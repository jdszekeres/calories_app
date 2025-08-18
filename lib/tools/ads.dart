import 'dart:async';
import 'dart:io';

import 'package:calories_app/widgets/web_advertisement.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {
  static String get adUnitId {
    // Use test ad unit IDs in debug mode or when running on simulator
    if (kDebugMode) {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/1712485313'; // iOS test rewarded ad unit
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/5224354917'; // Android test rewarded ad unit
      }
    }
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
      print('Ads initialized successfully.');
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

    // Use a Completer to wait for the ad to load
    final completer = Completer<RewardedAd?>();

    // Add a timeout for ad loading
    Timer timeoutTimer = Timer(Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        print('Ad loading timed out');
        completer.complete(null);
      }
    });

    try {
      await RewardedAd.load(
        adUnitId: adUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            timeoutTimer.cancel();
            _rewardedAd = ad;
            _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (RewardedAd ad) {
                ad.dispose();
                _rewardedAd = null;
              },
              onAdFailedToShowFullScreenContent:
                  (RewardedAd ad, AdError error) {
                    print('Failed to show ad: $error');
                    ad.dispose();
                    _rewardedAd = null;
                  },
            );
            print("loaded ${_rewardedAd?.adUnitId}");
            if (!completer.isCompleted) {
              completer.complete(_rewardedAd);
            }
          },
          onAdFailedToLoad: (LoadAdError error) {
            timeoutTimer.cancel();
            print('Failed to load rewarded ad: $error');
            // Check if it's a network error and we're in debug mode
            if (kDebugMode && error.code == 2) {
              print(
                'Network error detected in debug mode - this is common on simulators',
              );
            }
            if (!completer.isCompleted) {
              completer.complete(null);
            }
          },
        ),
      );
    } catch (e) {
      timeoutTimer.cancel();
      print('Exception while loading ad: $e');
      if (!completer.isCompleted) {
        completer.complete(null);
      }
    }

    return completer.future;
  }

  void showRewardedAd({required VoidCallback onUserEarnedReward}) {
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('User earned reward: ${reward.amount} ${reward.type}');
          onUserEarnedReward();
        },
      );
      _rewardedAd = null; // Reset after showing
    } else {
      print('Rewarded ad is not ready yet.');
    }
  }

  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }
}
