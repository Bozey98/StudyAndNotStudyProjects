//
//  ContentView.swift
//  HackWithSwift2
//
//  Created by Денис Мусатов on 27.05.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var rotation : Double = 0
    @State private var opacity : Double = 1
    @State private var wrongAnswer : CGFloat = 1

    var body: some View {
        ZStack {
        
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag").foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding()
                    }
                ForEach(0..<3) { number in
                    Button( action: {
                        withAnimation {
                            self.flagTapped(number)
                        }
                        
                    
                        
                    }) {
                        
                        FlagView(countries: self.countries, number: number)
                        
                            
                        
                        
                    }//.rotation3DEffect(.degrees(self.rotation), axis: (x: 0, y: 1, z:0))
                        
                        .scaleEffect(number != self.correctAnswer ? self.wrongAnswer : 1)
                        //.animation(.interpolatingSpring(stiffness: 5, damping: 3))
                        .rotationEffect(number == self.correctAnswer ? .degrees(self.rotation) : .degrees(0))
                        .opacity(number != self.correctAnswer ? self.opacity : 1)
                    
                    
                    
                }
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            self.rotation += 360
            self.opacity = 0.25
        }
        else {
            scoreTitle = "Wrong"
            score -= 1
            wrongAnswer -= 0.5
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        self.opacity = 1
        wrongAnswer = 1
        //wrongAnswer = false
    }
}

struct FlagView: View {
    let countries: [String]
    let number: Int
    var body: some View {
        Image(self.countries[self.number])
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
        .shadow(color: .black, radius: 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

