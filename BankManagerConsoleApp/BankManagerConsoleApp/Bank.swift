//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 고은 on 2021/12/24.
//

import Foundation

protocol WaitingLineManageable {
    var waitingLine: Queue<Customer> { get }
}

class Bank: WaitingLineManageable  {
    private weak var employee: Employee?
    private weak var bankManager: BankManager?
    let waitingLine = Queue<Customer>()

    init(employee: Employee, bankManager: BankManager) {
        self.employee = employee
        self.bankManager = bankManager
        self.employee?.bank = self
        self.bankManager?.bank = self
    }
    
    func open() {
        bankManager?.work()
    }
}
