Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E41CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:32:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B88A40A80;
	Wed,  1 Oct 2025 17:32:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8D50A402E7
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:32:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759332769; x=1790868769;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/9cYMy42AHAa0zoHyFDbJANCn3rPzoyn4muxrvDW0YI=;
 b=kk0zf8xKFLECqNXNIOR5Ad20YRVUfi4aVca9dbahjz+j481X6g34FFs6
 DSIbf8lXBmAOLrJIaJbK7H5xx0rS9Ibln7njrEn06bWT76WV7tngOPDtL
 eVVz2sU/XSevnVjs34RiC54cclNycF3Jdgfv2IXoFTitFT6+/y7eiQNq7
 iM670ITih3YflD0NbwS8sSCsvBoSr6WltU19W94z6qr5HYjhTU9/SprgJ
 3bMLEP0Khmj0ryvD5oMNyKqDs03eCWADM3+Rq3XGuh/vZHeJ6FfxvdnAq
 icyImxLd5Ink4ItrlqYtB675FXpmAUxB6lotO0RWGXEUYCnIdGE2GlS03 A==;
X-CSE-ConnectionGUID: KPYjLgsaQfqj80CSncc2Aw==
X-CSE-MsgGUID: yMDQtYw2SoeC+ouXnVld0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61648702"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; d="scan'208";a="61648702"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 08:32:47 -0700
X-CSE-ConnectionGUID: mq5griZ0R/KkjBJNSlWqeQ==
X-CSE-MsgGUID: 7g143gwoRGC3t1D8ud3A8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; d="scan'208";a="215939831"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by orviesa001.jf.intel.com with ESMTP; 01 Oct 2025 08:32:46 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Kai Ji <kai.ji@intel.com>
Subject: [dpdk-dev v5 1/2] eal: introduce rte_timingsafe_memcmp() based on
 OpenBSD API
Date: Wed,  1 Oct 2025 15:32:41 +0000
Message-Id: <20251001153242.55987-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929145049.153078-1-kai.ji@intel.com>
References: <20250929145049.153078-1-kai.ji@intel.com>
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
index dcc0e69cfe..6939c1caad 100644
--- a/lib/eal/include/rte_memory.h
+++ b/lib/eal/include/rte_memory.h
@@ -746,6 +746,44 @@ __rte_experimental
 void
 rte_memzero_explicit(void *dst, size_t sz);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Constant-time memory comparison.
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
+ *   0 if the memory regions are identical, non-zero if they differ
+ */
+__rte_experimental
+static inline int
+rte_timingsafe_memcmp(const void *a, const void *b, size_t n)
+{
+	const volatile uint8_t *pa = (const volatile uint8_t *)a;
+	const volatile uint8_t *pb = (const volatile uint8_t *)b;
+	uint8_t result = 0;
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		result |= pa[i] ^ pb[i];
+
+	return result;
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.34.1

