//
//  String+Extensions.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
