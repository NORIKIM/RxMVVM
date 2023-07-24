//
//  Memo.swift
//  Memo
//
//  Created by 김지나 on 2023/07/24.
//

import Foundation

struct Memo: Equatable {
    var content: String
    var inserDate: Date
    var identity: String
    
    init(content: String, inserDate = Date()) {
        self.content = content
        self.inserDate = inserDate
        self.identity = "\(inserDate.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo, updatedContent: String) {
        self = original
        self.content = updatedContent
    }
}
