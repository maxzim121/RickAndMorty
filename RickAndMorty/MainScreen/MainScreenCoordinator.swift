import Foundation

final class MainScreenCoordinator: BaseCoordinator {

    override func start() {
        showMainScreen()
    }

    override func finish() {
        finishDelegate?.didFinish(self)
    }
    
    func showNextScreen(id: Int, networkClient: NetworkClient) {
        showCharacterScreen(id: id, networkClient: networkClient)
    }
}

private extension MainScreenCoordinator {
    func showMainScreen() {
        let networkClient = NetworkClient()
        let viewModel = MainScreenViewModel(coordinator: self, network: networkClient)
        let viewController = MainScreenViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showCharacterScreen(id: Int, networkClient: NetworkClient) {
        let characterScreenCoordinator = CharacterScreenCoordinator(
            finishDelegate: self,
            navigationController: navigationController
        )
        characterScreenCoordinator.networkClient = networkClient
        characterScreenCoordinator.characterId = id
        addChild(characterScreenCoordinator)
        characterScreenCoordinator.start()
    }
}

extension MainScreenCoordinator: CoordinatorFinishDelegate {
    func didFinish(_ coordinator: CoordinatorProtocol) {
        navigationController.popToRootViewController(animated: true)
    }
}
