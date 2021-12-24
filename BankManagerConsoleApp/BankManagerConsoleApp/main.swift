//
//  BankManagerConsoleApp - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

fileprivate func printMenu() {
    print(Menu.initialMessage, terminator: " ")
}

fileprivate func receiveInput() -> String {
    guard let input = readLine() else {
        return Menu.Option.invalidInput
    }
    
    return input
}

fileprivate func runMenu(with input: String) {
    var bankManager = BankManager(clerkNumber: 1)

    switch input {
    case Menu.Option.open:
        bankManager.operateBankSystem()
        printMenu()
        runMenu(with: receiveInput())
    case Menu.Option.close:
        return
    default:
        print(Menu.Error.wrongInput)
        printMenu()
        runMenu(with: receiveInput())
    }
}

printMenu()
runMenu(with: receiveInput())
