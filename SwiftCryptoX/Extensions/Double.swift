//
//  Double.swift
//  SwiftCryptoX
//
//  Created by Jon Rosenblum on 8/21/23.
//

import Foundation

extension Double {
    
    /// converts a Double into a Currency with 2-6 decimal places
    /// ```
    ///Convert 1234.56 to $1,234.56
    ///Convert 12.3456 to $12.3456
    ///Convert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current // default value
//        formatter.currencyCode = "usd" // chnage currency
//        formatter.currencySymbol = "$" // change symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    
    /// converts a Double into a Currency as a String with 2-6 decimal places
    /// ```
    ///Convert 1234.56 to $1,234.56
    ///Convert 12.3456 to $12.3456
    ///Convert 0.123456 to $0.123456
    /// ```
    
    func asCurrencywith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// converts a Double into a String representation
    /// ```
    ///Convert 1.23456 to "1.23"
    /// ```
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// converts a Double into a String representation with percent symbol
    /// ```
    ///Convert 1.23456 to "1.23%"
    /// ```

    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
