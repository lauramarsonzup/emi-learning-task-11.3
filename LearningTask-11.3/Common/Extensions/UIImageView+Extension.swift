//
//  UIImageView+Extension.swift
//  LearningTask-11.3
//
//  Created by Laura Pinheiro Marson on 08/12/22.
//

import UIKit

extension UIImageView {
    func carregar(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let imagem = UIImage(data: data), let cgImage = imagem.cgImage {
                    DispatchQueue.main.async {
                        let scale = imagem.size.width / self!.frame.size.width
                        self?.image = UIImage.init(cgImage: cgImage, scale: scale, orientation: .up)
                    }
                }
            }
        }
    }
}
