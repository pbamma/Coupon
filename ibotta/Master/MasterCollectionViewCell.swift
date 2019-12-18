//
//  MasterCollectionViewCell.swift
//  ibotta
//
//  Created by Philip Starner on 11/5/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import UIKit
import SDWebImage

class MasterCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "cell"
    weak var amountLabel: UILabel!
    weak var nameLabel: UILabel!
    weak var imageBackgroundView: UIView!
    weak var imageThumbView: UIImageView!
    weak var imageLikeView: UIImageView!
    
    /** Cell view initialization */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let amountLabel = UILabel(frame: .zero)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        amountLabel.textColor = Constants.AppColors.cellTextColor
        self.contentView.addSubview(amountLabel)
        
        let nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: "AvenirNext-Regular", size: 11)
        nameLabel.textColor = Constants.AppColors.cellTextColor
        self.contentView.addSubview(nameLabel)
        
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = 5
        self.contentView.addSubview(backgroundView)
        
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageView)
        
        
        let imageLike = UIImage(named: "like")
        let imageLikeView = UIImageView(image: imageLike)
        imageLikeView.translatesAutoresizingMaskIntoConstraints = false
        imageLikeView.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageLikeView)
        
        NSLayoutConstraint.activate([
            self.contentView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            nameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.75),
            self.contentView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 2),
            nameLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 3),
            self.contentView.widthAnchor.constraint(equalTo: amountLabel.widthAnchor, constant: 2),
            
            self.contentView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor),
            self.contentView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 0),
            backgroundView.bottomAnchor.constraint(equalTo: amountLabel.topAnchor, constant: -8),
            
            imageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 6),
            imageView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -6),
            imageView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 6),
            imageView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -6),
            
            imageLikeView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3),
            imageLikeView.heightAnchor.constraint(equalTo: imageLikeView.widthAnchor),
            self.contentView.topAnchor.constraint(equalTo: imageLikeView.topAnchor, constant: 0),
            self.contentView.rightAnchor.constraint(equalTo: imageLikeView.rightAnchor, constant: 0),
        ])
        
        self.amountLabel = amountLabel
        self.nameLabel = nameLabel
        self.imageThumbView = imageView
        self.imageBackgroundView = backgroundView
        self.imageLikeView = imageLikeView
        
        self.amountLabel.textAlignment = .left
        self.nameLabel.textAlignment = .left
        
        self.reset()
    }

    /** This class may not be initialized from IB */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    /**
    Input the OfferViewModel data into the view
     
    - Parameter offer:the OfferViewModel data
     
    */
    func loadViewModel(offer: OfferViewModel) {
        self.amountLabel.text = offer.currentValueString
        self.nameLabel.text = offer.name
        if let imageUrl = offer.url {
            let url = URL(string: imageUrl)
            self.imageThumbView.sd_setImage(with: url)
        }
        self.imageLikeView.isHidden = !offer.favorite
        self.imageBackgroundView.backgroundColor = Constants.AppColors.backgroundColor
    }

    /**
    UICollectionViewCell reusable prepareForReuse() cell cleanup
     
    */
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    /** cell cleanup  */
    func reset() {
        self.nameLabel.text = " "
        self.amountLabel.text = " "
        
        self.imageThumbView.image = nil
        self.imageLikeView.isHidden = true
        self.imageBackgroundView.backgroundColor = .clear
    }
    
}
