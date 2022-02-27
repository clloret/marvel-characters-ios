//
//  ProgressHUD.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

import SVProgressHUD

final class ProgressHUD: ProgressHUDProtocol {
    func show(withStatus: String) {
        SVProgressHUD.show(withStatus: withStatus)
    }

    func dismiss() {
        SVProgressHUD.dismiss()
    }
}
