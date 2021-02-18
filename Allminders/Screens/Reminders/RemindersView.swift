//
//  RemindersView.swift
//  Allminders
//
//  Created by Jonas Gamburg on 06/02/2021.
//

import UIKit

protocol RemindersViewDelegate {
    func addNewReminderTapped()
}

class RemindersView: UIView {
    
    var delegate: RemindersViewDelegate?
    
    fileprivate let categories = ["test", "longerTest", "veryLongTest", "short", "foonai", "chznadar", "heavy sheep"]
    
    fileprivate var selectedCategory: CategoryCVC?
    
    fileprivate var justAddedReminder: Bool = false
    
    fileprivate var firstCategorySelected: Bool = false
    
    fileprivate var prevColor: UIColor!
    
    fileprivate let largeLabel: UILabel = {
        let label       = UILabel()
        label.text      = "Reminders"
        label.font      = UIFont(name: Font.semibold, size: 40)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let addButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: Font.semibold, size: 40)
        button.titleLabel?.textColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = Colors.deepBlue
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let categoriesLabel: UILabel = {
        let label       = UILabel()
        label.text      = "Categories"
        label.font      = UIFont(name: Font.semibold, size: 24)
        label.textColor = Colors.stoneGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let selectedCategoryLabel: UILabel = {
        let label       = UILabel()
        label.text      = "<Category>"
        label.font      = UIFont(name: Font.semibold, size: 24)
        label.textColor = Colors.stoneGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.stoneGrey
        view.layer.cornerRadius = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate var categoriesCV: UICollectionView!
    
    fileprivate var remindersCV: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addButton.layer.roundCorners(to: .rounded)
    }
    
    fileprivate func setUp() {
        configureLargeLabel()
        configureAddButton()
        configureCategoriesLabel()
        configureCategoriesCV()
        configureSelectedCategoryLabel()
        configureRemindersCV()
    }
    
    fileprivate func configureLargeLabel() {
        addSubview(largeLabel)
        NSLayoutConstraint.activate([
            largeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            largeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            largeLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    fileprivate func configureAddButton() {
        addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: largeLabel.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        addButton.addShadow(withOpactiy: 0.1, color: .black, radius: 4, andOffset: .init(width: 0, height: 3))
       
    }
    
    fileprivate func configureCategoriesLabel() {
        categoriesLabel.fix(horizontallyIn: self, belowView: largeLabel, withTopPadding: 35)
    }
    
    fileprivate func configureSelectedCategoryLabel() {
        selectedCategoryLabel.fix(horizontallyIn: self, belowView: categoriesCV, withTopPadding: 25)
        separatorView.fix(horizontallyIn: self, belowView: selectedCategoryLabel, withTopPadding: 8, andHeight: 1)
    }
    
    @objc fileprivate func addButtonTapped(_ sender: UIButton) {
        //delegate?.addNewReminderTapped()
        insert(cellWithString: "newReminder", atIndex: 0)
        startEditingAddedCell(forCells: remindersCV.visibleCells)
    }
    
    fileprivate func insert(cellWithString string: String, atIndex index: Int) {
        Test.reminders.insert(.init(body: string, dateCreated: Date(), category: (selectedCategory?.category)!), at: index)
        remindersCV.reloadData()
        remindersCV.layoutIfNeeded()
        justAddedReminder.toggle()
    }
    
    fileprivate func startEditingAddedCell(forCells cells: [UICollectionViewCell]) {
        for cell in cells {
            if let rCell = cell as? ReminderCVC {
                if rCell.reminderTextField.text == "newReminder" {
                    rCell.reminderTextField.becomeFirstResponder()
                }
            } else {
                return
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
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
        categoriesCV.register(CategoryCVC.self, forCellWithReuseIdentifier: Cell.cellID)
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
        layout.minimumLineSpacing    = 15
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
        return collectionView.tag == 0 ? categories.count : Test.reminders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.cellID, for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
            return configure(cell, for: collectionView.tag, at: indexPath)
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.cellID, for: indexPath) as? ReminderCVC else { return UICollectionViewCell() }
            return configure(cell, for: collectionView.tag, at: indexPath)
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
            if let cell = collectionView.cellForItem(at: indexPath) {
                self.prevColor       = cell.backgroundColor
                cell.transform       = .init(scaleX: 0.90, y: 0.90)
                cell.backgroundColor = Colors.deepBlue
            }
        }, completion: nil)
  
    }
        
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.transform       = .identity
                cell.backgroundColor = self.prevColor
            }
        }
    }
    
    fileprivate func configure<T>(_ cell: T, for tag: Int, at indexPath: IndexPath) -> T {
        var retCell: T!
        if tag == 0 {
            let cCell = cell as! CategoryCVC
            cCell.category = Test.categories[indexPath.row]
            selectFirst(categoryCell: cCell)
            retCell = cCell as? T
            
        } else {
            let rCell = cell as! ReminderCVC
            rCell.reminder = Test.reminders[indexPath.row]
            rCell.initCellColor()
            rCell.backgroundColor = .clear
            retCell = rCell as? T
        }
        
        return retCell
    }
    
    fileprivate func selectFirst(categoryCell cell: CategoryCVC) {
        if !firstCategorySelected {
            cell.layer.borderColor = cell.category.color.cgColor
            cell.categoryLabel.textColor = cell.category.color
            cell.layer.borderWidth = 0.4
            cell.backgroundColor = .white
            cell.didSelect.toggle()
            
            selectedCategoryLabel.text = cell.category.name
            selectedCategory = cell
            #warning("Show all reminders under the selected category")
            firstCategorySelected = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            animate(CategoryCell: collectionView.cellForItem(at: indexPath) as! CategoryCVC)
        } else {
            print("<Reminder selected: \(Test.reminders[indexPath.row].id)")
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
    
    fileprivate func animate(CategoryCell cell: CategoryCVC) {
        if !cell.didSelect {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
                
                if self.selectedCategory != nil {
                    self.selectedCategory?.backgroundColor         = self.selectedCategory?.categoryLabel.textColor
                    self.selectedCategory?.categoryLabel.textColor = .white
                    self.selectedCategory?.layer.borderWidth       = 0
                    self.selectedCategory?.didSelect.toggle()
                }
                
                cell.layer.borderColor = cell.backgroundColor?.cgColor
                cell.categoryLabel.textColor = cell.backgroundColor
                cell.layer.borderWidth = 0.4
                cell.backgroundColor = .white
                cell.didSelect.toggle()
                
                self.selectedCategory = cell
                self.selectedCategoryLabel.text = self.selectedCategory?.categoryLabel.text
                
            }, completion: nil)
        }
    }
    
    fileprivate func getEstimatedFrame(forText text: String) -> CGRect {
        let size = CGSize(width: frame.width / 2, height: 1000)
        return NSString(string: text).boundingRect(with: size, options:  [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], context: nil)
    }
}
