//
//  DetailViewModel.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/14.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Output {
        
    }
    
    // MARK: Parameter
    private let _output: DetailViewModel.Output!
    
    // init
    init() {
        _output = DetailViewModel.Output()
    }
    
    // MARK: OUTPUT
    func output() -> DetailViewModel.Output {
        _output
    }
}
