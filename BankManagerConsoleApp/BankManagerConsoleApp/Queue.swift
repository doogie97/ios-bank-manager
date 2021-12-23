//
//  Queue.swift
//  BankManagerConsoleApp
//
//  Created by 양호준 on 2021/12/21.
//

import Foundation

struct Queue<Type> {
    var queue: LinkedList<Type>
    
    var isEmpty: Bool {
        queue.isEmpty
    }
    
    func peek() -> Type? {
        queue.peek()
    }
    
    mutating func clear() {
        queue.removeAll()
    }
    
    mutating func enqueue(_ data: Type) {
        queue.append(data)
    }
    
    mutating func dequeue() {
        queue.removeFirst()
    }
}
