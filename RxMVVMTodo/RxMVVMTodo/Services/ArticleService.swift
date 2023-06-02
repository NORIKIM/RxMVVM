//
//  ArticleService.swift
//  RxMVVMTodo
//
//  Created by 김지나 on 2023/06/02.
//

import Foundation
import Alamofire
import RxSwift

class ArticleService {
    // RxSwift 사용시
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in
            self.fetchNews { (error, articles) in
                if let error = error {
                    observer.onError(error)
                }
                
                if let articles = articles {
                    observer.onNext(articles)
                }
                
                observer.onCompleted()
                
            }
            return Disposables.create()
        }
    }
    
    // 일반적인 방법인 Alamofire 사용시
    private func fetchNews(completion: @escaping((Error?, [Article]?) -> Void)) {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2023-05-02&sortBy=publishedAt&apiKey=f81a34284b32492abc217ccd10735672"
        guard let url = URL(string:  urlString) else { return completion(NSError(domain: "jinagold.k", code: 404, userInfo: nil), nil) }
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
        .responseDecodable(of: ArticleResponse.self) { response in
            if let error = response.error {
                return completion(error, nil)
            }
            
            if let articles = response.value?.articles {
                return completion(nil, articles)
            }
            
        }
    }
}
