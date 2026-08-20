Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D07DC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 16:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A917B4060B;
	Thu, 20 Aug 2026 18:03:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id C84EC4026D;
 Thu, 20 Aug 2026 18:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787241808; x=1818777808;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Sua6MjUUfX/JBx2JNkD8Pb1H+r/82xvLRE3XLUsxBgU=;
 b=BQzjSB4XHzvKr4vPhuVzxPw5Ir7hDEQ7l3JInjC61EnCXqf5ojEKYhNl
 IASgsTd9aXOJCnauCz8N7nzvLXIfuWXx+Bixl9YBtTD/f7o6QYUIfUxht
 73ZPZhxWvLeT9Op2WuyV0tVvjj+zanUDqoTRPXL+HWiBFdszxUX3Azml8
 Cxs0E/oPcYb4hVEbns70tpo2Vd0AX9Q4vsDjNDOqUE0XL75qWDf9/ajO8
 RGyNiQPajmfHe3qGPtmHyjo3NUxS3RtvjJrjgQib879OPl2z7vvVELD2q
 UTsVH6aFemtaHcaBmdGzPeF3+we8C+IhwR9RYYmgky8U6hvy18/RbCJtt Q==;
X-CSE-ConnectionGUID: KbiK41a2RRip7CVQYibJ0Q==
X-CSE-MsgGUID: 1ZAux+ceRR+u+Sc6SPy3QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87545294"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="87545294"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 09:03:26 -0700
X-CSE-ConnectionGUID: +TrSvvmTT0yMffeLcH9Niw==
X-CSE-MsgGUID: enpyda3mQdiXZqGkS/qGqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="269908088"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by orviesa004.jf.intel.com with ESMTP; 20 Aug 2026 09:03:23 -0700
From: sandeep.penigalapati@intel.com
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v4] net/af_xdp: fix shared UMEM refcount corruption
Date: Thu, 20 Aug 2026 19:05:21 -0400
Message-Id: <20260820230521.199048-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.27.0
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

From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>

Shared UMEM is meant to be shared by a limited number of sockets,
governed by the mempool size (max_xsks). When the UMEM was already at
capacity (refcnt >= max_xsks), xdp_umem_configure() returned the UMEM
without incrementing its refcount, so the extra socket used it
unaccounted for.

This missing reference has two consequences. During queue setup the
fill-queue reservation is chosen from the refcount, so the sharing
socket reserves into its own uninitialised fill queue and crashes. At
close, the under-counted refcount reaches zero while the UMEM is still
in use, freeing it early and causing a use-after-free.

Reject sharing once the UMEM is at capacity by returning NULL. The
error is propagated from xsk_configure(), so Rx queue setup fails
cleanly with -ENOMEM. This applies the per-mempool socket limit that
shared UMEM was always intended to respect.

Harden the failure path this makes reachable:
- clear rxq->umem and its paired txq->umem when xsk_configure() fails,
  and skip queues whose UMEM is not yet set in get_shared_umem(), so a
  later scan over the same mempool cannot dereference a NULL or
  dangling UMEM;
- free the fill-queue mbufs that were allocated but not yet handed to
  the fill queue when a sharing socket fails to bind, so it no longer
  leaks a burst of mbufs back out of the shared mempool;
- propagate the map-insert failures in xsk_configure() instead of
  returning success, so a failed xsks_map update no longer leaves the
  caller using a deleted socket;
- continue past, rather than stop at, a failed queue in eth_dev_close()
  so later successful queues and their UMEM references are still freed;
- clamp max_xsks to UINT8_MAX so the cap stays within the uint8_t
  refcount.

Also correct the UMEM refcount memory ordering: relaxed on the shared
increment, release on the decrements, with an acquire fence before
xdp_umem_destroy() so the final user's writes are visible to the thread
that frees the UMEM.

Document the shared mempool sizing requirement (4096 mbufs per socket).

Note: on stable branches this is a behaviour change. Shared-UMEM setups
that previously appeared to start, until the fill-queue crash or the
use-after-free at close, now fail cleanly at Rx queue setup with
-ENOMEM.

Fixes: 74b46340e2d4 ("net/af_xdp: support shared UMEM")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
v4:
- Free fill-queue mbufs on the failure path.
- Propagate map-insert failures and the -ENOMEM from xsk_configure() to
  the caller instead of a blanket -EINVAL / silent success.
- eth_dev_close(): continue past failed queues instead of break.
- Correct refcount memory ordering (relaxed increment, release
  decrement, acquire fence before destroy).
- Clamp max_xsks to UINT8_MAX so the cap fits the uint8_t refcount.
- Clear txq->umem on the early return; clearer log when the mempool is
  too small (max_xsks == 0).

v3:
- Move the NULL umem check after ctx_exists() so a failed queue is still
  checked for a duplicate context, as before.
- Shorten the "at capacity" log to one line and drop the count.
- Also clear txq->umem, not just rxq->umem, when setup fails.
- Clarify "AF_XDP socket" in the doc.

v2:
- Guard get_shared_umem() against a NULL umem and clear rxq->umem on the
  xsk_configure() error path (review).
- doc: "Rx queue setup fails", one sentence per line.
- Drop unrelated reflow of the refcount increment.

 doc/guides/nics/af_xdp.rst          |  7 +++
 drivers/net/af_xdp/rte_eth_af_xdp.c | 66 +++++++++++++++++++++++------
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/doc/guides/nics/af_xdp.rst b/doc/guides/nics/af_xdp.rst
index c455b4c066..cf4eeb63d0 100644
--- a/doc/guides/nics/af_xdp.rst
+++ b/doc/guides/nics/af_xdp.rst
@@ -99,6 +99,13 @@ configured like so:
     --vdev net_af_xdp0,iface=ens786f1,shared_umem=1 \
     --vdev net_af_xdp1,iface=ens786f2,shared_umem=1
 
+The shared mempool must be large enough for every AF_XDP socket sharing
+the UMEM.
+Each socket requires 4096 mbufs, so a UMEM shared by ``N`` sockets needs at
+least ``4096 * N`` mbufs.
+Rx queue setup fails if the mempool is too small to add another socket to the
+UMEM.
+
 xdp_prog
 ~~~~~~~~
 
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..8bd44b3766 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -1062,13 +1062,17 @@ eth_dev_close(struct rte_eth_dev *dev)
 
 	for (i = 0; i < internals->queue_cnt; i++) {
 		rxq = &internals->rx_queues[i];
+		/* Skip queues whose setup failed (umem left NULL). */
 		if (rxq->umem == NULL)
-			break;
+			continue;
 		xsk_socket__delete(rxq->xsk);
 
 		if (rte_atomic_fetch_sub_explicit(&rxq->umem->refcnt, 1,
-				rte_memory_order_acquire) - 1 == 0)
+				rte_memory_order_release) - 1 == 0) {
+			/* Acquire so the destroy sees all prior users' writes. */
+			rte_atomic_thread_fence(rte_memory_order_acquire);
 			xdp_umem_destroy(rxq->umem);
+		}
 	}
 	/* Free Tx and Rx queue arrays */
 	rte_free(internals->tx_queues);
@@ -1154,6 +1158,9 @@ get_shared_umem(struct pkt_rx_queue *rxq, const char *ifname,
 					ret = -1;
 					goto out;
 				}
+				/* A failed setup leaves mb_pool set with no umem. */
+				if (list_rxq->umem == NULL)
+					continue;
 				if (rte_atomic_load_explicit(&internals->rx_queues[i].umem->refcnt,
 						    rte_memory_order_acquire)) {
 					*umem = internals->rx_queues[i].umem;
@@ -1188,12 +1195,24 @@ xsk_umem_info *xdp_umem_configure(struct pmd_internals *internals,
 		if (get_shared_umem(rxq, internals->if_name, &umem) < 0)
 			return NULL;
 
-		if (umem != NULL &&
-			rte_atomic_load_explicit(&umem->refcnt, rte_memory_order_acquire) <
-					umem->max_xsks) {
+		if (umem != NULL) {
+			/* Reject sharing once the UMEM is at capacity. */
+			if (rte_atomic_load_explicit(&umem->refcnt,
+					rte_memory_order_acquire) >= umem->max_xsks) {
+				if (umem->max_xsks == 0)
+					AF_XDP_LOG_LINE(ERR, "%s,qid%i: mempool %s too small to share UMEM",
+							internals->if_name, rxq->xsk_queue_idx,
+							umem->mb_pool->name);
+				else
+					AF_XDP_LOG_LINE(ERR, "%s,qid%i: UMEM %s already at max %u sockets",
+							internals->if_name, rxq->xsk_queue_idx,
+							umem->mb_pool->name, umem->max_xsks);
+				return NULL;
+			}
+
 			AF_XDP_LOG_LINE(INFO, "%s,qid%i sharing UMEM",
 					internals->if_name, rxq->xsk_queue_idx);
-			rte_atomic_fetch_add_explicit(&umem->refcnt, 1, rte_memory_order_acquire);
+			rte_atomic_fetch_add_explicit(&umem->refcnt, 1, rte_memory_order_relaxed);
 		}
 	}
 
@@ -1239,8 +1258,10 @@ xsk_umem_info *xdp_umem_configure(struct pmd_internals *internals,
 		umem->buffer = aligned_addr;
 
 		if (internals->shared_umem) {
-			umem->max_xsks = mb_pool->populated_size /
-						ETH_AF_XDP_NUM_BUFFERS;
+			/* refcnt is uint8_t, so the cap cannot exceed UINT8_MAX. */
+			umem->max_xsks = RTE_MIN(mb_pool->populated_size /
+						ETH_AF_XDP_NUM_BUFFERS,
+						(uint32_t)UINT8_MAX);
 			AF_XDP_LOG_LINE(INFO, "Max xsks for UMEM %s: %u",
 						mb_pool->name, umem->max_xsks);
 		}
@@ -1684,10 +1705,13 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 	int reserve_size = ETH_AF_XDP_DFLT_NUM_DESCS;
 	struct rte_mbuf *fq_bufs[reserve_size];
 	bool reserve_before;
+	bool free_fq_bufs = false;
 
 	rxq->umem = xdp_umem_configure(internals, rxq);
-	if (rxq->umem == NULL)
+	if (rxq->umem == NULL) {
+		txq->umem = NULL;
 		return -ENOMEM;
+	}
 	txq->umem = rxq->umem;
 	reserve_before = rte_atomic_load_explicit(&rxq->umem->refcnt,
 			rte_memory_order_acquire) <= 1;
@@ -1698,11 +1722,14 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 		AF_XDP_LOG_LINE(DEBUG, "Failed to get enough buffers for fq.");
 		goto out_umem;
 	}
+	free_fq_bufs = true;
 #endif
 
 	/* reserve fill queue of queues not (yet) sharing UMEM */
 	if (reserve_before) {
 		ret = reserve_fill_queue(rxq->umem, reserve_size, fq_bufs, &rxq->fq);
+		/* reserve_fill_queue() consumes fq_bufs on success and frees them on failure. */
+		free_fq_bufs = false;
 		if (ret) {
 			AF_XDP_LOG_LINE(ERR, "Failed to reserve fill queue.");
 			goto out_umem;
@@ -1759,6 +1786,7 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 	if (!reserve_before) {
 		/* reserve fill queue of queues sharing UMEM */
 		ret = reserve_fill_queue(rxq->umem, reserve_size, fq_bufs, &rxq->fq);
+		free_fq_bufs = false;
 		if (ret) {
 			AF_XDP_LOG_LINE(ERR, "Failed to reserve fill queue.");
 			goto out_xsk;
@@ -1774,6 +1802,7 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 					  &rxq->xsk_queue_idx, &fd, 0);
 		if (err) {
 			AF_XDP_LOG_LINE(ERR, "Failed to insert xsk in map.");
+			ret = -EINVAL;
 			goto out_xsk;
 		}
 	}
@@ -1786,6 +1815,7 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 			map_fd = uds_get_xskmap_fd(internals->if_name, internals->dp_path);
 			if (map_fd < 0) {
 				AF_XDP_LOG_LINE(ERR, "Failed to receive xskmap fd from AF_XDP Device Plugin");
+				ret = -EINVAL;
 				goto out_xsk;
 			}
 		} else {
@@ -1793,6 +1823,7 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 			err = get_pinned_map(internals->dp_path, &map_fd);
 			if (err < 0 || map_fd < 0) {
 				AF_XDP_LOG_LINE(ERR, "Failed to retrieve pinned map fd");
+				ret = -EINVAL;
 				goto out_xsk;
 			}
 		}
@@ -1800,6 +1831,7 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 		err = update_xskmap(rxq->xsk, map_fd, rxq->xsk_queue_idx);
 		if (err) {
 			AF_XDP_LOG_LINE(ERR, "Failed to insert xsk in map.");
+			ret = -EINVAL;
 			goto out_xsk;
 		}
 
@@ -1816,8 +1848,18 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 out_xsk:
 	xsk_socket__delete(rxq->xsk);
 out_umem:
-	if (rte_atomic_fetch_sub_explicit(&rxq->umem->refcnt, 1, rte_memory_order_acquire) - 1 == 0)
+	/* Free fq_bufs that were allocated but never handed to the fill queue. */
+	if (free_fq_bufs)
+		rte_pktmbuf_free_bulk(fq_bufs, reserve_size);
+	if (rte_atomic_fetch_sub_explicit(&rxq->umem->refcnt, 1,
+			rte_memory_order_release) - 1 == 0) {
+		/* Acquire so the destroy sees all prior users' writes. */
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 		xdp_umem_destroy(rxq->umem);
+	}
+	/* Drop dangling pointers so a later shared-UMEM scan skips this queue. */
+	rxq->umem = NULL;
+	txq->umem = NULL;
 
 	return ret;
 }
@@ -1858,9 +1900,9 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 
 	rxq->mb_pool = mb_pool;
 
-	if (xsk_configure(internals, rxq, nb_rx_desc)) {
+	ret = xsk_configure(internals, rxq, nb_rx_desc);
+	if (ret) {
 		AF_XDP_LOG_LINE(ERR, "Failed to configure xdp socket");
-		ret = -EINVAL;
 		goto err;
 	}
 
-- 
2.27.0

