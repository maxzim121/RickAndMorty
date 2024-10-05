import Foundation

final class CharacterScreenCoordinator: BaseCoordinator {

    override func start() {
        showCharacterScreen()
    }

    override func finish() {
        finishDelegate?.didFinish(self)
    }
}

private extension CharacterScreenCoordinator {
    func showCharacterScreen() {
        let viewController = CharacterScreenViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
