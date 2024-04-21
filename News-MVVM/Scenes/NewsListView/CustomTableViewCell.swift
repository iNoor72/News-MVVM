//
//  CustomTableViewCell.swift
//  News-MVVM
//
//  Created by Noor El-Din Walid on 21/04/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(title: String) {
        titleLabel.text = title
    }
    
}
