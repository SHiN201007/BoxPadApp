//
//  ProgressHUD.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/14.
//

import Foundation
import RxSwift
import RxCocoa
import KRProgressHUD

struct ProgressHUD {
    enum loadingType {
        case load
        case dismiss
        
        func setup(_ me: UIViewController) {
            switch self {
            case .load:
                KRProgressHUD.showOn(me).show()
            case .dismiss:
                KRProgressHUD.showOn(me).dismiss()
            }
        }
    }
    
    var isLoading: Observable<loadingType>
    var showError: Observable<String>
}


protocol ProgressHUDDelegate {
    func progressOutput() -> ProgressHUD
}
