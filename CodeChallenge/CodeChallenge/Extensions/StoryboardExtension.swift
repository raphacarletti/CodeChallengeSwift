//
//  StoryboardExtension.swift
//  CodeChallenge
//
//  Created by Raphael Carletti on 7/24/18.
//  Copyright © 2018 Raphael Carletti. All rights reserved.
//

import UIKit

extension UIStoryboard {
    convenience init(name: StoryboardName) {
        self.init(name: name.rawValue, bundle: nil)
    }
    
    func instantiateViewController(vcName: ViewControllerName?, isInitial: Bool = false) -> UIViewController? {
        if isInitial, let vc = self.instantiateInitialViewController() {
            return vc
        } else if let vcName = vcName {
            return self.instantiateViewController(withIdentifier: vcName.rawValue)
        }
        return nil
    }
    
}
