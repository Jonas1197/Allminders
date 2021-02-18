//
//  SignInCoordinator.swift
//  Allminders
//
//  Created by Jonas Gamburg on 10/02/2021.
//

import UIKit


class SignInCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    let presenter: SignInPresenter
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.presenter = SignInPresenter()
    }

    func start() {
        let vc           = SignInViewController.instantiate()
        vc.output        = presenter
        presenter.input  = vc
        presenter.output = self
        navigationController.pushViewController(vc, animated: false)
    }
}

extension SignInCoordinator: SignInPresenterOutput {
    func `continue`() {
        startContainerCoordinator()
    }
    
    private func startContainerCoordinator() {
        let containerCoordinator = ContainerCoordinator(navigationController: navigationController)
        childCoordinators.append(containerCoordinator)
        containerCoordinator.output = self
        containerCoordinator.start()
    }
}

extension SignInCoordinator: ContainerCoordinatorOutput {
    func iWantToFinish(_ coord: Coordinator) {
        childDidFinish(coord)
    }
}
