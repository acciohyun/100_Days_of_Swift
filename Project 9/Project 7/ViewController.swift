//
//  ViewController.swift
//  Project 7
//
//  Created by Hyun Lee on 5/11/24.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filtered = [Petition]()
    var filter = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString: String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilterAlert))
        print("shown")
        
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        DispatchQueue.global(qos: .userInitiated).async {
            //sends the task to other queues to be resolved
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(json: data)
                    return
                }
            }
            self.showError()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filtered.isEmpty{
            return petitions.count
        }else{
            return filtered.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition: Petition
        if filtered.isEmpty{
            petition = petitions[indexPath.row]
        }else{
            petition = filtered[indexPath.row]
        }
        //        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            //            tableView.reloadData()
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    func showError(){
        DispatchQueue.main.async{
            let ac = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    @objc func showCredits(){
        let ac = UIAlertController(title: "Credits", message: "The following information are from We The People API", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showFilterAlert(){
        let ac = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let removeFilter = UIAlertAction(title: "Remove Filter", style: .default){ [weak self, weak ac] action in
            DispatchQueue.global(qos: .userInitiated).async{
                self?.filter = ""
                self?.filtered = []
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
            }
        }
        let addFilter = UIAlertAction(title: "Add", style: .default){ [weak self, weak ac] action in
            DispatchQueue.global(qos: .userInitiated).async{
                guard let answer = ac?.textFields?[0].text else{ return }
                self?.filter = answer
                if let petitions = self?.petitions{
                    self?.filtered = petitions.filter({$0.title.contains(self?.filter ?? "")})
                    DispatchQueue.main.async{
                        self?.tableView.reloadData()
                    }
                }
            }
        }
        ac.addAction(removeFilter)
        ac.addAction(addFilter)
        present(ac, animated: true)
    }
}

