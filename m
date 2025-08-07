Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFAEC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:40:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0144240661;
	Thu,  7 Aug 2025 14:40:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4A6CC40652
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:40:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570400; x=1786106400;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YIO5T1kSHivtgkNnvepMN/twvmxbvTFn2TftFJclh1c=;
 b=hNahDmzufF/uLIR+l2lIlJp7IFbP6+FDwicQiGRvvjcKWvTaHhJdhtLy
 gLDzee0Cspq7PGq5Xrg+giUcAB469HnXzSS8isDfDWkQdR//9iGUH/Ngg
 MdFXpCa70NDmxkVLxbX6zDrdD2E+tnEkpz+B/YJsE10NvBPcvCVrkvpce
 SKoc+a/0xReqzM406eKWMgQoJOpW2xD/e8frLD3vILiHN6YRaC7wceuCe
 bxtr3HEvRBrizhlN6LWt9/goYQNuBmlnrPO5a/C4fvZ0Hd46OmmF7aLe2
 8WCguMgQD8r34ltqZ/zH7gVgZ2ConqzjWVf+e0r+4M6LOP5try6+/BmbL Q==;
X-CSE-ConnectionGUID: G/yqfoR5RRmT9+Tl54YXwA==
X-CSE-MsgGUID: GO508d8jSBKCJoGOqPaSRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981118"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981118"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:39:59 -0700
X-CSE-ConnectionGUID: T61+MtkISUSO69Ep+2I6tA==
X-CSE-MsgGUID: t3sGORAiT26eBc1KFFou4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886731"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:39:59 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 05/15] net/intel: introduce common vector capability
 function
Date: Thu,  7 Aug 2025 12:39:39 +0000
Message-Id: <20250807123949.4063416-6-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123949.4063416-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
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
v2:
* removed erronous check for RTE_CPUFLAG_AVX512F for AVX2 path
---
 drivers/net/intel/common/rx_vec_x86.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
index 3d7343b1ff..32dd5ce189 100644
--- a/drivers/net/intel/common/rx_vec_x86.h
+++ b/drivers/net/intel/common/rx_vec_x86.h
@@ -346,4 +346,26 @@ ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)
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
+	else if (simd >= 256 && (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1))
+		ret = RTE_VECT_SIMD_256;
+	else if (simd >= 128)
+		ret = RTE_VECT_SIMD_128;
+	return ret;
+}
+
 #endif /* _COMMON_INTEL_RX_VEC_X86_H_ */
-- 
2.34.1

