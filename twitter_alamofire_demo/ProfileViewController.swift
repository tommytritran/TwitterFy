//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tommy Tran on 15/10/2018.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var followersCountLAbel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var tweets: [Tweet] = []
    var user: User! = User.current!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

}
