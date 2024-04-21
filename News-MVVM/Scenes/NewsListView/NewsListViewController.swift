//
//  ViewController.swift
//  News-MVVM
//
//  Created by Noor El-Din Walid on 20/04/2024.
//

import UIKit

class NewsListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let cellIdentifier = "Unique-id"
    
    private let viewModel = NewsListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.completionClosure = {[weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.errorClosure = {[weak self] error in
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            label.text = "ERROR: \(String(describing: error))"
            
            self?.view.addSubview(label)
        }
        
        viewModel.fetchNews()
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
