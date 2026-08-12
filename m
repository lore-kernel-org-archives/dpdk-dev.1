Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BABC5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 15:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7E0540264;
	Wed, 12 Aug 2026 17:07:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E22424025F;
 Wed, 12 Aug 2026 17:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786547222; x=1818083222;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=v0OqySReIxtgQo3DTYD17ToKqj89QRpuR8rB4/nGuzU=;
 b=U/QULVToIIH4lHg1V/fq0jMmjYFL9aneDYABOLIY3qK3xtZ54M7ud2iV
 uN31XgeucgSGag//qCli2PSdyTi/stlh1w+93rlkOO/SVSTlbcFL08/P4
 msoiqX2cjPLknel6c8NwC6AuSJyqFPfVfpDSixo0CFpq1EfppRvOLLDnE
 Q/PQSLqzwA7WCuRp+Jp+wWzUb7Ka1N9N08RGx6Gk+aiCO0xjwpqxlnA4B
 lxBP2AIZYXAOj5qI6K/wD+mnLVq9dz/Vp8LE/PQAWH/A/1/nH1EfCvhCw
 GBNPDHZhNFr53wZPu37SI5WpxnRMS9V52s0q5IaPzfYUInjHZ3KRwt4sa w==;
X-CSE-ConnectionGUID: bBuSod3eST2Ck+XaKJM1Og==
X-CSE-MsgGUID: jkADHHVyRN62wX22X7MVmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86065419"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="86065419"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 08:07:01 -0700
X-CSE-ConnectionGUID: iW4WydtmQzasBx4Iiid1GQ==
X-CSE-MsgGUID: ofrf0ZQ+QQmNJGgFAHbl7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="263195486"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by orviesa008.jf.intel.com with ESMTP; 12 Aug 2026 08:06:59 -0700
From: sandeep.penigalapati@intel.com
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 stable@dpdk.org, Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v1] net/af_xdp: fix shared UMEM refcount corruption
Date: Wed, 12 Aug 2026 18:08:43 -0400
Message-Id: <20260812220843.75727-1-sandeep.penigalapati@intel.com>
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

Reject sharing once the UMEM is at capacity by returning NULL, so queue
setup fails cleanly with -ENOMEM. This enforces the per-mempool socket
limit that shared UMEM was always intended to respect. Also document the
shared mempool sizing requirement (4096 mbufs per socket).

Fixes: 74b46340e2d4 ("net/af_xdp: support shared UMEM")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 doc/guides/nics/af_xdp.rst          |  5 +++++
 drivers/net/af_xdp/rte_eth_af_xdp.c | 24 ++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/af_xdp.rst b/doc/guides/nics/af_xdp.rst
index c455b4c066..00ba89dc97 100644
--- a/doc/guides/nics/af_xdp.rst
+++ b/doc/guides/nics/af_xdp.rst
@@ -99,6 +99,11 @@ configured like so:
     --vdev net_af_xdp0,iface=ens786f1,shared_umem=1 \
     --vdev net_af_xdp1,iface=ens786f2,shared_umem=1
 
+The shared mempool must be large enough for every socket sharing the UMEM. Each
+socket requires 4096 mbufs, so a UMEM shared by ``N`` sockets needs at least
+``4096 * N`` mbufs. Port initialisation fails if the mempool is too small to
+add another socket to the UMEM.
+
 xdp_prog
 ~~~~~~~~
 
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..6ef76bd60a 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -1188,12 +1188,28 @@ xsk_umem_info *xdp_umem_configure(struct pmd_internals *internals,
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
-			rte_atomic_fetch_add_explicit(&umem->refcnt, 1, rte_memory_order_acquire);
+			rte_atomic_fetch_add_explicit(&umem->refcnt, 1,
+					rte_memory_order_acquire);
 		}
 	}
 
-- 
2.27.0

