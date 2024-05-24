//
//  Photo.swift
//  Milestone 4
//
//  Created by Hyun Lee on 5/24/24.
//

import UIKit

class Photo: NSObject {
    var label: String
    var image: String
    
    init(label: String, image: String) {
        self.label = label
        self.image = image
    }
}
