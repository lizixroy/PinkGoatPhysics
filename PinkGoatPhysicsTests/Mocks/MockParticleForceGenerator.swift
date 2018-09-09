//
//  MockParticleForceGenerator.swift
//  PinkGoatPhysicsTests
//
//  Created by Roy Li on 9/6/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import Foundation
@testable import PinkGoatPhysics

class MockParticleForceGenerator: ParticleForceGeneratorProtocol {
    
    var particleUpdated: Particle?
    var durationUsed: Double?
    
    func updateForce(particle: Particle, duration: Double) {
        particleUpdated = particle
        durationUsed = duration
    }
}
