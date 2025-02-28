Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D7DC282C6
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 22:03:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 656B5410F2;
	Fri, 28 Feb 2025 23:03:18 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 723EA402CC
 for <dev@dpdk.org>; Fri, 28 Feb 2025 23:03:15 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id BBA94210D0EE; Fri, 28 Feb 2025 14:03:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBA94210D0EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740780194;
 bh=p6Xxmv+gUwX4YhysUIawoydf4FJBbDSzpBp8l4GMCj0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JiLIUgVSI4ZxoNsv8L863ntQUZm7clSQmMhozzYIBfse83PZVhmzcMOR3/Tpp/E0o
 iJCe4x7DxmJwJqMncH/ybjYDnLGaS7zjBdFwoEpOcqsBpx9qj/VonoHt12RFGnKkkw
 ViL+f2owKZbvHndnYZxYDdWStLPJ7aeCizyot6qw=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, konstantin.v.ananyev@yandex.ru
Subject: [PATCH v2 1/1] config: move existing code that is common to the top
Date: Fri, 28 Feb 2025 14:03:07 -0800
Message-Id: <1740780187-5272-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740780187-5272-1-git-send-email-andremue@linux.microsoft.com>
References: <1740757940-10253-1-git-send-email-andremue@linux.microsoft.com>
 <1740780187-5272-1-git-send-email-andremue@linux.microsoft.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

In preparation to add better MSVC support, existing common code was
moved up.

A split was added which in future will call an MSVC specific meson.build
file:

if is_ms_compiler
    subdir_done()
endif

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 config/x86/meson.build | 90 ++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index 47a5b0c04a..ea9bd8231d 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -1,6 +1,51 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017-2020 Intel Corporation
 
+cc_has_avx512 = false
+target_has_avx512 = false
+
+dpdk_conf.set('RTE_ARCH_X86', 1)
+if dpdk_conf.get('RTE_ARCH_64')
+    dpdk_conf.set('RTE_ARCH_X86_64', 1)
+    dpdk_conf.set('RTE_ARCH', 'x86_64')
+else
+    dpdk_conf.set('RTE_ARCH_I686', 1)
+    dpdk_conf.set('RTE_ARCH', 'i686')
+endif
+
+dpdk_conf.set('RTE_CACHE_LINE_SIZE', 64)
+dpdk_conf.set('RTE_MAX_LCORE', 128)
+
+epyc_zen_cores = {
+    '__znver5__':768,
+    '__znver4__':512,
+    '__znver3__':256,
+    '__znver2__':256,
+    '__znver1__':128
+    }
+
+if cpu_instruction_set == 'native'
+    foreach m:epyc_zen_cores.keys()
+        if cc.get_define(m, args: machine_args) != ''
+            dpdk_conf.set('RTE_MAX_LCORE', epyc_zen_cores[m])
+            break
+        endif
+    endforeach
+else
+    foreach m:epyc_zen_cores.keys()
+        if m.contains(cpu_instruction_set)
+            dpdk_conf.set('RTE_MAX_LCORE', epyc_zen_cores[m])
+            break
+        endif
+    endforeach
+endif
+
+dpdk_conf.set('RTE_MAX_NUMA_NODES', 32)
+
+if is_ms_compiler
+    subdir_done()
+endif
+
 # get binutils version for the workaround of Bug 97
 binutils_ok = true
 if is_linux or cc.get_id() == 'gcc'
@@ -14,9 +59,8 @@ if is_linux or cc.get_id() == 'gcc'
     endif
 endif
 
-cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw']
-cc_has_avx512 = false
-target_has_avx512 = false
+cc_avx2_flags = ['-mavx2']
+cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw', '-mavx512cd']
 if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
         and '-mno-avx512f' not in get_option('c_args'))
     # check if compiler is working with _mm512_extracti64x4_epi64
@@ -82,43 +126,3 @@ foreach f:optional_flags
         compile_time_cpuflags += ['RTE_CPUFLAG_' + f]
     endif
 endforeach
-
-
-dpdk_conf.set('RTE_ARCH_X86', 1)
-if dpdk_conf.get('RTE_ARCH_64')
-    dpdk_conf.set('RTE_ARCH_X86_64', 1)
-    dpdk_conf.set('RTE_ARCH', 'x86_64')
-else
-    dpdk_conf.set('RTE_ARCH_I686', 1)
-    dpdk_conf.set('RTE_ARCH', 'i686')
-endif
-
-dpdk_conf.set('RTE_CACHE_LINE_SIZE', 64)
-dpdk_conf.set('RTE_MAX_LCORE', 128)
-
-epyc_zen_cores = {
-    '__znver5__':768,
-    '__znver4__':512,
-    '__znver3__':256,
-    '__znver2__':256,
-    '__znver1__':128
-    }
-
-cpu_instruction_set = get_option('cpu_instruction_set')
-if cpu_instruction_set == 'native'
-    foreach m:epyc_zen_cores.keys()
-        if cc.get_define(m, args: machine_args) != ''
-            dpdk_conf.set('RTE_MAX_LCORE', epyc_zen_cores[m])
-            break
-        endif
-    endforeach
-else
-    foreach m:epyc_zen_cores.keys()
-        if m.contains(cpu_instruction_set)
-            dpdk_conf.set('RTE_MAX_LCORE', epyc_zen_cores[m])
-            break
-        endif
-    endforeach
-endif
-
-dpdk_conf.set('RTE_MAX_NUMA_NODES', 32)
-- 
2.48.1.vfs.0.0

