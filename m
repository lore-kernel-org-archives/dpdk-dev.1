Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B1ECCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:03:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7815640693;
	Fri, 16 Oct 2026 16:02:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 065C5402F0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:02:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792159348; x=1823695348;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=s6yuNRjhFCMP9ZgwMA0Rpxcw6GcfOqGpbufCIAno/tY=;
 b=LwydYb8zq1xCOPlBDuZVHIxMk7s5U3Dq/spp4k5W6EvDys9wvO3LeDC9
 3/hNPW04/uWlQxDSi5JnpOmMytTzwcb6GSWTwf4WwODAlIS6pxdJ8pxxE
 7Ief+HjvTS+xR7EzGCXAOqTaXG8sgKWqMk9/JZnhR/3Ti/j5BUhVHVw9J
 Jh5mu50Ac/Vd7l1fZ4LTbFpZw2GmXnWMb50Zq5GrgVBvKIi52ReqDi1mU
 CLF+pB5ibaytJso/otXgM/GLQgRS/jpW7i8cFhGngHo2Mo1elH9ZwoODr
 08Qp/fY5U1LB1fCWnA89lttbPs1hPgeR6sySnTjvSEqFcAxMjp6oMFyaW g==;
X-CSE-ConnectionGUID: btz0q1XfR7OsMip4m8jLvg==
X-CSE-MsgGUID: 1N6pjq8SS9myMjKehg/1yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1043676"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1043676"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 07:02:27 -0700
X-CSE-ConnectionGUID: K3MvgNBfRQidrYd+uT9owg==
X-CSE-MsgGUID: f8Z6O7PPQvmoIhy4khpcSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1951714"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 16 Oct 2026 07:02:27 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [27.03 RFC PATCH v1 7/8] lpm: use usage counters for ref counting
Date: Fri, 16 Oct 2026 15:02:14 +0100
Message-ID: <52dee006ce5bb25c428fbee4e092c939fcdfcb6c.1792159157.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792159157.git.anatoly.burakov@intel.com>
References: 
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

Use EAL usage counters instead of raw integers for ref counting.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/lpm/rte_lpm6.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/lpm/rte_lpm6.c b/lib/lpm/rte_lpm6.c
index e23c886766..3c927a8642 100644
--- a/lib/lpm/rte_lpm6.c
+++ b/lib/lpm/rte_lpm6.c
@@ -20,6 +20,7 @@
 #include <assert.h>
 #include <rte_jhash.h>
 #include <rte_tailq.h>
+#include <rte_usage_count.h>
 
 #include "rte_lpm6.h"
 #include "lpm_log.h"
@@ -87,7 +88,7 @@ struct rte_lpm_tbl8_hdr {
 	uint32_t owner_entry_ind; /**< index of the owner table entry where
 				    *  pointer to the tbl8 is stored
 				    */
-	uint32_t ref_cnt; /**< table reference counter */
+	rte_usage_count_t ref_cnt; /**< table reference counter */
 };
 
 /** LPM6 structure. */
@@ -676,7 +677,7 @@ add_step(struct rte_lpm6 *lpm, struct rte_lpm6_tbl_entry *tbl,
 
 		/* update tbl8 rule reference counter */
 		if (tbl_ind != TBL24_IND && is_new_rule)
-			lpm->tbl8_hdrs[tbl_ind].ref_cnt++;
+			rte_usage_count_claim(&lpm->tbl8_hdrs[tbl_ind].ref_cnt);
 
 		return 0;
 	}
@@ -717,7 +718,7 @@ add_step(struct rte_lpm6 *lpm, struct rte_lpm6_tbl_entry *tbl,
 
 			/* update the current table's reference counter */
 			if (tbl_ind != TBL24_IND)
-				lpm->tbl8_hdrs[tbl_ind].ref_cnt++;
+				rte_usage_count_claim(&lpm->tbl8_hdrs[tbl_ind].ref_cnt);
 		}
 		/*
 		 * If it's valid but not extended the rule that was stored
@@ -768,7 +769,7 @@ add_step(struct rte_lpm6 *lpm, struct rte_lpm6_tbl_entry *tbl,
 
 			/* update the current table's reference counter */
 			if (tbl_ind != TBL24_IND)
-				lpm->tbl8_hdrs[tbl_ind].ref_cnt++;
+				rte_usage_count_claim(&lpm->tbl8_hdrs[tbl_ind].ref_cnt);
 		}
 
 		*next_tbl_ind = tbl[entry_ind].lpm6_tbl8_gindex;
@@ -1231,7 +1232,7 @@ remove_tbl(struct rte_lpm6 *lpm, struct rte_lpm_tbl8_hdr *tbl_hdr,
 
 		struct rte_lpm_tbl8_hdr *owner_tbl_hdr =
 			&lpm->tbl8_hdrs[owner_tbl_ind];
-		if (--owner_tbl_hdr->ref_cnt == 0)
+		if (rte_usage_count_release(&owner_tbl_hdr->ref_cnt))
 			remove_tbl(lpm, owner_tbl_hdr, owner_tbl_ind, lsp_rule);
 	}
 
@@ -1306,7 +1307,7 @@ rte_lpm6_delete(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip, uint8_t de
 	 */
 	if (tbl_ind != TBL24_IND) {
 		struct rte_lpm_tbl8_hdr *tbl_hdr = &lpm->tbl8_hdrs[tbl_ind];
-		if (--tbl_hdr->ref_cnt == 0) {
+		if (rte_usage_count_release(&tbl_hdr->ref_cnt)) {
 			/* remove the table */
 			remove_tbl(lpm, tbl_hdr, tbl_ind, lsp_rule);
 			return 0;
-- 
2.52.0

