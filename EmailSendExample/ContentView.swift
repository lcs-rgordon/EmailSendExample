//
//  ContentView.swift
//  EmailSendExample
//
//  Created by Russell Gordon on 2021-03-29.
//

import SwiftUI

struct ContentView: View {
    
    // What to say in the email
    @State private var recipient = ""
    @State private var subject = ""
    @State private var messageBody = ""
    
    // Whether to show the alert
    @State private var showingAlert = false
    
    // URL that will open if the user wants to learn how to add an email account
    @Environment(\.openURL) var openURL
    
    var body: some View {
        
        Form {
            
            Section(header: Text("Sending to whom?")) {
                TextField("e.g.: someone@xyz.com", text: $recipient)
            }

            Section(header: Text("What is the subject?")) {
                TextField("e.g.: Read me right now... urgent!", text: $subject)
            }

            Section(header: Text("What do you want to say?")) {
                TextEditor(text: $messageBody)
            }
            
            Button("Send email") {
                do {
                    // Invoke the static property on the EmailHelper class and send an email using the phone's configured email client
                    try EmailHelper.shared.sendEmail(subject: subject, body: messageBody, to: recipient)
                } catch {
                    showingAlert = true
                }
            }
            
            
        }
        .navigationTitle("Email Send Test")
        .alert(isPresented: $showingAlert) {

            Alert(
                 title: Text("Cannot send email"),
                 message: Text("No email client is configured. Please add an email account to your device."),
                 primaryButton: .default(Text("Learn How")) {
                    openURL(URL(string: "https://support.apple.com/en-us/HT201320")!)
                 },
                secondaryButton: .default(Text("Not Now"))
             )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
