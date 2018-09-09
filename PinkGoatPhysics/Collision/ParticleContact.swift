//
//  ParticleContact.swift
//  PinkGoatPhysics
//
//  Created by Roy Li on 9/9/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import Foundation

class ParticleContact {
    let particles: [Particle]
    let restitution: Double
    let contactNormal: PGVector3
    
    init(particles: [Particle], restitution: Double, contactNormal: PGVector3) {
        self.particles = particles
        self.restitution = restitution
        self.contactNormal = contactNormal
    }
    
    private func resolveVelocity(duration: Double) {
        let separatingVelocity = calculateSeparatingVelocity()
        guard separatingVelocity <= 0 else { return }
        let newSeparatingVelocity = -restitution * separatingVelocity
        let deltaVelocity = newSeparatingVelocity - separatingVelocity
        
        var totalInverseMass = particles[0].inverseMass
        if particles.count > 1 {
            totalInverseMass += particles[1].inverseMass
        }
        // If all particles have infinite mass, then impulse hav no effect.
        guard totalInverseMass > 0 else { return }
        let impulse = deltaVelocity / totalInverseMass
        
        let impulsePerInverseMass = contactNormal * impulse
        particles[0].velocity = particles[0].velocity + impulsePerInverseMass * particles[0].inverseMass
        if particles.count > 1 {
            particles[1].velocity = particles[1].velocity + impulsePerInverseMass * particles[1].inverseMass
        }
    }
    
    func calculateSeparatingVelocity() -> Double {
        var relativeVelocity = particles[0].velocity
        if particles.count > 1 {
            relativeVelocity -= particles[1].velocity
        }
        return relativeVelocity * contactNormal
    }
}
