//
//  TabbarUtil.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/13.
//

import Foundation
import UIKit

enum TabbarUtil {
    case home
    
    var vc: UIViewController {
        switch self {
        case .home:
            return HomeViewController()
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "HOME"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home:
            return nil
        }
    }
    
    var tag: Int {
        switch self {
        case .home:
            return 0
        }
    }
}
