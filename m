Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9456CD5BBC
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 10:30:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D11ED40B9D;
	Thu, 13 Nov 2025 11:30:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id EF1EA40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 11:30:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763029842; x=1794565842;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=u2onzjcjnScFkOtT+h5/0W9oAh1068A0wQEc1BxyTl4=;
 b=SR4KNbY7adVjmyJGgyb7X1Q8rC1iVDCPifwIZuNTmdmx0n5mbybfAO/W
 4zl70SO6u8JZcAMS590WnsAXBMY645Qbc47IKu0N20qDASm1cg/QZQFB1
 zZyvkY24iVrfHBs/5gNC+dyVHNz6wGlvXfQLNPbpEu3VF/SgseA/SPXIQ
 ANBKWn5ijRNDsGZ3YueXOiS4t13wo9zKH+tnX6IdtbgHmgDexy4WgkKnE
 F2yRKJBEDXEtAuRN6t16fr8ffayAV4KBP4liNyPAE9thIUKGewxmkdhc1
 9jgC8r1giOhzpSsJ7KKiW840F+z9rybD5i+d2cFbk3bHCh8MLcgIBFfAY Q==;
X-CSE-ConnectionGUID: Zhs762dXQwiqRQE/ll2pEQ==
X-CSE-MsgGUID: xtkoVe39TzyA5YTjSHrpzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82503156"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="82503156"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 02:30:41 -0800
X-CSE-ConnectionGUID: jIph8I1oTr+Y7CcL1T6/Dg==
X-CSE-MsgGUID: 7vyO9Nr7Rqu/kBZFrhNHHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="194637130"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa005.jf.intel.com with ESMTP; 13 Nov 2025 02:30:40 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] net/intel: rename variable in Rx select to improve clarity
Date: Thu, 13 Nov 2025 10:30:12 +0000
Message-Id: <20251113103012.3782264-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

The common rx path selection function contains logic that compares two
rx paths:
1. the path selected as most suitable so far aka "current path"
2. a candidate path that has not yet been selected aka "path"

This naming could cause confusion, as the candidate path could also be
considered the "current path". To rectify this, rename "current path" to
"chosen path".

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 9fa3cdc64d..ea7fb98b47 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -261,7 +261,7 @@ ci_rx_path_select(struct ci_rx_path_features req_features,
 			int default_path)
 {
 	int i, idx = default_path;
-	const struct ci_rx_path_features *current_features = NULL;
+	const struct ci_rx_path_features *chosen_path_features = NULL;
 
 	for (i = 0; i < num_paths; i++) {
 		const struct ci_rx_path_features *path_features = &infos[i].features;
@@ -295,29 +295,29 @@ ci_rx_path_select(struct ci_rx_path_features req_features,
 		if (path_features->simd_width > req_features.simd_width)
 			continue;
 
-		/* Do not select the path if it is less suitable than the current path. */
-		if (current_features != NULL) {
-			/* Do not select paths with lower SIMD width than the current path. */
-			if (path_features->simd_width < current_features->simd_width)
+		/* Do not select the path if it is less suitable than the chosen path. */
+		if (chosen_path_features != NULL) {
+			/* Do not select paths with lower SIMD width than the chosen path. */
+			if (path_features->simd_width < chosen_path_features->simd_width)
 				continue;
-			/* Do not select paths with more offloads enabled than the current path if
+			/* Do not select paths with more offloads enabled than the chosen path if
 			 * the SIMD widths are the same.
 			 */
-			if (path_features->simd_width == current_features->simd_width &&
+			if (path_features->simd_width == chosen_path_features->simd_width &&
 					rte_popcount32(path_features->rx_offloads) >
-					rte_popcount32(current_features->rx_offloads))
+					rte_popcount32(chosen_path_features->rx_offloads))
 				continue;
 			/* Do not select paths without bulk alloc support if requested and the
-			 * current path already meets this requirement.
+			 * chosen path already meets this requirement.
 			 */
 			if (!path_features->extra.bulk_alloc && req_features.extra.bulk_alloc &&
-					current_features->extra.bulk_alloc)
+					chosen_path_features->extra.bulk_alloc)
 				continue;
 		}
 
 		/* Finally, select the path since it has met all the requirements. */
 		idx = i;
-		current_features = &infos[idx].features;
+		chosen_path_features = &infos[idx].features;
 	}
 
 	return idx;
-- 
2.34.1

