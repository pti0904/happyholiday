import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:happyholiday/sample_ads_unit.dart';

class InterstitialHelper {
  InterstitialAd? _interstitialAd;
  int numOfAttemptLoad = 0;

  void createInterad() {
    InterstitialAd.load(
        adUnitId: INTERSTITIAL_TEST,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            numOfAttemptLoad = 0;
          },
          onAdFailedToLoad: (error) {
            numOfAttemptLoad + 1;
            _interstitialAd = null;

            if (numOfAttemptLoad <= 2) {
              createInterad();
            }
          },
        ));
  }

  void showInterad() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('%ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterad();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );

    _interstitialAd!.show();

    _interstitialAd = null;
  }
}