Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104C2C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:11:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DC4540DDA;
	Fri,  6 Jun 2025 19:09:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3188F40E11
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749229790; x=1780765790;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qQbmxTzDWvVayMfUxi25N2OFEJRBDc0A6KoF9xjzkhY=;
 b=jXgucOwLetSjMdWySkrEesJMxkpTnfZijQ05Vx5oaBTN1/+UKOYFN2N7
 vWM4gYaPegA+veqFd5CxK3bJYQ5vbXUqaw6XVJI2EWVGvrCM6YPvv+bTW
 eZznce9gsdIJwp1ZcEBmDn76U0UnDwT4YUfIRjibW3eLuMdt2qGJHzjMu
 W8rB5gKlsqqv46ZUEK33CgRMEoSfuoVpfxCd0D3OAd8KpJzMLBJRqtpTt
 yb4lEMafJiwj393Tvlxti+L8bFAHFAWcXmZeFFyK0Kdy5dbutKOgru2EA
 i+6nY7sPsUU4VYEAh5uvSEdiAEfiFOYXxRtjCp2pJyUn7kFxdixrB8LaL Q==;
X-CSE-ConnectionGUID: YARlEKCkQU2OG3xTyAYbaQ==
X-CSE-MsgGUID: nVbUKCVoS6Snrzuh1QrHBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68828430"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="68828430"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:09:50 -0700
X-CSE-ConnectionGUID: E76PEsK3QUa1Dofjcw23ZA==
X-CSE-MsgGUID: kwM7CmCzQUWyFq9S8hGHfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="145808182"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa010.jf.intel.com with ESMTP; 06 Jun 2025 10:09:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v5 13/34] net/ixgbe: decouple scalar and vec rxq free mbufs
Date: Fri,  6 Jun 2025 18:08:52 +0100
Message-ID: <4d611236d5fee9b9315093d889fe0a41a7c6cef2.1749229650.git.anatoly.burakov@intel.com>
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

Currently, vector Rx queue release mbufs function is only called from
inside the scalar variant. Decouple them to allow both to be defined
separately from each other, and provide a common function that picks
between the two when necessary.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v5:
    - Add this commit

 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index fad4a01a10..ecd1f38ac5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2970,12 +2970,6 @@ ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
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
@@ -3002,11 +2996,20 @@ ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
 			}
 }
 
+static void __rte_cold
+ixgbe_rx_queue_release_mbufs_common(struct ixgbe_rx_queue *rxq)
+{
+	if (rxq->vector_rx)
+		ixgbe_rx_queue_release_mbufs_vec(rxq);
+	else
+		ixgbe_rx_queue_release_mbufs(rxq);
+}
+
 static void __rte_cold
 ixgbe_rx_queue_release(struct ixgbe_rx_queue *rxq)
 {
 	if (rxq != NULL) {
-		ixgbe_rx_queue_release_mbufs(rxq);
+		ixgbe_rx_queue_release_mbufs_common(rxq);
 		rte_free(rxq->sw_ring);
 		rte_free(rxq->sw_sc_ring);
 		rte_memzone_free(rxq->mz);
@@ -3501,7 +3504,7 @@ ixgbe_dev_clear_queues(struct rte_eth_dev *dev)
 		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
 
 		if (rxq != NULL) {
-			ixgbe_rx_queue_release_mbufs(rxq);
+			ixgbe_rx_queue_release_mbufs_common(rxq);
 			ixgbe_reset_rx_queue(adapter, rxq);
 			dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 		}
@@ -5701,7 +5704,7 @@ ixgbe_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 
 	rte_delay_us(RTE_IXGBE_WAIT_100_US);
 
-	ixgbe_rx_queue_release_mbufs(rxq);
+	ixgbe_rx_queue_release_mbufs_common(rxq);
 	ixgbe_reset_rx_queue(adapter, rxq);
 	dev->data->rx_queue_state[rx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
-- 
2.47.1

