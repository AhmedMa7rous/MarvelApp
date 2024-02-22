//
//  NetworkManager.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 18/02/2024.
//

import Foundation


class NetworkManager: NetworkManagerProtocol {
    //MARK: - Properties
    static let shared = NetworkManager()
    
    //MARK: - LifeCycle
    private init() {}
    
    //MARK: - Support Functions
    
    ///makeRequest is a generic function for making API requests
    private func makeRequest<T: Decodable>(urlString: String, method: String, parameters: [String: Any]?, completion: @escaping (Result<T, APIError>) -> Void) {
        var urlStringWithParams = Constants.baseURL + urlString
        // Add parameters to the request if needed
        if let parameters = parameters {
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                queryItems.append(queryItem)
            }
            
            var urlComponents = URLComponents(string: urlStringWithParams)!
            urlComponents.queryItems = queryItems
            urlStringWithParams = urlComponents.url!.absoluteString
        }
        
        guard let url = URL(string: urlStringWithParams) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
    
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                print(data.isEmpty)
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        
        task.resume()
    }
    
    //MARK: - EndPoints Functions
    func fetchCharacters(withOffSet offSet: Int, completion: @escaping (Result<Characters, APIError>) -> Void) {
        var parameters = Constants.parameters
        parameters["offset"] = offSet
        makeRequest(urlString: Constants.Endpoints.characters, method: "GET", parameters: parameters, completion: completion)
    }
    
    func fetchCharacterComics(forCharacterId characterId: Int, completion: @escaping (Result<Comics, APIError>) -> Void) {
        makeRequest(urlString: Constants.Endpoints.comics.replacingOccurrences(of: "{characterId}", with: "\(characterId)"), method: "GET", parameters: Constants.parameters, completion: completion)
    }
    
    func fetchCharacterSeries(forCharacterId characterId: Int, completion: @escaping (Result<Series, APIError>) -> Void) {
        makeRequest(urlString: Constants.Endpoints.series.replacingOccurrences(of: "{characterId}", with: "\(characterId)"), method: "GET", parameters: Constants.parameters, completion: completion)
    }
    
    func fetchCharacterStories(forCharacterId characterId: Int, completion: @escaping (Result<Stories, APIError>) -> Void) {
        makeRequest(urlString: Constants.Endpoints.stories.replacingOccurrences(of: "{characterId}", with: "\(characterId)"), method: "GET", parameters: Constants.parameters, completion: completion)
    }
    
    func fetchCharacterEvents(forCharacterId characterId: Int, completion: @escaping (Result<Events, APIError>) -> Void) {
        makeRequest(urlString: Constants.Endpoints.events.replacingOccurrences(of: "{characterId}", with: "\(characterId)"), method: "GET", parameters: Constants.parameters, completion: completion)
    }
}
