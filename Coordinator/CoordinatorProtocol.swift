import UIKit


protocol CoordinatorFinishDelegate: AnyObject {
    func didFinish(_ coordinator: CoordinatorProtocol)
}

protocol CoordinatorProtocol: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }

    func start()
    func finish()
}

extension CoordinatorProtocol {

    func addChild(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
