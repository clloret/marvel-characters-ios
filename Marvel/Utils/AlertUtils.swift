//
//  AlertUtils.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

import UIKit

final class AlertUtils: AlertUtilsProtocol {
    func showError(in viewController: ViewControllerProtocol, with message: String?) {
        let alert = UIAlertController(title: "Error".localized, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "OK".localized, style: .default)
        )
        viewController.present(alert, animated: true, completion: nil)
    }
}
