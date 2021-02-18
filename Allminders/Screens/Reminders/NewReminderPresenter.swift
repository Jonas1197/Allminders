//
//  NewReminderPresenter.swift
//  Allminders
//
//  Created by Jonas Gamburg on 13/02/2021.
//

import UIKit


protocol NewReminderPresenterOutput: AnyObject {
    func createNewReminder()
}

protocol NewReminderPresenterInput: AnyObject {
    
}

final class NewReminderPresenter {
    
    weak var output: NewReminderPresenterOutput?
    weak var input: NewReminderVCInput?
    
    
    init() {
        
    }
}


extension NewReminderPresenter: NewReminderVCOutput {
    
    func didLoad() {
        print("<didLaod NewRemindersVC")
    }
    
    func shouldCreateNewReminder() {
        input?.addReminder()
    }
}
