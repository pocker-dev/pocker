import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:highlight/languages/shell.dart' as highlight_shell;
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/directory_select_form_field.dart';
import 'package:pocker/core/widgets/file_select_form_field.dart';
import 'package:pocker/core/widgets/highlight.dart';
import 'package:pocker/core/widgets/key_values_form_field.dart';
import 'package:pocker/core/widgets/operate_page_layout.dart';
import 'package:pocker/core/widgets/text_edit_form_field.dart';
import 'package:pocker/services/podman.dart';

class ImageBuildPage extends StatefulWidget {
  const ImageBuildPage({super.key});

  @override
  State<ImageBuildPage> createState() => _ImageBuildPageState();
}

class _ImageBuildPageState extends State<ImageBuildPage> {
  final _formKey = GlobalKey<FormState>();
  final _progressList = <String>[];

  String? _containerfile;
  String? _directory;
  String? _name;
  List<KeyValuePair>? _arguments;
  // Architecture? _arch;

  /// Build status
  ///
  /// 0: pending
  /// 1: ready
  /// 2: building
  /// 4: complete
  int _status = 0;

  Future<List<int>> _createContextTar(String? externalDockerfile) async {
    final archive = Archive();
    await for (var entity in Directory(_directory!).list(recursive: true)) {
      if (entity is File) {
        final relativePath = entity.path.substring(_directory!.length + 1);
        final fileBytes = await entity.readAsBytes();
        archive.addFile(ArchiveFile(relativePath, fileBytes.length, fileBytes));
      }
    }
    if (externalDockerfile != null) {
      final fileBytes = await File(externalDockerfile).readAsBytes();
      archive.addFile(ArchiveFile('Dockerfile', fileBytes.length, fileBytes));
    }
    return TarEncoder().encode(archive);
  }

  void _buildImage() async {
    setState(() {
      _progressList.clear();
      _progressList
          .add('image_build_progress_uploading'.tr(args: [_directory ?? '']));
    });
    //
    String? dockerfile;
    if (_containerfile!.startsWith('$_directory/')) {
      dockerfile = _containerfile!.substring(_directory!.length + 1);
    }
    final tar =
        await _createContextTar(dockerfile == null ? _containerfile : null);
    setState(() {
      _progressList
          .add('image_build_progress_building'.tr(args: [_name ?? '']));
    });
    //
    final podman = await Podman.getInstance();
    if (podman != null) {
      await podman.image.buildImage(
        dockerfile: dockerfile ?? 'Dockerfile',
        contextTar: tar,
        t: _name!,
        buildArgs: Map.fromEntries(
            _arguments?.map((kv) => MapEntry(kv.key, kv.value)) ?? []),
        onData: (list) {
          _progressList.addAll(
              list.map((progress) => progress.error ?? progress.stream ?? ''));
        },
        onFinished: () {
          setState(() {
            _status = 4;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OperatePageLayout(
      breadcrumbs: [
        BreadcrumbInfo(name: 'images_title'.tr(), link: ''),
        BreadcrumbInfo(name: 'image_build_title'.tr()),
      ],
      icon: Icon(Symbols.deployed_code_update, size: 30.0),
      title: 'image_build_subtitle'.tr(),
      showProgress: _status == 2,
      content: Column(
        spacing: 20.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: _formKey,
            child: Column(
              spacing: 20.0,
              children: [
                FileSelectFormField(
                  label: 'image_build_containerfile_label'.tr(),
                  hint: 'image_build_containerfile_hint'.tr(),
                  submitting: _status == 2,
                  onChanged: (value) {
                    if (value.isNotEmpty && _status == 0) {
                      setState(() {
                        _status = 1;
                      });
                    } else if (value.isEmpty && _status == 1) {
                      setState(() {
                        _status = 0;
                      });
                    }
                    if (_directory == null) {
                      setState(() {
                        _directory = File(value).parent.path;
                      });
                    }
                  },
                  onSaved: (value) {
                    _containerfile = value;
                  },
                ),
                DirectorySelectFormField(
                  label: 'image_build_directory_label'.tr(),
                  hint: 'image_build_directory_hint'.tr(),
                  initValue: _directory,
                  submitting: _status == 2,
                  onSaved: (value) {
                    _directory = value;
                  },
                ),
                TextEditFormField(
                  label: 'image_name_label'.tr(),
                  hint: 'image_name_title'.tr(),
                  submitting: _status == 2,
                  onSaved: (value) {
                    _name = value;
                  },
                ),
                KeyValuesFormField(
                  label: 'argument_build_image_label'.tr(),
                  keyHint: 'argument_key_hint'.tr(),
                  valueHint: 'argument_value_hint'.tr(),
                  submitting: _status == 2,
                ),
              ],
            ),
          ),
          if (_status == 4)
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('done'.tr()),
            )
          else
            FilledButton.icon(
              onPressed: _status == 0 || _status == 2
                  ? null
                  : () {
                      if (_formKey.currentState?.validate() == true) {
                        _formKey.currentState?.save();
                        setState(() {
                          _status = 2;
                        });
                        _buildImage();
                      }
                    },
              icon: _status == 2
                  ? SizedBox(
                      width: 15.0,
                      height: 15.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    )
                  : Icon(Symbols.deployed_code_update, fill: 1),
              label: Text('image_build_label'.tr()),
            ),
          Highlight(
            language: highlight_shell.shell,
            text: _progressList.join(''),
          ),
        ],
      ),
    );
  }
}
