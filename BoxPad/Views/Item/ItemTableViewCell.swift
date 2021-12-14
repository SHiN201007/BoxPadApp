//
//  ItemTableViewCell.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/14.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // setup
    func setup(item: SectionBoxItem.Item) {
        itemNameLabel.text = item.itemName
    }
    
}
