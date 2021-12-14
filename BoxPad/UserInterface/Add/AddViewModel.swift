//
//  AddViewModel.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/14.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt
import Hydra
import KRProgressHUD

class AddViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        var titleText: Observable<String?>
        var verticalText: Observable<String?>
        var horizontalText: Observable<String?>
        var heightText: Observable<String?>
        var widthText: Observable<String?>
        var saveButtonTapped: Observable<Void>
    }
    
    struct Output {
        var isAddSuccsess: Observable<Bool>
    }
    
    // MARK: Parameter
    private let _input: AddViewModel.Input!
    private let _output: AddViewModel.Output!
    private let _progress: ProgressHUD!
    
    private let titleRelay = BehaviorRelay<String>(value: "")
    private let verticalRelay = BehaviorRelay<Int>(value: 0)
    private let horizontalRelay = BehaviorRelay<Int>(value: 0)
    private let heightRelay = BehaviorRelay<Int>(value: 0)
    private let widthRelay = BehaviorRelay<Int>(value: 0)
    private let isSuccsessSubject = PublishSubject<Bool>()
    // progressHUD
    private let isLoadingSubject = PublishSubject<ProgressHUD.loadingType>()
    private let errorSubject = PublishSubject<String>()
    
    // init
    init(trigger: AddViewModel.Input) {
        _input = trigger
        _output = AddViewModel.Output(
            isAddSuccsess: isSuccsessSubject.asObservable()
        )
        _progress = ProgressHUD(
            isLoading: isLoadingSubject.asObservable(),
            showError: errorSubject.asObservable()
        )
        
        bind()
    }
    
    private func bind() {
        // title
        _input.titleText.unwrap()
            .bind(to: titleRelay)
            .disposed(by: disposeBag)
        // vertical
        _input.verticalText.unwrap()
            .map { Int($0) }
            .unwrap()
            .bind(to: verticalRelay)
            .disposed(by: disposeBag)
        // horizontal
        _input.horizontalText.unwrap()
            .map { Int($0) }
            .unwrap()
            .bind(to: horizontalRelay)
            .disposed(by: disposeBag)
        // height
        _input.heightText.unwrap()
            .map { Int($0) }
            .unwrap()
            .bind(to: heightRelay)
            .disposed(by: disposeBag)
        // width
        _input.widthText.unwrap()
            .map { Int($0) }
            .unwrap()
            .bind(to: widthRelay)
            .disposed(by: disposeBag)
            
        
        _input.saveButtonTapped
            .bind(to: Binder(self) { me, _ in
                me.isLoadingSubject.onNext(.load)
                if me.isValidationCheck() {
                    me.addItem().then { _ in
                        // succsess
                        me.isSuccsessSubject.onNext(true)
                        me.isLoadingSubject.onNext(.dismiss)
                    }.catch { error in
                        me.errorSubject.onNext(L10n.addSendError)
                    }
                }else {
                    me.errorSubject.onNext(L10n.addEmptyTitle)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // valid check
    private func isValidationCheck() -> Bool {
        return !titleRelay.value.isEmpty
    }
    
    //
    private func addItem() -> Promise<Void> {
        return Promise<Void>(in: .main) { resolve, reject, _ in
            resolve(())
        }
    }
    
    // MARK: OUTPUT
    func output() -> AddViewModel.Output {
        _output
    }
}

extension AddViewModel: ProgressHUDDelegate {
    func progressOutput() -> ProgressHUD {
        _progress
    }
}
