//
//  ViewController.swift
//  Allminders
//
//  Created by Jonas Gamburg on 05/02/2021.
//

import UIKit

protocol SignInViewOutput: AnyObject {
    func didLoad()
    func shouldContinue()
}

protocol SignInViewInput: AnyObject {
    
}

final class SignInViewController: UIViewController, SignInViewInput, Storyboarded  {
    
    weak var coordinator: SignInCoordinator?
    
    weak var output: SignInViewOutput?
    
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

