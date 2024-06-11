### Fetch's iOS Challenge

 # Welcome to *Cuisine*
> Cuisine is an iOS app that displays food recipes from around the world

### What we support ✅
- iOS 15.0+
- Xcode 14.0+

### Built using 👷🏻
- Pure SwiftUI
- Xcode 15.4

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
- MVVM with an integrated service architecture
  - seperates enpoints and requests from view model

### View States
- Loading
- Result
- Empty/Error

### Network
- Custom URL session configurations
- Custom URL request configurations

### Caching
- All images are cached

### Testing
- Unit Tests
  - Network
    - Success
    - Server Fail
    - JSON Fail
  - Filter
  - Correct Initialization
    
- UI Tests
  - Dessert card exists
  - Dessert category exists
  - Filter alphabetical button exists
