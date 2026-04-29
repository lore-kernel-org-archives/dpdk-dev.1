Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89914CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:00:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97D5640E01;
	Wed, 29 Apr 2026 18:59:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 664C240DD8;
 Wed, 29 Apr 2026 18:59:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481951; x=1809017951;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XrET1IVFryQhZfjKl9uz8xNvjPmQfCJ9mXuWc8lVWio=;
 b=WnPtpcUjUhCQBbGWsxrjw0UWlXkuKXRnmhLXsyOd5wwJpe/qSE2lFgDW
 cu9Ya0MvzOCkVs7mqyoResBGtbopOCL741FPFls1Mgipxksdo8uLypH7n
 d+2yf/fHFFNdmDJZ/qXXUaxOFGdwAreQ8KLwCZQ+JKbU5ZoGkxC7ppHG2
 JFuDm+oYuaf10UIY6TK0usyl1WNp5mr2+OJgVsqFngv+7vSWNNiQURXz1
 x8QuB3Rm+ABhWTTISueZD50p6iWBqP7zXZJxn2uyGDzqkkRiRjgDASJ1x
 UTgVJB364cmXOP/TjqMZG0jGlnbQrqnLqR3n0fio2G7PQD+jVypPnfOrM w==;
X-CSE-ConnectionGUID: h1f1yaOfR367jdCdvWDYNA==
X-CSE-MsgGUID: r40qyGdjRpaHLhLQYCQS9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725311"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725311"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:11 -0700
X-CSE-ConnectionGUID: vuBWFWMKQMSO6i/7nPHUnw==
X-CSE-MsgGUID: yufwRk/YSxyZq+l/64+x8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696965"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:09 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 12/44] eal: add RTE_CPU_FFS macro
Date: Wed, 29 Apr 2026 17:58:04 +0100
Message-ID: <20260429165845.2136843-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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

FreeBSD supports the CPU_FFS macro as part of the regular cpuset
functions. Add this as RTE_CPU_FFS for all OS's.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/freebsd/include/rte_os.h |  2 ++
 lib/eal/linux/include/rte_os.h   | 10 ++++++++++
 lib/eal/windows/include/rte_os.h |  1 +
 lib/eal/windows/include/sched.h  | 10 ++++++++++
 4 files changed, 23 insertions(+)

diff --git a/lib/eal/freebsd/include/rte_os.h b/lib/eal/freebsd/include/rte_os.h
index 94b9275beb..38fd0e7f05 100644
--- a/lib/eal/freebsd/include/rte_os.h
+++ b/lib/eal/freebsd/include/rte_os.h
@@ -75,4 +75,6 @@ typedef cpuset_t rte_cpuset_t;
 
 #endif /* RTE_EAL_FREEBSD_CPUSET_LEGACY */
 
+#define RTE_CPU_FFS CPU_FFS
+
 #endif /* _RTE_OS_H_ */
diff --git a/lib/eal/linux/include/rte_os.h b/lib/eal/linux/include/rte_os.h
index 20eff0409a..6e299cc7da 100644
--- a/lib/eal/linux/include/rte_os.h
+++ b/lib/eal/linux/include/rte_os.h
@@ -41,6 +41,16 @@ typedef cpu_set_t rte_cpuset_t;
 	RTE_CPU_FILL(&tmp); \
 	CPU_XOR(dst, &tmp, src); \
 } while (0)
+
+static inline int
+_cpu_ffs(const rte_cpuset_t *s)
+{
+	for (unsigned int _i = 0; _i < CPU_SETSIZE; _i++)
+		if (CPU_ISSET(_i, s))
+			return (int)(_i + 1);
+	return 0;
+}
+#define RTE_CPU_FFS(s) _cpu_ffs(s)
 #endif
 
 #endif /* _RTE_OS_H_ */
diff --git a/lib/eal/windows/include/rte_os.h b/lib/eal/windows/include/rte_os.h
index 2a43cb1f9b..25701c7906 100644
--- a/lib/eal/windows/include/rte_os.h
+++ b/lib/eal/windows/include/rte_os.h
@@ -49,6 +49,7 @@ struct { \
 #define RTE_CPU_OR(dst, src1, src2) CPU_OR(dst, src1, src2)
 #define RTE_CPU_FILL(set) CPU_FILL(set)
 #define RTE_CPU_NOT(dst, src) CPU_NOT(dst, src)
+#define RTE_CPU_FFS(s) CPU_FFS(s)
 
 /* This is an exception without "rte_" prefix, because Windows does have
  * ssize_t, but it's defined in <windows.h> which we avoid to expose.
diff --git a/lib/eal/windows/include/sched.h b/lib/eal/windows/include/sched.h
index 912fed12c2..230de19c76 100644
--- a/lib/eal/windows/include/sched.h
+++ b/lib/eal/windows/include/sched.h
@@ -86,6 +86,16 @@ do { \
 		(dst)->_bits[_i] = (src)->_bits[_i] ^ -1LL; \
 } while (0)
 
+static inline int
+cpu_ffs(const rte_cpuset_t *s)
+{
+	for (unsigned int _i = 0; _i < CPU_SETSIZE; _i++)
+		if (CPU_ISSET(_i, s))
+			return (int)(_i + 1);
+	return 0;
+}
+#define CPU_FFS(s) cpu_ffs(s)
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.51.0

