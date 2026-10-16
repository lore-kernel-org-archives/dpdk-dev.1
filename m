Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D112DCCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:02:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F7AF400D7;
	Fri, 16 Oct 2026 16:02:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 416F4400D7
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:02:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792159347; x=1823695347;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=BsLnbH2uCorRry+Fwkdm3Tvy+oLSO34GIRO0cNfhVyM=;
 b=SeFpW7yY53P35nZCtwEFsRa64vQvVK+qCLegZMom4fECSNvN2+xQCd/U
 O7nFzXJFqZQ2SVKT33SsUCf5GPOYmu0KzFp3BYHaepVH+y6FsxGP0PYnE
 JrI5EpK5eMxA4EVXxIoR1iVpzh7rRgBY4L2ukVuMO6q8/DzHFeJBeJrj0
 Mdjz9PLO1mobfYEwUv9QQ9TDb7kXOYlvCtupSLtXhTgIK0lYRDbQug/12
 V0lxI4Qcv99EFxr9nPVYhaObyf43Y4sZs90OUjqqhkcH8tXgYWH00Ab/g
 P4qVhanS9vjnN+Y3lfZ9MhtB366knRL4Hs6wIPnQ6AVFtdzTfOj4y+wAm w==;
X-CSE-ConnectionGUID: 1sRe9p6xSwqXpL4Xgx7RJw==
X-CSE-MsgGUID: szlXsQJ4Re+7B6LeM6wxGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1043661"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1043661"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 07:02:20 -0700
X-CSE-ConnectionGUID: OL6cwfUKSnSrGAWd7hmsWw==
X-CSE-MsgGUID: qIIrgjc4SMyIZ/doANWmYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1951646"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 16 Oct 2026 07:02:20 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [27.03 RFC PATCH v1 1/8] eal: add usage count helpers
Date: Fri, 16 Oct 2026 15:02:08 +0100
Message-ID: <bbe2edb08d49131b8b17e04e9cf4c400c0f32af4.1792159157.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792159157.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In writing DPDK code, one of the often-seen pattern is counting usage of
resources - programming a HW block on first/last flow rule, or even just
tracking references to software structures. In a lot of cases, a simple
usage count is not a good fit because of atomicity/thread safety
requirements, but for trivial/already synchronized cases it can be useful.

Add a "usage count" library to EAL to enable such use cases.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/api/doxy-api-index.md         |  1 +
 lib/eal/include/meson.build       |  1 +
 lib/eal/include/rte_usage_count.h | 96 +++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 lib/eal/include/rte_usage_count.h

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 62390f7be3..ab4ff04797 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -177,6 +177,7 @@ The public API headers are grouped by topics:
   [soring](@ref rte_soring.h),
   [stack](@ref rte_stack.h),
   [tailq](@ref rte_tailq.h),
+  [usage count](@ref rte_usage_count.h),
   [bitset](@ref rte_bitset.h),
   [bitmap](@ref rte_bitmap.h)
 
diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index 67c6a8021a..5ff432051e 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -53,6 +53,7 @@ headers += files(
         'rte_trace.h',
         'rte_trace_point.h',
         'rte_trace_point_register.h',
+        'rte_usage_count.h',
         'rte_uuid.h',
         'rte_version.h',
 )
diff --git a/lib/eal/include/rte_usage_count.h b/lib/eal/include/rte_usage_count.h
new file mode 100644
index 0000000000..3056436ba8
--- /dev/null
+++ b/lib/eal/include/rte_usage_count.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _RTE_USAGE_COUNT_H_
+#define _RTE_USAGE_COUNT_H_
+
+/**
+ * @file
+ * RTE Usage Counter
+ *
+ * Trivial usage (reference) counters intended to express increment/decrement
+ * sequences with first/last user edge detection, for example "do X on first Y,
+ * undo X on last Y".
+ *
+ * The counters are neither thread-safe nor atomic; callers must provide their
+ * own serialization.
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+
+#include <rte_compat.h>
+#include <rte_debug.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * Usage counter type.
+ */
+typedef uint32_t rte_usage_count_t;
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Claim a usage.
+ *
+ * @param counter
+ *   Usage counter to claim.
+ * @return
+ *   true if this is the first usage, false otherwise.
+ */
+__rte_experimental
+static inline bool
+rte_usage_count_claim(rte_usage_count_t *counter)
+{
+	RTE_ASSERT(*counter != UINT32_MAX);
+	return (*counter)++ == 0;
+}
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Release a usage.
+ *
+ * @param counter
+ *   Usage counter to release. Must have at least one usage.
+ * @return
+ *   true if this was the last usage, false otherwise.
+ */
+__rte_experimental
+static inline bool
+rte_usage_count_release(rte_usage_count_t *counter)
+{
+	RTE_ASSERT(*counter != 0);
+	return --(*counter) == 0;
+}
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Test whether the currently claimed usage is the last one,
+ * i.e. whether a subsequent release would return true.
+ *
+ * @param counter
+ *   Usage counter to test.
+ * @return
+ *   true if exactly one usage is currently claimed, false otherwise.
+ */
+__rte_experimental
+static inline bool
+rte_usage_count_is_last(const rte_usage_count_t *counter)
+{
+	return *counter == 1;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_USAGE_COUNT_H_ */
-- 
2.52.0

