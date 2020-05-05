//
//  MoviesViewController.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/15/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit
import Alamofire

class EntertainmentViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var movieTitleWrapperView: UIView!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    
    // MARK: - Variables
    var movieList: [ArtEvent] = []
    var museumList: [ArtEvent] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupRevealBehaviour(forButton: menuButton)
        movieTitleWrapperView.applyGradient()
        
//        Repository.getMovies(completion: { [weak self] (result) in
//            switch result {
//            case .success(let movies):
//                self?.movieList = movies
//                self?.movieCollectionView.reloadData()
//            case .failure(let error):
//                print("Error: ", error)
//            }
//        })
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension EntertainmentViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == movieCollectionView {
            let currentMovie = movieList[indexPath.row]
            let movieCell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
            movieCell.setMovie(withEvent: currentMovie)

            movieCell.contentView.hero.id = "Root \(currentMovie.id)"
            movieCell.thumbnailImage.hero.id = "MoviePoster \(currentMovie.id)"
            movieCell.titleWrapperView.hero.id = "TitleWrapper \(currentMovie.id)"
            movieCell.titleLabel.hero.id = "TitleLabel \(currentMovie.id)"
            
            return movieCell
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if collectionView == movieCollectionView {
            let showAllMoviesFooter = movieCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieCollectionFooterView", for: indexPath) as! MovieCollectionFooterView

            showAllMoviesFooter.backgroundView.applyGradient(cornerRadius: 15)
            return showAllMoviesFooter
//        }
    }
}
