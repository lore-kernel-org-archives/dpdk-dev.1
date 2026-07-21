Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927AEC44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:47:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A043D40DD0;
	Tue, 21 Jul 2026 11:46:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 27AB440BA3
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627176; x=1816163176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RRohY4TQG6VtW7drIf4kTxc9h1j5kQUIonNjmqlmaHY=;
 b=PBOjD6YcIHaQJ1ceB2JRaSeG25VLomEHbF7eszfPY/XpE5rsR+mDN4rb
 D76SzJ1ar3On0jpEEzBQeB8itrsc+OxQmbXD6u4vhfgEyoGDbaNJ6xQ3W
 faQCun5Y5RktHOFXjbq/0SaWfx6vA9BUDEULhD7Fdd1TPrbTTK3BOm4Nt
 Q6EBQyUjtQIPwWt0q/7yJFzd5REizAd3EDkkXu4nLxqDhYIFg8SxVXiVQ
 2MHU57vll0eTEFx9GDqa7Eho5YxJqgIdJRgPWxC3rLVQquz4n8Oo2kNZu
 4CZaUoqi23laTk2tmQ5bmVPDSRcbyAx2FM6jQCst2YaMU6gWM0F49zjhZ A==;
X-CSE-ConnectionGUID: DfP3HhnIQbaxunUOWx7Tcw==
X-CSE-MsgGUID: 7qWXOYyqTWSk57TGAPIeXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872471"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872471"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:15 -0700
X-CSE-ConnectionGUID: 4cpHXWk7TP6wGBB4YljX2A==
X-CSE-MsgGUID: BnhK7E4JRz24CQ70je9uEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922327"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:14 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 14/39] eal: add macro for lowest set CPU bit in a set
Date: Tue, 21 Jul 2026 10:45:22 +0100
Message-ID: <20260721094555.2188496-15-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721094555.2188496-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260721094555.2188496-1-bruce.richardson@intel.com>
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

