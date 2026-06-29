Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E9DC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 05:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CF434021E;
	Mon, 29 Jun 2026 07:18:23 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id AEA10400D7;
 Mon, 29 Jun 2026 07:18:21 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BA6E200002;
 Mon, 29 Jun 2026 07:18:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 43DE4200007;
 Mon, 29 Jun 2026 07:18:21 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 65A771800071;
 Mon, 29 Jun 2026 13:18:20 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 1/9] net/enetc: fix TX BD structure
Date: Mon, 29 Jun 2026 10:48:11 +0530
Message-Id: <20260629051819.989176-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260629051819.989176-1-g.singh@nxp.com>
References: <20260623060004.2187716-1-g.singh@nxp.com>
 <20260629051819.989176-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

The flags field in struct enetc_tx_bd was declared as uint16_t but
ENETC4 TX BDs only use an 8-bit flags byte. Fix the type to uint8_t
to match the hardware descriptor layout.

Fixes: 696fa399d797 ("net/enetc: add PMD with basic operations")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/enetc/base/enetc_hw.h |  7 +++----
 drivers/net/enetc/enetc_rxtx.c    | 17 +++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index 173d677..19efadd 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2024 NXP
+ * Copyright 2018-2026 NXP
  */
 
 #ifndef _ENETC_HW_H_
@@ -198,8 +198,7 @@ enum enetc_bdr_type {TX, RX};
 
 #define ENETC_TX_ADDR(txq, addr) ((void *)((txq)->enetc_txbdr + (addr)))
 
-#define ENETC_TXBD_FLAGS_IE		BIT(13)
-#define ENETC_TXBD_FLAGS_F		BIT(15)
+#define ENETC_TXBD_FLAGS_F		BIT(7)
 
 /* ENETC Parsed values (Little Endian) */
 #define ENETC_PARSE_ERROR		0x8000
@@ -262,7 +261,7 @@ struct enetc_tx_bd {
 			uint8_t l3t:1;
 			uint8_t resv:5;
 			uint8_t l4t:3;
-			uint16_t flags;
+			uint8_t flags;
 		};/* default layout */
 		uint32_t txstart;
 		uint32_t lstatus;
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index a2b8153..d3b98b3 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2024 NXP
+ * Copyright 2018-2026 NXP
  */
 
 #include <stdbool.h>
@@ -101,7 +101,7 @@ enetc_xmit_pkts(void *tx_queue,
 		tx_swbd = &tx_ring->q_swbd[i];
 		txbd->frm_len = tx_pkts[start]->pkt_len;
 		txbd->buf_len = txbd->frm_len;
-		txbd->flags = rte_cpu_to_le_16(ENETC_TXBD_FLAGS_F);
+		txbd->flags = ENETC_TXBD_FLAGS_F;
 		txbd->addr = (uint64_t)(uintptr_t)
 		rte_cpu_to_le_64((size_t)tx_swbd->buffer_addr->buf_iova +
 				 tx_swbd->buffer_addr->data_off);
@@ -133,13 +133,13 @@ enetc4_tx_offload_checksum(struct rte_mbuf *mbuf, struct enetc_tx_bd *txbd)
 		txbd->ipcs = ENETC4_TXBD_IPCS;
 		txbd->l3_start = mbuf->l2_len;
 		txbd->l3_hdr_size = mbuf->l3_len / 4;
-		txbd->flags |= rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_L_TX_CKSUM);
+		txbd->flags |= ENETC4_TXBD_FLAGS_L_TX_CKSUM;
 		if ((mbuf->ol_flags & RTE_MBUF_F_TX_UDP_CKSUM) == RTE_MBUF_F_TX_UDP_CKSUM) {
-			txbd->l4t = rte_cpu_to_le_16(ENETC4_TXBD_L4T_UDP);
-			txbd->flags |= rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_L4CS);
+			txbd->l4t = ENETC4_TXBD_L4T_UDP;
+			txbd->flags |= ENETC4_TXBD_FLAGS_L4CS;
 		} else if ((mbuf->ol_flags & RTE_MBUF_F_TX_TCP_CKSUM) == RTE_MBUF_F_TX_TCP_CKSUM) {
-			txbd->l4t = rte_cpu_to_le_16(ENETC4_TXBD_L4T_TCP);
-			txbd->flags |= rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_L4CS);
+			txbd->l4t = ENETC4_TXBD_L4T_TCP;
+			txbd->flags |= ENETC4_TXBD_FLAGS_L4CS;
 		}
 	}
 }
@@ -172,7 +172,7 @@ enetc_xmit_pkts_nc(void *tx_queue,
 			dcbf(data + j);
 
 		txbd = ENETC_TXBD(*tx_ring, i);
-		txbd->flags = rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_F);
+		txbd->flags = 0;
 		if (tx_ring->q_swbd[i].buffer_addr->ol_flags & ENETC4_TX_CKSUM_OFFLOAD_MASK)
 			enetc4_tx_offload_checksum(tx_ring->q_swbd[i].buffer_addr, txbd);
 
@@ -182,6 +182,7 @@ enetc_xmit_pkts_nc(void *tx_queue,
 		txbd->addr = (uint64_t)(uintptr_t)
 		rte_cpu_to_le_64((size_t)tx_swbd->buffer_addr->buf_iova +
 				 tx_swbd->buffer_addr->data_off);
+		txbd->flags |= ENETC4_TXBD_FLAGS_F;
 		i++;
 		start++;
 		if (unlikely(i == tx_ring->bd_count))
-- 
2.25.1

