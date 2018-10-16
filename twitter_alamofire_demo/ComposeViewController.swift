//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tommy Tran on 15/10/2018.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate:NSObjectProtocol {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var textview: UITextView!
    
    @IBOutlet weak var wordcountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User.current
        textview.delegate = self
        textview.text = "Compose a tweet.."
        textview.textColor = UIColor.lightGray
        usernameLabel.text = user?.name
        screennameLabel.text = user?.screenName
        profileImage.af_setImage(withURL: (user?.profilePictureURL)!)
        
        textview!.layer.borderWidth = 1
        textview!.layer.borderColor = UIColor.gray.cgColor
        textview.becomeFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textview.text = ""
        textview.textColor = UIColor.black
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textview.text == ""{
            textview.text = "Compose a tweet"
        }
    }

    @IBAction func didTapTweet(_ sender: Any) {
        let tweetText = textview.text
        if ((tweetText?.isEmpty)!){
            print("Tweet empty")
        }else{
            APIManager.shared.composeTweet(with: tweetText!) { (tweet, error) in
                if let error = error {
                    print("Error composing Tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    self.delegate?.did(post: tweet)
                    print("Compose Tweet Success!")
                }
            }
            self.performSegue(withIdentifier: "backTimeline", sender: nil)
        }

    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        wordcountLabel.text = String(characterLimit - newText.count)
        // The new text should be allowed? True/False
        return newText.count < characterLimit
    }
}
