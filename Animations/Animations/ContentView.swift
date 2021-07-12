//
//  ContentView.swift
//  Animations
//
//  Created by Yemi Gabriel on 7/10/21.
//

import SwiftUI

struct CornerRadiusModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRadiusModifier(amount: 0, anchor: .topLeading), identity: CornerRadiusModifier(amount: 90, anchor: .topLeading))
    }
}

struct ContentView: View {
    
    @State private var animationAmount: CGFloat = 1
    @State private var rotateAnimationAmount = 0.0
    @State private var enabled = false
    @State private var shouldPivot = false
    
    var body: some View {
        print(animationAmount)
        
        return VStack {
            
            // custom modifiers
            Button("Pivot") {
                print("pivot")
                withAnimation {
                    shouldPivot.toggle()
                }
            }
            .padding()
            
            if shouldPivot {
                Rectangle()
                    .fill()
                    .frame(width: 150, height: 150)
                    .transition(.pivot)
            }
            
            Spacer()
            // Stacking
            Button("Hey there") {
                enabled.toggle()
            }
            .foregroundColor(.white)
            .frame(width: 75, height: 75)
            .background(enabled ? Color.green : Color.yellow)
            .animation(.default)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 20, damping: 1))
            
            
            
            // animating bindings
            Stepper("Scale Amount", value: $animationAmount.animation(
                // using Animation struct
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10, step: 1)
            
            Text("\(animationAmount, specifier: "%g")")
            
            Spacer()
            
            //explicit animations
            Button("Rotate me") {
                rotateAnimationAmount += 360
                print(rotateAnimationAmount)
//                withAnimation(
//                    .easeInOut(duration: 1)
//                    .repeatCount(3, autoreverses: true)
//                ) {
//                    rotateAnimationAmount += 360
//                }
            }
            .padding(50)
            .background(Color.purple)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(
                .degrees(rotateAnimationAmount),
                axis: (x: 1.0, y: 0.0, z: 0.0),
                anchor: .center)
            
            
            Spacer()
            
            Button("Scale me") {}
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount)
                
            //implicit animation on view
//            Button("Tap Me") {
//                print("me")
//                animationAmount += 1
//            }
//            .padding(50)
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .overlay(
//                Circle()
//                    .stroke(lineWidth: 1)
//                    .foregroundColor(.blue)
//                    .scaleEffect(animationAmount)
//    //                .blur(radius: (animationAmount - 1) * 3)
//                    .opacity(Double(2 - animationAmount))
//                    .animation(
//                        Animation
//                            .easeInOut(duration: 1.0)
//                            .repeatForever(autoreverses: false)
//                    )
//            )
//    //        .scaleEffect(animationAmount)
//    //        .blur(radius: (animationAmount - 1) * 3)
//    //        .animation(.easeInOut(duration: 1.0))
//            .onAppear(perform: {
//                animationAmount = 2
//        })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
