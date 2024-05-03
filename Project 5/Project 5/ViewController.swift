//
//  ViewController.swift
//  Project 5
//
//  Created by Hyun Lee on 5/1/24.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    var currentWord: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        
        if let file = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: file){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        startGame()
    }
    
    func startGame(){
        currentWord = allWords.randomElement()
        title = currentWord
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func restartGame(){
        usedWords.removeAll()
        startGame()
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Tell us", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default){ [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) && isOriginal(word: lowerAnswer) && isReal(word: lowerAnswer) && isSame(word: lowerAnswer){
            usedWords.insert(answer.lowercased(), at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func isPossible(word: String) -> Bool{
        guard var tempWord = title?.lowercased() else {return false}
        for letter in word{
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }else{
                return false
            }
        }
        return true
    }
    func isOriginal(word: String) -> Bool{
        return !usedWords.contains(word)
    }
    func isReal(word: String) -> Bool{
        if word.count < 3{
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    func isSame(word: String) -> Bool{
        if word == title?.lowercased(){
            return false
        }else{
            return true
        }
    }
}

