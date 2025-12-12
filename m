Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8FAD4417D
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 11:06:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E60D840A80;
	Fri, 12 Dec 2025 12:06:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 15621400D6
 for <dev@dpdk.org>; Fri, 12 Dec 2025 12:06:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765537598; x=1797073598;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eHNio8XZdSO+whsTgWOOqRrkYKknTzflzaX+zXhoCeA=;
 b=S9+Z1XA2df91t7K6QNd7DQkscaxlkYa3aJf6clM0TsL6W4hfN+6t3rUa
 6N2ME6H1jCE4wnxlz9aVNR5OUV9D7b/x6nHG6K7lhUqLd5pbYyz/jFK8e
 6i4R8hvjaKxRfvmmL0Mk7PG17i99bGMNXpElQvBLnB2LmUGIr0/ehI094
 +TfUJSqMSRm83hqMCuRnf8nZgP+jpoNduasUkuMhQxYzE1Upbfl7gG6k7
 QJSMX93qDCyYVGtgodXrwIyaew1BWbp24CMgVWIlRj3jqs/REihFBFrNH
 uIl0av5ZBfEjhQfcxawcPW7xepPiqRGdXU+mORzh16nJ/FomfjXxVRGDu Q==;
X-CSE-ConnectionGUID: kAOs7I7gQAmAEFGmtP6B5g==
X-CSE-MsgGUID: kkghh03DQLWytWaOVZrPuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67472046"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; d="scan'208";a="67472046"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 03:06:37 -0800
X-CSE-ConnectionGUID: WTZYEQP/Qp6F11OSJ6OIpw==
X-CSE-MsgGUID: X76fKR7ATMyqmIDgMy+Iqw==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 03:06:36 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 01/10] net/intel: introduce infrastructure for Tx path
 selection
Date: Fri, 12 Dec 2025 11:06:19 +0000
Message-ID: <20251212110628.1634703-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212110628.1634703-1-ciara.loftus@intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
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
- "Simple" Tx

The implementation is based off the Rx path selection infrastructure
introduced in a previous commit.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2:
* Change req_features to pointer instead of passing by value
* Change num_paths from int to size_t
* Change i from int to unsigned int and define it inside the for
statement.
* Remove ci_tx_path_features_extra substructure
* Add simple tx feature in this patch rather in a later patch when it
is first used by a driver.
---
 drivers/net/intel/common/tx.h | 77 +++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 5af64a4cfe..04d9aa8473 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -8,6 +8,7 @@
 #include <stdint.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <rte_vect.h>
 
 /* forward declaration of the common intel (ci) queue structure */
 struct ci_tx_queue;
@@ -117,6 +118,19 @@ struct ci_tx_queue {
 	};
 };
 
+struct ci_tx_path_features {
+	uint32_t tx_offloads;
+	enum rte_vect_max_simd simd_width;
+	bool simple_tx;
+};
+
+struct ci_tx_path_info {
+	eth_tx_burst_t pkt_burst;
+	const char *info;
+	struct ci_tx_path_features features;
+	eth_tx_prep_t pkt_prep;
+};
+
 static __rte_always_inline void
 ci_tx_backlog_entry(struct ci_tx_entry *txep, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
@@ -262,4 +276,67 @@ ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
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
+ci_tx_path_select(const struct ci_tx_path_features *req_features,
+			const struct ci_tx_path_info *infos,
+			size_t num_paths,
+			int default_path)
+{
+	int idx = default_path;
+	const struct ci_tx_path_features *chosen_path_features = NULL;
+
+	for (unsigned int i = 0; i < num_paths; i++) {
+		const struct ci_tx_path_features *path_features = &infos[i].features;
+
+		/* Do not use a simple tx path if not requested. */
+		if (path_features->simple_tx && !req_features->simple_tx)
+			continue;
+
+		/* Ensure the path supports the requested TX offloads. */
+		if ((path_features->tx_offloads & req_features->tx_offloads) !=
+				req_features->tx_offloads)
+			continue;
+
+		/* Ensure the path's SIMD width is compatible with the requested width. */
+		if (path_features->simd_width > req_features->simd_width)
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

