//
//  DetailViewController.swift
//  Milestone 1
//
//  Created by Hyun Lee on 4/27/24.
//

import UIKit

class DetailViewController: UIViewController {
    var flagName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = flagName{
            title = name
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
