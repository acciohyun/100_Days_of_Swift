//
//  Coordinator.swift
//  CoordinatorTest
//
//  Created by Hyun Lee on 5/28/24.
//

import Foundation
import UIKit

// MARK: COORDINATOR PROTOCOL
protocol Coordinator{
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    func start()
}


