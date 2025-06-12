Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AEFC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:13:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9F5041153;
	Thu, 12 Jun 2025 13:12:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4C942411F3
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726737; x=1781262737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zR2iShE9V074Wy0A2hrbtfLO8z6qRHJT4gU7Qe2ZqOE=;
 b=S8cRABguDhB3FeXw+5XrmEvj6jn4L3rjFw8FC7HsvJNBB0kFOAUTv8P5
 hBsJ4W+oYqigGj4pUFpImSVpukIKLR5jp5Huo5yOpVyYo+LfMjQFmyM4o
 HUJpl3Zr4kFiM62XCVcfIrhstMcRo55h2n2OAAnUcOsB4veydIpFvd1iQ
 NvJDdYVmFnAGiGBgHDWF+CAuJB4mcpIZL7urGgHHOrWg2Zc9/dsy2O2PU
 JIagNYDvnmZAzp3oD8pKMCpzTiy2GNWSdmVhrEKuwg/h4qbWxRrESp1U2
 Tff4Hn4LPgojCCatUTkZp710LMTgnpLP2MB7uOLtdvGTL07E8qidGpUqs A==;
X-CSE-ConnectionGUID: Fl4si6pvTNCqRiEyYZRgQg==
X-CSE-MsgGUID: 5Ipgn6ojTUuLcEmw2LK1/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177555"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177555"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:16 -0700
X-CSE-ConnectionGUID: F6rL0zluRCyFuwwE/dv5Ng==
X-CSE-MsgGUID: c1BTTTqbT7+eLl3nCA0vng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371344"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 13/33] net/ixgbe: rename vector txq free mbufs
Date: Thu, 12 Jun 2025 12:11:19 +0100
Message-ID: <1022b541a96422a464994c877ef3fd10c6ddca7f.1749726639.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
References: 
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

There is no reason why scalar and vector implementations of tx free mbufs
function have to share the same name, in fact it is counter-productive
because including `ixgbe_rxtx_vec_common.h` from `ixgbe_rxtx.c` will cause
naming clashes. Rename the vector implementation to avoid naming clashes.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v5:
    - Add this patch

 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h | 2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c   | 2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
index 018010820f..9e1abf4449 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
@@ -12,7 +12,7 @@
 #include "ixgbe_rxtx.h"
 
 static __rte_always_inline int
-ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
+ixgbe_tx_free_bufs_vec(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry_vec *txep;
 	uint32_t status;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
index f8916d44e8..3a0b2909a7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
@@ -583,7 +583,7 @@ ixgbe_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ixgbe_tx_free_bufs(txq);
+		ixgbe_tx_free_bufs_vec(txq);
 
 	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	if (unlikely(nb_pkts == 0))
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
index 9417e5b11f..1e063bb243 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
@@ -703,7 +703,7 @@ ixgbe_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ixgbe_tx_free_bufs(txq);
+		ixgbe_tx_free_bufs_vec(txq);
 
 	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	if (unlikely(nb_pkts == 0))
-- 
2.47.1

