//
//  NewReminderCoordinator.swift
//  Allminders
//
//  Created by Jonas Gamburg on 13/02/2021.
//

import UIKit

final class NewReminderCoordinator: Coordinator {
    
    weak var output: ContainerViewPresenterOutput?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    let presenter: NewReminderPresenter
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.presenter = NewReminderPresenter()
    }
    
    func start() {
        let vc = NewReminderVC.instantiate()
        vc.output = presenter
        presenter.input = vc
        presenter.output = self
        navigationController.present(vc, animated: true, completion: nil)
    }
}

extension NewReminderCoordinator: NewReminderPresenterOutput {
    func createNewReminder() {
        presenter.input?.addReminder()
    }
}
