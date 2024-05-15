//
//  ViewController.swift
//  Project1
//
//  Created by Hyun Lee on 4/20/24.
//

import UIKit //references iOS UI Kit

class ViewController: UITableViewController { //UIViewController is apple's default View (default: white & blank)

    var pictures = [String]()
    
    override func viewDidLoad() { //overrides the code from the parent class
        super.viewDidLoad() //asks Apple UIViewController to run before running our code
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        //Added code - these variables disappear once viewDidLoad() is done
        DispatchQueue.global(qos: .userInitiated).async{
            let fm = FileManager.default //built in system type that lets us work with files system - used to load file
            let path = Bundle.main.resourcePath! //sets resource path of our app bundle. bundle -> directory containing compiled program and assets
            var items = try! fm.contentsOfDirectory(atPath: path) // of all the files in the resource directory of the app
            items = items.sorted()
            for item in items{
                if item.hasPrefix("nssl"){
                    self.pictures.append(item)
                }
            }
        }
//        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
//        cell.textLabel?.text = "Picture \(indexPath.row + 1) of \(pictures.count) "
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            vc.index = indexPath.row
            vc.totalCount = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

