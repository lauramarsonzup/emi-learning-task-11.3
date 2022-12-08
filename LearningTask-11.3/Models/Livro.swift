//
//  Livro.swift
//  LearningTask-11.3
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

enum TipoDeLivro: CaseIterable, Decodable {
    case ebook
    case impresso
    case combo
    
    var indice: Int {
        switch self {
        case .ebook:
            return 0
        case .impresso:
            return 1
        case .combo:
            return 2
        }
    }
    
    var titulo: String {
        switch self {
        case .ebook:
            return "E-book"
        case .impresso:
            return "Impresso"
        case .combo:
            return "E-book + impresso"
        }
    }
}

struct Preco: Decodable {
    let valor: Decimal
    var tipoDeLivroString: String? {
        didSet {
            if tipoDeLivroString == "EBOOK" {
                tipoDeLivro = .ebook
            } else if tipoDeLivroString == "HARDCOVER" {
                tipoDeLivro = .impresso
            } else if tipoDeLivroString == "COMBO" {
                tipoDeLivro = .combo
            }
        }
    }
    
    var tipoDeLivro: TipoDeLivro?

    
    enum CodingKeys: String, CodingKey {
        case valor = "value"
        case tipoDeLivroString = "bookType"
    }
}

struct Livro: Decodable {
    let titulo: String
    let subtitulo: String
    let imagemDeCapaURI: String
    let autor: Autor
    let precos: [Preco]
    
    var imagemURL: URL? {
        return URL(string: imagemDeCapaURI)
    }
    
    enum CodingKeys: String, CodingKey {
        case titulo = "title"
        case subtitulo = "subtitle"
        case imagemDeCapaURI = "coverImagePath"
        case autor = "author"
        case precos = "prices"
    }
}
