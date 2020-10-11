//
//  NewsImageView.swift
//  My news
//
//  Created by Stanislav Slipchenko on 12.10.2020.
//

import UIKit

class NewsImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup(){
        self.frame = bounds

        self.layer.masksToBounds = false

        self.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
}
