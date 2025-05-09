// RUN: mlir-opt -allow-unregistered-dialect %s -split-input-file | mlir-opt -allow-unregistered-dialect | FileCheck %s

// CHECK-LABEL: @primitive
func.func @primitive() {
  // CHECK: !llvm.void
  "some.op"() : () -> !llvm.void
  // CHECK: !llvm.ppc_fp128
  "some.op"() : () -> !llvm.ppc_fp128
  // CHECK: !llvm.token
  "some.op"() : () -> !llvm.token
  // CHECK: !llvm.label
  "some.op"() : () -> !llvm.label
  // CHECK: !llvm.metadata
  "some.op"() : () -> !llvm.metadata
  return
}

// CHECK-LABEL: @func
func.func @func() {
  // CHECK: !llvm.func<void ()>
  "some.op"() : () -> !llvm.func<void ()>
  // CHECK: !llvm.func<void (i32)>
  "some.op"() : () -> !llvm.func<void (i32)>
  // CHECK: !llvm.func<i32 ()>
  "some.op"() : () -> !llvm.func<i32 ()>
  // CHECK: !llvm.func<i32 (f16, bf16, f32, f64)>
  "some.op"() : () -> !llvm.func<i32 (f16, bf16, f32, f64)>
  // CHECK: !llvm.func<i32 (i32, i32)>
  "some.op"() : () -> !llvm.func<i32 (i32, i32)>
  // CHECK: !llvm.func<void (...)>
  "some.op"() : () -> !llvm.func<void (...)>
  // CHECK: !llvm.func<void (i32, i32, ...)>
  "some.op"() : () -> !llvm.func<void (i32, i32, ...)>
  return
}

// CHECK-LABEL: @integer
func.func @integer() {
  // CHECK: i1
  "some.op"() : () -> i1
  // CHECK: i8
  "some.op"() : () -> i8
  // CHECK: i16
  "some.op"() : () -> i16
  // CHECK: i32
  "some.op"() : () -> i32
  // CHECK: i64
  "some.op"() : () -> i64
  // CHECK: i57
  "some.op"() : () -> i57
  // CHECK: i129
  "some.op"() : () -> i129
  return
}

// CHECK-LABEL: @ptr
func.func @ptr() {
  // CHECK: !llvm.ptr
  "some.op"() : () -> !llvm.ptr
  // CHECK: !llvm.ptr
  "some.op"() : () -> !llvm.ptr<0>
  // CHECK: !llvm.ptr<42>
  "some.op"() : () -> !llvm.ptr<42>
  // CHECK: !llvm.ptr<9>
  "some.op"() : () -> !llvm.ptr<9>
  return
}

// CHECK-LABEL: @vec
func.func @vec() {
  // CHECK: vector<4xi32>
  "some.op"() : () -> vector<4xi32>
  // CHECK: vector<4xf32>
  "some.op"() : () -> vector<4xf32>
  // CHECK: vector<[4]xi32>
  "some.op"() : () -> vector<[4] x i32>
  // CHECK: vector<[8]xf16>
  "some.op"() : () -> vector<[8] x f16>
  // CHECK: vector<4x!llvm.ptr>
  "some.op"() : () -> vector<4x!llvm.ptr>
  // CHECK: vector<4x!llvm.ppc_fp128>
  "some.op"() : () -> vector<4x!llvm.ppc_fp128>
  return
}

// CHECK-LABEL: @array
func.func @array() {
  // CHECK: !llvm.array<10 x i32>
  "some.op"() : () -> !llvm.array<10 x i32>
  // CHECK: !llvm.array<8 x f32>
  "some.op"() : () -> !llvm.array<8 x f32>
  // CHECK: !llvm.array<10 x ptr<4>>
  "some.op"() : () -> !llvm.array<10 x ptr<4>>
  // CHECK: !llvm.array<10 x array<4 x f32>>
  "some.op"() : () -> !llvm.array<10 x array<4 x f32>>
  // CHECK: !llvm.array<10 x array<4 x vector<8xf32>>>
  "some.op"() : () -> !llvm.array<10 x array<4 x vector<8xf32>>>
  // CHECK: !llvm.array<10 x array<4 x vector<[8]xf32>>>
  "some.op"() : () -> !llvm.array<10 x array<4 x vector<[8]xf32>>>
  return
}

// CHECK-LABEL: @literal_struct
func.func @literal_struct() {
  // CHECK: !llvm.struct<()>
  "some.op"() : () -> !llvm.struct<()>
  // CHECK: !llvm.struct<(i32)>
  "some.op"() : () -> !llvm.struct<(i32)>
  // CHECK: !llvm.struct<(f32, i32)>
  "some.op"() : () -> !llvm.struct<(f32, i32)>
  // CHECK: !llvm.struct<(struct<(i32)>)>
  "some.op"() : () -> !llvm.struct<(struct<(i32)>)>
  // CHECK: !llvm.struct<(i32, struct<(i32)>, f32)>
  "some.op"() : () -> !llvm.struct<(i32, struct<(i32)>, f32)>

  // CHECK: !llvm.struct<packed ()>
  "some.op"() : () -> !llvm.struct<packed ()>
  // CHECK: !llvm.struct<packed (i32)>
  "some.op"() : () -> !llvm.struct<packed (i32)>
  // CHECK: !llvm.struct<packed (f32, i32)>
  "some.op"() : () -> !llvm.struct<packed (f32, i32)>
  // CHECK: !llvm.struct<packed (f32, i32)>
  "some.op"() : () -> !llvm.struct<packed (f32, i32)>
  // CHECK: !llvm.struct<packed (struct<(i32)>)>
  "some.op"() : () -> !llvm.struct<packed (struct<(i32)>)>
  // CHECK: !llvm.struct<packed (i32, struct<(i32, i1)>, f32)>
  "some.op"() : () -> !llvm.struct<packed (i32, struct<(i32, i1)>, f32)>

  // CHECK: !llvm.struct<(struct<packed (i32)>)>
  "some.op"() : () -> !llvm.struct<(struct<packed (i32)>)>
  // CHECK: !llvm.struct<packed (struct<(i32)>)>
  "some.op"() : () -> !llvm.struct<packed (struct<(i32)>)>
  return
}

// CHECK-LABEL: @identified_struct
func.func @identified_struct() {
  // CHECK: !llvm.struct<"empty", ()>
  "some.op"() : () -> !llvm.struct<"empty", ()>
  // CHECK: !llvm.struct<"opaque", opaque>
  "some.op"() : () -> !llvm.struct<"opaque", opaque>
  // CHECK: !llvm.struct<"long", (i32, struct<(i32, i1)>, f32, ptr)>
  "some.op"() : () -> !llvm.struct<"long", (i32, struct<(i32, i1)>, f32, ptr)>
  // CHECK: !llvm.struct<"unpacked", (i32)>
  "some.op"() : () -> !llvm.struct<"unpacked", (i32)>
  // CHECK: !llvm.struct<"packed", packed (i32)>
  "some.op"() : () -> !llvm.struct<"packed", packed (i32)>
  // CHECK: !llvm.struct<"name with spaces and !^$@$#", packed (i32)>
  "some.op"() : () -> !llvm.struct<"name with spaces and !^$@$#", packed (i32)>
  // CHECK: !llvm.struct<"outer", (struct<"nested", ()>)>
  "some.op"() : () -> !llvm.struct<"outer", (struct<"nested", ()>)>
  // CHECK: !llvm.struct<"referring-another", (ptr)>
  "some.op"() : () -> !llvm.struct<"referring-another", (ptr)>
  // CHECK: !llvm.struct<"struct-of-arrays", (array<10 x i32>)>
  "some.op"() : () -> !llvm.struct<"struct-of-arrays", (array<10 x i32>)>
  // CHECK: !llvm.array<10 x struct<"array-of-structs", (i32)>>
  "some.op"() : () -> !llvm.array<10 x struct<"array-of-structs", (i32)>>
  return
}

func.func @verbose() {
  // CHECK: !llvm.struct<(i64, struct<(f32)>)>
  "some.op"() : () -> !llvm.struct<(i64, !llvm.struct<(f32)>)>
  return
}

// -----

// Check that type aliases can be used inside LLVM dialect types. Note that
// currently they are _not_ printed back as this would require
// DialectAsmPrinter to have a mechanism for querying the presence and
// usability of an alias outside of its `printType` method.

!baz = i64
!qux = !llvm.struct<(!baz)>

// CHECK: aliases
llvm.func @aliases() {
  // CHECK: !llvm.struct<(i32, f32, struct<(i64)>)>
  "some.op"() : () -> !llvm.struct<(i32, f32, !qux)>
  llvm.return
}

// -----

// CHECK-LABEL: ext_target
llvm.func @ext_target() {
    // CHECK: !llvm.target<"target1", i32, 1>
    %0 = "some.op"() : () -> !llvm.target<"target1", i32, 1>
    // CHECK: !llvm.target<"target2">
    %1 = "some.op"() : () -> !llvm.target<"target2">
    // CHECK: !llvm.target<"target3", i32, i64, f64>
    %2 = "some.op"() : () -> !llvm.target<"target3", i32, i64, f64>
    // CHECK: !llvm.target<"target4", 1, 0, 42>
    %3 = "some.op"() : () -> !llvm.target<"target4", 1, 0, 42>
    // CHECK: !llvm.target<"target5", i32, f64, 0, 5>
    %4 = "some.op"() : () -> !llvm.target<"target5", i32, f64, 0, 5>
    llvm.return
}
