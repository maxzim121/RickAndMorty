import Foundation

final class CharacterScreenCoordinator: BaseCoordinator {
    
    var characterId: Int?
    var networkClient: NetworkClient?

    override func start() {
        showCharacterScreen()
    }

    override func finish() {
        finishDelegate?.didFinish(self)
    }
}

private extension CharacterScreenCoordinator {
    func showCharacterScreen() {
        guard let characterId = characterId,
            let networkClient = networkClient else { return }
        let viewModel = CharacterScreenViewModel(characterId: characterId, coordinator: self, networkClient: networkClient)
        let viewController = CharacterScreenViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
