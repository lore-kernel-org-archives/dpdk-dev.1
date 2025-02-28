Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93739C282C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 15:52:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76CAD402DD;
	Fri, 28 Feb 2025 16:52:32 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 93661402CA
 for <dev@dpdk.org>; Fri, 28 Feb 2025 16:52:30 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id BC012210EAD0; Fri, 28 Feb 2025 07:52:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC012210EAD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740757949;
 bh=WCRKvE++HHPJgTZIa0FyrtELOPc/Oc5beNN/v1cRamM=;
 h=From:To:Cc:Subject:Date:From;
 b=dvKlJBx0/pq4dD4dkXy3myAK5J4AoiRDBIWr/ZA8R0pf6PIcrV7XFl6iRbPnxutpq
 d9ucA4sO7PflOKY34mAt1GQdY8nqCM/Nzk8BxKSi7LPiouXOt+2u+wsKxdTP73eYYx
 irXE64LJ+zPNH8ahM0UmnASe3eY8Z1PgjtfIqY8Y=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] config: move existing code that is common to the top
Date: Fri, 28 Feb 2025 07:52:20 -0800
Message-Id: <1740757940-10253-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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
 config/x86/meson.build | 91 ++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index 47a5b0c04a..68fcdc4993 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -1,6 +1,52 @@
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
+cpu_instruction_set = get_option('cpu_instruction_set')
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
@@ -14,9 +60,8 @@ if is_linux or cc.get_id() == 'gcc'
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
@@ -82,43 +127,3 @@ foreach f:optional_flags
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

