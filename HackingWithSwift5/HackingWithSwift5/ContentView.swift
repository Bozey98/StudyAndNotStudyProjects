//
//  ContentView.swift
//  HackingWithSwift5
//
//  Created by Денис Мусатов on 29.05.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                Text("Score is: \(score)").font(.headline)
                
                List(usedWords, id: \.self) { word in
                    Image(systemName: "\(word.count).circle")
                    Text("\(word)")
                }
            }
        .navigationBarTitle(rootWord)
        .navigationBarItems(leading: Button("Restart", action: startGame))
        .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    

        func isOriginal(word: String) -> Bool {
            !usedWords.contains(word)
        }
        
        func isPossible(word: String) -> Bool {
            
            var tempWord = rootWord
            
            for letter in word {
                if let pos = tempWord.firstIndex(of: letter) {
                    tempWord.remove(at: pos)
                }
                else {
                    return false
                }
            }
            
            return true
        }
        
        func isReal(word: String) -> Bool {
            guard word.count > 2 else { return false }
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            
            return misspelledRange.location == NSNotFound
        }
        
        func wordError(title: String, message: String) {
            errorTitle = title
            errorMessage = message
            showingError = true
        }
    

    
    
    func addNewWord() {
        
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        guard notSameWord(word: answer) else {
            wordError(title: "It's original word", message: "There are many other words :)")
            return
        }
        
        guard answer.count > 0 else { return }
        
        usedWords.insert(answer, at: 0)
        
        score += answer.count
        
        newWord = ""
    }
    
    
    func startGame() {
        
        restartScore()
        
        if let startWordsURL = Bundle.main.url(forResource: "start1", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let masWords = startWords.components(separatedBy: "\n")
                rootWord = masWords.randomElement() ?? "silkworm"
                
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    func notSameWord(word: String) -> Bool {
        word != rootWord
    }
        
    func restartScore() {
        score = 0
        usedWords = []
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
