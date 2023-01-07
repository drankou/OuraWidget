//
//  ContentView.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 02.01.2023.
//

import SwiftUI
import WidgetKit
import KeychainAccess
import KeyboardObserving

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var apiKey: String = ""
    @KeychainStorage("OURA_API_KEY") var savedApiKey
    @FocusState private var isInputFocused: Bool
    @State private var pastedToken: String = ""
    @State private var pasteboardChangeCountBeforeBackground: Int = UIPasteboard.general.changeCount
    @State private var isRedirecting: Bool = false
    
    var isSaved: Bool {
        !apiKey.isEmpty && apiKey == savedApiKey
    }
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
            VStack (alignment: .center, spacing: 8) {
                VStack {
                    Image("oura")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 82)
                        .padding(.vertical, 4)
                    Text("Oura Widget")
                        .foregroundColor(.black)
                        .opacity(0.7)
                        .font(.system(size: 32, weight: .medium))
                        .multilineTextAlignment(.center)
                }.padding(.bottom, 20)
                
                if isRedirecting {
                    Text("Redirecting to Oura")
                        .font(.system(size: 28))
                        .foregroundColor(.black)
                        .opacity(0.7)
                } else {
                    HStack {
                        Text("1. Go to __[Oura Developer Account](https://cloud.ouraring.com/personal-access-tokens)__\n2. Click __Create New Personal Access Token__\n3. Add Note: \"Oura Widget\"\n4. __Copy token__ and __Paste__ in the field below")
                            .accentColor(Color(hex: "7051D8"))
                            .foregroundColor(.black)
                            .lineLimit(nil)
                            .lineSpacing(8)
                            .padding(.top, 16)
                            .padding(.bottom, 16)
                        Spacer()
                    }
                    
                    VStack (alignment: .center, spacing: 6) {
                        TextField("Enter Your API Token", text: $apiKey)
                            .font(.system(size: 16, weight: .regular))
                            .focused($isInputFocused)
                            .removePredictiveSuggestions()
                            .padding(16)
                            .background(.white)
                            .cornerRadius(8)
                            .preferredColorScheme(.light)
                            .onAppear {
                                apiKey = savedApiKey
                            }
                        
                        
                        if !isSaved {
                            Button(action: {
                                savedApiKey = apiKey
                                isInputFocused = false
                                WidgetCenter.shared.reloadAllTimelines()
                            }) {
                                Text("Save")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(16)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(hex: "7B61FF").opacity(0.7))
                                    .cornerRadius(8)
                            }
                        } else {
                            HStack(alignment: .center, spacing: 8) {
                                Text("Done")
                                    .font(.system(size: 16, weight: .regular))
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12))
                            }
                            .foregroundColor(.secondary)
                            .padding(.top, 16)
                            
                            Text("You can now add widgets to your Home screen 🎉")
                                .foregroundColor(.secondary)
                                .font(.system(size: 12, weight: .regular))
                        }
                        
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea()
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                guard pasteboardChangeCountBeforeBackground != UIPasteboard.general.changeCount else { return }
                guard UIPasteboard.general.hasStrings else { return }
                if let clipboardKey = UIPasteboard.general.string {
                    apiKey = clipboardKey
                }
            } else if newPhase == .background {
                pasteboardChangeCountBeforeBackground = UIPasteboard.general.changeCount
            }
        }.onOpenURL { url in
            if let host = url.host, host == "api_key" {
                return
            }

            isRedirecting = true
            UIApplication.shared.open(URL(string: "oura://")!, options: [:]) { success in
                isRedirecting = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func removePredictiveSuggestions() -> some View {
        self.keyboardType(.alphabet)
            .disableAutocorrection(true)
    }
}
