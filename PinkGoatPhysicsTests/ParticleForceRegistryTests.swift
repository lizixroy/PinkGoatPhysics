//
//  ParticleForceRegistryTests.swift
//  PinkGoatPhysicsTests
//
//  Created by Roy Li on 9/6/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import XCTest
@testable import PinkGoatPhysics

class ParticleForceRegistryTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testRegistry() {
        let particle1 = Particle(position: PGVector3(), velocity: PGVector3(), acceleration: PGVector3(), damping: 1, mass: 1)
        let particle2 = Particle(position: PGVector3(), velocity: PGVector3(), acceleration: PGVector3(), damping: 1, mass: 1)
        let forceGenerator1 = MockParticleForceGenerator()
        let forceGenerator2 = MockParticleForceGenerator()
        let registry = ParticleForceRegistry()
        registry.add(particle: particle1, forceGenerator: forceGenerator1)
        registry.add(particle: particle2, forceGenerator: forceGenerator2)
        registry.updateForces(duration: 1.0)
        XCTAssertNotNil(forceGenerator1.particleUpdated)
        XCTAssertNotNil(forceGenerator2.particleUpdated)
        
        forceGenerator1.particleUpdated = nil
        forceGenerator2.particleUpdated = nil
        
        registry.remove(particle: particle1, forceGenerator: forceGenerator1)
        registry.updateForces(duration: 1.0)
        XCTAssertNil(forceGenerator1.particleUpdated)
        XCTAssertNotNil(forceGenerator2.particleUpdated)
        
        forceGenerator1.particleUpdated = nil
        forceGenerator2.particleUpdated = nil

        registry.remove(particle: particle2, forceGenerator: forceGenerator2)
        registry.updateForces(duration: 1.0)
        XCTAssertNil(forceGenerator1.particleUpdated)
        XCTAssertNil(forceGenerator2.particleUpdated)
        
        registry.add(particle: particle1, forceGenerator: forceGenerator1)
        registry.add(particle: particle2, forceGenerator: forceGenerator2)
        registry.clear()
        registry.updateForces(duration: 1.0)

        XCTAssertNil(forceGenerator1.particleUpdated)
        XCTAssertNil(forceGenerator2.particleUpdated)
    }
    
}
