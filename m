Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE2FC5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:35:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AF7F40E03;
	Tue, 18 Aug 2026 15:34:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 82D3240A76
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:33:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060038; x=1818596038;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RRohY4TQG6VtW7drIf4kTxc9h1j5kQUIonNjmqlmaHY=;
 b=Vwfr9yDKD4QDFWIPDs8T8Nl7IyhqT2fDXW6/Rv4AljdvcYX5FLzdt6JK
 wj68CoLWuNMOMA4lrCa/naIC2CSGZtsSxZFv+HFIkhF/okBjHFP1zWiRa
 JEBTLHq7bw2Gtu/Xt5XLredWYmnjP3zIpyLeb7DB+P4C7xAJua5LY2JPY
 FbqyJDN+aJdMzNzIa1K9UHrZwhG80ckJDHmEhjalrqLVE0OIq/aMgc2lC
 FYBobQSCqF45JpRQcG2i0TbJiAWTjRJlLzZLytLbgVumEp303SZXNILeg
 XfelCcR0BuZooxSf2WHU+VKj0CCMhMt3xvC1+uHCf/9FxhyAYQwkZZ71z g==;
X-CSE-ConnectionGUID: iX67DhH0Rmur7cz+t610iA==
X-CSE-MsgGUID: 75zfdAm5Q7GSZePuRPRMVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757638"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757638"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:33:57 -0700
X-CSE-ConnectionGUID: vUse5dw8Q861+T3eUmrqWQ==
X-CSE-MsgGUID: LK8Lzj9yRqW5Az07/nxKXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736632"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:33:56 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 14/39] eal: add macro for lowest set CPU bit in a set
Date: Tue, 18 Aug 2026 14:33:07 +0100
Message-ID: <20260818133334.2620165-15-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
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

From "man CPU_FFS" on FreeBSD 15:

  The CPU_FFS() macro returns the 1-index of the first (lowest) CPU in
  cpuset, or zero if cpuset is empty.  Like with ffs(3), to use the non-
  zero result of CPU_FFS() as a cpu_idx index parameter to any other
  cpuset(9) macro, you must subtract one from the result.

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
index 20eff0409a..85ce56afaa 100644
--- a/lib/eal/linux/include/rte_os.h
+++ b/lib/eal/linux/include/rte_os.h
@@ -41,6 +41,16 @@ typedef cpu_set_t rte_cpuset_t;
 	RTE_CPU_FILL(&tmp); \
 	CPU_XOR(dst, &tmp, src); \
 } while (0)
+
+static inline int
+rte_cpu_ffs(const rte_cpuset_t *s)
+{
+	for (unsigned int _i = 0; _i < CPU_SETSIZE; _i++)
+		if (CPU_ISSET(_i, s))
+			return (int)(_i + 1);
+	return 0;
+}
+#define RTE_CPU_FFS(s) rte_cpu_ffs(s)
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
2.53.0

