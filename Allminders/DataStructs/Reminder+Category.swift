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
    var category:    Category
    
    
    init(body: String, dateCreated: Date, category: Category) {
        self.id          = UUID()
        self.body        = body
        self.dateCreated = dateCreated
        self.category    = category
        self.isChecked   = false
    }
    
    func check() {
        isChecked = true
    }
    
    func uncheck() {
        isChecked = false
    }
}


class Category {
    var id:   UUID
    var name: String
    var color: UIColor
    
    init(name: String, color: UIColor) {
        id = UUID()
        self.name = name.capitalizingFirstLetter()
        self.color = color
    }
}
