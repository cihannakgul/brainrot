//
//  brainrotApp.swift
//  brainrot
//
//  Created by Cihan Akgül on 7.05.2025.
//

import SwiftUI

@main
struct brainrotApp: App {
    @StateObject private var audioManager = AudioManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}

import Foundation
import AVFoundation



