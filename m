Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA69C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:41:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A3BB40A6B;
	Thu,  7 Aug 2025 14:40:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id ED295406B7
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:40:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570408; x=1786106408;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JmhO0zB1ogJDah4IyPFLFVtuqbLcRvhJ2x4cvWdJGTo=;
 b=Wd96Uu7wEtQOxYXdsUvYMFHNZrRU7jbb151g1F02j9B2NPLyIbrqmNZH
 0wgAWGXi68Dv5LwNNGlDRGu6IgDp6QtieJbiw0/maAOSIlHVcmypSPbkY
 TwyP9Pjxxq32uFubNamuFLpn638Zsf6WW4GKq+1j6LKKYOXP86mVWXwRe
 6WunprszWwk2PDx7M2b2tuDCBaDUsP/Z8HEjNoDsRf11DlfezWKdG8+BK
 bWuuoz2eTcg607XpbsHsTI2FD4s2k14q7bUsk76cBiI7LG7DB9MUFh9pj
 TU1zxWhpiBgG2MLYItT+WBp1vUunJTky4lh8axHEgpp29dX6gAFi0lUzN Q==;
X-CSE-ConnectionGUID: tNpiZhkpT0mfKpZ9E5GfpQ==
X-CSE-MsgGUID: Fzj5vqbkQzKVfI6bFQVfmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981133"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981133"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:40:07 -0700
X-CSE-ConnectionGUID: iGRqPZzyTo+MNIyDylO6vg==
X-CSE-MsgGUID: wZJsfzrlReGcD9DPBXSbCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886772"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:40:07 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 12/15] net/intel: introduce infrastructure for Rx path
 selection
Date: Thu,  7 Aug 2025 12:39:46 +0000
Message-Id: <20250807123949.4063416-13-ciara.loftus@intel.com>
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
---
v2:
* renamed various items from "burst" to "path"
* added missing doxygen comments
* attempted to improve the logic in the select function around the bulk
 alloc feature

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx.h | 103 ++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 70b597e8dc..6d134622e6 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <rte_vect.h>
 
 #include "desc.h"
 
@@ -125,6 +126,26 @@ struct ci_rx_queue {
 	};
 };
 
+#define CI_RX_PATH_SCATTERED 1
+#define CI_RX_PATH_FLEX_DESC 1
+#define CI_RX_PATH_BULK_ALLOC 1
+#define CI_RX_PATH_DISABLED 1
+
+struct ci_rx_path_features {
+	uint32_t rx_offloads;
+	enum rte_vect_max_simd simd_width;
+	bool scattered;
+	bool flex_desc;
+	bool bulk_alloc;
+	bool disabled;
+};
+
+struct ci_rx_path_info {
+	eth_rx_burst_t pkt_burst;
+	const char *info;
+	struct ci_rx_path_features features;
+};
+
 static inline uint16_t
 ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs, uint8_t *split_flags,
 		struct rte_mbuf **pkt_first_seg, struct rte_mbuf **pkt_last_seg,
@@ -222,4 +243,86 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh, uint64_t offloads)
 	return true;
 }
 
+/**
+ * Select the best matching Rx path based on features
+ *
+ * @param req_features
+ *   The requested features for the Rx path
+ * @param infos
+ *   Array of information about the available Rx paths
+ * @param num_paths
+ *   Number of available paths in the infos array
+ * @param default_path
+ *   Index of the default path to use if no suitable path is found
+ *
+ * @return
+ *   The packet burst function index that best matches the requested features,
+ *   or default_path if no suitable path is found
+ */
+static inline int
+ci_rx_path_select(struct ci_rx_path_features req_features,
+			const struct ci_rx_path_info *infos,
+			int num_paths,
+			int default_path)
+{
+	int i, idx = -1;
+	const struct ci_rx_path_features *current_features = NULL;
+
+	for (i = 0; i < num_paths; i++) {
+		const struct ci_rx_path_features *path_features = &infos[i].features;
+
+		/* Do not select a disabled rx path. */
+		if (path_features->disabled)
+			continue;
+
+		/* If requested, ensure the path uses the flexible descriptor. */
+		if (path_features->flex_desc != req_features.flex_desc)
+			continue;
+
+		/* If requested, ensure the path supports scattered RX. */
+		if (path_features->scattered != req_features.scattered)
+			continue;
+
+		/* Do not use a bulk alloc path if not requested. */
+		if (path_features->bulk_alloc && !req_features.bulk_alloc)
+			continue;
+
+		/* Ensure the path supports the requested RX offloads. */
+		if ((path_features->rx_offloads & req_features.rx_offloads) !=
+				req_features.rx_offloads)
+			continue;
+
+		/* Ensure the path's SIMD width is compatible with the requested width. */
+		if (path_features->simd_width > req_features.simd_width)
+			continue;
+
+		/* Do not select the path if it is less suitable than the current path. */
+		if (current_features != NULL) {
+			/* Do not select paths with lower SIMD width than the current path. */
+			if (path_features->simd_width < current_features->simd_width)
+				continue;
+			/* Do not select paths with more offloads enabled than the current path. */
+			if (rte_popcount32(path_features->rx_offloads) >
+					rte_popcount32(current_features->rx_offloads))
+				continue;
+			/* Do not select paths without bulk alloc support if requested and the
+			 * current path already meets this requirement.
+			 */
+			if (!path_features->bulk_alloc && req_features.bulk_alloc &&
+					current_features->bulk_alloc)
+				continue;
+		}
+
+		/* Finally, select the path since it has met all the requirements. */
+		idx = i;
+		current_features = &infos[idx].features;
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

