//
//  NewReminderVC.swift
//  Allminders
//
//  Created by Jonas Gamburg on 13/02/2021.
//

import UIKit

protocol NewReminderVCInput: AnyObject {
    func addReminder()
}

protocol NewReminderVCOutput: AnyObject {
    func didLoad()
    func shouldCreateNewReminder()
}

class NewReminderVC: UIViewController, Storyboarded {

    weak var coordinator: NewReminderCoordinator?
    
    weak var output: NewReminderVCOutput?
    
    let largeLabel: UILabel = {
        let label       = UILabel()
        label.text      = "New reminder"
        label.font      = UIFont(name: Font.semibold, size: 40)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoad()
        setUp()
    }
    
    fileprivate func setUp() {
        configureLargeLabel()
    }
    
    fileprivate func configureLargeLabel() {
        view.addSubview(largeLabel)
        NSLayoutConstraint.activate([
            largeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            largeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            largeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension NewReminderVC: NewReminderVCInput {
    func addReminder() {
        print("Reminder added!!!")
    }
}
