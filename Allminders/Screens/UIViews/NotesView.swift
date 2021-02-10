//
//  NotesView.swift
//  Allminders
//
//  Created by Jonas Gamburg on 06/02/2021.
//

import UIKit

class NotesView: UIView {

    let largeTitle: UILabel = {
        let label       = UILabel()
        label.text      = "Notes"
        label.font      = UIFont(name: Font.semibold, size: 45)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func setUp() {
        configureLargeLabel()
    }
    
    fileprivate func configureLargeLabel() {
        largeTitle.fix(in: self, toTopWithPadding: 0, andHeight: 50)
    }

}
