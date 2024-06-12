//
//  String+.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/11/24.
//

import SwiftUI

extension String {
    /// Localizes a given string
    ///
    /// - Important: variable strings do not get localized with `Text` views.
    /// It's important to add this method to ensure localization.
    var localized: LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
