//
//  Quiz.swift
//  QuizGame
//
//  Created by Matthew Dias on 3/23/19.
//  Copyright © 2019 Matthew Dias. All rights reserved.
//

import Foundation

struct Quiz {
    var question: String
    var options: [String]
    var answerIndex: Int
    
    static func get() -> [Quiz] {
        return [
            Quiz(question: "Who won the Super Bowl?",
                 options: ["Michael Jackson", "The Patriots", "The Rams", "The Red Sox"],
                 answerIndex: 1),
            Quiz(question: "Which of these people helped create Swift?",
                 options: ["Galileo", "Napolean", "Chris Lattner", "Matt Dias"],
                 answerIndex: 2),
            Quiz(question: "What is 4 divided by 2?",
                 options: ["π", "42", "4", "2"],
                 answerIndex: 3)
        ]
    }
}

extension Quiz: Equatable { }
