import UIKit

class BaseCoordinator: CoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol]

    init(
        finishDelegate: CoordinatorFinishDelegate? = nil,
        navigationController: UINavigationController,
        childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol]()
    ) {
        self.finishDelegate = finishDelegate
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
    }

    deinit {
        childCoordinators.forEach { $0.finishDelegate = nil }
        childCoordinators.removeAll()
    }

    func start() {
        print("Coordinator start")
    }

    func finish() {
        print("Coordinator finish")
    }
}
