; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -O0 -mtriple=aarch64-linux-gnu -global-isel -stop-after=irtranslator %s -o - | FileCheck %s

define { half, half } @test_sincos_f16(half %a) {
  ; CHECK-LABEL: name: test_sincos_f16
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $h0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s16) = COPY $h0
  ; CHECK-NEXT:   [[FSINCOS:%[0-9]+]]:_(s16), [[FSINCOS1:%[0-9]+]]:_ = G_FSINCOS [[COPY]]
  ; CHECK-NEXT:   $h0 = COPY [[FSINCOS]](s16)
  ; CHECK-NEXT:   $h1 = COPY [[FSINCOS1]](s16)
  ; CHECK-NEXT:   RET_ReallyLR implicit $h0, implicit $h1
  %result = call { half, half } @llvm.sincos.f16(half %a)
  ret { half, half } %result
}

define { <2 x half>, <2 x half> } @test_sincos_v2f16(<2 x half> %a) {
  ; CHECK-LABEL: name: test_sincos_v2f16
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $d0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<4 x s16>) = COPY $d0
  ; CHECK-NEXT:   [[UV:%[0-9]+]]:_(<2 x s16>), [[UV1:%[0-9]+]]:_(<2 x s16>) = G_UNMERGE_VALUES [[COPY]](<4 x s16>)
  ; CHECK-NEXT:   [[FSINCOS:%[0-9]+]]:_(<2 x s16>), [[FSINCOS1:%[0-9]+]]:_ = G_FSINCOS [[UV]]
  ; CHECK-NEXT:   [[UV2:%[0-9]+]]:_(s16), [[UV3:%[0-9]+]]:_(s16) = G_UNMERGE_VALUES [[FSINCOS]](<2 x s16>)
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:_(s16) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<4 x s16>) = G_BUILD_VECTOR [[UV2]](s16), [[UV3]](s16), [[DEF]](s16), [[DEF]](s16)
  ; CHECK-NEXT:   [[UV4:%[0-9]+]]:_(s16), [[UV5:%[0-9]+]]:_(s16) = G_UNMERGE_VALUES [[FSINCOS1]](<2 x s16>)
  ; CHECK-NEXT:   [[BUILD_VECTOR1:%[0-9]+]]:_(<4 x s16>) = G_BUILD_VECTOR [[UV4]](s16), [[UV5]](s16), [[DEF]](s16), [[DEF]](s16)
  ; CHECK-NEXT:   $d0 = COPY [[BUILD_VECTOR]](<4 x s16>)
  ; CHECK-NEXT:   $d1 = COPY [[BUILD_VECTOR1]](<4 x s16>)
  ; CHECK-NEXT:   RET_ReallyLR implicit $d0, implicit $d1
  %result = call { <2 x half>, <2 x half> } @llvm.sincos.v2f16(<2 x half> %a)
  ret { <2 x half>, <2 x half> } %result
}

define { float, float } @test_sincos_f32(float %a) {
  ; CHECK-LABEL: name: test_sincos_f32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $s0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $s0
  ; CHECK-NEXT:   [[FSINCOS:%[0-9]+]]:_(s32), [[FSINCOS1:%[0-9]+]]:_ = G_FSINCOS [[COPY]]
  ; CHECK-NEXT:   $s0 = COPY [[FSINCOS]](s32)
  ; CHECK-NEXT:   $s1 = COPY [[FSINCOS1]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $s0, implicit $s1
  %result = call { float, float } @llvm.sincos.f32(float %a)
  ret { float, float } %result
}

define { <2 x float>, <2 x float> } @test_sincos_v2f32(<2 x float> %a) {
  ; CHECK-LABEL: name: test_sincos_v2f32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $d0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<2 x s32>) = COPY $d0
  ; CHECK-NEXT:   [[FSINCOS:%[0-9]+]]:_(<2 x s32>), [[FSINCOS1:%[0-9]+]]:_ = G_FSINCOS [[COPY]]
  ; CHECK-NEXT:   $d0 = COPY [[FSINCOS]](<2 x s32>)
  ; CHECK-NEXT:   $d1 = COPY [[FSINCOS1]](<2 x s32>)
  ; CHECK-NEXT:   RET_ReallyLR implicit $d0, implicit $d1
  %result = call { <2 x float>, <2 x float> } @llvm.sincos.v2f32(<2 x float> %a)
  ret { <2 x float>, <2 x float> } %result
}

define { double, double } @test_sincos_f64(double %a) {
  ; CHECK-LABEL: name: test_sincos_f64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $d0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $d0
  ; CHECK-NEXT:   [[FSINCOS:%[0-9]+]]:_(s64), [[FSINCOS1:%[0-9]+]]:_ = G_FSINCOS [[COPY]]
  ; CHECK-NEXT:   $d0 = COPY [[FSINCOS]](s64)
  ; CHECK-NEXT:   $d1 = COPY [[FSINCOS1]](s64)
  ; CHECK-NEXT:   RET_ReallyLR implicit $d0, implicit $d1
  %result = call { double, double } @llvm.sincos.f64(double %a)
  ret { double, double } %result
}

define { <2 x double>, <2 x double> } @test_sincos_v2f64(<2 x double> %a) {
  ; CHECK-LABEL: name: test_sincos_v2f64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $q0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(<2 x s64>) = COPY $q0
  ; CHECK-NEXT:   [[FSINCOS:%[0-9]+]]:_(<2 x s64>), [[FSINCOS1:%[0-9]+]]:_ = G_FSINCOS [[COPY]]
  ; CHECK-NEXT:   $q0 = COPY [[FSINCOS]](<2 x s64>)
  ; CHECK-NEXT:   $q1 = COPY [[FSINCOS1]](<2 x s64>)
  ; CHECK-NEXT:   RET_ReallyLR implicit $q0, implicit $q1
  %result = call { <2 x double>, <2 x double> } @llvm.sincos.v2f64(<2 x double> %a)
  ret { <2 x double>, <2 x double> } %result
}

define { fp128, fp128 } @test_sincos_f128(fp128 %a) {
  ; CHECK-LABEL: name: test_sincos_f128
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $q0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s128) = COPY $q0
  ; CHECK-NEXT:   [[FSINCOS:%[0-9]+]]:_(s128), [[FSINCOS1:%[0-9]+]]:_ = G_FSINCOS [[COPY]]
  ; CHECK-NEXT:   $q0 = COPY [[FSINCOS]](s128)
  ; CHECK-NEXT:   $q1 = COPY [[FSINCOS1]](s128)
  ; CHECK-NEXT:   RET_ReallyLR implicit $q0, implicit $q1
  %result = call { fp128, fp128 } @llvm.sincos.f16(fp128 %a)
  ret { fp128, fp128 } %result
}

define { float, float } @test_sincos_f32_afn(float %a) {
  ; CHECK-LABEL: name: test_sincos_f32_afn
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $s0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $s0
  ; CHECK-NEXT:   [[FSINCOS:%[0-9]+]]:_(s32), [[FSINCOS1:%[0-9]+]]:_ = afn G_FSINCOS [[COPY]]
  ; CHECK-NEXT:   $s0 = COPY [[FSINCOS]](s32)
  ; CHECK-NEXT:   $s1 = COPY [[FSINCOS1]](s32)
  ; CHECK-NEXT:   RET_ReallyLR implicit $s0, implicit $s1
  %result = call afn { float, float } @llvm.sincos.f32(float %a)
  ret { float, float } %result
}
