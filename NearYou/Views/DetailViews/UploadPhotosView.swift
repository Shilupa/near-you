//
//  UploadPhotosView.swift
//  NearYou
//
//  Created by Shilpa Singh on 1.5.2023.
//

import SwiftUI
import PhotosUI

struct ImageData {
    let id: Int
    let images: [UIImage]
}

//View to upload multiple photos
struct UploadPhotosView: View {
    // Define state variables to keep track of selected photos and whether the photo picker is currently being shown
    @State private var selectedPhotos: [UIImage] = []
    @State private var isShowingPhotoPicker = false
    // Define state objects for the visited and place image view models
    @StateObject private var vvm = VisitedViewModel()
    @StateObject private var pivm = PlaceImageViewModel()
    
    // Define a binding to the place ID for which photos are being uploaded
    @Binding var id: String
    
    var body: some View {
        VStack {
            // Show placeholder image if no photos are selected
            if selectedPhotos.isEmpty {
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(.systemGray4))
                    .frame(width: 250, height: 500)
                    .padding()
            } else {
                // Show grid of selected photos
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                        ForEach(selectedPhotos, id: \.self) { photo in
                            Image(uiImage: photo)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: (UIScreen.main.bounds.width - 32 - 16) / 3, height: (UIScreen.main.bounds.width - 32 - 16) / 3)
                                .clipped()
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                            
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(width: .none, height: 500)
            }
            
            // Buttons for selecting and uploading photos
            HStack {
                Spacer()
                // Button to show the photo picker
                Button(action: {
                    self.isShowingPhotoPicker = true
                }, label: {
                    Text("Select Photos")
                        .font(Font.custom("Poppins-Regular", size: 15))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color("ThemeColour"))
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                        .shadow(color: Color("ThemeColour").opacity(0.1), radius: 5)
                })
                
                Spacer()
                
                // Button to upload selected photos
                Button(action: {
                    
                    for index in selectedPhotos.indices {
                        pivm.addPlaceImage(id, selectedPhotos[index])
                    }
                    
                    selectedPhotos = []
                    

                }, label: {
                    Text("Upload Photos")
                        .font(Font.custom("Poppins-Regular", size: 15))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(selectedPhotos.isEmpty ? Color.gray :Color("ThemeColour"))
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                        .shadow(color: Color("ThemeColour").opacity(0.1), radius: 5)
                })
                .disabled(selectedPhotos.isEmpty)
                
                Spacer()
            }
            .padding(.top, 16)
            
            Spacer()
        }
        // Show photo picker as a sheet when isShowingPhotoPicker is true
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(selectedPhotos: self.$selectedPhotos)
        }
        .navigationBarTitle("")
        //.background(Color(.systemGray6))
    }
}


struct PhotoPicker: UIViewControllerRepresentable {
    // Define a binding to the array of selected photos
    @Binding var selectedPhotos: [UIImage]
    // Use an environment variable to get access to the presentation mode of the view
    @Environment(\.presentationMode) var presentationMode
    
    // Define a function to create the coordinator for this view
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Define a function to create the view controller for this view
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0 // set to 0 for unlimited selection
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    // This is a no-op function that does nothing when the view is updated.
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    // This is a Coordinator class that implements the PHPickerViewControllerDelegate protocol.
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker?
        
        // This is the initializer for the Coordinator class.
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        // This function is called when the user has finished picking photos using the PHPickerViewController.
            // It adds any selected photos to the selectedPhotos array and dismisses the picker.
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self?.parent?.selectedPhotos.append(image)
                            }
                        }
                    }
                }
            }
            parent?.presentationMode.wrappedValue.dismiss()
        }
    }
}

//
//struct UploadPhotosView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadPhotosView()
//    }
//}
