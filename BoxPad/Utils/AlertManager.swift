//
//  AlertManager.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/14.
//

import Foundation
import UIKit

class AlertManager {
    static func setupAlert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style
        )
        
        actions.forEach {
            alert.addAction($0)
        }
        
        return alert
    }
}
