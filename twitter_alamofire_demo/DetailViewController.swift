//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tommy Tran on 15/10/2018.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var datestampLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
        
    }
    
    func refreshData(){
        print(tweet)
    }
}
