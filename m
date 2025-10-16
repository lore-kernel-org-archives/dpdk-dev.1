Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC45CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 10:28:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5153D4278F;
	Thu, 16 Oct 2025 12:28:14 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id A9F2640E2B;
 Thu, 16 Oct 2025 12:28:09 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 693821A2718;
 Thu, 16 Oct 2025 12:28:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 33B4C1A270E;
 Thu, 16 Oct 2025 12:28:09 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A28B4180009C;
 Thu, 16 Oct 2025 18:28:08 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Brick Yang <brick.yang@nxp.com>
Subject: [PATCH v2 03/15] net/dpaa2: fix L3/L4 csum results in packet parse
Date: Thu, 16 Oct 2025 15:57:53 +0530
Message-ID: <20251016102805.2453687-4-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
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

From: Brick Yang <brick.yang@nxp.com>

Layer3 and layer4 checksum validation and error
status is part of word1 of annotation area, but
driver is looking into wrong word.
This patch fixes the checksum error status in packet
parsing.

Fixes: 94d31549c380 ("net/dpaa2: support Rx checksum offload in slow parsing")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Brick Yang <brick.yang@nxp.com>
---
 drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h | 10 +++++-----
 drivers/net/dpaa2/dpaa2_rxtx.c               | 16 ++++------------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h b/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
index d156b07087..a670098958 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016,2019 NXP
+ *   Copyright 2016,2019,2022,2024 NXP
  *
  */
 
@@ -304,13 +304,13 @@ struct dpaa2_faead {
 #define DPAA2_ETH_FAS_PHE	       0x00000020
 #define DPAA2_ETH_FAS_BLE	       0x00000010
 /* L3 csum validation performed */
-#define DPAA2_ETH_FAS_L3CV	      0x00000008
+#define DPAA2_ETH_FAS_L3CV	      0x0000000800000000
 /* L3 csum error */
-#define DPAA2_ETH_FAS_L3CE	      0x00000004
+#define DPAA2_ETH_FAS_L3CE	      0x0000000400000000
 /* L4 csum validation performed */
-#define DPAA2_ETH_FAS_L4CV	      0x00000002
+#define DPAA2_ETH_FAS_L4CV	      0x0000000200000000
 /* L4 csum error */
-#define DPAA2_ETH_FAS_L4CE	      0x00000001
+#define DPAA2_ETH_FAS_L4CE	      0x0000000100000000
 
 #ifdef __cplusplus
 }
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 656a3a423f..da0c06caad 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -201,14 +201,10 @@ dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
 		goto parse_done;
 	}
 
-	if (BIT_ISSET_AT_POS(annotation->word8, DPAA2_ETH_FAS_L3CE))
+	if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L3CE))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
-	else
-		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
-	if (BIT_ISSET_AT_POS(annotation->word8, DPAA2_ETH_FAS_L4CE))
+	else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CE))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
-	else
-		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
 
 	if (BIT_ISSET_AT_POS(annotation->word4, L3_IP_1_FIRST_FRAGMENT |
 	    L3_IP_1_MORE_FRAGMENT |
@@ -248,14 +244,10 @@ dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
 	DPAA2_PMD_DP_DEBUG("(fast parse) Annotation = 0x%" PRIx64 "\t",
 			   annotation->word4);
 
-	if (BIT_ISSET_AT_POS(annotation->word8, DPAA2_ETH_FAS_L3CE))
+	if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L3CE))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
-	else
-		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
-	if (BIT_ISSET_AT_POS(annotation->word8, DPAA2_ETH_FAS_L4CE))
+	else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CE))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
-	else
-		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
 
 	if (unlikely(dpaa2_print_parser_result))
 		dpaa2_print_parse_result(annotation);
-- 
2.43.0

