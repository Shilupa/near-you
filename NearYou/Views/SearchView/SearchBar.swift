//
//  SearchBar.swift
//  NearYou
//
//  Created by Bibek on 20.4.2023.
//

import SwiftUI
 
/*
 SearchBar used in SerachView where user can search via text or speech
 */
struct SearchBar: View {
    @State private var isRecording = false
    @StateObject var speechRecognizer = SpeechRecognizer()
    @Binding var text: String
    var placeholder: String
    var onSearch: () -> Void
    var onClear: () -> Void
    
    var body: some View {
        HStack {
            
            //Magnifying image
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            //Text-field for search
            TextField(placeholder, text: $text, onCommit: onSearch)
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
           
            // clear button when clicked clears the text field
            if !text.isEmpty {
                Button(action: {
                    text = ""
                    onClear()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            //Recording button used for searching via speech
            Button(action: {
                isRecording.toggle()
                if isRecording {
                    speechRecognizer.transcribe()
                } else {
                    speechRecognizer.stopTranscribing()
                    text = speechRecognizer.transcript
                }
            }, label: {
                Image(systemName: "mic.fill")
                    .foregroundColor(isRecording ? .red : .gray)
            })
            .padding(.horizontal)
        }
        .frame(height: 20)
        .padding(.vertical, 10)
        .background(Color(.systemGray5))
        .cornerRadius(20)
        
    }
}
