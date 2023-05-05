//
//  ReadServer.swift
//  openrack
//
//  Created by Ayman Ali on 21/04/2023.
//
import Foundation
import SwiftUI
import FirebaseFunctions
import Firebase

class ReadServer : ObservableObject {
    lazy var functions = Functions.functions(app: FirebaseApp.app()!)
    
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
    
    func startCheckout(completion: @escaping ([String?]) -> Void) {
        @AppStorage("email") var userEmail: String = ""
        @AppStorage("full_name") var fullName: String = ""
        @AppStorage("stripe_customer_id") var stripeCustomerID: String = ""
        let url = URL(string: "https://foul-checkered-lettuce.glitch.me/create-payment-intent")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = try? JSONEncoder().encode(["customer_id": stripeCustomerID, "name": fullName, "email": userEmail, "price": "5"])
        
//        Listing(image: "tshirt.fill", title: "Off-White Tee", quantity: "2", price: "450", type: "Buy Now")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion([])
                return
            }
            let checkoutIntentResponse = try? JSONDecoder().decode(CheckoutIntentResponse.self, from: data)
            
            if stripeCustomerID == "" {
                UpdateDB().updateStripeCustomerID(customerID: checkoutIntentResponse!.customerID)
            }
            completion([checkoutIntentResponse?.clientSecret, checkoutIntentResponse?.paymentIntentID])
            
        }.resume()
    }

    func getPaymentMethod(payment_intent: String, completion: @escaping (String?) -> Void) {
        @AppStorage("stripe_customer_id") var stripeCustomerID: String = ""
        
        let url = URL(string: "https://foul-checkered-lettuce.glitch.me/get-payment-method")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = try? JSONEncoder().encode(["payment_intent_id": payment_intent, "customer_id": stripeCustomerID])
        
//        Listing(image: "tshirt.fill", title: "Off-White Tee", quantity: "2", price: "450", type: "Buy Now")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(nil)
                return
            }
            let paymentIntentResponse = try? JSONDecoder().decode(PaymentIntentResponse.self, from: data)
            completion(paymentIntentResponse?.paymentMethodID)
            
        }.resume()
    }
    
    func executeOrderTransaction(order_amount: String, completion: @escaping (String?) -> Void) {
        @AppStorage("stripe_customer_id") var stripeCustomerID: String = ""
        @AppStorage("stripe_payment_method") var stripePaymentMethod: String = ""
        
        if Int(order_amount) == nil {
            print("Item not available for buying")
        } else {
            let url = URL(string: "https://foul-checkered-lettuce.glitch.me/execute-transaction")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            request.httpBody = try? JSONEncoder().encode(["customer_id": stripeCustomerID, "amount": order_amount, "payment_method": stripePaymentMethod])
            
    //        Listing(image: "tshirt.fill", title: "Off-White Tee", quantity: "2", price: "450", type: "Buy Now")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil,
                      (response as? HTTPURLResponse)?.statusCode == 200
                else {
                    completion(nil)
                    return
                }
                let orderTransactionResponse = try? JSONDecoder().decode(OrderTransactionResponse.self, from: data)
                completion(orderTransactionResponse?.message)
                
            }.resume()
        }
    }
    
}
