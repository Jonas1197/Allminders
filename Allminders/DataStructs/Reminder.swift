//
//  Reminder.swift
//  Allminders
//
//  Created by Jonas Gamburg on 18/02/2021.
//

import UIKit

class Reminder {
    
    var id:          UUID
    var body:        String
    var dateCreated: Date
    var isChecked:   Bool
    
    
    init(body: String, dateCreated: Date) {
        self.id          = UUID()
        self.body        = body
        self.dateCreated = dateCreated
        self.isChecked   = false
    }
    
    func check() {
        isChecked = true
    }
    
    func uncheck() {
        isChecked = false
    }
}
