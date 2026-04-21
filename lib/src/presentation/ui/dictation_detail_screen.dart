import 'package:flutter/material.dart';
import '../../application/providers.dart';
import '../../application/audio_player_notifier.dart'; // Direct import
import '../../domain/audio_player_state.dart'; // Direct import
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/dictation.dart';
import '../../domain/audio_service.dart';

class DictationDetailScreen extends ConsumerWidget {
  const DictationDetailScreen({required this.dictationId, super.key});
  final String dictationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dictationsAsync = ref.watch(dictationsNotifierProvider);
    final audioPlayerState = ref.watch(audioPlayerNotifierProvider);
    final audioPlayerNotifier = ref.read(audioPlayerNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('聽寫詳情')),
      body: SafeArea(
        child: dictationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('發生錯誤: $err')),
        data: (dictations) {
          final dictation = dictations.firstWhere(
            (d) => d.id == dictationId,
            orElse: () => Dictation(
              id: '',
              categoryName: '未找到',
              textbookName: '未找到',
              recordings: [],
              createdAt: DateTime.now(),
            ),
          );

          if (dictation.id.isEmpty) {
            return const Center(child: Text('找不到該聽寫紀錄。'));
          }

          final isPlayingThisDictation =
              audioPlayerState.currentDictationId == dictationId;
          final currentPlayingIndex = isPlayingThisDictation
              ? audioPlayerState.currentRecordingIndex
              : null;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dictation.textbookName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  dictation.categoryName,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: const Color(0xFFD8A9E8),
                  ),
                ),
                const SizedBox(height: 24),
                Text('錄音列表', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: dictation.recordings.length,
                    itemBuilder: (context, index) {
                      final recording = dictation.recordings[index];
                      final isCurrent = currentPlayingIndex == index;
                      final isPlaying = isCurrent &&
                          audioPlayerState.playerState == PlayerState.playing;
                      final isPaused = isCurrent &&
                          audioPlayerState.playerState == PlayerState.paused;

                      return ListTile(
                        leading: CircleAvatar(child: Text('${index + 1}')),
                        title: Text('錄音 ${index + 1}'),
                        subtitle: Text(
                          '長度: ${recording.durationSeconds} 秒${isCurrent ? (isPlaying ? ' (播放中)' : ' (已暫停)') : ''}',
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                          ),
                          onPressed: () {
                            if (isPlaying) {
                              audioPlayerNotifier.pause();
                            } else if (isPaused) {
                              audioPlayerNotifier.resume();
                            } else {
                              audioPlayerNotifier.playAllRecordings(
                                dictationId,
                                startIndex: index,
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildPlaybackControls(
                  context,
                  ref,
                  dictation,
                  audioPlayerState,
                  audioPlayerNotifier,
                  isPlayingThisDictation,
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    ),
    );
  }

  Widget _buildPlaybackControls(
    BuildContext context,
    WidgetRef ref,
    Dictation dictation,
    AudioPlayerState audioPlayerState,
    AudioPlayerNotifier audioPlayerNotifier,
    bool isPlayingThisDictation,
  ) {
    final isPlaying =
        audioPlayerState.playerState == PlayerState.playing && isPlayingThisDictation;
    final isPaused =
        audioPlayerState.playerState == PlayerState.paused && isPlayingThisDictation;
    final isStopped =
        audioPlayerState.playerState == PlayerState.stopped || !isPlayingThisDictation;

    IconData mainButtonIcon;
    if (isPlaying) {
      mainButtonIcon = Icons.pause_circle_filled;
    } else if (isPaused) {
      mainButtonIcon = Icons.play_circle_filled;
    } else {
      mainButtonIcon = Icons.play_arrow;
    }

    final int totalRecordings = dictation.recordings.length;
    final int currentDisplayIndex = (audioPlayerState.currentRecordingIndex ?? -1) + 1;

    return Column(
      children: [
        if (isPlayingThisDictation && audioPlayerState.currentRecordingIndex != null)
          Text(
            '目前播放: 錄音 $currentDisplayIndex / $totalRecordings',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 48,
              icon: const Icon(Icons.skip_previous),
              onPressed: (isStopped && !isPlayingThisDictation) || (audioPlayerState.currentRecordingIndex == 0)
                  ? null
                  : () {
                      if (isPlaying || isPaused) {
                        audioPlayerNotifier.playPrevious();
                      } else {
                        // If stopped, just navigate to the previous recording without playing
                        final newIndex = (audioPlayerState.currentRecordingIndex ?? 0) - 1;
                        audioPlayerNotifier.setCurrentRecording(dictationId, newIndex.clamp(0, totalRecordings - 1));
                      }
                    },
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              heroTag: 'main_playback_button',
              onPressed: () {
                if (isPlaying) {
                  audioPlayerNotifier.pause();
                } else if (isPaused) {
                  audioPlayerNotifier.resume();
                } else {
                  // If stopped, start from the beginning or current index if context exists
                  final startIndex = isPlayingThisDictation && audioPlayerState.currentRecordingIndex != null
                      ? audioPlayerState.currentRecordingIndex!
                      : 0;
                  audioPlayerNotifier.playAllRecordings(dictationId, startIndex: startIndex);
                }
              },
              child: Icon(mainButtonIcon, size: 48),
            ),
            const SizedBox(width: 16),
            IconButton(
              iconSize: 48,
              icon: const Icon(Icons.skip_next),
              onPressed: (isStopped && !isPlayingThisDictation) || (audioPlayerState.currentRecordingIndex == totalRecordings - 1)
                  ? null
                  : () {
                      if (isPlaying || isPaused) {
                        audioPlayerNotifier.playNext();
                      } else {
                        // If stopped, just navigate to the next recording without playing
                        final newIndex = (audioPlayerState.currentRecordingIndex ?? -1) + 1;
                        audioPlayerNotifier.setCurrentRecording(dictationId, newIndex.clamp(0, totalRecordings - 1));
                      }
                    },
            ),
          ],
        ),
      ],
    );
  }
}
