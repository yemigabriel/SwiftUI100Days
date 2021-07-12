//
//  AnimationGestures.swift
//  Animations
//
//  Created by Yemi Gabriel on 7/12/21.
//

import SwiftUI

struct AnimationGestures: View {
    
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged({ dragAmount = $0.translation })
                    .onEnded({ _ in
                        withAnimation {
                            dragAmount = CGSize.zero
                        }
                        
                    })
            )
//            .animation(.default)
        
        
    }
}

struct AnimationGestures_Previews: PreviewProvider {
    static var previews: some View {
        AnimationGestures()
    }
}
