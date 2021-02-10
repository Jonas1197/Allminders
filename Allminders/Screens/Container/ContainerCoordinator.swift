//
//  ContainerCoordinator.swift
//  Allminders
//
//  Created by Jonas Gamburg on 10/02/2021.
//

import UIKit

protocol ContainerCoordinatorOutput: AnyObject {
    func iWantToFinish(_ coord: Coordinator)
}
    
final class ContainerCoordinator: Coordinator {
    weak var output: ContainerCoordinatorOutput?
    
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    let presenter: ContainerPresenter
    
    init(navigationController: UINavigationController) {
        presenter = ContainerPresenter()
        self.navigationController = navigationController
    }
    
    func start() {
        let vc =  ContainerViewController.instantiate()
        vc.output = presenter
        presenter.input = vc
        presenter.output = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func theSyriansAreOnTheBorder() {
        output?.iWantToFinish(self)
    }
    
}

extension ContainerCoordinator: ContainerPresenterOutput {
    
}
