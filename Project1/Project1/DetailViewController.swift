//
//  DetailViewController.swift
//  Project1
//
//  Created by Hyun Lee on 4/21/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var ImageView: UIImageView!
    var selectedImage: String?
    var index: Int?
    var totalCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index{
            title = "Picture \(index + 1) of \(totalCount ?? 0)"
        }
        navigationItem.largeTitleDisplayMode = .never
        if let imageToLoad = selectedImage{
            ImageView.image = UIImage(named: imageToLoad)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
