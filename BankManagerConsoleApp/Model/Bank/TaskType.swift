//
//  WorkType.swift
//  BankManagerConsoleApp
//
//  Created by 우롱차, 민성 on 2022/05/04.
//

import Foundation

enum TaskType: CaseIterable {
    case deposit
    case loan

    var text: String {
        switch self {
        case .deposit:
            return "예금"
        case .loan:
            return "대출"
        }
    }
}
