//
//  DetailViewController.swift
//  Milestone 1
//
//  Created by Hyun Lee on 4/27/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var flagName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = flagName{
            title = name.dropLast(7).uppercased()
            imageView.image = UIImage(named: name)
        }
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
