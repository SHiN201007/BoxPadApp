//
//  CellUtil.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/14.
//

import Foundation

enum CellUtil {
    case item
    
    var view: String {
        switch self {
        case .item:
            return "ItemTableViewCell"
        }
    }
    
    var cell: String {
        switch self {
        case .item:
            return "ItemCell"
        }
    }
}
