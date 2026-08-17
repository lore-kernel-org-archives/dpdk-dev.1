Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F273EC5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 09:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C11E640275;
	Mon, 17 Aug 2026 11:11:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1729A4021F;
 Mon, 17 Aug 2026 11:11:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786957866; x=1818493866;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kH7b8VxMMfFd6JC41vb108Gc5gukJ3fXvJ52M5fWsSk=;
 b=jPtWe9+3pCobCyqIQzwMEVwzFDcdkgk8TtnaG4uDRX1CJ61kOBwtWQkq
 Cxae3bGmR3FAWUQMKL+FS4P77zTVnaMjmNnIaOicYwB8aoBphFEg8VPLT
 JK5ZusehpmZrFR/fLVaktcJjPpF0ZplTeoWReRppd1RItoN+LDgnBaJNl
 +bcLDzz6E7HKfzviexscVI6IVWELVyKAnf7D/mrILgszgQO1XwMZw3Vsd
 UNCINGLGl2rO28SOu7BQhP9cBdBgesX/uk1ktAz8XNAmPHWDn0qCR3aG7
 oPP31OdP5bqFHTtnDigCo+EltyaaZr7cy3vJuQr3yIpH1S+V13iPsqj+H A==;
X-CSE-ConnectionGUID: rAozUV3tSOOHQfUaaK74WQ==
X-CSE-MsgGUID: WKdBrXeuT92D3TMU3zW0qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87188226"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="87188226"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:11:05 -0700
X-CSE-ConnectionGUID: Ggl23D9wT4aZK5do+1kyXg==
X-CSE-MsgGUID: da9hH+2fS/OLzLZITf/sTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="264898324"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by orviesa007.jf.intel.com with ESMTP; 17 Aug 2026 02:11:03 -0700
From: sandeep.penigalapati@intel.com
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v3] net/af_xdp: fix shared UMEM refcount corruption
Date: Mon, 17 Aug 2026 12:13:01 -0400
Message-Id: <20260817161301.54049-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260814215107.114582-1-sandeep.penigalapati@intel.com>
References: <20260814215107.114582-1-sandeep.penigalapati@intel.com>
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

Harden the failure path this makes reachable: clear rxq->umem and its
paired txq->umem when xsk_configure() fails, and skip queues whose UMEM
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
v3:
- Move the NULL umem check after ctx_exists() so a failed queue is still
  checked for a duplicate context, as before.
- Shorten the "at capacity" log to one line and drop the count (always
  the max here).
- Also clear txq->umem, not just rxq->umem, when setup fails.
- Clarify "AF_XDP socket" in the doc.

 doc/guides/nics/af_xdp.rst          |  7 +++++++
 drivers/net/af_xdp/rte_eth_af_xdp.c | 19 ++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

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
index 2cdb533276..3838d52d5d 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -1154,6 +1154,9 @@ get_shared_umem(struct pkt_rx_queue *rxq, const char *ifname,
 					ret = -1;
 					goto out;
 				}
+				/* A failed setup leaves mb_pool set with no umem. */
+				if (internals->rx_queues[i].umem == NULL)
+					continue;
 				if (rte_atomic_load_explicit(&internals->rx_queues[i].umem->refcnt,
 						    rte_memory_order_acquire)) {
 					*umem = internals->rx_queues[i].umem;
@@ -1188,9 +1191,16 @@ xsk_umem_info *xdp_umem_configure(struct pmd_internals *internals,
 		if (get_shared_umem(rxq, internals->if_name, &umem) < 0)
 			return NULL;
 
-		if (umem != NULL &&
-			rte_atomic_load_explicit(&umem->refcnt, rte_memory_order_acquire) <
-					umem->max_xsks) {
+		if (umem != NULL) {
+			/* Reject sharing once the UMEM is at capacity. */
+			if (rte_atomic_load_explicit(&umem->refcnt,
+					rte_memory_order_acquire) >= umem->max_xsks) {
+				AF_XDP_LOG_LINE(ERR, "%s,qid%i: UMEM %s already at max %u sockets",
+						internals->if_name, rxq->xsk_queue_idx,
+						umem->mb_pool->name, umem->max_xsks);
+				return NULL;
+			}
+
 			AF_XDP_LOG_LINE(INFO, "%s,qid%i sharing UMEM",
 					internals->if_name, rxq->xsk_queue_idx);
 			rte_atomic_fetch_add_explicit(&umem->refcnt, 1, rte_memory_order_acquire);
@@ -1818,6 +1828,9 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
 out_umem:
 	if (rte_atomic_fetch_sub_explicit(&rxq->umem->refcnt, 1, rte_memory_order_acquire) - 1 == 0)
 		xdp_umem_destroy(rxq->umem);
+	/* Drop dangling pointers so a later shared-UMEM scan skips this queue. */
+	rxq->umem = NULL;
+	txq->umem = NULL;
 
 	return ret;
 }
-- 
2.27.0

