//
//  ReadServer.swift
//  openrack
//
//  Created by Ayman Ali on 21/04/2023.
//

import Foundation

class ReadServer : ObservableObject {
    
    func getPaymentMethodDetails(payment_method: String, completion: @escaping ([String?]) -> Void) {
        let url = URL(string: "https://foul-checkered-lettuce.glitch.me/get-payment-method-details")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = try? JSONEncoder().encode(["payment_method_id": payment_method])
        
//        Listing(image: "tshirt.fill", title: "Off-White Tee", quantity: "2", price: "450", type: "Buy Now")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion([])
                return
            }
            let paymentMethodResponse = try? JSONDecoder().decode(PaymentMethodResponse.self, from: data)
            completion([paymentMethodResponse?.cardBrand, paymentMethodResponse?.lastFour]) 
        }.resume()
    }

    
}
