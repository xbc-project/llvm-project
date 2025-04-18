; RUN: opt -passes=sandbox-vectorizer -sbvec-print-pass-pipeline %s -disable-output | FileCheck %s

; !!!WARNING!!! This won't get updated by update_test_checks.py !

; This checks the default pass pipeline for the sandbox vectorizer.
define void @pipeline() {
; CHECK: fpm
; CHECK: seed-collection
; CHECK: rpm
; CHECK: bottom-up-vec
; CHECK: tr-accept-or-revert
; CHECK-EMPTY:
  ret void
}
