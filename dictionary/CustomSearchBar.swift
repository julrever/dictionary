//
//  CustomSearchBar.swift
//  dictionary
//
//  Created by Юля on 14.04.17.
//  Copyright © 2017 jul. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    var preferredFont: UIFont!
    
    var preferredTextColor: UIColor!
    
    init(frame: CGRect, font: UIFont, textColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        preferredFont = font
        preferredTextColor = textColor
        searchBarStyle = UISearchBarStyle.prominent
        isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
