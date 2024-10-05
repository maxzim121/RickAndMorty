import UIKit

extension URLRequest {
    static func makeHTTPRequest(
        httpMethod: String,
        baseURLString: String = "https://rickandmortyapi.com/api/character/",
        requestType: Request,
        id: Int
    ) -> URLRequest {
        switch requestType {
        case .character:
            let baseURL = URL(string: baseURLString + String(id))!
            var request = URLRequest(url: baseURL)
            request.httpMethod = httpMethod
            return request
        case .page:
            let baseURL = URL(string: baseURLString)!
            var request = URLRequest(url: baseURL)
            request.addValue(String(id), forHTTPHeaderField: "page")
            request.httpMethod = httpMethod
            return request
        }
    }
}

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}

enum Request {
    case page
    case character
}

extension URLSession {
    func data(
        for request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask {
            let fulfillCompletion: (Result<Data, Error>) -> Void = { result in
                DispatchQueue.main.async { completion(result) }
            }
            let task = dataTask(with: request, completionHandler: { data, response, error in
                if let data = data,
                   let response = response,
                   let statusCode = (response as? HTTPURLResponse)?.statusCode
                {
                    if 200 ..< 300 ~= statusCode {
                        fulfillCompletion(.success(data))
                    } else {
                        fulfillCompletion(.failure(NetworkError.httpStatusCode(statusCode)))
                    }
                } else if let error = error {
                    fulfillCompletion(.failure(NetworkError.urlRequestError(error)))
                } else {
                    fulfillCompletion(.failure(NetworkError.urlSessionError))
                }
            })
            task.resume()
            return task
        }
    
    func object<T: Codable>(
        urlSession: URLSession,
        for request: URLRequest,
        completion: @escaping  (Result<T, Error>) -> Void) -> URLSessionTask {
            let decoder = JSONDecoder()
            return urlSession.data(for: request) { (result: Result<Data, Error>) in
                let response = result.flatMap { data -> Result<T, Error> in
                    Result { try decoder.decode(T.self, from: data) }
            }
                completion(response)
        }
    }
}
