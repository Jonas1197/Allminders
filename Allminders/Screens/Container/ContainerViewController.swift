//
//  ContainerViewController.swift
//  Allminders
//
//  Created by Jonas Gamburg on 05/02/2021.
//

import UIKit

enum ViewType {
    case reminders,
         notes,
         settings
}

protocol ContainerViewInput: AnyObject {
    
}

protocol ContainerViewControllerOutput: AnyObject {
    func didLoad()
    func shouldPresentNotesView()
    func shouldPresentRemindersView()
    func shouldPresentSettingsView()
    func shouldPresentNewReminderVC()
}


final class ContainerViewController: UIViewController, Storyboarded {

    weak var output:             ContainerViewControllerOutput?
    
    weak var coordinator:        MainCoordinator?
    
    private var currentViewType: ViewType      = .reminders
    
    private let remindersView:   RemindersView = .init()
    
    private let notesView:       NotesView     = .init()
    
    let actionBar: ActionBar = {
        let ab = ActionBar()
        ab.layer.cornerRadius = 16
        return ab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func setUp() {
        configureActionBar()
        configureRemindersView()
        configureNotesView()
        configureSettingsView()
    }
    
    fileprivate func configureRemindersView() {
        remindersView.delegate = self
        remindersView.fix(in: view, padding: UIEdgeInsets(top: 45, left: 10, bottom: 110, right: 10))
        remindersView.layer.opacity      = 1.0
        remindersView.backgroundColor    = .white
        remindersView.layer.cornerRadius = 10
    }
    
    fileprivate func configureNotesView() {
        notesView.fix(in: view, padding: UIEdgeInsets(top: 45, left: 10, bottom: 110, right: 10))
        notesView.layer.opacity      = 0.0
        notesView.backgroundColor    = .white
        notesView.layer.cornerRadius = 10
    }
    
    fileprivate func configureSettingsView() {
        #warning("Implemintation missing!")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension ContainerViewController: RemindersViewDelegate {
    func addNewReminderTapped() {
        output?.shouldPresentNewReminderVC()
    }
}

extension ContainerViewController: ActionBarDelegate {

    func remindersTapped() {
        output?.shouldPresentRemindersView()
    }
    
    func notesTapped() {
        output?.shouldPresentNotesView()
    }
    
    func settingsTapped() {
        output?.shouldPresentSettingsView()
    }
    
    fileprivate func configureActionBar() {
        actionBar.delegate = self
        view.addSubview(actionBar)

        NSLayoutConstraint.activate([
            actionBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            actionBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            actionBar.heightAnchor.constraint(equalToConstant: 70),
            actionBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
        
        actionBar.spacing = view.frame.width / 5.984
    }
}

extension ContainerViewController: ContainerViewPresenterInput {
    func presentNewReminderVC() {
        //coordinaaotr
    }
    
    
    func presentNotesView() {
        changeFocus(toView: .notes)
    }
    
    func presentRemindersView() {
        changeFocus(toView: .reminders)
    }
    
    func presentSettingsView() {
        changeFocus(toView: .settings)
    }
    
    
    private func changeFocus(toView viewType: ViewType) {
        switch viewType {
        case .reminders:
            UIView.animate(withDuration: AnimationConstants.animationDuration - 0.2) {
                self.remindersView.layer.opacity = 1.0
                self.notesView.layer.opacity  = 0.0
                //self.settingsView.layer.opacity = 0.0
            }

        case .notes:
            UIView.animate(withDuration: AnimationConstants.animationDuration - 0.2) {
                self.remindersView.layer.opacity = 0.0
                self.notesView.layer.opacity  = 1.0
                //self.settingsView.layer.opacity = 0.0
            }

        case .settings:
            UIView.animate(withDuration: AnimationConstants.animationDuration - 0.2) {
                self.remindersView.layer.opacity = 0.0
                self.notesView.layer.opacity  = 0.0
                //self.settingsView.layer.opacity = 1.0
            }
        }
    }
}
