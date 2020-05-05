//
//  HomeViewController.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit
import Hero
import Lottie

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var moviesTitleWrapperView: UIView!
    @IBOutlet weak var moviesTitleLabel: UILabel!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var movieLoader: AnimationView!
    @IBOutlet weak var restaurantCollectionView: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var restaurantTitleWrapperView: UIView!
    @IBOutlet weak var restaurantTitleLabel: UILabel!
    
    
    // MARK: - Constraints
    @IBOutlet weak var movieCollectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var movieLoaderHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - Variables
    var movieList: [Movie] = []
    var museumList: [ArtEvent] = []
    var restaurantList: [Restaurant] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRevealBehaviour(forButton: menuButton, usePanGesture: false)
        self.navigationController?.becomeTransparent()
        
        self.movieCollectionView.pinFirstItemToCenter(view: view)
        self.restaurantCollectionView.pinFirstItemToCenter(view: view)
        
        self.moviesTitleWrapperView.setSlightShadow(shadowColor: .darkGray, length: 10)
        self.moviesTitleWrapperView.applyGradient()
        self.restaurantTitleWrapperView.applyGradient()
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: contentView.frame.size.height + 20)
        
        movieLoader.startVioletLoadingAnimation()
        
        self.loadMovies()
        
        self.restaurantList = Repository.getThumbnailRestaurants()
        restaurantCollectionView.reloadData()
        self.view.layoutIfNeeded()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

//        restaurantCollectionView.collectionViewLayout.invalidateLayout()
//        movieCollectionView.collectionViewLayout.invalidateLayout()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        restaurantCollectionView.reloadData()
        self.view.layoutIfNeeded()
        restaurantCollectionView.scrollToCenter(view: view)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            if let indexPath = movieCollectionView.indexPathsForSelectedItems?[0] {
                var movie = Movie()
                movie = movieList[indexPath.row]
                let movieVC = segue.destination as! MovieDetailViewController
                movieVC.movie = movie
                
                movieVC.imageView.hero.id = "MoviePoster \(movie.id)"
                movieVC.titleWrapperView.hero.id = "TitleWrapper \(movie.id)"
                movieVC.titleLabel.hero.id = "TitleLabel \(movie.id)"
                movieVC.view.hero.id = "BottomTransformerView \(movie.id)"
                movieVC.descriptionLabel.text = movie.description
                
                navigationController?.isHeroEnabled = true
                Hero.shared.defaultAnimation = .auto
            }
        } else if segue.identifier == "toScanning" {
        }
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == movieCollectionView {
            return movieList.count
        } else {
            return restaurantList.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // MARK: - Movie Cell
        if collectionView == movieCollectionView {
            let currentMovie = movieList[indexPath.row]
            let movieCell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
            movieCell.setMovie(withEvent: currentMovie)

            movieCell.thumbnailImage.hero.id = "MoviePoster \(currentMovie.id)"
            movieCell.titleWrapperView.hero.id = "TitleWrapper \(currentMovie.id)"
            movieCell.titleLabel.hero.id = "TitleLabel \(currentMovie.id)"
            movieCell.bottomTransformerView.hero.id = "BottomTransformerView \(currentMovie.id)"
            
            return movieCell
        }
        // MARK: - Restaurant Cell
        else if collectionView == restaurantCollectionView {
            let currentRestaurant = restaurantList[indexPath.row]
            
            let cell = restaurantCollectionView.dequeueReusableCell(withReuseIdentifier: "FoodCollectionViewCell", for: indexPath) as! FoodCollectionViewCell
            cell.set(withRestaurant: currentRestaurant)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == movieCollectionView {
            let showAllMoviesFooter = movieCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieCollectionFooterView", for: indexPath) as! MovieCollectionFooterView

            showAllMoviesFooter.backgroundView.applyGradient(cornerRadius: 15)
            return showAllMoviesFooter
        } else  {
            let showAllRestaurantsFooter = restaurantCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RestaurantCollectionFooterView", for: indexPath) as! RestaurantCollectionFooterView
            
            return showAllRestaurantsFooter
        }
    }
    
    
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        var layout = UICollectionViewFlowLayout()
        if (scrollView as? UICollectionView) == movieCollectionView {
            layout = self.movieCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        } else if (scrollView as? UICollectionView) == restaurantCollectionView {
            layout = self.restaurantCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        }
        let cellWidthWithSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthWithSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthWithSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView as? UICollectionView) == self.movieCollectionView {
            self.transformAndFade(forCollectionView: movieCollectionView)
        } else if (scrollView as? UICollectionView) == self.restaurantCollectionView {
            self.transformAndFade(forCollectionView: restaurantCollectionView)
        }
    }
    
    func changeSizeScaleToAlphaScale(_ x : CGFloat) -> CGFloat {
        let minScale : CGFloat = 0.86
        let maxScale : CGFloat = 1.0
        
        let minAlpha : CGFloat = 0.25
        let maxAlpha : CGFloat = 1.0
        
        return ((maxAlpha - minAlpha) * (x - minScale)) / (maxScale - minScale) + minAlpha
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        var layout = UICollectionViewFlowLayout()
        if collectionView == movieCollectionView {
            layout = self.movieCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        } else if collectionView == restaurantCollectionView {
            layout = self.restaurantCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth * Constants.UIConfiguration.Factors.collectionCellWidth + layout.minimumLineSpacing
        
        return CGSize(width: 280, height: 0)
    }
}


// MARK: - Helper Methods
extension HomeViewController {
    private func transformAndFade(forCollectionView collectionView: UICollectionView) {
        let centerX = collectionView.center.x
        
        for cell in collectionView.visibleCells {
            
            let basePosition = cell.convert(CGPoint.zero, to: self.view)
            let cellCenterX = basePosition.x + collectionView.frame.size.height / 2.0
            
            let distance = abs(cellCenterX - centerX)
            
            let tolerance : CGFloat = 0.02
            var scale = 1.00 + tolerance - (( distance / centerX ) * 0.205)
            if(scale > 1.0){
                scale = 1.0
            }
            
            if(scale < 0.860091) {
                scale = 0.860091
            }
            
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            if collectionView == movieCollectionView {
                let coverCell = cell as! MovieCollectionViewCell
                coverCell.thumbnailImage.alpha = changeSizeScaleToAlphaScale(scale)
            } else if collectionView == restaurantCollectionView {
                let coverCell = cell as! FoodCollectionViewCell
                coverCell.thumbnailImage.alpha = changeSizeScaleToAlphaScale(scale)
            }
        }
    }
}


// MARK: - Loading Data
extension HomeViewController {
    private func loadMovies() {
        self.movieList = NetworkManager.getThumbnailMovies()
        self.movieCollectionView.reloadData()
        self.view.layoutIfNeeded()
        self.movieCollectionHeightConstraint.constant = 240
        UIView.animate(withDuration: 0.4, animations: {
            self.movieLoader.alpha = 0
            self.view.layoutIfNeeded()
            self.movieCollectionView.scrollToCenter(view: self.view)
        }) { _ in
            UIView.animate(withDuration: 0.4) {
                self.movieCollectionView.alpha = 1
            }
        }
        
        
        
//        Repository.getMovies(completion: { [weak self] (result) in
//            switch result {
//            case .success(let movies):
//                self?.movieList = movies
//            case .failure(let error):
//                print("Error: ", error)
//                self?.movieList = NetworkManager.getThumbnailMovies()
//            }
//
//            self?.movieCollectionView.reloadData()
//            self?.view.layoutIfNeeded()
//
//            self?.movieCollectionHeightConstraint.constant = 240
//            UIView.animate(withDuration: 0.4, animations: {
//                self?.movieLoader.alpha = 0
//                self?.view.layoutIfNeeded()
//            }) { _ in
//                UIView.animate(withDuration: 0.4) {
//                    self?.movieCollectionView.alpha = 1
//                }
//            }
//
//            self?.movieCollectionView.scrollToCenter(view: (self?.view)!)
//        })
    }
}
