# Initial Requirements — Vectoral Image Generator AI App

> **Short description**
>
> A lightweight, high-performance vector image generation mobile app that communicates with a backend image-generation endpoint. The app supports three input modes: prompt-only, prompt + reference image, and reference-image-only. Drawing types (styles) are fetched from Supabase. Image creation calls are made as `multipart/form-data` POST requests to `http://api.yazilimgo.com/vector/index.php` with fields: `user_id`, `prompt`, and `style_id`.

---

## Table of contents

1. Project overview
2. Primary features
3. Screens / UI
4. Backend integration & API
5. Data & storage
6. State management
7. Performance & responsiveness
8. Theming & styling
9. Error handling & resiliency
10. Testing & QA
11. Non-functional requirements
12. Deliverables & milestones

---

## 1. Project overview

* Platform: Mobile (Flutter)
* Purpose: Let anonymous users create vector images using text prompts and/or reference images.
* Users: All anonymous — `user_id` is generated/stored client-side from Supabase (no sign-in flows).
* Architecture: Flutter front-end + Supabase for small data (drawing types, anonymous user id storage). Image generation performed by external API (`http://api.yazilimgo.com/vector/index.php`).

## 2. Primary features

* Create images with three modes:

  * Prompt only
  * Prompt + reference image
  * Reference image only
* Fetch available drawing types / styles from Supabase at app startup (or lazily when needed).
* Send create-image requests as `multipart/form-data` POST to the provided endpoint.
* Display progress, success, and error states for generation requests.
* Keep UI fluid at minimum 60 FPS; avoid UI jank during network calls and parsing.

## 3. Screens / UI

* All view HTML files live under `assets/screen_uis`.
* Screens:

  1. **Splash** — initial loading, fetch minimal data (drawing types, cached user_id). Should be short and show a graceful loading state.
  2. **Home** — list of drawing types, quick actions, recent generated images (if stored locally) and navigation to Create Image screen.
  3. **Create Image** — editor with prompt input, reference image picker (camera / gallery), style selector, preview area, and create button.
* UI constraints:

  * Use `Consumer`/`ConsumerWidget` to read providers.
  * Update state at the smallest component possible (fine-grained providers).
  * All screens use dark theme only.

## 4. Backend integration & API

* Image generation endpoint (server expects `multipart/form-data`):

  * URL: `http://api.yazilimgo.com/vector/index.php`
  * Required fields:

    * `user_id` — determined from Supabase (anonymous id persisted locally)
    * `prompt` — text prompt (empty string allowed when using reference-only)
    * `style_id` — integer or string ID mapping to drawing type returned from Supabase
  * If sending a reference image, include it as a `file` field in the same multipart form data (use conventional field name like `image` or `file` — coordinate with backend if needed).

* Supabase integration:

  * Fetch drawing types/styles via Supabase REST or client SDK. Cache locally and refresh on pull-to-refresh.
  * Store an anonymous `user_id` value in Supabase or obtain/generate a stable anonymous id and persist locally (e.g. secure storage or shared preferences). The app has no auth flow.

* Request & response behavior:

  * Use non-blocking HTTP calls (Dart `http` or Dio with isolates for heavy parsing).
  * Enforce reasonable timeouts and allow request cancellation.
  * Parse responses off the UI thread if payload is large (use `compute` or isolates).

### Example (curl)

```bash
curl -X POST "http://api.yazilimgo.com/vector/index.php" \
  -F "user_id=ANONYMOUS-ID-EXAMPLE" \
  -F "prompt=An abstract geometric vector of a futuristic city" \
  -F "style_id=3" \
  -F "image=@/path/to/reference.png"
```

> Note: Confirm the exact multipart field names for the reference image with the backend team if not already standardized.

## 5. Data & storage

* Local caching:

  * Cache drawing types locally (with TTL).
  * Optionally cache latest generated images (to speed previews) — store thumbnails and metadata only.
  * Persist `user_id` locally (secure storage or shared preferences) so that the same id is reused.
* No user accounts. All users are anonymous.

## 6. State management (Riverpod)

* Use Riverpod for all app state.
* Guidelines:

  * Provide fine-grained providers: one provider per small UI unit (e.g., `promptProvider`, `referenceImageProvider`, `styleSelectorProvider`, `createImageRequestProvider`).
  * Use `StateNotifier` / `StateNotifierProvider` for more complex logic (request lifecycle, loading/error states).
  * Use `ConsumerWidget` or `Consumer` where UI needs to react to provider changes.
  * Avoid large monolithic providers that update many unrelated widgets.
  * Keep side effects inside providers or dedicated controllers (networking, caching).

## 7. Performance & responsiveness

* App must maintain **minimum 60 FPS** during normal use.
* Networking and parsing must be non-blocking:

  * Execute heavy JSON or binary parsing in isolates (`compute`) to avoid main thread stalls.
  * Use asynchronous image decoding and caching libraries where appropriate.
  * Show progressive UI states (skeletons / placeholders) while waiting for results to avoid layout rebuild spikes.
* Memory & CPU:

  * Limit in-memory image sizes; use thumbnails for previews and fetch full-size only when needed.
  * Cancel or debounce frequent requests (for example, if user is rapidly changing prompts).
* Stress testing:

  * Test on low-end devices to ensure 60 FPS target remains achievable for major flows.

## 8. Theming & styling

* Only **dark theme** supported.
* Theme must be defined at the top level using Flutter's theming system (`ThemeData`), do not hardcode colors or decorations in widgets.
* No manual color constants scattered across widgets — use `Theme.of(context)` or extension helpers to access theme colors.
* Provide a single source of truth for typography, spacing, radii, and iconography.

## 9. Error handling & resiliency

* Network errors:

  * Present clear, actionable messages on network failure (retry, check connection).
  * Backoff strategy for repeated failures.
* API errors:

  * Validate responses and surface server error messages when helpful.
  * Handle malformed responses gracefully without crashing.
* UI/UX fallback:

  * Ensure the app never freezes — any background failure must degrade gracefully (show an error state or retry option).

## 10. Security & privacy

* Users are anonymous. Do not collect PII.
* Persist only a stable anonymous `user_id` and minimal metadata required for the app.
* Secure storage for `user_id` if necessary.
* All external requests should use HTTPS where possible; if using HTTP (current endpoint provided is `http://`) discuss with backend team to upgrade to HTTPS for production.

## 11. Testing & QA

* Unit tests for providers and business logic.
* Integration tests for the create-image flow (mock network responses where appropriate).
* Performance tests to verify UI stays >= 60 FPS during heavy operations.
* Manual QA on multiple device profiles (low/mid/high end) and Android/iOS.

## 12. Non-functional requirements

* Smoothness: 60 FPS minimum on supported devices.
* Robustness: App must not crash on malformed responses or missing network.
* Responsiveness: UI must remain interactive while requests are in-flight.
* Maintainability: Code should be modular with clear separation of concerns (UI, state, network, storage).

## 13. Deliverables

* `initial_requirements.md` (this document)
* Wireframes / screenshots for Splash, Home, Create Image
* Riverpod architecture sketch (diagram or document)
* Sample network client implementing the `multipart/form-data` POST
* Test plan and basic performance report

## 14. Implementation notes / suggestions

* Network library: consider `dio` for multipart support combined with cancellable requests.
* Parsing: use isolates/`compute` for heavy parsing and image decoding.
* Caching: use `sqflite` or local file storage for thumbnail caching; use `shared_preferences` or `secure_storage` for `user_id`.
* UI: use `ConsumerWidget` and `HookConsumerWidget` (if using hooks) for concise provider usage.
* Ensure the HTML assets under `assets/screen_uis` are included in `pubspec.yaml` and loaded efficiently (do not block the main thread while parsing heavy HTML if applicable).

---

If anything above needs to be adjusted (field names for multipart, exact Supabase table schema for drawing types, or switching the endpoint to HTTPS), list the changes and we will update this file.
