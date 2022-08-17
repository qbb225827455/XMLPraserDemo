//
//  NewsTableViewCell.swift
//  XMLParserDemo
//
//  Created by 陳鈺翔 on 2022/8/17.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel:UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
            titleLabel.font = .rounded(size: 22, weight: .bold)
        }
    }
    
    @IBOutlet weak var dateLabel:UILabel! {
        didSet {
            dateLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var descriptionLabel:UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 4
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
