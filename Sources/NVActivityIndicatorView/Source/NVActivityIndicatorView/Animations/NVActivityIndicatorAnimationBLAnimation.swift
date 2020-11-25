//
//  NVActivityIndicatorAnimationBLAnimation.swift
//  NVActivityIndicatorView
//
//  Created by Azis Senoaji Prasetyotomo on 16/01/18.
//  Copyright © 2018 Vinh Nguyen. All rights reserved.
//

import Foundation

class NVActivityIndicatorAnimationBLAnimation: NVActivityIndicatorAnimationDelegate {
    private let imagesLayer = CALayer()
    private var images: [UIImage] = []
    var indexOfImages = 2
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadImages() {

        var images: [UIImage] = []
        for i in 2..<7 {
            let image = UIImage(named: "ic_loader_\(i)",
                                in: bundle,
                                compatibleWith: nil)!
            images.append(image)
            
        }
        let image = UIImage(named: "ic_loader_1",
                            in: bundle,
                            compatibleWith: nil)!
        images.append(image)
        
        self.images = images
    }
    
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        loadImages()
        
        // Draw image layer
        let backgroundLayer = CALayer()
        backgroundLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: size.width + 4,
            height: size.height
        )
        backgroundLayer.backgroundColor = UIColor.white.cgColor
        backgroundLayer.cornerRadius = 20
        
        let imageSize: CGFloat = 32
        let myImage = UIImage(named: "ic_loader_2",
                              in: bundle,
                              compatibleWith: nil)!.cgImage
        imagesLayer.frame = CGRect(
            x: (layer.bounds.size.width / 2) - (imageSize / 2),
            y: (layer.bounds.size.height / 2) - (imageSize * 5 / 6),
            width: imageSize,
            height: imageSize
        )
        imagesLayer.contents = myImage
        imagesLayer.backgroundColor = UIColor.white.cgColor
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(imagesLayer)
        
        animate()
    }
    
    private func animate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let ws = self else { return }
                
                if ws.images.count > ws.indexOfImages {
                    let image = ws.images[ws.indexOfImages].cgImage
                    ws.imagesLayer.contents = image
                }
                ws.indexOfImages += 1
                if ws.indexOfImages >= 7 {
                    ws.indexOfImages = 0
                }
                ws.animate()
            })
        }
    }
}


