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
    @IBOutlet var tableView: UITableView!

    let addMemeIdentifer = "MemeEditorViewController"
    
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
            tableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == addMemeIdentifer) {
            _ = segue.destination as! MemeEditorViewController
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    //Configure tableView cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as UITableViewCell!
        let meme = memes[indexPath.row]
        
        cell?.imageView?.image = meme.memedImage
        cell?.textLabel?.text = "\(meme.topTextField) \(meme.bottomTextField)"
        
        return cell!
    }
    //Show detailView from selection
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController")
        let detailVC = object as! MemeDetailViewController
        
        //pass data from selected row to detail View
        detailVC.meme = memes[indexPath.row]
        navigationController!.pushViewController(detailVC, animated: true)
    }
  
}
