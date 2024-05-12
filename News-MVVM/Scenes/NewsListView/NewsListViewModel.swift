//
//  NewsListViewModel.swift
//  News-MVVM
//
//  Created by Noor El-Din Walid on 21/04/2024.
//

import Foundation
import Combine

//final is related to Static & Dynamic dispatch
final class NewsListViewModel {
    private let network: AlamofireNetworkService
    private var articles: [Article] = []
    
    var reactiveArticlesCombine = PassthroughSubject<[Article], NSError>()
    
    var completionClosure: (() -> ())?
    var errorClosure: ((String?) -> ())?
    
    init(network: AlamofireNetworkService = AlamofireNetworkService()) {
        self.network = network
        fetchNews()
    }
    
    func fetchNews() {
        network.fetchCNNNews { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .failure(let error):
                if let errorClosure = self.errorClosure {
                    errorClosure(error.localizedDescription)
                }
                
            case .success(let newsResponse):
                self.articles = newsResponse.articles ?? []
                self.reactiveArticlesCombine.send(newsResponse.articles ?? [])
                DispatchQueue.main.async {
                    if let completionClosure = self.completionClosure {
                        completionClosure()
                    }
                }
            }
        }
    }
    
    func numberOfArticles() -> Int {
        articles.count
    }
    
    func populateTableView(at index: Int) -> ArticleViewItem? {
        let article = articles[index]
        let viewItem = ArticleViewItem(title: article.title ?? "No title!")
        return viewItem
    }
}

struct ArticleViewItem {
    let title: String
}
