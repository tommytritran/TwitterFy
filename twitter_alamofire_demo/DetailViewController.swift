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
    
    @IBAction func onReply(_ sender: Any) {
    }
    @IBAction func onFavorite(_ sender: Any) {
        if tweet.favorited == false {
            tweet.favorited = true
            tweet.favoriteCount = tweet.favoriteCount!+1
            refreshData()
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(String(describing: tweet.text))")
                }
            }
        }else{
            tweet.favorited = false
            tweet.favoriteCount = tweet.favoriteCount!-1
            refreshData()
            APIManager.shared.unfavorite(with: tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(String(describing: tweet.text))")
                }
                
            }
        }
    }
    @IBAction func onRetweet(_ sender: Any) {
        if tweet.retweeted == false{
            tweet.retweetCount = tweet.retweetCount!+1
            tweet.retweeted = true
            refreshData()
            APIManager.shared.retweet(with: tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error Retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully Retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }else{
            tweet.retweeted = false
            tweet.retweetCount = tweet.retweetCount!-1
            refreshData()
            APIManager.shared.untweet(with: tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error Unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully Unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    func refreshData(){
        textLabel.text = tweet.text
        usernameLabel.text = tweet.user?.name
        datestampLabel.text = tweet.createdAtString
        retweetCountLabel.text = String(tweet.retweetCount!)
        favoriteCountLabel.text = String(tweet.favoriteCount!)
        screennameLabel.text = tweet.user?.screenName
        profileImage.af_setImage(withURL: tweet.user!.profilePictureURL!)
        
        if tweet.favorited! {
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
        }
        if tweet.favorited! == false{
            favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: UIControlState.normal)
        }
        if tweet.retweeted! {
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
        }
        if tweet.retweeted! == false {
            retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: UIControlState.normal)
        }
    }
}
