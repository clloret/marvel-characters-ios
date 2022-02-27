//
//  CharacterListInteractorTests.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import Mockingbird
import Swinject
import XCTest

final class CharacterListInteractorTests: XCTestCase {
    private var sut: CharacterListInteractor!
    private var service: ServiceProtocolMock!

    override func setUp() {
        super.setUp()

        service = mock(ServiceProtocol.self)
        sut = CharacterListInteractor(service: service)
    }

    override func tearDown() {
        sut = nil
        service = nil
        
        super.tearDown()
    }

    func test_getCharacters_callApiToGetCharacters() {
        sut.getCharacters { _ in
        }

        verify(service.getCharacters(completion: any())).wasCalled()
    }
}
