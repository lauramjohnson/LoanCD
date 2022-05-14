//
//  Double+Ext.swift
//  LoanCD
//


import Foundation

extension Double {
    var toCurrency: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        
        currencyFormatter.maximumFractionDigits = 0
        currencyFormatter.numberStyle = .currency
        
        currencyFormatter.locale = Locale.current
        
        let currencyString = currencyFormatter.string(from: NSNumber(value: self))!
        
        return currencyString
    }
}
