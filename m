Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CB8C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 13:44:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66FCF40264;
	Fri, 26 Jun 2026 15:44:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 068BE4025F;
 Fri, 26 Jun 2026 15:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782481492; x=1814017492;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vrYcD88Abls8Ljm6FRxuuzHPG5GViLRzPsmjeHOGig8=;
 b=B4CQek6QZZsrKNb77xCgpHh8Ob4nKDSPtLAX72WibKibz+rowQ4F/kNo
 c1HTsmaEV39DJh7Y2zeTfkEN0CJYwaNd8Avzqzkxo9n1Q3qB+pE8ySP2J
 JZmdC+AFaLGJKUGQlJ91L2M/xl3FuQp1lCd7tWlak47RTZgMqZhNGopeY
 qlKquDOgEXNikGWgO5xmVPdbf21LiFJEY274Ppp+fQHuABI/YxVCEugwy
 pciFZWorIiBqncFJ344XSJOXnLVz7QQhfsusORWBWrUxNQOaalSY/grCC
 iZ2ADz1BGHpBFuw8TWPZJNLXPoNy5VGuQo62TQ/4MhxlW32LZvHlVkwFi w==;
X-CSE-ConnectionGUID: zaZ3Oe3VS/yET0KDYZJUzA==
X-CSE-MsgGUID: TQ9MU/ZtTCC/1MLPTqJLZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="100822304"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="100822304"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 06:44:51 -0700
X-CSE-ConnectionGUID: aR0BvSWbTaSWpgYtSQdvMQ==
X-CSE-MsgGUID: RCh1kaqGTxWihN5IPR1zbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="249663454"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 26 Jun 2026 06:44:49 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org, Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Xiaoyun Li <xiaoyun.li@intel.com>, Beilei Xing <beilei.xing@intel.com>,
 Junfeng Guo <junfengg@nvidia.com>
Subject: [PATCH] net/idpf: fix Tx of large mbuf segments
Date: Fri, 26 Jun 2026 14:43:37 +0100
Message-ID: <20260626134440.2108591-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303150026.1601461-1-bruce.richardson@intel.com>
References: <20260303150026.1601461-1-bruce.richardson@intel.com>
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
v2: rework implementation based on changes to the idpf driver
    since v1 was submitted.
---
 drivers/net/intel/idpf/idpf_common_rxtx.c | 37 ++++++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index a123d969ee..8aa61a2af4 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
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

