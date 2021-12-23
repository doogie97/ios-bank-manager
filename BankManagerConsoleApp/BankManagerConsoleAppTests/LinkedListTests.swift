//
//  LinkedListTests.swift
//  LinkedListTests
//
//  Created by JeongTaek Han on 2021/12/20.
//

import XCTest

class LinkedListTests: XCTestCase {
    
    var sutLinkedList: LinkedList<Int>!

    override func setUp() {
        sutLinkedList = LinkedList()
    }

    override func tearDown() {
        sutLinkedList = nil
    }
    
    func appendTestElements(_ elements: [Int]) {
        elements.forEach{ sutLinkedList.append(data: $0) }
    }

    func test_1_2_3을_append_한_후에_removeFirst_하면_1을_반환해야한다() {
        appendTestElements([1, 2, 3])
        
        do {
            let result = try sutLinkedList.removeFirst()
            XCTAssertEqual(result, 1)
        } catch LinkedListError.dataDoesNotExist {
            XCTFail(LinkedListError.dataDoesNotExist.description)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_4_5_6을_append_한_후에_removeFirst_두번_하면_5를_반환해야한다() {
        appendTestElements([4, 5, 6])
        
        do {
            let _ = try sutLinkedList.removeFirst()
            let secondResult = try sutLinkedList.removeFirst()
            XCTAssertEqual(secondResult, 5)
        } catch LinkedListError.dataDoesNotExist {
            XCTFail(LinkedListError.dataDoesNotExist.description)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_11을_append_한_후에_removeFirst_하면_비어있어야한다() {
        appendTestElements([11])
        
        do {
            let _ = try sutLinkedList.removeFirst()
        } catch LinkedListError.dataDoesNotExist {
            XCTFail(LinkedListError.dataDoesNotExist.description)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        let result = sutLinkedList.isEmpty
        XCTAssertTrue(result)
    }
    
    func test_7_8_9_append_한_후에_firstData를_호출하면_7을_반환해야한다() {
        appendTestElements([7, 8, 9])
        
        do {
            let firstData = try sutLinkedList.firstData()
            XCTAssertEqual(firstData, 7)
        } catch LinkedListError.dataDoesNotExist {
            XCTFail(LinkedListError.dataDoesNotExist.description)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_LinkedList가_비어있을때_isEmpty는_true를_반환해야한다() {
        let isEmpty = sutLinkedList.isEmpty
        XCTAssertTrue(isEmpty)
    }
    
    func test_LinkedList가_비어있지않을때_isEmpty는_false를_반환해야한다() {
        appendTestElements([7, 8, 9])
        
        let isEmpty = sutLinkedList.isEmpty
        XCTAssertFalse(isEmpty)
    }
    
    func test_LinkedList가_비어있을때_dequeue_하면_오류를_반환해야한다() {
        XCTAssertThrowsError(try sutLinkedList.removeFirst())
    }
    
}
