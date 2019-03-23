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
        answerPicker.layer.borderWidth = 1
        answerPicker.layer.borderColor = UIColor.darkGray.cgColor
        answerPicker.layer.cornerRadius = 8
    }
    
    func setValues(for quiz: Quiz) {
        questionLabel.text = quiz.question
        self.answers = quiz.options
    }

    @IBAction func submit(_ sender: Any) {
        if answerPicker.selectedRow(inComponent: 0) == quiz?.answerIndex {
            resultLabel.text = "You got it!"
        } else {
            resultLabel.text = "Try again..."
        }
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
