// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.16.

// ignore_for_file: unused_import, unused_element, unnecessary_import, duplicate_ignore, invalid_use_of_internal_member, annotate_overrides, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'api/rust_x3dh_e2e.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ffi' as ffi;
import 'frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated_io.dart';

abstract class RustLibApiImplPlatform extends BaseApiImpl<RustLibWire> {
  RustLibApiImplPlatform({
    required super.handler,
    required super.wire,
    required super.generalizedFrbRustBinding,
    required super.portManager,
  });

  @protected
  String dco_decode_String(dynamic raw);

  @protected
  List<int> dco_decode_list_prim_u_8_loose(dynamic raw);

  @protected
  Uint8List dco_decode_list_prim_u_8_strict(dynamic raw);

  @protected
  (Uint8List, Uint8List)
      dco_decode_record_list_prim_u_8_strict_list_prim_u_8_strict(dynamic raw);

  @protected
  int dco_decode_u_8(dynamic raw);

  @protected
  void dco_decode_unit(dynamic raw);

  @protected
  String sse_decode_String(SseDeserializer deserializer);

  @protected
  List<int> sse_decode_list_prim_u_8_loose(SseDeserializer deserializer);

  @protected
  Uint8List sse_decode_list_prim_u_8_strict(SseDeserializer deserializer);

  @protected
  (Uint8List, Uint8List)
      sse_decode_record_list_prim_u_8_strict_list_prim_u_8_strict(
          SseDeserializer deserializer);

  @protected
  int sse_decode_u_8(SseDeserializer deserializer);

  @protected
  void sse_decode_unit(SseDeserializer deserializer);

  @protected
  int sse_decode_i_32(SseDeserializer deserializer);

  @protected
  bool sse_decode_bool(SseDeserializer deserializer);

  @protected
  ffi.Pointer<wire_cst_list_prim_u_8_strict> cst_encode_String(String raw) {
    return cst_encode_list_prim_u_8_strict(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<wire_cst_list_prim_u_8_loose> cst_encode_list_prim_u_8_loose(
      List<int> raw) {
    final ans = wire.cst_new_list_prim_u_8_loose(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }

  @protected
  ffi.Pointer<wire_cst_list_prim_u_8_strict> cst_encode_list_prim_u_8_strict(
      Uint8List raw) {
    final ans = wire.cst_new_list_prim_u_8_strict(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }

  @protected
  void cst_api_fill_to_wire_record_list_prim_u_8_strict_list_prim_u_8_strict(
      (Uint8List, Uint8List) apiObj,
      wire_cst_record_list_prim_u_8_strict_list_prim_u_8_strict wireObj) {
    wireObj.field0 = cst_encode_list_prim_u_8_strict(apiObj.$1);
    wireObj.field1 = cst_encode_list_prim_u_8_strict(apiObj.$2);
  }

  @protected
  int cst_encode_u_8(int raw);

  @protected
  void cst_encode_unit(void raw);

  @protected
  void sse_encode_String(String self, SseSerializer serializer);

  @protected
  void sse_encode_list_prim_u_8_loose(List<int> self, SseSerializer serializer);

  @protected
  void sse_encode_list_prim_u_8_strict(
      Uint8List self, SseSerializer serializer);

  @protected
  void sse_encode_record_list_prim_u_8_strict_list_prim_u_8_strict(
      (Uint8List, Uint8List) self, SseSerializer serializer);

  @protected
  void sse_encode_u_8(int self, SseSerializer serializer);

  @protected
  void sse_encode_unit(void self, SseSerializer serializer);

  @protected
  void sse_encode_i_32(int self, SseSerializer serializer);

  @protected
  void sse_encode_bool(bool self, SseSerializer serializer);
}

// Section: wire_class

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names
// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint

/// generated by flutter_rust_bridge
class RustLibWire implements BaseWire {
  factory RustLibWire.fromExternalLibrary(ExternalLibrary lib) =>
      RustLibWire(lib.ffiDynamicLibrary);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  RustLibWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  RustLibWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void dart_fn_deliver_output(
    int call_id,
    ffi.Pointer<ffi.Uint8> ptr_,
    int rust_vec_len_,
    int data_len_,
  ) {
    return _dart_fn_deliver_output(
      call_id,
      ptr_,
      rust_vec_len_,
      data_len_,
    );
  }

  late final _dart_fn_deliver_outputPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int32, ffi.Pointer<ffi.Uint8>, ffi.Int32,
              ffi.Int32)>>('frbgen_r2f_x3dh_e2e_dart_fn_deliver_output');
  late final _dart_fn_deliver_output = _dart_fn_deliver_outputPtr
      .asFunction<void Function(int, ffi.Pointer<ffi.Uint8>, int, int)>();

  WireSyncRust2DartDco wire_decrypt_with_bytes_key(
    ffi.Pointer<wire_cst_list_prim_u_8_loose> shared_secret_key,
    ffi.Pointer<wire_cst_list_prim_u_8_loose> ciphertext,
    ffi.Pointer<wire_cst_list_prim_u_8_loose> iv,
  ) {
    return _wire_decrypt_with_bytes_key(
      shared_secret_key,
      ciphertext,
      iv,
    );
  }

  late final _wire_decrypt_with_bytes_keyPtr = _lookup<
          ffi.NativeFunction<
              WireSyncRust2DartDco Function(
                  ffi.Pointer<wire_cst_list_prim_u_8_loose>,
                  ffi.Pointer<wire_cst_list_prim_u_8_loose>,
                  ffi.Pointer<wire_cst_list_prim_u_8_loose>)>>(
      'frbgen_r2f_x3dh_e2e_wire_decrypt_with_bytes_key');
  late final _wire_decrypt_with_bytes_key =
      _wire_decrypt_with_bytes_keyPtr.asFunction<
          WireSyncRust2DartDco Function(
              ffi.Pointer<wire_cst_list_prim_u_8_loose>,
              ffi.Pointer<wire_cst_list_prim_u_8_loose>,
              ffi.Pointer<wire_cst_list_prim_u_8_loose>)>();

  WireSyncRust2DartDco wire_decrypt_with_hex_string_key(
    ffi.Pointer<wire_cst_list_prim_u_8_strict> shared_secret_key,
    ffi.Pointer<wire_cst_list_prim_u_8_loose> ciphertext,
    ffi.Pointer<wire_cst_list_prim_u_8_loose> iv,
  ) {
    return _wire_decrypt_with_hex_string_key(
      shared_secret_key,
      ciphertext,
      iv,
    );
  }

  late final _wire_decrypt_with_hex_string_keyPtr = _lookup<
          ffi.NativeFunction<
              WireSyncRust2DartDco Function(
                  ffi.Pointer<wire_cst_list_prim_u_8_strict>,
                  ffi.Pointer<wire_cst_list_prim_u_8_loose>,
                  ffi.Pointer<wire_cst_list_prim_u_8_loose>)>>(
      'frbgen_r2f_x3dh_e2e_wire_decrypt_with_hex_string_key');
  late final _wire_decrypt_with_hex_string_key =
      _wire_decrypt_with_hex_string_keyPtr.asFunction<
          WireSyncRust2DartDco Function(
              ffi.Pointer<wire_cst_list_prim_u_8_strict>,
              ffi.Pointer<wire_cst_list_prim_u_8_loose>,
              ffi.Pointer<wire_cst_list_prim_u_8_loose>)>();

  WireSyncRust2DartDco wire_encrypt_with_bytes_key(
    ffi.Pointer<wire_cst_list_prim_u_8_loose> shared_secret_key,
    ffi.Pointer<wire_cst_list_prim_u_8_strict> plaintext,
  ) {
    return _wire_encrypt_with_bytes_key(
      shared_secret_key,
      plaintext,
    );
  }

  late final _wire_encrypt_with_bytes_keyPtr = _lookup<
          ffi.NativeFunction<
              WireSyncRust2DartDco Function(
                  ffi.Pointer<wire_cst_list_prim_u_8_loose>,
                  ffi.Pointer<wire_cst_list_prim_u_8_strict>)>>(
      'frbgen_r2f_x3dh_e2e_wire_encrypt_with_bytes_key');
  late final _wire_encrypt_with_bytes_key =
      _wire_encrypt_with_bytes_keyPtr.asFunction<
          WireSyncRust2DartDco Function(
              ffi.Pointer<wire_cst_list_prim_u_8_loose>,
              ffi.Pointer<wire_cst_list_prim_u_8_strict>)>();

  WireSyncRust2DartDco wire_encrypt_with_hex_string_key(
    ffi.Pointer<wire_cst_list_prim_u_8_strict> shared_secret_key,
    ffi.Pointer<wire_cst_list_prim_u_8_strict> plaintext,
  ) {
    return _wire_encrypt_with_hex_string_key(
      shared_secret_key,
      plaintext,
    );
  }

  late final _wire_encrypt_with_hex_string_keyPtr = _lookup<
          ffi.NativeFunction<
              WireSyncRust2DartDco Function(
                  ffi.Pointer<wire_cst_list_prim_u_8_strict>,
                  ffi.Pointer<wire_cst_list_prim_u_8_strict>)>>(
      'frbgen_r2f_x3dh_e2e_wire_encrypt_with_hex_string_key');
  late final _wire_encrypt_with_hex_string_key =
      _wire_encrypt_with_hex_string_keyPtr.asFunction<
          WireSyncRust2DartDco Function(
              ffi.Pointer<wire_cst_list_prim_u_8_strict>,
              ffi.Pointer<wire_cst_list_prim_u_8_strict>)>();

  void wire_init_app(
    int port_,
  ) {
    return _wire_init_app(
      port_,
    );
  }

  late final _wire_init_appPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'frbgen_r2f_x3dh_e2e_wire_init_app');
  late final _wire_init_app =
      _wire_init_appPtr.asFunction<void Function(int)>();

  ffi.Pointer<wire_cst_list_prim_u_8_loose> cst_new_list_prim_u_8_loose(
    int len,
  ) {
    return _cst_new_list_prim_u_8_loose(
      len,
    );
  }

  late final _cst_new_list_prim_u_8_loosePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_cst_list_prim_u_8_loose> Function(
              ffi.Int32)>>('frbgen_r2f_x3dh_e2e_cst_new_list_prim_u_8_loose');
  late final _cst_new_list_prim_u_8_loose = _cst_new_list_prim_u_8_loosePtr
      .asFunction<ffi.Pointer<wire_cst_list_prim_u_8_loose> Function(int)>();

  ffi.Pointer<wire_cst_list_prim_u_8_strict> cst_new_list_prim_u_8_strict(
    int len,
  ) {
    return _cst_new_list_prim_u_8_strict(
      len,
    );
  }

  late final _cst_new_list_prim_u_8_strictPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_cst_list_prim_u_8_strict> Function(
              ffi.Int32)>>('frbgen_r2f_x3dh_e2e_cst_new_list_prim_u_8_strict');
  late final _cst_new_list_prim_u_8_strict = _cst_new_list_prim_u_8_strictPtr
      .asFunction<ffi.Pointer<wire_cst_list_prim_u_8_strict> Function(int)>();

  int dummy_method_to_enforce_bundling() {
    return _dummy_method_to_enforce_bundling();
  }

  late final _dummy_method_to_enforce_bundlingPtr =
      _lookup<ffi.NativeFunction<ffi.Int64 Function()>>(
          'dummy_method_to_enforce_bundling');
  late final _dummy_method_to_enforce_bundling =
      _dummy_method_to_enforce_bundlingPtr.asFunction<int Function()>();
}

final class wire_cst_list_prim_u_8_loose extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_cst_list_prim_u_8_strict extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_cst_record_list_prim_u_8_strict_list_prim_u_8_strict
    extends ffi.Struct {
  external ffi.Pointer<wire_cst_list_prim_u_8_strict> field0;

  external ffi.Pointer<wire_cst_list_prim_u_8_strict> field1;
}
