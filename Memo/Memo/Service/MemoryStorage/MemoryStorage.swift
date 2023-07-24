//
//  MemoryStorage.swift
//  Memo
//
//  Created by 김지나 on 2023/07/24.
//
// 메모리 저장소

import Foundation
import RxSwift

class MemoryStorage: MemoStorageType {
    // 옵저버블을 통해 외부로 공개되고 이 배열이 업데이트되면 새로운 next event를 방출
    private var list = [Memo(content: "Hello, RxSwift", insertDate: Date().addingTimeInterval(-10)),
                        Memo(content: "안녕 알엑스스위프트", insertDate: Date().addingTimeInterval(-20))]
    /* 위 list를 그냥 옵저버블로만 만들면 업데이트 상태를 알 수 없으므로, subject로 만들어야 한다. 그리고 초기에 더미데이터를 표시해야하므로, behaviorSubject로 만든다.
     기본값을 list 배열로 선언하기 위해 lazy, 외부에서 직접 접근할 필요 없기 때문에 private으로 */
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    @discardableResult
    func creatMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        // subject에서 새로운 넥스트 이벤트를 방출
        store.onNext(list)
        
        // 새로운 옵저버블 방출
        return Observable.just(memo)
    }
    
    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        
        if let index = list.firstIndex(where: {$0 == memo}) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(updated)
    }
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where: {$0 == memo}) {
            list.remove(at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(memo)
    }
    
    
}
