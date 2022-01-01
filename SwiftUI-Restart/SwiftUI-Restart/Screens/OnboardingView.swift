//
//  OnboardingView.swift
//  SwiftUI-Restart
//
//  Created by Ahmet on 30.12.2021.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true

    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var titleText = "Share."

    let hapticFeedback = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)

            VStack(spacing: 20) {
                Spacer()

                //MARK: - HEADER
                VStack(spacing: 0) {
                    Text(titleText)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .id(titleText)

                    Text("""
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }//MARK: VSTACK
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                //MARK: HEADER

                //MARK: - CENTER
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1, y: 0)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)

                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    indicatorOpacity = 0
                                    titleText = "Give."
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffset = .zero

                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1.0
                                        titleText = "Share."
                                    }
                                })
                        )//: GESTURE
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }//; ZSTACK
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(1).repeatForever(), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                //MARK: CENTER

                Spacer()

                //MARK: - FOOTER
                ZStack {
                    ZStack {
                        // 1. Background (Static)
                        Capsule()
                            .fill(.white.opacity(0.2))

                        Capsule()
                            .fill(.white.opacity(0.2))
                            .padding(8)


                        // 2. Call to action (Static)
                        Text("Get Started")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(x: 20)

                        // 3. Capsule (Dynamic width)
                        HStack {
                            Capsule()
                                .fill(Color("ColorRed"))
                                .frame(width: 80 + buttonOffset)

                            Spacer()
                        }
                        // 4. Circle (Draggable)

                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color("ColorRed"))

                                Circle()
                                    .fill(.black.opacity(0.2))
                                    .padding(8)

                                Image(systemName: "chevron.right.2")
                                    .font(.system(size: 24, weight: .bold))
                            }
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80, alignment: .center)
                            .offset(x: buttonOffset)
                            .gesture(
                                DragGesture()
                                    .onChanged({ gesture in
                                        if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                            buttonOffset = gesture.translation.width
                                        }
                                    })
                                    .onEnded({ _ in
                                        withAnimation(.easeOut(duration: 0.4)) {
                                            if buttonOffset > buttonWidth / 2 {
                                                hapticFeedback.notificationOccurred(.success)
                                                buttonOffset = buttonWidth - 80
                                                playSound(sound: .chimeup, type: .mp3)
                                                isOnboardingViewActive = false
                                            } else {
                                                hapticFeedback.notificationOccurred(.error)
                                                buttonOffset = 0
                                            }
                                        }
                                    })
                            )//: GESTURE

                            Spacer()
                        }
                    }
                    .frame(width: buttonWidth, height: 80, alignment: .center)
                    .padding()


                }//MARK: FOOTER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : +40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }//: VSTACK
        }//: ZSTACK
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
