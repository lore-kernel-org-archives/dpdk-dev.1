Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61092CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 18:44:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EB9F40611;
	Fri, 19 Jun 2026 20:44:33 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id C472B40279;
 Fri, 19 Jun 2026 20:44:29 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A96841A0025;
 Fri, 19 Jun 2026 20:44:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 732B51A0020;
 Fri, 19 Jun 2026 20:44:29 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A01DE1800071;
 Sat, 20 Jun 2026 02:44:28 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	stable@dpdk.org
Subject: [PATCH 02/10] net/enetc: fix TX BDs flag overwrite issue
Date: Sat, 20 Jun 2026 00:14:19 +0530
Message-Id: <20260619184427.522518-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619184427.522518-1-g.singh@nxp.com>
References: <20260619184427.522518-1-g.singh@nxp.com>
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

Zero the flags field before setting offload bits and set the
frame-last flag (F) after all descriptor fields are written.
This prevents stale flag bits from a previous packet corrupting
the current descriptor.

Fixes: 72f491f1e53c ("net/enetc: optimize ENETC4 data path")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/enetc/enetc_rxtx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index a2b8153..b44e6f3 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2024 NXP
+ * Copyright 2018-2026 NXP
  */
 
 #include <stdbool.h>
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
+		txbd->flags |= rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_F);
 		i++;
 		start++;
 		if (unlikely(i == tx_ring->bd_count))
-- 
2.25.1

