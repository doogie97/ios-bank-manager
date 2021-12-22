import Foundation

struct BankClerk {
    private let workSpeed: TimeInterval
    
    init(workSpeed: TimeInterval) {
        self.workSpeed = workSpeed
    }
    
    func work(for customer: Customer) {
        print("\(customer.waitingNumber)번 고객 업무 시작")
        Thread.sleep(forTimeInterval: workSpeed)
        print("\(customer.waitingNumber)번 고객 업무 완료")
    }
}
