import Foundation

struct Bank {
    // MARK: - Properties
    private var bankClerk: DispatchQueue = DispatchQueue(label: "customSerial")
    private var customers: CustomerQueue = CustomerQueue<Customer>()
    private var numberOfCustomer: Int = 0
    private let dispatchGroup = DispatchGroup()
    
    // MARK: - Initalizer
    init(numberOfBankClerk: Int, numberOfCustomer: Int) {
        instantiateCustomers(of: numberOfCustomer)
        self.numberOfCustomer = numberOfCustomer
    }
    
    // MARK: - Methods
    private func instantiateCustomers(of number: Int) {
         for index in 0..<number {
             let customer = Customer(number: (index + 1))
             customers.enqueue(value: customer)
         }
     }
    
    func openBank() {
        dispatchGroup.enter()
        let totalTime = checkTotalTime(of: handleTaskOfAllCustomers)
        dispatchGroup.leave()
        
        dispatchGroup.wait()
        notifyBankClosing(with: totalTime)
    }
    
    private func checkTotalTime(of taskFunction: () -> Void) -> String {
        let startTime = CFAbsoluteTimeGetCurrent()
        taskFunction()
        let totalTime = CFAbsoluteTimeGetCurrent() - startTime
        let totalTimeInString: String = String(format: "%.2f", totalTime)

        return totalTimeInString
    }
    
    private func handleTaskOfAllCustomers() {
        let taskItem = DispatchWorkItem {
            if let currentCustomer = customers.peek {
                workOnTask(of: currentCustomer)
            }
        }
        
        for _ in 0..<numberOfCustomer {
            bankClerk.sync(execute: taskItem)
        }
    }
    
    private func workOnTask(of customer: Customer) {
        notifyStartingTask(of: customer)
        customer.task()
        notifyFinisingTask(of: customer)
        
        do {
            try customers.dequeue()
        } catch {
            print(error)
        }
    }
    
    private func notifyStartingTask(of customer: Customer) {
        print("\(customer.number)번 고객 업무 시작")
    }
    
    private func notifyFinisingTask(of customer: Customer) {
        print("\(customer.number)번 고객 업무 완료")
    }
    
    private func notifyBankClosing(with totalTime: String) {
        print("업무가 마감되었습니다, 오늘 업무를 처리한 고객은 총 \(numberOfCustomer)명이며, 총 업무시간은 \(totalTime)초 입니다.")
    }
}
