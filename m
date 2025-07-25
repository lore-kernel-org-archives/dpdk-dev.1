Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0B5C87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 12:51:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 952094067E;
	Fri, 25 Jul 2025 14:50:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 596974064E
 for <dev@dpdk.org>; Fri, 25 Jul 2025 14:50:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753447816; x=1784983816;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AfljH2ur/oliS68LxYCsNV1NrIWe8U31oFH2I6I99v8=;
 b=JSwDmaRTauShg/s5Mvg1galZBJXdOdaiXfYgGk/GnGl9bhsNcbrjMRrT
 uCQFTZM4mLNeylBgvA+hxSl9UOQyNwWpaKYNJk5AeqBal8mLif2EP0TdW
 mDpmMTDXuUIFVjGHw8BBdOsW9tQCHulKnypA+jCYUSspHPjZdELQoPfWM
 1vLgGt9rpxXzwulNRXzdKJP7+zKXTnxLaVUHifBrwmj0TXSY/JddxRjaM
 o2aqFRtVxnB+wJyszswA/mFThKDdnY3bIxZrAiIHkbPIfA6IgBuJ3TJ/7
 YokOL7IQs2FfzNDzScarRG0J0mSPflhLog/SlLdaKVjdyOGO/xM5bAMQF A==;
X-CSE-ConnectionGUID: RLHj5QAvThKzE/53gHL5yw==
X-CSE-MsgGUID: Q/jfWomjTz6kHP/nlZLpTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66480158"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66480158"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 05:50:16 -0700
X-CSE-ConnectionGUID: 8MDQtvo+RcakCio6LUDpwg==
X-CSE-MsgGUID: JNSkvIjXTVytmASB5kMooQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="161152334"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa007.jf.intel.com with ESMTP; 25 Jul 2025 05:50:15 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 10/14] net/intel: introduce infrastructure for Rx path
 selection
Date: Fri, 25 Jul 2025 12:49:15 +0000
Message-Id: <20250725124919.3564890-11-ciara.loftus@intel.com>
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

The code for determining which Rx path to select during initialisation
has become complicated in many intel drivers due to the amount of
different paths and features available within each path. This commit
aims to simplify and genericize the path selection logic.

The following information about each Rx burst function is stored and
used by the new common function to select the appropriate Rx path:
- Rx Offloads
- SIMD bitwidth
- Flexible RXD usage
- Bulk alloc function
- Scattered function

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx.h | 110 ++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 70b597e8dc..6e9d81fecf 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <rte_vect.h>
 
 #include "desc.h"
 
@@ -20,6 +21,12 @@
 #define CI_VPMD_DESCS_PER_LOOP_WIDE 8
 #define CI_VPMD_RX_REARM_THRESH     64
 
+#define CI_RX_BURST_NO_FEATURES		0
+#define CI_RX_BURST_FEATURE_SCATTERED	RTE_BIT32(0)
+#define CI_RX_BURST_FEATURE_FLEX	RTE_BIT32(1)
+#define CI_RX_BURST_FEATURE_BULK_ALLOC	RTE_BIT32(2)
+#define CI_RX_BURST_FEATURE_IS_DISABLED	RTE_BIT32(3)
+
 struct ci_rx_queue;
 
 struct ci_rx_entry {
@@ -125,6 +132,19 @@ struct ci_rx_queue {
 	};
 };
 
+
+struct ci_rx_burst_features {
+	uint32_t rx_offloads;
+	enum rte_vect_max_simd simd_width;
+	uint32_t other_features_mask;
+};
+
+struct ci_rx_burst_info {
+	eth_rx_burst_t pkt_burst;
+	const char *info;
+	struct ci_rx_burst_features features;
+};
+
 static inline uint16_t
 ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs, uint8_t *split_flags,
 		struct rte_mbuf **pkt_first_seg, struct rte_mbuf **pkt_last_seg,
@@ -222,4 +242,94 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh, uint64_t offloads)
 	return true;
 }
 
+/**
+ * Select the best matching Rx burst mode function based on features
+ *
+ * @param req_features
+ *   The requested features for the Rx burst mode
+ *
+ * @return
+ *   The packet burst function index that best matches the requested features
+ */
+static inline int
+ci_rx_burst_mode_select(const struct ci_rx_burst_info *infos,
+			struct ci_rx_burst_features req_features,
+			int num_paths,
+			int default_path)
+{
+	int i, idx = -1;
+	const struct ci_rx_burst_features *info_features;
+	bool req_flex = req_features.other_features_mask & CI_RX_BURST_FEATURE_FLEX;
+	bool req_scattered = req_features.other_features_mask & CI_RX_BURST_FEATURE_SCATTERED;
+	bool req_bulk_alloc = req_features.other_features_mask & CI_RX_BURST_FEATURE_BULK_ALLOC;
+	bool info_flex, info_scattered, info_bulk_alloc;
+
+	for (i = 0; i < num_paths; i++) {
+		info_features =  &infos[i].features;
+
+		/* Do not select a disabled rx burst function. */
+		if (info_features->other_features_mask & CI_RX_BURST_FEATURE_IS_DISABLED)
+			continue;
+
+		/* If requested, ensure the function uses the flexible descriptor. */
+		info_flex = info_features->other_features_mask & CI_RX_BURST_FEATURE_FLEX;
+		if (info_flex != req_flex)
+			continue;
+
+		/* If requested, ensure the function supports scattered RX. */
+		info_scattered = info_features->other_features_mask & CI_RX_BURST_FEATURE_SCATTERED;
+		if (info_scattered != req_scattered)
+			continue;
+
+		/* Do not use a bulk alloc function if not requested. However if it is the only
+		 * feature requested, ensure it is supported in the selected function.
+		 */
+		info_bulk_alloc =
+			info_features->other_features_mask & CI_RX_BURST_FEATURE_BULK_ALLOC;
+		if ((info_bulk_alloc && !req_bulk_alloc) ||
+				(req_features.other_features_mask ==
+						CI_RX_BURST_FEATURE_BULK_ALLOC &&
+						!info_bulk_alloc))
+			continue;
+
+		/* Ensure the function supports the requested RX offloads. */
+		if ((info_features->rx_offloads & req_features.rx_offloads) !=
+				req_features.rx_offloads)
+			continue;
+
+		/* Ensure the function's SIMD width is compatible with the requested width. */
+		if (info_features->simd_width > req_features.simd_width)
+			continue;
+
+		/* If this is the first valid path found, select it. */
+		if (idx == -1) {
+			idx = i;
+			continue;
+		}
+
+		/* At this point, at least one path has already been found that has met the
+		 * requested criteria. Analyse the current path and select it if it is
+		 * better than the previously selected one. i.e. if it has a larger SIMD width or
+		 * if it has the same SIMD width but fewer offloads enabled.
+		 */
+
+		if (info_features->simd_width > infos[idx].features.simd_width) {
+			idx = i;
+			continue;
+		}
+
+		/* Use the path with the least offloads that satisfies the requested offloads. */
+		if (info_features->simd_width == infos[idx].features.simd_width &&
+				(rte_popcount32(info_features->rx_offloads) <
+					rte_popcount32(infos[idx].features.rx_offloads)))
+			idx = i;
+	}
+
+	/* No path was found so use the default. */
+	if (idx == -1)
+		return default_path;
+
+	return idx;
+}
+
 #endif /* _COMMON_INTEL_RX_H_ */
-- 
2.34.1

