//
//  Particle.swift
//  PinkGoatPhysics
//
//  Created by Roy Li on 9/5/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import Foundation

public class Particle {
    var position: PGVector3
    var velocity: PGVector3
    var acceleration: PGVector3
    var damping: Double
    var inverseMass: Double
    private var forceAccumulator: PGVector3?
    
    var mass: Double {
        get {
            return 1.0 / inverseMass
        }
        set(newMass) {
            // We treat 0 mass as infinite mass
            if newMass == 0 {
                inverseMass = 0
            } else {
                inverseMass = 1.0 / newMass
            }
        }
    }
    
    init(position: PGVector3, velocity: PGVector3, acceleration: PGVector3, damping: Double, mass: Double) {
        self.position = position
        self.velocity = velocity
        self.acceleration = acceleration
        self.damping = damping
        
        // To calculate acceleration, we use the equation: pʹʹ = (1.0 / mass) * f, so we store mass as the inverse of mass (1.0 / mass).
        // This will help us in the event of having infinite mass, because inverse of mass will be zero if mass is infinite.
        
        self.inverseMass = 1.0 / mass
    }
    
    func integrate(duration: Double) {
        guard inverseMass > 0 else { return }
        guard duration > 0 else { return }
        // Update linear position
        position.addScaledVector(vector: velocity, scale: duration)
        // Update acceleration if needed
        if let forceAccumulator = self.forceAccumulator {
            acceleration.addScaledVector(vector: forceAccumulator, scale: inverseMass)
        }
        velocity.addScaledVector(vector: acceleration, scale: duration)
        // Impose drag
        velocity *= pow(damping, duration)
        clearAccumulator()
    }
    
    func addForce(force: PGVector3) {
        if forceAccumulator == nil {
            forceAccumulator = PGVector3()
        }
        forceAccumulator? += force
    }
    
    private func clearAccumulator() {
        forceAccumulator = nil
    }
}
