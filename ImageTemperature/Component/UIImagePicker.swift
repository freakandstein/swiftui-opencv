//
//  ImagePicker.swift
//  ImageTemperature
//
//  Created by Satrio Wicaksono on 01/03/25.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct UIImagePicker: UIViewControllerRepresentable {
    var onImagePicked: (UIImage?) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"] // Only allow images
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: UIImagePicker

        init(_ parent: UIImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let url = info[.imageURL] as? URL {
                let imageType = UTType(filenameExtension: url.pathExtension)
                
                if imageType == .jpeg {
                    if let image = info[.originalImage] as? UIImage {
                        parent.onImagePicked(image)
                    }
                } else {
                    parent.onImagePicked(nil)
                }
            }
            picker.dismiss(animated: true)
        }
    }
}
