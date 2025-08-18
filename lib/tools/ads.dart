import 'dart:io';

import 'package:calories_app/widgets/web_advertisement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {
  static String get adUnitId {
    return dotenv.env['REWARDED_ADS_ID']!;
  }

  static String get appID {
    return dotenv.env['ADS_APP_ID']!;
  }

  static Future<void> initializeAds() async {
    bool isSupported = false;
    try {
      isSupported = Platform.isIOS || Platform.isAndroid;
    } catch (e) {
      isSupported = false;
    }
    if (isSupported) {
      await MobileAds.instance.initialize();
    } else {
      print('Ads are not supported on this platform.');
    }
  }

  RewardedAd? _rewardedAd;

  Future<RewardedAd?> loadRewarded(BuildContext context) async {
    bool isSupported = false;
    try {
      isSupported = Platform.isIOS || Platform.isAndroid;
    } catch (e) {
      isSupported = false;
    }
    if (!isSupported) {
      return null;
    }

    await RewardedAd.load(
      adUnitId: adUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load rewarded ad: $error');
        },
      ),
    );

    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
      },
    );
    return _rewardedAd;
  }
}
