import Foundation

final class MainScreenViewModel {
    
    weak var coordinator: MainScreenCoordinator?
    
    // MARK: - Private variables
    
    private var pageItems: [Results] = []
    private var pageNumber = 1
    private var networkClient: NetworkClient
    
    // MARK: - Closures
    
    var onDataLoaded: (([Results]) -> Void)?
    var onError: ((String) -> Void)?
    
    // MARK: - Initialisation
    
    init(coordinator: MainScreenCoordinator?, network: NetworkClient) {
        self.coordinator = coordinator
        self.networkClient = network
    }
    
    // MARK: - Public methods
    
    func fetchPage() {
        networkClient.fetchPage(pageId: pageNumber) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let page):
                page.results.forEach {
                    self.pageItems.append($0)
                }
                self.onDataLoaded?(pageItems)
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    }
    
    func countItems() -> Int {
        pageItems.count
    }
    
    func getItem(at: Int) -> Results? {
        pageItems[at]
    }
    
    func nextPage(indexPath: IndexPath) {
        if indexPath.row + 1 == pageItems.count && pageNumber < 42{
            pageNumber += 1
            if pageNumber < 43 {
                fetchPage()
            }
        }
    }
    
    func showCharacter(id: Int) {
        coordinator?.showNextScreen(id: id, networkClient: networkClient)
    }
}
