//
//  ItemModel.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/14.
//

import Foundation
import RxDataSources

struct BoxItem {
    var itemID: String
    var itemImageURL: URL?
    var itemName: String
}

struct SectionBoxItem {
  var items: [Item]
}
extension SectionBoxItem: SectionModelType {
  typealias Item = BoxItem

  init(original: SectionBoxItem, items: [SectionBoxItem.Item]) {
    self = original
    self.items = items
  }
}
