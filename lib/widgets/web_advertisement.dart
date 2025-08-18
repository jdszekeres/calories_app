import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../web_launcher_stub.dart'
    if (dart.library.html) '../web_launcher_web.dart';

class WebAdvertisement extends StatefulWidget {
  const WebAdvertisement({Key? key, required this.onClose}) : super(key: key);

  final VoidCallback onClose;

  @override
  _WebAdvertisementState createState() => _WebAdvertisementState();
}

class _WebAdvertisementState extends State<WebAdvertisement>
    with TickerProviderStateMixin {
  late AnimationController _countdownController;
  bool _canClose = false;

  @override
  void initState() {
    super.initState();
    _countdownController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _countdownController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _canClose = true;
        });
      }
    });

    _countdownController.forward();
  }

  @override
  void dispose() {
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                kIsWeb
                    ? AppLocalizations.of(context)!.webAdvertisementTitle
                    : AppLocalizations.of(context)!.mobileAdvertisementTitle,
              ),
              SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.useMobileAppMessage),
              ElevatedButton(
                onPressed: () {
                  launchUrl(
                    "https://apps.apple.com/us/app/calorie-tracker-pro-max/id6749119246",
                  );
                },
                child: Text(AppLocalizations.of(context)!.downloadApp),
              ),
              SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.supportMeMessage),
              ElevatedButton(
                onPressed: () {
                  launchUrl("https://buymeacoffee.com/jdszekeres");
                },
                child: Text(AppLocalizations.of(context)!.supportMe),
              ),
            ],
          ),
          // Close button with countdown ring
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: _canClose ? widget.onClose : null,
              child: AnimatedBuilder(
                animation: _countdownController,
                builder: (context, child) {
                  return Container(
                    width: 36,
                    height: 36,
                    child: Stack(
                      children: [
                        // Circular progress indicator
                        CircularProgressIndicator(
                          value: _countdownController.value,
                          strokeWidth: 3,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _canClose ? Colors.green : Colors.blue,
                          ),
                        ),
                        // X button
                        Center(
                          child: Icon(
                            Icons.close,
                            color: _canClose ? Colors.black : Colors.grey,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
