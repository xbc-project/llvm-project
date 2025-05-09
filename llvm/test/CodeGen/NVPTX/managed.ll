; RUN: llc < %s -mtriple=nvptx64 -mcpu=sm_30 -mattr=+ptx40 | FileCheck %s
; RUN: %if ptxas %{ llc < %s -mtriple=nvptx64 -mcpu=sm_30 -mattr=+ptx40 | %ptxas-verify %}

; RUN: not --crash llc < %s -mtriple=nvptx64 -mcpu=sm_20 2>&1 | FileCheck %s --check-prefix ERROR
; ERROR: LLVM ERROR: .attribute(.managed) requires PTX version >= 4.0 and sm_30

; CHECK: .visible .global .align 4 .u32 device_g;
@device_g = addrspace(1) global i32 zeroinitializer
; CHECK: .visible .global .attribute(.managed) .align 4 .u32 managed_g;
@managed_g = addrspace(1) global i32 zeroinitializer

; CHECK: .extern .global .align 4 .u32 decl_g;
@decl_g = external addrspace(1) global i32, align 4
; CHECK: .extern .global .attribute(.managed) .align 8 .b64 managed_decl_g;
@managed_decl_g = external addrspace(1) global ptr, align 8

!nvvm.annotations = !{!0, !1}
!0 = !{ptr addrspace(1) @managed_g, !"managed", i32 1}
!1 = !{ptr addrspace(1) @managed_decl_g, !"managed", i32 1}
