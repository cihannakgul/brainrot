//
//  PurchasesDelegateHandler.swift
//  brainrot
//
//  Created by Cihan Akgül on 16.05.2025.
//

import Foundation
import RevenueCat

class PurchasesDelegateHandler: NSObject, ObservableObject {

    static let shared = PurchasesDelegateHandler()

}

extension PurchasesDelegateHandler: PurchasesDelegate {
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {

        UserViewModel.shared.customerInfo = customerInfo
    }
    
    func purchases(_ purchases: Purchases,
        readyForPromotedProduct product: StoreProduct,
        purchase startPurchase: @escaping StartPurchaseBlock) {
        startPurchase { (transaction, info, error, cancelled) in
            if let info = info, error == nil, !cancelled {
                UserViewModel.shared.customerInfo = info
            }
        }
    }
}
