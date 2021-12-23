//
//  CustomerQueue.swift
//  BankManagerConsoleApp
//
//  Created by JeongTaek Han on 2021/12/21.
//

import Foundation

struct CustomerQueue<Element> {
    
    private var linkedList = LinkedList<Element>()
    
    func enqueue(data: Element) {
        linkedList.append(data: data)
    }
    
    func dequeue() throws -> Element {
        let dequeuedData = try linkedList.removeFirst()
        return dequeuedData
    }
    
    func peek() throws -> Element {
        let firstData = try linkedList.firstData()
        return firstData
    }
    
    mutating func clear() {
        linkedList = LinkedList<Element>()
    }
    
    var isEmpty: Bool {
        return linkedList.isEmpty
    }
    
}
