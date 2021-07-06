//
//  ContentView.swift
//  PryanikiTest
//
//  Created by Alexander Bonney on 7/5/21.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack() {
                ForEach(vm.orderToDisplay, id: \.self) { v in
                    if v == "hz" {
                        TextBlockView()
                    } else if v == "selector" {
                        ListView()
                    } else if v == "picture" {
                        ImageView()
                    }
                }
            }.navigationBarHidden(true)
        }.environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TextBlockView: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5)
            Text(vm.dataToDisplay["hz"]?.text ?? "Loading...").padding()
        }.padding()
    }
}

struct ListView: View {
    @EnvironmentObject var vm: ViewModel
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ForEach(vm.dataToDisplay["selector"]?.variants ?? [], id: \.id) { thing in
            Button(action: {
                print("\(thing.id), \(thing.text)")
                alertMessage = "\(thing.text), id:\(thing.id)"
                showingAlert = true
            }, label: {
                Text(thing.text)
                    .padding()
                    .foregroundColor(.black)
                    .background(
                        Capsule()
                            .fill(Color.gray)
                            .opacity(0.5)
                    ).shadow(radius: 10)
            }).alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
        }
        .listStyle(InsetListStyle())
    }
}

struct ImageView: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        KFImage(URL(string: "\(vm.dataToDisplay["picture"]?.url ?? "")"))
            .resizable()
            .scaledToFit()
            .padding(.top).frame(width: 150)
    }
}


