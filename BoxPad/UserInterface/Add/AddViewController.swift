//
//  AddViewController.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/13.
//

import UIKit
import RxSwift
import RxCocoa
import KRProgressHUD

class AddViewController: UIViewController {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var verticalTextField: UITextField!
    @IBOutlet weak var horizontalTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    private var viewModel: AddViewModel!
    private let disposeBag = DisposeBag()
    
    private let imagePicker = UIImagePickerController()
    
    private var itemImageTapGesture: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configViewModel()
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
        // item image
        itemImageTapGesture = UITapGestureRecognizer()
        itemImageView.do {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(itemImageTapGesture)
        }
        // save button
        saveButton.layer.cornerRadius = 10.0
        
        imagePicker.do {
            $0.delegate = self
        }
    }
    
    private func configViewModel() {
        let input = AddViewModel.Input(
            titleText: titleTextField.rx.text.asObservable(),
            verticalText: verticalTextField.rx.text.asObservable(),
            horizontalText: horizontalTextField.rx.text.asObservable(),
            heightText: heightTextField.rx.text.asObservable(),
            widthText: widthTextField.rx.text.asObservable(),
            saveButtonTapped: saveButton.rx.tap.asObservable()
        )
        viewModel = AddViewModel(trigger: input)
    }
    
    private func bind() {
        itemImageTapGesture.rx.event.asObservable()
            .bind(to: Binder(self) { me, _ in
                me.showUsageLibraryAlert()
            })
            .disposed(by: disposeBag)
        
        viewModel.output().isAddSuccsess
            .filter { !$0 }
            .bind(to: Binder(self) { me, _ in
                me.navigationController?.popToRootViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.progressOutput().isLoading
            .bind(to: Binder(self) { me, loadingType in
                loadingType.setup(me)
            })
            .disposed(by: disposeBag)
        
        viewModel.progressOutput().showError
            .bind(to: Binder(self) { me, error in
                KRProgressHUD.showOn(me).showError(withMessage: error)
            })
            .disposed(by: disposeBag)
    }
    
    private func showUsageLibraryAlert() {
        let camera = UIAlertAction(title: L10n.libraryUsageCamera, style: .default) { [weak self] _ in
            self?.showCameraPicker()
        }
        let library = UIAlertAction(title: L10n.libraryUsageLibrary, style: .default) { [weak self] _ in
            self?.showLiberayPicker()
        }
        let close = UIAlertAction(title: L10n.libraryUsageCancel, style: .cancel)
        
        let alert = AlertManager.setupAlert(
            title: L10n.libraryUsageTitle,
            message: L10n.libraryUsageMessage,
            style: .actionSheet,
            actions: [camera, library, close]
        )
        present(alert, animated: true, completion: nil)
    }
    
    private func showLiberayPicker() {
        imagePicker.sourceType = .photoLibrary
        LibraryManager.isLibraryAuthorized { [weak self] status in
            guard let imagePicker = self?.imagePicker else { return }
            if status {
                self?.present(imagePicker, animated: true, completion: nil)
            }else {
                DispatchQueue.main.async {
                    let alert = LibraryManager.setupLibraryAccsessAlert()
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func showCameraPicker() {
        imagePicker.sourceType = .camera
        LibraryManager.isCameraAuthorized { [weak self] status in
            guard let imagePicker = self?.imagePicker else { return }
            if status {
                self?.present(imagePicker, animated: true, completion: nil)
            }else {
                DispatchQueue.main.async {
                    let alert = LibraryManager.setupLibraryAccsessAlert()
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: true) { [weak self] in
                self?.itemImageView.image = selectedImage
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
