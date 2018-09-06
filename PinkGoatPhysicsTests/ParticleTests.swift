//
//  ParticleTests.swift
//  PinkGoatPhysicsTests
//
//  Created by Roy Li on 9/6/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import XCTest
@testable import PinkGoatPhysics

class ParticleTests: XCTestCase {

    func testMass() {
        let particle = Particle(position: PGVector3(), velocity: PGVector3(), acceleration: PGVector3(), damping: 0.5, mass: 5)
        XCTAssertEqual(particle.inverseMass, 1 / 5)
        particle.mass = 10
        XCTAssertEqual(particle.inverseMass, 1 / 10)
        particle.mass = 0
        XCTAssertEqual(particle.inverseMass, 0)
    }
}
