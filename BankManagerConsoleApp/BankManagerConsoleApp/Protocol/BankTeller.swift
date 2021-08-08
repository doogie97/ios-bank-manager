//
//  BankTeller.swift
//  BankManagerConsoleApp
//
//  Created by 홍정아 on 2021/07/30.
//

import Foundation

protocol BankTeller {
    var duty: BankingCategory { get }
    
    func serve(customer: Customer)
}
