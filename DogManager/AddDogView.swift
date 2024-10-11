//
//  AddDogView.swift
//  DogManager
//
//  Created by Felipe Duarte on 3/10/24.
//

import SwiftUI
import PhotosUI

struct AddDogView: View {
    
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var profilePictureData: Data?
    
    @State private var name: String = ""
    @State private var breed: String = ""
    @State private var age = ""
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel : EventViewModel
    
    var body: some View {
        
        if let selectedImage = selectedImage {
                       Image(uiImage: selectedImage)
                           .resizable()
                           .scaledToFit()
                           .frame(width: 200, height: 200)
                   } else {
                       Rectangle()
                           .frame(width: 200, height: 200)
                           .foregroundColor(.gray)
                           .overlay(Text("Selecciona una imagen"))
                   }
        

        
        PhotosPicker(selection: $selectedPhotoItem, matching: .images){
            Text("Select a photo")
        }
        .onChange(of: selectedPhotoItem) { oldValue, newItem in
             if let newItem = newItem {
                 // Cargar la imagen desde el PhotosPickerItem
                 Task {
                     do {
                         if let imageData = try await newItem.loadTransferable(type: Data.self),
                            let uiImage = UIImage(data: imageData) {
                             selectedImage = uiImage
                             profilePictureData = imageData // Guardamos los datos de la imagen
                         }
                     } catch {
                         print("Error al cargar la imagen: \(error.localizedDescription)")
                     }
                 }
             }
//             if let newValue {
//                 Task {
//                     do {
//                         selectedImage = try await newValue.loadUIImage()
//                     } catch {
//                         print("Error al cargar la imagen: \(error)")
//                     }
//                 }
//             }
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
            if let profilePictureData = profilePictureData{
                viewModel.addDog(name: name, age: Int(age) ?? 0, breed: breed, profilePictureData: profilePictureData)
            }
        }
        
        
    }
}


#Preview {
    ContentView()
}
