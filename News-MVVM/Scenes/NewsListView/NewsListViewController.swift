//
//  ViewController.swift
//  News-MVVM
//
//  Created by Noor El-Din Walid on 20/04/2024.
//

import UIKit
import Combine

class NewsListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let cellIdentifier = "Unique-id"
    
    private let viewModel = NewsListViewModel()
    private var bagCombine = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTableView()
        setupReactiveTableView()
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
//        
        //You don't need to call this here, call it in the ViewModel init.
//        viewModel.fetchNews()
    }
    
    private func setupReactiveTableView() {
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.reactiveArticlesCombine.sink { error in
            print(error)
        } receiveValue: { articles in
            self.tableView.reloadData()
        }
        .store(in: &bagCombine)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        let articleViewItem = viewModel.populateTableView(at: indexPath.row)
        cell.setup(title: articleViewItem?.title ?? "No title")
        
        return cell
    }
}
