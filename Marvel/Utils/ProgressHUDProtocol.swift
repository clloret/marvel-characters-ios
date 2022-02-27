//
//  ProgressHUDProtocol.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

import SVProgressHUD

protocol ProgressHUDProtocol {
    func show(withStatus: String)
    func dismiss()
}
