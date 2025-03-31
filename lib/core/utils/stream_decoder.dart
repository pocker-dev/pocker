import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

class StreamDecoder {
  static List<String> toLines(List<int> stream) {
    return utf8.decode(stream).split('\n');
  }

  static Future<List<int>> toLogs(
    List<int> stream,
    Function(List<String>) onLines,
  ) async {
    int index = 0;
    final lines = <String>[];
    //
    while (index < stream.length) {
      final data = stream.sublist(index);
      if (data.length < 8) {
        break;
      }
      //
      final buffer = Uint8List.fromList(data);
      final fd = buffer[0];
      if (fd < 0 || fd > 3) {
        throw FormatException('Invalid channel "$fd", expected 0-3');
      }
      //
      final size = ByteData.sublistView(buffer, 4, 8).getUint32(0, Endian.big);
      if (data.length < size) {
        break;
      }
      lines.add(utf8.decode(buffer.sublist(8, size + 8)));
      index += size + 8;
    }
    if (lines.isNotEmpty) {
      onLines(lines);
    }
    return stream.sublist(index);
  }
}
