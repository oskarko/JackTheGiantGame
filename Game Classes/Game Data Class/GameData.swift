//
//  GameData.swift
//  Jack The Giant
//
//  Created by Oscar Rodriguez Garrucho on 8/9/18.
//  Copyright © 2018 Main 3.0. All rights reserved.
//

import Foundation

class GameData: NSObject, NSCoding {
    
    struct Keys {
        static let EasyDifficultScore = "EasyDifficultScore";
        static let MediumDifficultScore = "MediumDifficultScore";
        static let HardDifficultScore = "HardDifficultScore";
        
        static let EasyDifficultCoinScore = "EasyDifficultCoinScore";
        static let MediumDifficultCoinScore = "MediumDifficultCoinScore";
        static let HardDifficultCoinScore = "HardDifficultCoinScore";
        
        static let EasyDifficulty = "EasyDifficulty";
        static let MediumDifficulty = "MediumDifficulty";
        static let HardDifficulty = "HardDifficulty";
        
        static let Music = "Music";
    }
    
    private var easyDifficultyScore = Int32();
    private var mediumDifficultyScore = Int32();
    private var hardDifficultyScore = Int32();
    
    private var easyDifficultyCoinScore = Int32();
    private var mediumDifficultyCoinScore = Int32();
    private var hardDifficultyCoinScore = Int32();
    
    private var easyDifficulty = false;
    private var mediumDifficulty = false;
    private var hardDifficulty = false;

    private var isMusicOn = false;
    
    override init() {}
    
    required init?(coder aDecoder:NSCoder) {
        super.init()
        
        self.easyDifficultyScore = aDecoder.decodeCInt(forKey: Keys.EasyDifficultScore);
        self.easyDifficultyCoinScore = aDecoder.decodeCInt(forKey: Keys.EasyDifficultCoinScore);
        
        self.mediumDifficultyScore = aDecoder.decodeCInt(forKey: Keys.MediumDifficultScore);
        self.mediumDifficultyCoinScore = aDecoder.decodeCInt(forKey: Keys.MediumDifficultCoinScore);
        
        self.hardDifficultyScore = aDecoder.decodeCInt(forKey: Keys.HardDifficultScore);
        self.hardDifficultyCoinScore = aDecoder.decodeCInt(forKey: Keys.HardDifficultCoinScore);
        
        self.easyDifficulty = aDecoder.decodeBool(forKey: Keys.EasyDifficulty);
        self.mediumDifficulty = aDecoder.decodeBool(forKey: Keys.MediumDifficulty);
        self.hardDifficulty = aDecoder.decodeBool(forKey: Keys.HardDifficulty);
        
        self.isMusicOn = aDecoder.decodeBool(forKey: Keys.Music);
    }
    
    func encode(with aCoder: NSCoder) {
        // save our data
        aCoder.encodeCInt(self.easyDifficultyScore, forKey: Keys.EasyDifficultScore);
        aCoder.encodeCInt(self.easyDifficultyCoinScore, forKey: Keys.EasyDifficultCoinScore);
        
        aCoder.encodeCInt(self.mediumDifficultyScore, forKey: Keys.MediumDifficultScore);
        aCoder.encodeCInt(self.mediumDifficultyCoinScore, forKey: Keys.MediumDifficultCoinScore);
        
        aCoder.encodeCInt(self.hardDifficultyScore, forKey: Keys.HardDifficultScore);
        aCoder.encodeCInt(self.hardDifficultyCoinScore, forKey: Keys.HardDifficultCoinScore);
        
        aCoder.encode(self.easyDifficulty, forKey: Keys.EasyDifficulty);
        aCoder.encode(self.mediumDifficulty, forKey: Keys.MediumDifficulty);
        aCoder.encode(self.hardDifficulty, forKey: Keys.HardDifficulty);
        
        aCoder.encode(self.isMusicOn, forKey: Keys.Music);
    }
    
    // getters and setters
    func setEasyDifficultScore(easyDifficultyScore: Int32) {
        self.easyDifficultyScore = easyDifficultyScore;
    }
    
    func setEasyDifficultyCoinScore(easyDifficultyCoinScore: Int32) {
        self.easyDifficultyCoinScore = easyDifficultyCoinScore;
    }
    
    func getEasyDifficultyScore() -> Int32 {
        return self.easyDifficultyScore;
    }
    
    func getEasyDifficultyCoinScore() -> Int32 {
        return self.easyDifficultyCoinScore;
    }
    
    func setMediumDifficultScore(mediumDifficultyScore: Int32) {
        self.mediumDifficultyScore = mediumDifficultyScore;
    }
    
    func setMediumDifficultyCoinScore(mediumDifficultyCoinScore: Int32) {
        self.mediumDifficultyCoinScore = mediumDifficultyCoinScore;
    }
    
    func getMediumDifficultyScore() -> Int32 {
        return self.mediumDifficultyScore;
    }
    
    func getMediumDifficultyCoinScore() -> Int32 {
        return self.mediumDifficultyCoinScore;
    }
    
    func setHardDifficultScore(hardDifficultyScore: Int32) {
        self.hardDifficultyScore = hardDifficultyScore;
    }
    
    func setHardDifficultyCoinScore(hardDifficultyCoinScore: Int32) {
        self.hardDifficultyCoinScore = hardDifficultyCoinScore;
    }
    
    func getHardDifficultyScore() -> Int32 {
        return self.hardDifficultyScore;
    }
    
    func getHardDifficultyCoinScore() -> Int32 {
        return self.hardDifficultyCoinScore;
    }
    
    func setEasyDifficult(easyDifficult: Bool) {
        self.easyDifficulty = easyDifficult
    }
    
    func getEasyDifficult() -> Bool {
        return self.easyDifficulty
    }
    
    func setMediumDifficult(mediumDifficult: Bool) {
        self.mediumDifficulty = mediumDifficult
    }
    
    func getMediumDifficult() -> Bool {
        return self.mediumDifficulty
    }
    
    func setHardDifficult(hardDifficult: Bool) {
        self.hardDifficulty = hardDifficult
    }
    
    func getHardDifficult() -> Bool {
        return self.hardDifficulty
    }
    
    func setIsMusicOn(isMusicOn: Bool) {
        self.isMusicOn = isMusicOn
    }
    
    func getIsMusicOn() -> Bool {
        return self.isMusicOn
    }
    
    
}















