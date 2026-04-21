import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers.dart';
import '../../../domain/recording.dart';

class RecordingWidget extends ConsumerWidget {
  const RecordingWidget({required this.onStop, super.key});
  final Function(Recording) onStop;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingState = ref.watch(recordingNotifierProvider);
    final recordingNotifier = ref.read(recordingNotifierProvider.notifier);

    return Column(
      children: [
        if (recordingState.error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '錯誤: ${recordingState.error}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        const SizedBox(height: 16),
        Text(
          _formatDuration(recordingState.duration),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) async {
            // Hide keyboard when button is pressed
            FocusScope.of(context).unfocus();
            // Only start if not already recording
            if (!recordingState.isRecording) {
              await recordingNotifier.startRecording();
            }
          },
          onTapUp: (details) async {
            // Stop recording when button is released (only if actually recording)
            if (recordingState.isRecording) {
              final recording = await recordingNotifier.stopRecording();
              if (recording != null) {
                onStop(recording);
              }
            }
          },
          onTapCancel: () async {
            // Stop recording if tap is cancelled (only if actually recording)
            if (recordingState.isRecording) {
              await recordingNotifier.stopRecording();
            }
          },
          child: Container(
            height: 60,
            width: 100,
            alignment: Alignment.center,
            child: Icon(
              recordingState.isRecording ? Icons.mic : Icons.mic_none,
              size: 64,
              color: recordingState.isRecording
                  ? Colors.red
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
