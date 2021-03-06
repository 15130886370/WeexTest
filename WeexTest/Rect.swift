//
//  Rect.swift
//  WeexTest
//
//  Created by ittmomWang on 17/4/21.
//  Copyright © 2017年 ittmomWang. All rights reserved.
//

import Foundation
import UIKit

struct Rect {
    static let SCREENW = UIScreen.main.bounds.width
    static let SCREENH = UIScreen.main.bounds.height
}

protocol mySize {}

extension UIView: mySize {}

extension mySize where Self: UIView {
    
    var width: CGFloat {
        get{
            return self.frame.width
        }
        
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get{
            return self.frame.height
        }
        
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var centerX: CGFloat {
        get{
            return self.center.x
        }
        
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var centerY: CGFloat {
        get{
            return self.center.y
        }
        
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    var size: CGSize {
        
        get{
            return self.frame.size
        }
        
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
}
