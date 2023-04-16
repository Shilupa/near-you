//
//  EditProfileView.swift
//  NearYou
//
//  Created by Shilpa Singh on 16.4.2023.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var profileImage: Image?
    @State private var isShowingImagePicker = false
    @State private var name = ""
    @State private var address = ""
    
    var body: some View {
        VStack {
            if profileImage != nil {
                profileImage?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Button(action: {
                isShowingImagePicker.toggle()
            }) {
                Text("Add Photo")
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $profileImage)
            }
            
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Address", text: $address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                // Code to update user information
            }) {
                Text("Update")
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
        }
        .padding()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: Image?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: uiImage)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
