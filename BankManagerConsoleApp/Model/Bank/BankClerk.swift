//
//  BankClerk.swift
//  BankManagerConsoleApp
//
//  Created by 우롱차, 민성 on 2022/04/28.
//

import Foundation

protocol BankDelegate: AnyObject {
    func updateWorkData()
}

private enum Constant {
    static let startWorkMessageFormat = "%d번 고객 %@업무 시작"
    static let finishedWorkMessageFormat = "%d번 고객 %@업무 완료"
}

protocol BankClerk {
    var spendingTimeForClient: Double { get }
    var delegate: BankDelegate? { get set }

    func work(client: Client)
}

extension BankClerk {
    func work(client: Client) {
        print(String(format: Constant.startWorkMessageFormat, client.waitingNumber, client.taskType.text))
        let usecondsTimeForAClient = useconds_t(spendingTimeForClient * 1000000)
        usleep(usecondsTimeForAClient)
        delegate?.updateWorkData()
        print(String(format: Constant.finishedWorkMessageFormat, client.waitingNumber, client.taskType.text))
    }
}
