### Fetch's iOS Challenge

 # Welcome to *Cuisine*
> Cuisine is an iOS app that displays food recipes from around the world

### What we support ✅
- iOS 15.0+
- Xcode 14.0+

### Built using 👷🏻
- Pure SwiftUI
- Xcode 15.4
- Async/Await

### Features 😎
- Light/Dark Mode
- Select any food category
- Get all available details for listed recipes
- Search for a specific recipe
<p>
<img src="CuisineLaunchLogo.png" width="225" height="487.5">
<img src="Simulator Screenshot - Clone 1 of iPhone 15 Pro Max - 2024-06-08 at 14.17.50.png" width="225" height="487.5">
<img src="Simulator Screenshot - Clone 1 of iPhone 15 Pro Max - 2024-06-08 at 14.18.15.png" width="225" height="487.5">
</p>


## For Dev Review

### Architecture
> MVVM with an integrated service architecture
> - seperates enpoints, services, and network requests from the view model
  <img src="Cuisine System Design.png" width="400" height="400">

### View States
- Loading
- Result
- Empty/Error

### Network
- Custom url session configurations
- Custom url request configurations

### Caching
- All images are cached
- All urls are cached

### Localization 
- English
- Swedish

### Testing
> Unit Tests
- `CuisineNetworkTests`
  - Success
  - Server Fail
  - JSON Fail
       
- `CuisineMainTests`
  - Filter
  - Correct Initialization
    
> UI Tests
- `CuisineUITests`
  - Dessert card exists
  - Dessert category exists
  - Filter alphabetical button exists
