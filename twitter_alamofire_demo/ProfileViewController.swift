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
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var screennameLabel: UILabel!
    var tweets: [Tweet] = []
    var user: User! = User.current!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
        refreshData()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTweetCell", for: indexPath) as! ProfileTweetCell
        cell.tweet = tweets[indexPath.row]
        return cell;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func fetchData(){
        APIManager.shared.getUserTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    func refreshData(){
        tweetCountLabel.text = self.user.tweetCount
        followersCountLabel.text = self.user.followers
        followingCountLabel.text = self.user.following
        profileImage.af_setImage(withURL: self.user.profilePictureURL!)
        usernameLabel.text = self.user.name
        screennameLabel.text = self.user.screenName
    }

}
