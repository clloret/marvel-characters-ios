//
//  AlertUtilsTests.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import Mockingbird
import XCTest

final class AlertUtilsTests: XCTestCase {
    func test_showErrorAlert_shouldCallViewControllerPresent() {
        let sut = AlertUtils()
        let viewController = mock(ViewControllerProtocol.self)

        sut.showError(in: viewController, with: "Error!")

        verify(viewController.present(any(), animated: any(), completion: any())).wasCalled()
    }
}
