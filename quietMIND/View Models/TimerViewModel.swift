//
//  TimerPageViewModel.swift
//  quietMind
//
//  Created by Ameen Mustafa on 1/16/22.
//

import Foundation
import SwiftUI
import AVFoundation

class TimerViewModel: ObservableObject {
    
    // this is probably what causes the profile click thing
    @Published var timerModel: TimerModel = TimerModel()
    // what if timer is moved here? that way view does not deal with logic
    // or should it be in model?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var audioPlayer: AVAudioPlayer!
    @State private var isSerialKiller = UserDefaults.standard.bool(forKey: "isSerialKiller")
    
    init(){
        self.timerModel = timerModel
        self.timerModel.timerVal = self.timerModel.timerVal
    }
    
    func startTimer(){
        if self.timerModel.timerVal > 0 && self.timerModel.paused == false {
            self.timerModel.timerVal -= 1
        }
    }
    
    func setInitTime(){
        self.timerModel.timerVal *= 60
    }
    
    func timeString(time: Int) -> String {
        let minutes = self.timerModel.timerVal / 60 % 60
        let seconds = self.timerModel.timerVal % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func getTimerVal() -> Int {
        return self.timerModel.timerVal
    }
    
    func getChosenSound() -> String {
        return self.timerModel.chosenSound
    }
    
    func getInitialTime() -> Int {
        return self.timerModel.initialTime
    }
    
    func getPaused() -> Bool {
        return self.timerModel.paused
    }
    
    func pressPause() {
        self.timerModel.paused = !self.timerModel.paused
    }
    
    func getSounds() -> [String]{
        if isSerialKiller == true {
            return self.timerModel.soundsDark
        } else {
            return self.timerModel.soundsLight
        }
    }
    
    func getTimes() -> [Int] {
        return self.timerModel.times
    }
    
    func playSounds(_ sound: String){

        // selecting none prints sound:
        guard sound != "None" else {
            return
        }

        guard let soundURL = Bundle.main.url(forResource: sound, withExtension: ".mp3") else {
            fatalError("Unable to find \(sound) in bundle")
        }

        // needs to be separate method?
        if sound == "ding" {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer.play()
            } catch {
                print(error.localizedDescription)
            }
        } else {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer.play()
                audioPlayer.numberOfLoops = -1
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

