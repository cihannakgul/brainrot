//
//  ContentView.swift
//  brainrot
//
//  Created by Cihan Akgül on 7.05.2025.
//

import SwiftUI
import AVFoundation

// Quiz için gerekli model yapısı
struct BrainrotItem: Identifiable {
    let id: Int
    let name: String
    let imageName: String
    let soundName: String
}

// Shared data for all quiz views
let allBrainrots: [BrainrotItem] = [
    BrainrotItem(id: 1, name: "Tung Tung Tung Sahur", imageName: "1", soundName: "1m"),
    BrainrotItem(id: 2, name: "Bombardiro Crocodilo", imageName: "2", soundName: "2m"),
    BrainrotItem(id: 3, name: "Tralalero Tralala", imageName: "3", soundName: "3m"),
    BrainrotItem(id: 4, name: "Ballerina Cappucina", imageName: "4", soundName: "4m"),
    BrainrotItem(id: 5, name: "Bobombini Goosini", imageName: "5", soundName: "5m"),
    BrainrotItem(id: 6, name: "Capuccino Assasino", imageName: "6", soundName: "6m"),
    BrainrotItem(id: 7, name: "Lirilì Larilà", imageName: "7", soundName: "7m"),
    BrainrotItem(id: 8, name: "Bobrito Bandito", imageName: "8", soundName: "8m"),
    BrainrotItem(id: 9, name: "Trippi Troppi", imageName: "9", soundName: "9m"),
    BrainrotItem(id: 10, name: "Trulimero Trulicina", imageName: "10", soundName: "10m"),
    BrainrotItem(id: 11, name: "Bobrini Cocococini", imageName: "11", soundName: "11m"),
    BrainrotItem(id: 12, name: "U Din Din Din Din", imageName: "12", soundName: "12m"),
    BrainrotItem(id: 13, name: "Burbaloni Lulilolli", imageName: "13", soundName: "13m"),
    BrainrotItem(id: 14, name: "Brr Brr Patapim", imageName: "14", soundName: "14m"),
    BrainrotItem(id: 15, name: "Chimpanzini Bananini", imageName: "15", soundName: "15m"),
    BrainrotItem(id: 16, name: "Frigo Camelo", imageName: "16", soundName: "16m"),
    BrainrotItem(id: 17, name: "La Vaca Saturno Saturnita", imageName: "17", soundName: "17m"),
    BrainrotItem(id: 18, name: "Giraffe Celeste", imageName: "18", soundName: "18m"),
    BrainrotItem(id: 19, name: "Frulli Frulia", imageName: "19", soundName: "19m"),
    BrainrotItem(id: 20, name: "Bicus Dicus Bombicus", imageName: "20", soundName: "20m"),
    BrainrotItem(id: 21, name: "Tric Trac Baraboom", imageName: "21", soundName: "21m"),
    BrainrotItem(id: 22, name: "Cocofanto Elefanto", imageName: "22", soundName: "22m"),
    BrainrotItem(id: 23, name: "Burbaloni Luliloli", imageName: "23", soundName: "23m"),
    BrainrotItem(id: 24, name: "Orangutini Ananasini", imageName: "24", soundName: "24m"),
    BrainrotItem(id: 25, name: "Garamaraman dan Madudungdung", imageName: "25", soundName: "25m"),
    BrainrotItem(id: 26, name: "Il Cacto Hipopotamo", imageName: "26", soundName: "26m"),
    BrainrotItem(id: 27, name: "Blueberrinni Octopussini", imageName: "27", soundName: "27m"),
    BrainrotItem(id: 28, name: "Glorbo Fruttodrillo", imageName: "28", soundName: "28m"),
    BrainrotItem(id: 29, name: "Rhino Toasterino", imageName: "29", soundName: "29m"),
    BrainrotItem(id: 30, name: "Zibra Zubra Zibralini", imageName: "30", soundName: "30m"),
    BrainrotItem(id: 31, name: "Graipussi Medussi", imageName: "31", soundName: "31m"),
    BrainrotItem(id: 32, name: "Tigrrullini Watermellini", imageName: "32", soundName: "32m"),
    BrainrotItem(id: 33, name: "Tracotucotulu Delapeladustuz", imageName: "33", soundName: "33m"),
    BrainrotItem(id: 34, name: "Chimpanzini Capuchini", imageName: "34", soundName: "34m"),
    BrainrotItem(id: 35, name: "Gorillo Watermellondrillo", imageName: "35", soundName: "35m"),
    BrainrotItem(id: 36, name: "Bananita Dolfinita", imageName: "36", soundName: "36m"),
    BrainrotItem(id: 37, name: "Pot Hotspoot", imageName: "37", soundName: "37m"),
    BrainrotItem(id: 38, name: "Svinino Bombondino", imageName: "38", soundName: "38m"),
    BrainrotItem(id: 39, name: "Bulbito Bandito Traktorito", imageName: "39", soundName: "39m"),
    BrainrotItem(id: 40, name: "Raccooni Watermelunni", imageName: "40", soundName: "40m"),
    BrainrotItem(id: 41, name: "Pippi Poppa Pippo Peppe", imageName: "41", soundName: "41m")
]

// Quiz için View
struct StartQuizView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var audioManager = AudioManager.shared
    @State private var questions: [BrainrotItem] = []
    @State private var currentQuestionIndex = 0
    @State private var options: [(item: BrainrotItem, isCorrect: Bool)] = []
    @State private var questionAudio: AVAudioPlayer?
    @State private var showCorrectAnswer = false
    @State private var isQuizReady = false
    @State private var selectedAnswerID: Int? = nil
    @State private var showStartAgain = false
    @State private var currentPoints = 0
    @State private var isHintUsed = false
    @AppStorage("maxPoints") private var maxPoints = 0
    
    // Shiny effect for No Ads button
    @State private var shineOffset: CGFloat = -100
    
    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(gradient: Gradient(colors: [.purple, .pink.opacity(0.3)]),
                         startPoint: .topLeading,
                         endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            if isQuizReady && !questions.isEmpty {
                VStack(spacing: 0) {
                    // Üst bar
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        // Points
                        HStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(currentPoints)")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(20)
                        
                        // No Ads Button
                        Button(action: {
                            // No Ads action
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: "crown.fill")
                                    .foregroundColor(.yellow)
                                Text("No Ads")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                ZStack {
                                    Color.purple.opacity(0.3)
                                    // Shiny effect
                                    Rectangle()
                                        .fill(Color.white.opacity(0.3))
                                        .rotationEffect(.degrees(45))
                                        .frame(width: 30)
                                        .offset(x: shineOffset)
                                }
                            )
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.white.opacity(0.5), lineWidth: 1))
                        }
                        .onAppear {
                            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                                shineOffset = 100
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Question Name and Sound Button
                    VStack(spacing: 16) {
                        HStack {
                            Text("Brainrot:")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text(questions[currentQuestionIndex].name)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(20)
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                playQuestionSound()
                            }) {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70)
                                    .background(Circle().fill(Color.white.opacity(0.2)))
                            }
                            
                            Button(action: {
                                isHintUsed.toggle()
                            }) {
                                Image(systemName: "lightbulb.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(isHintUsed ? .yellow : .white)
                                    .frame(width: 70, height: 70)
                                    .background(Circle().fill(Color.white.opacity(0.2)))
                            }
                        }
                    }
                    .padding(.bottom, 8)
                    
                 
                    
                    // Seçenekler
                    HStack(spacing: 12) {
                        ForEach(options, id: \.item.id) { option in
                            Button(action: {
                                checkAnswer(option.isCorrect, optionId: option.item.id)
                            }) {
                                ZStack {
                                    Image(option.item.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                        .frame(height: 360)
                                        .opacity(isHintUsed && !option.isCorrect ? 0.3 : 1.0)
                                      
                                    
                                    // Doğru/Yanlış İkonları
                                    if showCorrectAnswer {
                                        if option.isCorrect {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.system(size: 90))
                                                .foregroundColor(.green)
                                                .background(Circle().fill(Color.white))
                                        } else if selectedAnswerID == option.item.id {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.system(size: 90))
                                                .foregroundColor(.red)
                                                .background(Circle().fill(Color.white))
                                        }
                                    }
                                }
                            }
                            .disabled(showCorrectAnswer)
                        }
                    }
                    .padding(.horizontal)
                 Spacer()
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
            
            // Start Again overlay
            if showStartAgain {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    VStack(spacing: 30) {
                        Text("Game Over!")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.purple)
                        
                        VStack(spacing: 16) {
                            PointRow(title: "Your Points:", points: currentPoints)
                            PointRow(title: "Max Points:", points: maxPoints)
                        }
                        .padding(.vertical)
                    }
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 15)
                    
                    Button(action: {
                        showStartAgain = false
                        currentPoints = 0
                        setupQuiz()
                    }) {
                        Text("Start Again")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.purple)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            setupQuiz()
        }
    }
    
    private func setupQuiz() {
        questions = allBrainrots.shuffled()
        currentQuestionIndex = 0
        setupQuestion()
        isQuizReady = true
        playQuestionSound()
    }
    
    private func setupQuestion() {
        guard !questions.isEmpty && currentQuestionIndex < questions.count else { return }
        
        selectedAnswerID = nil
        showCorrectAnswer = false
        isHintUsed = false
        
        let currentQuestion = questions[currentQuestionIndex]
        var wrongAnswers = questions.filter { $0.id != currentQuestion.id }.shuffled()
        wrongAnswers = Array(wrongAnswers.prefix(1))
        
        options = wrongAnswers.map { ($0, false) }
        options.append((currentQuestion, true))
        options.shuffle()
    }
    
    private func playQuestionSound() {
        guard !questions.isEmpty && currentQuestionIndex < questions.count else { return }
        
        // Eğer ses çalıyorsa, durdurup baştan başlat
        questionAudio?.stop()
        questionAudio?.currentTime = 0
        
        guard let path = Bundle.main.path(forResource: questions[currentQuestionIndex].soundName, ofType: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            questionAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            questionAudio?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    private func checkAnswer(_ isCorrect: Bool, optionId: Int) {
        selectedAnswerID = optionId
        showCorrectAnswer = true
        
        if isCorrect {
            currentPoints += 10 // 10 puan artış
            maxPoints = max(currentPoints, maxPoints)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if currentQuestionIndex < questions.count - 1 {
                    currentQuestionIndex += 1
                    showCorrectAnswer = false
                    setupQuestion()
                    playQuestionSound()
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showStartAgain = true
            }
        }
    }
}

struct PointRow: View {
    let title: String
    let points: Int
    
    var body: some View {
        HStack(spacing: 12) {
            Text(title)
                .font(.title3)
                .foregroundColor(.gray)
            
            Text("\(points)")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.purple)
        }
    }
}

struct QuizProView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var audioManager = AudioManager.shared
    @State private var questions: [BrainrotItem] = []
    @State private var currentQuestionIndex = 0
    @State private var options: [(item: BrainrotItem, isCorrect: Bool)] = []
    @State private var questionAudio: AVAudioPlayer?
    @State private var showCorrectAnswer = false
    @State private var isQuizReady = false
    @State private var selectedAnswerID: Int? = nil
    @State private var showStartAgain = false
    @State private var currentPoints = 0
    @State private var isHintUsed = false
    @AppStorage("maxPoints") private var maxPoints = 0
    @State private var shineOffset: CGFloat = -100
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .pink.opacity(0.4)]),
                         startPoint: .topLeading,
                         endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            if isQuizReady && !questions.isEmpty {
                VStack(spacing: 0) {
                    // Üst bar
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(currentPoints)")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(20)
                        
                        Button(action: {}) {
                            HStack(spacing: 6) {
                                Image(systemName: "crown.fill")
                                    .foregroundColor(.yellow)
                                Text("No Ads")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                ZStack {
                                    Color.purple.opacity(0.3)
                                    Rectangle()
                                        .fill(Color.white.opacity(0.3))
                                        .rotationEffect(.degrees(45))
                                        .frame(width: 30)
                                        .offset(x: shineOffset)
                                }
                            )
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.white.opacity(0.5), lineWidth: 1))
                        }
                        .onAppear {
                            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                                shineOffset = 100
                            }
                        }
                    }
                    .padding()
                    
                    VStack(spacing: 16) {
                        Image(questions[currentQuestionIndex].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 360)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                playQuestionSound()
                            }) {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70)
                                    .background(Circle().fill(Color.white.opacity(0.2)))
                            }
                            
                            Button(action: {
                                isHintUsed.toggle()
                            }) {
                                Image(systemName: "lightbulb.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(isHintUsed ? .yellow : .white)
                                    .frame(width: 70, height: 70)
                                    .background(Circle().fill(Color.white.opacity(0.2)))
                            }
                        }
                    }
                    .padding(.bottom, 8)
                    
                    // Seçenekler - Text olarak
                    VStack(spacing: 16) {
                        ForEach(options, id: \.item.id) { option in
                            Button(action: {
                                checkAnswer(option.isCorrect, optionId: option.item.id)
                            }) {
                                Text(option.item.name)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(getTextColor(for: option))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 60)
                                    .background(Color.white.opacity(isHintUsed && !option.isCorrect ? 0.3 : 1))
                                    .cornerRadius(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(getBorderColor(for: option), lineWidth: showCorrectAnswer ? 3 : 0)
                                    )
                            }
                            .disabled(showCorrectAnswer)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
            
            if showStartAgain {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    VStack(spacing: 30) {
                        Text("Game Over!")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.purple)
                        
                        VStack(spacing: 16) {
                            PointRow(title: "Your Points:", points: currentPoints)
                            PointRow(title: "Max Points:", points: maxPoints)
                        }
                        .padding(.vertical)
                    }
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 15)
                    
                    Button(action: {
                        showStartAgain = false
                        currentPoints = 0
                        setupQuiz()
                    }) {
                        Text("Start Again")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.purple)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            setupQuiz()
        }
    }
    
    private func getTextColor(for option: (item: BrainrotItem, isCorrect: Bool)) -> Color {
        if showCorrectAnswer {
            if option.isCorrect {
                return .green
            } else if selectedAnswerID == option.item.id {
                return .red
            }
        }
        return .purple
    }
    
    private func getBorderColor(for option: (item: BrainrotItem, isCorrect: Bool)) -> Color {
        if showCorrectAnswer && (option.isCorrect || selectedAnswerID == option.item.id) {
            return option.isCorrect ? .green : .red
        }
        return .clear
    }
    
    private func setupQuiz() {
        questions = allBrainrots.shuffled()
        currentQuestionIndex = 0
        setupQuestion()
        isQuizReady = true
        playQuestionSound()
    }
    
    private func setupQuestion() {
        guard !questions.isEmpty && currentQuestionIndex < questions.count else { return }
        
        selectedAnswerID = nil
        showCorrectAnswer = false
        isHintUsed = false
        
        let currentQuestion = questions[currentQuestionIndex]
        var wrongAnswers = questions.filter { $0.id != currentQuestion.id }.shuffled()
        wrongAnswers = Array(wrongAnswers.prefix(1))
        
        options = wrongAnswers.map { ($0, false) }
        options.append((currentQuestion, true))
        options.shuffle()
    }
    
    private func playQuestionSound() {
        guard !questions.isEmpty && currentQuestionIndex < questions.count else { return }
        
        // Eğer ses çalıyorsa, durdurup baştan başlat
        questionAudio?.stop()
        questionAudio?.currentTime = 0
        
        guard let path = Bundle.main.path(forResource: questions[currentQuestionIndex].soundName, ofType: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            questionAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            questionAudio?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    private func checkAnswer(_ isCorrect: Bool, optionId: Int) {
        selectedAnswerID = optionId
        showCorrectAnswer = true
        
        if isCorrect {
            currentPoints += 10 // 10 puan artış
            maxPoints = max(currentPoints, maxPoints)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if currentQuestionIndex < questions.count - 1 {
                    currentQuestionIndex += 1
                    showCorrectAnswer = false
                    setupQuestion()
                    playQuestionSound()
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showStartAgain = true
            }
        }
    }
}

struct SpeedQuizTimerView: View {
    var onSelectTime: (Int) -> Void
    var onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
            
            VStack(spacing: 20) {
                Text("Select Time Limit")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                VStack(spacing: 15) {
                    ForEach([15, 30, 45, 60], id: \.self) { seconds in
                        Button(action: {
                            onSelectTime(seconds)
                        }) {
                            HStack {
                                Image(systemName: "timer")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                
                                Text("\(seconds) sec")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
            }
            .frame(width: 300)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.purple.opacity(0.95))
            )
            .shadow(radius: 20)
        }
    }
}

struct SpeedQuizView: View {
    let timeLimit: Int
    @Environment(\.dismiss) private var dismiss
    @StateObject private var audioManager = AudioManager.shared
    @State private var questions: [BrainrotItem] = []
    @State private var currentQuestionIndex = 0
    @State private var options: [(item: BrainrotItem, isCorrect: Bool)] = []
    @State private var questionAudio: AVAudioPlayer?
    @State private var showCorrectAnswer = false
    @State private var isQuizReady = false
    @State private var selectedAnswerID: Int? = nil
    @State private var showStartAgain = false
    @State private var currentPoints = 0
    @State private var isHintUsed = false
    @AppStorage("maxPoints") private var maxPoints = 0
    @State private var remainingTime: Int
    @State private var timer: Timer?
    
    init(timeLimit: Int) {
        self.timeLimit = timeLimit
        _remainingTime = State(initialValue: timeLimit)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .pink.opacity(0.4)]),
                         startPoint: .topLeading,
                         endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            if isQuizReady && !questions.isEmpty {
                VStack(spacing: 0) {
                    // Top bar
                    HStack {
                        Button(action: {
                            timer?.invalidate()
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        // Timer display
                        HStack(spacing: 8) {
                            Image(systemName: "timer")
                                .foregroundColor(.white)
                            Text("\(remainingTime)s")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 70)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(20)
                        
                        // Points display
                        HStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(currentPoints)")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(20)
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Question Name and Sound Button
                    VStack(spacing: 16) {
                        HStack {
                            Text("Brainrot:")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text(questions[currentQuestionIndex].name)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(20)
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                playQuestionSound()
                            }) {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70)
                                    .background(Circle().fill(Color.white.opacity(0.2)))
                            }
                            
                            Button(action: {
                                isHintUsed.toggle()
                            }) {
                                Image(systemName: "lightbulb.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(isHintUsed ? .yellow : .white)
                                    .frame(width: 70, height: 70)
                                    .background(Circle().fill(Color.white.opacity(0.2)))
                            }
                        }
                    }
                    .padding(.bottom, 8)
                    
                    // Options
                    HStack(spacing: 12) {
                        ForEach(options, id: \.item.id) { option in
                            Button(action: {
                                checkAnswer(option.isCorrect, optionId: option.item.id)
                            }) {
                                ZStack {
                                    Image(option.item.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                        .frame(height: 360)
                                        .opacity(isHintUsed && !option.isCorrect ? 0.3 : 1.0)
                                    
                                    if showCorrectAnswer {
                                        if option.isCorrect {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.system(size: 90))
                                                .foregroundColor(.green)
                                                .background(Circle().fill(Color.white))
                                        } else if selectedAnswerID == option.item.id {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.system(size: 90))
                                                .foregroundColor(.red)
                                                .background(Circle().fill(Color.white))
                                        }
                                    }
                                }
                            }
                            .disabled(showCorrectAnswer)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
            
            // Game Over overlay
            if showStartAgain {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    VStack(spacing: 30) {
                        Text("Game Over!")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.purple)
                        
                        VStack(spacing: 16) {
                            PointRow(title: "Your Points:", points: currentPoints)
                            PointRow(title: "Max Points:", points: maxPoints)
                            Text("Time's up!")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical)
                    }
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 15)
                    
                    Button(action: {
                        showStartAgain = false
                        currentPoints = 0
                        remainingTime = timeLimit
                        setupQuiz()
                        startTimer()
                    }) {
                        Text("Start Again")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.purple)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            setupQuiz()
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer?.invalidate()
                showStartAgain = true
            }
        }
    }
    
    private func setupQuiz() {
        questions = allBrainrots.shuffled()
        currentQuestionIndex = 0
        setupQuestion()
        isQuizReady = true
        playQuestionSound()
    }
    
    private func setupQuestion() {
        guard !questions.isEmpty && currentQuestionIndex < questions.count else { return }
        
        selectedAnswerID = nil
        showCorrectAnswer = false
        isHintUsed = false
        
        let currentQuestion = questions[currentQuestionIndex]
        var wrongAnswers = questions.filter { $0.id != currentQuestion.id }.shuffled()
        wrongAnswers = Array(wrongAnswers.prefix(1))
        
        options = wrongAnswers.map { ($0, false) }
        options.append((currentQuestion, true))
        options.shuffle()
    }
    
    private func playQuestionSound() {
        guard !questions.isEmpty && currentQuestionIndex < questions.count else { return }
        
        questionAudio?.stop()
        questionAudio?.currentTime = 0
        
        guard let path = Bundle.main.path(forResource: questions[currentQuestionIndex].soundName, ofType: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            questionAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            questionAudio?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    private func checkAnswer(_ isCorrect: Bool, optionId: Int) {
        selectedAnswerID = optionId
        showCorrectAnswer = true
        
        if isCorrect {
            currentPoints += 10
            maxPoints = max(currentPoints, maxPoints)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if currentQuestionIndex < questions.count - 1 {
                    currentQuestionIndex += 1
                    showCorrectAnswer = false
                    setupQuestion()
                    playQuestionSound()
                }
            }
        } else {
            timer?.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showStartAgain = true
            }
        }
    }
}

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    @Published var isPlaying = false
    @Published var player: AVAudioPlayer?
    
    func startPlayback() {
        guard let path = Bundle.main.path(forResource: "background", ofType: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player?.numberOfLoops = -1 // Sonsuz döngü
            player?.play()
            isPlaying = true
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func togglePlayback() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
    }
    
    func stopSound() {
        player?.stop()
        player = nil
        isPlaying = false
    }
    
    func playSound(fileName: String) {
        stopSound()
        guard let path = Bundle.main.path(forResource: fileName, ofType: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player?.play()
            isPlaying = true
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

struct SoundBarView: View {
    @StateObject private var audioManager = AudioManager.shared
    @State private var currentlyPlaying: Int?
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.orange, .white]),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 15) {
                        ForEach(allBrainrots) { item in
                            Button(action: {
                                playSound(for: item)
                            }) {
                                HStack(spacing: 15) {
                                    Image(item.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .shadow(radius: 5)
                                    
                                    Text(item.name)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.black.opacity(0.6))
                                    
                                    Spacer()
                                    
                                    Image(systemName: currentlyPlaying == item.id ? "pause.circle.fill" : "play.circle.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(currentlyPlaying == item.id ? Color.white : Color.clear, lineWidth: 2)
                                )
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Sound Bar")
            }
        }
    }
    
    private func playSound(for item: BrainrotItem) {
        if currentlyPlaying == item.id {
            audioManager.stopSound()
            currentlyPlaying = nil
        } else {
            audioManager.playSound(fileName: item.soundName)
            currentlyPlaying = item.id
        }
    }
}

struct QuizView: View {
    @StateObject private var audioManager = AudioManager.shared
    @State private var showSpeedQuizTimer = false
    @State private var showSpeedQuiz = false
    @State private var selectedTimeLimit: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.orange, .white]),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .shadow(radius: 20)
                        .frame(height: 300)
                        .padding(.vertical, 15)
                    
                    Spacer()
                    
                    // Quiz Buttons
                    Button(action: {
                        showSpeedQuizTimer = true
                    }) {
                        QuizButton(title: "QUIZ SPEED - SENSEI", color: .red)
                    }
                    .padding(.bottom, 5)
                    
                    NavigationLink(destination: StartQuizView()) {
                        QuizButton(title: "QUIZ MASTER (Guess with Name)", color: .orange)
                    }
                    .padding(.bottom, 5)
                    
                    NavigationLink(destination: QuizProView()) {
                        QuizButton(title: "QUIZ PRO (Guess with Image)", color: .purple)
                    }
                    
                    Spacer()
                }
                .padding()
                
                if showSpeedQuizTimer {
                    SpeedQuizTimerView(
                        onSelectTime: { seconds in
                            selectedTimeLimit = seconds
                            showSpeedQuizTimer = false
                            showSpeedQuiz = true
                        },
                        onDismiss: {
                            showSpeedQuizTimer = false
                        }
                    )
                }
            }
            .fullScreenCover(isPresented: $showSpeedQuiz) {
                SpeedQuizView(timeLimit: selectedTimeLimit)
            }
        }
    }
}

struct MainTabView: View {
    @StateObject private var audioManager = AudioManager.shared
    
    var body: some View {
        TabView {
            QuizView()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Quiz")
                }
            
            SoundBarView()
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Sound Bar")
                }
        }
        .tint(.purple)
        .onAppear {
            audioManager.startPlayback()
        }
    }
}

struct ContentView: View {
    var body: some View {
        MainTabView()
    }
}

struct QuizButton: View {
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 70)
            .background(color)
            .cornerRadius(15)
            .shadow(radius: 8)
    }
}

#Preview {
    ContentView()
}

