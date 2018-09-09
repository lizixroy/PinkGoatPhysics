//
//  ParticleForceRegistry.swift
//  PinkGoatPhysics
//
//  Created by Roy Li on 9/6/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import Foundation

struct ParticleForceRegistration {
    let particle: Particle
    let forceGenerator: ParticleForceGeneratorProtocol
}

class ParticleForceRegistry {
    private var particleForceRegistrations = [ParticleForceRegistration]()
    
    func add(particle: Particle, forceGenerator: ParticleForceGeneratorProtocol) {
        let registration = ParticleForceRegistration(particle: particle, forceGenerator: forceGenerator)
        particleForceRegistrations.append(registration)
    }
    
    func remove(particle: Particle, forceGenerator: ParticleForceGeneratorProtocol) {
        for (index, registration) in particleForceRegistrations.enumerated() {
            if registration.particle === particle && registration.forceGenerator === forceGenerator {
                particleForceRegistrations.remove(at: index)
                return
            }
        }
    }
    
    func clear() {
        particleForceRegistrations.removeAll()
    }
    
    func updateForces(duration: Double) {
        for registration in particleForceRegistrations {
            registration.forceGenerator.updateForce(particle: registration.particle, duration: duration)
        }
    }
}
