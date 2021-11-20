import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quran_app/ads/adsHelper.dart';

class AdsProvider extends GetxController{
  BannerAd myBanner;
  // BannerAd myBanner1;
  // BannerAd myBanner2;
  // BannerAd myBanner3;
  InterstitialAd interstitialAd;
  bool isLoaded = false;
  bool _isInterstitialAdLoaded = false;
  AdWidget _adWidget;
  Container adContainer;
  @override
  void onInit() {
    super.onInit();
    bannerAd();
    interstitialAdLoad();
  }


  final AdRequest targetingInfo = AdRequest(
    keywords: <String>['quran'],
    contentUrl: 'https://flutter.io',
    nonPersonalizedAds: true,
  );


  Future<void> interstitialAdLoad(){
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),

        adLoadCallback: InterstitialAdLoadCallback(

          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this.interstitialAd = ad;
            _isInterstitialAdLoaded = true;
            print('InterstitialAd loaded');
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            _isInterstitialAdLoaded = false;
            interstitialAd.dispose();
            print('InterstitialAd failed to load: $error');
            update();
          },
        ));
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        interstitialAdLoad();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        interstitialAdLoad();
      },
    );
    interstitialAd.show();
    interstitialAd = null;
  }

  Future<void> bannerAd({banner}){
   myBanner = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: targetingInfo,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          isLoaded = true;
          print('Banner loaded');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          isLoaded = false;
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );
   myBanner.load();
   _adWidget = AdWidget(ad: myBanner);
   adContainer = Container(
     alignment: Alignment.center,
     child: _adWidget,
     width: myBanner.size.width.toDouble(),
     height: myBanner.size.height.toDouble(),
   );
  }
}


