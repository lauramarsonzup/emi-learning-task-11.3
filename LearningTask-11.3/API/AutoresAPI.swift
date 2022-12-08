//
//  AutoresAPI.swift
//  LearningTask-11.3
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

class AutoresAPI {
    let endpoint: String = "https://casadocodigo-api.herokuapp.com/api/author"
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    private var dataTask: URLSessionDataTask?
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func listaAutores(completionHandler: @escaping (Result<[Autor], Error>) -> Void) {
        
        dataTask?.cancel()
        
        guard let url = URL(string: endpoint) else { return }
        
        dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(.falhaAoProcessarRequisicao(error)))
                }
                
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.falhaAoObterResposta))
                }
                return
            }
            
            do {
                guard let self = self else { return }
                
                let autores = try self.decoder.decode([Autor].self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(.success(autores))
                }
            } catch {
                completionHandler(.failure(.dadosInvalidos))
            }
        }
        
        dataTask?.resume()
    }
}

extension AutoresAPI {
    typealias SError = Swift.Error
    
    enum Error: SError, LocalizedError {
        case falhaAoProcessarRequisicao(SError)
        case falhaAoObterResposta
        case dadosInvalidos
        
        var errorDescription: String? {
            switch self {
            case .falhaAoProcessarRequisicao(let error):
                return "Erro ao processar a requisição \(error.localizedDescription)"
                
            case .falhaAoObterResposta:
                return "Erro ao obter resposta do servidor"
                
            case .dadosInvalidos:
                return "Os dados recebidos do servidor são inválidos"
            }
        }
    }
}
