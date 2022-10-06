//
//  PostCell.swift
//  SimpleLoginVC
//
//  Created by Дима Холод on 05.10.2022.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    var post: Post! {
        didSet {
            titleLabel.text = post.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
