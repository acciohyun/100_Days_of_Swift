//
//  ViewController.swift
//  Milestone 1
//
//  Created by Hyun Lee on 4/27/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        var items = try! fm.contentsOfDirectory(atPath: path)
        items = items.sorted()
        for item in items{
            if item.hasSuffix("2x.png"){
                flags.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row].dropLast(7).uppercased()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
           vc.flagName = flags[indexPath.row]
           navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

