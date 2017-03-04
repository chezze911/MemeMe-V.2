//
//  MemeTableViewController.swift
//  MemeMe V.1
//
//  Created by Chi Nguyen on 2017/02/22.
//  Copyright © 2017 udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController{
    
    var memes: [Meme] { return (UIApplication.shared.delegate as! AppDelegate).memes }
    

    let addMemeIdentifer = "MemeEditorViewController"
    @IBOutlet var sentMemesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        //Go straight to editor view if no memes
        if memes.isEmpty {
            performSegue(withIdentifier: addMemeIdentifer, sender: nil)
        }
        else {
            sentMemesTableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == addMemeIdentifer) {
            _ = segue.destination as! MemeEditorViewController
        }
    }
    override func tableView(_ sentMemesTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    //Configure tableView cells
    override func tableView(_ sentMemesTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sentMemesTableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as UITableViewCell!
        let meme = memes[indexPath.row]
        
        cell?.imageView?.image = meme.memedImage
        cell?.textLabel?.text = "\(meme.topTextField!)...\(meme.bottomTextField!)"
        return cell!
    }
    //Show detailView from selection
    func tableView(sentMemesTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        //pass data from selected row to detail View
        detailViewController.selectedMeme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
  
}
