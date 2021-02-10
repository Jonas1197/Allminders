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

protocol ContainerViewOutput: AnyObject {
    func shouldPresentNotesView()
}

extension ContainerViewController: ContainerViewInput {
    
}

final class ContainerViewController: UIViewController, Storyboarded {

    weak var output: ContainerViewOutput?
    
    weak var coordinator: MainCoordinator?
    
    private var currentViewType: ViewType = .reminders
    
    private let remindersView: RemindersView = .init()
    private let notesView: NotesView = .init()
    
    let actionBar: ActionBar = {
        let ab = ActionBar()
        ab.layer.cornerRadius = 16
        return ab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        #warning("Add Super!!!!")
        navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func setUp() {
        configureActionBar()
        configureRemindersView()
    }
    
    fileprivate func configureRemindersView() {
        remindersView.fix(in: view, padding: UIEdgeInsets(top: 45, left: 10, bottom: 110, right: 10))
        remindersView.layer.opacity      = 1.0
        remindersView.backgroundColor    = .white
        remindersView.layer.cornerRadius = 10
        changeFocus(toView: .reminders)
    }
    
    fileprivate func configureNotesView() {
        notesView.fix(in: view, padding: UIEdgeInsets(top: 45, left: 10, bottom: 110, right: 10))
        notesView.layer.opacity      = 0.0
        notesView.backgroundColor    = .white
        notesView.layer.cornerRadius = 10
        changeFocus(toView: .notes)
    }
}


extension ContainerViewController: ActionBarDelegate {

    func remindersTapped() {
        print("[reminders tapped]")
        if currentViewType != .reminders {
            currentViewType = .reminders
            changeFocus(toView: currentViewType)
        }
    }
    
    func notesTapped() {
        output?.shouldPresentNotesView()
        
//        print("[notes tapped]")
//        if currentViewType != .notes {
//            currentViewType = .notes
//            configureNotesView()
//            changeFocus(toView: currentViewType)
//        }
    }
    
    func settingsTapped() {
        print("[settings tapped]")
//        if currentView != .settings {
//            currentView = .settings
//            changeFocus(toView: currentView)
//        }
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
    
    fileprivate func changeFocus(toView viewType: ViewType) {
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
