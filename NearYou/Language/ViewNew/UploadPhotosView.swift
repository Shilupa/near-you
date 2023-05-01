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

struct UploadPhotosView: View {
    @State private var selectedPhotos: [UIImage] = []
    @State private var isShowingPhotoPicker = false
    @StateObject private var vvm = VisitedViewModel()
    @StateObject private var pivm = PlaceImageViewModel()
    
    @Binding var id: String
    
    var body: some View {
        VStack {
            if selectedPhotos.isEmpty {
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(.systemGray4))
                    .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                        ForEach(selectedPhotos, id: \.self) { photo in
                            Image(uiImage: photo)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: (UIScreen.main.bounds.width - 32 - 16) / 3, height: (UIScreen.main.bounds.width - 32 - 16) / 3)
                                .clipped()
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            HStack {
                Spacer()
                Button(action: {
                    self.isShowingPhotoPicker = true
                }, label: {
                    Text("Select Photos")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.orange)
                        .cornerRadius(10)
                })
                
                Button(action: {
                    for index in selectedPhotos.indices {
                        pivm.addPlaceImage(id, selectedPhotos[index])
                    }
                }, label: {
                    Text("Upload Photos")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.orange)
                        .cornerRadius(10)
                })
                .disabled(selectedPhotos.isEmpty)
                
                Spacer()
            }
            .padding(.top, 16)
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(selectedPhotos: self.$selectedPhotos)
        }
        .navigationBarTitle("Upload Photos")
        .background(Color(.systemGray6))
    }
}


struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedPhotos: [UIImage]
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0 // set to 0 for unlimited selection
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // no-op
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker?
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
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

//struct UploadPhotosView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadPhotosView()
//    }
//}
