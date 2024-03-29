//
//  FrameHandler.swift
//  openrack
//
//  Created by Ayman Ali on 12/04/2023.
//
import SwiftUI
import AVFoundation
import CoreImage
import HaishinKit

class FrameHandler: NSObject, ObservableObject {
    @AppStorage("stream_key") var streamKey: String = ""
    @Published var frame: CGImage?
    private var permissionGranted = false
    private let captureSession = AVCaptureSession()
    private let context = CIContext()
    private let rtmpConnection = RTMPConnection()
    private var rtmpStream: RTMPStream?
    
    override init() {
        super.init()
        checkPermission()
        self.setupCaptureSession()
    }

    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                permissionGranted = true
            case .notDetermined:
                requestPermission()
        default:
            permissionGranted = false
        }
    }

    func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [unowned self] granted in
            self.permissionGranted = granted
        }
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = .hd1920x1080
        guard permissionGranted else { return }
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
        guard captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)

        guard let audioDevice = AVCaptureDevice.default(for: .audio) else { return }
        guard let audioDeviceInput = try? AVCaptureDeviceInput(device: audioDevice) else { return }
        guard captureSession.canAddInput(audioDeviceInput) else { return }
        captureSession.addInput(audioDeviceInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
        captureSession.addOutput(videoOutput)
        videoOutput.connection(with: .video)?.videoOrientation = .portrait
        
        // Add audio input and output
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleAudioQueue"))
        captureSession.addOutput(audioOutput)
        let connection = rtmpConnection
        connection.connect("rtmp://global-live.mux.com:5222/app")
        let stream = RTMPStream(connection: connection)
        stream.attachAudio(audioDevice)
        rtmpStream = stream
        captureSession.startRunning()
    }
    
    func publishStream() {
        rtmpStream!.publish("\(streamKey)")
    }
    
    func closeStream() {
        print("Stream Closed")
        rtmpStream!.close()
    }
}

extension FrameHandler: AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let rtmpStream = rtmpStream else { return }
        if connection.videoOrientation != nil {
                    guard let cgImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
                    DispatchQueue.main.async { [unowned self] in
                        self.frame = cgImage
                        rtmpStream.appendSampleBuffer(sampleBuffer, withType: .video)
                    }
        } else if connection.audioChannels != nil {
                    DispatchQueue.main.async {
                        rtmpStream.appendSampleBuffer(sampleBuffer, withType: .audio)
                    }
                }
    }

    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return cgImage
    }
}
