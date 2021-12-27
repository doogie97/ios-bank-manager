//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Seul Mac on 2021/12/23.
//

import Foundation

struct Bank {
    
    private var customerQueue: CustomerQueue<Customer>
    private var numberOfCustomer: Int
    private let taskTime: TimeInterval
    
    private var numberOfCustomerRange: ClosedRange<Int> {
        return 1...numberOfCustomer
    }
    private var totalTaskTime: Decimal {
        return Decimal(taskTime) * Decimal(numberOfCustomer)
    }
    
    init(numberOfCustomerRange: ClosedRange<Int> = DefaultValue.numberOfCustomerRange, taskTime: TimeInterval = DefaultValue.taskTimeInterval) {
        self.customerQueue = CustomerQueue()
        self.numberOfCustomer = Int.random(in: numberOfCustomerRange)
        self.taskTime = taskTime
    }
    
    mutating func open() {
        enqueueCustomer()
        operateTask()
        printTaskEndMessage()
        resetBank()
    }
    
    private func enqueueCustomer() {
        for count in numberOfCustomerRange {
            let customer = Customer(turn: count)
            customerQueue.enqueue(data: customer)
        }
    }
    
    private func operateTask() {
        let bankTaskQueue = DispatchQueue(label: "Bank")
        for _ in numberOfCustomerRange {
            bankTaskQueue.sync {
                takeTask()
            }
        }
    }
    
    private func takeTask() {
        do {
            let customer = try customerQueue.dequeue()
            task(of: customer)
        } catch LinkedListError.dataDoesNotExist {
            print(LinkedListError.dataDoesNotExist.description)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func task(of customer: Customer) {
        let number = customer.turn
        print(Message.taskStart(turn: number).description)
        Thread.sleep(forTimeInterval: taskTime)
        print(Message.taskEnd(turn: number).description)
    }
    
    private func printTaskEndMessage() {
        print(Message.totalTaskEnd(count: numberOfCustomer, time: totalTaskTime).description)
    }
    
    private mutating func resetBank() {
        numberOfCustomer = Int.random(in: DefaultValue.numberOfCustomerRange)
        customerQueue.clear()
    }
    
}

private extension Bank {
    
    enum Message {
        case taskStart(turn: Int)
        case taskEnd(turn: Int)
        case totalTaskEnd(count: Int, time: Decimal)
        
        var description: String {
            switch self {
            case .taskStart(let turn):
                return "\(turn)번 고객 업무 시작"
            case .taskEnd(let turn):
                return "\(turn)번 고객 업무 완료"
            case .totalTaskEnd(let count, let time):
                return "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(count)명이며, 총 업무시간은 \(time)초입니다."
            }
        }
    }
    
    struct DefaultValue {
        static let numberOfCustomerRange = 10...30
        static let taskTimeInterval = 0.7
    }
    
}
