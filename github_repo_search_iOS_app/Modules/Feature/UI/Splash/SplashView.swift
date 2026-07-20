//
//  SplashView.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/16.
//

import SwiftUI

/**
 Starter view to show animation and logo
 */
struct SplashView: View {
    @State private var startHomeScreen = false
    @State private var isAnimationNotStarted = true

    var body: some View {
        ZStack {
            if startHomeScreen {
                MainTabView()
            } else {
                ZStack {
                    Image("logo")
                        .scaleEffect(isAnimationNotStarted ? CGFloat(0.2) : 1)
                        .rotationEffect(Angle.degrees(isAnimationNotStarted ? SplashConstants.animationRotationStartAngle : SplashConstants.animationRotationEndAngle))
                        .opacity(isAnimationNotStarted ? 0 : 1)
                        .animation(.easeInOut(duration: SplashConstants.animationDuration).delay(1), value: isAnimationNotStarted)
                        .onAppear {
                            isAnimationNotStarted = false
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .ignoresSafeArea()
            }
        }
        .task {
            try? await Task.sleep(nanoseconds: UInt64(SplashConstants.splashFinishTime * 1_000_000_000))
            withAnimation {
                startHomeScreen = true
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
