'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "3335e381bfa21283c2cdd6e7f8d4fe66",
"assets/AssetManifest.json": "73033aa1e49366a873b754b6832eed2d",
"assets/assets/fonts/Rubik-BoldItalic.ttf": "dc069fd43e202359cfef038ce28b20ac",
"assets/assets/fonts/Rubik-Medium.ttf": "e785acbf5775e9bec2129f4967a75472",
"assets/assets/fonts/Rubik-Regular.ttf": "46df28800514364ef2766f74386b1bd3",
"assets/assets/images/berlingo.svg": "2616dcc064abbb139e018222cf94c378",
"assets/assets/images/camion.jpg": "bd5ec2e3321c4a3fdfc1e63a2941714a",
"assets/assets/images/camiona.svg": "c94aa56b5f80ff2e33690e477cf8ee31",
"assets/assets/images/carousel1.jpg": "609b846113e836b216e1a7da1cde21ba",
"assets/assets/images/carousel2.jpg": "d08f93af27fa69424a64305189ceb6ac",
"assets/assets/images/carousel3.jpg": "3e3a15e21ca03d39e072a8ba988d0389",
"assets/assets/images/confused.png": "a529b816d68c91332094a3082bca5fd3",
"assets/assets/images/direction.png": "aadcd2c08211448ec1c1c766409d4e84",
"assets/assets/images/forgot-password.png": "9e28ec59355326080e8134790d0c50c6",
"assets/assets/images/logoWithName.png": "8952b788291367987913727ca0711ffd",
"assets/assets/images/logoWithoutName.svg": "8da115772480aced3c5b68ff8d129f1e",
"assets/assets/images/map.png": "a254ed449b738fb6267678096236d841",
"assets/assets/images/password.png": "fd45d932f1254363cfeca5e4dc8bffbe",
"assets/assets/images/poid_lourd.svg": "d62ced115d75a578fd50a51e60aae689",
"assets/assets/images/profile-circle.svg": "b8714781f808c32b3eb4e508d1a30174",
"assets/assets/images/right-arrow.png": "5111b6f55b97f3e6705cf014aa712b7d",
"assets/assets/images/route.png": "7eadb830924b8ecd79a82798f82deff1",
"assets/assets/images/semi.svg": "3d436bc9df7d56da0d6badf84995c143",
"assets/assets/images/target.png": "a6703fa518e62a68516a158673e7813a",
"assets/assets/images/trab.svg": "b5a17aec50a4d37e7700eef24c63ee64",
"assets/assets/images/warning.png": "ff5b1b3b5e8a116ab26a949c8c994eb2",
"assets/assets/images/welcome.jpg": "f1e90eee9d97469026d7a2ea29565534",
"assets/FontManifest.json": "988c58bc521e108390161e562b199040",
"assets/fonts/MaterialIcons-Regular.otf": "b6c10ee200701d0fbb1699761e9ab401",
"assets/mouvema.png": "15d705ca954418046a0d11c3427849b3",
"assets/mouvemaLoading.gif": "e541e5eb5e3abce325f4f45f9151d945",
"assets/NOTICES": "ce8469a88452fc4adf343fe33e9aeb49",
"assets/packages/awesome_dialog/assets/flare/error.flr": "e3b124665e57682dab45f4ee8a16b3c9",
"assets/packages/awesome_dialog/assets/flare/info.flr": "bc654ba9a96055d7309f0922746fe7a7",
"assets/packages/awesome_dialog/assets/flare/info2.flr": "21af33cb65751b76639d98e106835cfb",
"assets/packages/awesome_dialog/assets/flare/info_without_loop.flr": "cf106e19d7dee9846bbc1ac29296a43f",
"assets/packages/awesome_dialog/assets/flare/question.flr": "1c31ec57688a19de5899338f898290f0",
"assets/packages/awesome_dialog/assets/flare/succes.flr": "ebae20460b624d738bb48269fb492edf",
"assets/packages/awesome_dialog/assets/flare/succes_without_loop.flr": "3d8b3b3552370677bf3fb55d0d56a152",
"assets/packages/awesome_dialog/assets/flare/warning.flr": "68898234dacef62093ae95ff4772509b",
"assets/packages/awesome_dialog/assets/flare/warning_without_loop.flr": "c84f528c7e7afe91a929898988012291",
"assets/packages/awesome_dialog/assets/rive/error.riv": "e74e21f8b53de4b541dd037c667027c1",
"assets/packages/awesome_dialog/assets/rive/info.riv": "2a425920b11404228f613bc51b30b2fb",
"assets/packages/awesome_dialog/assets/rive/info_reverse.riv": "c6e814d66c0e469f1574a2f171a13a76",
"assets/packages/awesome_dialog/assets/rive/question.riv": "00f02da4d08c2960079d4cd8211c930c",
"assets/packages/awesome_dialog/assets/rive/success.riv": "73618ab4166b406e130c2042dc595f42",
"assets/packages/awesome_dialog/assets/rive/warning.riv": "0becf971559a68f9a74c8f0c6e0f8335",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "15d705ca954418046a0d11c3427849b3",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/favicon.png": "15d705ca954418046a0d11c3427849b3",
"index.html": "fd1b5cd40f76f28f335973eb089ae4d4",
"/": "fd1b5cd40f76f28f335973eb089ae4d4",
"main.dart.js": "39fd8b75539d2d859e43eed4fa825e66",
"manifest.json": "48bb15ab1ef5817f69c824c2a52c75da",
"splash/img/dark-1x.png": "a2fec813ec2da8e233abb1ead204181a",
"splash/img/dark-2x.png": "331ecee07f38416e802ac168fb7d00cf",
"splash/img/dark-3x.png": "34200c997312bd1ca876ddb0f560afe7",
"splash/img/dark-4x.png": "b68bc1a45dbce3ce206423214a85f936",
"splash/img/light-1x.png": "a2fec813ec2da8e233abb1ead204181a",
"splash/img/light-2x.png": "331ecee07f38416e802ac168fb7d00cf",
"splash/img/light-3x.png": "34200c997312bd1ca876ddb0f560afe7",
"splash/img/light-4x.png": "b68bc1a45dbce3ce206423214a85f936",
"version.json": "931647244a0441f8c03c5a6132cbf446"};
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
