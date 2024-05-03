//
//  CardView.swift
//  walkers
//
//  Created by Connor Hutchinson on 5/1/24.
//

import SwiftUI

struct CardVC: View {
    
    var card: Card
    var currentSteps: Int
    var viewModel: CardVM
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .padding(.leading, 10)
                    .padding(.top, 10)
                
                Spacer()
                
                VStack {
                    Text(card.motivationalQuote)
                        .lineLimit(nil)
                        .font(.title)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
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
                        }
                        
                        Text("\(viewModel.difference)")
                            .font(.title)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .bold()
                    }
                }
                .padding(.trailing, 25)
            }
            
            VStack {
                ProgressView(value: viewModel.progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: viewModel.completed ? .green : .blue))
                
                HStack {
                    Text("Current: \(currentSteps)")
                    Spacer()
                    Text("Goal: \(Int(card.goalSteps))")
                }
                .padding(.horizontal, 10)
                .font(.subheadline)
                .cornerRadius(10)
                .foregroundStyle(.gray)
                
                if viewModel.completed {
                    Button {
                        withAnimation {
                            viewModel.updateCard()
                        }
                    } label: {
                        Text("Claim Reward")
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                }
            }
            .padding()

        }

    }
}

//#Preview(traits: .sizeThatFitsLayout) {
//    return CardVC(card: Card.testData[5], healthManager: HealthManager.shared)
//}
var vm = CardVM()
#Preview(traits: .sizeThatFitsLayout) {
    Group {
        ScrollView{
            ForEach(Card.testData.indices, id: \.self) { index in
                CardVC(card: Card.testData[index], currentSteps: 10000, viewModel: vm)
                    .environmentObject(vm)
            }
        }
    }
}
