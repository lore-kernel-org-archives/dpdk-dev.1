Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EE6CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 10:07:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F14A040DCD;
	Wed, 15 Oct 2025 12:07:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id DB78E40276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:07:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760522853; x=1792058853;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=57MrHL4UOLrkXjTzVyYPhqhKvUdDlnHurB7f7oVZstQ=;
 b=GOQh5PTwSnaTYMsesKwdEnqr/PPsGSgagfUpHXpiTcHuMxRrmMCsci+B
 Ja0f/WBg24VazkHadAfAqy77LiypHBnHKx2hlfZopFL6ieqc9O/yUSHyG
 2uqOnyxnQeOTzULin6rRYkue7Gd6sqtYquTn1F04jx7q5UyUNL5jPFbLg
 8ZmdiZeloanGWU3JgwnUOrA0NxWH+x7JwWXHLaDUPdwomc1qRCxss/0Wu
 z4zdtO5UM7xMLC4MCbdP4fPsepPktdArsddXLkWkkiOpNMDpBZm1hn1Je
 A3PGk3rcQ63l6YYEmDZity2+SbZfFB4DsUkRX31qUkI+h1dwVpnju9MoB Q==;
X-CSE-ConnectionGUID: qbmFIooeSciNDEY62+ALzw==
X-CSE-MsgGUID: 2+3mgCiLStGZlm3tGPgdcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73371787"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="73371787"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:07:32 -0700
X-CSE-ConnectionGUID: xmydMHy3RIGypvod/90nSw==
X-CSE-MsgGUID: BwZO0edqTTKud8I964HmCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="181262606"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 15 Oct 2025 03:07:31 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 2/7] net/intel: remove redundant Rx offload check
Date: Wed, 15 Oct 2025 10:07:18 +0000
Message-Id: <20251015100723.1603296-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015100723.1603296-1-ciara.loftus@intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251015100723.1603296-1-ciara.loftus@intel.com>
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

Four Intel drivers use a common vector compatibility function to
determine if certain characteristics about a given rxq are compatible
with vector rx paths. The function checks if the buffer split offload is
enabled and disqualifies the rxq if it is, because that offload is not
available on any vector path. However, this check is redundant because
three of the drivers that use that function now use the common rx path
selection framework which performs essentially the same validation when
ensuring the requested offloads are available on the rx path to be
selected. The fourth driver does not support buffer split at all, so the
rx queue will never have that offload enabled as initialisation would
fail before getting to the path selection step. The redundant check is
removed in this commit.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx.h                   | 6 +-----
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h   | 2 +-
 drivers/net/intel/iavf/iavf_rxtx.c              | 2 +-
 drivers/net/intel/ice/ice_rxtx_vec_common.h     | 2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c | 2 +-
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index d3e4492ff1..5012e4fced 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -228,17 +228,13 @@ ci_rxq_mbuf_initializer(uint16_t port_id)
  * Individual drivers may have other further tests beyond this.
  */
 static inline bool
-ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh, uint64_t offloads)
+ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh)
 {
 	if (!rte_is_power_of_2(nb_desc) ||
 			rx_free_thresh < CI_RX_MAX_BURST ||
 			(nb_desc % rx_free_thresh) != 0)
 		return false;
 
-	/* no driver supports buffer split on vector path */
-	if (offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)
-		return false;
-
 	return true;
 }
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
index 39c9d2ee10..14651f2f06 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
@@ -62,7 +62,7 @@ i40e_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
 		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 		if (!rxq)
 			continue;
-		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads))
+		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh))
 			return -1;
 	}
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 775fb4a66f..f500ba030f 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -727,7 +727,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 #if defined RTE_ARCH_X86 || defined RTE_ARCH_ARM
 	/* check vector conflict */
-	if (ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads) &&
+	if (ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh) &&
 			iavf_rxq_vec_setup(rxq)) {
 		PMD_DRV_LOG(ERR, "Failed vector rx setup.");
 		return -EINVAL;
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 07996ab2b7..a7cc4736cf 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -78,7 +78,7 @@ ice_rx_vec_queue_default(struct ci_rx_queue *rxq)
 	if (!rxq)
 		return -1;
 
-	if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads))
+	if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh))
 		return -1;
 
 	if (rxq->proto_xtr != PROTO_XTR_NONE)
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
index 94fbde1de2..eb7c79eaf9 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
@@ -131,7 +131,7 @@ ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 		if (!rxq)
 			continue;
-		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads))
+		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh))
 			return -1;
 	}
 	return 0;
-- 
2.34.1

