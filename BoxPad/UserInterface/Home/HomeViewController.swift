//
//  HomeViewController.swift
//  BoxPad
//
//  Created by 松丸真 on 2021/12/13.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    private var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionBoxItem>(configureCell: configureCell)
    
    private lazy var configureCell: RxTableViewSectionedReloadDataSource<SectionBoxItem>.ConfigureCell = { [weak self] (dataSouce, tableView, indexPath, item) in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellUtil.item.cell, for: indexPath) as! ItemTableViewCell
        
        cell.setup(item: item)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configViewModel()
        bind()
    }
    
    private func configView() {
        title = L10n.titleHomePage
        navigationItem.backButtonTitle = ""
        
        addButton.do {
            $0.layer.cornerRadius = $0.bounds.width / 2
        }
        
        // tableView
        configTableView()
    }
    
    private func configTableView() {
        let nib = UINib(nibName: CellUtil.item.view, bundle: Bundle.main)
        tableView.do {
            $0.register(nib, forCellReuseIdentifier: CellUtil.item.cell)
            $0.tableFooterView = UIView(frame: .zero)
            $0.separatorStyle = .none
            $0.rx.setDelegate(self).disposed(by: disposeBag)
        }
    }
    
    private func configViewModel() {
        viewModel = HomeViewModel()
    }
    
    private func bind() {
        addButton.rx.tap
            .bind(to: Binder(self) { me, _ in
                me.navigationController?.pushViewController(AddViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(to: Binder(self) { me, indexPath in
                me.tableView.deselectRow(at: indexPath, animated: true)
                let item = me.dataSource[indexPath]
                let vc = DetailViewController()
                vc.title = item.itemName
                me.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        // viewModel output
        viewModel.output().items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
