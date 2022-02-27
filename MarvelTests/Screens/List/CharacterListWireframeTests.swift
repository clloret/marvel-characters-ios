//
//  CharacterListWireframeTests.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import Mockingbird
import Swinject
import XCTest

final class CharacterListWireframeTests: XCTestCase {
    private var sut: CharacterListWireframe!
    private var navigationController: UINavigationControllerProtocolMock!
    private var characterDetailsWireframe: CharacterDetailsWireframe!
    private var container: Container!

    override func setUp() {
        super.setUp()

        container = Container()
        container.register(CharacterListPresenterProtocol.self) { _ in mock(CharacterListPresenterProtocol.self) }
        container.register(CharacterDetailsWireframeProtocol.self) { (resolver, character: MarvelCharacter) in
            self.characterDetailsWireframe = CharacterDetailsWireframe(resolver: AppResolverWrapper(resolver: resolver), character: character)
            return self.characterDetailsWireframe
        }

        sut = CharacterListWireframe(resolver: container)

        navigationController = mock(UINavigationControllerProtocol.self)
        sut.navigationControllerProtocol = navigationController
    }

    override func tearDown() {
        sut = nil
        navigationController = nil
        characterDetailsWireframe = nil
        container = nil

        super.tearDown()
    }

    func test_navigateToCharacterDetails_pushWireframe() {
        sut.navigate(to: .characterDetails(TestData.getSampleCharacter()))

        verify(navigationController.pushWireframe(characterDetailsWireframe, animated: any())).wasCalled()
    }
}
