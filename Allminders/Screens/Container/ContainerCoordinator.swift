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
    
    let navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    let presenter: ContainerViewPresenter
    
    init(navigationController: UINavigationController) {
        presenter = ContainerViewPresenter()
        self.navigationController = navigationController
    }
    
    func start() {
        let vc           = ContainerViewController.instantiate()
        vc.output        = presenter
        presenter.input  = vc
        presenter.output = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func theSyriansAreOnTheBorder() {
        output?.iWantToFinish(self)
    }
    
}

extension ContainerCoordinator: ContainerViewPresenterOutput {
    func presentNewReminderVC() {
        startNewReminderCoordinator()
    }
    
    private func startNewReminderCoordinator() {
        let newReminderCoordinator = NewReminderCoordinator(navigationController: navigationController)
        childCoordinators.append(newReminderCoordinator)
        newReminderCoordinator.output = self
        newReminderCoordinator.start()
    }
    
    func presentNotesView() {
        presenter.input?.presentNotesView()
    }
    
    func presentRemindersView() {
        presenter.input?.presentRemindersView()
    }
    
    func presentSettingsView() {
        presenter.input?.presentSettingsView()
    }
}
