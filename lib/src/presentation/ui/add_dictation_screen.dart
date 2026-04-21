import 'package:flutter/material.dart';
import 'dart:async';
import './widgets/recording_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../application/providers.dart';
import '../../domain/dictation.dart';
import '../../domain/recording.dart';
import '../../domain/audio_service.dart';

class AddDictationScreen extends ConsumerStatefulWidget {
  const AddDictationScreen({super.key, this.dictationId});

  final String? dictationId;

  @override
  ConsumerState<AddDictationScreen> createState() => _AddDictationScreenState();
}

class _AddDictationScreenState extends ConsumerState<AddDictationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textbookNameController = TextEditingController();
  final _categoryNameController = TextEditingController();
  final List<Recording> _recordings = [];
  final _recordingsScrollController = ScrollController();
  late String _dictationId;
  late DateTime _originalCreatedAt;
  bool _isEditMode = false;
  late String _originalTextbookName;
  late String _originalCategoryName;
  late List<Recording> _originalRecordings;
  Set<String> _textbookNames = {};
  Set<String> _categoryNames = {};
  int? _currentPlayingIndex;
  bool _isPlaying = false;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<Duration?>? _playbackPositionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.dictationId != null;
    _dictationId = widget.dictationId ?? const Uuid().v4();
    _originalCreatedAt = DateTime.now();
    _originalTextbookName = '';
    _originalCategoryName = '';
    _originalRecordings = [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDictationList();
      if (_isEditMode) {
        _loadDictation();
      }
    });
  }

  @override
  void dispose() {
    // Clean up subscriptions and resources
    _playerStateSubscription?.cancel();
    _playbackPositionSubscription?.cancel();
    _durationSubscription?.cancel();
    _recordingsScrollController.dispose();
    super.dispose();
  }

  Future<void> _loadDictationList() async {
    try {
      final dictations = await ref.read(dictationsNotifierProvider.future);
      setState(() {
        _textbookNames = dictations.map((d) => d.textbookName).toSet();
        _categoryNames = dictations.map((d) => d.categoryName).toSet();
      });
    } catch (_) {}
  }

  Future<void> _loadDictation() async {
    try {
      final dictations = await ref.read(dictationsNotifierProvider.future);
      final dictation = dictations.firstWhere((d) => d.id == _dictationId);

      _textbookNameController.text = dictation.textbookName;
      _categoryNameController.text = dictation.categoryName;
      _originalCreatedAt = dictation.createdAt;

      if (mounted) {
        setState(() {
          _recordings.clear();
          _recordings.addAll(dictation.recordings);
          _originalTextbookName = dictation.textbookName;
          _originalCategoryName = dictation.categoryName;
          _originalRecordings = List.from(dictation.recordings);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('加載聽寫失敗: $e')));
      }
    }
  }

  bool _hasChanges() {
    if (_isEditMode) {
      // 編輯模式：檢查是否有任何改變
      return _textbookNameController.text != _originalTextbookName ||
          _categoryNameController.text != _originalCategoryName ||
          _recordings.length != _originalRecordings.length ||
          !_listsEqual(_recordings, _originalRecordings);
    } else {
      // 新建模式：檢查是否有任何內容被填寫
      return _textbookNameController.text.isNotEmpty ||
          _categoryNameController.text.isNotEmpty ||
          _recordings.isNotEmpty;
    }
  }

  bool _isCombinationDuplicate() {
    final currentCombination =
        '${_textbookNameController.text}_${_categoryNameController.text}';

    try {
      final dictationsAsync = ref.read(dictationsNotifierProvider);
      return dictationsAsync.when(
        loading: () => false,
        error: (_, _) => false,
        data: (dictations) {
          for (final dictation in dictations) {
            final combination =
                '${dictation.textbookName}_${dictation.categoryName}';
            if (_isEditMode && dictation.id == _dictationId) {
              continue;
            }
            if (combination == currentCombination) {
              return true;
            }
          }
          return false;
        },
      );
    } catch (_) {
      return false;
    }
  }

  bool _listsEqual(List<Recording> list1, List<Recording> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].filePath != list2[i].filePath ||
          list1[i].durationSeconds != list2[i].durationSeconds ||
          list1[i].name != list2[i].name) {
        return false;
      }
    }
    return true;
  }

  Future<bool> _confirmDiscard() async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('放棄修改？'),
              content: const Text('內容未保存'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('取消'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('放棄'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> _validateForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('請先輸入課本名稱及類別')));
      }
    }
    return isValid;
  }

  Future<void> _submit() async {
    if (await _validateForm()) {
      if (_recordings.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('請至少錄製一個音檔')));
        }
        return;
      }

      // 檢查組合是否重複
      if (_isCombinationDuplicate()) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('此課本名稱及類別組合已存在')));
        }
        return;
      }

      final dictation = Dictation(
        id: _dictationId,
        textbookName: _textbookNameController.text,
        categoryName: _categoryNameController.text,
        recordings: _recordings,
        createdAt: _originalCreatedAt,
      );

      if (_isEditMode) {
        await ref
            .read(dictationsNotifierProvider.notifier)
            .updateDictation(dictation);
      } else {
        await ref
            .read(dictationsNotifierProvider.notifier)
            .addDictation(dictation);
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _onRecordingStopped(Recording recording) {
    setState(() {
      _recordings.add(recording);
    });
    
    // Scroll to the bottom to show the newly added recording
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_recordingsScrollController.hasClients) {
        _recordingsScrollController.animateTo(
          _recordingsScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showTextbookSuggestions() {
    if (_textbookNames.isEmpty) return;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: _textbookNames.map((String textbook) {
            return ListTile(
              title: Text(textbook),
              onTap: () {
                setState(() {
                  _textbookNameController.text = textbook;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showCategorySuggestions() {
    if (_categoryNames.isEmpty) return;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: _categoryNames.map((String category) {
            return ListTile(
              title: Text(category),
              onTap: () {
                setState(() {
                  _categoryNameController.text = category;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Future<void> _playRecording(int index) async {
    final audioService = ref.read(audioServiceProvider);
    try {
      setState(() {
        _currentPlayingIndex = index;
        _isPlaying = true;
      });
      
      // Cancel previous subscriptions
      await _playerStateSubscription?.cancel();
      await _playbackPositionSubscription?.cancel();
      await _durationSubscription?.cancel();
      
      // Set up listener for player state changes
      _playerStateSubscription = audioService.playerStateStream.listen(
        (playerState) {
          if (mounted) {
            if (playerState == PlayerState.playing) {
              // Ensure UI shows playing state
              setState(() {
                _currentPlayingIndex = index;
                _isPlaying = true;
              });
            } else if (playerState == PlayerState.paused) {
              // Show paused state but keep the current index
              setState(() {
                _isPlaying = false;
              });
            } else if (playerState == PlayerState.completed || 
                       playerState == PlayerState.stopped) {
              // Reset UI when playback completes or stops
              setState(() {
                _isPlaying = false;
                _currentPlayingIndex = null;
              });
            }
          }
        },
      );
      
      // Start playback
      await audioService.playRecording(_recordings[index].filePath);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('播放失敗: $e')),
        );
      }
      setState(() {
        _isPlaying = false;
        _currentPlayingIndex = null;
      });
    }
  }

  Future<void> _stopPlayback() async {
    final audioService = ref.read(audioServiceProvider);
    try {
      await audioService.stopPlayback();
      setState(() {
        _isPlaying = false;
        _currentPlayingIndex = null;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('停止播放失敗: $e')),
        );
      }
    }
  }

  Future<void> _editRecordingName(int index) async {
    final recording = _recordings[index];
    final nameController = TextEditingController(
      text: recording.name ?? '錄音 ${index + 1}',
    );
    
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('編輯錄音名稱'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: '輸入錄音名稱',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _recordings[index] = _recordings[index].copyWith(
                    name: nameController.text.isNotEmpty 
                        ? nameController.text 
                        : '錄音 ${index + 1}',
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('確定'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Reset recording state when entering screen
    ref.invalidate(recordingNotifierProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }

        if (!_hasChanges()) {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        } else {
          if (context.mounted) {
            final confirm = await _confirmDiscard();
            if (confirm && context.mounted) {
              Navigator.of(context).pop();
            }
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditMode ? '編輯聽寫' : '新增聽寫'),
          actions: [
            IconButton(icon: const Icon(Icons.save), onPressed: _submit),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _textbookNameController,
                        decoration: InputDecoration(
                          labelText: '課本名稱',
                          hintText: '輸入或選擇課本名稱',
                          suffixIcon: _textbookNames.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onPressed: _showTextbookSuggestions,
                                )
                              : null,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '請輸入課本名稱';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _categoryNameController,
                        decoration: InputDecoration(
                          labelText: '類別',
                          hintText: '輸入或選擇類別',
                          suffixIcon: _categoryNames.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onPressed: _showCategorySuggestions,
                                )
                              : null,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '請輸入類別';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 300,
                  ),
                  child: _recordings.isEmpty
                      ? const Center(child: Text('暫無錄音'))
                      : ReorderableListView(
                          scrollController: _recordingsScrollController,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              final Recording item = _recordings.removeAt(
                                oldIndex,
                              );
                              _recordings.insert(newIndex, item);
                            });
                          },
                          children: [
                            for (
                              int index = 0;
                              index < _recordings.length;
                              index++
                            )
                              ListTile(
                                key: ValueKey(_recordings[index]),
                                leading: CircleAvatar(
                                  backgroundColor: const Color.fromARGB(255, 210, 117, 226),
                                  foregroundColor: Colors.white,
                                  child: Text('${index + 1}'),
                                ),
                                title: GestureDetector(
                                  onTap: () => _editRecordingName(index),
                                  child: Text(
                                    _recordings[index].name ?? '錄音 ${index + 1}',
                                    style: TextStyle(
                                      color: Colors.purple.shade300,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  '長度: ${_recordings[index].durationSeconds} 秒',
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          (_currentPlayingIndex == index && _isPlaying)
                                              ? Icons.pause_circle
                                              : Icons.play_arrow,
                                        ),
                                        onPressed: () {
                                          if (_currentPlayingIndex == index && _isPlaying) {
                                            _stopPlayback();
                                          } else {
                                            _playRecording(index);
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            _recordings.removeAt(index);
                                          });
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '已刪除錄音 ${index + 1}',
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                ),
                const Divider(height: 10),
                RecordingWidget(onStop: _onRecordingStopped),
                const SizedBox(height: 16),
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}
