//
//  EditProfileView.swift
//  NearYou
//
//  Created by Shilpa Singh on 16.4.2023.
//

import SwiftUI

//View where user profile can be created/edited
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
            ZStack {
                VStack {
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("ThemeColour"), lineWidth: 5)
                            )
                    }
                    // Button to open the image picker
                    Button(action: {
                        showImagePicker.toggle()
                        isButtonDisabled = false
                    }) {
                        Text("Add Photo")
                            .foregroundColor(.white)
                            .padding()
                            .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    }
                    .background(Color("ThemeColour"))
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage)
                    }.padding(.bottom, -70)
                    
                    VStack {
                        HStack {
                            //Text with no functionality
                            Text("Name")
                                .foregroundColor(Color("ThemeColour"))
                                .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        //Field to write the name
                        TextField("Jane Korhonen", text: $name)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 2)
                                    .opacity(0.6)
                            )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        HStack {
                            //Text with no functionality
                            Text("Address")
                                .foregroundColor(Color("ThemeColour"))
                                .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                            
                            Spacer()
                            
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(Color("ThemeColour"))
                                .padding(.leading, 4)
                            
                        }
                        .padding(.horizontal)
                        
                        //Field to write the address
                        TextField("Some street no.15, London", text: $address)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 2)
                                    .opacity(0.6)
                            )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.top, 80)
                    
                    //Button to update the information and image
                    Button(action: {
                        mypvm.addUser(name, address, selectedImage)
                        // Set the state variable to true to trigger navigation
                        navigateToMainProfileView = true
                    }) {
                        Text("Update")
                            .foregroundColor(.white)
                            .padding()
                            .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    }
                    .background(Color("ThemeColour"))
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding(.bottom, 250)
                    .disabled(isButtonDisabled)
                }
                .padding(.horizontal, 20)
                .padding(.top, 90)
                .onAppear{
                    selectedImage = gvvm.profileImage
                }
            }
            //When navigated gives a full screen
        }.fullScreenCover(isPresented: $navigateToMainProfileView) {
            MainProfileView()
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    
    // Function to create and configure the UIImagePickerController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    //Called when view needs to be updated
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    //Creates a new coordinator object to handle interactions between this view and the UIImagePickerController.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //Coordinator class that will handle interactions with the UIImagePickerController.
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // This function is called when the user selects an image in the UIImagePickerController.
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
