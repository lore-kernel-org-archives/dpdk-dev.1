Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7B3C87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 12:50:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 218874065E;
	Fri, 25 Jul 2025 14:50:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 73E26400D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 14:50:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753447811; x=1784983811;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i7sK58R06PnhYlh9YRQgaqabkNTctfbajraVb9R9w3E=;
 b=HKqewuBaZppNjYqGYKVYHcNpIC7IgL7+1rDfk3Yc2XwjKyu2oNgxqMj5
 vMHr8cG7Dk35kDEJqNLZFXo7nbo7jtYR8/fTe9CNqOhqZ+z68EPUnx4lw
 45o9dYttQif5UhN0RR9QtPIpu3Fd95BSjYc68zyLfbm2kkn4l7YHUnlrh
 yMmIJZ6Bl8dn+WyTH3uRzY44xrBAH1LInoljuHRNcKYh6RBISPpx9h43g
 U3sUbBL8jLwNyZJYljNoTrnO5qU5udr8kxsXdOgarZTLDdBrHvRjaiSbH
 n0GkjZSrlsiDgjJNt6iCkmle+kAusX+cWnRUAscYWJeJBRe7bygZ+gAkZ g==;
X-CSE-ConnectionGUID: +VtGK21HSbiiIvi0a/NPSg==
X-CSE-MsgGUID: gHUWNOmUQHKs53bOb3RiuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66480147"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66480147"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 05:50:11 -0700
X-CSE-ConnectionGUID: dcynbCy5Rt2jSMDvnW0e6Q==
X-CSE-MsgGUID: IJn9yrTVR9irktgaOG3UVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="161152296"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa007.jf.intel.com with ESMTP; 25 Jul 2025 05:50:10 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 05/14] net/intel: introduce common vector capability
 function
Date: Fri, 25 Jul 2025 12:49:10 +0000
Message-Id: <20250725124919.3564890-6-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725124919.3564890-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
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

From: Bruce Richardson <bruce.richardson@intel.com>

A common need within the drivers is to select between SSE, AVX2 and
AVX-512 code paths. Provide a common function which helps with this
decision making, that returns the max simd bandwidth based on any
user configured maximums and available CPU flags.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx_vec_x86.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
index 3d7343b1ff..314fa24b41 100644
--- a/drivers/net/intel/common/rx_vec_x86.h
+++ b/drivers/net/intel/common/rx_vec_x86.h
@@ -346,4 +346,27 @@ ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)
 	rte_write32_wc(rte_cpu_to_le_32(rx_id), rxq->qrx_tail);
 }
 
+#ifdef CC_AVX512_SUPPORT
+#define X86_MAX_SIMD_BITWIDTH (rte_vect_get_max_simd_bitwidth())
+#else
+#define X86_MAX_SIMD_BITWIDTH RTE_MIN(256, rte_vect_get_max_simd_bitwidth())
+#endif /* CC_AVX512_SUPPORT */
+
+static inline enum rte_vect_max_simd
+ci_get_x86_max_simd_bitwidth(void)
+{
+	int ret = RTE_VECT_SIMD_DISABLED;
+	int simd = X86_MAX_SIMD_BITWIDTH;
+
+	if (simd >= 512 && rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
+			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
+		ret = RTE_VECT_SIMD_512;
+	else if (simd >= 256 && (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
+			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1))
+		ret = RTE_VECT_SIMD_256;
+	else if (simd >= 128)
+		ret = RTE_VECT_SIMD_128;
+	return ret;
+}
+
 #endif /* _COMMON_INTEL_RX_VEC_X86_H_ */
-- 
2.34.1

