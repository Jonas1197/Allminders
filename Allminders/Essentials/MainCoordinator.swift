//
//  MainCoordinator.swift
//  Allminders
//
//  Created by Jonas Gamburg on 05/02/2021.
//

import UIKit


class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startSignInCoordinator()
    }
    
    private func startSignInCoordinator() {
        let coord = SignInCoordinator(navigationController: self.navigationController)
        childCoordinators.append(coord)
        coord.start()
    }
    
    func containerView() {
    
    }
}

