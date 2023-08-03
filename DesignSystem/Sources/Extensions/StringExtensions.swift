//
//  StringExtensions.swift
//  Kabum
//
//  Created by João Pedro Mata on 06/06/23.
//

import Foundation

extension String {
    public func toCurrency() -> String? {
        guard let myDouble = Double(self) else { return nil }
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current

        guard let priceString = currencyFormatter.string(from: NSNumber(value: myDouble)) else { return nil }
        return priceString
    }
}
