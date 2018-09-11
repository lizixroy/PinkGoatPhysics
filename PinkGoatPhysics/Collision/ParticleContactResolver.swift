//
//  ParticleContactResolver.swift
//  PinkGoatPhysics
//
//  Created by Roy Li on 9/10/18.
//  Copyright © 2018 Roy Li. All rights reserved.
//

import Foundation

public class ParticleContactResolver {
    private let iterations: UInt16
    private var iterationsUsed: UInt16 = 0
    
    init(iterations: UInt16) {
        self.iterations = iterations
    }
    
    func resolveContacts(contacts: [ParticleContact], numberOfContacts: uint32, duration: Double) {
        var index = 0
        while (index < iterations) {
            let separatingVelocity = contacts[index].calculateSeparatingVelocity()
            // TODO: implement the rest.
        }
    }
}
