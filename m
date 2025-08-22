Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFACECA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 17:07:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEE1040DD6;
	Fri, 22 Aug 2025 19:07:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id C22FC40A87
 for <dev@dpdk.org>; Fri, 22 Aug 2025 19:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755882432; x=1787418432;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uKPAwtACYDOoJs6R0/dmMPfCc3osCKFB+scvBj1bHho=;
 b=SE/3v3K9yL8SQDLYJ1/X3rSQ4rnAisCpnl+OwM+FDZRLko82LhlCSsTD
 xNfz/K6mocz7MKhXfpugiQVT8tq1mrSFlll/GCtROV9WF9qeuZP5k3Qyc
 WVfTeqpLRXvUS0NjlHswzNLQiwfm73H2SFHjATEffgCfW+zompGHyYVUl
 xD8xoa1bV80qOnzN6HvPiubjB7MZ9G8qWo0HTvXrdLUSmaQfvkoR62AFL
 ybqTtb6BujL4H9KtZL7JberQRW/TNM5lSsVhjAZvtiWeCiyIJlxuDfVH3
 SzsdOiATG86+2ilF0N7+fNcZN0P1JojEDbT49RP4DxeCVnepjmq8lNY8r g==;
X-CSE-ConnectionGUID: Ii73xoUdRS+genlRF11pvg==
X-CSE-MsgGUID: n7Cg04VGQomcPH7FtQT8fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69294559"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="69294559"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2025 10:07:11 -0700
X-CSE-ConnectionGUID: u1YKiRedTqSpiL28hVVRpw==
X-CSE-MsgGUID: V4/+VdKlTHuz5VmETTGElA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="192416681"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa002.fm.intel.com with ESMTP; 22 Aug 2025 10:07:09 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/2] net/intel: avoid accessing mempool directly on free
Date: Fri, 22 Aug 2025 17:06:56 +0000
Message-ID: <20250822170656.454571-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250822170656.454571-1-bruce.richardson@intel.com>
References: <20250822170656.454571-1-bruce.richardson@intel.com>
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

Rather than calling the mempool function rte_pktmbuf_put_bulk directly
in drivers, switch to using the rte_mbuf_raw_free_bulk() function which
properly supports debug flags and checks, when they are enabled.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h                   | 4 ++--
 drivers/net/intel/fm10k/fm10k_ethdev.c          | 3 +--
 drivers/net/intel/fm10k/fm10k_rxtx.c            | 5 ++---
 drivers/net/intel/fm10k/fm10k_rxtx_vec.c        | 5 ++---
 drivers/net/intel/i40e/i40e_rxtx.c              | 5 ++---
 drivers/net/intel/ice/ice_rxtx.c                | 2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c            | 5 ++---
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h | 5 ++---
 8 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 7dc84da170..27a3dd388c 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -203,13 +203,13 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq, ci_desc_done_fn desc_done, bool ctx
 				if (likely(m->pool == free[0]->pool)) {
 					free[nb_free++] = m;
 				} else {
-					rte_mempool_put_bulk(free[0]->pool, (void *)free, nb_free);
+					rte_mbuf_raw_free_bulk(free[0]->pool, free, nb_free);
 					free[0] = m;
 					nb_free = 1;
 				}
 			}
 		}
-		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
+		rte_mbuf_raw_free_bulk(free[0]->pool, free, nb_free);
 	} else {
 		for (uint32_t i = 1; i < n; i++) {
 			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 216165a9bd..57f09be88e 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -212,8 +212,7 @@ rx_queue_reset(struct fm10k_rx_queue *q)
 	for (i = 0; i < q->nb_desc; ++i) {
 		fm10k_pktmbuf_reset(q->sw_ring[i], q->port_id);
 		if (!fm10k_addr_alignment_valid(q->sw_ring[i])) {
-			rte_mempool_put_bulk(q->mp, (void **)q->sw_ring,
-						q->nb_desc);
+			rte_mbuf_raw_free_bulk(q->mp, q->sw_ring, q->nb_desc);
 			return -EINVAL;
 		}
 		dma_addr = MBUF_DMA_ADDR_DEFAULT(q->sw_ring[i]);
diff --git a/drivers/net/intel/fm10k/fm10k_rxtx.c b/drivers/net/intel/fm10k/fm10k_rxtx.c
index 0557ee88df..a6ca38a6da 100644
--- a/drivers/net/intel/fm10k/fm10k_rxtx.c
+++ b/drivers/net/intel/fm10k/fm10k_rxtx.c
@@ -495,15 +495,14 @@ static inline void tx_free_bulk_mbuf(struct rte_mbuf **txep, int num)
 				if (likely(m->pool == free[0]->pool))
 					free[nb_free++] = m;
 				else {
-					rte_mempool_put_bulk(free[0]->pool,
-							(void *)free, nb_free);
+					rte_mbuf_raw_free_bulk(free[0]->pool, free, nb_free);
 					free[0] = m;
 					nb_free = 1;
 				}
 			}
 			txep[i] = NULL;
 		}
-		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
+		rte_mbuf_raw_free_bulk(free[0]->pool, free, nb_free);
 	} else {
 		for (i = 1; i < num; i++) {
 			m = rte_pktmbuf_prefree_seg(txep[i]);
diff --git a/drivers/net/intel/fm10k/fm10k_rxtx_vec.c b/drivers/net/intel/fm10k/fm10k_rxtx_vec.c
index 1269a34e76..0eada7275e 100644
--- a/drivers/net/intel/fm10k/fm10k_rxtx_vec.c
+++ b/drivers/net/intel/fm10k/fm10k_rxtx_vec.c
@@ -775,14 +775,13 @@ fm10k_tx_free_bufs(struct fm10k_tx_queue *txq)
 				if (likely(m->pool == free[0]->pool))
 					free[nb_free++] = m;
 				else {
-					rte_mempool_put_bulk(free[0]->pool,
-							(void *)free, nb_free);
+					rte_mbuf_raw_free_bulk(free[0]->pool, free, nb_free);
 					free[0] = m;
 					nb_free = 1;
 				}
 			}
 		}
-		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
+		rte_mbuf_raw_free_bulk(free[0]->pool, free, nb_free);
 	} else {
 		for (i = 1; i < n; i++) {
 			m = rte_pktmbuf_prefree_seg(txep[i]);
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index a3ca8254ff..ca439ebd8a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1355,8 +1355,7 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
 					free[i] = txep->mbuf;
 					txep->mbuf = NULL;
 				}
-				rte_mempool_put_bulk(free[0]->pool, (void **)free,
-						I40E_TX_MAX_FREE_BUF_SZ);
+				rte_mbuf_raw_free_bulk(free[0]->pool, free, I40E_TX_MAX_FREE_BUF_SZ);
 			}
 		}
 
@@ -1365,7 +1364,7 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
 				free[i] = txep->mbuf;
 				txep->mbuf = NULL;
 			}
-			rte_mempool_put_bulk(free[0]->pool, (void **)free, m);
+			rte_mbuf_raw_free_bulk(free[0]->pool, free, m);
 		}
 	} else {
 		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 0294794bed..5889d51618 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -2050,7 +2050,7 @@ ice_rx_alloc_bufs(struct ci_rx_queue *rxq)
 		diag_pay = rte_mbuf_raw_alloc_bulk(rxq->rxseg[1].mp,
 				(void *)rxq->sw_split_buf, rxq->rx_free_thresh);
 		if (unlikely(diag_pay != 0)) {
-			rte_mempool_put_bulk(rxq->mp, (void *)rxep,
+			rte_mbuf_raw_free_bulk(rxq->mp, (void *)rxep,
 				    rxq->rx_free_thresh);
 			PMD_RX_LOG(ERR, "Failed to get payload mbufs in bulk");
 			return -ENOMEM;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 6143d16377..0aa7b9bf2e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -141,8 +141,7 @@ ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
 
 		if (nb_free >= IXGBE_TX_MAX_FREE_BUF_SZ ||
 		    (nb_free > 0 && m->pool != free[0]->pool)) {
-			rte_mempool_put_bulk(free[0]->pool,
-					     (void **)free, nb_free);
+			rte_mbuf_raw_free_bulk(free[0]->pool, free, nb_free);
 			nb_free = 0;
 		}
 
@@ -150,7 +149,7 @@ ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
 	}
 
 	if (nb_free > 0)
-		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
+		rte_mbuf_raw_free_bulk(free[0]->pool, free, nb_free);
 
 	/* buffers were freed, update counters */
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
index e54f532497..7fb3c3dc24 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
@@ -55,14 +55,13 @@ ixgbe_tx_free_bufs_vec(struct ci_tx_queue *txq)
 				if (likely(m->pool == free[0]->pool))
 					free[nb_free++] = m;
 				else {
-					rte_mempool_put_bulk(free[0]->pool,
-							(void *)free, nb_free);
+					rte_mbuf_raw_free_bulk(free[0]->pool, free, nb_free);
 					free[0] = m;
 					nb_free = 1;
 				}
 			}
 		}
-		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
+		rte_mbuf_raw_free_bulk(free[0]->pool, free, nb_free);
 	} else {
 		for (i = 1; i < n; i++) {
 			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
-- 
2.48.1

