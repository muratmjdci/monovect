# Vectorify Implementation Plan

## Overview
Complete implementation plan for Vectorify app following requirements in `specs/initial_requirements.md`.

**Key Strategy:**
- UI polish first, then backend integration
- Skip Supabase initially (use mock data)
- Replace credit system with user type system (free/premium)
- Daily creation limit for free users (watch ad or go premium)
- Premium users get unlimited creations

---

## Phase 1: UI Polish & Enhancement (PRIORITY)

### 1.1 Fix App Entry Point & Navigation
- [ ] Change main.dart home from PaywallView to SplashView
- [ ] Add auto-navigation from Splash → Home after drawing types are loaded
- [ ] Ensure smooth screen transitions with proper animations

### 1.2 Enhance Splash Screen
- [ ] Convert SplashView from StatelessWidget to StatefulWidget
- [ ] Add animated CircularProgressIndicator
- [ ] Add "Loading your creative space..." text with fade animation
- [ ] Implement mock data loading (simulate fetching drawing types)
- [ ] Navigate to Home when drawing types are ready (2-3 second delay)
- [ ] Add proper lifecycle management

### 1.3 Enhance Create Image Screen
**Image Preview & Selection:**
- [ ] Add image preview after selection with proper aspect ratio
- [ ] Add "Remove" button on image preview
- [ ] Add placeholder for "no image selected" state

**Prompt Input Enhancements:**
- [ ] Add character counter for prompt (e.g., 0/500)
- [ ] Show counter below text field
- [ ] Add max length validation

**Loading States:**
- [ ] Create loading overlay during generation
- [ ] Add progress indicator (CircularProgressIndicator)
- [ ] Add "Generating your masterpiece..." text
- [ ] Add Cancel button on loading overlay
- [ ] Implement cancellation logic

**Error States:**
- [ ] Create error dialog component
- [ ] Add retry button
- [ ] Show user-friendly error messages
- [ ] Handle network errors specifically

**Success Flow:**
- [ ] Navigate to Result Screen on success

### 1.4 Create Result Screen (NEW)
- [ ] Create new file: `lib/features/home/create_art/presentation/result_view.dart`
- [ ] Add full-screen generated image display
- [ ] Add Download button with icon
- [ ] Add Share button with native share functionality
- [ ] Add "Create Another" button (navigate back to Create)
- [ ] Add Save to favorites (heart icon toggle)
- [ ] Add glassmorphic UI matching app design
- [ ] Add hero animation from generation to result

### 1.5 Enhance Home Screen
**Skeleton Loading:**
- [ ] Add skeleton loader for categories (horizontal list)
- [ ] Add skeleton loader for creations grid (masonry)
- [ ] Create SkeletonLoader widget component
- [ ] Show skeletons during initial load
- [ ] Smooth transition from skeleton to real data

**Empty State:**
- [ ] Add empty state illustration/icon
- [ ] Add "No creations yet, start creating!" message
- [ ] Add "Create Now" button
- [ ] Show only when no creations exist

**Category Filtering:**
- [ ] Implement actual filtering logic
- [ ] Filter creations by selected category
- [ ] Update grid when category changes
- [ ] Add smooth transitions

**Code Cleanup:**
- [ ] Remove pull-to-refresh code (not needed)
- [ ] Remove search bar (not needed)
- [ ] Remove Recent/Popular toggle (not needed)

### 1.6 Replace Credit System with User Type System
**Remove Credit Components:**
- [ ] Remove CreditChip from HomeView
- [ ] Remove CreditChip from CreateVectorView
- [ ] Remove CreditChip from PaywallView
- [ ] Remove credit-related logic

**Create User Type Components:**
- [ ] Create new `lib/common/widget/user_type_chip.dart`
- [ ] Design Premium badge (gold/yellow styling)
- [ ] Design Free user indicator
- [ ] Add to HomeView header
- [ ] Add to CreateVectorView header

**Update Create Screen Logic:**
- [ ] Add user type check before generation
- [ ] For Free users: Check if daily creation used
- [ ] If daily limit reached: Show "Watch Ad to Create Today" button
- [ ] If daily limit reached: Show "Go Premium" button
- [ ] For Premium users: Always show Generate button
- [ ] Add daily countdown timer for free users

### 1.7 Build Paywall Screen Components
**Update Messaging:**
- [ ] Change focus from credits to unlimited creations
- [ ] Update benefits list: "Unlimited Creations", "No Ads", "Priority Support", "Exclusive Styles"
- [ ] Remove credit-related text
- [ ] Update hero text to emphasize unlimited creation

**UI Enhancements:**
- [ ] Add subscription tier comparison table
- [ ] Add "Most Popular" badge on annual plan
- [ ] Add checkmarks for each feature
- [ ] Add terms & privacy policy links at bottom
- [ ] Add "Restore Purchases" button styling

### 1.8 Create Rewarded Ad Flow (UI)
- [ ] Create `lib/features/ads/presentation/watch_ad_sheet.dart`
- [ ] Design bottom sheet for ad flow
- [ ] Add "Watch Ad to Create Today" screen
- [ ] Add ad loading state (spinner)
- [ ] Add "Ad completed, you can create 1 image today!" success message
- [ ] Add countdown timer showing when next free creation available
- [ ] Add close button

### 1.9 Create Reusable UI Components
**LoadingOverlay Widget:**
- [ ] Create `lib/common/widget/loading_overlay.dart`
- [ ] Add semi-transparent background
- [ ] Add progress indicator with percentage
- [ ] Add loading message parameter
- [ ] Add cancel button option

**ErrorDialog Widget:**
- [ ] Create `lib/common/widget/error_dialog.dart`
- [ ] Add error icon
- [ ] Add error message parameter
- [ ] Add retry callback button
- [ ] Add close button
- [ ] Match glassmorphic design

**SuccessDialog Widget:**
- [ ] Create `lib/common/widget/success_dialog.dart`
- [ ] Add success icon/animation
- [ ] Add success message parameter
- [ ] Add action button
- [ ] Match glassmorphic design

**EmptyState Widget:**
- [ ] Create `lib/common/widget/empty_state.dart`
- [ ] Add illustration/icon parameter
- [ ] Add title and description parameters
- [ ] Add action button parameter
- [ ] Make reusable across screens

**SkeletonLoader Widget:**
- [ ] Create `lib/common/widget/skeleton_loader.dart`
- [ ] Add shimmer animation
- [ ] Add height/width parameters
- [ ] Add border radius parameter
- [ ] Match app design system

**ImagePreviewCard Widget:**
- [ ] Create `lib/common/widget/image_preview_card.dart`
- [ ] Add image display with proper scaling
- [ ] Add remove button overlay
- [ ] Add glassmorphic border
- [ ] Add tap to expand functionality

---

## Phase 2: State Management Foundation

### 2.1 Add Dependencies
- [ ] Open pubspec.yaml
- [ ] Add `flutter_riverpod: ^2.6.1`
- [ ] Add `shared_preferences: ^2.3.3`
- [ ] Add `flutter_secure_storage: ^9.2.2`
- [ ] Add `cached_network_image: ^3.4.1`
- [ ] Add `path_provider: ^2.1.5`
- [ ] Add `uuid: ^4.5.1`
- [ ] Add `google_mobile_ads: ^5.2.0`
- [ ] Run `flutter pub get`
- [ ] Verify all dependencies installed

### 2.2 Create Data Models

**User Model:**
- [ ] Create `lib/core/models/user.dart`
- [ ] Add userId field (String)
- [ ] Add userType field (UserType enum)
- [ ] Add lastCreationDate field (DateTime?)
- [ ] Add createdAt field (DateTime)
- [ ] Add fromJson factory constructor
- [ ] Add toJson method
- [ ] Add copyWith method

**UserType Enum:**
- [ ] Create `lib/core/models/user_type.dart`
- [ ] Add enum values: free, premium
- [ ] Add toString method
- [ ] Add fromString method
- [ ] Add extension for display names

**DrawingType Model:**
- [ ] Create `lib/features/home/domain/models/drawing_type.dart`
- [ ] Add id field (String or int)
- [ ] Add name field (String)
- [ ] Add previewUrl field (String?)
- [ ] Add description field (String?)
- [ ] Add fromJson factory constructor
- [ ] Add toJson method

**GeneratedImage Model:**
- [ ] Create `lib/features/home/domain/models/generated_image.dart`
- [ ] Add id field (String)
- [ ] Add userId field (String)
- [ ] Add imageUrl field (String)
- [ ] Add prompt field (String?)
- [ ] Add referenceImagePath field (String?)
- [ ] Add styleId field (String/int)
- [ ] Add createdAt field (DateTime)
- [ ] Add isFavorite field (bool)
- [ ] Add fromJson factory constructor
- [ ] Add toJson method
- [ ] Add copyWith method

**API Response Models:**
- [ ] Create `lib/core/models/api_response.dart`
- [ ] Add generic ApiResponse<T> class
- [ ] Add success field (bool)
- [ ] Add data field (T?)
- [ ] Add error field (String?)
- [ ] Add statusCode field (int?)
- [ ] Add factory constructors for success/error

### 2.3 Set Up Riverpod Providers

**Core Providers:**
- [ ] Create `lib/core/providers/user_provider.dart`
- [ ] Create userProvider (StateNotifierProvider)
- [ ] Create UserNotifier class
- [ ] Implement user state management (load/save user)
- [ ] Create userTypeProvider (computed from userProvider)
- [ ] Create canCreateTodayProvider (checks premium OR free with ad OR free with no creation today)

**Drawing Types Providers:**
- [ ] Create `lib/core/providers/drawing_types_provider.dart`
- [ ] Create drawingTypesProvider (FutureProvider)
- [ ] Load mock drawing types initially
- [ ] Add caching logic

**Create Screen Providers:**
- [ ] Create `lib/features/home/create_art/providers/create_providers.dart`
- [ ] Create promptProvider (StateProvider<String>)
- [ ] Create referenceImageProvider (StateProvider<File?>)
- [ ] Create selectedStyleProvider (StateProvider<String?>)
- [ ] Create generationStateProvider (StateNotifierProvider)
- [ ] Create GenerationStateNotifier class with states: idle/loading/success/error

**Daily Creation Providers:**
- [ ] Create `lib/core/providers/daily_creation_provider.dart`
- [ ] Create dailyCreationProvider (tracks if free user created today)
- [ ] Create adWatchedTodayProvider (tracks if ad was watched)
- [ ] Add logic to reset at midnight

**Home Screen Providers:**
- [ ] Create `lib/features/home/providers/home_providers.dart`
- [ ] Create selectedCategoryProvider (StateProvider<String>)
- [ ] Create recentGenerationsProvider (FutureProvider)
- [ ] Create filteredCreationsProvider (computed provider)

**Paywall Providers:**
- [ ] Create `lib/features/paywall/providers/paywall_providers.dart`
- [ ] Create subscriptionProvider (FutureProvider)
- [ ] Create purchaseStateProvider (StateNotifierProvider)

**Ad Providers:**
- [ ] Create `lib/features/ads/providers/ad_providers.dart`
- [ ] Create rewardedAdProvider (StateNotifierProvider)
- [ ] Create AdStateNotifier class
- [ ] Track ad states: loading/ready/showing/completed/failed

### 2.4 Convert Screens to ConsumerWidget
**Splash Screen:**
- [ ] Convert SplashView to ConsumerStatefulWidget
- [ ] Add WidgetRef to use providers
- [ ] Load drawing types on init
- [ ] Navigate when loaded

**Home Screen:**
- [ ] Convert HomeView to ConsumerStatefulWidget
- [ ] Watch userTypeProvider for user status
- [ ] Watch selectedCategoryProvider for filtering
- [ ] Watch filteredCreationsProvider for grid data
- [ ] Update UI based on provider states

**Create Screen:**
- [ ] Convert CreateVectorView to ConsumerStatefulWidget
- [ ] Watch userProvider for user type
- [ ] Watch canCreateTodayProvider for permission
- [ ] Watch generationStateProvider for loading/error/success
- [ ] Update Generate button based on user type & daily limit
- [ ] Use providers for prompt, image, style selection

**Paywall Screen:**
- [ ] Convert PaywallView to ConsumerStatefulWidget
- [ ] Watch subscriptionProvider for offerings
- [ ] Watch purchaseStateProvider for purchase flow
- [ ] Update UI based on loading/success/error states

---

## Phase 3: Backend Integration

### 3.1 Initialize Services

**Storage Service:**
- [ ] Create `lib/core/services/storage_service.dart`
- [ ] Initialize SharedPreferences
- [ ] Add methods: saveUserId, getUserId
- [ ] Add methods: saveUserType, getUserType
- [ ] Add methods: saveLastCreationDate, getLastCreationDate
- [ ] Add methods: saveAdWatchedToday, getAdWatchedToday
- [ ] Add methods: saveCachedDrawingTypes, getCachedDrawingTypes
- [ ] Add method: clearCache
- [ ] Create singleton pattern

**Anonymous User ID:**
- [ ] Update main.dart to initialize services
- [ ] Generate UUID on first launch
- [ ] Save to SharedPreferences
- [ ] Load on subsequent launches
- [ ] Set default user type to 'free'
- [ ] Initialize user provider with loaded data

**Network Service:**
- [ ] Initialize NetworkService in main.dart
- [ ] Call `await NetworkService().initialize()` before runApp()
- [ ] Ensure isolate worker is ready

### 3.2 Create API Service Layer

**Vector API Service:**
- [ ] Create `lib/core/services/vector_api_service.dart`
- [ ] Create VectorApiService class
- [ ] Inject NetworkService dependency
- [ ] Create method: `Future<GeneratedImage> generateVector({required userId, prompt, styleId, imageFile})`
- [ ] Build multipart FormData with: user_id, prompt, style_id, image
- [ ] Use NetworkService.uploadFile for POST request
- [ ] Parse API response to GeneratedImage model
- [ ] Handle errors and throw specific exceptions
- [ ] Add request cancellation support

**Error Handling:**
- [ ] Create `lib/core/exceptions/api_exceptions.dart`
- [ ] Define NetworkException
- [ ] Define APIException
- [ ] Define ValidationException
- [ ] Add user-friendly error messages

### 3.3 Integrate Vector Generation API

**Pre-Generation Checks:**
- [ ] Add user type validation
- [ ] Add daily limit check for free users
- [ ] Show "Watch Ad" button if limit reached
- [ ] Show "Go Premium" button if limit reached
- [ ] Validate inputs (style selected, prompt or image provided)

**Generation Flow:**
- [ ] Update Generate button onPressed
- [ ] Call VectorApiService.generateVector()
- [ ] Update generationStateProvider to loading
- [ ] Show LoadingOverlay
- [ ] Handle progress updates

**Success Handling:**
- [ ] Update generationStateProvider to success
- [ ] Save creation timestamp for free users
- [ ] Save generated image to local cache
- [ ] Navigate to Result screen with image data
- [ ] Show success feedback

**Error Handling:**
- [ ] Update generationStateProvider to error
- [ ] Hide LoadingOverlay
- [ ] Show ErrorDialog with error message
- [ ] Provide retry option
- [ ] Log errors for debugging

### 3.4 Add Mock Data Service

**Mock Data Service:**
- [ ] Create `lib/core/services/mock_data_service.dart`
- [ ] Create mockDrawingTypes list (6 types):
  - Engraving
  - Outcut
  - Linocut
  - Sticker
  - Chibi
  - Icon
- [ ] Add preview URLs for each style
- [ ] Create mockGeneratedImages list for Home screen
- [ ] Add method to simulate loading delay

**Integration:**
- [ ] Update drawingTypesProvider to use mock service
- [ ] Update Splash screen to load mock types
- [ ] Navigate to Home when loaded
- [ ] Update Create screen to use mock types
- [ ] Update Home screen to show mock generations

---

## Phase 4: Rewarded Ads & IAP Integration

### 4.1 Add Google Mobile Ads (Rewarded Ads)

**Setup:**
- [ ] Initialize AdMob in main.dart
- [ ] Add AdMob app IDs to AndroidManifest.xml
- [ ] Add AdMob app IDs to Info.plist
- [ ] Add test ad unit IDs for development

**Ad Service:**
- [ ] Create `lib/core/services/ad_service.dart`
- [ ] Create AdService class singleton
- [ ] Add method: loadRewardedAd()
- [ ] Add method: showRewardedAd()
- [ ] Add callbacks: onAdLoaded, onAdFailed, onAdCompleted, onAdDismissed
- [ ] Track ad state (loading/ready/showing)

**Ad State Management:**
- [ ] Update AdStateNotifier in ad_providers.dart
- [ ] Connect to AdService callbacks
- [ ] Track ad reward completion
- [ ] Update adWatchedTodayProvider on completion

**UI Integration:**
- [ ] Show "Watch Ad to Create" button for free users
- [ ] Handle button tap to load & show ad
- [ ] Show loading state while ad loads
- [ ] Show success message after ad completion
- [ ] Update canCreateTodayProvider after ad watched

### 4.2 Add RevenueCat (Premium Subscriptions)

**Setup:**
- [ ] Add purchases_flutter to pubspec.yaml
- [ ] Create RevenueCat account
- [ ] Set up products in App Store Connect (iOS)
- [ ] Set up products in Google Play Console (Android)
- [ ] Configure products in RevenueCat dashboard
- [ ] Get API keys for iOS and Android

**Initialization:**
- [ ] Update main.dart to initialize RevenueCat
- [ ] Add API keys
- [ ] Set up user identification (anonymous ID)

**Purchase Service:**
- [ ] Create `lib/core/services/purchase_service.dart`
- [ ] Create PurchaseService class
- [ ] Add method: getOfferings()
- [ ] Add method: purchasePackage(package)
- [ ] Add method: restorePurchases()
- [ ] Add method: checkSubscriptionStatus()
- [ ] Handle purchase callbacks

### 4.3 Create IAP Models & Providers

**Subscription Models:**
- [ ] Create `lib/features/paywall/domain/models/subscription_package.dart`
- [ ] Add identifier, price, title, description
- [ ] Add packageType (monthly/annual)
- [ ] Add isPopular flag

**Provider Updates:**
- [ ] Update subscriptionProvider to fetch from RevenueCat
- [ ] Create PurchaseStateNotifier
- [ ] Track states: idle/loading/purchasing/success/error
- [ ] Handle purchase flow states

### 4.4 Implement Purchase Flow

**Paywall Screen Updates:**
- [ ] Watch subscriptionProvider for offerings
- [ ] Display monthly and annual plans
- [ ] Show pricing from RevenueCat
- [ ] Add "Most Popular" badge
- [ ] Show benefits: Unlimited Creations, No Ads, etc.

**Purchase Logic:**
- [ ] Handle Subscribe button tap
- [ ] Update purchaseStateProvider to purchasing
- [ ] Call PurchaseService.purchasePackage()
- [ ] Show loading indicator
- [ ] Handle success: Update user type to premium
- [ ] Handle error: Show error dialog
- [ ] Handle cancellation

**Restore Purchases:**
- [ ] Handle Restore Purchases button tap
- [ ] Call PurchaseService.restorePurchases()
- [ ] Check for active subscriptions
- [ ] Update user type if subscription found
- [ ] Show success/error messages

**Post-Purchase:**
- [ ] Save premium status to storage
- [ ] Update userProvider to premium
- [ ] Navigate back to previous screen
- [ ] Show success message
- [ ] Enable unlimited creations

### 4.5 Daily Creation Logic for Free Users

**Daily Limit Implementation:**
- [ ] Check user type before generation
- [ ] If free: Check lastCreationDate
- [ ] Calculate hours since last creation
- [ ] If < 24 hours: Check if ad watched
- [ ] If ad watched: Allow creation
- [ ] If no ad: Show "Watch Ad" button

**Reset Logic:**
- [ ] Reset daily limit 24 hours after last creation
- [ ] Reset ad watched flag at midnight
- [ ] Update UI countdown timer
- [ ] Show "X hours until next free creation"

**Storage:**
- [ ] Save creation timestamp after successful generation
- [ ] Save ad watched flag after ad completion
- [ ] Load on app startup
- [ ] Clear when user upgrades to premium

---

## Phase 5: Local Storage & Caching

### 5.1 Create Storage Service Extensions

**User Data:**
- [ ] Add saveUser(User) method
- [ ] Add getUser() method
- [ ] Serialize User model to JSON
- [ ] Store in SharedPreferences
- [ ] Load on app startup

**Drawing Types Cache:**
- [ ] Add saveCachedDrawingTypes(List<DrawingType>) method
- [ ] Add getCachedDrawingTypes() method
- [ ] Add cache timestamp
- [ ] Implement TTL check (24 hours)
- [ ] Return null if cache expired

**Ad & Creation Tracking:**
- [ ] Add methods for ad watched tracking
- [ ] Add methods for last creation date
- [ ] Add daily reset logic
- [ ] Add cache clearing methods

### 5.2 Image Caching

**Local Image Storage:**
- [ ] Add sqflite dependency (if not using, use file system)
- [ ] Use path_provider for app directory
- [ ] Create images directory in app documents
- [ ] Save generated images with UUID names
- [ ] Store metadata in JSON file or sqflite

**Generated Images Management:**
- [ ] Save image file after generation
- [ ] Save metadata (prompt, style, timestamp)
- [ ] Load recent generations on Home screen
- [ ] Implement cache size limit (50 images max)
- [ ] Delete oldest when limit reached

**Image Display:**
- [ ] Use cached_network_image for remote images
- [ ] Use Image.file for local cached images
- [ ] Add fade-in animation
- [ ] Add error placeholder
- [ ] Add loading placeholder

### 5.3 Offline Support

**Connectivity Checking:**
- [ ] Add connectivity_plus dependency
- [ ] Create ConnectivityService
- [ ] Monitor network status
- [ ] Update UI based on connectivity

**Offline Behavior:**
- [ ] Show cached creations when offline
- [ ] Disable generation button when offline
- [ ] Show "No internet connection" banner
- [ ] Queue generation requests for retry
- [ ] Show offline indicator in UI

---

## Phase 6: Supabase Integration (Future)

### 6.1 Add Supabase (To be done after mock data)
- [ ] Add supabase_flutter dependency
- [ ] Create Supabase project
- [ ] Set up environment variables for API keys
- [ ] Initialize Supabase client in main.dart

### 6.2 Create Database Schema
- [ ] Create drawing_types table
- [ ] Add columns: id, name, preview_url, description, created_at
- [ ] Seed initial data
- [ ] Set up RLS policies

### 6.3 Replace Mock Data
- [ ] Create SupabaseService
- [ ] Add method: fetchDrawingTypes()
- [ ] Update drawingTypesProvider to fetch from Supabase
- [ ] Add error handling (fallback to cache)
- [ ] Update cache after successful fetch

---

## Phase 7: Testing & Performance

### 7.1 Create Test Structure
- [ ] Create test/ directory
- [ ] Add test dependencies to pubspec.yaml
- [ ] Create test/models/ for model tests
- [ ] Create test/providers/ for provider tests
- [ ] Create test/widgets/ for widget tests
- [ ] Create test/services/ for service tests

### 7.2 Unit Tests
**Model Tests:**
- [ ] Test User model serialization
- [ ] Test DrawingType model serialization
- [ ] Test GeneratedImage model serialization
- [ ] Test enum conversions

**Provider Tests:**
- [ ] Test userProvider state changes
- [ ] Test canCreateTodayProvider logic
- [ ] Test generationStateProvider flow
- [ ] Test filteredCreationsProvider filtering

**Service Tests:**
- [ ] Test StorageService save/load
- [ ] Test VectorApiService API calls (mocked)
- [ ] Test AdService ad flow
- [ ] Test PurchaseService purchase flow

### 7.3 Integration Tests
- [ ] Test full generation flow (free user)
- [ ] Test generation flow (premium user)
- [ ] Test ad watch flow
- [ ] Test purchase flow
- [ ] Test daily limit reset
- [ ] Test error scenarios

### 7.4 Performance Optimization
**Profiling:**
- [ ] Run Flutter DevTools
- [ ] Profile frame rendering
- [ ] Check for 60 FPS during scrolling
- [ ] Identify jank and stutters
- [ ] Profile memory usage

**Optimizations:**
- [ ] Optimize image loading (use cached_network_image)
- [ ] Add image compression for uploads
- [ ] Lazy load images in grid
- [ ] Use const constructors where possible
- [ ] Minimize rebuilds with providers

**Device Testing:**
- [ ] Test on low-end Android device
- [ ] Test on mid-range Android device
- [ ] Test on iOS device
- [ ] Test on tablet
- [ ] Ensure 60 FPS on all devices

### 7.5 Final Polish
**Animations:**
- [ ] Add page transition animations
- [ ] Add loading shimmer effects
- [ ] Add success animations
- [ ] Add micro-interactions
- [ ] Add haptic feedback

**User Experience:**
- [ ] Test complete user flows
- [ ] Fix edge cases
- [ ] Improve error messages
- [ ] Add helpful tooltips
- [ ] Polish loading states

---

## Implementation Timeline

### Week 1: UI Foundation
- Days 1-2: Phase 1.1 - 1.5 (Fix entry, enhance screens)
- Days 3-4: Phase 1.6 - 1.9 (User type system, reusable components)
- Day 5: Testing & bug fixes

### Week 2: State & Backend
- Days 1-2: Phase 2 (State management setup)
- Days 2-3: Phase 3 (API integration)
- Days 4-5: Phase 4 (Ads & IAP)

### Week 3: Storage & Polish
- Days 1-2: Phase 5 (Local storage & caching)
- Days 3-5: Phase 7 (Testing & performance)

### Future: Supabase
- Phase 6 (When ready to integrate real backend)

---

## Success Criteria

- [ ] App launches to Splash screen
- [ ] Splash loads drawing types and navigates to Home
- [ ] Home displays categories and creations with filtering
- [ ] Create screen allows image/prompt input and style selection
- [ ] Free users can watch ad to create 1 image daily
- [ ] Premium users have unlimited creations
- [ ] Generation calls real API and displays result
- [ ] Result screen shows generated image with actions
- [ ] Paywall allows subscription purchase
- [ ] Local caching works for images and types
- [ ] App maintains 60 FPS
- [ ] All screens match design system
- [ ] Error handling is user-friendly
- [ ] Tests cover critical flows

---

## Notes

- Start with mock data for drawing types
- API endpoint is available: http://api.yazilimgo.com/vector/index.php
- Use NetworkService's uploadFile method for multipart/form-data
- Focus on UI polish first before complex backend logic
- Ensure all screens use design system (DColors, DTextStyles, etc.)
- Maintain glassmorphism aesthetic throughout
