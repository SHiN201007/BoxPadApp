//
//  HomeViewModel.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/14.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class HomeViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Output {
        var items: Observable<[SectionBoxItem]>
    }
    
    // MARK: Parameter
    private let _output: HomeViewModel.Output!
    
    private let boxItemsRelay = BehaviorRelay<[SectionBoxItem]>(value: [])
    
    // init
    init() {
        _output = HomeViewModel.Output(
            items: boxItemsRelay.asObservable()
        )
        
        setupSampleBoxItems()
    }
    
    private func setupSampleBoxItems() {
        var sampleItems = [SectionBoxItem]()
        for i in 0..<10 {
            sampleItems.append(
                SectionBoxItem(
                    items: [SectionBoxItem.Item(
                            itemID: "testID",
                            itemImageURL: nil,
                            itemName: "アイテム名：No.\(i)"
                        )
                    ]
                )
            )
        }
        
        boxItemsRelay.accept(sampleItems)
    }
    
    // MARK: OUTPUT
    func output() -> HomeViewModel.Output {
        _output
    }
}
