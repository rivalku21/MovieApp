//
//  ActivityIndicatorView.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 21/02/24.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
}
