//
//  MainCustomTableViewCell.swift
//  XRCustomProgressView
//
//  Created by xuran on 2017/10/1.
//  Copyright © 2017年 xuran. All rights reserved.
//

import UIKit

class MainCustomTableViewCell: UITableViewCell {

    var yearEarningsPrecentView: XRCirclePercentProgressView!
    var paillarProgressView: XRPaillarProgressView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        yearEarningsPrecentView = XRCirclePercentProgressView(frame: .zero)
        self.contentView.addSubview(yearEarningsPrecentView)
        
        paillarProgressView = XRPaillarProgressView(frame: CGRect.zero)
        self.contentView.addSubview(paillarProgressView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yearEarningsPrecentView.frame = CGRect(x: 20, y: (self.contentView.frame.size.height - 110.0) * 0.5, width: 110, height: 110)
        paillarProgressView.frame = CGRect(x: yearEarningsPrecentView.frame.maxX + 20, y: (self.contentView.frame.size.height - 18) * 0.5, width: 180, height: 18)
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
