//
//  HomeView.swift
//  SwiftUI-Restart
//
//  Created by Ahmet on 30.12.2021.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false

    @State private var isAnimating: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            //MARK: - HEADER
            Spacer()

            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)

                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(Animation
                                .easeOut(duration: 4)
                                .repeatForever()
                               , value: isAnimating
                    )
            }
            //MARK: HEADER

            //MARK: - CENTER
            Text("""
            Lorem ipsum dolor sit amet, consectetur adipiscing elit
            """)
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : +40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            //MARK: CENTER

            //MARK: - FOOTER

            Spacer()

            Button {
                withAnimation(.easeOut(duration: 1)) {
                    playSound(sound: .success, type: .m4a)
                    isOnboardingViewActive = true
                }
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)

                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .opacity(isAnimating ? 1 : 0)
            .offset(y: isAnimating ? 0 : +40)
            .animation(.easeOut(duration: 1), value: isAnimating)

            //MARK: FOOTER

        }//: VSTACK
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
