//
//  Storyboarded.swift
//  CoordinatorTest
//
//  Created by Hyun Lee on 5/28/24.
//

import Foundation
import UIKit

// MARK: STORYBOARD PROTOCOL
// Makes it easier to create view controllers from the storyboard 

protocol Storyboarded{
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController{
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        //load storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
