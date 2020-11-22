//
//  HighscoreScene.swift
//  Jack The Giant
//
//  Created by Oscar Rodriguez Garrucho on 2/2/18.
//  Copyright © 2018 Main 3.0. All rights reserved.
//

import SpriteKit


class HighscoreScene : SKScene {
    
    private var scoreLabel: SKLabelNode?;
    private var coinLabel: SKLabelNode?;
    
    override func didMove(to view: SKView) {
        initializeVariables();
        setScoreAndCoin();
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Back" {
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
                
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 0.9))
                
            }
        }
        
    }
    
    private func initializeVariables() {
        scoreLabel = self.childNode(withName: "Score Label") as? SKLabelNode;
        coinLabel = self.childNode(withName: "Coin Label") as? SKLabelNode;
    }
    
    private func setScoreAndCoin() {
        if (GameManager.instance.getEasyDifficulty()) {
            scoreLabel?.text = String(GameManager.instance.getEasyDifficultyScore());
            coinLabel?.text = String(GameManager.instance.getEasyDifficultyCoinScore());
        }
        else if (GameManager.instance.getMediumDifficulty()) {
            scoreLabel?.text = String(GameManager.instance.getMediumDifficultyScore());
            coinLabel?.text = String(GameManager.instance.getMediumDifficultyCoinScore());
        }
        else if (GameManager.instance.getHardDifficulty()) {
            scoreLabel?.text = String(GameManager.instance.getHardDifficultyScore());
            coinLabel?.text = String(GameManager.instance.getHardDifficultyCoinScore());
        }
    }
    
}
