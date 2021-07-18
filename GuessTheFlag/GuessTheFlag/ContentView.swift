//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Yemi Gabriel on 6/29/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var rotationAmount = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack() {
                Text("Tap the flag of")
                    .foregroundColor(.white)
                Text(countries[correctAnswer])
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                VStack(spacing: 20) {
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.flagTapped(number)
                            withAnimation {
                                if number == correctAnswer {
                                    rotationAmount += 360
                                }
                            }
                        },
                        label: {
                            FlagImage(name: countries[number])
                                .rotation3DEffect(
                                    .degrees(rotationAmount),
                                    axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
//                                .opacity(number == correctAnswer ? 0.25 : 1)
                        })
                    }
                }
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("OK"), action: {
                askQuestion()
            }))
        })
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 10
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    var name: String
//    var correct = false
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
//            .opacity(correct ? 1.0 : 0.25)
    }
}
