import Foundation

final class MainScreenCoordinator: BaseCoordinator {

    override func start() {
        showMainScreen()
    }

    override func finish() {
        finishDelegate?.didFinish(self)
    }
    
    func showNextScreen() {
        showCharacterScreen()
    }
}

private extension MainScreenCoordinator {
    func showMainScreen() {
        let viewController = MainScreenViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showCharacterScreen() {
        let characterScreenCoordinator = CharacterScreenCoordinator(
            finishDelegate: self,
            navigationController: navigationController
        )
        addChild(characterScreenCoordinator)
        characterScreenCoordinator.start()
    }
}

extension MainScreenCoordinator: CoordinatorFinishDelegate {
    func didFinish(_ coordinator: CoordinatorProtocol) {
        navigationController.popToRootViewController(animated: true)
    }
}
