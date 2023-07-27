//
//  TransitionModel.swift
//  Memo
//
//  Created by 김지나 on 2023/07/25.
//

import Foundation

enum TransitionStyle {
    case root // 첫번째 화면 표시
    case push // 새로운 화면을 네비게이션 스택에 푸시
    case modal // 새로운 화면을 모달 형태로 표시
}

enum TransitionError: Error {
    case navigationControllerMissing // 네비게이션 컨트롤러가 없을 때
    case cannotPop // 네비게이션 스택에 추가되어 있는 뷰컨트롤러를 pop 할 수 없을 때
    case unKnown // 에러의 종류를 알 수 없을 때
}
