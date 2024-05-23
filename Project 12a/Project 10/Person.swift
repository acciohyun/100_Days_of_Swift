//
//  Person.swift
//  Project 10
//
//  Created by Hyun Lee on 5/17/24.
//

import UIKit

class Person: NSObject, NSCoding {
    func encode(with coder: NSCoder) { //used when saving
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }
    
    required init?(coder: NSCoder) { //when initalising this class
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        image = coder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
