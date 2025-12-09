Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B127D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:27:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 118A340A6D;
	Tue,  9 Dec 2025 12:27:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 84E424025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:27:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279628; x=1796815628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eMH1XniOu7k42UMyIsFFL4vF8frP9dRcHKw4zAoB/so=;
 b=nPCmSUSOCGQWUQ5boYoYJjBZOkTQofsQxeMJEhx/RnivOx6bS1N9Elx4
 WNQuyjDj/LIlBSdMvG9IDfsNlUswcORHS5YbyYKdkosmzDYdcYfu3Xk3P
 hA92SVR4M3LNfO3HXKT689SOVfYfsziuHXjcJ3Dz+hI9/GoZDZZ7VV2Qk
 9NhwmhOPtvbGfaeRdaDIFev7A3NJiYbIlfME9QfV7PbQtuCg/45KcwElX
 oyXwtz1h9So29qFA2BwAwfqRdMz75WDDkdoTtrMGm1WqPWCveyBzdNCHY
 2PZTp+detUKi2wxalLXWxfo7pUBGN7yeWSPjrLsGtXVm1sBak5ECxVLqr A==;
X-CSE-ConnectionGUID: sUuVfxJoQhai9MEL1nCD6g==
X-CSE-MsgGUID: JQYdeXlJScWSNfjKNVy78g==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117025"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117025"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:07 -0800
X-CSE-ConnectionGUID: TgqHdMw1TK6S9vFv/V4pag==
X-CSE-MsgGUID: uiICaChWSqalMEjKWogZrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270167"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:06 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 01/13] net/intel: introduce infrastructure for Tx path
 selection
Date: Tue,  9 Dec 2025 11:26:40 +0000
Message-ID: <20251209112652.963981-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209112652.963981-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
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

The code for determining which Tx path to select during initialisation
has become complicated in many intel drivers due to the amount of
different paths and features available within each path. This commit
aims to simplify and genericize the path selection logic.

The following information about each Tx burst function is stored and
used by the new common function to select the appropriate Tx path:
- Tx Offloads
- SIMD bitwidth

The implementation is based off the Rx path selection infrastructure
introduced in a previous commit.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx.h | 71 +++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 5af64a4cfe..c6c1904ba3 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -8,6 +8,7 @@
 #include <stdint.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <rte_vect.h>
 
 /* forward declaration of the common intel (ci) queue structure */
 struct ci_tx_queue;
@@ -117,6 +118,17 @@ struct ci_tx_queue {
 	};
 };
 
+struct ci_tx_path_features {
+	uint32_t tx_offloads;
+	enum rte_vect_max_simd simd_width;
+};
+
+struct ci_tx_path_info {
+	eth_tx_burst_t pkt_burst;
+	const char *info;
+	struct ci_tx_path_features features;
+};
+
 static __rte_always_inline void
 ci_tx_backlog_entry(struct ci_tx_entry *txep, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
@@ -262,4 +274,63 @@ ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
 	memset(txq->sw_ring_vec, 0, sizeof(txq->sw_ring_vec[0]) * nb_desc);
 }
 
+/**
+ * Select the best matching Tx path based on features
+ *
+ * @param req_features
+ *   The requested features for the Tx path
+ * @param infos
+ *   Array of information about the available Tx paths
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
+ci_tx_path_select(struct ci_tx_path_features req_features,
+			const struct ci_tx_path_info *infos,
+			int num_paths,
+			int default_path)
+{
+	int i, idx = default_path;
+	const struct ci_tx_path_features *chosen_path_features = NULL;
+
+	for (i = 0; i < num_paths; i++) {
+		const struct ci_tx_path_features *path_features = &infos[i].features;
+
+		/* Ensure the path supports the requested TX offloads. */
+		if ((path_features->tx_offloads & req_features.tx_offloads) !=
+				req_features.tx_offloads)
+			continue;
+
+		/* Ensure the path's SIMD width is compatible with the requested width. */
+		if (path_features->simd_width > req_features.simd_width)
+			continue;
+
+		/* Do not select the path if it is less suitable than the chosen path. */
+		if (chosen_path_features != NULL) {
+			/* Do not select paths with lower SIMD width than the chosen path. */
+			if (path_features->simd_width < chosen_path_features->simd_width)
+				continue;
+			/* Do not select paths with more offloads enabled than the chosen path if
+			 * the SIMD widths are the same.
+			 */
+			if (path_features->simd_width == chosen_path_features->simd_width &&
+					rte_popcount32(path_features->tx_offloads) >
+					rte_popcount32(chosen_path_features->tx_offloads))
+				continue;
+		}
+
+		/* Finally, select the path since it has met all the requirements. */
+		idx = i;
+		chosen_path_features = &infos[idx].features;
+	}
+
+	return idx;
+}
+
 #endif /* _COMMON_INTEL_TX_H_ */
-- 
2.43.0

