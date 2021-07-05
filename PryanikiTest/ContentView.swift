//
//  ContentView.swift
//  PryanikiTest
//
//  Created by Alexander Bonney on 7/5/21.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5)
                    Text(vm.dataToDisplay["hz"]?.text ?? "Loading...").padding()
                }.padding()
                
                ForEach(vm.dataToDisplay["selector"]?.variants ?? [], id: \.id) { thing in
                        NavigationLink(
                            destination: Text(thing.text),
                            label: {
                                Cell(text: "Variant \(thing.id)").foregroundColor(.black).padding(.horizontal)
                            })
                }
                .listStyle(InsetListStyle())
                
                KFImage(URL(string: "\(vm.dataToDisplay["picture"]?.url ?? "")"))
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
                
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5)
                    Text(vm.dataToDisplay["hz"]?.text ?? "Loading...").padding()
                }.padding()
            }.navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
