//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Tommy Tran on 05/10/2018.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var favoritLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var profilePictureIV: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    var tweet: Tweet!{
        didSet{
            tweetLabel.text = tweet.text
            usernameLabel.text = tweet.user?.name
            timestampLabel.text = tweet.createdAtString
          
           
           
        //    favoritLabel.text = String(tweet.favoriteCount)
          //  profilePictureIV.af_setImage(withURL: tweet.user?.profilePictureURL!)
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

}
