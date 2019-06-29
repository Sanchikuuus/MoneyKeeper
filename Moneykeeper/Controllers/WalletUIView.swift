//
//  walletUIVew.swift
//  Moneykeeper
//
//  Created by Sashko Shel on 6/23/19.
//  Copyright © 2019 Sashko Shel. All rights reserved.
//

import UIKit

@IBDesignable class WalletUIView: UIView {
    
    override func draw(_ rect: CGRect) {
        print("+++")
        super.draw(rect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("---")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.layer.cornerRadius = 10
//        layer.shadowOffset = CGSize(width: 0, height: -1)
//        layer.shadowOpacity = 0.1
        print("???")
    }
    
}


