//
//  ViewController.swift
//  News-MVVM
//
//  Created by Noor El-Din Walid on 20/04/2024.
//

import UIKit
import RxCocoa
import RxSwift

class NewsListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet private weak var tableView: UITableView!
    private let cellIdentifier = "Unique-id"
    
    private let viewModel = NewsListViewModel()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupReactiveTableView()
//        setupTableView()
//        viewModel.completionClosure = {[weak self] in
//            self?.tableView.reloadData()
//        }
//        
//        viewModel.errorClosure = {[weak self] error in
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//            label.text = "ERROR: \(String(describing: error))"
//            
//            self?.view.addSubview(label)
//        }
        
        viewModel.fetchNews()
    }
    
    private func setupReactiveTableView() {
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.reactiveArticles.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: CustomTableViewCell.self)) { (row, item, cell) in
            
            cell.setup(title: item.title ?? "")
            
        }.disposed(by: bag)
        
//        viewModel.reactiveArticles.subscribe(onNext: { articlesArray in
//            self.tableView.reloadData()
//        })
//            .disposed(by: bag)
    }

//    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
//    }
}

//extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfArticles()
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
//        
//        let articleViewItem = viewModel.populateTableView(at: indexPath.row)
//        cell.setup(title: articleViewItem?.title ?? "No title")
//        
//        return cell
//    }
//}
