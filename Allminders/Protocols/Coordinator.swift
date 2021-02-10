//
//  Coordinator.swift
//  Allminders
//
//  Created by Jonas Gamburg on 05/02/2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    
    func start()
    
    func childDidFinish(_ child: Coordinator)
}

extension Coordinator {
    
    func childDidFinish(_ child: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        } 
    }
    
}
