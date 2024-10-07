import UIKit

final class AppCoordinator: BaseCoordinator {
    override func start() {
        showCharacterFlow()
    }

    override func finish() {
        print("AppCoordinator Finish")
    }
}

private extension AppCoordinator {
    func showMainFlow() {
        let mainCoordinator = MainScreenCoordinator(
            finishDelegate: self,
            navigationController: navigationController
        )
        addChild(mainCoordinator)
        mainCoordinator.start()
    }
    
    func showCharacterFlow() {
        let characterCoordinator = CharacterScreenCoordinator(
            finishDelegate: self,
            navigationController: navigationController
        )
        addChild(characterCoordinator)
        characterCoordinator.start()
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func didFinish(_ coordinator: CoordinatorProtocol) {
        removeChild(coordinator)
        navigationController.popToRootViewController(animated: false)
    }
}
