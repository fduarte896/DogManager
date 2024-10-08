//
//  AddDogView.swift
//  DogManager
//
//  Created by Felipe Duarte on 3/10/24.
//

import SwiftUI
import PhotosUI

struct AddDogView: View {
    
    @State private var photo: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var name: String = ""
    @State private var breed: String = ""
    @State private var age = ""
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel : EventViewModel
    
    var body: some View {
        
        if let selectedImage {
            Text("Profile Picture")
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
        }
        PhotosPicker(selection: $photo,
                     matching: .images) {
            Text("Select a photo")
        }
         .onChange(of: photo) { oldValue, newValue in
             if let newValue {
                 Task {
                     do {
                         selectedImage = try await newValue.loadUIImage()
                     } catch {
                         print("Error al cargar la imagen: \(error)")
                     }
                 }
             }
         }
        

        
        VStack{
            TextField("Name", text: $name)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                
            TextField("Breed", text: $breed)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            TextField("Age", text: $age)
                .keyboardType(UIKeyboardType.numberPad)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
        }
        .frame(width: 200)
        Button("Save") {
            presentationMode.wrappedValue.dismiss()
            viewModel.addDog(name: name, age: age, breed: breed, profilePicture: photo)
        }
        
        
    }
}

extension PhotosPickerItem {
    /// Cargar y devolver un UIImage desde un PhotosPickerItem
    func loadUIImage() async throws -> UIImage? {
        do {
            if let data = try await self.loadTransferable(type: Data.self) {
                return UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
            throw error
        }
        return nil
    }
}



#Preview {
    AddDogView()
}
