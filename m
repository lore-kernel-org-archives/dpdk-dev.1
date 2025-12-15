Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BEDD5B170
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 17:36:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40D264029A;
	Mon, 15 Dec 2025 18:36:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8289240151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 18:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765820158; x=1797356158;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eNLArygPlwza+ots/wzNSe8bzEmJugVKzsLHcj4TSMw=;
 b=Mzwqd6eKU43SDgSD8ikPF7j36xPgN7LGugPnjAuZEOqkQCHqw6dSVcLz
 2O6w2ZsJfLhh1G4/BumvXkPXHGLa3M6zusrwcpoimAxIFhibAXc0AnzI+
 2uCsbdeJY1TF0y9Ny2nqvL550PQylXMylvBWxkyYNUZ2lY1TufmtUGH5A
 Sg6SFmcdsPoqpN5F6x4Gi4V6W/XS0m7MoMObSI9KGCpnX44FwadiCTow+
 y3lOMzQYF16PPhRtIvzUOAyl5dt62dpqOHfUJBLoaicuF4MjYQPFentPP
 hGn6Z+/jI/CsG3VudVx3fS9G7meYjzPVnI41oSohB+fs/UGDOqNbLPHq6 g==;
X-CSE-ConnectionGUID: Do+98YzWQpWr9wuP8fB0bw==
X-CSE-MsgGUID: Y5s0kpQPQn2Kay6elmGf5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67763437"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="67763437"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 09:35:57 -0800
X-CSE-ConnectionGUID: b/aeOQApTeurQbk22CtX3Q==
X-CSE-MsgGUID: +rkGYvj/ScmpPyvg5O7bpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="196876299"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 15 Dec 2025 09:35:56 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH] net/intel: improve Rx descriptor ring size checks
Date: Mon, 15 Dec 2025 17:35:43 +0000
Message-ID: <20251215173543.1707960-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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
 drivers/net/intel/cpfl/cpfl_rxtx.c   |  7 +++++++
 drivers/net/intel/i40e/i40e_rxtx.c   |  7 +++++++
 drivers/net/intel/iavf/iavf_rxtx.c   | 20 +++++---------------
 drivers/net/intel/ice/ice_rxtx.c     |  7 +++++++
 drivers/net/intel/idpf/idpf_rxtx.c   |  7 +++++++
 drivers/net/intel/ixgbe/ixgbe_rxtx.c |  7 +++++++
 6 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 453ec975d5..1479f55d23 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -362,6 +362,13 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	if (idpf_qc_rx_thresh_check(nb_desc, rx_free_thresh) != 0)
 		return -EINVAL;
 
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_free_thresh) {
+		PMD_INIT_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			     nb_desc, 2 * rx_free_thresh);
+		return -EINVAL;
+	}
+
 	/* Free memory if needed */
 	if (dev->data->rx_queues[queue_idx] != NULL) {
 		cpfl_rx_queue_release(dev->data->rx_queues[queue_idx]);
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 255414dd03..f4a7222bc1 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2113,6 +2113,13 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_conf->rx_free_thresh) {
+		PMD_DRV_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			    nb_desc, 2 * rx_conf->rx_free_thresh);
+		return -EINVAL;
+	}
+
 	/* Free memory if needed */
 	if (dev->data->rx_queues[queue_idx]) {
 		i40e_rx_queue_release(dev->data->rx_queues[queue_idx]);
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index d8662fd815..f4be309ef8 100644
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
@@ -589,8 +575,12 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	rx_free_thresh = (rx_conf->rx_free_thresh == 0) ?
 			 IAVF_DEFAULT_RX_FREE_THRESH :
 			 rx_conf->rx_free_thresh;
-	if (check_rx_thresh(nb_desc, rx_free_thresh) != 0)
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_free_thresh) {
+		PMD_INIT_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			     nb_desc, 2 * rx_free_thresh);
 		return -EINVAL;
+	}
 
 	/* Free memory if needed */
 	if (dev->data->rx_queues[queue_idx]) {
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 74db0fbec9..42f2d5c590 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1295,6 +1295,13 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_conf->rx_free_thresh) {
+		PMD_INIT_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			     nb_desc, 2 * rx_conf->rx_free_thresh);
+		return -EINVAL;
+	}
+
 	offloads = rx_conf->offloads | dev->data->dev_conf.rxmode.offloads;
 
 	if (mp)
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 4796d8b862..136882e084 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -244,6 +244,13 @@ idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	if (idpf_qc_rx_thresh_check(nb_desc, rx_free_thresh) != 0)
 		return -EINVAL;
 
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_free_thresh) {
+		PMD_INIT_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			     nb_desc, 2 * rx_free_thresh);
+		return -EINVAL;
+	}
+
 	/* Free memory if needed */
 	if (dev->data->rx_queues[queue_idx] != NULL) {
 		idpf_qc_rx_queue_release(dev->data->rx_queues[queue_idx]);
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index a7583c178a..4d2033114e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -3206,6 +3206,13 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
+	/* Check that ring size is > 2 * rx_free_thresh */
+	if (nb_desc <= 2 * rx_conf->rx_free_thresh) {
+		PMD_INIT_LOG(ERR, "rx ring size (%u) must be > 2 * rx_free_thresh (%u)",
+			     nb_desc, 2 * rx_conf->rx_free_thresh);
+		return -EINVAL;
+	}
+
 	/* Free memory prior to re-allocation if needed... */
 	if (dev->data->rx_queues[queue_idx] != NULL) {
 		ixgbe_rx_queue_release(dev->data->rx_queues[queue_idx]);
-- 
2.51.0

