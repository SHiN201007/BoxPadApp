//
//  AddViewController.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/13.
//

import UIKit
import RxSwift
import RxCocoa

class AddViewController: UIViewController {
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configView() {
        title = L10n.titleAddPage
    }
    
    private func bind() {
        
    }

}
