//
//  AutoresAPI.swift
//  LearningTask-11.3
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

class AutoresAPI {
    let endpoint: String = "https://casadocodigo-api.herokuapp.com/api/author"
    
    var session: URLSession
    var decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func listaAutores(completionHandler: @escaping (Result<[Autor], Error>) -> Void) {
        
        guard let url = URL(string: endpoint) else { return }
        
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            do {
                guard let self = self else { return }
                
                let autores = try self.decoder.decode([Autor].self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(.success(autores))
                }
            } catch {
                completionHandler(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}

