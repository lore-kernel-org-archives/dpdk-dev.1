Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FB1C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 08:28:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E475D406B4;
	Thu,  6 Aug 2026 10:27:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3702E40276;
 Thu,  6 Aug 2026 10:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786004876; x=1817540876;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o56VLBSc9c3dWv7K0ZyfD+YCg+R88Jc7y5EcCWN9yIA=;
 b=bILyHgUz0ncbIWuPMgNGuKLfwAIiHkLpmRGQIVf/n4thHqMdPfDj1bEx
 bIn9aEgXoUlMUk5xOgmqx+YNzRAjXKpPoYW5PxD8LRD/86YljTk1kObD6
 Zmys+HUozhf+o+mOvXZrkpntbaVnUcpukQbzfW2CRiZdo9d18eaB5sjPC
 MDbp0Mk2sBlPdeuc263Wtcdn29iQVSq2FrkMBazdMfvejG0OzDsjiXF5T
 3Nr9nxckArpWGZ0ycT97oINUQoDmw2Q31rxWVXzfU3Pdv8gBXWQAim6pk
 pH8/RDIuA1bHeYZh+jXI6ePz2Aojl66DoLY5FvkHiz/V+E7Fosub96pTv w==;
X-CSE-ConnectionGUID: LOTaRujITQKH8BhIZc+pBw==
X-CSE-MsgGUID: v5oX5106Q0aIaNKXA3JcnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86666992"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86666992"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 01:27:56 -0700
X-CSE-ConnectionGUID: PNCys3iBRTi5KUffDCg4Tw==
X-CSE-MsgGUID: BfqzeHiFRJSNWOi+5u10wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="259421019"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 06 Aug 2026 01:27:54 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH 4/5] net/iavf: change no_poll flag to atomic
Date: Thu,  6 Aug 2026 08:26:27 +0000
Message-Id: <d1ea05c4fb2db04ce8cdd5d96b1998c183cf864e.1786004043.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786004043.git.anurag.mandal@intel.com>
References: <cover.1786004043.git.anurag.mandal@intel.com>
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
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf.h        | 2 +-
 drivers/net/intel/iavf/iavf_ethdev.c | 6 +++++-
 drivers/net/intel/iavf/iavf_rxtx.c   | 8 ++++++--
 drivers/net/intel/iavf/iavf_vchnl.c  | 4 +++-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index e76c3bb410..037bc8436f 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -392,7 +392,7 @@ struct iavf_adapter {
 	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t ptype_tbl[IAVF_MAX_PKT_TYPE];
 	bool stopped;
 	bool closed;
-	bool no_poll;
+	RTE_ATOMIC(bool)no_poll;
 	enum iavf_rx_func_type rx_func_type;
 	enum iavf_tx_func_type tx_func_type;
 	uint16_t fdir_ref_cnt;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 87b826c873..f6ce339b0c 100644
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
index 931bb8420d..104197d082 100644
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
index d22990a524..dee76f97cb 100644
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

