import Foundation
final class CharacterScreenViewModel {
    
    let networkClient: NetworkClient
    
    // MARK: - Public variables
    
    weak var coordinator: CharacterScreenCoordinator?
    var characterId: Int
    var onDataLoaded: ((CharacterResponseStruct) -> Void)?
    var onError: ((String) -> Void)?
    
    // MARK: - Initialisation
    
    init(characterId: Int, coordinator: CharacterScreenCoordinator, networkClient: NetworkClient) {
        self.characterId = characterId
        self.coordinator = coordinator
        self.networkClient = networkClient
    }
    
    // MARK: - Public methods
    
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
