import Foundation

struct Bank {
    private var loanCustomerQueue = Queue<Customer>()
    private var depositCustomerQueue = Queue<Customer>()
    private let loanBankersCount: Int
    private let depositBankersCount: Int
    private var numberOfCustomers = 0
    
    init(loanBankersCount: Int = 1, depositBankersCount: Int = 2) {
        self.loanBankersCount = loanBankersCount
        self.depositBankersCount = depositBankersCount
    }
    
    mutating func handOutWaitingNumber(from customerNumber: Int) {
        numberOfCustomers = customerNumber
        for number in 1...customerNumber {
            let customer = Customer(waitingNumber: number)
            customerQueue(customer.banking).enqueue(customer)
        }
    }
    
    private func customerQueue(_ banking: Banking) -> Queue<Customer> {
        switch banking {
        case .loan:
            return loanCustomerQueue
        case .deposit:
            return depositCustomerQueue
        }
    }
    
    mutating func openBank() {
        let bankGroup = DispatchGroup()
        let openTime = Date()
        
        workBankers(loanBankersCount, customers: loanCustomerQueue, group: bankGroup)
        workBankers(depositBankersCount, customers: depositCustomerQueue, group: bankGroup)
        
        bankGroup.wait()
        closeBank(numberOfCustomers, from: openTime)
    }
    
    private func workBankers(_ number: Int, customers: Queue<Customer>, group: DispatchGroup) {
        for _ in 1...number {
            workBanker(customers: customers, group: group)
        }
    }
    
    private func workBanker(customers: Queue<Customer>, group: DispatchGroup) {
        let banker = Banker()
        DispatchQueue.global().async(group: group) {
            while let customer = customers.dequeue() {
                banker.work(for: customer)
            }
        }
    }
    
    private mutating func closeBank(_ numberOfCustomers: Int, from openTime: Date) {
        let durationTime = -openTime.timeIntervalSinceNow
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(numberOfCustomers)명이며, 총 업무시간은 \(durationTime.roundedOffDescription(for: 2))초 입니다.")
        self.numberOfCustomers = 0
    }
}
