'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "99d1a14a3c0b55cb8cb55afdabf28366",
"assets/assets/alerted.gif": "7bd26a28df2a15f10e108947c842f3f4",
"assets/assets/barcelona.jpg": "decbb26390b27a810e076de0c01e635e",
"assets/assets/binocular.png": "c4b758cde3fc457905d09f95bfa66c48",
"assets/assets/cloud%2520airlines.jpg": "d277ddb88307fbe6c8ba87cbb5506744",
"assets/assets/cloud%2520airlines2.jpg": "64d0f2d2f6a079b110899a9dfb8f48ab",
"assets/assets/cloud_airlines2_resized.jpg": "a90cc3608db1ff1f2b336468efdce577",
"assets/assets/cloud_airlines_transparent.png": "2381e032765cd702aa761a91615e4843",
"assets/assets/cloud_airlines_transparent_resized.png": "9127f024cc5b05b7072958367c24a6ee",
"assets/assets/compass.png": "67014cda4d654693be6f2eb5b109650c",
"assets/assets/dashboard.png": "2a0291c1311ebe3965686b778fe973f9",
"assets/assets/dish.png": "dd37df538a915aeac61178441b22dbc1",
"assets/assets/favorites.jpg": "4a2fc97c5b34fe16e66023d4bd3d41e5",
"assets/assets/favorites2.jpg": "13722af56ee4040d0d39ab72d961c667",
"assets/assets/FlightIcons.ttf": "9c02e63dbbe55e85f2c166c5984df253",
"assets/assets/flight_bg.jpg": "a704bcc9bfcf5131c3d51a717873d08e",
"assets/assets/flight_bg2.jpg": "43db8078c8f53667048239be8a5809c5",
"assets/assets/flight_bg3.jpg": "1afdb2798023e954e821bf3806e41ece",
"assets/assets/flight_browse.jpg": "bc0d0d4c149d5f1cf984319069213f2e",
"assets/assets/flight_browse2.jpg": "95f34a5e5371a6cd74c6984e4042fada",
"assets/assets/flight_info.jpg": "517c6bc8dcae37692b3e47b9d8c62209",
"assets/assets/home_screen_background.jpg": "af82b18b07cb2dd27e81a45360359a38",
"assets/assets/home_screen_background.png": "27c24ba78d1819c665f47c38a7a03037",
"assets/assets/map.jpg": "154960442ef8d0dfcd1ada72cdad3784",
"assets/assets/monumen.png": "b372bc43c9c4d88e9125d6cd32622aa2",
"assets/assets/on_the_way.gif": "094377c70e747cf87d33fe218c429f4c",
"assets/assets/poi_icon.png": "1038c1c2ed55b6e2ef0df35a724063da",
"assets/assets/safetyInstructions.mp4": "f94355bc78755376c8fbef9a7be9a825",
"assets/FontManifest.json": "41da26d7c6fc4314acba1ff874c106a3",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/NOTICES": "33dbba13ea8b778d3b9c74faa1d4626e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/survey_kit/assets/fancy_checkmark.json": "ba198bdf17f5a9a97e89d74c61921edb",
"assets/packages/wakelock_web/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "dd5c37fb406558d634aa11164c0064d7",
"/": "dd5c37fb406558d634aa11164c0064d7",
"main.dart.js": "1db7112504148df204d0aa8bc1147084",
"manifest.json": "dc3c0a1ec09338119506f0a61eb8bcab",
"version.json": "2b521e10dfa0f067561de489a19d6620"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
