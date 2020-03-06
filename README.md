# Onramp iOS Take-Home Project 

## Overview 
Clowder is an app that allows you to view, favorite, and download cat photos.

## How I fufilled the project requirements:

1)Used at least 3 UIViewControllers: PhotoListViewController, FavoritePhotosViewController, and PhotoDetailViewController.  
2) Used at least one UIView: EmptyStateView  
3) Used MVVM with viewModels: PhotoViewModel and PhotosViewModel
4) Used a REST API: Unsplash API  
5) Used at least 5 UIView/UIControls: UITableView (PhotoListController), UICollectionView(FavoritePhotosViewController), UIStackView(ActionStackView in PhotoDetailViewController), UIImageView(multiple - see PhotoTableViewCell and PhotoCollectionCell), UIButton(multiple - see FavoriteButton for example).   
6) Used local persistence - I used CoreData to persist favorited cat photos.  
 
## Description:

The app has a UITabBarController with two tabs: "Photos" (PhotoListViewController) and "Favorites" (FavoritePhotosViewController).

PhotoListViewController shows an tableView of cat photos inside PhotoTableViewCells. ![Image of PhotoListVC](https://i.imgur.com/1dQ8ZYh.jpg)

FavoritePhotosViewController shows a collectionView of favorited cat photos in PhotoCollectionViewCells. If you haven't favorited any cat photos yet, it shows an empty state (EmptyStateView).
![Image of FavoritePhotosVC](https://i.imgur.com/ydPJXgF.png)

PhotoDetailViewController presents when you tap on a cat photo in either PhotoListViewController or FavoritePhotosViewController. You can tap on the download or favorite button (Favorite Button) in the stackView (ActionStackView) below the photo. An alert (AlertPresenter) shows upon completion or failure of downloading or favoriting. You can dismiss the view controller by tapping the x-button (closeButton).
![Image of PhotoDetailViewController](https://i.imgur.com/zPKvGRR.png)

## Design Pattern:

I used MVC as a starting point for a design pattern. I then went back and refactored with MVVM to extract some of the business and presentation logic out of the viewControllers and views.

I also grouped networking files in a "Networking" folder.
