import UIKit

typealias PageResponseCompletion = (Result<PageResponse, Error>) -> Void

final class NetworkClient {
    private let urlSession = URLSession.shared
    private var pageTask: URLSessionTask?
    static let shared = NetworkClient()
    
    func fetchPage(completion: @escaping PageResponseCompletion) {
        assert(Thread.isMainThread)
        let request = pageRequest()
        pageTask = urlSession.object(urlSession: urlSession, for: request) { [weak self] (result: Result<PageResponse, Error>) in
            DispatchQueue.main.async {
                guard self != nil else {return}
                switch result {
                case .success(let page):
                    completion(.success(page))
                case .failure(let error):
                    completion(.failure(error))
                    assertionFailure("\(error)")
                }
            }
        }
    }
    
    func pageRequest() -> URLRequest {
        URLRequest.makeHTTPRequest(
            httpMethod: "get"
        )
    }
}
