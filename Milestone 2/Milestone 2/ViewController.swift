//
//  ViewController.swift
//  Milestone 2
//
//  Created by Hyun Lee on 5/7/24.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearItems))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingItems[indexPath.row]
        return cell
    }

    @objc func addItem(){
        let ac = UIAlertController(title: "Add an item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submit = UIAlertAction(title: "Add", style: .default){ [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else {return}
            self?.submit(item)
        }
        ac.addAction(submit)
        present(ac, animated: true)
    }
    
    @objc func clearItems(){
        shoppingItems.removeAll()
        tableView.reloadData()
    }
    
    func submit(_ item: String){
        shoppingItems.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

