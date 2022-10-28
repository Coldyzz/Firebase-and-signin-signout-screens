//
//  PostCell.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 05.10.2022.
//

import UIKit
import AlamofireImage

class PostCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var photoView: UIImageView!
    let profilesRepository: UserProfilesRepository = FirebaseUserProfilesRepository()
    let authenticatedService: AuthenticationService = FirebaseAuthenticationService()
    var post: Post! {
        didSet {
            titleLabel.text = post.title
            profilesRepository.getOne(userID: post.authorId) { profile in
                guard let profile = profile else {
                    return
                }
                self.authorLabel.text = "\(profile.firstName) \(profile.lastName)"
            }
            let currentUser = authenticatedService.currentUserId()
            if post.authorId == currentUser {
                deleteButton.isHidden = false
            } else {
                deleteButton.isHidden = true
            }
            guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/simplesigninsignup.appspot.com/o/icon-60%403x.png?alt=media") else {
                return
            }
            photoView.af.setImage(withURL: url)
        }
    }
    var onDeleteCompletion: ((Post) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func deleteClicked(_ sender: Any) {
        onDeleteCompletion?(post)
    }
}
