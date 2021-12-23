//
//  BankManagerConsoleAppTests.swift
//  BankManagerConsoleAppTests
//
//  Created by Seul Mac on 2021/12/21.
//

import XCTest

class CustomerQueueTests: XCTestCase {
    
    var sutCustomerQueue: CustomerQueue<Int>!

    override func setUp() {
        sutCustomerQueue = CustomerQueue<Int>()
    }

    override func tearDown() {
        sutCustomerQueue = nil
    }
    
    func enqueueTestElements(_ elements: [Int]) {
        elements.forEach{ sutCustomerQueue.enqueue(data: $0) }
    }
    
    func test_1_2_3을_enqueue_한_후에_dequeue_하면_1을_반환해야한다() {
        enqueueTestElements([1, 2, 3])
        
        do {
            let result = try sutCustomerQueue.dequeue()
            XCTAssertEqual(result, 1)
        } catch LinkedListError.dataDoesNotExist {
            XCTFail(LinkedListError.dataDoesNotExist.description)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_9_10_11을_enqueue_한_후에_dequeue_두번_하면_10을_반환해야한다() {
        enqueueTestElements([9, 10, 11])
        
        do {
            let _ = try sutCustomerQueue.dequeue()
            let result = try sutCustomerQueue.dequeue()
            XCTAssertEqual(result, 10)
        } catch LinkedListError.dataDoesNotExist {
            XCTFail(LinkedListError.dataDoesNotExist.description)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_11을_enqueue_한_후에_dequeue_하면_비어있어야한다() {
        enqueueTestElements([11])
        
        do {
            let _ = try sutCustomerQueue.dequeue()
        } catch LinkedListError.dataDoesNotExist {
            XCTFail(LinkedListError.dataDoesNotExist.description)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        let result = sutCustomerQueue.isEmpty
        XCTAssertTrue(result)
    }
    
    func test_CustomerQueue가_비어있을때_dequeue_하면_오류를_던져야한다() {
        XCTAssertThrowsError(try sutCustomerQueue.dequeue())
    }
    
    func test_9_10_11을_enqueue_한_후에_peek하면_9를_반환해야한다() {
        enqueueTestElements([9, 10, 11])
        
        do {
            let result = try sutCustomerQueue.peek()
            XCTAssertEqual(result, 9)
        } catch LinkedListError.dataDoesNotExist {
            XCTFail(LinkedListError.dataDoesNotExist.description)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_CustomerQueue가_비어있을때_peek하면_오류를_던져야한다() {
        XCTAssertThrowsError(try sutCustomerQueue.peek())
    }
    
    func test_CustomerQueue가_비어있을때_isEmpty는_true를_반환해야한다() {
        let result = sutCustomerQueue.isEmpty
        XCTAssertTrue(result)
    }
    
    func test_CustomerQueue가_비어있지않을때_isEmpty는_false를_반환해야한다() {
        enqueueTestElements([9, 10, 11])
        
        let result = sutCustomerQueue.isEmpty
        XCTAssertFalse(result)
    }
    
    func test_CustomerQueue에_clear하면_빈_queue가_되어야한다() {
        enqueueTestElements([9, 10, 11])
        sutCustomerQueue.clear()
        
        let result = sutCustomerQueue.isEmpty
        XCTAssertTrue(result)
    }
}
