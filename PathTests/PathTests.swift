//
//  PathTests.swift
//  PathTests
//
//  Created by Christian Otkjær on 01/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
@testable import Path
//import Arithmetic

class PathTests: XCTestCase
{
    let path = UIBezierPath()
    
    override func setUp()
    {
        path.moveToPoint(CGPoint(x: 10, y: 10))
        path.addLineToPoint(CGPoint(x: 20, y: 20))
        path.addQuadCurveToPoint(CGPoint(x: 100, y: 10), controlPoint: CGPoint(x: 50, y: 100))
        path.addCurveToPoint(CGPoint(x: 50, y: 0), controlPoint1: CGPoint(x: 75, y: 100), controlPoint2: CGPoint(x: 10, y: -100))
        path.closePath()
    }
    
    func test_elements()
    {
        let oval = UIBezierPath(ovalInRect: CGRect(origin: CGPointZero, size: CGSize(width: 100, height: 100)))
        
        XCTAssertGreaterThan(oval.elements.count, 2)
        
        XCTAssertEqual(path.elements.count, 5)
        
        XCTAssertEqual(path.elements[1], PathElement.AddLineToPoint(CGPoint(x: 20, y: 20)))
    }
    
    func test_init_elements()
    {
        XCTAssertEqual(UIBezierPath(elements: []).elements.count, 0)
        
        XCTAssertEqual(UIBezierPath(elements: path.elements).elements.count, 5)

        XCTAssertEqual(UIBezierPath(elements: [PathElement.MoveToPoint(CGPointZero)]).elements.count, 1)
    }

    func test_image()
    {
        path.lineWidth = 5
        path.setLineDash([2,2])
        path.lineJoinStyle = .Round
        
        let image = path.image(strokeColor: UIColor.redColor(), fillColor: UIColor.whiteColor(), backgroundColor: nil)
        
        XCTAssertNotNil(image)
    }
    
    
    func test_equality()
    {
        let p1 = UIBezierPath()
        let p2 = UIBezierPath()
        
        XCTAssert(p1 == p1)
        XCTAssert(p2 == p2)
        XCTAssert(p1 == p2)
        XCTAssertFalse(p1 === p2)
        
        let point = CGPoint(3,4)
        
        p1.moveToPoint(point)
        XCTAssert(p1 != p2)
        
        p2.moveToPoint(point)
        XCTAssert(p1 == p2)
        
        let p3 = UIBezierPath()
        
        p3.moveToPoint(CGPoint(x: 10, y: 10))
        p3.addLineToPoint(CGPoint(x: 20, y: 20))
        p3.addQuadCurveToPoint(CGPoint(x: 100, y: 10), controlPoint: CGPoint(x: 50, y: 100))
        p3.addCurveToPoint(CGPoint(x: 50, y: 0), controlPoint1: CGPoint(x: 75, y: 100), controlPoint2: CGPoint(x: 10, y: -100))
        p3.closePath()
        
        XCTAssertEqual(p3, path)
    }

}
