//
//  HeaderVC.swift
//  walkers
//
//  Created by Connor Hutchinson on 5/2/24.
//

import SwiftUI

struct HeaderVC: View {
    
    let coinCount: Int
    let todaysDate: Date
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 38, height: 38)
                    .foregroundStyle(.gray)
                
                Spacer()
                HStack {
                    Text("\(coinCount)")
                        .font(.headline)
                        .bold()
                    if let image = UIImage(named: "basic_token") {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 30, height: 30)
                    } else {
                        Image(systemName: "heart.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.purple)
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 25)
            
            VStack(alignment: .leading) {
                Text("\(formattedDate(date: todaysDate))")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 10)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .opacity(0.4)
                    .padding(.horizontal, 5)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    return HeaderVC(coinCount: 5, todaysDate: Date.now)
}

