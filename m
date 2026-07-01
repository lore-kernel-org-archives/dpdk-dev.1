Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6462C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB372402E0;
	Wed,  1 Jul 2026 10:23:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 93BC040278;
 Wed,  1 Jul 2026 10:23:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782894224; x=1814430224;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kSENlYEnLHkDLuBxkNLNKNRq9ZyxxSgVqIioSuuxM3I=;
 b=cz/j2nBn7A78GTqJDrrxaBGkOdAxeQsuzYfMlurrCujVRjObRBZbu3w+
 0oUoxBBVB73tMzPPAXpueD8C+ujeqAapqvHWx0twxzvFF/YPWVmPKF1fY
 cWkvoXpxmhhj3WvkcOdbRSYvb8tUSyNZ5hm39YrrT4sPj6S/H6k0Hxt5E
 kgGHLpEBPqksxEPocK0klzKTxFBhWYUJszIiONwX5RpRKw641rBQno+2p
 freDpMK+DUhBDCZb2MezUheFYoClM6zEcqlvVYUJEGYRxmRoV6vgSmWzP
 BkR2Xth1GPxQIl6jAd6Dwb5lmrlH/A29G2NxrJ5fgEh3vzTWnJXV18fk+ w==;
X-CSE-ConnectionGUID: OmgGvNieTuSDqCnxnNI25g==
X-CSE-MsgGUID: ErTUxadWQRCXTi5uaeG2Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83491674"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="83491674"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 01:23:43 -0700
X-CSE-ConnectionGUID: Pw0KjAESQDGUaJlue8qbUQ==
X-CSE-MsgGUID: q+lXUqaBTqGnovJikvM4MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="257405308"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 01:23:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH v2] net/idpf: fix Tx of large mbuf segments
Date: Wed,  1 Jul 2026 09:23:37 +0100
Message-ID: <20260701082337.3176970-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626134440.2108591-1-bruce.richardson@intel.com>
References: <20260626134440.2108591-1-bruce.richardson@intel.com>
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

When TSO is enabled, and we get a packet to transmit where an individual
mbuf segment is longer than 16k, we need to split that segment across
multiple Tx descriptors. This support is present in the single-queue
mode of idpf - since it shares common code with the other Intel drivers
-  but was missing from the splitq path.

This patch adds the proper data path handling. Previous work ensured
that the descriptor count calculation took over-sized segments into
account but the actual descriptor writing part was overlooked.

Fixes: 770f4dfe0f79 ("net/idpf: support basic Tx data path")
Fixes: 2904020f8313 ("net/intel: add common function to calculate needed descs")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
V2: change check for number of free descriptor slots to use the correct
    count, rather than just the number of mbuf segments passed
---
 drivers/net/intel/idpf/idpf_common_rxtx.c | 43 ++++++++++++++++++-----
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index a123d969ee..2c87e02c98 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -952,9 +952,6 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				idpf_split_tx_free(txq->complq);
 		}
 
-		if (txq->nb_tx_free < tx_pkt->nb_segs)
-			break;
-
 		cmd_dtype = 0;
 		ol_flags = tx_pkt->ol_flags;
 		tx_offload.l2_len = tx_pkt->l2_len;
@@ -976,6 +973,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		else
 			nb_used = tx_pkt->nb_segs + nb_ctx;
 
+		if (txq->nb_tx_free < nb_used)
+			break;
+
 		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
 			cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
 
@@ -994,16 +994,43 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		uint16_t first_sw_id = sw_id;
 
 		do {
+			uint16_t slen = tx_pkt->data_len;
+			rte_iova_t buf_dma_addr = rte_mbuf_data_iova(tx_pkt);
+
+			/* Split segment across multiple descriptors if needed
+			 * for TSO packets where segment exceeds max buf size.
+			 */
+			while ((ol_flags & RTE_MBUF_F_TX_TCP_SEG) &&
+					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
+				txd = &txr[tx_id];
+				txn = &sw_ring[txe->next_id];
+				txe->mbuf = NULL;
+
+				txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
+				txd->qw1.cmd_dtype = cmd_dtype |
+					IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
+				txd->qw1.rxr_bufsize = CI_MAX_DATA_PER_TXD;
+				txd->qw1.compl_tag = sw_id;
+
+				buf_dma_addr += CI_MAX_DATA_PER_TXD;
+				slen -= CI_MAX_DATA_PER_TXD;
+
+				tx_id++;
+				if (tx_id == txq->nb_tx_desc)
+					tx_id = 0;
+				sw_id = txe->next_id;
+				txe = txn;
+			}
+
 			txd = &txr[tx_id];
 			txn = &sw_ring[txe->next_id];
 			txe->mbuf = tx_pkt;
 
 			/* Setup TX descriptor */
-			txd->buf_addr =
-				rte_cpu_to_le_64(rte_mbuf_data_iova(tx_pkt));
-			cmd_dtype |= IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
-			txd->qw1.cmd_dtype = cmd_dtype;
-			txd->qw1.rxr_bufsize = tx_pkt->data_len;
+			txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
+			txd->qw1.cmd_dtype = cmd_dtype |
+				IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
+			txd->qw1.rxr_bufsize = slen;
 			txd->qw1.compl_tag = sw_id;
 			tx_id++;
 			if (tx_id == txq->nb_tx_desc)
-- 
2.53.0

