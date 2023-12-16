//
//  MainController.swift
//  demo1
//
//  Created by Inon Barber on 15/12/2023.
//

import UIKit
import LBTATools

class PostCell: LBTAListCell<String> {
    
    
    let imageView = UIImageView(image: UIImage(named: "avatar1"))
    let nameLabel = UILabel(text: "Lee Ji Eun")
    let dataLabel = UILabel(text: "Friday at 18:20")
    let postTextLabel = UILabel(text: "Here is my post")
    
    let photosGridController = PhotosGridController()
    
    override func setupViews() {
        backgroundColor = .white
        
        stack(hstack(imageView.withHeight(40).withWidth(40),stack(nameLabel, dataLabel), spacing: 8).padLeft(12).padLeft(12).padTop(12), postTextLabel,
              photosGridController.view, spacing: 8)
    }
}

class StoryHeader: UICollectionReusableView {
    
    let storiesController = StoriesController(scrollDirection: .horizontal)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .yellow
        
        stack(storiesController.view)
        
    }
    
    required init?(coder:NSCoder){
        fatalError()
    }
}

class StoryPhotoCell: LBTAListCell<String>{
    
    override var item: String! {
        didSet{
            imageView.image = UIImage(named: item)
        }
    }
    
    let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Lee Ji Eun",font: .boldSystemFont(ofSize: 14), textColor: .white)
    
    override func setupViews() {
    
        imageView.layer.cornerRadius = 10
        
        
        stack(imageView)
        
        setupGradientLayer()
        
        stack(UIView(),nameLabel).withMargins(.allSides(8))
    }
    
    let gradientLayer = CAGradientLayer()
    
    fileprivate func setupGradientLayer(){
       
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5,1.2]
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
        
    }
}

class StoriesController: LBTAListController<StoryPhotoCell,String>, UICollectionViewDelegateFlowLayout 
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: view.frame.height - 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = ["photo1","story_photo2","story_photo1","story_photo2","story_photo1"]
    }
}

class MainController: LBTAListHeaderController<PostCell,String, StoryHeader>, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 0, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        collectionView.backgroundColor = .init(white: 0.9, alpha: 1)
        
        self.items = ["Hello", "World", "1", "2"]
        
        setupNavBar()
    }
    
    let fbLogoImageView = UIImageView(image: UIImage(named: "fb_logo"), contentMode: .scaleAspectFit)
     lazy var searchButton = UIButton(image: UIImage(named: "search")!, tintColor: .black)
     
     lazy var messageButton = UIButton(image: UIImage(named: "messenger")!, tintColor: .black)
    
    fileprivate func setupNavBar() {
        let coverWhiteView = UIView(backgroundColor: .clear)
        view.addSubview(coverWhiteView)
        coverWhiteView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        let safeAreaTop = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        coverWhiteView.constrainHeight(safeAreaTop)
        
        [searchButton, messageButton].forEach { (button) in
            button.layer.cornerRadius = 17
            button.clipsToBounds = true
            button.backgroundColor = .init(white: 0.9, alpha: 1)
            button.withSize(.init(width: 34, height: 34))
        }
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        
        let titleView = UIView(backgroundColor: .clear)
        let lessWidth: CGFloat = 34 + 34 + 120 + 24 + 16
        let width = (view.frame.width - lessWidth)
        titleView.hstack(fbLogoImageView.withWidth(120), UIView().withWidth(width), searchButton, messageButton, spacing: 8).padBottom(8)
        navigationItem.titleView = titleView
    }
        


    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let safeAreaTop = windowScene.windows.first?.safeAreaInsets.top ?? 0
            
            let magicalSafeAreaTop: CGFloat = safeAreaTop + (navigationController?.navigationBar.frame.height ?? 0)
            print(scrollView.contentOffset.y)
            
            let offset = scrollView.contentOffset.y + magicalSafeAreaTop
            
            let alpha: CGFloat = 1 - ((scrollView.contentOffset.y + magicalSafeAreaTop) / magicalSafeAreaTop)
            
            [fbLogoImageView,searchButton].forEach { $0.alpha = alpha }
            
            navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 400)
    }
}

















import SwiftUI
struct MainPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
    struct ContainerView: UIViewControllerRepresentable{
        func updateUIViewController(_ uiViewController: MainPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {
            
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) -> UIViewController {
            return UINavigationController(rootViewController: MainController())
        }
    }
}
