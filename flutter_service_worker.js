'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/assets/images/coin/bronze/Bronze_6.png": "20fc91d412676d44072076a76a531254",
"assets/assets/images/coin/bronze/Bronze_10.png": "e5af7b7945eee9162bcf22178458d20c",
"assets/assets/images/coin/bronze/Bronze_28.png": "e2441c00169c826e670e98779c3395f7",
"assets/assets/images/coin/bronze/Bronze_27.png": "56a690a6f5dbfce9f461b2890fc7df10",
"assets/assets/images/coin/bronze/Bronze_5.png": "921ad136a387dc955f847d39f97d1bc7",
"assets/assets/images/coin/bronze/Bronze_15.png": "7a5be0cda4040b191d5804c1cd205dac",
"assets/assets/images/coin/bronze/Bronze_22.png": "3a32750e49a16ced671ca415f2fd7669",
"assets/assets/images/coin/bronze/Bronze_2.png": "ea6722f2a06db0d09a784a5a3c4dd640",
"assets/assets/images/coin/bronze/Bronze_16.png": "fc04ff46c31a41ceca9c2b1e4f09097d",
"assets/assets/images/coin/bronze/Bronze_13.png": "285a2c13687c9a2b48dcfc2930114e87",
"assets/assets/images/coin/bronze/Bronze_26.png": "a63a0f1bbc6f79ed6fc96053aed046ac",
"assets/assets/images/coin/bronze/Bronze_17.png": "0f1d6d41b32a37233e86cc0c4d226b2c",
"assets/assets/images/coin/bronze/Bronze_19.png": "2895c4826dc0ae7da9c147acd93a6fb6",
"assets/assets/images/coin/bronze/Bronze_4.png": "beb6c2f024f85a6f6fc70174d3d40e75",
"assets/assets/images/coin/bronze/Bronze_21.png": "50e26f93c1f836fcdab5e1b7cbc621f0",
"assets/assets/images/coin/bronze/Bronze_23.png": "2fd22f77aeaa843b65e28e79ef3762e7",
"assets/assets/images/coin/bronze/Bronze_25.png": "e6b7241531e23389d180fa919675d3fd",
"assets/assets/images/coin/bronze/Bronze_29.png": "e100cdbc66a9c4d8b64db17965cebadb",
"assets/assets/images/coin/bronze/Bronze_9.png": "2fe036da608b843527cd7155acf0c794",
"assets/assets/images/coin/bronze/Bronze_7.png": "86ef9b7388962aeb142ed8bf81c79df4",
"assets/assets/images/coin/bronze/Bronze_1.png": "6c2af7f3a3d35588ecca68baee8c5ce1",
"assets/assets/images/coin/bronze/Bronze_30.png": "f9615549b9faaabba27b4e3b2467c27c",
"assets/assets/images/coin/bronze/Bronze_12.png": "d2e0886420de76a8d2b2bbdc12bba2f6",
"assets/assets/images/coin/bronze/Bronze_18.png": "589bc77b856bf21640e2e0592027cca5",
"assets/assets/images/coin/bronze/Bronze_11.png": "fb6df09e888e913687716e946bfe8718",
"assets/assets/images/coin/bronze/Bronze_24.png": "25d00c988999aea528e64931947e1bed",
"assets/assets/images/coin/bronze/Bronze_20.png": "bc7b98891fe7ad5b01cc331f37062a34",
"assets/assets/images/coin/bronze/Bronze_14.png": "065fc236ac39cdbd4ebc9199c21c5514",
"assets/assets/images/coin/bronze/Bronze_8.png": "a564c4fc6d542d93829a6e5744f7bce7",
"assets/assets/images/coin/bronze/Bronze_3.png": "7ba4e9b943d3f520837da4a349ece904",
"assets/assets/images/characters/main/stay_2.png": "749a7351248b9c5191410bc6ef9a6705",
"assets/assets/images/characters/main/stay_1.png": "cede60c64ba87c48cd3154f7095f00ab",
"assets/assets/images/characters/dog/Hurt.png": "f653f8d78c91a452a56e28daa71a9789",
"assets/assets/images/characters/dog/Walk.png": "9152029301592668a9dea72d6c5c0a5a",
"assets/assets/images/characters/dog/Death.png": "c71002dd216367216836dc754c6ca764",
"assets/assets/images/characters/dog/Attack.png": "5145949e4dd21df9e4fe352d26e04eea",
"assets/assets/images/characters/dog/Idle.png": "7a974ed2ff74b9093d284ce39198cedc",
"assets/assets/images/characters/cat/Hurt.png": "3278d202abc29fab70c69fe705ff872a",
"assets/assets/images/characters/cat/Walk.png": "79e6dc9297ad4f16d90641eaf12dbc1f",
"assets/assets/images/characters/cat/Death.png": "212f550dfadae1845164a67d918785cb",
"assets/assets/images/characters/cat/Attack.png": "2c62db4749d05baa5be9017b5542b959",
"assets/assets/images/characters/cat/Idle.png": "7f4f4e0e9b8354fdb17e949ce03f9930",
"assets/FontManifest.json": "d751713988987e9331980363e24189ce",
"assets/AssetManifest.json": "d59d303a855855ebf983346c18d61967",
"assets/NOTICES": "f2b1e3d5f8ad4d0699f626dd2f5d0898",
"assets/AssetManifest.bin": "abde6118cb1f0ea2948f15160a5f140a",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin.json": "cc8dad18e90026675a067bcaa9b30a78",
"manifest.json": "9da947e7564da5e25db6c5f571bf78fe",
"index.html": "32d642c0f1bfb663a03201b186f20c2c",
"/": "32d642c0f1bfb663a03201b186f20c2c",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "da7a59e1978987dbc05235c17084dc07",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"version.json": "a7014ca46ed865f7c604f2ec1be2cf03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
