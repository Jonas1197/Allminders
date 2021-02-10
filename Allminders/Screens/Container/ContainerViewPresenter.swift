//
//  ContainerViewPresenter.swift
//  Allminders
//
//  Created by Jonas Gamburg on 10/02/2021.
//

import Foundation

final class ContainerViewPresenter {
    
    weak var coordinator: MainCoordinator?
    
    weak var input: ContainerViewInput?
    
    init() {
        
    }
    
}

extension ContainerViewPresenter: ContainerViewOutput {
    
    
    func shouldPresentNotesView() {
        
    }
    
    
}
