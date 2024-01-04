//
//  Application.swift
//  openrack
//
//  Created by Ayman Ali on 28/03/2023.
//

import SwiftUI

extension AuthViewModel {
    func getRootViewController() -> UIViewController {
            guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return .init()
            }
            guard let root = screen.windows.first?.rootViewController else {
                return .init()
            }
            return root
        }
}
