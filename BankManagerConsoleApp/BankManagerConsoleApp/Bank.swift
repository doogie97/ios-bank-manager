//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by mmim, malrang.
//

import Foundation

struct Bank {
    private var clerks: [Workable] = []
    private var loanClientQueue = Queue(list: LinkedList<Client>())
    private var depositClientQueue = Queue(list: LinkedList<Client>())
    private let operationQueue = OperationQueue()
    
    mutating func executeBankWork() {
        let numberOfClients = receiveClients()
        let totalWorkTime = measureWorkTime {
            serveClients()
        }
        let resultDescription = "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 %d명이며, 총 업무시간은 %.2f입니다."
        let resultMessage = String(format: resultDescription, numberOfClients, totalWorkTime)
        
        print(resultMessage)
    }
    
    @discardableResult
    private mutating func receiveClients() -> Int {
        for order in 1...Int.random(in: 10...30) {
            clientQueue.enqueue(Client(order))
        }
        return clientQueue.count
    }
    
    private func measureWorkTime(_ block: () -> Void) -> Double {
        let start = CFAbsoluteTimeGetCurrent()
        block()
        let interval = CFAbsoluteTimeGetCurrent() - start
        return interval
    }
    
    private mutating func serveClients() {
        while let client = clientQueue.dequeue() {
            executeWork(of: client)
        }
        clerks.wait()
    }
    
    private mutating func executeWork(of client: Client) {
        self.clerksCount.wait()
        
        DispatchQueue.global().async(group: clerks) { [self] in
            if client.requirementType == .loan {
                self.loanClerk.deal(with: client)
            } else if client.requirementType == .deposit {
                self.depositClerk.deal(with: client)
            }
            
            self.clerksCount.signal()
        }
    }
}
