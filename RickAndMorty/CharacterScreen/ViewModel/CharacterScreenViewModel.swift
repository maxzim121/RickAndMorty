import Foundation
final class CharacterScreenViewModel {
    
    var characterId: Int
    
    let networkClient: NetworkClient
    
    weak var coordinator: CharacterScreenCoordinator?
    
    var onDataLoaded: ((CharacterResponseStruct) -> Void)?
    var onError: ((String) -> Void)?
    
    init(characterId: Int, coordinator: CharacterScreenCoordinator, networkClient: NetworkClient) {
        self.characterId = characterId
        self.coordinator = coordinator
        self.networkClient = networkClient
    }
    
    func fetchCharacter() {
        networkClient.fetchCharacter(id: characterId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let character):
                self.onDataLoaded?(character)
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    }
    
    func backButtonTapped() {
        coordinator?.finish()
    }
}
