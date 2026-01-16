# Clash of Cans

A playful, visual iOS app for tracking energy drink consumption through a satisfying "stacked can wall" experience.

## Overview

Clash of Cans transforms caffeine tracking into a fun visual collection. Each logged drink appears as a can image in a tightly-packed, staggered brick wall layout. The app emphasizes simplicity, immediate visual feedback, and a satisfying ritual around logging drinks.

## Features

- **Stacked Can Wall**: Visual display of all logged drinks in a 5-6 column grid with staggered rows
- **Low-Friction Logging**: Add drinks in 2 taps via search/select or barcode scan
- **Points System**: Total caffeine content displayed as "points" in the header
- **Curated Drink Catalog**: Pre-loaded catalog of popular energy drink brands and flavors
- **Barcode Scanning**: Optional barcode scanning for quick drink identification
- **Local Persistence**: All data stored locally on device

## Project Structure

```
ClashOfCans/
├── ClashOfCans/
│   ├── ClashOfCansApp.swift          # Main app entry point
│   ├── Models/
│   │   ├── Drink.swift               # Drink catalog model
│   │   └── DrinkEntry.swift          # Logged drink entry model
│   ├── ViewModels/
│   │   ├── WallViewModel.swift       # Wall view state management
│   │   └── AddDrinkViewModel.swift   # Add drink view state management
│   ├── Views/
│   │   ├── ContentView.swift         # Main container view
│   │   ├── WallView.swift            # Stacked can wall display
│   │   ├── CanView.swift             # Individual can image view
│   │   ├── HeaderView.swift          # Totals header
│   │   ├── AddDrinkView.swift        # Drink selection/search view
│   │   └── BarcodeScannerView.swift  # Barcode scanner interface
│   ├── Services/
│   │   ├── DataManager.swift         # Local data persistence
│   │   ├── DrinkCatalogService.swift # Drink catalog management
│   │   └── BarcodeScannerService.swift # Barcode scanning (legacy/unused)
│   └── Utilities/
│       └── GridLayoutHelper.swift    # Grid layout calculations
└── Info.plist                        # App configuration (camera permissions)
```

## Quick Start

See [QUICK_START.md](QUICK_START.md) for detailed setup instructions.

## Setup Instructions

### 1. Create Xcode Project

1. Open Xcode
2. Create a new iOS App project
3. Name it "ClashOfCans"
4. Choose SwiftUI as the interface
5. Set minimum iOS version to 16.0

### 2. Add Source Files

Copy all Swift files from `ClashOfCans/ClashOfCans/` into your Xcode project, maintaining the folder structure:
- Models/
- ViewModels/
- Views/
- Services/
- Utilities/

### 3. Configure Info.plist

Ensure your Info.plist includes the camera usage description:
```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to scan barcodes on energy drinks.</string>
```

Alternatively, add this in Xcode under "Info" tab → "Custom iOS Target Properties" → Add "Privacy - Camera Usage Description"

### 4. Add Can Image Assets

You need to create placeholder can images and add them to `Assets.xcassets`:

1. Create an "Image Set" folder called "Cans" in Assets.xcassets
2. For each drink in the catalog (see `DrinkCatalogService.swift`), create a transparent PNG image
3. Name each image to match the `assetId` from the drink catalog (e.g., `redbull_original.png`)
4. Add images as Image Sets in Assets.xcassets

**Placeholder Can Image Specifications:**
- Format: Transparent PNG
- Aspect Ratio: ~2:1 or 3:1 (tall can)
- Style: Minimalist colored cylinders representing brand colors
- Size: Recommended 200x400px or 300x600px (will be scaled in app)
- Transparency: Transparent background around edges

**Required Assets (matching DrinkCatalogService):**
- redbull_original
- redbull_sugarfree
- redbull_totalzero
- monster_green
- monster_ultra
- monster_zero
- rockstar_original
- rockstar_zero
- celsius_peach
- celsius_sparkling
- celsius_arctic
- bang_cotton
- bang_rainbow
- bang_miami
- reign_orange
- reign_raze
- 5hour_regular
- 5hour_extra
- nos_original
- nos_zero
- gfuel_faze
- gfuel_peach
- c4_orange
- c4_berry
- rockstar_recovery
- monster_hydro

### 5. Build and Run

The app should compile and run. Note that without the can images, you'll see missing image placeholders. Create simple colored rectangles as placeholders if needed for initial testing.

## Usage

1. **Add a Drink**: Tap the + button, search for a drink, and tap to add
2. **Scan Barcode**: Tap the barcode icon in Add Drink view to scan a product
3. **View Wall**: Scroll through your stacked can wall to see all logged drinks
4. **View Totals**: Header shows total drinks logged and total caffeine consumed

## Technical Details

- **Platform**: iOS 16.0+
- **Framework**: SwiftUI
- **Architecture**: MVVM
- **Storage**: FileManager + Codable (JSON files in Documents directory)
- **Data Format**: JSON with ISO8601 date encoding

## Future Enhancements (Out of MVP Scope)

- Cloud sync / iCloud backup
- Social sharing
- Drink editing/deletion
- Custom drink creation
- Advanced statistics/analytics
- Multiple accounts

## License

See LICENSE file for details.
