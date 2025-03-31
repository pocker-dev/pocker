import 'dart:convert';
import 'dart:io';

import 'model/machine_inspect.dart';

class MachineExecResult {
  int exitCode;
  String data;
  String error;

  MachineExecResult(
    this.exitCode,
    this.data,
    this.error,
  );
}

class Machine {
  static MachineInspect? inspect() {
    final result = _exec(
      arguments: [
        'machine',
        'inspect',
      ],
    );
    if (result.exitCode != 0) {
      return null;
    }
    //
    final list = json
        .decode(result.data)
        .map((json) => MachineInspect.fromJson(json))
        .toList();
    return list[0];
  }

  static bool start() {
    final result = _exec(
      arguments: [
        'machine',
        'start',
      ],
    );
    return result.exitCode == 0;
  }

  static bool stop() {
    final result = _exec(
      arguments: [
        'machine',
        'stop',
      ],
    );
    return result.exitCode == 0;
  }

  static bool restart() {
    final result = _exec(
      arguments: [
        'machine',
        'restart',
      ],
    );
    return result.exitCode == 0;
  }

  static bool delete() {
    final result = _exec(
      arguments: [
        'machine',
        'rm',
      ],
    );
    return result.exitCode == 0;
  }

  static MachineExecResult _exec({
    List<String> arguments = const [],
    Map<String, String>? environment,
  }) {
    ProcessResult result = Process.runSync(
      'podman',
      arguments,
      environment: environment,
    );
    //
    return MachineExecResult(result.exitCode, result.stdout, result.stderr);
  }
}
