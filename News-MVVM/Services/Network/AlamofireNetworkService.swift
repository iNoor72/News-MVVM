//
//  AlamofireNetworkService.swift
//  News-MVVM
//
//  Created by Noor El-Din Walid on 21/04/2024.
//

import Foundation
import Alamofire

final class AlamofireNetworkService {
    func fetchCNNNews(completion: @escaping (Result<NewsResponse, AFError>) -> Void) {
        guard let url = URL(string: AppConstants.newsURL) else {
            //handle error
            return
        }
        let request = URLRequest(url: url)
        
        AF.request(request).validate().responseDecodable(queue: .global()) {
            (response: DataResponse<NewsResponse, AFError>) in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(.failure(error))
                
            case .success(let newsResponse):
                completion(.success(newsResponse))
            }
        }
    }
}
