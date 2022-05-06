//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 쿼카, 두기 on 2022/04/28.
import Foundation

struct Bank {
    enum Task: CaseIterable {
        case deposit
        case loan
        
        var clerkCount: Int {
            switch self {
            case .deposit:
                return 2
            case .loan:
                return 1
            }
        }
        
        var title: String {
            switch self {
            case .deposit:
                return "예금"
            case .loan:
                return "대출"
            }
        }
    }
    private enum Constant {
        static let customerRange = 1...Int.random(in: 10...30)
        static let empty = ""
    }
    private var customerQueue = Queue<Customer>()
    private var totalCustomerCount = Int.zero
    private var workingTime = Constant.empty
    
    private let depositSemaphore = DispatchSemaphore(value: Task.deposit.clerkCount)
    private let loanSemaphore = DispatchSemaphore(value: Task.loan.clerkCount)
    
    private mutating func receiveCustomer() {
        for number in Constant.customerRange {
            guard let task = Task.allCases.randomElement() else {
                return
            }
            customerQueue.enqueue(newElement: Customer(number: number, task: task))
        }
    }
    
    private mutating func sendCustomerToClerk() {
        let group = DispatchGroup()
        while !customerQueue.isEmpty {
            guard let customer = customerQueue.dequeue() else {
                return
            }
            matchToClerk(customer: customer, group: group)
            totalCustomerCount += 1
        }
        group.wait()
    }
    
    private func matchToClerk(customer: Customer, group: DispatchGroup) {
        switch customer.task {
        case .deposit:
            DispatchQueue.global().async(group: group) {
                depositSemaphore.wait()
                BankClerk.startDepositWork(customer: customer)
                depositSemaphore.signal()
            }
        case .loan:
            DispatchQueue.global().async(group: group) {
                loanSemaphore.wait()
                BankClerk.startLoanWork(customer: customer)
                loanSemaphore.signal()
            }
        }
    }
    
    private mutating func printCloseMessage() {
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(totalCustomerCount)명이며, 총 업무시간은 \(workingTime)초입니다.")
        totalCustomerCount = Int.zero
    }
    
    func timeCheck(_ block: () -> Void) -> String {
        let startTime = CFAbsoluteTimeGetCurrent()
        block()
        let durationTime = CFAbsoluteTimeGetCurrent() - startTime
        return String(format: "%.2f", durationTime)
    }
    
    mutating func openBank() {
        receiveCustomer()
        workingTime = timeCheck {
            sendCustomerToClerk()
        }
        printCloseMessage()
    }
}
