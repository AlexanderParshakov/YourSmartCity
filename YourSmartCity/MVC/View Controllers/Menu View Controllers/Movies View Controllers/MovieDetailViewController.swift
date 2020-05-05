//
//  MovieViewController.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/12/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionSeparator: UIView!
    @IBOutlet weak var descriptionWrapperView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cinemaTitleWrapperView: UIView!
    
    // MARK: - Constraints
    @IBOutlet weak var descriptionViewHeightConstraint: NSLayoutConstraint!
    
    
    
    // MARK: - Code UI
    var imageView = UIImageView()
    var titleWrapperView = UIView()
    var titleLabel = UILabel()
    var backButton = UIButton()
    
    
    // MARK: - Variables
    var movie: ArtEvent = ArtEvent()
    
    
    // MARK: - Aliases
    typealias Factors = Constants.UIConfiguration.Factors

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: Factors.headerImageHeight, left: 0, bottom: 0, right: 0)
        scrollView.delegate = self
        
        descriptionWrapperView.setSlightShadow(length: 4)
        descriptionWrapperView.layer.cornerRadius = 20
        
        cinemaTitleWrapperView.applyGradient()
        
        addDescriptionGestureRecognizer()
        
        imageView = buildHeaderImageView()
        titleLabel = buildHeaderTitleLabel()
        titleWrapperView = buildHeaderTitleWrapperView()
        self.setupConstraintsForHeader()
        
        backButton = buildBackButton()
        self.setupConstraintForBackButton()
        backButton.applyGradient(cornerRadius: 10)
        
        view.layoutIfNeeded()
        imageView.hero.id = "MoviePoster \(movie.id)"
        titleWrapperView.hero.id = "TitleWrapper \(movie.id)"
        titleLabel.hero.id = "TitleLabel \(movie.id)"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    @IBAction func onHideButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: - UIScrollViewDelegate
extension MovieDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yForImage = Factors.headerImageHeight - (scrollView.contentOffset.y + Factors.headerImageHeight)
        let heightForImage = min(max(yForImage, 0), 450)
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: heightForImage)
    }
}


// MARK: - Build UI
extension MovieDetailViewController {
    private func buildHeaderImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: Factors.headerImageHeight)
        imageView.image = UIImage(data: movie.pictureData ?? Data())
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    private func buildHeaderTitleWrapperView() -> UIView {
        let titleView = UIView()
        
        titleView.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.size.width, height: 40)
        titleView.clipsToBounds = true
        titleView.backgroundColor = UIColor.black
        titleView.alpha = 0.5
        titleView.layer.cornerRadius = titleView.frame.height / 2
        titleView.isUserInteractionEnabled = false
        
        return titleView
    }
    
    private func buildHeaderTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = movie.title
        label.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }
    
    private func buildBackButton() -> UIButton {
        let button = UIButton()
        
        button.hero.isEnabled = false
        button.setTitle("Назад", for: .normal)
        button.addTarget(self, action: #selector(onHideButtonTapped), for: .touchUpInside)
        
        return button
    }
    
    private func setupConstraintsForHeader() {
        view.addSubview(imageView)
        view.addSubview(titleWrapperView)
        view.addSubview(titleLabel)
        
        titleWrapperView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.leading.equalTo(imageView.snp.leading).offset(30)
            make.trailing.equalTo(imageView.snp.trailing).inset(30)
            make.bottom.equalTo(imageView.snp.bottom).inset(10)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(titleWrapperView)
            make.leading.equalTo(titleWrapperView.snp.leading).offset(10)
            make.trailing.equalTo(titleWrapperView.snp.trailing).inset(10)
        }
    }
    
    private func setupConstraintForBackButton() {
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(200)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).inset(30)
        }
    }
}


// MARK: - Helper Methods
extension MovieDetailViewController {
    private func addDescriptionGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(switchDescriptionViewVisibility))
        
        gestureRecognizer.cancelsTouchesInView = false
        descriptionWrapperView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    private func switchDescriptionViewVisibility() {
        let size = CGSize(width: descriptionLabel.bounds.width, height: .infinity)
        let estimatedSize = descriptionLabel.sizeThatFits(size)
        
        descriptionViewHeightConstraint.constant = descriptionViewHeightConstraint.constant == 140 ? estimatedSize.height + 85 : 140

        UIView.animate(withDuration: 0.55, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.scrollView.updateContentView()
        }
    }
}
