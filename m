Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE391D5B866
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 18:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11BB44029A;
	Mon, 15 Dec 2025 19:43:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 08EBB40151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 19:43:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765824231; x=1797360231;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qyo11zMzqAOnyh5QwWDByPQgpLYCv5QBCMc9RE1PHcE=;
 b=DJZs+tK+Fw9+mBf341WdJBEVPDZYNjRcJSor2NdscrESNGLnzyUd04Ia
 Qe+UgHJAu4tPMhLASPlVjRh3sKsmB8pHEg5QQEMlg+9IfuaHKToa4cs7C
 SMWR0IxafGGBeKgnQ0HKzyH1m7/PbO+skbeINUpVrRbKIkOLAgvd8dzzI
 ckMG7/AXh+sK04x4nYUOe5HU+kv68bX330cxMxuXIPO2OEgpW3Sr5/SIb
 xwdRRhLEL8tB2u2PX+sSiw8ozDlVr3xgohyvPhZclxvEj89qle6TlIVYF
 hlBshugRmyFKF/QNZ2wknZOVj0TG6aeiZDU4NMrC7NjmFInxkl1eFieg6 Q==;
X-CSE-ConnectionGUID: GPsamReWRCidC7RZ3IaZAA==
X-CSE-MsgGUID: 3S1uykmDR+yt8824gaVUJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="70312983"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="70312983"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 10:43:50 -0800
X-CSE-ConnectionGUID: oOmrHQ8IS1mgzieya36ypg==
X-CSE-MsgGUID: 647ygaynRvODTGv/nZRlBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="197426904"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa007.fm.intel.com with ESMTP; 15 Dec 2025 10:43:46 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] net/intel: improve Rx descriptor ring size checks
Date: Mon, 15 Dec 2025 18:43:42 +0000
Message-ID: <20251215184342.1722960-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215173543.1707960-1-bruce.richardson@intel.com>
References: <20251215173543.1707960-1-bruce.richardson@intel.com>
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

The default Rx ring size checks did not account for the fact that the
port would not work correctly if the Rx ring size was only twice the
free threshold size or less, so add in a new check for this. This would
generally only apply in cases where very small rings sizes are being
used, for example, with default Rx free thresh of 32, only ring size of
64 would cause issues.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2: add in extra error message for the small queue size case, to help
    make users aware of what setting they need to use to fix things.
---
 drivers/net/intel/cpfl/cpfl_rxtx.c   | 10 ++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c   | 10 ++++++++++
 drivers/net/intel/iavf/iavf_rxtx.c   | 23 ++++++++---------------
 drivers/net/intel/ice/ice_rxtx.c     | 10 ++++++++++
 drivers/net/intel/idpf/idpf_rxtx.c   | 10 ++++++++++
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 10 ++++++++++
 6 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 453ec975d5..d42b1142c2 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -362,6 +362,16 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	if (idpf_qc_rx_thresh_check(nb_desc, rx_free_thresh) != 0)
 		return -EINVAL;
 
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_free_thresh) {
+		PMD_INIT_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			     nb_desc, rx_free_thresh);
+		if (rx_free_thresh == CPFL_DEFAULT_RX_FREE_THRESH)
+			PMD_INIT_LOG(ERR, "To use ring sizes of %u or smaller, reduce rx_free_thresh",
+					CPFL_DEFAULT_RX_FREE_THRESH * 2);
+		return -EINVAL;
+	}
+
 	/* Free memory if needed */
 	if (dev->data->rx_queues[queue_idx] != NULL) {
 		cpfl_rx_queue_release(dev->data->rx_queues[queue_idx]);
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 255414dd03..430f367eab 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2113,6 +2113,16 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_conf->rx_free_thresh) {
+		PMD_DRV_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			    nb_desc, rx_conf->rx_free_thresh);
+		if (nb_desc == I40E_MIN_RING_DESC)
+			PMD_DRV_LOG(ERR, "To use the minimum ring size (%u), reduce rx_free_thresh to a lower value (recommended %u)",
+				    I40E_MIN_RING_DESC, I40E_MIN_RING_DESC / 4);
+		return -EINVAL;
+	}
+
 	/* Free memory if needed */
 	if (dev->data->rx_queues[queue_idx]) {
 		i40e_rx_queue_release(dev->data->rx_queues[queue_idx]);
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index d8662fd815..a8d7c2fc1d 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -146,20 +146,6 @@ iavf_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
 	return 0;
 }
 
-static inline int
-check_rx_thresh(uint16_t nb_desc, uint16_t thresh)
-{
-	/* The following constraints must be satisfied:
-	 *   thresh < rxq->nb_rx_desc
-	 */
-	if (thresh >= nb_desc) {
-		PMD_INIT_LOG(ERR, "rx_free_thresh (%u) must be less than %u",
-			     thresh, nb_desc);
-		return -EINVAL;
-	}
-	return 0;
-}
-
 static inline int
 check_tx_thresh(uint16_t nb_desc, uint16_t tx_rs_thresh,
 		uint16_t tx_free_thresh)
@@ -589,8 +575,15 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	rx_free_thresh = (rx_conf->rx_free_thresh == 0) ?
 			 IAVF_DEFAULT_RX_FREE_THRESH :
 			 rx_conf->rx_free_thresh;
-	if (check_rx_thresh(nb_desc, rx_free_thresh) != 0)
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_free_thresh) {
+		PMD_INIT_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			     nb_desc, rx_free_thresh);
+		if (nb_desc == IAVF_MIN_RING_DESC)
+			PMD_INIT_LOG(ERR, "To use the minimum ring size (%u), reduce rx_free_thresh to a lower value (recommended %u)",
+				     IAVF_MIN_RING_DESC, IAVF_MIN_RING_DESC / 4);
 		return -EINVAL;
+	}
 
 	/* Free memory if needed */
 	if (dev->data->rx_queues[queue_idx]) {
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 74db0fbec9..510eb1d316 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1295,6 +1295,16 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_conf->rx_free_thresh) {
+		PMD_INIT_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			     nb_desc, rx_conf->rx_free_thresh);
+		if (nb_desc == ICE_MIN_RING_DESC)
+			PMD_INIT_LOG(ERR, "To use the minimum ring size (%u), reduce rx_free_thresh to a lower value (recommended %u)",
+				     ICE_MIN_RING_DESC, ICE_MIN_RING_DESC / 4);
+		return -EINVAL;
+	}
+
 	offloads = rx_conf->offloads | dev->data->dev_conf.rxmode.offloads;
 
 	if (mp)
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 4796d8b862..fefe7d89ce 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -244,6 +244,16 @@ idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	if (idpf_qc_rx_thresh_check(nb_desc, rx_free_thresh) != 0)
 		return -EINVAL;
 
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_free_thresh) {
+		PMD_INIT_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			     nb_desc, rx_free_thresh);
+		if (rx_free_thresh == IDPF_DEFAULT_RX_FREE_THRESH)
+			PMD_INIT_LOG(ERR, "To use ring sizes of %u or smaller, reduce rx_free_thresh",
+					IDPF_DEFAULT_RX_FREE_THRESH * 2);
+		return -EINVAL;
+	}
+
 	/* Free memory if needed */
 	if (dev->data->rx_queues[queue_idx] != NULL) {
 		idpf_qc_rx_queue_release(dev->data->rx_queues[queue_idx]);
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index a7583c178a..9f36179c21 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -3206,6 +3206,16 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_conf->rx_free_thresh) {
+		PMD_INIT_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			     nb_desc, rx_conf->rx_free_thresh);
+		if (nb_desc == IXGBE_MIN_RING_DESC)
+			PMD_INIT_LOG(ERR, "To use the minimum ring size (%u), reduce rx_free_thresh to a lower value (recommended %u)",
+				     IXGBE_MIN_RING_DESC, IXGBE_MIN_RING_DESC / 4);
+		return -EINVAL;
+	}
+
 	/* Free memory prior to re-allocation if needed... */
 	if (dev->data->rx_queues[queue_idx] != NULL) {
 		ixgbe_rx_queue_release(dev->data->rx_queues[queue_idx]);
-- 
2.51.0

