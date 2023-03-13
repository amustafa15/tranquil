//
//  TimerViewController.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 1/17/22.
//

import WatchKit
import SwiftUI
import Foundation
import AVFoundation

class TimerViewModel: ObservableObject {
    
    @Published var timerModel: TimerModel = TimerModel()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var audioPlayer: AVAudioPlayer!
    
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
    
    func getSounds() -> [String] {
        return self.timerModel.soundsLight
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
            
            if sound == "ding" {
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    self.audioPlayer.play()
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    self.audioPlayer.play()
                    self.audioPlayer.numberOfLoops = -1
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
    }
}
