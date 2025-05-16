//
//  RatingManager.swift
//  brainrot
//
//  Created by Cihan Akgül on 17.05.2025.
//

import SwiftUI
import StoreKit

// Değerlendirme mantığını içeren sınıf
class RatingManager: ObservableObject {
    @Published var showingAlert = false
    
    static let shared = RatingManager() // Singleton instance
    
    private init() {}
    
    // Kullanıcının değerlendirme yapabilecek durumda olup olmadığını kontrol et
    func checkIfUserCanReview() -> Bool {
        // UserDefaults'dan son değerlendirme tarihini al
        let lastReviewRequestDate = UserDefaults.standard.object(forKey: "lastReviewRequestDate") as? Date
        
        let threeMonthsInSeconds: TimeInterval = 2221111 // 90 gün
        let minimumLaunchCount = 2
        let currentLaunchCount = UserDefaults.standard.integer(forKey: "appLaunchCount")
        
        // Uygulama açılış sayısını artır
        UserDefaults.standard.set(currentLaunchCount + 1, forKey: "appLaunchCount")
        
        // Değerlendirme gösterilmesi için koşulları kontrol et
        if currentLaunchCount >= minimumLaunchCount {
            if lastReviewRequestDate == nil || Date().timeIntervalSince(lastReviewRequestDate!) >= threeMonthsInSeconds {
                return true
            }
        }
        
        return false
    }
    
    // Değerlendirme zamanını güncelle
    func updateReviewTime() {
        UserDefaults.standard.set(Date(), forKey: "lastReviewRequestDate")
    }
    
    // Değerlendirme göster
    func requestReview() {
        if let windowScene = UIApplication.shared.windows.first?.windowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
        updateReviewTime()
    }
}

// Değerlendirme sorusunu gösteren view modifier
struct RatingAlertModifier: ViewModifier {
    @ObservedObject private var ratingManager = RatingManager.shared
    @Binding var showAlert: Bool
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Do you like our app?"),
                    primaryButton: .default(Text("Yes")) {
                        // "Yes" seçildiğinde App Store değerlendirme sayfasını göster
                        ratingManager.requestReview()
                    },
                    secondaryButton: .cancel(Text("No")) {
                        // "No" seçildiğinde alert'i kapat
                        ratingManager.updateReviewTime()
                    }
                )
            }
    }
}

// View extension ile kolay kullanım
extension View {
    func ratingAlert(isPresented: Binding<Bool>) -> some View {
        self.modifier(RatingAlertModifier(showAlert: isPresented))
    }
}
