//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Tommy Tran on 05/10/2018.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage


class TweetCell: UITableViewCell {

    
    @IBOutlet weak var favoritLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var profilePictureIV: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!{
        didSet{
            tweetLabel.text = tweet.text
            usernameLabel.text = tweet.user?.name
            timestampLabel.text = tweet.createdAtString
            retweetLabel.text = String(tweet.retweetCount!)
            favoritLabel.text = String(tweet.favoriteCount!)
            screenNameLabel.text = tweet.user?.screenName
            profilePictureIV.af_setImage(withURL: tweet.user!.profilePictureURL!)
            
            if tweet.favorited! {
                favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
            }
            if tweet.retweeted! {
                retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
            }

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didTapFavorite(_ sender: Any) {
        if tweet.favorited == false {
            tweet.favorited = true
            tweet.favoriteCount = tweet.favoriteCount!+1
             refreshData()
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
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
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
                
            }
        }
    }
    @IBAction func didTapRetweet(_ sender: Any) {
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
        tweetLabel.text = tweet.text
        usernameLabel.text = tweet.user?.name
        timestampLabel.text = tweet.createdAtString
        retweetLabel.text = String(tweet.retweetCount!)
        favoritLabel.text = String(tweet.favoriteCount!)
        screenNameLabel.text = tweet.user?.screenName
        profilePictureIV.af_setImage(withURL: tweet.user!.profilePictureURL!)
        
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
