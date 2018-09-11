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
    let penetration: Double
    
    init(particles: [Particle], restitution: Double, contactNormal: PGVector3, penetration: Double = 0) {
        self.particles = particles
        self.restitution = restitution
        self.contactNormal = contactNormal
        self.penetration = penetration
    }
    
    private func resolveVelocity(duration: Double) {
        let separatingVelocity = calculateSeparatingVelocity()
        guard separatingVelocity <= 0 else { return }
        var newSeparatingVelocity = -restitution * separatingVelocity
        
        // Adjust new separating velocity for resting contacts
        newSeparatingVelocity = processNewSeparatingVelocityForRestingContacts(newSeparatingVelocity: newSeparatingVelocity,
                                                                               duration: duration)
        
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
    
    private func processNewSeparatingVelocityForRestingContacts(newSeparatingVelocity: Double, duration: Double) -> Double {
        var accelerationCausedByVelocity = particles[0].acceleration
        if particles.count > 1 {
            accelerationCausedByVelocity -= particles[1].acceleration
        }
        let accelerationCausedSeparatingVelocity = accelerationCausedByVelocity * contactNormal * duration
        if accelerationCausedSeparatingVelocity < 0 {
            let newSeparatingVelocityAfterProcessing = newSeparatingVelocity + restitution * accelerationCausedSeparatingVelocity
            return max(0, newSeparatingVelocityAfterProcessing)
        } else {
            return newSeparatingVelocity
        }
    }
    
    func calculateSeparatingVelocity() -> Double {
        var relativeVelocity = particles[0].velocity
        if particles.count > 1 {
            relativeVelocity -= particles[1].velocity
        }
        return relativeVelocity * contactNormal
    }
    
    func resolveInterpenetration(duration: Double) {
        guard penetration > 0 else { return }
        var totalInverseMass = particles[0].inverseMass
        if particles.count > 1 {
            totalInverseMass += particles[1].inverseMass
        }
        // If all particles have infinite mass, do nothing.
        if totalInverseMass <= 0 { return }
        let movementPerInverseMass = contactNormal * (penetration / totalInverseMass)
        let firstParticleMovement = movementPerInverseMass * particles[0].inverseMass
        var secondParticleMovement: PGVector3?
        if particles.count > 1 {
            secondParticleMovement = movementPerInverseMass * -particles[1].inverseMass
        }
        particles[0].position += firstParticleMovement
        if let secondParticleMovement = secondParticleMovement {
            particles[1].position += secondParticleMovement
        }
    }
}
