Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59648606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NqgHUGgu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7642402C3;
	Tue, 17 Nov 2026 12:30:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTPS id BB2B24026F;
 Tue, 17 Nov 2026 12:30:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794915030; x=1826451030;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wr0zdnmhjVlpqs1iBWvzgHUgEBWw2rJb9N+I8HewSrg=;
 b=NqgHUGgun5vOrgrWG3Wr/K1LKQ6s344mDtSZUnPcJgbP4p5614I1NDkv
 T+P6HOzx49UeFLNv33Ka3SR+OcU4roELOfLhY9qig3hIE4oD+Owfl5K9N
 o4dUVy7p/YBKtCi3t50CCq1JRn+VaAxk/vDqnKCrA9oMlKQLwwjrbm3I4
 rMyqEFx6SoKA0p92A60fPv33oNJAzWBH9nFLh212Oiocl8RSSiNDMmEIR
 6rNtAdvFD9HuLmpNtjQOqKZSIJ++XaQ+x/mknmX1KA12pCn6SJKE75E/h
 0CF9OnRV606GI95+EZsRcH+Rj5NEsOhlrCher5JIGUKBH3037PPslZSAg g==;
X-CSE-ConnectionGUID: 1QFUy9wHTzGEvyD7YxFJVg==
X-CSE-MsgGUID: /HKvnvOBT6OX4r6Feyka3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3576480"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3576480"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 03:30:27 -0800
X-CSE-ConnectionGUID: Tr2y7dwlRTSjXHGoCk+6SQ==
X-CSE-MsgGUID: kKYClCbPS2qQSwvErnh/4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9898122"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 17 Nov 2026 03:30:26 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Tony U <tony@compilex.com>
Subject: [PATCH] raw/ntb: fix Tx of incomplete packets
Date: Tue, 17 Nov 2026 11:30:17 +0000
Message-ID: <20261117113017.2225641-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a Tx descriptor had no room, a zero length or an unmappable
address, the Tx burst stopped after its software ring entry had already
been set to the mbuf, which is still owned by the application. On
device stop, that mbuf was freed a second time.

For multi-segment mbufs, a failure on a later segment also left the
earlier segments enqueued and published to the peer without EOP, with
their ring entries referencing application-owned mbufs.

Check all descriptors of a packet before consuming any of them,
so that the ring is only updated for complete packets.

Bugzilla ID: 2134
Fixes: 11b5c7daf019 ("raw/ntb: add enqueue and dequeue functions")
Cc: stable@dpdk.org

Reported-by: Tony U <tony@compilex.com>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/raw/ntb/ntb.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 85354b54ed..94802d5f20 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -576,12 +576,13 @@ ntb_enqueue_bufs(struct rte_rawdev *dev,
 	struct ntb_tx_entry *sw_ring = txq->sw_ring;
 	struct rte_mbuf *txm;
 	struct ntb_used tx_used[NTB_MAX_DESC_SIZE];
+	void *seg_addr[NTB_MAX_DESC_SIZE];
+	uint16_t seg_len[NTB_MAX_DESC_SIZE];
 	volatile struct ntb_desc *tx_item;
 	uint16_t tx_last, nb_segs, off, last_used, avail_cnt;
 	uint16_t nb_mbufs = 0;
 	uint16_t nb_tx = 0;
 	uint64_t bytes = 0;
-	void *buf_addr;
 	int i;
 
 	if (unlikely(dev->started == 0 || !ntb_peer_dev_is_up(hw))) {
@@ -600,35 +601,43 @@ ntb_enqueue_bufs(struct rte_rawdev *dev,
 		if (txm == NULL || txq->nb_tx_free < txm->nb_segs)
 			break;
 
-		tx_last = (txq->last_used + txm->nb_segs - 1) &
-			  (txq->nb_tx_desc - 1);
 		nb_segs = txm->nb_segs;
+		/* Check all descriptors first so a packet is never partially enqueued. */
 		for (i = 0; i < nb_segs; i++) {
+			const uint16_t idx = (txq->last_used + i) & (txq->nb_tx_desc - 1);
+
 			/* Not enough ring space for tx. */
-			if (txq->last_used == avail_cnt)
+			if (idx == avail_cnt)
 				goto end_of_tx;
-			sw_ring[txq->last_used].mbuf = txm;
-			tx_item = txq->tx_desc_ring + txq->last_used;
+			tx_item = txq->tx_desc_ring + idx;
 
-			if (!tx_item->len) {
+			seg_len[i] = tx_item->len;
+			if (seg_len[i] == 0) {
 				(hw->ntb_xstats[NTB_TX_ERRS_ID + off])++;
 				goto end_of_tx;
 			}
-			if (txm->data_len > tx_item->len) {
-				NTB_LOG(ERR, "Data length exceeds buf length."
-					" Only %u data would be transmitted.",
-					tx_item->len);
-				txm->data_len = tx_item->len;
-			}
 
 			/* translate remote virtual addr to bar virtual addr */
-			buf_addr = (*hw->ntb_ops->ioremap)(dev, tx_item->addr);
-			if (buf_addr == NULL) {
+			seg_addr[i] = (*hw->ntb_ops->ioremap)(dev, tx_item->addr);
+			if (seg_addr[i] == NULL) {
 				(hw->ntb_xstats[NTB_TX_ERRS_ID + off])++;
 				NTB_LOG(ERR, "Null remap addr.");
 				goto end_of_tx;
 			}
-			rte_memcpy(buf_addr, rte_pktmbuf_mtod(txm, void *),
+		}
+
+		tx_last = (txq->last_used + nb_segs - 1) & (txq->nb_tx_desc - 1);
+		for (i = 0; i < nb_segs; i++) {
+			sw_ring[txq->last_used].mbuf = txm;
+
+			if (txm->data_len > seg_len[i]) {
+				NTB_LOG(ERR, "Data length exceeds buf length."
+					" Only %u data would be transmitted.",
+					seg_len[i]);
+				txm->data_len = seg_len[i];
+			}
+
+			rte_memcpy(seg_addr[i], rte_pktmbuf_mtod(txm, void *),
 				   txm->data_len);
 
 			tx_used[nb_mbufs].len = txm->data_len;
-- 
2.55.0

