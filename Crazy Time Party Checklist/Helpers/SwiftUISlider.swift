//
//  CustomSlider.swift
//  Movieplanner
//
//  Created by Роман on 18.06.2024.
//

import SwiftUI

struct SwiftUISlider: UIViewRepresentable {

  final class Coordinator: NSObject {

    var value: Binding<Double>

    // Create the binding when you initialize the Coordinator
    init(value: Binding<Double>) {
      self.value = value
    }

    // Create a valueChanged(_:) action
    @objc func valueChanged(_ sender: UISlider) {
      self.value.wrappedValue = Double(sender.value)
    }
  }

  var thumbColor: UIColor = .white
  var minTrackColor: UIColor?
  var maxTrackColor: UIColor?

  @Binding var value: Double

  func makeUIView(context: Context) -> UISlider {
    let slider = UISlider(frame: .zero)
    slider.thumbTintColor = thumbColor
    slider.minimumTrackTintColor = minTrackColor
      slider.maximumTrackTintColor = maxTrackColor
    slider.value = Float(value)

    slider.addTarget(
      context.coordinator,
      action: #selector(Coordinator.valueChanged(_:)),
      for: .valueChanged
    )

    return slider
  }

  func updateUIView(_ uiView: UISlider, context: Context) {
    // Coordinating data between UIView and SwiftUI view
    uiView.value = Float(self.value)
  }

  func makeCoordinator() -> SwiftUISlider.Coordinator {
    Coordinator(value: $value)
  }
}

#if DEBUG
struct SwiftUISlider_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUISlider(
      thumbColor: .white,
      minTrackColor: .blue,
      maxTrackColor: .green,
      value: .constant(0.5)
    )
  }
}
#endif
