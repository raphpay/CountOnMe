//
//  Double+Ext.swift
//  MyCountOnMe
//
//  Created by Raphaël Payet on 20/11/2020.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        // This function round a number to a certain decimal.
        // It multiplies the double by 100, round it, then divide it again by 100.
        return ( self * 100).rounded()/100
    }
}
