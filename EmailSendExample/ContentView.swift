//
//  ContentView.swift
//  EmailSendExample
//
//  Created by Russell Gordon on 2021-03-29.
//

import SwiftUI

struct ContentView: View {
    
    @State private var recipient = ""
    @State private var subject = ""
    @State private var messageBody = ""
    
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
                // Invoke the static property on the EmailHelper class and send an email using the phone's configured email client
                // TODO: Implement proper error handling if an email client isn't configured
                EmailHelper.shared.sendEmail(subject: subject, body: messageBody, to: recipient)
            }
            
        }
        .navigationTitle("Email Send Test")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
