Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD94CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 15:32:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B87FD402C0;
	Thu,  2 Oct 2025 17:32:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8BA2C40268
 for <dev@dpdk.org>; Thu,  2 Oct 2025 17:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759419155; x=1790955155;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mRUHkEM8o+yz8OHjuzxe9RLz9OB8mxHpmRM2ohAA7Ls=;
 b=XrTcX9mSaatNJn77yeioulEpE3rhAaV6zz2Mz/sIteMsmgYvFS98WjMF
 vv/s0Nt4Q2fZRHTFUTms5a8ZAl2O9n/IFP1qCgT5O8ZAE/URpecKWFEI2
 iIP7VkWMUQZj0/3aOewSJDg7FMczxCLhLUx2szoH94h9fd5uXB2jxggrT
 um6DmfjT7m8YZbsvtamn4FZEnAnf/MpLuMNZxtRh+XIWI0RbSOpy3hlCH
 6RpJ7ekaf3/lQsuMzuEzvcDG+9757lAmCuDAj1Oclu1YQNyzCVDhWASMC
 fGkp6RX7HXlA0TzIwJoal9P4TUOP0TzyhwY+nmr84KrPtfNl903XRDGeS A==;
X-CSE-ConnectionGUID: K7QKPv2IT76xY/Xap3Uqzg==
X-CSE-MsgGUID: DSQ75KdqRtSYiGAdcdPcCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61866728"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="61866728"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 08:32:34 -0700
X-CSE-ConnectionGUID: wkde2Pr8SEyTdlAuPwf4sA==
X-CSE-MsgGUID: VeRhogDdQk6eVFhy/fZ9lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="179016168"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2025 08:32:31 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Kai Ji <kai.ji@intel.com>
Subject: [dpdk-dev v6 1/2] eal: introduce rte_memeq_timingsafe() based on
 FreeBSD API
Date: Thu,  2 Oct 2025 15:32:28 +0000
Message-Id: <20251002153229.98158-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001153242.55987-1-kai.ji@intel.com>
References: <20251001153242.55987-1-kai.ji@intel.com>
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

Bugzilla ID: 1773
https://bugs.dpdk.org/show_bug.cgi?id=1773

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 lib/eal/include/rte_memory.h | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/eal/include/rte_memory.h b/lib/eal/include/rte_memory.h
index dcc0e69cfe..2d24e091af 100644
--- a/lib/eal/include/rte_memory.h
+++ b/lib/eal/include/rte_memory.h
@@ -746,6 +746,44 @@ __rte_experimental
 void
 rte_memzero_explicit(void *dst, size_t sz);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Timing-safe memory equality comparison.
+ *
+ * This function compares two memory regions in constant time, making it
+ * resistant to timing side-channel attacks. The execution time depends only
+ * on the length parameter, not on the actual data values being compared.
+ *
+ * This is particularly important for cryptographic operations where timing
+ * differences could leak information about secret keys, passwords, or other
+ * sensitive data.
+ *
+ * @param a
+ *   Pointer to the first memory region to compare
+ * @param b
+ *   Pointer to the second memory region to compare
+ * @param n
+ *   Number of bytes to compare
+ * @return
+ *   true if the memory regions are identical, false if they differ
+ */
+__rte_experimental
+static inline bool
+rte_memeq_timingsafe(const void *a, const void *b, size_t n)
+{
+	const volatile uint8_t *pa = (const volatile uint8_t *)a;
+	const volatile uint8_t *pb = (const volatile uint8_t *)b;
+	uint8_t result = 0;
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		result |= pa[i] ^ pb[i];
+
+	return result == UINT8_C(0);
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.34.1

