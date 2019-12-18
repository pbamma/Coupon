//
//  ViewController.swift
//  ibotta
//
//  Created by Philip Starner on 11/5/19.
//  Copyright © 2019 Philip Starner. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    weak var collectionView: UICollectionView!
    
    //collectionView cell sizes and margins
    var cellAspectRatio = CGFloat(38.0/43.0)
    let margin = CGFloat(12.0)
    let centerMargin = CGFloat(12.0)
    
    //feed service and offer list
    var feedService = FeedService()
    var offers:[OfferViewModel]?
    var selectedOffer:OfferViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ibotta"
        setupCollectionView()
        setupFeed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    /** setup the collection view UI */
    func setupCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        self.collectionView = collectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(MasterCollectionViewCell.self, forCellWithReuseIdentifier: MasterCollectionViewCell.identifier)
        
        self.collectionView.reloadData()
    }
    
    /** create a call to setup the offers and display them in the collection view */
    func setupFeed() {
        //uncomment this test the included feed from the application bundle
        feedService.fetchMockFeed{ [weak self] (vmFeed) in
            self?.offers = vmFeed
            self?.collectionView.reloadData()
        }
        
        //uncomment this test call to get meal data which can populate this feed.
//        feedService.fetchTestMealFeed{ [weak self] (vmFeed) in
//            self?.offers = vmFeed
//            self?.collectionView.reloadData()
//        }
    }
}

extension MasterViewController :UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let theOffers = self.offers {
            return theOffers.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MasterCollectionViewCell.identifier, for: indexPath) as! MasterCollectionViewCell
        
        if let offer = self.offers?[indexPath.item] {
            cell.loadViewModel(offer: offer)
        }
        
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let offer = self.offers?[indexPath.item] {
            self.selectedOffer = offer
            let vc = DetailViewController(offer: offer)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension MasterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (self.margin*2.0) - centerMargin) / 2
        let height = width*self.cellAspectRatio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}

