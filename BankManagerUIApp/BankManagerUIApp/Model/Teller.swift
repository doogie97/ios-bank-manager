//
//  Teller.swift
//  BankManagerUIApp
//
//  Created by 박세웅 on 2022/05/05.
//

import Foundation

struct Teller {
    func work(for customer: Customer) {
        guard let task = customer.bankingType else {
            return
        }

        print("\(customer.number)번 고객 \(task.rawValue) 시작")
        Thread.sleep(forTimeInterval: task.workTime)
        print("\(customer.number)번 고객 \(task.rawValue) 완료")
    }
}
