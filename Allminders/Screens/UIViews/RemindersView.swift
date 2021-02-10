//
//  RemindersView.swift
//  Allminders
//
//  Created by Jonas Gamburg on 06/02/2021.
//

import UIKit

class RemindersView: UIView {

    let categories = ["test", "longerTest", "veryLongTest", "short", "foonai", "chznadar", "heavy sheep"]
    let reminders  = ["Get food", "Do that with this", "Write a new something", "Make dinner for this lady", "Get money from that guy", "Kick this from team", "Find that  treasure", "Buya an Apple", "Conquer the world", "Find some crabs", "Make a lovely painting"]
    
    let largeLabel: UILabel = {
        let label       = UILabel()
        label.text      = "Reminders"
        label.font      = UIFont(name: Font.semibold, size: 40)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoriesLabel: UILabel = {
        let label       = UILabel()
        label.text      = "Categories"
        label.font      = UIFont(name: Font.semibold, size: 24)
        label.textColor = Colors.stoneGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectedCategoryLabel: UILabel = {
        let label       = UILabel()
        label.text      = "<Category>"
        label.font      = UIFont(name: Font.semibold, size: 24)
        label.textColor = Colors.stoneGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.stoneGrey
        view.layer.cornerRadius = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var categoriesCV: UICollectionView!
    
    var remindersCV: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func setUp() {
        configureLargeLabel()
        configureCategoriesLabel()
        configureCategoriesCV()
        configureSelectedCategoryLabel()
        configureRemindersCV()
    }
    
    fileprivate func configureLargeLabel() {
        largeLabel.fix(in: self, toTopWithPadding: 0, andHeight: 50)
    }
    
    fileprivate func configureCategoriesLabel() {
        categoriesLabel.fix(horizontallyIn: self, belowView: largeLabel, withTopPadding: 35)
    }
    
    fileprivate func configureSelectedCategoryLabel() {
        selectedCategoryLabel.fix(horizontallyIn: self, belowView: categoriesCV, withTopPadding: 25)
        separatorView.fix(horizontallyIn: self, belowView: selectedCategoryLabel, withTopPadding: 8, andHeight: 1)
    }
}

extension RemindersView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate func configureCategoriesCV() {
        let layout: UICollectionViewFlowLayout = .init()

        layout.sectionInset          = .init(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize              = .init(width: 50, height: 25)
        layout.scrollDirection       = .horizontal
        categoriesCV                 = .init(frame: frame, collectionViewLayout: layout)
        categoriesCV.tag             = 0
        categoriesCV.register(CategorieCVC.self, forCellWithReuseIdentifier: Cell.cellID)
        categoriesCV.delegate        = self
        categoriesCV.dataSource      = self
        categoriesCV.backgroundColor = .clear
        categoriesCV.showsHorizontalScrollIndicator = false
        categoriesCV.allowsSelection = true
        categoriesCV.fix(horizontallyIn: self, belowView: categoriesLabel, withTopPadding: 0, andHeight: 50)
    }
    
    fileprivate func configureRemindersCV() {
        let layout: UICollectionViewFlowLayout = .init()

        layout.sectionInset          = .init(top: 8, left: 15, bottom: 0, right: 0)
        layout.itemSize              = .init(width: frame.width - 45, height: 50)
        layout.scrollDirection       = .vertical
        remindersCV                  = .init(frame: frame, collectionViewLayout: layout)
        remindersCV.tag              = 1
        remindersCV.register(ReminderCVC.self, forCellWithReuseIdentifier: Cell.cellID)
        remindersCV.delegate        = self
        remindersCV.dataSource      = self
        remindersCV.backgroundColor = .clear
        remindersCV.showsHorizontalScrollIndicator = false
        remindersCV.allowsSelection = true
        remindersCV.fix(in: self, below: separatorView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 0 ? categories.count : reminders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.cellID, for: indexPath) as? CategorieCVC else { return UICollectionViewCell() }
            return configure(cell, for: collectionView.tag, at: indexPath)
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.cellID, for: indexPath) as? ReminderCVC else { return UICollectionViewCell() }
            return configure(cell, for: collectionView.tag, at: indexPath)
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func configure<T>(_ cell: T, for tag: Int, at indexPath: IndexPath) -> T {
        var retCell: T!
        if tag == 0 {
            let cCell = cell as! CategorieCVC
            cCell.backgroundColor = Colors.greenDragon
            cCell.categoryLabel.text = categories[indexPath.row]
            
            let colors = [Colors.deepBlue, Colors.goldStone, Colors.greenDragon, Colors.stoneGrey]
            cCell.backgroundColor = colors.randomElement()
            retCell = cCell as? T
            
        } else {
            let rCell = cell as! ReminderCVC
            rCell.backgroundColor = .clear
            rCell.reminderTitleLabel.text = reminders[indexPath.row]
            retCell = rCell as? T
        }
        
        return retCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            print("<Category selected: \(categories[indexPath.row])>")
            selectedCategoryLabel.text = categories[indexPath.row]
        } else {
            print("<Reminder selected: \(reminders[indexPath.row])")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            let size = getEstimatedFrame(forText: categories[indexPath.row])
            return .init(width: size.width + 15, height: size.height + 15)
        } else {
            return .init(width: frame.width, height: 50)
        }
    }
    
    func getEstimatedFrame(forText text: String) -> CGRect {
        let size = CGSize(width: frame.width / 2, height: 1000)
        return NSString(string: text).boundingRect(with: size, options:  [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], context: nil)
    }
}
