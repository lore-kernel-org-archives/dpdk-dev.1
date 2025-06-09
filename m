Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54201C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:39:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 201F1427B1;
	Mon,  9 Jun 2025 17:38:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id CE3754279A
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749483486; x=1781019486;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TTMLDqKqRhp4/hssFeJAMZsGfC8mQkjWRlun1ysqRzI=;
 b=XuYjexsoG4zhkZO7bipXs1u0mgmnnIRipHYGtTR4sk7DDVhAxqmpKCRg
 tRXo6EB1m5krEa57IFJdwydiB3FTihEpX+JjrwmqML8ug2GY5wi3JbwDX
 eMp6mkAgDDGuS0ruHZmEGE4rlq+gkOd5/7f8pi1ZRo7goRpSTNSfR9jsm
 otZMBBN5JaTcLhuZp8Cy4A1aAK6RTt4BtLI6zrxgV89RrIv16f6xd1pJz
 Mtc3tabr79BT+o9QEdKGyZs3GwKrCEi0AyTDqm7Oud6LP90GbrsLFgUGY
 x8luNVdGc+qPMjnLj9qaz2CS0dGY4SGpuXA/8moj48HOqazSkHpV7rn4C Q==;
X-CSE-ConnectionGUID: m11tmkuBTcSIHnkM/8PPFQ==
X-CSE-MsgGUID: KCKrjEE8T4yYymRZl2PKLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69012179"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="69012179"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:38:06 -0700
X-CSE-ConnectionGUID: 08Z2prqXQUOeMTFVDL51ag==
X-CSE-MsgGUID: cNL9amCSTVOMwAeZoGBIAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151419644"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 08:38:04 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v6 12/33] net/ixgbe: decouple scalar and vec rxq free mbufs
Date: Mon,  9 Jun 2025 16:37:10 +0100
Message-ID: <738618797c9573e2946b20e87abcbefd4fcdc684.1749483382.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749483381.git.anatoly.burakov@intel.com>
 <cover.1749483381.git.anatoly.burakov@intel.com>
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

Currently, vector Rx queue release mbufs function is only called from
inside the scalar variant. Decouple them to allow both to be defined
separately from each other, and provide a common function that picks
between the two when necessary.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v5 -> v6:
    - Rename functions to _vec and _non_vec, and keep common name as is
    
    v5:
    - Add this commit

 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 0777f70a4b..0b949c3cfc 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2967,16 +2967,10 @@ ixgbe_free_sc_cluster(struct rte_mbuf *m)
 }
 
 static void __rte_cold
-ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
+ixgbe_rx_queue_release_mbufs_non_vec(struct ixgbe_rx_queue *rxq)
 {
 	unsigned i;
 
-	/* SSE Vector driver has a different way of releasing mbufs. */
-	if (rxq->vector_rx) {
-		ixgbe_rx_queue_release_mbufs_vec(rxq);
-		return;
-	}
-
 	if (rxq->sw_ring != NULL) {
 		for (i = 0; i < rxq->nb_rx_desc; i++) {
 			if (rxq->sw_ring[i].mbuf != NULL) {
@@ -3003,6 +2997,15 @@ ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
 			}
 }
 
+static void __rte_cold
+ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
+{
+	if (rxq->vector_rx)
+		ixgbe_rx_queue_release_mbufs_vec(rxq);
+	else
+		ixgbe_rx_queue_release_mbufs_non_vec(rxq);
+}
+
 static void __rte_cold
 ixgbe_rx_queue_release(struct ixgbe_rx_queue *rxq)
 {
-- 
2.47.1

