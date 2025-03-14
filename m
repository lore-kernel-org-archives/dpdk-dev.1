Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C9C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 14:34:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F61F4042E;
	Fri, 14 Mar 2025 15:34:04 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DD88D402D9
 for <dev@dpdk.org>; Fri, 14 Mar 2025 15:33:59 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 09DA0203344D; Fri, 14 Mar 2025 07:33:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09DA0203344D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741962839;
 bh=bmhrcGVGI3PApBzN3fDQ3RCYavepZsQgg9fx7ep+8ec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jmr1kptZcwQLXE5+9paI+2gpgUjVsj095kKNt4a45cdiwp/5Xwgq705jlINVUJgBa
 nb5u5fEAF8qGhDnFWnZNKtc+cDRDu5OtOu8yYRoGEVyzw89A5NhiT1u5uO44PVfMmz
 imUFOrpXSU6JQussccYg74stRuD9+zOUsFXtHDBw=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v5 1/3] eal: add portable version of __builtin_add_overflow
Date: Fri, 14 Mar 2025 07:33:38 -0700
Message-Id: <1741962820-27123-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741962820-27123-1-git-send-email-andremue@linux.microsoft.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741962820-27123-1-git-send-email-andremue@linux.microsoft.com>
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

__builtin_add_overflow is gcc specific. There's a need for a portable
version that can also be used with other compilers.

This patch introduces rte_add_overflow.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 doc/api/doxy-api-index.md   |  1 +
 lib/eal/include/meson.build |  1 +
 lib/eal/include/rte_math.h  | 46 +++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 lib/eal/include/rte_math.h

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index b2fc24b3e4..48922054ed 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -227,6 +227,7 @@ The public API headers are grouped by topics:
   [checksum](@ref rte_cksum.h),
   [config file](@ref rte_cfgfile.h),
   [key/value args](@ref rte_kvargs.h),
+  [math](@ref rte_math.h),
   [argument parsing](@ref rte_argparse.h),
   [ptr_compress](@ref rte_ptr_compress.h),
   [string](@ref rte_string_fns.h),
diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index d903577caa..041a4105b5 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -31,6 +31,7 @@ headers += files(
         'rte_lcore_var.h',
         'rte_lock_annotations.h',
         'rte_malloc.h',
+        'rte_math.h',
         'rte_mcslock.h',
         'rte_memory.h',
         'rte_memzone.h',
diff --git a/lib/eal/include/rte_math.h b/lib/eal/include/rte_math.h
new file mode 100644
index 0000000000..2f4581f81b
--- /dev/null
+++ b/lib/eal/include/rte_math.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Microsoft Corporation
+ */
+
+#ifndef _RTE_MATH_H_
+#define _RTE_MATH_H_
+
+/**
+ * @file
+ *
+ * Math function definitions for DPDK.
+ */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Function that allows performing simple arithmetic operations together with
+ * checking whether the operation overflowed.
+ * Example of usage:
+ *     uint8_t overflow;
+ *     uint16_t a, b, result;
+ *     a = 1;
+ *     b = 2;
+ *     overflow = rte_add_overflow(a, b, &result);
+ */
+#ifdef RTE_TOOLCHAIN_MSVC
+#define rte_add_overflow(a, b, res) _Generic((a), \
+	uint8_t : _addcarry_u8, \
+	uint16_t : _addcarry_u16, \
+	uint32_t : _addcarry_u32, \
+	uint64_t : _addcarry_u64)(0, a, b, res)
+#else
+#define rte_add_overflow(a, b, res) _Generic((a), \
+	uint8_t : __builtin_add_overflow, \
+	uint16_t : __builtin_add_overflow, \
+	uint32_t : __builtin_add_overflow, \
+	uint64_t : __builtin_add_overflow)(a, b, res)
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- 
2.48.1.vfs.0.1

