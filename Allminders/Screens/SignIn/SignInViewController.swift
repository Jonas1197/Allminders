//
//  ViewController.swift
//  Allminders
//
//  Created by Jonas Gamburg on 05/02/2021.
//

import UIKit

protocol SignInViewControllerInput: AnyObject {
    
}

protocol SignInViewControllerOutput: AnyObject {
    func didLoad()
    func shouldContinue()
}


final class SignInViewController: UIViewController, Storyboarded  {
    
    weak var coordinator: SignInCoordinator?
    
    weak var output: SignInViewControllerOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoad()
    }
    
    fileprivate func setUp() {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func continueTapped(_ sender: UIButton) {
        output?.shouldContinue()
    }
}

extension SignInViewController: SignInViewControllerInput {
    
}
