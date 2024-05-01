//
//  CardView.swift
//  walkers
//
//  Created by Connor Hutchinson on 5/1/24.
//

import SwiftUI

struct CardView: View {
    
    var card: Card
    
    var body: some View {
        VStack {
            HStack {
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                VStack {
                    Text(card.main_title)
                        .font(.title)
                        .foregroundColor(.black)
                        .bold()
                    VStack {
                        HStack {
                            Text("Steps left to defeat")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Image("fighting")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.black)
                        }
                        Text("\(card.total_steps - card.steps_done)")
                            .font(.title)
                            .foregroundColor(.black)
                            .bold()
                    }
                }
            }
            .cornerRadius(15)
            
            VStack {
                HStack {
                    let progress = Double(card.steps_done) / Double(card.total_steps)
                    ProgressView(value: progress, total: 1.0)
                }
                
                HStack {
                    Text("\(card.steps_done) steps done")
                    Spacer()
                    Text("Goal \(card.total_steps)")
                }
                .padding(.horizontal, 10)
                .font(.subheadline)
                .cornerRadius(10)
                .foregroundStyle(.gray)
            }
            .padding()
        }

    }
}

#Preview {
    let image = "alien"
    let main_title = "You're off to a great start!"
    
    let card = Card(
        image: image,
        main_title: main_title,
        total_steps: 10000,
        steps_done: 4356,
        completed: false
    )
    
    return CardView(card: card)
}
