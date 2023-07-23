//
//  ArticleVM.swift
//  RxMVVMTodo
//
//  Created by 김지나 on 2023/07/03.
//

import Foundation

struct ArticleVM {
    private let article: Article
    var imageUrl: String? {
        return article.urlToImage
    }
    var title: String? {
        return article.title
    }
    var desciption: String? {
        return article.description
    }
    
    init(article: Article) {
        self.article = article
    }
}
