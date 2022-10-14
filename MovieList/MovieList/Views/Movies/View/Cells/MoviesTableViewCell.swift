//
//  MoviesTableViewCell.swift
//  MovieList
//
//  Created by Axel Mosiejko on 13/10/2022.
//

import UIKit

protocol MoviesTableViewCellDelegate: NSObjectProtocol {
    func showMovieDetails(_ movie: Movie)
}

class MoviesTableViewCell: UITableViewCell {

    var delegate: MoviesTableViewCellDelegate?
    private var movies: [Movie] = [Movie]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cellNib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    func populate(_ movies: [Movie]) {
        self.movies = movies
        
        collectionView.reloadData()
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
    }
}

extension MoviesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.populate(movies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showMovieDetails(movies[indexPath.row])
    }
}

