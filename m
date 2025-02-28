Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D394C282C6
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 19:01:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7412B402C2;
	Fri, 28 Feb 2025 20:01:07 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 487D740280
 for <dev@dpdk.org>; Fri, 28 Feb 2025 20:01:05 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 7E5AF210D0DA; Fri, 28 Feb 2025 11:01:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E5AF210D0DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740769264;
 bh=yOqTAn196K9Ykhdf0NQq6SDEibJ4dEyGUVtd8aaQ9OA=;
 h=From:To:Cc:Subject:Date:From;
 b=HCEaQHhxjo5thuFjk9namDJRp60dVmAE+SXWsETR8H3oAVdbk6aEp1GPIyJe92sp9
 snBqthaMOcwX+NLwL5Tq78bRc8sg6QNJJ4P2372GPJNSgNRKl/P1BRCZ3AQ7wrqXip
 QIBiBmwhG/fgNKKiEinKwh9BA4722ugnbhVfnolw=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] member: use common top-level variable for easier maintenance
Date: Fri, 28 Feb 2025 11:01:01 -0800
Message-Id: <1740769261-736-1-git-send-email-andremue@linux.microsoft.com>
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

Updated meson.build to use common variable cc_avx512_flags for
msvc and avoiding code duplication for other compilers.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/member/meson.build | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/member/meson.build b/lib/member/meson.build
index f92cbb7f25..8416dc6f8a 100644
--- a/lib/member/meson.build
+++ b/lib/member/meson.build
@@ -33,6 +33,12 @@ if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
     # compiler flags, and then have the .o file from static lib
     # linked into main lib.
 
+    if is_ms_compiler
+        member_avx512_args = cc_avx512_flags
+    else
+        member_avx512_args = ['-mavx512f', '-mavx512dq', '-mavx512ifma']
+    endif
+
     # check if all required flags already enabled
     sketch_avx512_flags = ['__AVX512F__', '__AVX512DQ__', '__AVX512IFMA__']
 
@@ -46,13 +52,12 @@ if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
     if sketch_avx512_on == true
         cflags += ['-DCC_AVX512_SUPPORT']
         sources += files('rte_member_sketch_avx512.c')
-    elif cc.has_multi_arguments('-mavx512f', '-mavx512dq', '-mavx512ifma')
+    elif cc.has_multi_arguments(member_avx512_args)
         sketch_avx512_tmp = static_library('sketch_avx512_tmp',
             'rte_member_sketch_avx512.c',
             include_directories: includes,
             dependencies: [static_rte_eal, static_rte_hash],
-            c_args: cflags +
-                ['-mavx512f', '-mavx512dq', '-mavx512ifma'])
+            c_args: cflags + member_avx512_args)
         objs += sketch_avx512_tmp.extract_objects('rte_member_sketch_avx512.c')
         cflags += ['-DCC_AVX512_SUPPORT']
     endif
-- 
2.48.1.vfs.0.0

