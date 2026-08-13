Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9825C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2387E42831;
	Thu, 13 Aug 2026 12:46:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id F2D3A42D2B
 for <dev@dpdk.org>; Thu, 13 Aug 2026 12:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786618006; x=1818154006;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yk2tgI3DID5MHp2ml35KrWV3unyAjOaKee+DHzLPLBY=;
 b=WP3f63c9+9sHOzZ1XcG1LcQDtULooDhozumL3hOgm008q740+XkI4rJT
 qsoif7xf0Ox2cNtKKjpXfEB075neK/2CmQ304vqXqCBnUheGwf5UdfiOl
 NkJW4P1KeKRal07PKYoX0CvOX18kHwQrdFhS2+g0iktp2b2BizDIWQM2e
 YVBEnPJqiPudw+dpFGlWeTTx13F8pE6vZfFU6CrekTpx680QDfYEaghJr
 3C6q171Oqwthn4hhJyt+5lXB97i/FGRGs0Yd4OVlu7Quft8oZE/4UQPXw
 oWjuZCn/wFHuzHO0R6plohxiE5ZXwIH4VcokSShRpILb5EBElKLidaEv7 w==;
X-CSE-ConnectionGUID: BbCsSaH5QRuZECGYZvDMwA==
X-CSE-MsgGUID: d78zmt2TSre+YdhOSg3lFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89708992"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="89708992"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:46:45 -0700
X-CSE-ConnectionGUID: zlN2AnP0RdCxi2yoM+dKPQ==
X-CSE-MsgGUID: UIjeyjpSQMq5PvmUfDLGGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="264491562"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa009.jf.intel.com with ESMTP; 13 Aug 2026 03:46:44 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 4/7] net/iavf: change no_poll flag to atomic
Date: Thu, 13 Aug 2026 10:45:32 +0000
Message-Id: <1c5f2d854da4181f8cbd2b1806a926da75deea59.1786617159.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786617159.git.anurag.mandal@intel.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
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
index e08f0ef253..5f7d3831a3 100644
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
index 83c2789cda..e04afe1d6a 100644
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
 		if (!vf->link_up)
 			iavf_dev_tx_drain(dev);
 	}
-- 
2.34.1

