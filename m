Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BDEC02192
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 01:58:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 278FA40289;
	Tue,  4 Feb 2025 02:58:48 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D43984003C
 for <dev@dpdk.org>; Tue,  4 Feb 2025 02:58:46 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 07B8D205493F; Mon,  3 Feb 2025 17:58:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 07B8D205493F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738634326;
 bh=TPLcCGfFqPF3Y/WgrDFt9DR40a8TsWyYXlx/fQolxRU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Efa9PnuqdGWR3H6T234ivMT33x0gwVDrWpw2brljnWVrfkFUc/bVSesq6GeuT1Uq7
 qzn5Z1HyLHwJgTxjfHon80L4lxd3RE8533ozZ78lP9jlV2sA8dlcxdNBiAnGipnVar
 J2NesAGr3gZH1gyHuPMpt0Z+bD7XdOMo1zT6gsQ4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	david.marchand@redhat.com
Subject: [PATCH v3 2/2] stack: enable build with MSVC
Date: Mon,  3 Feb 2025 17:58:38 -0800
Message-Id: <1738634318-12876-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738634318-12876-1-git-send-email-andremue@linux.microsoft.com>
References: <1733848355-19048-1-git-send-email-andremue@linux.microsoft.com>
 <1738634318-12876-1-git-send-email-andremue@linux.microsoft.com>
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

An implementation compatible with MSVC is provided for
atomic128_cmp_exchange in rte_stack_lf_c11.h.

Now that the issues preventing the code needed to build lib/stack
have been addressed, it can be enabled so that it also gets built
when using the MSVC compiler.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/stack/meson.build        |  6 ------
 lib/stack/rte_stack_lf_c11.h | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/lib/stack/meson.build b/lib/stack/meson.build
index 7631a14784..18177a742f 100644
--- a/lib/stack/meson.build
+++ b/lib/stack/meson.build
@@ -1,12 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2019 Intel Corporation
 
-if is_ms_compiler
-    build = false
-    reason = 'not supported building with Visual Studio Toolset'
-    subdir_done()
-endif
-
 sources = files('rte_stack.c', 'rte_stack_std.c', 'rte_stack_lf.c')
 headers = files('rte_stack.h')
 # subheaders, not for direct inclusion by apps
diff --git a/lib/stack/rte_stack_lf_c11.h b/lib/stack/rte_stack_lf_c11.h
index 60d46e963b..898d43edb2 100644
--- a/lib/stack/rte_stack_lf_c11.h
+++ b/lib/stack/rte_stack_lf_c11.h
@@ -8,6 +8,33 @@
 #include <rte_branch_prediction.h>
 #include <rte_prefetch.h>
 
+#ifdef RTE_TOOLCHAIN_MSVC
+/**
+ * The maximum lock-free data size that can be manipulated atomically using C11
+ * standard is limited to 8 bytes.
+ *
+ * This implementation for rte_atomic128_cmp_exchange operates on 16-byte
+ * data types and is made available here so that it can be used without the
+ * need to unnecessarily expose other non-C11 atomics present in
+ * rte_atomic_64.h when using MSVC.
+ */
+static inline int
+rte_atomic128_cmp_exchange(rte_int128_t *dst,
+			   rte_int128_t *exp,
+			   const rte_int128_t *src,
+			   unsigned int weak,
+			   int success,
+			   int failure)
+{
+	return (int)_InterlockedCompareExchange128(
+		(int64_t volatile *) dst,
+		src->val[1], /* exchange high */
+		src->val[0], /* exchange low */
+		(int64_t *) exp /* comparand result */
+	);
+}
+#endif /* RTE_TOOLCHAIN_MSVC */
+
 static __rte_always_inline unsigned int
 __rte_stack_lf_count(struct rte_stack *s)
 {
-- 
2.47.2.vfs.0.1

