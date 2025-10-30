Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B35FCCF9EA
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 04:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0620B402ED;
	Thu, 30 Oct 2025 05:53:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8DA6640611;
 Thu, 30 Oct 2025 05:53:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761799987; x=1793335987;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r/de4pa01ahGqM+9fN11b8vYIopGQLnf0VOM5NASnSY=;
 b=n5vASFXDTQfw9a8ih/W4VJdLwDtu5shuXytVhR1BuB3wk1zc/8BzF+NY
 LBTeT0nmf/HVe4sEySuyIJDbQDlkcaTPJPWhPWOs0tenfyemoyOuT17L+
 z/dfm+rurMc/5e+U9qH3arsZ1dKRtf/YErjP/iVYuJsEP95BnGIOHpiav
 yRhqyNq8FIT52TXggRrEJB+mQfMAL38dDAoIE6vrJBJLJvyVp6X6cnqdS
 eGYXWZaOzUKTCH8oFSOF5wo3eL0kk6vzZh2DUIMhb2NeKxm+pLnk6OPC+
 bfAoIuimVImoenESXMg5WxtRDbDNm5/bz06IQ6lm0RieeclgsGvW4ML+7 A==;
X-CSE-ConnectionGUID: GqQbYrblQFW89YJ9CcPiZg==
X-CSE-MsgGUID: r9owyaoHR+GMieI/A+vUpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74225259"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="74225259"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 21:53:06 -0700
X-CSE-ConnectionGUID: U3FosB20Rq2ntSxREkyQcw==
X-CSE-MsgGUID: eHu6Nv+mTgC+p1CMOH/ZZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="185733144"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2025 21:53:03 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com, ciara.loftus@intel.com, stable@dpdk.org
Subject: [PATCH v2 2/3] net/ice: fix PTP clock corruption with TxPP
Date: Thu, 30 Oct 2025 13:33:03 -0400
Message-ID: <20251030173304.260209-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251030173304.260209-1-soumyadeep.hore@intel.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
 <20251030173304.260209-1-soumyadeep.hore@intel.com>
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

Earlier when timesync was enabled in tx queue setup, on stopping ports
time will reset back to 0. Currently after every port restart PHC clock
will be set to current system CLOCK_REALTIME.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index fd0b3a7532..752e52b8cd 100644
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

