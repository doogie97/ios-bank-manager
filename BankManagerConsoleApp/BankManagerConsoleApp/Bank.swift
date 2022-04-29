//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Lingo, Cathy on 2022/04/29.
//

import Foundation

final class Bank {
  private enum Constants {
    static let closed = "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 %d명이며, 총 업무시간은 %.2f초입니다."
    static let limit = 31
    static let range = 10...30
  }

  private var clientQueue: BankQueue<Client> = BankQueue(limit: .zero)
  private var totalClientCount: Int = .zero
  private var totalExecuteTime: Double = .zero

  func open() {
    clientQueue = createClients(limit: Constants.limit, range: Constants.range)
    totalClientCount = clientQueue.count
    execute()
    close()
  }

  private func createClients(limit: Int, range: ClosedRange<Int>) -> BankQueue<Client> {
    var clientQueue = BankQueue<Client>(limit: limit)
    for waitingNumber in 1...Int.random(in: range) {
      let client = Client(waitingNumber: waitingNumber)
      clientQueue.enqueue(client)
    }
    return clientQueue
  }

  private func execute() {
    while !clientQueue.isEmpty, let client = clientQueue.dequeue() {
      let time = BankTask().execute(client)
      totalExecuteTime += time
    }
  }

  private func close() {
    print(String(format: Constants.closed, totalClientCount, totalExecuteTime))
  }
}
