import 'dart:async';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

final adBannerId = Platform.isAndroid ? 'ca-app-pub-7216031421590870/4555878988' : 'ca-app-pub-3940256099942544/2934735716';

final adInterstitialId = Platform.isAndroid ? 'ca-app-pub-7216031421590870/6383395151' : 'ca-app-pub-3940256099942544/4411468910';

final adRewardedId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-3940256099942544/1712485313';

class AdmobPlugin {
  static Future<void> init() async {
    await MobileAds.instance.initialize();
  }

  static Future<BannerAd> loadBannerAd() async {
    return BannerAd(
      adUnitId: adBannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          // print('$ad loaded.');
        },
        onAdFailedToLoad: (ad, err) {
          // print('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  static Future<InterstitialAd> loadInterstitialAd() async {
    Completer<InterstitialAd> completer = Completer();
    InterstitialAd.load(
        adUnitId: adInterstitialId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {},
              onAdImpression: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdClicked: (ad) {},
            );

            completer.complete(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            completer.completeError(error);
          },
        ));
    return completer.future;
  }

  static Future<RewardedAd> loadRewardedAd() async {
    Completer<RewardedAd> completer = Completer();

    RewardedAd.load(
        adUnitId: adRewardedId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            completer.complete(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            completer.completeError(error);
          },
        ));
    return completer.future;
  }
}
