//
//  AudioRecorder.swift
//  visionRecord
//
//  Created by 遠藤拓弥 on 2024/07/06.
//

import Foundation
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    @Published var isRecording = false
    @Published var isPlaying = false

    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)

            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()

            isRecording = true
        } catch {
            // Error handling
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
    }

    func startPlayback() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.delegate = self
            audioPlayer?.play()

            isPlaying = true
        } catch {
            // Error handling
        }
    }

    func stopPlayback() {
        audioPlayer?.stop()
        isPlaying = false
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension AudioRecorder: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // Handle the recording finished
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
}
