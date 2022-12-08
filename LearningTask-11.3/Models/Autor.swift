//
//  Autor.swift
//  LearningTask-11.3
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

struct Autor: Decodable {
    var id: Int?
    let foto: String
    let nome: String
    let sobrenome: String
    let bio: String
    let tecnologias: [String]
    
    var nomeCompleto: String {
        return "\(nome) \(sobrenome)"
    }
    
    var fotoURL: URL? {
        return URL(string: foto)
    }
    
    enum CodingKeys: String, CodingKey {
        case bio, id
        case foto = "profilePicturePath"
        case nome = "firstName"
        case sobrenome = "lastName"
        case tecnologias = "technologiesSHeWritesAbout"
    }
}

