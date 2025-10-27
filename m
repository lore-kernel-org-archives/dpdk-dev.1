Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6B5CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 05:47:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FD9D402E4;
	Mon, 27 Oct 2025 06:47:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 04CF5402E1;
 Mon, 27 Oct 2025 06:47:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761544055; x=1793080055;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xk6D7UGyj+QARDDY+2HYcBrR3c0A549EaQxT/wSufiI=;
 b=dQYTjGel6pJNB1WzG6nlX2uvR1oWTsWRjEX8JxRwXqmcG2pI1EiwBZnN
 lS90cdkAY0qeEPLS3YDMmbM7W4oTy3Fk2s6/iilJWj0GF1W9kompM0AuR
 Fc7b9fOSOFc75FN6oPy6kyrRBMiJQWDkHosW4fSjEn343MDssA0il/kpH
 QtSDxoJgiL1DQ/zCx3K+StKMPzj4V1l4OQ6F31lLvF9Gd/ZTGuWJkSC0F
 BcKlzjDB2rpZFle3UWRphhQtwZIHwpGGGR/GaPaEi2lF27FUQvS55eAVQ
 VdrpG8ddmVR4y+pv+p7hd4dpwhQTtTdIxEjj5bumD1K0wRgF4MpoJyUeB Q==;
X-CSE-ConnectionGUID: d1ki1yd2SsqGJ+vvdjDSkg==
X-CSE-MsgGUID: shg8AFE6SoakQQCcHA7UGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66232931"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="66232931"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 22:47:34 -0700
X-CSE-ConnectionGUID: itY/ML8SQCuIVlCVr0/5Pg==
X-CSE-MsgGUID: XmGOobYOTFyGupmzco/XfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="189265787"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa004.jf.intel.com with ESMTP; 26 Oct 2025 22:47:33 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com, stable@dpdk.org
Subject: [PATCH v1 2/3] net/ice: fix PTP clock corruption with TxPP
Date: Mon, 27 Oct 2025 14:28:00 -0400
Message-ID: <20251027182801.191295-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251027182801.191295-1-soumyadeep.hore@intel.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
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

On enabling TxPP PTP clock was getting corrupted as timesync was enabled
on during setup. Currently timesync will be enabled during start of tx
queue, hence enabling PHC clock to get updated on starting and stopping
of ports.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 33d82cd46d..7473d45260 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -908,6 +908,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 			rte_free(txq_elem);
 			return err;
 		}
+		dev->dev_ops->timesync_enable(dev);
 	} else {
 		txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
 
@@ -1671,7 +1672,6 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf field/flag for timestamp");
 			return -EINVAL;
 		}
-		dev->dev_ops->timesync_enable(dev);
 
 		txq->tsq->nb_ts_desc = ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi), txq->nb_tx_desc);
 		ring_size = sizeof(struct ice_ts_desc) * txq->tsq->nb_ts_desc;
-- 
2.47.1

