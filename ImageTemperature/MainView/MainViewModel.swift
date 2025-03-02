//
//  MainViewViewModel.swift
//  ImageTemperature
//
//  Created by Satrio Wicaksono on 01/03/25.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    // MARK: - Properties
    @Published var processedImage: UIImage?
    @Published var temperature: Float = .zero
    @Published var isShowImagePicker: Bool = false
    @Published var isShowAlert: Bool = false
    @Published var lastHoldLocation: CGPoint = .zero
    @Published var alertBodyMessage: String = ""
    @Published var alertTitleMessage: String = ""
    private var originalImage: UIImage?
    private var lastEditedImage: UIImage?
    
    let imageService: ImageService = ImageService()
    
    // MARK: - Functions
    func showImagePicker() {
        isShowImagePicker = true
        temperature = .zero
    }
    
    func setImage(_ image: UIImage) {
        self.originalImage = image
        self.processedImage = image
    }
    
    func showImagePickerError() {
        isShowAlert = true
        alertTitleMessage = "Load Picture Error"
        alertBodyMessage = "Picture must be jpeg!"
    }
    
    func adjustTemperature(value: Float) {
        guard let originalImage = originalImage else { return }
        lastEditedImage = processedImage
        processedImage = imageService.setTemperature(image: originalImage, value: value)
    }
    
    func resetFromEdited(location: CGPoint) {
        if lastHoldLocation == .zero {
            guard let originalImage = originalImage else { return }
            lastEditedImage = processedImage // save last state
            processedImage = originalImage
            lastHoldLocation = location
        }
    }
    
    func restoreToEdited() {
        processedImage = lastEditedImage
        lastHoldLocation = .zero
    }
    
    func saveImage() {
        guard let processedImage = processedImage else { return }
        UIImageWriteToSavedPhotosAlbum(processedImage, nil, nil, nil)
        isShowAlert = true
        alertTitleMessage = "Save Success"
        alertBodyMessage = "Your picture has been saved to the gallery"
    }
    
    func removeImage() {
        processedImage = nil
        temperature = .zero
        isShowImagePicker = false
    }
}

