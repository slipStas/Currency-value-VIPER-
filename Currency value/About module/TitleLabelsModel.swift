//
//  TitleLabelsModel.swift
//  Currency value
//
//  Created by Stanislav Slipchenko on 07.10.2020.
//

import Foundation

protocol TitleLabelsModelProtocol: class {
    var descriptionTitle: String {get}
    var thanksTitle: String {get}
}

class TitleLabelModel: TitleLabelsModelProtocol {
    var descriptionTitle: String {
        return "This is a free news getter"
    }
    
    var thanksTitle: String {
        return "Special thanks for news to"
    }
}
