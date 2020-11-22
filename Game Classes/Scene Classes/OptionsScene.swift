//
//  OptionsScene.swift
//  Jack The Giant
//
//  Created by Oscar Rodriguez Garrucho on 2/2/18.
//  Copyright © 2018 Main 3.0. All rights reserved.
//

import SpriteKit


class OptionsScene : SKScene {
    
    private var easyBtn : SKSpriteNode?
    private var mediumBtn : SKSpriteNode?
    private var hardBtn : SKSpriteNode?
    
    private var sign : SKSpriteNode?
    
    override func didMove(to view: SKView) {
        //
        initializeVariables();
        setSign();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location) == easyBtn {
                setDifficulty(difficulty: "easy");
            }
            else if atPoint(location) == mediumBtn {
                setDifficulty(difficulty: "medium");
            }
            else if atPoint(location) == hardBtn {
                setDifficulty(difficulty: "hard");
            }
            setSign();
            
            
            if atPoint(location).name == "Back" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 0.9))
                
            }
            self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
        }
        
    }
    
    func initializeVariables() {
        
        easyBtn = self.childNode(withName: "Easy Button") as? SKSpriteNode
        mediumBtn = self.childNode(withName: "Medium Button") as? SKSpriteNode
        hardBtn = self.childNode(withName: "Hard Button") as? SKSpriteNode
        sign = self.childNode(withName: "Sign") as? SKSpriteNode
    }
    
    func setDifficulty(difficulty: String) {
        // reset values
        GameManager.instance.setEasyDifficult(easyDifficulty: false);
        GameManager.instance.setMediumDifficulty(mediumDifficulty: false);
        GameManager.instance.setHardDifficulty(hardDifficulty: false);
        
        switch difficulty {
        case "easy":
            GameManager.instance.setEasyDifficult(easyDifficulty: true);
            break;
        case "medium":
            GameManager.instance.setMediumDifficulty(mediumDifficulty: true);
            break;
        case "hard":
            GameManager.instance.setHardDifficulty(hardDifficulty: true);
            break;
        default:
            break;
        }
        
        GameManager.instance.saveData();
    }
    
    func setSign() {
        if GameManager.instance.getEasyDifficulty() {
            sign?.position.y = (easyBtn?.position.y)!;
        }
        else if GameManager.instance.getMediumDifficulty() {
            sign?.position.y = (mediumBtn?.position.y)!;
        }
        else if GameManager.instance.getHardDifficulty() {
            sign?.position.y = (hardBtn?.position.y)!;
        }
        sign?.zPosition = 4;
    }
    
}
