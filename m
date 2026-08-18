Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF726C5DF67
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30A9240687;
	Tue, 18 Aug 2026 06:58:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5947C40691
 for <dev@dpdk.org>; Tue, 18 Aug 2026 06:58:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787029125; x=1818565125;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mCRRG6pWMkoCA0bDXx047dw9l2SwCAEwujLK8ZQCAAI=;
 b=Ll/48hzXL7ONbBP3PRopL+YXtQ5URivqvkQKThGvfrUsoe9QQyeiMObe
 goNxeRdgDakJG5XvXdI9lwHdt43oDSCuieEsykuwDxfHhmXCyyric0kDO
 d2y0sCf8nIe1y2cjqeV6TYCLz2qoRxe2wwCKT0GlE6d0Zs1XOHhryQcLI
 dAg9OMpnQ3xYvu0cKlGtgRljAJnITgCSAdvLjJwfcKimNctmvSJHbMrmG
 drywJkV57lhkvNOdJHQiJ9kRS7KK8wqrRhDYBLzM6hacI2PKdwlntFKo3
 IF8fUwR9d39ghYuokdFevnT+z8+0Xl5IE6tJzVcvyouXy8dkKmsFAFSji w==;
X-CSE-ConnectionGUID: TvfGG72xRCORbfGLu4tebw==
X-CSE-MsgGUID: QmXnBOExROi+v1q+cAE9MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87633018"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87633018"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 21:58:44 -0700
X-CSE-ConnectionGUID: qLxHx0S6Sg+A8bAKSMbkUw==
X-CSE-MsgGUID: Z7aE5VjiSSGZMvgG74gf9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="268611267"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa003.jf.intel.com with ESMTP; 17 Aug 2026 21:58:42 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v4 4/7] net/iavf: change no_poll flag to atomic
Date: Tue, 18 Aug 2026 04:57:29 +0000
Message-Id: <636d7a4894079e9254dace290f4db968b543c371.1787028683.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787028683.git.anurag.mandal@intel.com>
References: <cover.1787028683.git.anurag.mandal@intel.com>
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

The no_poll gate that pauses the Rx/Tx data path during reset and
link-down was a plain bool written on the control path and read on
the data-plane lcores without synchronization, allowing stale reads
that either keep dropping traffic or trigger spurious reset detection.

Made no_poll an RTE_ATOMIC(bool) and access it with release stores and
acquire loads so data-plane lcores reliably observe gate changes.

Fixes: 5b3124a0a6ef ("net/iavf: support no polling when link down")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf.h        | 2 +-
 drivers/net/intel/iavf/iavf_ethdev.c | 6 +++++-
 drivers/net/intel/iavf/iavf_rxtx.c   | 8 ++++++--
 drivers/net/intel/iavf/iavf_vchnl.c  | 4 +++-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index e76c3bb410..605e9dd3aa 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -392,7 +392,7 @@ struct iavf_adapter {
 	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t ptype_tbl[IAVF_MAX_PKT_TYPE];
 	bool stopped;
 	bool closed;
-	bool no_poll;
+	RTE_ATOMIC(bool) no_poll;
 	enum iavf_rx_func_type rx_func_type;
 	enum iavf_tx_func_type tx_func_type;
 	uint16_t fdir_ref_cnt;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index ebe0183a77..0f5eb57bbe 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3604,9 +3604,13 @@ void
 iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
 {
 	struct iavf_info *vf = &adapter->vf;
+	bool no_poll;
 
-	adapter->no_poll = (link_change & !vf->link_up) ||
+	no_poll = (link_change & !vf->link_up) ||
 		vf->vf_reset || vf->in_reset_recovery;
+
+	rte_atomic_store_explicit(&adapter->no_poll, no_poll,
+				  rte_memory_order_release);
 }
 
 static int
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index db332cc682..7651c14903 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3723,7 +3723,9 @@ iavf_recv_pkts_no_poll(void *rx_queue, struct rte_mbuf **rx_pkts,
 	struct ci_rx_queue *rxq = rx_queue;
 	enum iavf_rx_func_type rx_func_type;
 
-	if (!rxq->iavf_vsi || rxq->iavf_vsi->adapter->no_poll)
+	if (!rxq->iavf_vsi ||
+	    rte_atomic_load_explicit(&rxq->iavf_vsi->adapter->no_poll,
+				     rte_memory_order_acquire))
 		return 0;
 
 	rx_func_type = rxq->iavf_vsi->adapter->rx_func_type;
@@ -3739,7 +3741,9 @@ iavf_xmit_pkts_no_poll(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_queue *txq = tx_queue;
 	enum iavf_tx_func_type tx_func_type;
 
-	if (!txq->iavf_vsi || txq->iavf_vsi->adapter->no_poll)
+	if (!txq->iavf_vsi ||
+	    rte_atomic_load_explicit(&txq->iavf_vsi->adapter->no_poll,
+				     rte_memory_order_acquire))
 		return 0;
 
 	tx_func_type = txq->iavf_vsi->adapter->tx_func_type;
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 565e81e176..43b5f29cad 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -268,7 +268,9 @@ iavf_handle_link_change_event(struct rte_eth_dev *dev,
 	if (adapter->devargs.no_poll_on_link_down) {
 		iavf_set_no_poll(adapter, true);
 		PMD_DRV_LOG(DEBUG, "VF no poll turned %s",
-			    adapter->no_poll ? "on" : "off");
+			    rte_atomic_load_explicit(&adapter->no_poll,
+						     rte_memory_order_relaxed) ?
+						     "on" : "off");
 	}
 
 	/* Retry a dev_start deferred by reset recovery, before the LSC post. */
-- 
2.34.1

