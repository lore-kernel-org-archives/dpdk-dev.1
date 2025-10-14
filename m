Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482E1CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:20:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 355D140669;
	Tue, 14 Oct 2025 09:20:12 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9974E40288;
 Tue, 14 Oct 2025 08:00:47 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 806591A1BF9;
 Tue, 14 Oct 2025 08:00:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4AAE11A1BE2;
 Tue, 14 Oct 2025 08:00:47 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5DCE71800091;
 Tue, 14 Oct 2025 14:00:46 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Brick Yang <brick.yang@nxp.com>
Subject: [PATCH 03/15] net/dpaa2: fix L3/L4 csum results in packet parse
Date: Tue, 14 Oct 2025 11:30:33 +0530
Message-ID: <20251014060045.1304694-4-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
References: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 14 Oct 2025 09:20:04 +0200
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
 drivers/net/dpaa2/dpaa2_rxtx.c               | 17 ++---------------
 2 files changed, 7 insertions(+), 20 deletions(-)

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
index 656a3a423f..6cb91e67d4 100644
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
@@ -248,15 +244,6 @@ dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
 	DPAA2_PMD_DP_DEBUG("(fast parse) Annotation = 0x%" PRIx64 "\t",
 			   annotation->word4);
 
-	if (BIT_ISSET_AT_POS(annotation->word8, DPAA2_ETH_FAS_L3CE))
-		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
-	else
-		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
-	if (BIT_ISSET_AT_POS(annotation->word8, DPAA2_ETH_FAS_L4CE))
-		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
-	else
-		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
-
 	if (unlikely(dpaa2_print_parser_result))
 		dpaa2_print_parse_result(annotation);
 
-- 
2.43.0

