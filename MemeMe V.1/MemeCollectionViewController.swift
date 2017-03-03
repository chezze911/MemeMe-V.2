//
//  MemeCollectionViewController.swift
//  MemeMe V.1
//
//  Created by Chi Nguyen on 2017/02/22.
//  Copyright © 2017 udacity. All rights reserved.
//

import UIKit

let reuseIdentifier = "MemeCollectionViewCell"
let didSelectItemAtIdentifier = "MemeDetailViewController"
let addMemeIdentifer = "MemeEditorViewController"

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet var collectionViewMain: UICollectionView!
    
    var memes: [Meme] { return (UIApplication.shared.delegate as! AppDelegate).memes }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //portrait orientation
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionViewMain?.reloadData()
    }
    // Return number of items in memes array
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    // Configure collection view cells for each meme
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.backgroundView = UIImageView(image: meme.memedImage)
        
        return cell
    }
   //
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        // Grab the DetailViewController from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: reuseIdentifier) as! MemeDetailViewController
        
        // Populate view controller with data from the selected item
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    @IBAction func addMeme(_ sender: Any) {
        performSegue(withIdentifier: addMemeIdentifer, sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == addMemeIdentifer) {
            _ = segue.destination as! MemeEditorViewController
        }
    }
}

