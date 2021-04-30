//
//  BankManagerTests.swift
//  BankManagerTests
//
//  Created by Yun, Ryan on 2021/04/27.
//

import XCTest
@testable import BankManagerConsoleApp

final class BankManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testMakeClients_whenClientNumberLessThanOne_returnEmptyArray() {
        var sutBank: Bank = Bank()
        
        for lessThanOne in -1...0 {
            XCTAssertEqual(sutBank.makeClients(number: lessThanOne), [])
        }
    }
    
    func testMakeClients_whenClientNumberIsMoreThanOne_returnClientsWithWaitingNumber() {
        var sutBank: Bank = Bank()
        let sutClients: [Client] = sutBank.makeClients(number: 3)
        
        XCTAssertEqual(sutClients.count, 3)
        
        for index in 0...2 {
            XCTAssertEqual(sutClients[index].waitingNumber, index + 1)
        }
    }
    
//    func testClose_whenProcessedTimeHasMoreThanTwoDecimalPlaces_checksResultHasTwoDecimalPlaces() {
//        var sutBank: Bank = Bank(numberOfTeller: 1)
//
//        sutBank.        total:processedTime = 123.56789
//        XCTAssertEqual(sutBank.close(), 123.56)
//    }
    
//    func testTotalProcessedTime_whenGivenProcessingTime_checksGivenValueAndCalculatedResultAreSame() {
//        let sutBank: Bank = Bank(numberOfTeller: 1)
//        let sleepTime: Double = sutBank.processedTime {
//            Thread.sleep(forTimeInterval: 0.01)
//        }
//        
//        XCTAssertEqual(floor(sleepTime * 100) / 100, 0.01)
//    }
}
