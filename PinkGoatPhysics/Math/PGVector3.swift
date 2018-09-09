//
//  PGVector3.swift
//  PinkGoatPhysics
//
//  Created by Roy Li on 9/3/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import Foundation

public struct PGVector3 {
    var x: Double;
    var y: Double;
    var z: Double;
    
    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init() {
        self.init(x: 0, y: 0, z: 0)
    }
    
    public mutating func invert() {
        self.x = -x
        self.y = -y
        self.z = -z
    }
    
    var magnitude: Double {
        return sqrt(x*x + y*y + z*z)
    }
    
    var squaredMagnitude: Double {
        return x*x + y*y + z*z
    }
    
    mutating func normalize() {
        self *= (1.0 / self.magnitude)
    }
    
    mutating func addScaledVector(vector: PGVector3, scale: Double) {
        self += (vector * scale)
    }
    
    func vectorProduct(vector: PGVector3) -> PGVector3 {
        return PGVector3(
            x: self.y * vector.z - self.z * vector.y,
            y: self.z * vector.x - self.x * vector.z,
            z: self.x * vector.y - self.y * vector.x)
    }
    
    static func makeOrthonormalBasis(vectorA: PGVector3, vectorB: PGVector3) throws -> [PGVector3] {
        var vectorACopy = PGVector3(x: vectorA.x, y: vectorA.y, z: vectorA.z)
        vectorACopy.normalize()
        var vectorC = vectorACopy.vectorProduct(vector: vectorB)
        guard vectorC.magnitude != 0 else {
            throw VectorError.parallelVectors
        }
        vectorC.normalize()
        let newVectorB = vectorC.vectorProduct(vector: vectorACopy)
        return [vectorACopy, newVectorB, vectorC]
    }
}

extension PGVector3 {
    static func *=(lhs: inout PGVector3, scalar: Double) {
        lhs.x *= scalar
        lhs.y *= scalar
        lhs.z *= scalar
    }
    
    static func *(lhs: PGVector3, scalar: Double) -> PGVector3 {
        return PGVector3(x: lhs.x * scalar, y: lhs.y * scalar, z: lhs.z * scalar)
    }
    
    static func +=(lhs: inout PGVector3, rhs: PGVector3) {
        lhs.x += rhs.x
        lhs.y += rhs.y
        lhs.z += rhs.z
    }
    
    static func +(lhs: PGVector3, rhs: PGVector3) -> PGVector3 {
        return PGVector3(
            x: lhs.x + rhs.x,
            y: lhs.y + rhs.y,
            z: lhs.z + rhs.z
        )
    }
    
    static func -=(lhs: inout PGVector3, rhs: PGVector3) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
        lhs.z -= rhs.z
    }
    
    static func -(lhs: PGVector3, rhs: PGVector3) -> PGVector3 {
        return PGVector3(
            x: lhs.x - rhs.x,
            y: lhs.y - rhs.y,
            z: lhs.z - rhs.z)
    }
    
    // Dot product or scalar product
    static func *(lhs: PGVector3, rhs: PGVector3) -> Double {
        return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z
    }
}

extension PGVector3: CustomStringConvertible {
    public var description: String {
        return "[x: \(x), y: \(y), z: \(z)]"
    }
}

enum VectorError: Error {
    case parallelVectors
}
