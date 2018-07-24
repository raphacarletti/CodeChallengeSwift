//
//  UIColorExtension.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/23/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import UIKit

extension UIColor {
    public class var lightGrayMovieList: UIColor {
        return UIColor(red: 192/255, green: 200/255, blue: 214/255, alpha: 1)
    }
    public class var mediumGrayMovieDetail: UIColor {
        return UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
    }
    
    public class var blueZodiac: UIColor {
        return UIColor(red: 17/255, green: 31/255, blue: 71/255, alpha: 1)
    }
    public class var darkBlueZodiac: UIColor {
        return UIColor(red: 20/255, green: 36/255, blue: 84/255, alpha: 1)
    }
    public class var TunaGray: UIColor {
        return UIColor(red: 57/255, green: 57/255, blue: 64/255, alpha: 1)
    }
    public class var semiTranslucentWhite: UIColor {
        return UIColor.white.withAlphaComponent(0.8)
    }
}
