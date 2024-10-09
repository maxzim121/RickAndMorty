import Foundation

typealias PageResponseCompletion = (Result<PageResponse, Error>) -> Void
typealias CharacterResponseCompletion = (Result<CharacterResponseStruct, Error>) -> Void

final class NetworkClient {
    private let urlSession = URLSession.shared
    private var pageTask: URLSessionTask?
    static let shared = NetworkClient()
    
    func fetchPage(pageId: Int, completion: @escaping PageResponseCompletion) {
        assert(Thread.isMainThread)
        let request = makeRequest(id: pageId, request: .page)
        pageTask = urlSession.object(urlSession: urlSession, for: request) { [weak self] (result: Result<PageResponse, Error>) in
            DispatchQueue.main.async {
                guard self != nil else {return}
                switch result {
                case .success(let page):
                    completion(.success(page))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchCharacter(id: Int, completion: @escaping CharacterResponseCompletion) {
        assert(Thread.isMainThread)
        let request = makeRequest(id: id, request: .character)
        pageTask = urlSession.object(urlSession: urlSession, for: request) { [weak self] (result: Result<CharacterResponseStruct, Error>) in
            DispatchQueue.main.async {
                guard self != nil else {return}
                switch result {
                case .success(let page):
                    completion(.success(page))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func makeRequest(id: Int, request: Request) -> URLRequest {
        URLRequest.makeHTTPRequest(
            httpMethod: "get",
            requestType: request,
            id: id
        )
    }
}
