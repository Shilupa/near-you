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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "FBF2B8"), Color(hex: "FACFD9")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                if profileImage != nil {
                    profileImage?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.orange, lineWidth: 5)
                        )
                    
                } else {
//                    Image(systemName: "person.circle.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 150, height: 150)
//                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Image("profile")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 250, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.orange, lineWidth: 5)
                        )
                }
                
                Button(action: {
                    isShowingImagePicker.toggle()
                }) {
                    Text("Add Photo")
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(image: $profileImage)
                }.padding(.bottom, -70)
                
                VStack {
                    HStack {
                        Text("Name")
                            .foregroundColor(.orange)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    TextField("Jane Korhonen", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Address")
                            .foregroundColor(.orange)
                        
                        Spacer()
                        
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.orange)
                            .padding(.leading, 4)
                    
                    }
                    .padding(.horizontal)
                    
                    TextField("Some street no.15, London", text: $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.top, 80)
                
                Button(action: {
                    // Code to update user information
                }) {
                    Text("Update")
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding(.bottom, 250)
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 90)
            
            
        }
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
