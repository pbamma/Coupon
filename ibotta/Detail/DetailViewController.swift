//
//  DetailViewCellViewController.swift
//  ibotta
//
//  Created by Philip Starner on 11/6/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var offer: OfferViewModel
    weak var imageThumbView: UIImageView!
    weak var descriptionLabel: UILabel!
    weak var termsLabel: UILabel!
    weak var likeButton: UIButton!
    weak var imageLikeView: UIImageView!

    
    /** DI constructor */
    init(offer: OfferViewModel) {
        self.offer = offer
        super.init(nibName: nil, bundle: nil)
    }

    /** This may not be initialized from IB */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Constants.AppColors.backgroundColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupViews()
    }
    
    /** setup all views within this controller */
    private func setupViews() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        descriptionLabel.textColor = Constants.AppColors.cellTextColor
        self.view.addSubview(descriptionLabel)
        
        let termsLabel = UILabel(frame: .zero)
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        termsLabel.textColor = Constants.AppColors.cellTextColor
        termsLabel.numberOfLines = 0
        termsLabel.sizeToFit()
        self.view.addSubview(termsLabel)
        
        let imageLike = UIImage(named: "like")
        let imageLikeView = UIImageView(image: imageLike)
        imageLikeView.translatesAutoresizingMaskIntoConstraints = false
        imageLikeView.contentMode = .scaleAspectFit
        self.view.addSubview(imageLikeView)
        
        let likeButton = UIButton()
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        likeButton.setTitle("Favorite", for: .normal)
        likeButton.layer.cornerRadius = 5
        likeButton.backgroundColor = Constants.AppColors.companyGreen
        likeButton.setTitleColor(Constants.AppColors.companyPink, for: .normal)
        likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        
        self.view.addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -8),
            self.view.widthAnchor.constraint(equalTo: imageView.widthAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),

            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            termsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            termsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            termsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            termsLabel.bottomAnchor.constraint(lessThanOrEqualTo: likeButton.topAnchor, constant: -8),

            likeButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            likeButton.heightAnchor.constraint(equalToConstant: 50),
            likeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            likeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16),
            
            
            imageLikeView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            imageLikeView.heightAnchor.constraint(equalTo: imageLikeView.widthAnchor),
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: imageLikeView.topAnchor, constant: 0),
            self.view.rightAnchor.constraint(equalTo: imageLikeView.rightAnchor, constant: 0),
        ])
        
        self.imageThumbView = imageView
        self.imageLikeView = imageLikeView
        self.descriptionLabel = descriptionLabel
        self.termsLabel = termsLabel
        self.likeButton = likeButton
        
        //populate with vm
        self.descriptionLabel.text = offer.description
        self.termsLabel.text = offer.terms
        if let imageUrl = offer.url {
            let url = URL(string: imageUrl)
            self.imageThumbView.sd_setImage(with: url)
        }
        self.imageLikeView.isHidden = !offer.favorite
    }
    
    /** Action executed from likeButton `Favorite` */
    @objc func likeButtonAction(sender: UIButton!) {
        self.offer.favorite = !self.offer.favorite
        self.imageLikeView.isHidden = !offer.favorite
    }
}
