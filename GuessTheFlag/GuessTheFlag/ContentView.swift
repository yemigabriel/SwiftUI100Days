//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Yemi Gabriel on 6/29/21.
//

import SwiftUI

struct ContentView: View {
    
    let countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack() {
                Text("Tap the flag of")
                    .foregroundColor(.white)
                Text(countries[correctAnswer])
                    .foregroundColor(.white)
                
                VStack(spacing: 20) {
                    ForEach(0 ..< 3) {
                        Image(countries[$0])
                    }
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
