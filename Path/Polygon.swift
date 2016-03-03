//
//  Polygon.swift
//  Path
//
//  Created by Christian Otkjær on 02/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Graphics
import Arithmetic

public extension UIBezierPath
{
    /**
     Initializeses the bezier curve as a N-Sided Convex Regular Polygon
     
     - parameter n: number of sides
     - parameter center: center og the polygon. Default is (0,0)
     - parameter radius: the radius of the circumscribed circle
     - parameter turned: if *true* the polygon is rotated (counterclockwise around center) to let the rightmost edge be vertical. If *false* the rightmost corner is directly right of the center. Default is *false*
     */
    public convenience init(
        convexRegularPolygonWithNumberOfSides n: Int,
        center: CGPoint = CGPointZero,
        circumscribedCircleRadius radius: CGFloat,
        turned: Bool = false)
    {
        precondition(n > 2, "A polygon must have at least three sides")
        
        self.init()
        
        moveToPoint(CGPoint(x: radius, y: 0))
        
        for theta in (1 ..< n).map({ $0 * 2 * π / n } )
        {
            addLineToPoint(CGPoint(x: radius * cos(theta), y: radius * sin(theta)))
        }
        
        closePath()
        
        if turned
        {
            applyTransform(CGAffineTransformMakeRotation(π_2 - π / n))

//            applyTransform(CGAffineTransformMakeRotation(π / CGFloat(n)))
        }
        
        applyTransform(CGAffineTransformMakeTranslation(center.x, center.y))
    }
    
    public convenience init(pentagonWithCenter center: CGPoint = CGPointZero, sideLength: CGFloat, turned: Bool = false)
    {
        self.init(convexRegularPolygonWithNumberOfSides: 5, center: center, circumscribedCircleRadius: sideLength, turned: turned)
    }
}
