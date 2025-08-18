Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2B3CA0EC6
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 11:00:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74C64406BB;
	Mon, 18 Aug 2025 12:59:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id C720840695
 for <dev@dpdk.org>; Mon, 18 Aug 2025 12:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755514786; x=1787050786;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Jp2yaHvVW+Vuo53GUtjZHSdFYUffXvDINYeAeR0wik=;
 b=QIhJCIOc5k2ypOWJSEmb3d5FhNSozPzmGks9ihEhB5lvo6Ju6XmcF5et
 PhHgqLaRS7EKkuZT/7oCPqwSE808k5oySG6PdkgJXhioPo+pgo54Ta81s
 dAlbF4k/MAZeUAO8ksO+l9h6OnevkVDxPyje/T2rJRLdClBHyFaRTUUIN
 F5DTd+fZAPBpJ9FOoLE7OX90/LYABnWql7B7z7YdnRuhMAKdrhpkk2vRa
 4oKKOR5j0TDguphgOnnzGr1gYberwHxyKVFVNKRcGDl98+vLkW36CDp17
 2dRwrlm+iQrOb8MH1AIB2ttd32RzRs42IJYJxD6o7YfZSjyKdjt6Qx1je Q==;
X-CSE-ConnectionGUID: 5PoydoMBQw6avczMwd2rOw==
X-CSE-MsgGUID: hWv+pDMgQ+aStKAi0eArXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="83165439"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="83165439"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 03:59:45 -0700
X-CSE-ConnectionGUID: wrwMz+PZSxOvGRV6bKdz4A==
X-CSE-MsgGUID: xsly09pRQ4Kl1jCT7o5hdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="166723005"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa006.jf.intel.com with ESMTP; 18 Aug 2025 03:59:43 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 12/15] net/intel: introduce infrastructure for Rx path
 selection
Date: Mon, 18 Aug 2025 10:59:11 +0000
Message-Id: <20250818105914.169732-13-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818105914.169732-1-ciara.loftus@intel.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v3:
* remove unnecessary initialisation in the path select function
* remove defines for features
* define new sub structure within features structure
---
 drivers/net/intel/common/rx.h | 98 +++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 70b597e8dc..770284f7ab 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <rte_vect.h>
 
 #include "desc.h"
 
@@ -125,6 +126,25 @@ struct ci_rx_queue {
 	};
 };
 
+struct ci_rx_path_features_extra {
+	bool scattered;
+	bool flex_desc;
+	bool bulk_alloc;
+	bool disabled;
+};
+
+struct ci_rx_path_features {
+	uint32_t rx_offloads;
+	enum rte_vect_max_simd simd_width;
+	struct ci_rx_path_features_extra extra;
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
@@ -222,4 +242,82 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh, uint64_t offloads)
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
+	int i, idx = default_path;
+	const struct ci_rx_path_features *current_features = NULL;
+
+	for (i = 0; i < num_paths; i++) {
+		const struct ci_rx_path_features *path_features = &infos[i].features;
+
+		/* Do not select a disabled rx path. */
+		if (path_features->extra.disabled)
+			continue;
+
+		/* If requested, ensure the path uses the flexible descriptor. */
+		if (path_features->extra.flex_desc != req_features.extra.flex_desc)
+			continue;
+
+		/* If requested, ensure the path supports scattered RX. */
+		if (path_features->extra.scattered != req_features.extra.scattered)
+			continue;
+
+		/* Do not use a bulk alloc path if not requested. */
+		if (path_features->extra.bulk_alloc && !req_features.extra.bulk_alloc)
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
+			if (!path_features->extra.bulk_alloc && req_features.extra.bulk_alloc &&
+					current_features->extra.bulk_alloc)
+				continue;
+		}
+
+		/* Finally, select the path since it has met all the requirements. */
+		idx = i;
+		current_features = &infos[idx].features;
+	}
+
+	return idx;
+}
+
 #endif /* _COMMON_INTEL_RX_H_ */
-- 
2.34.1

