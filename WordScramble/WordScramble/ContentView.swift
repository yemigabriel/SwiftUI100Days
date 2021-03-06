//
//  ContentView.swift
//  WordScramble
//
//  Created by Yemi Gabriel on 7/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Text("Successful tries: \(usedWords.count) \nTotal letters used: \(usedWords.joined().count)")
                    .font(.smallCaps(.headline)())
                    .foregroundColor(.purple)
                    .multilineTextAlignment(.center)
                    
            }
            
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading:
                                    Button("Refresh Word", action: startGame)
                                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .foregroundColor(.white)
                                    .background(Color.purple)
                                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                                    .shadow(radius: 5)
                                    
            )
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        guard !isSameAsStart(word: answer) else {
            wordError(title: "Word is same as root word", message: "Use another word")
            return
        }
        guard !isTooShort(word: answer) else {
            wordError(title: "Word too short", message: "Use no less than three letters")
            return
        }
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        usedWords.removeAll()
        if let startWordUrl = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String(contentsOf: startWordUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isTooShort(word: String) -> Bool {
        word.count < 3
    }
    
    func isSameAsStart(word: String) -> Bool {
        word == rootWord
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
