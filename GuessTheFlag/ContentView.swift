//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by aidar on 04.09.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var scoreTitle = ""
    @State private var showingScore = false
    
    @State private var score = 0
    @State private var message = ""
    
    
    @State private var question = 1
    @State private var finished = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                       .font(.largeTitle.bold())
                       .foregroundColor(.white)
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
        } message: {
            Text(message)
        }
        .alert("Well done", isPresented: $finished) {
            Button("Reset", action: restart)
        } message: {
            Text("Final score: \(score).")
        }
    }
    
    func restart() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        question = 1
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            message = "Your score: \(score)"
        } else {
            scoreTitle = "Wrong"
            message = "That is flag of \(countries[number])"
        }
        question += 1
        if question > 8 {
            finished = true
        }
        showingScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
