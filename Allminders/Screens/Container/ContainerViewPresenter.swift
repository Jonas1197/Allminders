//
//  ContainerViewPresenter.swift
//  Allminders
//
//  Created by Jonas Gamburg on 10/02/2021.
//

import Foundation

protocol ContainerViewPresenterOutput: AnyObject {
    func presentNotesView()
    func presentRemindersView()
    func presentSettingsView()
    func presentNewReminderVC()
}

protocol ContainerViewPresenterInput: AnyObject {
    func presentNotesView()
    func presentRemindersView()
    func presentSettingsView()
    func presentNewReminderVC()
}

final class ContainerViewPresenter {
    
    weak var coordinator: MainCoordinator?
    
    weak var output: ContainerViewPresenterOutput?
    
    weak var input: ContainerViewPresenterInput?
    
    init() {
        
    }
    
}

extension ContainerViewPresenter: ContainerViewControllerOutput {
    
    func shouldPresentNewReminderVC() {
        output?.presentNewReminderVC()
    }
    
    func didLoad() {
        print("<didLoad ContainerVC>")
    }
    
    func shouldPresentRemindersView() {
        output?.presentRemindersView()
    }
    
    func shouldPresentNotesView() {
        output?.presentNotesView()
    }
    
    func shouldPresentSettingsView() {
        output?.presentSettingsView()
    }
}
