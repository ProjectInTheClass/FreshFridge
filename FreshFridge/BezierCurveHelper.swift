//
//  BezierCurveHelper.swift
//  FreshFridge
//
//  Created by changae choi on 2021/01/22.
//

import Foundation
import UIKit

// Helper Functions
func CubicBezierCurveFactors(t:CGFloat) -> (CGFloat,CGFloat,CGFloat,CGFloat){
    let t1 = pow(1.0-t, 3.0)
    let t2 = 3.0*pow(1.0-t,2.0)*t
    let t3 = 3.0*(1.0-t)*pow(t,2.0)
    let t4 = pow(t, 3.0)
    
    return  (t1,t2,t3,t4)
}


func QuadBezierCurveFactors(t:CGFloat) -> (CGFloat,CGFloat,CGFloat){
    let t1 = pow(1.0-t,2.0)
    let t2 = 2.0*(1-t)*t
    let t3 = pow(t, 2.0)
    
    return (t1,t2,t3)
}

// Quadratic Bezier Curve
func BezierCurve(t:CGFloat,p0:CGFloat,c1:CGFloat,p1:CGFloat) -> CGFloat{
    let factors = QuadBezierCurveFactors(t: t)
    return (factors.0*p0) + (factors.1*c1) + (factors.2*p1)
}


// Quadratic Bezier Curve
func BezierCurve(t:CGFloat,p0:CGPoint,c1:CGPoint,p1:CGPoint) -> CGPoint{
    let x = BezierCurve(t: t, p0: p0.x, c1: c1.x, p1: p1.x)
    let y = BezierCurve(t: t, p0: p0.y, c1: c1.y, p1: p1.y)
    return CGPoint(x: x, y: y)
}



// Cubic Bezier Curve
func BezierCurve(t:CGFloat,p0:CGFloat, c1:CGFloat, c2:CGFloat, p1:CGFloat) -> CGFloat{
    let factors = CubicBezierCurveFactors(t: t)
    return (factors.0*p0) + (factors.1*c1) + (factors.2*c2) + (factors.3*p1)
}


// Cubic Bezier Curve
func BezierCurve(t: CGFloat, p0:CGPoint, c1:CGPoint, c2: CGPoint, p1: CGPoint) -> CGPoint{
    let x = BezierCurve(t: t, p0: p0.x, c1: c1.x, c2: c2.x, p1: p1.x)
    let y = BezierCurve(t: t, p0: p0.y, c1: c1.y, c2: c2.y, p1: p1.y)
    return CGPoint(x: x, y: y)
}


// Cubic Bezier Curve Length
func BezierCurveLength(p0:CGPoint,c1:CGPoint, c2:CGPoint, p1:CGPoint) -> CGFloat{
    let steps = 12 // on greater samples, more presicion
    
    var current  = p0
    var previous = p0
    var length:CGFloat = 0.0
    
    for i in 1...steps{
        let t = CGFloat(i) / CGFloat(steps)
        current = BezierCurve(t: t, p0: p0, c1: c1, c2: c2, p1: p1)
        length += previous.distance(to: current)
        previous = current
    }
    
    return length
}


// Quadratic Bezier Curve Length
func BezierCurveLength(p0:CGPoint,c1:CGPoint, p1:CGPoint) -> CGFloat{
    let steps = 12 // on greater samples, more presicion
    
    var current  = p0
    var previous = p0
    var length:CGFloat = 0.0
    
    for i in 1...steps{
        let t = CGFloat(i) / CGFloat(steps)
        current = BezierCurve(t: t, p0: p0, c1: c1, p1: p1)
        length += previous.distance(to: current)
        previous = current
    }
    return length
}

extension CGPoint{
    func distance(to:CGPoint) -> CGFloat{
        let dx = pow(to.x - self.x,2)
        let dy = pow(to.y - self.y,2)
        return sqrt(dx+dy)
    }
}
