//
//  AlertHelperClass.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/21/21.
//

import Foundation

class AlertProvider {
    struct Alert {
        var title: String
        let message: String
        let primaryButtomText: String
        let primaryButtonAction: () -> Void
        let secondaryButtonText: String
    }

    @Published var shouldShowAlert = false

    var alert: Alert? = nil { didSet { shouldShowAlert = alert != nil } }
}
