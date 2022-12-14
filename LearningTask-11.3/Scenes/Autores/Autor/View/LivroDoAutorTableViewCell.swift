//
//  LivroDoAutorTableViewCell.swift
//  LearningTask-11.3
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class LivroDoAutorTableViewCell: UITableViewCell {

    @IBOutlet private weak var tituloLabel: UILabel!
    @IBOutlet private weak var capaImageView: UIImageView!
    
    var livro: Livro? {
        didSet {
            guard let livro = livro else {
                return
            }

            tituloLabel.text = livro.titulo
            
            capaImageView.image = UIImage.init("Book",
                                               aspectFillIn: capaImageView.frame)
            capaImageView.carregar(url: livro.imagemURL!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = .texasRose.withAlphaComponent(0.3)
        selectedBackgroundView = bgColorView
    }
    
}

