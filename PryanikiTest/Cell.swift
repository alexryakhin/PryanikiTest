//
//  Cell.swift
//  PryanikiTest
//
//  Created by Alexander Bonney on 7/5/21.
//

import SwiftUI

struct Cell: View {
    
    var text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5)
            HStack {
                Text(text).font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
            }.padding()
        }.frame(height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell(text: "Cell")
    }
}
