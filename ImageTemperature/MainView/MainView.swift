//
//  MainView.swift
//  ImageTemperature
//
//  Created by Satrio Wicaksono on 28/02/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: .zero) {
                
                Spacer()
                
                if let image = viewModel.processedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .gesture(
                            DragGesture(minimumDistance: .zero)
                                .onChanged { value in
                                    viewModel.resetFromEdited(location: value.location)
                                }
                                .onEnded { _ in
                                    viewModel.restoreToEdited()
                                }
                        )
                } else {
                    Text("Picture is not selected")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                }
                
                Spacer()
                
                VStack(spacing: .zero) {
                    if let _ = viewModel.processedImage {
                        HStack(spacing: .zero) {
                            UISlider(value: $viewModel.temperature, range: -100...100)
                            .onChange(of: viewModel.temperature) { newValue in
                                viewModel.adjustTemperature(value: newValue)
                            }
                            .padding(.horizontal, .zero)
                            
                            Text("\(Int(viewModel.temperature))")
                                .font(.subheadline)
                                .frame(width: 48)
                                .padding(.horizontal, .zero)
                        }
                        .padding(.trailing, .zero)
                        .padding(.leading, 12)
                        .padding(.bottom, 16)
                    }
                    
                    if let _ = viewModel.processedImage {
                        UIButton(text: "Save Picture", state: .normal) {
                            viewModel.saveImage()
                        }
                        .padding(.horizontal, 8)
                        
                    } else {
                        UIButton(text: "Select Picture (.JPEG)", state: .normal) {
                            viewModel.showImagePicker()
                        }
                        .padding(.horizontal, 8)
                        .sheet(isPresented: $viewModel.isShowImagePicker) {
                            UIImagePicker { image in
                                guard let image = image else {
                                    viewModel.showImagePickerError()
                                    return
                                }
                                viewModel.setImage(image)
                            }
                        }
                    }
                    
                    if let _ = viewModel.processedImage {
                        UIButton(text: "Remove Picture", state: .danger) {
                            viewModel.removeImage()
                        }
                        .padding(.all, 8)
                    }
                }
                .padding(.top, .zero)
                .padding(.bottom, 4)
            }
            .padding(.bottom, .zero)
            .navigationBarTitle("Picture Temperature Adjustment", displayMode: .inline)
            .alert(isPresented: $viewModel.isShowAlert) {
                Alert(title: Text(viewModel.alertTitleMessage), message: Text(viewModel.alertBodyMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    MainView()
}
