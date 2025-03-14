//
//  OnboardingView.swift
//  Bookmark App
//
//  Created by Адлет Жумагалиев on 13.03.2025.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Image("background")
                    .resizable()
                    .frame(width: 390, height: 614)
                    .ignoresSafeArea()
                    .padding(.bottom, 6)
                
                Text("Save all interesting links in one app")
                    .frame(width: 358, height: 92)
                    .foregroundStyle(.white)
                    .font(.system(size: 36, weight: .bold))
                    .padding(.bottom, 24)
                    .padding(.leading, -16)
                
                Button(action: {
                    hasSeenOnboarding = true
                }, label: {
                    Text("Let's start collecting")
                        .foregroundStyle(.black)
                        .frame(width: 358, height: 58)
                        .background(.white)
                        .cornerRadius(16)
                })
            }
        }
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}
