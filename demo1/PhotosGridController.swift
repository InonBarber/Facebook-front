//
//  PhotosGridController.swift
//  demo1
//
//  Created by Inon Barber on 15/12/2023.
//

import UIKit
import SwiftUI
import LBTATools

class PhotosGridCell: LBTAListCell<String> {
    
    override var item: String! {
        didSet{
            imageView.image = UIImage(named: item)
        }
    }
    
    let imageView = UIImageView(image: UIImage(named: "avatar1"), contentMode: .scaleAspectFill)
    
    override func setupViews() {
        backgroundColor = .yellow
        
//        addSubview(imageView)
//        imageView.fillSuperview()
        stack(imageView)
    }
    
}

class PhotosGridController: LBTAListController<PhotosGridCell,String>, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .lightGray
        
        self.items = ["avatar1","story_photo1","story_photo2","avatar1","avatar1"]
    }
    
    let cellsSpacing: CGFloat = 4
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if indexPath.item == 0 || indexPath.item == 1 {
            let width = (view.frame.width - 3 * cellsSpacing) / 2
            
            return .init(width: width, height: width)
        }
        let width = (view.frame.width - 4.1 * cellsSpacing) / 3
        
        return .init(width: width, height: width)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellsSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: cellsSpacing, bottom: 0, right: cellsSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellsSpacing
    }
     
}

struct PhotoGridPreview: PreviewProvider {
    static var previews: some View{
        ContainerView()
        
    }
    
    struct ContainerView: UIViewControllerRepresentable{
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoGridPreview.ContainerView>) ->  UIViewController {
            return PhotosGridController()
        }
        
        func updateUIViewController(_ uiViewController: PhotoGridPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PhotoGridPreview.ContainerView>) {
            
        }
    }
}
