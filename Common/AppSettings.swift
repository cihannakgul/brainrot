//
//  AppSettings.swift
//  brainrot
//
//  Created by Cihan Akgül on 16.05.2025.
//



import Foundation
import Combine

class AppSettings: ObservableObject {
    static let shared = AppSettings()

    @Published var maxMessageCount: Int = 3 // TO DO BEFORE PUBLISH
    @Published var messageCount: Int = 0
    @Published var userModel = UserViewModel.shared

    private var cancellables = Set<AnyCancellable>()
    private let resetKey = "lastResetDate"

    private init() {
        loadCounts()
        setupSubscriptions()
        resetCountsIfNeeded()
        
    }

    private func loadCounts() {
        let userDefaults = UserDefaults.standard
        if let maxMessageCount = userDefaults.object(forKey: "maxMessageCount") as? Int {
            self.maxMessageCount = maxMessageCount
        }

        if let messageCount = userDefaults.object(forKey: "messageCount") as? Int {
            self.messageCount = messageCount
        }
    }

    private func saveCounts() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(maxMessageCount, forKey: "maxMessageCount")
        userDefaults.set(messageCount, forKey: "messageCount")
        userDefaults.set(Date(), forKey: resetKey)
    }

    private func setupSubscriptions() {
        userModel.$subscriptionActive
            .sink { [weak self] subscriptionActive in
                self?.updateMaxMessageCount(subscriptionActive: subscriptionActive)
            }
            .store(in: &cancellables)
    }

    private func updateMaxMessageCount(subscriptionActive: Bool) {
        if subscriptionActive {
            maxMessageCount = Int.max
        } else {
            maxMessageCount = 5 // TO DO BEFORE PUBLISH
        }
    }

    func increaseMessageCount() {
        messageCount += 1
        saveCounts()
    }

    func resetMessageCount() {
        messageCount = 0
        saveCounts()
    }

    private func resetCountsIfNeeded() {
        let userDefaults = UserDefaults.standard
        let lastResetDate = userDefaults.object(forKey: resetKey) as? Date ?? Date.distantPast

        let calendar = Calendar.current
        if !calendar.isDateInToday(lastResetDate) {
            resetMessageCount()
        }
    }
}
