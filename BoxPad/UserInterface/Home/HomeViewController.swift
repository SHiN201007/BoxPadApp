//
//  HomeViewController.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/13.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bind()
    }
    
    private func configView() {
        title = L10n.titleHomePage
        navigationItem.backButtonTitle = ""
        
        addButton.do {
            $0.layer.cornerRadius = $0.bounds.width / 2
        }
    }
    
    private func bind() {
        addButton.rx.tap
            .bind(to: Binder(self) { me, _ in
                me.navigationController?.pushViewController(AddViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }

}
