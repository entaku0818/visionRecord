//
//  ContentView.swift
//  visionRecord
//
//  Created by 遠藤拓弥 on 2024/07/06.
//

import SwiftUI
import RealityKit
import RealityKitContent

import SwiftUI
import RealityKit

struct ContentView: View {
    @StateObject private var audioRecorder = AudioRecorder()

    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            Text("Hello, world!")

            HStack {
                Button(action: {
                    if audioRecorder.isRecording {
                        audioRecorder.stopRecording()
                    } else {
                        audioRecorder.startRecording()
                    }
                }) {
                    Text(audioRecorder.isRecording ? "Stop Recording" : "Start Recording")
                        .padding()
                        .background(audioRecorder.isRecording ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }

                Button(action: {
                    if audioRecorder.isPlaying {
                        audioRecorder.stopPlayback()
                    } else {
                        audioRecorder.startPlayback()
                    }
                }) {
                    Text(audioRecorder.isPlaying ? "Stop Playback" : "Start Playback")
                        .padding()
                        .background(audioRecorder.isPlaying ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding(.leading, 20)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
