Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456A4C369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 21:24:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFDDA40270;
	Tue,  8 Apr 2025 23:24:45 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 52AA84026B
 for <dev@dpdk.org>; Tue,  8 Apr 2025 23:24:44 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 69CB82113E93; Tue,  8 Apr 2025 14:24:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69CB82113E93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744147483;
 bh=GXYlvGlqb5ImEtsVQ3NM2SId9ZnM4lBXqgyifEfmHaY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f2Kg0pLiJMnNZswpQsVsjQVDx1LsEr/4rSN1VaekdHsXjfRfcCPmCN9VIEfcpxKRb
 wlLTCpOLlRkxao0qQwSkYsUXyqj/OBeS+cgweK+YcMsjYca4qkiAcr8PHs4740ONLE
 jjM2pNUHG4U5X5bmHhG1Gb5aU7eNKFhODeX3lsPU=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v4 1/1] mbuf: enable to be compiled with MSVC
Date: Tue,  8 Apr 2025 14:24:37 -0700
Message-Id: <1744147477-23715-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744147477-23715-1-git-send-email-andremue@linux.microsoft.com>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1744147477-23715-1-git-send-email-andremue@linux.microsoft.com>
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

Now that the issues preventing this lib from being compiled with MSVC
are fixed it can be included in the compilation.

The "net" library will automatically get compiled as well as it
has a dependency on "mbuf" which will now get fulfilled.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/mbuf/meson.build | 6 ------
 lib/net/meson.build  | 7 ++++++-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/mbuf/meson.build b/lib/mbuf/meson.build
index 2cee9057a5..0435c5e628 100644
--- a/lib/mbuf/meson.build
+++ b/lib/mbuf/meson.build
@@ -1,12 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-if is_ms_compiler
-    build = false
-    reason = 'not supported building with Visual Studio Toolset'
-    subdir_done()
-endif
-
 sources = files(
         'rte_mbuf.c',
         'rte_mbuf_ptype.c',
diff --git a/lib/net/meson.build b/lib/net/meson.build
index 7a6c419f40..c528fcc9a2 100644
--- a/lib/net/meson.build
+++ b/lib/net/meson.build
@@ -43,7 +43,12 @@ use_function_versioning = true
 
 if dpdk_conf.has('RTE_ARCH_X86_64')
     sources += files('net_crc_sse.c')
-    cflags += ['-mpclmul', '-maes']
+    cflags_options = ['-mpclmul', '-maes']
+    foreach option:cflags_options
+        if cc.has_argument(option)
+            cflags += option
+        endif
+    endforeach
     # only build AVX-512 support if we also have PCLMULQDQ support
     if cc.has_argument('-mvpclmulqdq')
         sources_avx512 += files('net_crc_avx512.c')
-- 
2.49.0.vfs.0.0

