Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C2C282C6
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 20:48:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABCB240156;
	Mon,  3 Mar 2025 21:48:21 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 551E940041
 for <dev@dpdk.org>; Mon,  3 Mar 2025 21:48:20 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id A313B2110483; Mon,  3 Mar 2025 12:48:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A313B2110483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741034899;
 bh=VTcdwWxV59G8cUEPpZQ0LQVOOW48NfBZrWv0q/ynQ/k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=azoqJKGovTMKm9ZqDIP01XRBz7jbIIN8FUZrWkF2MvqHVDhK2ek9R32clkj8QJNa8
 VRpcUS3TxnLEhZTVSJD7ps5G2RIqPNyK/hBQ2AxcjiI8XNlJenl4XRMcX5FxKQwt3a
 N77xu+9jeOQpiVb+alM6utGsUprHBrK9fqRgVeRo=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	sameh.gobriel@intel.com,
	yipeng1.wang@intel.com
Subject: [PATCH v2] member: use common top-level variable for easier
 maintenance
Date: Mon,  3 Mar 2025 12:47:54 -0800
Message-Id: <1741034874-13573-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740769261-736-1-git-send-email-andremue@linux.microsoft.com>
References: <1740769261-736-1-git-send-email-andremue@linux.microsoft.com>
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
 lib/member/meson.build | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/member/meson.build b/lib/member/meson.build
index f92cbb7f25..4341b424df 100644
--- a/lib/member/meson.build
+++ b/lib/member/meson.build
@@ -33,6 +33,11 @@ if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
     # compiler flags, and then have the .o file from static lib
     # linked into main lib.
 
+    member_avx512_args = cc_avx512_flags
+    if not is_ms_compiler
+            member_avx512_args += '-mavx512ifma'
+    endif
+
     # check if all required flags already enabled
     sketch_avx512_flags = ['__AVX512F__', '__AVX512DQ__', '__AVX512IFMA__']
 
@@ -46,13 +51,12 @@ if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
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

