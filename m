Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9BCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 16:02:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2310240677;
	Fri, 26 Sep 2025 18:02:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id A769B40262
 for <dev@dpdk.org>; Fri, 26 Sep 2025 18:02:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758902535; x=1790438535;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xCgtJP+TgmiadoTweEZI0P0YvKEMUN+uwpGMSVZua6A=;
 b=Nl3mh61U/uv75cV8XW4AnkNqLGLKIaUwpzilFLYucKeuaNaYU4gAfLiz
 f/bRVjRwut7NRlPhXxivvCNVfhfvaRCbrTjuFrJ3GMBCTqG1iv2Y/P+Lk
 bAP9x7qE0hVgp2tDmU/8hCNdJQahwvW4kguMmi+8k7/xc5GDuUHgEQ4Rh
 zbaOebzwDYOmQHba+E4hk/BoEPEtcTZusm5xLvT1ViwmB5aaJLcHwQCSl
 p0plLnCVof78OXtz/GJtBp7ILtWpx/lYtAEzVLPPFEr1nbzVfE4wAb+js
 Tg7511Cr1t/tuQDguOkc8ooEdVefbXj2MxFrijhvm/EBxO0F2QHCAaEil w==;
X-CSE-ConnectionGUID: Oeyb5ksfQzmszcWzEjzxpg==
X-CSE-MsgGUID: MziQu/YHT7mHMcxLj27fGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="60938860"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="60938860"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 09:02:14 -0700
X-CSE-ConnectionGUID: /1CGv5Y1Qd2jMoXU2Jdy6A==
X-CSE-MsgGUID: s4kdcYyRTDKYpgReSycfqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="178405688"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by fmviesa010.fm.intel.com with ESMTP; 26 Sep 2025 09:02:12 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net,
 stephen@networkplumber.org, Kai Ji <kai.ji@intel.com>
Subject: [dpdk-dev v3 1/2] eal: Add rte_consttime_memneq() to prevent timing
 attacks memcmp.
Date: Fri, 26 Sep 2025 16:02:08 +0000
Message-Id: <20250926160209.56496-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926154905.54416-1-kai.ji@intel.com>
References: <20250926154905.54416-1-kai.ji@intel.com>
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
 lib/eal/include/rte_common.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 9e7d84f929..ddbba083be 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -700,6 +700,40 @@ rte_is_aligned(const void * const __rte_restrict ptr, const unsigned int align)
 	return ((uintptr_t)ptr & (align - 1)) == 0;
 }
 
+/**
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
+static inline bool
+rte_consttime_memneq(const void *a, const void *b, size_t n)
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
 /*********** Macros for compile type checks ********/
 
 /* Workaround for toolchain issues with missing C11 macro in FreeBSD */
-- 
2.34.1

