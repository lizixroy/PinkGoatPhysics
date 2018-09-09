//
//  ParticleForceGeneratorProtocol.swift
//  PinkGoatPhysics
//
//  Created by Roy Li on 9/6/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import Foundation

protocol ParticleForceGeneratorProtocol: class {
    func updateForce(particle: Particle, duration: Double)
}
