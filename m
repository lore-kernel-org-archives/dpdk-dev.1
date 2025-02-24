Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E58BC021BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 21:02:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 322D2427D0;
	Mon, 24 Feb 2025 22:01:51 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8C01640EE2
 for <dev@dpdk.org>; Mon, 24 Feb 2025 22:01:43 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id CB1B9203CDE7; Mon, 24 Feb 2025 13:01:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB1B9203CDE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740430902;
 bh=iFNM5B/UEgul4mhihyyxloZ7LMgVV0NP5YkFXQSLdpw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CTZOVod0SlUXhNS3hQyiRHdcwy7gsbyB/ujSZVzfb8JwCsnNq5F3Y4Hfdc9RQhVRv
 Q8ubXRGMaCtvZ8Nk1PKNqvfi7A+7bZoigCfpaaRGkE6mchVe1NmUT9k6vnvZBpP878
 g+dZrrCJqGRlrDE2yMSwjkPTxOR5f5qXor0xYt04=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 5/6] acl: make compatible with instruction set updates for MSVC
Date: Mon, 24 Feb 2025 13:01:18 -0800
Message-Id: <1740430879-17874-6-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
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

Top level 'cc_avx2_flags' was created and holds the correct flags
depending on the compiler used.

File meson.build was updated to handle the correct AVX512 flags
depending on compiler used.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/acl/meson.build | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/acl/meson.build b/lib/acl/meson.build
index fefe131a48..24e47b6cc1 100644
--- a/lib/acl/meson.build
+++ b/lib/acl/meson.build
@@ -19,7 +19,7 @@ if dpdk_conf.has('RTE_ARCH_X86')
     avx2_tmplib = static_library('avx2_tmp',
             'acl_run_avx2.c',
             dependencies: static_rte_eal,
-            c_args: cflags + ['-mavx2'])
+            c_args: [cflags, cc_avx2_flags])
     objs += avx2_tmplib.extract_objects('acl_run_avx2.c')
 
     # compile AVX512 version if:
@@ -38,6 +38,12 @@ if dpdk_conf.has('RTE_ARCH_X86')
         # compiler flags, and then have the .o file from static lib
         # linked into main lib.
 
+        if is_ms_compiler
+            acl_avx512_args = cc_avx512_flags
+        else
+            acl_avx512_args = ['-mavx512f', '-mavx512vl', '-mavx512cd', '-mavx512bw']
+        endif
+
         # check if all required flags already enabled (variant a).
         acl_avx512_flags = ['__AVX512F__', '__AVX512VL__',
             '__AVX512CD__', '__AVX512BW__']
@@ -55,15 +61,11 @@ if dpdk_conf.has('RTE_ARCH_X86')
             sources += files('acl_run_avx512.c')
             cflags += '-DCC_AVX512_SUPPORT'
 
-        elif cc.has_multi_arguments('-mavx512f', '-mavx512vl',
-                    '-mavx512cd', '-mavx512bw')
-
+        elif cc.has_multi_arguments(acl_avx512_args)
             avx512_tmplib = static_library('avx512_tmp',
                 'acl_run_avx512.c',
                 dependencies: static_rte_eal,
-                c_args: cflags +
-                    ['-mavx512f', '-mavx512vl',
-                     '-mavx512cd', '-mavx512bw'])
+                c_args: cflags + acl_avx512_args)
             objs += avx512_tmplib.extract_objects(
                     'acl_run_avx512.c')
             cflags += '-DCC_AVX512_SUPPORT'
-- 
2.48.1.vfs.0.0

