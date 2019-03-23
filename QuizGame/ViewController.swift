//
//  ViewController.swift
//  QuizGame
//
//  Created by Matthew Dias on 3/23/19.
//  Copyright © 2019 Matthew Dias. All rights reserved.
//

import UIKit

typealias JSON = [String: Any]

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerPicker: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    let allQuizzes = Quiz.get()
    
    var answers: [String] = []
    var quiz: Quiz? {
        didSet {
            guard let quiz = quiz else { return }
            setValues(for: quiz)
        }
    }
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.quiz = allQuizzes.first
        
        answerPicker.delegate = self
        answerPicker.dataSource = self
        
        submitButton.layer.cornerRadius = 16
        
        nextButton.isEnabled = false
        nextButton.layer.cornerRadius = 16
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1).cgColor
        
        resetButton.layer.cornerRadius = 16
        resetButton.isHidden = true
        
        answerPicker.layer.borderWidth = 1
        answerPicker.layer.borderColor = UIColor.darkGray.cgColor
        answerPicker.layer.cornerRadius = 8
    }
    
    func setValues(for quiz: Quiz) {
        questionLabel.text = quiz.question
        self.answers = quiz.options
        
        answerPicker.reloadAllComponents()
        answerPicker.selectRow(0, inComponent: 0, animated: true)
        resultLabel.text = ""
        
        nextButton.isEnabled = false
    }
    
    func quizOver() {
        let alert = UIAlertController(title: "Quiz over",
                                      message: "Thanks for playing! Your score is: \(score)",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
        resetButton.isHidden = false
    }
    
    func reset() {
        self.quiz = allQuizzes.first
        resetButton.isHidden = true
        score = 0
    }
    
    func correctAnswerSelected() {
        resultLabel.text = "You got it!"
        score += 1
    }
    
    func wrongAnswerSelected() {
        score -= 1
        resultLabel.text = "Wrong, try again..."
    }

    @IBAction func submit(_ sender: Any) {
        guard answerPicker.selectedRow(inComponent: 0) == quiz?.answerIndex else {
            wrongAnswerSelected()
            return
        }
        
        correctAnswerSelected()
        
        guard let index = allQuizzes.lastIndex(where: { $0 == self.quiz }) else { return }
        
        if allQuizzes.count > index + 1 {
            nextButton.isEnabled = true
        } else {
            quizOver()
        }
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        guard let index = allQuizzes.lastIndex(where: { $0 == self.quiz }) else { return }
        
        if allQuizzes.count > index + 1 {
            self.quiz = allQuizzes[index + 1]
        }
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        reset()
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return answers[row]
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answers.count
    }
}
