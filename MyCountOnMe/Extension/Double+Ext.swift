//
//  Double+Ext.swift
//  MyCountOnMe
//
//  Created by Raphaël Payet on 20/11/2020.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded()/divisor
    }
}
