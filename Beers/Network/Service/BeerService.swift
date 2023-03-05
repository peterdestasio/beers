//
//  BeerService.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

final class BeerService {
    
    private lazy var baseURL: URL = {
        return URL(string: "https://api.punkapi.com/v2/")!
    }()
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchBeers(with request: BeerRequest, page: Int, completion: @escaping (Result<Beers, DataResponseError>) -> Void) {
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        let parameters = ["page": "\(page)"]
        let encodedURLRequest = urlRequest.encode(with: parameters)

        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode, let data = data else {
                completion(Result.failure(DataResponseError.network))
                return
            }
            guard let decodedResponse = try? JSONDecoder().decode(Beers.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
}
