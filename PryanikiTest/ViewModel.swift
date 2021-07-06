//
//  ViewModel.swift
//  PryanikiTest
//
//  Created by Alexander Bonney on 7/5/21.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var dataToDisplay: [String:DataOfTheObject] = [:]
    @Published var orderToDisplay: [String] = []
    
    init() {
        
        fetchData(from: "https://pryaniky.com/static/json/sample.json") { result in
            
            switch result {
            case .success(let response):
                for object in response.data {
                    self.dataToDisplay[object.name] = object.data
                }
                self.orderToDisplay = response.view
            case .failure(let error):
                switch error {
                case .badURL:
                    print("The URL in invalid.")
                case .requestFailed:
                    print("Network problems")
                case .cannotDecode:
                    print("Cannot get data from given file")
                }
            }
        }
        
    }
    
    func fetchData(from urlString: String, completion: @escaping (Result<APIResponse, NetworkError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    if let decoded = try? JSONDecoder().decode(APIResponse.self, from: data) {
                        completion(.success(decoded))
                    } else {
                        completion(.failure(.cannotDecode))
                    }
                } else {
                    completion(.failure(.requestFailed))
                }
            }
        }.resume()
        
    }
    
    
}

enum NetworkError: Error {
    case badURL
    case requestFailed
    case cannotDecode
}
