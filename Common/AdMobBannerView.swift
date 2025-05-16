//
//  AdMobBannerView.swift
//  brainrot
//
//  Created by Cihan Akgül on 16.05.2025.
//


import Foundation
import SwiftUI
import GoogleMobileAds

struct AdMobBannerView: UIViewRepresentable {

    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeLargeBanner)
        banner.adUnitID = "ca-app-pub-6303466444103792/3709351115" //TODO: Change it
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {}
}
