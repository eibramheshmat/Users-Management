//
//  mycell.swift
//  Users Management
//
//  Created by IBRAM on 3/21/19.
//  Copyright © 2019 IBRAM. All rights reserved.
//

import UIKit

class mycell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //for design 
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
