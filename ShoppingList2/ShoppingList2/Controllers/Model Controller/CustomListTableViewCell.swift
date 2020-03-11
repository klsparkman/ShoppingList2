//
//  CustomListTableViewCell.swift
//  ShoppingList2
//
//  Created by Kelsey Sparkman on 3/10/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

import UIKit
import CoreData

protocol CustomListTableViewCellDelegate: class {
    func buttonTapped(_ sender: CustomListTableViewCell)
    func updateButton(_ sender: CustomListTableViewCell)
}
class CustomListTableViewCell: UITableViewCell {
    
    weak var delegate: CustomListTableViewCellDelegate?
    
   
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonTapped(self)
    }
    
    
    fileprivate func updateViews(_ isComplete: Bool) {
        completeButton.setImage(isComplete ? #imageLiteral(resourceName: "complete") : #imageLiteral(resourceName: "incomplete"), for: .normal)
    }
    func update(list: List) {
        updateViews(list.isComplete)
    }
}
