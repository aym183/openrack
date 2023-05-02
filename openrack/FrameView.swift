//
//  FrameView.swift
//  liveview
//
//  Created by Ayman Ali on 12/04/2023.
//
import SwiftUI

struct FrameView: View {
    var image: CGImage?
    private let label = Text("frame")
    var body: some View {
        if let image = image {
            Image(image, scale: 1.0, orientation: .up, label:label)
        } else {
            Color.black
        }
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}
