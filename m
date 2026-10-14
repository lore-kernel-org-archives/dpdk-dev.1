Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4BECC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:14:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0203140B90;
	Wed, 14 Oct 2026 17:14:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0CBD040144;
 Wed, 14 Oct 2026 17:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791990855; x=1823526855;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uopCS5q4ac6pGWwyXcb9tK2OecphR+VYPPt8jfiLGCI=;
 b=UWWkbmYePircXYFDT+WIHyhme1UF2I8iTkaqt/xGmYe9Xf4/q3xYt5RP
 cYYNDwosQGmFdjGHGUxECNwXHW1eKvBioWFYuYlvL8Xy9OH0Q0B3GzaVj
 F0vSSikl+P4fN3NNiYY52WYCtK9GIlrlVYpihByBJnxWUcrp3P5uJrHfs
 69w8Mj3ry0gePg7S+Lkod/jJZUQtBC3dIeWYKVD3Xz7LpoNMN0PfloxFo
 69pbMUj9agFvv2SefVuEBZeyQwCsZeQeSDdMlYpG8eyAbLDuLV6u12xVG
 6rgYt2mEj5dxgKA0/96SckOabICwpVdGQ96q4WZDxVgyrBFr2GqeEREBP g==;
X-CSE-ConnectionGUID: rtntdnyBRk2NjKSZrAXCcw==
X-CSE-MsgGUID: 1TpI9VXWRsy2TtaNILSlWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="642330"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="642330"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:14:05 -0700
X-CSE-ConnectionGUID: uANu0j/rS5ObXKMVzFlcwg==
X-CSE-MsgGUID: e9ZBCIbzRu6lDw4KDsYU/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1785411"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2026 08:14:04 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Gaetan Rivet <grive@u256.net>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v2 2/5] net/failsafe: fix queue release without sub-device op
Date: Wed, 14 Oct 2026 22:16:01 +0000
Message-Id: <20261014221604.128677-3-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
References: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
 <20261014221604.128677-1-sandeep.penigalapati@intel.com>
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
v2:
- Add explicit ETH(sdev) != NULL check before dereferencing.

 drivers/net/failsafe/failsafe_ops.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/failsafe_ops.c
index 8761cb07c3..0b025bd122 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -398,7 +398,9 @@ fs_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	if (rxq->event_fd >= 0)
 		close(rxq->event_fd);
 	FOREACH_SUBDEV_STATE(sdev, i, dev, DEV_ACTIVE) {
-		if (ETH(sdev)->data->rx_queues != NULL &&
+		if (ETH(sdev) != NULL &&
+		    SUBOPS(sdev, rx_queue_release) != NULL &&
+		    ETH(sdev)->data->rx_queues != NULL &&
 		    ETH(sdev)->data->rx_queues[rxq->qid] != NULL)
 			SUBOPS(sdev, rx_queue_release)(ETH(sdev), rxq->qid);
 	}
@@ -574,7 +576,9 @@ fs_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	if (fs_lock(dev, 0) != 0)
 		return;
 	FOREACH_SUBDEV_STATE(sdev, i, dev, DEV_ACTIVE) {
-		if (ETH(sdev)->data->tx_queues != NULL &&
+		if (ETH(sdev) != NULL &&
+		    SUBOPS(sdev, tx_queue_release) != NULL &&
+		    ETH(sdev)->data->tx_queues != NULL &&
 		    ETH(sdev)->data->tx_queues[txq->qid] != NULL)
 			SUBOPS(sdev, tx_queue_release)(ETH(sdev), txq->qid);
 	}
-- 
2.34.1

