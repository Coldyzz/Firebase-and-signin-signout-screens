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
