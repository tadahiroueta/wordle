//
//  Game.swift
//  wordle
//
//  Created by Ueta, Lucas T on 3/28/24.
//

import Foundation

class Game {
    
    static var vocabulary: [String] = []
    
    var answer: String?
    var turn = 0
    
    init() {
        if Game.vocabulary.count == 0 { fetchVocabulary() }
        
        answer = Game.getRandomWord()
    }
    
    func fetchVocabulary() {
        let URL = Bundle.main.path(forResource: "dictionary", ofType: "txt")
        let read = try! String(contentsOfFile: URL!, encoding: String.Encoding.utf8)
        Game.vocabulary = read.components(separatedBy: "\n").filter({ $0.count == 5 })
    }
    
    static func getRandomWord() -> String { return Game.vocabulary[Int.random(in: 0..<Game.vocabulary.count)] }
        
    static func isWord(word: String) -> Bool { return Game.vocabulary.contains(word) }
    
    func guess(word: String) -> (Bool, [TileStatus], [String]) {
        turn += 1
        
        guard word != answer else { return (true, [.rightPlace, .rightPlace, .rightPlace, .rightPlace, .rightPlace], []) }
        
        let guessLetters = toArray(word)
        let answerLetters = toArray(answer!)
        var answerLettersExaustable = answerLetters
        var status: [TileStatus] = [.wrong, .wrong, .wrong, .wrong, .wrong]
        var deadLetters: [String] = []
        
        for i in 0..<5 {
            let guessLetter = guessLetters[i]
            guard guessLetter == answerLetters[i] else { continue }
            status[i] = .rightPlace
            answerLettersExaustable = answerLettersExaustable.filter({ $0 != guessLetter })
        }
        
        for i in 0..<5 {
            let guessLetter = guessLetters[i]
            guard status[i] == .wrong else { continue }
            guard answerLettersExaustable.contains(guessLetter) else {
                guard !answerLetters.contains(guessLetter) else { continue }
                deadLetters.append(guessLetter)
                continue
            }
            status[i] = .rightLetter
            answerLettersExaustable = answerLettersExaustable.filter({ $0 != guessLetter })
        }
        
        return (false, status, deadLetters)
    }
    
    func isGameOver() -> Bool { return turn > 5 }
}

