//
//  myDogsView.swift
//  DogManager
//
//  Created by Felipe Duarte on 8/10/24.
//

import SwiftUI

struct MyDogsView: View {
    
    @ObservedObject var viewModel: EventViewModel
    @State private var isPresentingAddDogView = false
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                VStack{
                    ForEach(viewModel.dogs) { dog in
                            NavigationLink(destination: DogDetailView(dog: dog, viewModel: viewModel)) {
                                HStack{
                                    if let imageData = dog.profilePicture, let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .overlay(
                                                Circle().stroke(Color.black, lineWidth: 6)
                                            )
                                            .clipShape(Circle())
                                            .padding(.trailing, 16)
                                    } else {
                                        // Imagen por defecto si no hay imagen
                                        Circle()
                                            .frame(width: 100, height: 100)
                                            .foregroundStyle(.gray)
                                            .padding(.trailing, 16)
                                            .overlay {
                                                Image(systemName: "pawprint")
                                                    .foregroundStyle(Color.white)
//                                                    .frame(width: 150, height: 150)
                                                    .font(.largeTitle)
                                            }
                                    }
                                    Text(dog.name)
                                        .font(.largeTitle)
                                        .foregroundStyle(.black)

                                }
                                .padding()
                                .frame(width: 300)
//                                .background(getBackgroundColor(for: dog))
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                            }
                            
                        
                        .navigationTitle("My Pets")

                    }

                }
                .onAppear {
                    viewModel.showDogs()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add a Dog", systemImage: "plus.circle") {
                            isPresentingAddDogView = true
                        }
                    }
                }
                .sheet(isPresented: $isPresentingAddDogView) {
                    AddDogView(viewModel: viewModel) // Pasar el viewModel a la nueva vista
                }
            }
        }
        
    }
    
    func getBackgroundColor(for dog: DogModel) -> Color {
        
        switch dog.name {
        case "Avril":
            return Color.orange.opacity(0.3)
        case "Eevee":
            return Color.blue.opacity(0.3)
        case "Mac":
            return Color.green.opacity(0.3)
            
            
        default:
            return Color.red.opacity(0.3)
        }
    }
}

#Preview {
    ContentView()
}
