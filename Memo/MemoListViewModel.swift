//
//  MemoListViewModel.swift
//  Memo
//
//  Created by 김지나 on 2023/07/24.
//

// 메모 목록 화면에서 사용

import Foundation
import RxSwift
import RxCocoa

class MemoListViewModel: CommonViewModel {
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
}
