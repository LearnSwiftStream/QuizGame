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
    
    var answers: [String] = []
    var quiz: Quiz? {
        didSet {
            guard let quiz = quiz else { return }
            setValues(for: quiz)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.quiz = Quiz(question: "Who won the Super Bowl?",
                         options: ["Michael Jackson", "The Patriots", "The Rams", "The Red Sox"],
                         answerIndex: 1)
        
        answerPicker.delegate = self
        answerPicker.dataSource = self
        
        submitButton.layer.cornerRadius = 16
        
        nextButton.isEnabled = false
        nextButton.layer.cornerRadius = 16
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1).cgColor
        
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
    }

    @IBAction func submit(_ sender: Any) {
        if answerPicker.selectedRow(inComponent: 0) == quiz?.answerIndex {
            resultLabel.text = "You got it!"
            nextButton.isEnabled = true
            
        } else {
            resultLabel.text = "Try again..."
        }
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        self.quiz = Quiz(question: "What day is it?",
                         options: ["Monday", "Tuesday", "Saturday", "I don't know"],
                         answerIndex: 2)
        nextButton.isEnabled = false
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
