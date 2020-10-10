//
//  MainTableViewCell.swift
//  My news
//
//  Created by Stanislav Slipchenko on 09.10.2020.
//

import UIKit

class MainTableViewCell: UITableViewCell {
  
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageOfNews: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        imageOfNews.image = nil
        descriptionLabel.text = nil
        authorNameLabel.text = nil
        dateLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
