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

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool = false
    
    private init() {
        setupAudio()
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
    }
    
    func setupAudio() {
        guard let path = Bundle.main.path(forResource: "background", ofType: "mp3") else {
            print("Background music file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = -1 // Sonsuz döngü
            audioPlayer?.volume = 1.0 // Ses seviyesini maksimuma çıkardım
            audioPlayer?.prepareToPlay() // Sesi önceden hazırla
        } catch {
            print("Error initializing audio player: \(error.localizedDescription)")
        }
    }
    
    func togglePlayback() {
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isPlaying.toggle()
    }
    
    func startPlayback() {
        audioPlayer?.play()
        isPlaying = true
    }
}
