//
//  PGMatrix3.swift
//  PinkGoatPhysics
//
//  Created by Roy Li on 9/13/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import Foundation
import SceneKit

public struct PGMatrix3 {
    
    let data: [Double]
    
    init() {
        self.init(m11: 0, m12: 0, m13: 0, m21: 0, m22: 0, m23: 0, m31: 0, m32: 0, m33: 0)
    }
    
    init(m11: Double, m12: Double, m13: Double, m21: Double, m22: Double, m23: Double, m31: Double, m32: Double, m33: Double) {
        self.data = [m11, m12, m13, m21, m22, m23, m31, m32, m33]
    }
    
    func transform(vector: PGVector3) -> PGVector3 {
        return self * vector
    }
}

extension PGMatrix3 {
    static func *(lhs: PGMatrix3, rhs: PGVector3) -> PGVector3 {
        return PGVector3(
            x: lhs.data[0] * rhs.x + lhs.data[1] * rhs.y + lhs.data[2] * rhs.z,
            y: lhs.data[3] * rhs.x + lhs.data[4] * rhs.y + lhs.data[5] * rhs.z,
            z: lhs.data[6] * rhs.x + lhs.data[7] * rhs.y + lhs.data[8] * rhs.z
        )
    }
}
