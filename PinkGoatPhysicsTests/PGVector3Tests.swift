//
//  PGVector3Tests.swift
//  PinkGoatPhysicsTests
//
//  Created by Roy Li on 9/3/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import XCTest
@testable import PinkGoatPhysics

class PGVector3Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMagnitude() {
        let vector = PGVector3(x: 1, y: 1, z: 1)
        XCTAssertTrue(abs(vector.magnitude - 1.73205) < 0.0001)
    }
    
    func testSquaredMagnitude() {
        let vector = PGVector3(x: 1, y: 1, z: 1)
        XCTAssertTrue(abs(vector.squaredMagnitude - 3) < 0.0001)
    }
    
    func testScalarMultiplication() {
        var vector = PGVector3(x: 1, y: 1, z: 1)
        vector *= 3
        XCTAssertTrue(vector.x == 3)
        XCTAssertTrue(vector.y == 3)
        XCTAssertTrue(vector.z == 3)
    }
    
    func testNormalize() {
        var vector = PGVector3(x: 3, y: 3, z: 3)
        vector.normalize()
        XCTAssertTrue(abs(vector.x - 0.5773502692) < 0.01)
        XCTAssertTrue(abs(vector.y - 0.5773502692) < 0.01)
        XCTAssertTrue(abs(vector.z - 0.5773502692) < 0.01)
    }
    
    func testScalarMultiplcationWithReturn() {
        var vector = PGVector3(x: 1, y: 1, z: 1)
        vector = vector * 3
        XCTAssertTrue(vector.x == 3)
        XCTAssertTrue(vector.y == 3)
        XCTAssertTrue(vector.z == 3)
    }
    
    func testAddition() {
        var vector = PGVector3(x: 1, y: 1, z: 1)
        let vector2 = PGVector3(x: 1, y: 2, z: 3)
        vector += vector2
        XCTAssertEqual(vector.x, 2)
        XCTAssertEqual(vector.y, 3)
        XCTAssertEqual(vector.z, 4)
    }
    
    func testAdditionWithReturn() {
        var vector = PGVector3(x: 1, y: 1, z: 1)
        let vector2 = PGVector3(x: 1, y: 2, z: 3)
        vector = vector + vector2
        XCTAssertEqual(vector.x, 2)
        XCTAssertEqual(vector.y, 3)
        XCTAssertEqual(vector.z, 4)
    }
    
    func testSubtraction() {
        var vector = PGVector3(x: 1, y: 1, z: 1)
        let vector2 = PGVector3(x: 1, y: 2, z: 3)
        vector -= vector2
        XCTAssertEqual(vector.x, 0)
        XCTAssertEqual(vector.y, -1)
        XCTAssertEqual(vector.z, -2)
    }
    
    func testSubtractionWithReturn() {
        var vector = PGVector3(x: 1, y: 1, z: 1)
        let vector2 = PGVector3(x: 1, y: 2, z: 3)
        vector = vector - vector2
        XCTAssertEqual(vector.x, 0)
        XCTAssertEqual(vector.y, -1)
        XCTAssertEqual(vector.z, -2)
    }
    
    func testAddScaledVector() {
        var vector = PGVector3(x: 1, y: 1, z: 1)
        vector.addScaledVector(vector: PGVector3(x: 1, y: 2, z: 3), scale: 2)
        XCTAssertEqual(vector.x, 3)
        XCTAssertEqual(vector.y, 5)
        XCTAssertEqual(vector.z, 7)
    }
    
    func testScalarProduct() {
        let vector = PGVector3(x: 1, y: 2, z: 3)
        let vector2 = PGVector3(x: 3, y: 4, z: 5)
        let scalarProduct = vector * vector2
        XCTAssertEqual(scalarProduct, 26)
    }
    
    func testVectorProduct() {
        let vector = PGVector3(x: 1, y: 2, z: 3)
        let vector2 = PGVector3(x: 3, y: 4, z: 5)
        let vectorProduct = vector.vectorProduct(vector: vector2)
        XCTAssertEqual(vectorProduct.x, -2)
        XCTAssertEqual(vectorProduct.y, 4)
        XCTAssertEqual(vectorProduct.z, -2)
        let vector3 = PGVector3(x: 10, y: 12, z: 13)
        let vector4 = PGVector3(x: 13, y: 14, z: 15)
        let vectorProduct2 = vector3.vectorProduct(vector: vector4)
        XCTAssertEqual(vectorProduct2.x, -2)
        XCTAssertEqual(vectorProduct2.y, 19)
        XCTAssertEqual(vectorProduct2.z, -16)
    }
    
    func testMakeOrthonormalBasis() {
        let vector1 = PGVector3(x: 2, y: 0, z: 2)
        let vector2 = PGVector3(x: 2,y: 2, z: 0)
        let orthonormalBasis = try! PGVector3.makeOrthonormalBasis(vectorA: vector1, vectorB: vector2)
        XCTAssertEqual(orthonormalBasis.count, 3)
        let vectorA = orthonormalBasis[0]
        let vectorB = orthonormalBasis[1]
        let vectorC = orthonormalBasis[2]
        
        XCTAssertTrue(abs(vectorA.x - 0.7071067811865476) < 0.001)
        XCTAssertTrue(abs(vectorA.y - 0) < 0.001)
        XCTAssertTrue(abs(vectorA.z - 0.7071067811865476) < 0.001)
        
        XCTAssertTrue(abs(vectorB.x - 0.40824829) < 0.001)
        XCTAssertTrue(abs(vectorB.y - 0.81649658) < 0.001)
        XCTAssertTrue(abs(vectorB.z - -0.40824829) < 0.001)

        XCTAssertTrue(abs(vectorC.x - -0.57735027) < 0.001)
        XCTAssertTrue(abs(vectorC.y - 0.57735027) < 0.001)
        XCTAssertTrue(abs(vectorC.z - 0.57735027) < 0.001)
    }
}
