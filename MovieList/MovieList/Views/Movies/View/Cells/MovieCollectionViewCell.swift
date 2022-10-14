//
//  MovieCollectionViewCell.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    func populate(_ movie: Movie) {
        if let url = URL.init(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)") {
            imageView?.sd_setImage(with: url, completed: {_,_,_,_ in
                DispatchQueue.main.async {
                    self.activityIndicator?.stopAnimating()
                }
            })
        }
    }
}
