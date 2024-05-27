//
//  ViewController.swift
//  Milestone 4
//
//  Created by Hyun Lee on 5/24/24.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var photos = [Photo(label: "label", image: "image")]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
    }
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    @objc func addPhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathExtension(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Photo(label: "Unknown", image: imageName)
        photos.append(photo)
        collectionView.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension ViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue collection view cell")
        }
        
        let photo = photos[indexPath.row]
        cell.name.text = photo.label
        
        let path = getDocumentsDirectory().appendingPathExtension(photos[indexPath.row].image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
}

