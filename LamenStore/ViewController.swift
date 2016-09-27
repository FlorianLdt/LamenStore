//
//  ViewController.swift
//  LamenStore
//
//  Created by Florian LUDOT on 10/09/16.
//  Copyright © 2016 Florian LUDOT. All rights reserved.
//

import UIKit

class FeaturedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    private let largeCellId = "largeCellId"
    
    var appCategories: [AppCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    AppCategory.fetchFeaturedApps { (appCategories) -> () in
        self.appCategories = appCategories
        self.collectionView?.reloadData()
    }
    
        
    collectionView?.backgroundColor = UIColor.whiteColor()
        
    collectionView?.registerClass(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    collectionView?.registerClass(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)

        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(largeCellId, forIndexPath: indexPath) as! LargeCategoryCell
            
            cell.appCategory = appCategories?[indexPath.item]
            
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! CategoryCell
        
        cell.appCategory = appCategories?[indexPath.item]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.item == 2 {
            return CGSizeMake(view.frame.width, 160)
        }
        
        return CGSizeMake(view.frame.width, 230)
    }
}

class LargeCategoryCell: CategoryCell {
    
    private let largeAppCellId = "largeAppCellId"
    
    override func setupViews() {
        super.setupViews()
        appsCollectionView.registerClass(LargeAppCell.self, forCellWithReuseIdentifier: largeAppCellId)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(largeAppCellId, forIndexPath: indexPath) as! AppCell
        
        cell.app = appCategory?.apps?[indexPath.item]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(200, frame.height - 32)
    }

    
    private class LargeAppCell: AppCell {
        private override func setupViews() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options:NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-2-[v0]-14-|", options:NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        }
    }
}
