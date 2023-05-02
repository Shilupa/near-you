//
//  EditProfileView.swift
//  NearYou
//
//  Created by Shilpa Singh on 16.4.2023.
//

import SwiftUI

struct EditProfileView: View {
    @State private var profileImage: Image?
    @State private var name = ""
    @State private var address = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var isButtonDisabled = true
    @State private var navigateToMainProfileView = false
    
    @StateObject private var mypvm = MyProfileViewModel()
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                // Profile Photo
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 250, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("ThemeColour"), lineWidth: 3)
                        )
                        .padding()
                }
                
                // Button - Change profile photo
                Button(action: {
                    showImagePicker.toggle()
                    isButtonDisabled = false
                }) {
                    Text("Change Profile")
                        .font(Font.custom("Poppins-Regular", size: 15))
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 8)
                        .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                }
                .background(Color("ThemeColour"))
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .shadow(color: Color.gray, radius: 7, x: 0, y: 2)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                

                HStack {
                    
                    Text("Name")
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Color("ThemeColour"))
                        .padding(.leading)
                        .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // Name text Field
                TextField("Jane Korhonen", text: $name)
                    .font(Font.custom("Poppins-Regular", size: 16))
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 1)
                            .opacity(0.8)
                            .frame(width: .none, height: 50)
                    )
                    .padding(.horizontal)
                
                
                Spacer().frame(height: 35)
                
                
                HStack {
                    Text("Address")
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Color("ThemeColour"))
                        .padding(.leading)
                        .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                
                // Address Text Field
                TextField("Some street no.15, London", text: $address)
                    .font(Font.custom("Poppins-Regular", size: 16))
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 1)
                            .opacity(0.8)
                            .frame(width: .none, height: 50)
                    )
                    .padding(.horizontal)
                
                Spacer().frame(height: 50)
                
                
                // Update Button
                Button(action: {
                    mypvm.addUser(name, address, selectedImage)
                    navigateToMainProfileView = true // Set the state variable to true to trigger navigation
                }) {
                    Text("Update")
                        .font(Font.custom("Poppins-Regular", size: 15))
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                }
                .background(Color("ThemeColour"))
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .shadow(color: Color.gray, radius: 7, x: 0, y: 2)
                .disabled(isButtonDisabled)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .onAppear{
                selectedImage = gvvm.profileImage
            }
        }.fullScreenCover(isPresented: $navigateToMainProfileView) {
            MainProfileView()
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
