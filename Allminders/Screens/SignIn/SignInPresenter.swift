//
//  SignInPresenter.swift
//  Allminders
//
//  Created by Jonas Gamburg on 10/02/2021.
//

import Foundation

protocol SignInPresenterOutput: AnyObject {
    func `continue`()
}

protocol SignInPresenterInput: AnyObject {
    
}

final class SignInPresenter {
    
    weak var output: SignInPresenterOutput?
    
    weak var input: SignInViewControllerInput?
    
    init() {
        
    }
    
}

extension SignInPresenter: SignInViewControllerOutput {
    func didLoad() {
        print("<didLoad SignInVC>")
    }
    
    func shouldContinue() {
        output?.continue()
    }
    
}
