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
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "FBF2B8"), Color(hex: "FACFD9")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
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
                                    .stroke(Color.orange, lineWidth: 5)
                            )
                    }
                    Button(action: {
                        showImagePicker.toggle()
                        isButtonDisabled = false
                    }) {
                        Text("Add Photo")
                            .foregroundColor(.white)
                            .padding()
                            .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    }
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage)
                    }.padding(.bottom, -70)
                    
                    VStack {
                        HStack {
                            Text("Name")
                                .foregroundColor(.orange)
                                .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        TextField("Jane Korhonen", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        HStack {
                            Text("Address")
                                .foregroundColor(.orange)
                                .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                            
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
                        mypvm.addUser(name, address, selectedImage)
                        navigateToMainProfileView = true // Set the state variable to true to trigger navigation
                    }) {
                        Text("Update")
                            .foregroundColor(.white)
                            .padding()
                            .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    }
                    .background(Color.orange)
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
