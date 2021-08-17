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
            if(startHomeScreen) {
                HomeView()
            } else {
                ZStack {
                    Image("logo")
                        .scaleEffect(isAnimationNotStarted ? CGFloat(0.2) : 1)
                        .rotationEffect(Angle.degrees(isAnimationNotStarted ? SplashConstants.animationRotationStartAngle : SplashConstants.animationRotationEndAngle))
                        .opacity(isAnimationNotStarted ? 0 : 1)
                        .animation(Animation.easeInOut(duration: SplashConstants.animationDuration).delay(1))
                        .onAppear(perform: {
                            isAnimationNotStarted = false
                        })
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white).edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + SplashConstants.splashFinishTime) {
                withAnimation {
                    startHomeScreen = true
                }
            }
        }
        
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
