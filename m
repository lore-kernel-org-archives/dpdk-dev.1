Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BFECAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 14:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BA414066C;
	Mon, 29 Sep 2025 16:50:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id E11CC40289;
 Mon, 29 Sep 2025 16:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759157455; x=1790693455;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ipFJ7I5lJ9GcrBG8Ir+3WmzCKm51UCF/4GrYrlAGfLk=;
 b=GnDyV6p5S2xYYRwdEsY1HjIqM1M0yrzTOHmCEWjl4MggqydzKQcRXBAh
 8SpAOnLZSFYsP3U2152h+b3zBcxcTlJUsQuygJl98Q3eLl1HxOAT8PD4k
 TVZLz7VutgUuYAly+15b5JjT4eLVTH9G6sCNDXbZz3XfiFmLV7CIlVN5J
 GAQxySNJlj8mC84qxqb+t3eCaPfuleU0z9Vucw90R2B6QGKMjmUIs05qQ
 5Y4QjYSeYoAIQa3tOrr0+Er+3Jznq4SjPb3PykCSFPw4KPl/Omq19k6FV
 tAwIQN9jlt4RD9M4p41Qv9M+pMW/eZcTuJVoQ0GVCxfo5CHh789tW1Vp5 w==;
X-CSE-ConnectionGUID: RwX1/LhMQceAaujWW54ozQ==
X-CSE-MsgGUID: hrslE7RrSl6kXFieEgdYKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72078799"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="72078799"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 07:50:54 -0700
X-CSE-ConnectionGUID: 1SMh/gwkR9+agpdFc2Y46Q==
X-CSE-MsgGUID: qQiGH4aWS9imD3ySBEZrqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="177507194"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by orviesa010.jf.intel.com with ESMTP; 29 Sep 2025 07:50:52 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Kai Ji <kai.ji@intel.com>, stable@dpdk.org
Subject: [dpdk-dev v4 1/2] eal: Add mem equal and non-equal to prevent timing
 attacks memcmp.
Date: Mon, 29 Sep 2025 14:50:48 +0000
Message-Id: <20250929145049.153078-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926160209.56496-1-kai.ji@intel.com>
References: <20250926160209.56496-1-kai.ji@intel.com>
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
Cc: stable@dpdk.org

[0] https://bugs.dpdk.org/show_bug.cgi?id=1773

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 lib/eal/include/rte_memory.h | 68 ++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/lib/eal/include/rte_memory.h b/lib/eal/include/rte_memory.h
index dcc0e69cfe..bbdef8e939 100644
--- a/lib/eal/include/rte_memory.h
+++ b/lib/eal/include/rte_memory.h
@@ -746,6 +746,74 @@ __rte_experimental
 void
 rte_memzero_explicit(void *dst, size_t sz);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Constant-time memory inequality comparison.
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
+ *   false if the memory regions are identical, true if they differ
+ */
+__rte_experimental
+static inline bool
+rte_memneq_consttime(const void *a, const void *b, size_t n)
+{
+	const volatile uint8_t *pa = (const volatile uint8_t *)a;
+	const volatile uint8_t *pb = (const volatile uint8_t *)b;
+	uint8_t result = 0;
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		result |= pa[i] ^ pb[i];
+
+	return result != 0;
+}
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Constant-time memory equality comparison.
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
+rte_memeq_consttime(const void *a, const void *b, size_t n)
+{
+	return !rte_memneq_consttime(a, b, n);
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.34.1

