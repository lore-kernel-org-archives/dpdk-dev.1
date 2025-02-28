Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF36C282C6
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 18:46:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCE00402C2;
	Fri, 28 Feb 2025 19:46:13 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3FB2D40280
 for <dev@dpdk.org>; Fri, 28 Feb 2025 19:46:12 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 72FC7210D0D9; Fri, 28 Feb 2025 10:46:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72FC7210D0D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740768371;
 bh=TJPR9P0Xsu98lAxWdGMdNjKIT02r3fdQ+V2zTR54SSQ=;
 h=From:To:Cc:Subject:Date:From;
 b=NFc6nUoODpKBZD4YUfEC5q4CZfskBg0Jml7W3GmKzCcoEzOI0MwMSNkOwkInkLuvv
 PrCBvn6D7drAhq39OfeytxeqtbopDTi6piMvycTJs1k9f0Jp30tPjoOgbdITgd2LVa
 uTUC5hceWvo3DcVAJyucp5B30JSUrl1AvQ+0VMcE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] acl: use common top-level variable for easier maintenance
Date: Fri, 28 Feb 2025 10:45:56 -0800
Message-Id: <1740768356-29954-1-git-send-email-andremue@linux.microsoft.com>
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

Updated meson.build to use common variable cc_avx512_flags.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 config/x86/meson.build | 2 +-
 lib/acl/meson.build    | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index 47a5b0c04a..12befd4d73 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -14,7 +14,7 @@ if is_linux or cc.get_id() == 'gcc'
     endif
 endif
 
-cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw']
+cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw', '-mavx512cd']
 cc_has_avx512 = false
 target_has_avx512 = false
 if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
diff --git a/lib/acl/meson.build b/lib/acl/meson.build
index fefe131a48..6ba53fbba4 100644
--- a/lib/acl/meson.build
+++ b/lib/acl/meson.build
@@ -55,15 +55,11 @@ if dpdk_conf.has('RTE_ARCH_X86')
             sources += files('acl_run_avx512.c')
             cflags += '-DCC_AVX512_SUPPORT'
 
-        elif cc.has_multi_arguments('-mavx512f', '-mavx512vl',
-                    '-mavx512cd', '-mavx512bw')
-
+        elif cc.has_multi_arguments(cc_avx512_flags)
             avx512_tmplib = static_library('avx512_tmp',
                 'acl_run_avx512.c',
                 dependencies: static_rte_eal,
-                c_args: cflags +
-                    ['-mavx512f', '-mavx512vl',
-                     '-mavx512cd', '-mavx512bw'])
+                c_args: cflags + cc_avx512_flags)
             objs += avx512_tmplib.extract_objects(
                     'acl_run_avx512.c')
             cflags += '-DCC_AVX512_SUPPORT'
-- 
2.48.1.vfs.0.0

