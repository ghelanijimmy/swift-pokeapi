//
//  FetchedImage.swift
//  Dex3
//
//  Created by Jimmy Ghelani on 2023-09-09.
//

import SwiftUI

struct FetchedImage: View {
    let url: URL?
    var body: some View {
        if let url, let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .shadow(color: .black, radius: 6)
        } else {
            Image(.bulbasaur)
        }
    }
}

#Preview {
    FetchedImage(url: SamplePokemon.samplePokemon.sprite)
}
