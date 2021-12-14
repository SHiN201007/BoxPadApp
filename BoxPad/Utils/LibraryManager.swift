//
//  LibraryManager.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/14.
//

import Foundation
import UIKit
import Photos

class LibraryManager {
    static func isLibraryAuthorized(hundler: @escaping(Bool) -> Void) {
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization { status in
                let isAuthorized = status == .authorized ? true : false
                hundler(isAuthorized)
            }
        }else {
            hundler(true)
        }
    }
    
    static func setupLibraryAccsessAlert() -> UIAlertController {
        let settingButton = UIAlertAction(
            title: L10n.libraryAccsessSettingButton,
            style: .default
        ) { action in
            if let settingURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.canOpenURL(settingURL)
                UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
            }
        }
        
        let closeButton = UIAlertAction(
            title: L10n.libraryAccsessCloseButton,
            style: .cancel
        )
        
        return AlertManager.setupAlert(
            title: L10n.libraryAccsessTitle,
            message: L10n.libraryAccsessMessage,
            style: .alert,
            actions: [settingButton, closeButton]
        )
    }
    
}
