//
//  BankManagerConsoleApp - main.swift
//  Created by Charlotte, Soll. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

enum Menu: String, CustomStringConvertible {
    case open = "1 : 은행 개점"
    case close = "2 : 종료"
    case input = "입력 : "
    
    var description: String {
        return self.rawValue
    }
}

func printMenu() {
    print("\(Menu.open)\n\(Menu.close)")
    print(Menu.input, terminator: "")
}

func readUserInput() -> String? {
    guard let userInput: String = readLine() else {
        return nil
    }
    return userInput
}

func startTask(_ userInput: String?) {
    while userInput == "1" {
        let newbankManager = [BankManager()]
        let bank = Bank(bankManager: newbankManager)
        
        bank.openBank()
        
        readUserInput()
    }
}

startTask(readUserInput())
