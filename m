Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7221FC61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:11:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79E9A40E03;
	Fri,  6 Jun 2025 19:09:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id ABAAC40E03
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749229792; x=1780765792;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=146ee9e5nDe+hXkqpDQwZLAZCUdX0+uPeEifoXcJe7Q=;
 b=f4ya9lHA0npUO2/9ASPXqT0+UBt0oQeFJpr1nV/7w0pnhJActuJCCket
 /n3FBBihJbrjpxf6YdQDgYmZXuK1EIt8qI3BcbRPa8SyjJQLrxGf3yCI3
 yuxNIvtEPZz2HK0OGqzbgmxK8XYwccOM4kJ9W7/YZYp67AfUKtIHMsnDX
 8Ib2BeNh+cvQ1LMZrJl5VSkCPhod4l1oCqDcbaNNgJWERg3PH0mPKuMZR
 WFixag4RUX8/3rDTVZStZkATRqKxa8pcldRAGHdHiXe1O/sX3QQgap3xp
 9ivLjxgdvRn4C9X5hRz0xfmbo3NkYZvWuf9Cbe62/xGpba4NkFZbClU8x w==;
X-CSE-ConnectionGUID: kwbcwG9gQ7+8sfWsGEpaDw==
X-CSE-MsgGUID: 7KfEnibdS9WZfStJhLh4vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68828432"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="68828432"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:09:51 -0700
X-CSE-ConnectionGUID: YcyC2Q4WRoqCtxyf4VnBew==
X-CSE-MsgGUID: Kad7QwMUQI6UBFBnl0zW7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="145808187"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa010.jf.intel.com with ESMTP; 06 Jun 2025 10:09:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v5 14/34] net/ixgbe: rename vector txq free mbufs
Date: Fri,  6 Jun 2025 18:08:53 +0100
Message-ID: <783f1afd4f23d38f21b2ce5e0c97f2efa1f8bbab.1749229650.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
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
function have to share the same name. Fix it.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v5:
    - Add this commit

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

