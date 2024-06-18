import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../constants/colors.dart';

class MovieDetailNotification extends StatefulWidget {
  final int movieId;

  const MovieDetailNotification({super.key, required this.movieId});

  @override
  State<MovieDetailNotification> createState() =>
      _MovieDetailNotificationState();
}

class _MovieDetailNotificationState extends State<MovieDetailNotification> {
  bool notifyReleaseDate = false;
  bool notifyReviews = false;
  bool notifyDvdRelease = false;
  bool notifyDigitalRelease = false;
  bool isLoading = false;
  String? errorMessage;

  void _savePreferences() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // Simulate a network call to save preferences
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
      // If there's an error, set the errorMessage to display it
      // errorMessage = 'Failed to save preferences';
    });

    if (errorMessage == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Preferences saved successfully!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: kPrimaryColor.withOpacity(0.5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        child: Column(
          children: [
            MovieDetailNotificationRow(
              title: 'Notify When This Movie Releases',
              value: notifyReleaseDate,
              onChanged: (value) {
                if (value != null) {
                  setState(() => notifyReleaseDate = value);
                }
              },
            ),
            MovieDetailNotificationRow(
              title: 'Notify When The Reviews Are Available',
              value: notifyReviews,
              onChanged: (value) {
                if (value != null) {
                  setState(() => notifyReviews = value);
                }
              },
            ),
            MovieDetailNotificationRow(
              title: 'Notify When This Movie Releases on DVD',
              value: notifyDvdRelease,
              onChanged: (value) {
                if (value != null) {
                  setState(() => notifyDvdRelease = value);
                }
              },
            ),
            MovieDetailNotificationRow(
              title: 'Notify When This Movie Releases on Digital',
              value: notifyDigitalRelease,
              onChanged: (value) {
                if (value != null) {
                  setState(() => notifyDigitalRelease = value);
                }
              },
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 10),
            if (isLoading)
              Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: kPrimaryColor,
                  size: 40,
                ),
              )
            else
              ElevatedButton(
                onPressed: _savePreferences,
                child: const Text('Save Preferences'),
              ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailNotificationRow extends StatelessWidget {
  final bool value;
  final String title;
  final void Function(bool?) onChanged;

  const MovieDetailNotificationRow({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.055,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox.adaptive(
            value: value,
            onChanged: onChanged,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
