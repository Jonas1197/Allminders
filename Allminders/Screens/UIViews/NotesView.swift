//
//  NotesView.swift
//  Allminders
//
//  Created by Jonas Gamburg on 06/02/2021.
//

import UIKit

class NotesView: UIView {

    let largeLabel: UILabel = {
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
        addSubview(largeLabel)
        NSLayoutConstraint.activate([
            largeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            largeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            largeLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}
