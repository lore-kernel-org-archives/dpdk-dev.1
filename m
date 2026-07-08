Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F30C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 17:18:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5139840279;
	Tue,  7 Jul 2026 19:18:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id E142540264;
 Tue,  7 Jul 2026 19:18:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783444730; x=1814980730;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Yd5xg4JaRdpvBV/rJOgs5mA6x7ryRfQKpSMGNKq+8XM=;
 b=bYeo7a2LgOAh2Pq/k3F/PM58HuVXpD6Aa61uaFPc8osbIsG6U57ADvnw
 gU3Zgw/kwyNbjKbpG2rqsE1MSV5tWxbw7uR1rFFk/ncR+taPnZMtm9P1c
 ltIpOoMXaGbkUmfpdc94olvilcLup7Dib/e05mhJgvSEiC2PNUp6WH0Kp
 sQIxMJl5NKdHZz2w/s7HKxJqo6MuPcxcI8jJvtSI33U3Cx5MvYmwhOoD1
 H9theFd2JmAl6Hb6yNer1vyKHy9HJ2NwXeMQcFiGFn0KfWuF62Tv5tYxk
 ICQkU+BYujVjMd5EGTTpCyymiPWSABAc/hd2AQOVT09/Fqq+k1g5o7vMj Q==;
X-CSE-ConnectionGUID: GeblJUpsQdi4d4VKvEJJRQ==
X-CSE-MsgGUID: AnuB2m8OR2iGItK5sqyQVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="87781495"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="87781495"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 10:18:43 -0700
X-CSE-ConnectionGUID: AC4Y3thuTEC5SJ5evq2q3g==
X-CSE-MsgGUID: F5Z/LD6GQyKdTWet9uta+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="253566654"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by orviesa008.jf.intel.com with ESMTP; 07 Jul 2026 10:18:43 -0700
From: sandeep.penigalapati@intel.com
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] net/i40e: fix FDIR flexible payload issues
Date: Tue,  7 Jul 2026 20:20:45 -0400
Message-Id: <20260708002045.166595-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.27.0
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

From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>

This fixes two issues in the i40e Flow Director flexible payload path.

The bitmask array bound was checked after the write to
bitmask[nb_bitmask], allowing a one-slot out-of-bounds write when the
number of partial-mask words exceeds I40E_FDIR_BITMASK_NUM_WORD. Move
the check before the write and use '>=' so the array is never indexed
out of bounds.

In addition, i40e_flow_set_fdir_flex_pit() programs the global GLQF_ORT
register, which is shared by all PFs on the NIC. It was called before
the flex mask was validated, so a rule that is later rejected still left
the global register modified, affecting other PFs. Validate the flex
mask first and only touch the hardware registers once it has passed.

Fixes: 6ced3dd72f5f ("net/i40e: support flexible payload parsing for FDIR")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/intel/i40e/i40e_fdir.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index ad256a5a11..8a233f8a97 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -1230,12 +1230,12 @@ i40e_flow_store_flex_mask(struct i40e_pf *pf,
 			flex_mask.word_mask |=
 				I40E_FLEX_WORD_MASK(i / sizeof(uint16_t));
 			if (mask_tmp != UINT16_MAX) {
+				if (nb_bitmask >= I40E_FDIR_BITMASK_NUM_WORD)
+					return -1;
 				flex_mask.bitmask[nb_bitmask].mask = ~mask_tmp;
 				flex_mask.bitmask[nb_bitmask].offset =
 					i / sizeof(uint16_t);
 				nb_bitmask++;
-				if (nb_bitmask > I40E_FDIR_BITMASK_NUM_WORD)
-					return -1;
 			}
 		}
 	}
@@ -1488,15 +1488,17 @@ i40e_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
 				}
 			}
 
-			if (cfg_flex_pit)
-				i40e_flow_set_fdir_flex_pit(pf, layer_idx,
-						filter->input.flow_ext.raw_id);
-
 			/* Store flex mask to SW */
 			for (i = 0; i < I40E_FDIR_MAX_FLEX_LEN; i++)
 				flex_mask[i] =
 					filter->input.flow_ext.flex_mask[i];
 
+			/* Validate the flex mask before writing any hardware
+			 * register. i40e_flow_set_fdir_flex_pit() below programs
+			 * the global GLQF_ORT register, which is shared by all
+			 * PFs on the NIC, so it must not be touched for a rule
+			 * that is going to be rejected.
+			 */
 			ret = i40e_flow_store_flex_mask(pf, pctype, flex_mask);
 			if (ret == -1) {
 				PMD_DRV_LOG(ERR, "Exceed maximal"
@@ -1506,9 +1508,14 @@ i40e_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "Conflict with the"
 					    " first flexible rule");
 				return -EINVAL;
-			} else if (ret == 0) {
-				i40e_flow_set_fdir_flex_msk(pf, pctype);
 			}
+
+			if (cfg_flex_pit)
+				i40e_flow_set_fdir_flex_pit(pf, layer_idx,
+						filter->input.flow_ext.raw_id);
+
+			if (ret == 0)
+				i40e_flow_set_fdir_flex_msk(pf, pctype);
 		}
 
 		ret = i40e_sw_fdir_filter_insert(pf, &check_filter);
-- 
2.27.0

