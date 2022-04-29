//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 허윤영 on 27/04/2022.
//

import Foundation

fileprivate extension Constants {
    static let decimalPlace = "%.2f"
}

final class Bank: Presentable {
    private let clientQueue = Queue<Client>()
    private let bankClerk: BankClerk
    private let clientCount: Int
    
    init(bankClerk: BankClerk, clientCount: Int) {
        self.bankClerk = bankClerk
        self.clientCount = clientCount
    }
    
    func open() {
        receiveClients()
        
        let totalWorkTime = measureTotalWorkTime {
            bankClerk.work(clientQueue)
        }
        
        close(totalWorkTime: totalWorkTime)
    }
    
    private func receiveClients() {
        for order in 1 ... clientCount {
            clientQueue.enqueue(Client(waitingNumber: order))
        }
    }
    
    private func measureTotalWorkTime(_ task: () -> Void) -> String {
        let startTime = CFAbsoluteTimeGetCurrent()
        task()
        let finishTime = CFAbsoluteTimeGetCurrent()
        let totalTime = finishTime - startTime
        
        return totalTime.formatted
    }
    
    private func close(totalWorkTime: String) {
        printClosingMessage(clientCount: clientCount, totalWorkTime: totalWorkTime)
    }
}

fileprivate extension CFAbsoluteTime {
    var formatted: String {
        String(format: Constants.decimalPlace, self)
    }
}
