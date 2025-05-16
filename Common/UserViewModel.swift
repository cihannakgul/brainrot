//
//  UserViewModel.swift
//  brainrot
//
//  Created by Cihan Akgül on 16.05.2025.
//



import Foundation
import RevenueCat
import SwiftUI

class UserViewModel: ObservableObject {
    static let shared = UserViewModel()
    
    
    @Published var customerInfo: CustomerInfo? {
        didSet {
            subscriptionActive = customerInfo?.entitlements[Constants.entitlementID]?.isActive == true
             // TO DO
        }
    }
    
    @Published var offerings: Offerings? = nil
    @Published var subscriptionActive: Bool = false // TO DO
    @Published var hasRatedApp = false
    
    
    #warning("Public-facing usernames aren't optimal for user ID's - you should use something non-guessable, like a non-public database ID. For more information, visit https://docs.revenuecat.com/docs/user-ids.")
    func login(userId: String) async {
        _ = try? await Purchases.shared.logIn(userId)
    }
    
    func logout() async {
        _ = try? await Purchases.shared.logOut()
    }
}
