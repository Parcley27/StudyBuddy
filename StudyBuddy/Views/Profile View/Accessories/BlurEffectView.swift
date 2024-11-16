//
//  BlurEffectView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 15/11/24.
//

import SwiftUI

struct BlurEffectView: UIViewRepresentable {
    var effect: UIBlurEffect.Style = .regular
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        return view
        
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: effect)
        
    }
}

#Preview {
    ZStack {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pellentesque, mauris sit amet lacinia semper, sem libero tempus metus, quis pellentesque nulla quam id sem. Nam bibendum est a imperdiet fermentum. Integer sit amet risus risus. Nullam interdum pulvinar tellus, ac dictum arcu semper id. Quisque ornare eget nisi at pharetra. Nunc a eros eu augue accumsan sodales. Quisque vehicula nisi quis turpis cursus, et interdum dolor pulvinar. Duis ultricies rutrum nunc, ac consectetur justo venenatis id. Duis fringilla est lectus, nec mollis nunc consequat eu. Suspendisse ac justo venenatis, commodo ipsum in, cursus nunc. Quisque dictum nisl in nisl auctor, id feugiat turpis congue. Aliquam erat volutpat. Integer tincidunt hendrerit augue, quis feugiat felis porttitor vel. Proin non fringilla mauris, in vehicula massa. Nam est justo, viverra quis risus sed, placerat molestie urna. Etiam volutpat condimentum libero vel hendrerit.")
        
        BlurEffectView()

    }
}
