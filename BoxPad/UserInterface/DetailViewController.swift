//
//  DetailViewController.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/14.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    private var viewModel: DetailViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bind()
    }
    
    private func configView() {
        
    }
    
    private func bind() {
        
    }

}
