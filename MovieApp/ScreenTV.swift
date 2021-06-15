//
//  ScreenTV.swift
//  MovieApp
//
//  Created by ADMIN on 6/6/21.
//

import UIKit

class ScreenTVView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        
        
        aPath.move(to: CGPoint(x:5, y:50))

        aPath.addCurve(to: CGPoint(x: rect.maxX - 5, y: 50), controlPoint1: CGPoint(x: rect.midX / 2, y: 25), controlPoint2: CGPoint(x: rect.midX * 1.5, y: 25))

               //Keep using the method addLineToPoint until you get to the one where about to close the path


               //If you want to stroke it with a red color
               UIColor.white.set()
        aPath.lineWidth = 5
        aPath.lineCapStyle = .round
        aPath.lineJoinStyle = .round
        aPath.stroke()
       
        
               //If you want to fill it as well
    }

    
}
