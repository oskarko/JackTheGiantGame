//
//  AudioManager.swift
//  Jack The Giant
//
//  Created by Oscar Rodriguez Garrucho on 12/9/18.
//  Copyright © 2018 Main 3.0. All rights reserved.
//

import AVFoundation

class AudioManager {
    
    static let instance = AudioManager();
    private init() {}
    
    private var audioPlayer: AVAudioPlayer?;
    
    func playBGmusic() {
        
        let url = Bundle.main.url(forResource: "Background music", withExtension: "mp3");
        
        var err: NSError?;
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!);
            audioPlayer?.numberOfLoops = -1; // infinite = -1
            audioPlayer?.prepareToPlay();
            audioPlayer?.play();
        } catch let err1 as NSError {
            err = err1;
        }
        
        if err != nil {
            print("we have a problem")
        }
    }
    
    func stopBGMusic() {
        if (audioPlayer?.isPlaying)! {
            audioPlayer?.stop();
        }
    }
    
    func isAudioPlayerInitialized() -> Bool {
        return audioPlayer == nil;
    }
}














