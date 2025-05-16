//
//  PaywallView.swift
//  brainrot
//
//  Created by Cihan Akgül on 16.05.2025.
//


import Foundation
import SwiftUI
import RevenueCat
//
//struct PaywallView: View {
//    @Binding var isPresented: Bool
//    @State private(set) var isPurchasing: Bool = false
//    @ObservedObject var userViewModel = UserViewModel.shared
//    @EnvironmentObject var appState: AppState // AppStorage yerine AppState eklendi
//
//    @State private var offering: Offering?
//    
//    @State private var error: NSError?
//    @State private var displayError: Bool = false
//    @State private var selectedPackage: Package?
//    @State private var leadingBarItemOpacity = 0.0
//    @State private var showAlert = false
//
//
//    var body: some View {
//        NavigationView {
//            if isPurchasing {
//                ProgressView()
//            }
//            ZStack {
//                ScrollView(showsIndicators: false) {
//                    VStack {
//                            Image("logo")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .mask(
//                                               LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray, Color.gray, Color.gray.opacity(0)]), startPoint: .top, endPoint: .bottom)
//                                           )
//                                .edgesIgnoringSafeArea(.all)
//                                .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? -200 : -80)
//                        VStack {
//                            HStack {
//                                
////                                Text("❤️‍🔥")
////                                    .font(.custom("", size: 34, relativeTo: .title3))
////                                    .foregroundColor(Color(hex: ColorConstants.chatGreen))
//                                HStack {
//                                                    Text(NSLocalizedString("paywall1", comment: ""))
//                                                             .font(.system(size: 23, weight: .black))
//                                                             .foregroundColor(Color.black)
//                                                             .padding(.horizontal, 16)
//                                                             .padding(.vertical, 10)
//                                                             .background(
//                                                                 RoundedRectangle(cornerRadius: 8)
//                                                                     .fill(Color.white.opacity(0.9))
//                                                             )
//                                                     }//                                    .font(.custom("", size: 30, relativeTo: .title3))
//                                
//                                    .font(.system(size: 21, weight: .black))
//                                 .foregroundColor(Color.white)
//            
//                            
//                            }
//                            Text(NSLocalizedString("paywall2", comment: ""))
//                              
//                                .font(.system(size: 22, weight: .black))
//                                .foregroundColor(Color.white)
//                                .padding(.horizontal, 10)
//                                .padding(.vertical, 6)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill(Color.black.opacity(0.9)))
//                        }.padding(.top, 40)
//                            
//
//                        VStack(alignment: .leading) {
//
//                            HStack {
//                                Image(systemName: "checkmark.seal")
//                                    .foregroundColor(.black)
//                                Text(NSLocalizedString("noads", comment: ""))
//                                    .font(.system(size: 18))
//
//                             }
//                      
//                            HStack {
//                                Image(systemName: "checkmark.seal")
//                                    .foregroundColor(.black)
//
//                                Text(NSLocalizedString("paywall4", comment: ""))
//                                    .font(.system(size: 18))
//
//                             }
//                            HStack {
//                                Image(systemName: "checkmark.seal")
//                                    .foregroundColor(.black)
//
//                                Text(NSLocalizedString("paywall3", comment: ""))
//                                    .font(.system(size: 18))
//
//                             }
//                            HStack {
//                                Image(systemName: "checkmark.seal")
//                                    .foregroundColor(.black)
//                                Text(NSLocalizedString("paywall5", comment: ""))
//                                    .font(.system(size: 18))
//
//                             }
//                            
//
//                        }.padding(.vertical, 8)
//
//                        VStack {
////
//                            ForEach([offering?.lifetime].compactMap { $0 }) { package in
//                                PackageCellView(package: package, isSelected: package == selectedPackage) { (package) in
//                                    selectedPackage = package
//                                }
//                                }
//                            
//                            
////                            ForEach(offering?.availablePackages ?? []) { package in
////                                PackageCellView(package: package, isSelected: package == selectedPackage) { (package) in
////                                    selectedPackage = package
////                                }
////                            }
//                        
//                    }.padding()
//                            .accentColor(Color.black)
//
//                    Button(action: {
//                        if let selectedPackage = selectedPackage {
//                            isPurchasing = true
//                            Task {
//                                do {
//                                    let customerInfo = try await Purchases.shared.purchase(package: selectedPackage)
//                                    self.isPurchasing = false
//                                    // No need to check userCancelled in v5 as it throws an error instead
//                                    appState.completeOnboarding() // AppState kullanıldı
//                                    // Convert Decimal to Double for EventLogger
//                                    let priceValue = NSDecimalNumber(decimal: selectedPackage.storeProduct.price).doubleValue
//                                    self.isPresented = false
//                                } catch {
//                                    self.isPurchasing = false
//                                    self.error = error as NSError
//                                    self.displayError = true
//                                }
//                            }
//                        } else {
//                            // Handle the case where no package is selected
//                            // You can show an alert or handle it as needed
//                        }
//                    }) {
//                        Text(NSLocalizedString("next", comment: ""))
//                        
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(
//                                    LinearGradient(
//                                        colors: [
//                                            Color(red: 1, green: 0.2, blue: 0.5),
//                                            Color(red: 0.2, green: 0.6, blue: 1)
//                                        ],
//                                        startPoint: .leading,
//                                        endPoint: .trailing
//                                    )
//                            )
//                            .cornerRadius(15)
//                    }
//                        .padding(.horizontal)
//                        .disabled(selectedPackage == nil) // Disable button if no package is selected
//
//
////                        Text(NSLocalizedString("autorenew", comment: ""))
////                        .font(.footnote)
//                    HStack {
//
//                        Button(action: {
//                            guard let url = URL(string: "https://www.cihanakgul.com/seo-privacy") else { return }
//                            UIApplication.shared.open(url)
//                        }) {
//                            Text(NSLocalizedString("privacy", comment: "")) //TODO: privacy
//                                .font(.footnote)
//                        }
//                        Button(action: {
//                            guard let url = URL(string: "https://www.cihanakgul.com/seo-terms") else { return }
//                            UIApplication.shared.open(url)
//                        }) {
//                            Text(NSLocalizedString("terms", comment: ""))
//                                .font(.footnote)
//                        }
//                        Button(action: {
//                        Task {
//                            try? await Purchases.shared.restorePurchases()
//                        }
//                    }) {
//                        Text(NSLocalizedString("restore", comment: "")) //TODO: privacy
//                            .font(.footnote)
//                    }
//                        
//                        Button(action: {
//                        
//                                appState.completeOnboarding()
//                                self.isPresented = false
//                           
//                        }) {
//                            Text(NSLocalizedString("dismiss", comment: ""))
//                                .font(.footnote)
//                                .underline()
//                                .padding(.horizontal, 10)
//                                .padding(.vertical, 8)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill(Color.white.opacity(0.9))
//                                )
//                                .foregroundColor(.black.opacity(0.8))
//                        }
//                    }.foregroundColor(.white.opacity(0.8))
//                 }
//            }
//                .listStyle(InsetGroupedListStyle())
//                .navigationBarTitleDisplayMode(.inline)
//            
//                .onAppear {
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                    withAnimation {
//                        leadingBarItemOpacity = 1
//                    }
//                }
//            }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .edgesIgnoringSafeArea(.bottom)
//                 
//            
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .edgesIgnoringSafeArea(.all)
//
//            Rectangle()
//                    .foregroundColor(Color.white)
//                .opacity(isPurchasing ? 0.5 : 0.0)
//                .edgesIgnoringSafeArea(.all)
//        }
//            .preferredColorScheme(.dark)
//             .background(Color(hex: "1a1a2e"))
// 
//        } .onAppear() {
//          
//            Task {
//                do {
//                    let offerings = try await Purchases.shared.offerings()
//                    if let offer = offerings.current {
//                        offering = offer
//                        // Yearly seçeneği başlangıçta seçili olarak ayarlandı
//                        selectedPackage = offer.lifetime
//                    }
//                } catch {
//                    self.error = error as NSError
//                    self.displayError = true
//                }
//            }
//        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
//          .onAppear {
//        if selectedPackage == nil {
//            selectedPackage = UserViewModel.shared.offerings?.current?.lifetime
//        }
//    }
//         .navigationViewStyle(StackNavigationViewStyle())
//         .alert(isPresented: $showAlert) {
//        Alert(
//            title: Text("Error"),
//            message: Text(error?.localizedDescription ?? "An unexpected error occurred. Please try again later."),
//            dismissButton: .default(Text("OK"), action: { self.showAlert = false })
//        )
//    }
//}
//}
//
//struct PackageCellView: View {
//    let package: Package
//    let isSelected: Bool
//    let onSelection: (Package) -> Void
//
//    var body: some View {
//        Button {
//            onSelection(package)
//        } label: {
//            HStack {
////                Text("\(package.localizedPriceString)/\(package.storeProduct.localizedTitle)")
//                Text("\(package.storeProduct.localizedPriceString) - \(package.storeProduct.localizedTitle)")
//                    .font(.system(size: 16, weight: .heavy))
//
//                
//                    .font(.headline)
//                    .foregroundColor(.white)
//                
//                    .padding(10)
//                
//            }
//            .preferredColorScheme(.dark)
//            .frame(maxWidth: .infinity)
//        }
//            .padding()
//            .background(
//                RoundedRectangle(cornerRadius: 15)
//                    .fill(LinearGradient(
//                        gradient: Gradient(colors: [
//                            Color("6b33fd").opacity(0.7),
//                            Color("6b33fd").opacity(0.9)
//                        ]),
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    ))
//                     
//            )
//            .background(
//            RoundedRectangle(cornerRadius: 15)
//                .stroke(isSelected ? Color.black : Color.white, lineWidth: 4)
//        )
//             
//     }
//}
//
//
//extension NSError: LocalizedError {
//    public var errorDescription: String? {
//        return self.localizedDescription
//    }
//}
//
//#Preview {
//    PaywallView(isPresented: .constant(true))
//        .environmentObject(UserViewModel.shared)
//}


struct PaywallView: View {
    @Binding var isPresented: Bool
    @State private(set) var isPurchasing: Bool = false
    @ObservedObject var userViewModel = UserViewModel.shared
    @EnvironmentObject var appState: AppState // AppStorage yerine AppState eklendi

    @State private var offering: Offering?
    
    @State private var error: NSError?
    @State private var displayError: Bool = false
    @State private var selectedPackage: Package?
    @State private var leadingBarItemOpacity = 0.0
    @State private var showAlert = false


    var body: some View {
        NavigationView {
            if isPurchasing {
                ProgressView()
            }
            ZStack {
                // Burada istediğiniz gradient arka planı ekliyoruz
                LinearGradient(
                    colors: [
                        Color.white,
                        Color.orange
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    
                   
                    VStack {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .mask(
                                               LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray, Color.gray, Color.gray.opacity(0)]), startPoint: .top, endPoint: .bottom)
                                           )
                                .edgesIgnoringSafeArea(.all)
                                .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? -200 : -80)
                        VStack {
                            HStack {
                                
//                                Text("❤️‍🔥")
//                                    .font(.custom("", size: 34, relativeTo: .title3))
//                                    .foregroundColor(Color(hex: ColorConstants.chatGreen))
                                HStack {
                                                    Text(NSLocalizedString("paywall1", comment: ""))
                                                             .font(.system(size: 23, weight: .black))
                                                             .foregroundColor(Color.black)
                                                             .padding(.horizontal, 16)
                                                             .padding(.vertical, 10)
                                                             .background(
                                                                 RoundedRectangle(cornerRadius: 8)
                                                                     .fill(Color.white.opacity(0.9))
                                                             )
                                                     }//                                    .font(.custom("", size: 30, relativeTo: .title3))
                                
                                    .font(.system(size: 21, weight: .black))
                                 .foregroundColor(Color.white)
            
                            
                            }
                            Text(NSLocalizedString("paywall2", comment: ""))
                              
                                .font(.system(size: 22, weight: .black))
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.black.opacity(0.9)))
                        }.padding(.top, 40)
                            

                        VStack(alignment: .leading) {

                            HStack {
                                Image(systemName: "checkmark.seal")
                                    .foregroundColor(.black)
                                Text(NSLocalizedString("noads", comment: ""))
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)


                             }
                      
                            HStack {
                                Image(systemName: "checkmark.seal")
                                    .foregroundColor(.black)

                                Text(NSLocalizedString("paywall4", comment: ""))
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)


                             }
                            HStack {
                                Image(systemName: "checkmark.seal")
                                    .foregroundColor(.black)

                                Text(NSLocalizedString("paywall3", comment: ""))
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)


                             }
                            HStack {
                                Image(systemName: "checkmark.seal")
                                    .foregroundColor(.black)
                                Text(NSLocalizedString("paywall5", comment: ""))
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)


                             }
                            

                        }.padding(.vertical, 8)

                        VStack {
//
                            ForEach([offering?.lifetime].compactMap { $0 }) { package in
                                PackageCellView(package: package, isSelected: package == selectedPackage) { (package) in
                                    selectedPackage = package
                                }
                                }
                            
                            
//                            ForEach(offering?.availablePackages ?? []) { package in
//                                PackageCellView(package: package, isSelected: package == selectedPackage) { (package) in
//                                    selectedPackage = package
//                                }
//                            }
                        
                    }.padding()
                            .accentColor(Color.black)

                    Button(action: {
                        if let selectedPackage = selectedPackage {
                            isPurchasing = true
                            Task {
                                do {
                                    let customerInfo = try await Purchases.shared.purchase(package: selectedPackage)
                                    self.isPurchasing = false
                                    // No need to check userCancelled in v5 as it throws an error instead
                                    appState.completeOnboarding() // AppState kullanıldı
                                    // Convert Decimal to Double for EventLogger
                                    let priceValue = NSDecimalNumber(decimal: selectedPackage.storeProduct.price).doubleValue
                                    self.isPresented = false
                                } catch {
                                    self.isPurchasing = false
                                    self.error = error as NSError
                                    self.displayError = true
                                }
                            }
                        } else {
                            // Handle the case where no package is selected
                            // You can show an alert or handle it as needed
                        }
                    }) {
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
                        .padding(.horizontal)
                        .disabled(selectedPackage == nil) // Disable button if no package is selected


//                        Text(NSLocalizedString("autorenew", comment: ""))
//                        .font(.footnote)
                    HStack {

                        Button(action: {
                            guard let url = URL(string: "https://www.cihanakgul.com/brainrot-privacy") else { return }
                            UIApplication.shared.open(url)
                        }) {
                            Text(NSLocalizedString("privacy", comment: "")) //TODO: privacy
                                .font(.footnote)
                        }
                        Button(action: {
                            guard let url = URL(string: "https://www.cihanakgul.com/brainrot-terms") else { return }
                            UIApplication.shared.open(url)
                        }) {
                            Text(NSLocalizedString("terms", comment: ""))
                                .font(.footnote)
                        }
                        Button(action: {
                        Task {
                            try? await Purchases.shared.restorePurchases()
                        }
                    }) {
                        Text(NSLocalizedString("restore", comment: "")) //TODO: privacy
                            .font(.footnote)
                    }
                        
                        Button(action: {
                        
                                appState.completeOnboarding()
                                self.isPresented = false
                           
                        }) {
                            Text(NSLocalizedString("dismiss", comment: ""))
                                .font(.footnote)
                                .underline()
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white.opacity(0.9))
                                )
                                .foregroundColor(.black.opacity(0.8))
                        }
                    }.foregroundColor(.white.opacity(0.8))
                 }
            }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitleDisplayMode(.inline)
            
                .onAppear {

                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        leadingBarItemOpacity = 1
                    }
                }
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.bottom)
                 
            
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            Rectangle()
                    .foregroundColor(Color.white)
                .opacity(isPurchasing ? 0.5 : 0.0)
                .edgesIgnoringSafeArea(.all)
        }
 
        } .onAppear() {
          
            Task {
                do {
                    let offerings = try await Purchases.shared.offerings()
                    if let offer = offerings.current {
                        offering = offer
                        // Yearly seçeneği başlangıçta seçili olarak ayarlandı
                        selectedPackage = offer.lifetime
                    }
                } catch {
                    self.error = error as NSError
                    self.displayError = true
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
          .onAppear {
        if selectedPackage == nil {
            selectedPackage = UserViewModel.shared.offerings?.current?.lifetime
        }
    }
         .navigationViewStyle(StackNavigationViewStyle())
         .alert(isPresented: $showAlert) {
        Alert(
            title: Text("Error"),
            message: Text(error?.localizedDescription ?? "An unexpected error occurred. Please try again later."),
            dismissButton: .default(Text("OK"), action: { self.showAlert = false })
        )
    }
}
}

struct PackageCellView: View {
    let package: Package
    let isSelected: Bool
    let onSelection: (Package) -> Void

    var body: some View {
        Button {
            onSelection(package)
        } label: {
            HStack {
//                Text("\(package.localizedPriceString)/\(package.storeProduct.localizedTitle)")
                Text("\(package.storeProduct.localizedPriceString) - \(package.storeProduct.localizedTitle)")
                    .font(.system(size: 16, weight: .heavy))

                
                    .font(.title)
                    .foregroundColor(.black)
                
                    .padding(10)
                
            }
            .preferredColorScheme(.dark)
            .frame(maxWidth: .infinity)
        }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            Color("6b33fd").opacity(0.7),
                            Color("6b33fd").opacity(0.9)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                     
            )
            .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(isSelected ? Color.black : Color.white, lineWidth: 4)
        )
             
     }
}


extension NSError: LocalizedError {
    public var errorDescription: String? {
        return self.localizedDescription
    }
}

#Preview {
    PaywallView(isPresented: .constant(true))
        .environmentObject(UserViewModel.shared)
}
