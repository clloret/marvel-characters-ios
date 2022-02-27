//
//  ViewControllerProtocol.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

import UIKit

protocol ViewControllerProtocol {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

extension UIViewController: ViewControllerProtocol {}
