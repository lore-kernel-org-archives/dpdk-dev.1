Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D335606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=medc5rcu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC02C40B91;
	Thu, 26 Nov 2026 19:14:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 9E6D64064E
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716872; x=1827252872;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ir3QzZpb4564Vrm25MULZmfzMyjzPE/FNvGa8d1ahRk=;
 b=medc5rcukB82PuT4SoP+ysoXBeDKDKP+skCjAC9G2iNDF0tgTL1PKiPB
 uNzWsT9mBT4oDyDohk61TL/eynyrEuGih+flK/88FLs7lLBzst3MM0Oz9
 ywB/udKBTNIDq1SJDz0Utu54sCUqf8j/Ws/aAJpds2thDS3wcdaKfuZrr
 kuMT2lDApTf9kJdFO/u44jy2AmHW+k3RCT73yqlgD01kyCD2Fdpurh5gp
 Gb+USeURr9iflfXlgxOkjpvQGuyAfzlbkhHTjYNzrGq2t69nYQYCyFOR9
 R0PzAM/6PDdcJa82HTZLxFftBTL+CQrPowr77iQQJyqog36lL9WSslQCT g==;
X-CSE-ConnectionGUID: u3K5VD1iRQS318ZuMgwbYA==
X-CSE-MsgGUID: L1J44TgjRtSrs6m7/yUFSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633563"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633563"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:32 -0800
X-CSE-ConnectionGUID: hfhcgP5aSCqTRdkgAc6wGQ==
X-CSE-MsgGUID: zOilKDfcTUiDef9ngjLaaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732904"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:30 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 14/39] eal: add macro for lowest set CPU bit in a set
Date: Thu, 26 Nov 2026 18:13:47 +0000
Message-ID: <20261126181414.124094-15-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126181414.124094-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20261126181414.124094-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.55.0

