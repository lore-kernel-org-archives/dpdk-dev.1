Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF741D2F325
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:16:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82C4C40684;
	Tue, 13 Jan 2026 16:15:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 55AC64065B
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317323; x=1799853323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HWxtGXB9qMKTWAtETB8irXkBClXvJjSusfGVTymRb1U=;
 b=O5jhPfQBpNjfi8rfy7LeMgI9TsF2XjiuGfSLcSkWVxkfSrpSVvuJsnWN
 tnK9FCQFQRzt5XLgrRRj7Jc1/gjkBmSj63BRqBf0RBqRr+wU9SC7rl5XT
 /LsDQ/gnhwqyIZd0dFzJU30AWVswiedvdfcirkAlvsHX/WlDvGKlEsz6s
 OVKw/adoZxzZCSWmZ8x/NOakSZPQcp+4/huWdDGnoSc5fX+sgT0gixP8k
 /6aT1BLbKKgidNzh8xR3yiWpZV8oaJ8/N4mXb0+QzyUmWNbK7BVS1Aoqi
 QpZhVnzr9CebRGvlvA0mhO3ot5FWHKe/TuO5lmMnuWPtOKDzZv8mSSNH3 Q==;
X-CSE-ConnectionGUID: VktJ4cn9RPKDWOYNqgwF9w==
X-CSE-MsgGUID: Su8X9UnnQLu55r11ego9EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969140"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969140"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:22 -0800
X-CSE-ConnectionGUID: G/qAsH0iRkan7FILF7M0TQ==
X-CSE-MsgGUID: 5kxcQIfYSyaBavcLphDaWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556551"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:21 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 05/36] net/intel: create separate header for Tx scalar fns
Date: Tue, 13 Jan 2026 15:14:29 +0000
Message-ID: <20260113151505.1871271-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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

Rather than having all Tx code in the one file, which could start
getting rather long, move the scalar datapath functions to a new header
file.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h            | 58 ++------------------
 drivers/net/intel/common/tx_scalar_fns.h | 67 ++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 53 deletions(-)
 create mode 100644 drivers/net/intel/common/tx_scalar_fns.h

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 3d3d9ad8e3..320ab0b8e0 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -309,59 +309,6 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq, ci_desc_done_fn desc_done, bool ctx
 	return txq->tx_rs_thresh;
 }
 
-/*
- * Common transmit descriptor cleanup function for Intel drivers.
- * Used by ice, i40e, iavf, and idpf drivers.
- *
- * Returns:
- *   0 on success
- *  -1 if cleanup cannot proceed (descriptors not yet processed by HW)
- */
-static __rte_always_inline int
-ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
-{
-	struct ci_tx_entry *sw_ring = txq->sw_ring;
-	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
-	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	uint16_t nb_tx_desc = txq->nb_tx_desc;
-	uint16_t desc_to_clean_to;
-	uint16_t nb_tx_to_clean;
-
-	/* Determine the last descriptor needing to be cleaned */
-	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
-	if (desc_to_clean_to >= nb_tx_desc)
-		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
-
-	/* Check to make sure the last descriptor to clean is done */
-	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
-
-	/* Check if descriptor is done - all drivers use 0xF as done value in bits 3:0 */
-	if ((txd[desc_to_clean_to].cmd_type_offset_bsz & rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
-			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE)) {
-		/* Descriptor not yet processed by hardware */
-		return -1;
-	}
-
-	/* Figure out how many descriptors will be cleaned */
-	if (last_desc_cleaned > desc_to_clean_to)
-		nb_tx_to_clean = (uint16_t)((nb_tx_desc - last_desc_cleaned) + desc_to_clean_to);
-	else
-		nb_tx_to_clean = (uint16_t)(desc_to_clean_to - last_desc_cleaned);
-
-	/* The last descriptor to clean is done, so that means all the
-	 * descriptors from the last descriptor that was cleaned
-	 * up to the last descriptor with the RS bit set
-	 * are done. Only reset the threshold descriptor.
-	 */
-	txd[desc_to_clean_to].cmd_type_offset_bsz = 0;
-
-	/* Update the txq to reflect the last descriptor that was cleaned */
-	txq->last_desc_cleaned = desc_to_clean_to;
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
-
-	return 0;
-}
-
 static inline void
 ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
 {
@@ -480,4 +427,9 @@ ci_tx_path_select(const struct ci_tx_path_features *req_features,
 	return idx;
 }
 
+/* include the scalar functions at the end, so they can use the common definitions.
+ * This is done so drivers can use all functions just by including tx.h
+ */
+#include "tx_scalar_fns.h"
+
 #endif /* _COMMON_INTEL_TX_H_ */
diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
new file mode 100644
index 0000000000..c79210d084
--- /dev/null
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_TX_SCALAR_FNS_H_
+#define _COMMON_INTEL_TX_SCALAR_FNS_H_
+
+#include <stdint.h>
+#include <rte_byteorder.h>
+
+/* depends on common Tx definitions. */
+#include "tx.h"
+
+/*
+ * Common transmit descriptor cleanup function for Intel drivers.
+ * Used by ice, i40e, iavf, and idpf drivers.
+ *
+ * Returns:
+ *   0 on success
+ *  -1 if cleanup cannot proceed (descriptors not yet processed by HW)
+ */
+static __rte_always_inline int
+ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
+{
+	struct ci_tx_entry *sw_ring = txq->sw_ring;
+	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
+	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
+	uint16_t nb_tx_desc = txq->nb_tx_desc;
+	uint16_t desc_to_clean_to;
+	uint16_t nb_tx_to_clean;
+
+	/* Determine the last descriptor needing to be cleaned */
+	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
+	if (desc_to_clean_to >= nb_tx_desc)
+		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
+
+	/* Check to make sure the last descriptor to clean is done */
+	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
+
+	/* Check if descriptor is done - all drivers use 0xF as done value in bits 3:0 */
+	if ((txd[desc_to_clean_to].cmd_type_offset_bsz & rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE)) {
+		/* Descriptor not yet processed by hardware */
+		return -1;
+	}
+
+	/* Figure out how many descriptors will be cleaned */
+	if (last_desc_cleaned > desc_to_clean_to)
+		nb_tx_to_clean = (uint16_t)((nb_tx_desc - last_desc_cleaned) + desc_to_clean_to);
+	else
+		nb_tx_to_clean = (uint16_t)(desc_to_clean_to - last_desc_cleaned);
+
+	/* The last descriptor to clean is done, so that means all the
+	 * descriptors from the last descriptor that was cleaned
+	 * up to the last descriptor with the RS bit set
+	 * are done. Only reset the threshold descriptor.
+	 */
+	txd[desc_to_clean_to].cmd_type_offset_bsz = 0;
+
+	/* Update the txq to reflect the last descriptor that was cleaned */
+	txq->last_desc_cleaned = desc_to_clean_to;
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
+
+	return 0;
+}
+
+#endif /* _COMMON_INTEL_TX_SCALAR_FNS_H_ */
-- 
2.51.0

