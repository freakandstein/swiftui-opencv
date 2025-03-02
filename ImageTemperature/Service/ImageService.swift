//
//  ImageService.swift
//  ImageTemperature
//
//  Created by Satrio Wicaksono on 01/03/25.
//

import Foundation
import UIKit

protocol ImageServiceProtocol {
    // MARK: - Functions
    func setTemperature(image: UIImage, value: Float) -> UIImage
}

class OpenCv: ImageServiceProtocol {
    // MARK: - Properties
    private let openCv: OpenCV
    
    // MARK: - Functions
    init() {
        self.openCv = OpenCV()
    }
    
    func setTemperature(image: UIImage, value: Float) -> UIImage {
        return openCv.setTemperature(image, temperature: value)
    }
}

class ImageService {
    // MARK: - Properties
    static let shared = ImageService()
    private let cv: ImageServiceProtocol
    
    // MARK: - Functions
    init(cv: ImageServiceProtocol = OpenCv()) {
        self.cv = cv
    }
    
    func setTemperature(image: UIImage, value: Float) -> UIImage {
        return cv.setTemperature(image: image, value: value)
    }
}
