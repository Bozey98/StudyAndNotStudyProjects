//
//  Test.swift
//  HackingWithSwift5
//
//  Created by Денис Мусатов on 29.05.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct Test: View {
    @State var output = ""
    @State var inputText = ""
    @State var outputText = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Work with URL")) {
                    Button("Url", action: getUrl)
                    Text("\(output)")
                }
                
                Section(header: Text("Work with TextChecker")) {
                    TextField("Text", text: $inputText)
                    Text("\(outputText)")
                }
            }
        .navigationBarTitle("Test")
        .navigationBarItems(trailing: Button("MEM", action: checkWord))
        }
    }
    
    func getUrl() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContent = try? String(contentsOf: fileURL) {
                output = fileContent
            }
            //output = "\(fileURL)"
        }
        else {
           output = "hui"
        }
    }
    
    func checkWord() {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: outputText.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: outputText, range: range, startingAt: 0, wrap: false, language: "en")
        
        print(misspelledRange.location)
        
        
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
