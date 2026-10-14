Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058E6CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:43:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0D6840653;
	Wed, 14 Oct 2026 14:43:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 7683F4021E;
 Wed, 14 Oct 2026 14:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791981806; x=1823517806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3rc/qqSnghN8x7wuNOLhSDx/eqxwW9PFPCjaTGW5dvY=;
 b=NnUGnHb3o0Xcp3HOTqInjC+VYgguLTYGxuhF29uUB0EKZP+4ibopc3oP
 pSyNR3j+3ubnlEun+wJ+9Tl42u8jiNYhQdTY0X9BY7AtHI50Abra7rTLJ
 fAaCB84ujbTScMvEIvWUXcMxT6Q0WPNc9lzO5gbSEsivv5Ba4rpA9jzIa
 TuVIZEk+Y96CK7p6znlGRiHA0wtmX7lCNJghWRIebOt69T2CC52bGWTlq
 MgYCWKSSxjcyxOfYDgNI/6ZAcPLO5BOUjAuCf7gGwa4b1a1IPy/9UM2vM
 UuPAiFQ6/jrESXVqciZVTHur7dNlWfCY8669rNepNpjbXwioCSXh8Yyfa w==;
X-CSE-ConnectionGUID: 29/70TapSbq+pA23Trn3lQ==
X-CSE-MsgGUID: JXAJQjawRw+FKJdZxIsSaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="625456"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="625456"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 05:41:23 -0700
X-CSE-ConnectionGUID: o+p+bSMPSV6s3p1vSXmjBw==
X-CSE-MsgGUID: CnV+Ps73Q2KUXhS3STGq4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1342541"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by orviesa008.jf.intel.com with ESMTP; 14 Oct 2026 05:41:23 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Gaetan Rivet <grive@u256.net>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH 2/5] net/failsafe: fix queue release without sub-device op
Date: Wed, 14 Oct 2026 19:42:54 +0000
Message-Id: <20261014194257.123356-3-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
References: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
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

fs_rx_queue_release() and fs_tx_queue_release() iterate over the active
sub-devices and call the sub-device Rx/Tx queue release op directly.
Some PMDs do not implement that op, so the function pointer is NULL.
Calling it unconditionally could dereference a NULL pointer and crash
when releasing fail-safe queues.

Check that the sub-device provides the release op before calling it.

Fixes: 7483341ae553 ("ethdev: change queue release callback")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/failsafe/failsafe_ops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/failsafe_ops.c
index 8761cb07c3..79aa57cb35 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -398,7 +398,8 @@ fs_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	if (rxq->event_fd >= 0)
 		close(rxq->event_fd);
 	FOREACH_SUBDEV_STATE(sdev, i, dev, DEV_ACTIVE) {
-		if (ETH(sdev)->data->rx_queues != NULL &&
+		if (SUBOPS(sdev, rx_queue_release) != NULL &&
+		    ETH(sdev)->data->rx_queues != NULL &&
 		    ETH(sdev)->data->rx_queues[rxq->qid] != NULL)
 			SUBOPS(sdev, rx_queue_release)(ETH(sdev), rxq->qid);
 	}
@@ -574,7 +575,8 @@ fs_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	if (fs_lock(dev, 0) != 0)
 		return;
 	FOREACH_SUBDEV_STATE(sdev, i, dev, DEV_ACTIVE) {
-		if (ETH(sdev)->data->tx_queues != NULL &&
+		if (SUBOPS(sdev, tx_queue_release) != NULL &&
+		    ETH(sdev)->data->tx_queues != NULL &&
 		    ETH(sdev)->data->tx_queues[txq->qid] != NULL)
 			SUBOPS(sdev, tx_queue_release)(ETH(sdev), txq->qid);
 	}
-- 
2.34.1

