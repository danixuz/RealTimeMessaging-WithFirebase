//
//  MessageField.swift
//  DieWithMe
//
//  Created by Daniel Spalek on 27/04/2022.
//

import SwiftUI
import Combine

struct MessageField: View {
    @EnvironmentObject var viewModel: MessagesManager
    @State private var message = ""
    
    var body: some View {
        HStack{
            Button {
                viewModel.sendMessage(text: message)
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15, height: 15)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(.black)
                    .cornerRadius(20)
            }
            CustomTextField(placeholder: Text("הודעה..."), text: $message)

        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color(red: 50/255, green: 50/255, blue: 55/255))
        .cornerRadius(15)
        .padding(7)
    }
}

struct CustomTextField: View{
    let textLimit = 100
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    var body: some View{
        ZStack(alignment: .trailing){
            if text.isEmpty {
                placeholder
                    .opacity(0.5)
            }
            
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .multilineTextAlignment(.trailing)
                .flipsForRightToLeftLayoutDirection(true)
                .onReceive(Just(text)) { _ in
                    limitText(textLimit)
                }
        }
    }
    
    func limitText(_ max: Int){
        if text.count > max {
            text = String(text.prefix(max))
        }
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
            .environmentObject(MessagesManager())
    }
}
