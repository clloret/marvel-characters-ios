//
//  BaseWireframeTests.swift
//  MarvelTests
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import Mockingbird
import XCTest
import Swinject

final class BaseWireframeTests: XCTestCase {
    func test_showError_shouldCallAlertUtilsShowError() {
        let viewController = UIViewController()
        let alertUtils = mock(AlertUtilsProtocol.self)
        let container = Container()
        container.register(AlertUtilsProtocol.self) { _ in alertUtils }
        let sut = BaseWireframe(resolver: container, viewController: viewController)

        sut.showError("Error!")

        verify(alertUtils.showError(in: viewController, with: "Error!")).wasCalled()
    }
}
