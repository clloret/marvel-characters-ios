import UIKit

protocol WireframeProtocol: AnyObject {
    func showError(_ errorMessage: String)
}

class BaseWireframe {
    private unowned var _viewController: UIViewController
    var navigationControllerProtocol: UINavigationControllerProtocol?
    private let alertUtils: AlertUtilsProtocol?

    // To retain view controller reference upon first access
    private var _temporaryStoredViewController: UIViewController?

    init(resolver: AppResolver, viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
        alertUtils = resolver.resolve(AlertUtilsProtocol.self)
    }
}

extension BaseWireframe: WireframeProtocol {
    func showError(_ errorMessage: String) {
        alertUtils?.showError(in: viewController, with: errorMessage)
    }
}

extension BaseWireframe {
    var viewController: UIViewController {
        defer { _temporaryStoredViewController = nil }
        return _viewController
    }

    var navigationController: UINavigationControllerProtocol? {
        return navigationControllerProtocol ?? viewController.navigationController
    }
}

protocol UINavigationControllerProtocol {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool)
}

extension UINavigationController: UINavigationControllerProtocol {
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        pushViewController(wireframe.viewController, animated: animated)
    }
}

extension UIViewController {
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        setViewControllers([wireframe.viewController], animated: animated)
    }
}
