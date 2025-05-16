//
//  Onboarding.swift
//  brainrot
//
//  Created by Cihan Akgül on 16.05.2025.
//


import Foundation
import SwiftUI
 

let AIModelData: [AIModel] = [
    AIModel(
        title: NSLocalizedString("intro1", comment: "Kullanıcıyı karşılama metni"),
        headline: NSLocalizedString("descp1", comment: "Kullanıcıyı karşılama metni"),
        image: "logo",
        gradientColors: [ Color(hex: "1a1a2e"), Color(hex: "16213e").opacity(0.8)]
    ),
    AIModel(
        title: NSLocalizedString("intro2", comment: "Kullanıcıyı karşılama metni"),
        headline: NSLocalizedString("descp2", comment: "Kullanıcıyı karşılama metni"),
        image: "onboard1",
        gradientColors: [ Color(hex: "1a1a2e"), Color(hex: "16213e").opacity(0.8)]
    ),
    AIModel(
        title: NSLocalizedString("intro3", comment: "Kullanıcıyı karşılama metni"),
        headline: NSLocalizedString("descp3", comment: "Kullanıcıyı karşılama metni"),
        image: "onboard2",
        gradientColors: [ Color(hex: "1a1a2e"), Color(hex: "16213e").opacity(0.8)]
    )
]

struct OnBoardingView: View {
    var fruits: [AIModel] = AIModelData
    @State private var currentPage = 0
    @State private var navigateToNextPage = false // State to control navigation

    var body: some View {
        ZStack {
            
 
            
            LinearGradient(
                colors: [
                    Color.white,
                    Color.orange
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0...2, id: \.self) { index in
                        AIModelCardView(fruit: fruits[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .padding(.vertical, 20)
                
                // Next Button
                Button(action: {
                    if currentPage == 2 {
                   
                        navigateToNextPage = true
                    } else {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                }) {
                    HStack {
                        Text(NSLocalizedString("next", comment: ""))
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 2)
                            .padding(.horizontal)
                    }
                  
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .fullScreenCover(isPresented: $navigateToNextPage, content: { // ilk gösterimden sonra nereye gidecek?
            PaywallView(isPresented: $navigateToNextPage)
            
        })
    }
}
 

 
struct AIModel: Identifiable {
  var id = UUID()
  var title: String
  var headline: String
  var image: String?
  var gradientColors: [Color]
  var systemImage: String?

}
 

import SwiftUI
struct AIModelCardView: View {
 
    var fruit: AIModel

    @State private var isAnimating: Bool = false

 
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // FRUIT: IMAGE
                if let image = fruit.image {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .frame(width: 360, height: 360) // İsteğe bağlı: Resmin boyutunu belirleyebilirsiniz.
    //                    .shadow(color: Color(hex: "1a1a2e").opacity(0.7), radius: 8, x: 6, y: 8)
                          .scaleEffect(isAnimating ? 1.0 : 0.6)
                }
                else if let systemImage = fruit.systemImage{
                    Image(systemName: systemImage)
                        .resizable()
                        .foregroundColor(Color.white)

                        .aspectRatio(contentMode: .fit)
                        .frame(width: 320, height: 320) // İsteğe bağlı: Resmin boyutunu belirleyebilirsiniz.
     //                    .shadow(color: Color(hex: "1a1a2e").opacity(0.7), radius: 8, x: 6, y: 8)
                          .scaleEffect(isAnimating ? 1.0 : 0.6)
                }
            
 
                // FRUIT: TITLE
                Text(fruit.title)
                    .foregroundColor(Color.black)
                    .font(.system(size: 19))
                    .bold()
                    
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                    .padding()
                     
                
                
                // FRUIT: HEADLINE
                Text(fruit.headline)
                    .foregroundColor(Color.black)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 480)
                
             
                // BUTTON: START
            } //: VSTACK
        } //: ZSTACK
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
 
            .cornerRadius(20)
            .padding(.horizontal, 20)
        
        
     }
}

