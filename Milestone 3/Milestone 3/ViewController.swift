//
//  ViewController.swift
//  Milestone 3
//
//  Created by Hyun Lee on 5/15/24.
//

import UIKit

class ViewController: UIViewController {
    var currentAnswer = [Character]()
    var currentClue = [Character]()
    var score = 0
    var currentGuess: UITextField!
    var clueLabel: UILabel!
    
    
    override func loadView(){
        view = UIView()
        view.backgroundColor = .white
        
        currentGuess = UITextField()
        currentGuess.translatesAutoresizingMaskIntoConstraints = false
        currentGuess.placeholder = "Enter a letter to guess"
        currentGuess.textAlignment = .center
        currentGuess.font = UIFont.systemFont(ofSize: 30)
        currentGuess.isUserInteractionEnabled = true
        currentGuess.keyboardType = UIKeyboardType.default

        view.addSubview(currentGuess)
        
        clueLabel = UILabel()
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.font = UIFont.systemFont(ofSize: 50)
        clueLabel.text = "Guess this word"
        clueLabel.numberOfLines = 0
        view.addSubview(clueLabel)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("Submit", for: .normal)
        view.addSubview(submit)
        submit.addTarget(self, action: #selector(submitLetter), for: .touchUpInside)
        
        NSLayoutConstraint.activate([clueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     clueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     currentGuess.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 30),
                                     currentGuess.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     submit.topAnchor.constraint(equalTo: currentGuess.bottomAnchor, constant: 10),
                                     submit.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                                    ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
    }
    
    @objc func submitLetter(_ sender: UIButton){
        guard let letter = currentGuess.text else {return}
        if letter.count == 1{
            checkLetter(Character(letter))
        }else{
            let ac = UIAlertController(title: "Enter only one letter", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
        }
    }
    
    func loadLevel(){
        if let levelFileURL = Bundle.main.url(forResource: "level1", withExtension: "txt"){
            if let levelContents = try? String(contentsOf:  levelFileURL){
                var allWords = levelContents.components(separatedBy: "\n")
                allWords.shuffle()                
                currentAnswer = Array(allWords[0])
                currentClue = [Character](repeating: "?", count: currentAnswer.count)
                clueLabel.text = String(currentClue)
                print(currentAnswer)
            }
        }
    }
    
    func checkLetter(_ letter: Character){
        var letter = Character(letter.uppercased())
        if currentAnswer.contains(letter) && !currentClue.contains(letter){
            for (i, char) in currentAnswer.enumerated(){
                if char == letter{
                    currentClue[i] = letter
                }
            }
            clueLabel.text = String(currentClue)
            currentGuess.text = ""
        }else if currentClue.contains(letter){
            let ac = UIAlertController(title: "Already guessed", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
        }else if !currentClue.contains(letter){
            let ac = UIAlertController(title: "Wrong guess, try again", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
        }
    }


}

