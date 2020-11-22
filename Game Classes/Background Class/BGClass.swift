//
//  BGClass.swift
//  Jack The Giant
//
//  Created by Oscar Rodriguez Garrucho on 29/1/18.
//  Copyright © 2018 Main 3.0. All rights reserved.
//

import SpriteKit


class BGClass : SKSpriteNode {
    
    
    func moveBG(camera: SKCameraNode) {
        
        if self.position.y - self.size.height - 10 > camera.position.y {
            self.position.y -= self.size.height * 3
        }
        
    }
    
}



























