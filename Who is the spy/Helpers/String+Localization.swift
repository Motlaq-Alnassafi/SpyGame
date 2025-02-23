//
//  String+Localization.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 23/02/2025.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

