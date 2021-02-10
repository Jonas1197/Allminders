//
//  ContainerPresenter.swift
//  Allminders
//
//  Created by Jonas Gamburg on 10/02/2021.
//

import Foundation


protocol ContainerPresenterInput: AnyObject {
    
}

protocol ContainerPresenterOutput: AnyObject {
    
}

final class ContainerPresenter {
    
    weak var input: ContainerViewInput?
    weak var output: ContainerPresenterOutput?
    
    init() {
        
    }
    
}

extension ContainerPresenter: ContainerViewOutput {
    func shouldPresentNotesView() {
        
    }
    
}
