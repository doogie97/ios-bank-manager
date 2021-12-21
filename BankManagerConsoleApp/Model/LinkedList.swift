import Foundation

class LinkedList<Element> {
    class ListNode<Element> {
        private(set) var value: Element
        var next: ListNode?
        
        init(value: Element) {
            self.value = value
        }
    }
    
    typealias Node = ListNode<Element>
    
    var head: Node?
    var tail: Node? {
        var finderToTail: Node? = head
        
        while let nextNode = finderToTail?.next {
            finderToTail = nextNode
        }
        
        return finderToTail
    }
    var isEmpty: Bool {
        return head == nil
    }
    
    init(value: Element?) {
        if let value = value {
            self.head = Node(value: value)
        }
    }
    
    func append(value: Element) {
        let newNode = Node(value: value)
        
        if isEmpty {
            head = newNode
        } else {
            tail?.next = newNode
        }
    }
    
    func removeFirst() -> Element? {
        if isEmpty { return nil }
        
        let valueToRemove = head?.value
        head = head?.next
        
        return valueToRemove
    }
    
    func removeAll() {
        head = nil
    }
    
    func scanAllValues() -> [Element] {
        var scanResult: [Element] = []
        
        guard var finderToTail = head else { return scanResult }

        scanResult.append(finderToTail.value)

        while let nextNode = finderToTail.next {
            scanResult.append(nextNode.value)
            finderToTail = nextNode
        }
        
        return scanResult
    }
}


