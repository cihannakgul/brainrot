//
//  brainrotApp.swift
//  brainrot
//
//  Created by Cihan Akgül on 7.05.2025.
//

import SwiftUI
import RevenueCat
import GoogleMobileAds

@main
struct brainrotApp: App {
    @StateObject private var audioManager = AudioManager.shared
    @StateObject private var appState = AppState()
    @State private var showPaywall = true
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
 

        DispatchQueue.global(qos: .background).async {
            GADMobileAds.sharedInstance().start(completionHandler: nil)
        }
        if UserDefaults.standard.object(forKey: "isOnboarding") == nil {
                   UserDefaults.standard.set(true, forKey: "isOnboarding")
                   UserDefaults.standard.set(false, forKey: "checkPaywall")
         }
         Purchases.logLevel = .debug
        
         let configuration = Configuration.Builder(withAPIKey: Constants.apiKey)
            .with(usesStoreKit2IfAvailable: true)
             .build()
        
        Purchases.configure(with: configuration)
        
         Purchases.shared.delegate = PurchasesDelegateHandler.shared
    }
    
    var body: some Scene {
        
        
        
        
        
        
        
        WindowGroup {
 
                 if appState.isOnboarding && !UserViewModel.shared.subscriptionActive {                OnBoardingView()
                        .environmentObject(UserViewModel.shared)
                        .environmentObject(appState)
                }
                else {
                    ContentView()
                        .environmentObject(audioManager)
                        .environmentObject(UserViewModel.shared)
                        .environmentObject(appState)
                        .navigationViewStyle(StackNavigationViewStyle())
                                       .fullScreenCover(isPresented: .init(
                                        get: { showPaywall && !appState.hasSeenPaywallThisSession && !UserViewModel.shared.subscriptionActive },
                                           set: { showPaywall = $0 }
                                       )) {
                                           PaywallView(isPresented: $showPaywall)
                                               .environmentObject(UserViewModel.shared)
                                               .environmentObject(appState)
                                       }
                               }
      
            
            
        }
    }
}

import Foundation
import AVFoundation



class AppState: ObservableObject {
    @Published var isOnboarding: Bool {
        didSet {
            UserDefaults.standard.set(isOnboarding, forKey: "isOnboarding")
        }
    }
    @Published var hasSeenPaywallThisSession: Bool = false

    
    init() {
        self.isOnboarding = UserDefaults.standard.bool(forKey: "isOnboarding")
    }
    
    func completeOnboarding() {
        isOnboarding = false
        hasSeenPaywallThisSession = true
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
 
        Task {
            do {
                UserViewModel.shared.offerings = try await Purchases.shared.offerings()
            } catch {
                print("Error fetching offerings: \(error)")
            }
        }
 
 
        
         return true
    }
}
