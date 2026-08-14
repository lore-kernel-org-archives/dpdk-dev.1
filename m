Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788D9C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 14:49:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C43D40285;
	Fri, 14 Aug 2026 16:49:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C66D0400D5;
 Fri, 14 Aug 2026 16:49:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786718952; x=1818254952;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wLh2jZHsDO+I2NZIAufQbvhS0hVvTAkbJIZ6KbnePQY=;
 b=D6zk+FjezV+DVg6d5JbYbSETll5q/L14WCDjEqQZ519vxuRmjNdwRqGf
 vWo0ip7xZoAQ42HkkJ+HJnc2gBMIZE+lf8m1bAFClrfrVoPl+/QUwmeHv
 1hDdSztX4/55KOXGhGMW5h+k2x7+WzfYCa8URn0kfuJUwpOqBFU5uGcSL
 +SB94n8MY+5A+e5oAfbCJuLgphkcisJHYLo7yQBsPfivbEXGJ+Ks8KrhF
 r0KZzV3e74vQ4+902eNkBDR3IkD2cKpK+npd8VS/A3BSB507YzdAZlQjn
 f2Xnzq6SWmnqyX/bH75oDtbVE7fQ/8zxe7y5Wh5uJknZh2ak3eP5SkRMH w==;
X-CSE-ConnectionGUID: izbPZ/AaQYyR4rFIESruMA==
X-CSE-MsgGUID: 39g9ag0YQwaKv6w9md0/Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="89816768"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="89816768"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 07:49:10 -0700
X-CSE-ConnectionGUID: UDHH6bd9Sn+XpT9TW6qM7A==
X-CSE-MsgGUID: 3+ANZjO8RieH640+80jBdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="262911795"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by orviesa010.jf.intel.com with ESMTP; 14 Aug 2026 07:49:08 -0700
From: sandeep.penigalapati@intel.com
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v2] net/af_xdp: fix shared UMEM refcount corruption
Date: Fri, 14 Aug 2026 17:51:07 -0400
Message-Id: <20260814215107.114582-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260812220843.75727-1-sandeep.penigalapati@intel.com>
References: <20260812220843.75727-1-sandeep.penigalapati@intel.com>
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

Reject sharing once the UMEM is at capacity by returning NULL, so queue
setup fails cleanly with -ENOMEM. This applies the per-mempool socket
limit that shared UMEM was always intended to respect.

Harden the failure path this makes reachable: clear rxq->umem
unconditionally when xsk_configure() fails, and skip queues whose UMEM
is not yet set in get_shared_umem(), so a later scan over the same
mempool cannot dereference a NULL or dangling UMEM.

Also document the shared mempool sizing requirement (4096 mbufs per
socket).

Note: on stable branches this is a behaviour change. Shared-UMEM setups
that previously appeared to start, until the fill-queue crash or the
use-after-free at close, now fail cleanly at Rx queue setup with
-ENOMEM.

Fixes: 74b46340e2d4 ("net/af_xdp: support shared UMEM")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
v2:
- Guard get_shared_umem() against a NULL umem and clear rxq->umem on the
  xsk_configure() error path (review).
- doc: "Rx queue setup fails", one sentence per line.
- Drop unrelated reflow of the refcount increment.

 doc/guides/nics/af_xdp.rst          |  6 ++++++
 drivers/net/af_xdp/rte_eth_af_xdp.c | 30 ++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/af_xdp.rst b/doc/guides/nics/af_xdp.rst
index c455b4c066..261689e4e9 100644
--- a/doc/guides/nics/af_xdp.rst
+++ b/doc/guides/nics/af_xdp.rst
@@ -99,6 +99,12 @@ configured like so:
     --vdev net_af_xdp0,iface=ens786f1,shared_umem=1 \
     --vdev net_af_xdp1,iface=ens786f2,shared_umem=1
 
+The shared mempool must be large enough for every socket sharing the UMEM.
+Each socket requires 4096 mbufs, so a UMEM shared by ``N`` sockets needs at
+least ``4096 * N`` mbufs.
+Rx queue setup fails if the mempool is too small to add another socket to the
+UMEM.
+
 xdp_prog
 ~~~~~~~~
 
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..a9e488d13c 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -1149,6 +1149,13 @@ get_shared_umem(struct pkt_rx_queue *rxq, const char *ifname,
 			if (rxq == list_rxq)
 				continue;
 			if (mb_pool == internals->rx_queues[i].mb_pool) {
+				/*
+				 * A failed queue setup can leave mb_pool set
+				 * with no umem; skip it to avoid a NULL
+				 * dereference below.
+				 */
+				if (internals->rx_queues[i].umem == NULL)
+					continue;
 				if (ctx_exists(rxq, ifname, list_rxq,
 						internals->if_name)) {
 					ret = -1;
@@ -1188,9 +1195,24 @@ xsk_umem_info *xdp_umem_configure(struct pmd_internals *internals,
 		if (get_shared_umem(rxq, internals->if_name, &umem) < 0)
 			return NULL;
 
-		if (umem != NULL &&
-			rte_atomic_load_explicit(&umem->refcnt, rte_memory_order_acquire) <
-					umem->max_xsks) {
+		if (umem != NULL) {
+			uint32_t cnt = rte_atomic_load_explicit(&umem->refcnt,
+					rte_memory_order_acquire);
+
+			/* Reject sharing once the UMEM is at capacity: sharing without
+			 * taking a reference corrupts the refcount and crashes later.
+			 */
+			if (cnt >= umem->max_xsks) {
+				AF_XDP_LOG_LINE(ERR,
+					"UMEM %s is shared by %u socket(s), max %u: "
+					"cannot share with %s,qid%i. "
+					"Increase the mempool size (%d mbufs per socket required).",
+					umem->mb_pool->name, cnt, umem->max_xsks,
+					internals->if_name, rxq->xsk_queue_idx,
+					ETH_AF_XDP_NUM_BUFFERS);
+				return NULL;
+			}
+
 			AF_XDP_LOG_LINE(INFO, "%s,qid%i sharing UMEM",
 					internals->if_name, rxq->xsk_queue_idx);
 			rte_atomic_fetch_add_explicit(&umem->refcnt, 1, rte_memory_order_acquire);
@@ -1818,6 +1840,8 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 out_umem:
 	if (rte_atomic_fetch_sub_explicit(&rxq->umem->refcnt, 1, rte_memory_order_acquire) - 1 == 0)
 		xdp_umem_destroy(rxq->umem);
+	/* Drop the dangling pointer so a later shared-UMEM scan skips it. */
+	rxq->umem = NULL;
 
 	return ret;
 }
-- 
2.27.0

