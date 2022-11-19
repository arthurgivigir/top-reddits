//
//  NetworkManager.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

class NetworkManager {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func makeRequest<T: Decodable>(
        with url: URL,
        decode decodable: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        session.fetchData(with: URLRequest(url: url)) { data, error in
            guard let data = data else {
                completion(.failure(.notFound))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let parsed = try decoder.decode(decodable, from: data)
                completion(.success(parsed))
            } catch {
                completion(.failure(self.resolve(error: error)))
            }
        }
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet:
            return .notConnected
        default:
            return .generic(error)
        }
    }
}
