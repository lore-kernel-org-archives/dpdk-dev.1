Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CABC28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 08:25:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47932402B5;
	Wed,  2 Apr 2025 10:25:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 875B04029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 10:25:09 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5327RQJ4014482
 for <dev@dpdk.org>; Wed, 2 Apr 2025 01:25:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=i9h0A4yE0JmzS/eizNPtAwo
 YLI/LviwIF5tHgvk7tss=; b=LmBEja4pwgKRIdqm2Ai7IJLGiH5IMWZ8ipNw/Ky
 YQVhlbPBhlLIaqn7fDLiyrn5qHB0Fy4u4AF/iy7TeUnmWfKPX7nigU40Rk12aSNf
 OW8z9mpkIAFt13O8BBY2OY1kBmjp9pF6NSBfALLpanouacZ05QM7KApEcw81a5O3
 gJHRoB6DIXLkPXyGpXsqjiAy7qzIuWKdbgRaUUGsdxIEBNYXU6byOQqPQx3ySg2c
 xKgmtJyAadrNXw4zxCV4J1QGlAqau2VfBniB2wirKD6k79BVQe9TNAuvIVKuTpL3
 Vdh3RRvoa7rey+1e+Y2bI9RvoT6PVnD3sBszSAfcsxoF1yA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45s0v5068q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 02 Apr 2025 01:25:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 2 Apr 2025 01:25:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 2 Apr 2025 01:25:06 -0700
Received: from cavium-OptiPlex-3070-BM17.. (unknown [10.28.34.33])
 by maili.marvell.com (Postfix) with ESMTP id ABF223F7060;
 Wed,  2 Apr 2025 01:25:03 -0700 (PDT)
From: <psatheesh@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Satheesh Paul <psatheesh@marvell.com>
Subject: [dpdk-dev] [PATCH ] net/cnxk: support ESP based RSS hashing
Date: Wed, 2 Apr 2025 13:54:59 +0530
Message-ID: <20250402082459.785424-1-psatheesh@marvell.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: L-En8ct-PYsT_-gAYBMChOK4JawvYILc
X-Proofpoint-ORIG-GUID: L-En8ct-PYsT_-gAYBMChOK4JawvYILc
X-Authority-Analysis: v=2.4 cv=GOkIEvNK c=1 sm=1 tr=0 ts=67ecf464 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=qgxgCQmrzONHshxSRX8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
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

From: Satheesh Paul <psatheesh@marvell.com>

Support ESP based RSS hashing.

Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
Reviewed-by: Kiran Kumar K <kirankumark@marvell.com>
---
 drivers/common/cnxk/roc_mbox.h |  1 +
 drivers/net/cnxk/cnxk_ethdev.c |  3 ++
 drivers/net/cnxk/cnxk_ethdev.h | 67 ++++++++++++++++------------------
 3 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index a82d120d1d..471b66ec78 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -1777,6 +1777,7 @@ struct nix_rss_flowkey_cfg {
 #define FLOW_KEY_TYPE_CH_LEN_90B    BIT(18)
 #define FLOW_KEY_TYPE_CUSTOM0	    BIT(19)
 #define FLOW_KEY_TYPE_VLAN	    BIT(20)
+#define FLOW_KEY_TYPE_ESP	    BIT(23)
 #define FLOW_KEY_TYPE_L4_DST	    BIT(28)
 #define FLOW_KEY_TYPE_L4_SRC	    BIT(29)
 #define FLOW_KEY_TYPE_L3_DST	    BIT(30)
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 289ae96afa..c116e2cc87 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -935,6 +935,9 @@ cnxk_rss_ethdev_to_nix(struct cnxk_eth_dev *dev, uint64_t ethdev_rss,
 	if (ethdev_rss & RTE_ETH_RSS_GTPU)
 		flowkey_cfg |= FLOW_KEY_TYPE_GTPU;
 
+	if (ethdev_rss & RTE_ETH_RSS_ESP)
+		flowkey_cfg |= FLOW_KEY_TYPE_ESP;
+
 	return flowkey_cfg;
 }
 
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index daf80be51b..d62cc1ec20 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -49,47 +49,44 @@
 /* LPB & SPB */
 #define CNXK_NIX_NUM_POOLS_MAX 2
 
-#define CNXK_NIX_DEF_SQ_COUNT	512
-
-#define CNXK_NIX_RSS_L3_L4_SRC_DST                                             \
-	(RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY |                   \
-	 RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY)
-
-#define CNXK_NIX_RSS_OFFLOAD                                                   \
-	(RTE_ETH_RSS_PORT | RTE_ETH_RSS_IP | RTE_ETH_RSS_UDP |                 \
-	 RTE_ETH_RSS_TCP | RTE_ETH_RSS_SCTP | RTE_ETH_RSS_TUNNEL |             \
-	 RTE_ETH_RSS_L2_PAYLOAD | CNXK_NIX_RSS_L3_L4_SRC_DST |                 \
-	 RTE_ETH_RSS_LEVEL_MASK | RTE_ETH_RSS_C_VLAN)
-
-#define CNXK_NIX_TX_OFFLOAD_CAPA                                               \
-	(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE |          \
-	 RTE_ETH_TX_OFFLOAD_VLAN_INSERT | RTE_ETH_TX_OFFLOAD_QINQ_INSERT |             \
-	 RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM | RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |    \
-	 RTE_ETH_TX_OFFLOAD_TCP_CKSUM | RTE_ETH_TX_OFFLOAD_UDP_CKSUM |                 \
-	 RTE_ETH_TX_OFFLOAD_SCTP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_TSO |                  \
-	 RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO | RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |        \
-	 RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS |              \
+#define CNXK_NIX_DEF_SQ_COUNT 512
+
+#define CNXK_NIX_RSS_L3_L4_SRC_DST                                                                 \
+	(RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY | RTE_ETH_RSS_L4_SRC_ONLY |             \
+	 RTE_ETH_RSS_L4_DST_ONLY)
+
+#define CNXK_NIX_RSS_OFFLOAD                                                                       \
+	(RTE_ETH_RSS_PORT | RTE_ETH_RSS_IP | RTE_ETH_RSS_UDP | RTE_ETH_RSS_TCP |                   \
+	 RTE_ETH_RSS_SCTP | RTE_ETH_RSS_TUNNEL | RTE_ETH_RSS_L2_PAYLOAD |                          \
+	 CNXK_NIX_RSS_L3_L4_SRC_DST | RTE_ETH_RSS_LEVEL_MASK | RTE_ETH_RSS_C_VLAN |                \
+	 RTE_ETH_RSS_ESP)
+
+#define CNXK_NIX_TX_OFFLOAD_CAPA                                                                   \
+	(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE |                      \
+	 RTE_ETH_TX_OFFLOAD_VLAN_INSERT | RTE_ETH_TX_OFFLOAD_QINQ_INSERT |                         \
+	 RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM | RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |                \
+	 RTE_ETH_TX_OFFLOAD_TCP_CKSUM | RTE_ETH_TX_OFFLOAD_UDP_CKSUM |                             \
+	 RTE_ETH_TX_OFFLOAD_SCTP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_TSO |                              \
+	 RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO | RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |                    \
+	 RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS |                          \
 	 RTE_ETH_TX_OFFLOAD_IPV4_CKSUM | RTE_ETH_TX_OFFLOAD_SECURITY)
 
-#define CNXK_NIX_RX_OFFLOAD_CAPA                                               \
-	(RTE_ETH_RX_OFFLOAD_CHECKSUM | RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |         \
-	 RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM | RTE_ETH_RX_OFFLOAD_SCATTER |    \
-	 RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM | RTE_ETH_RX_OFFLOAD_RSS_HASH |    \
-	 RTE_ETH_RX_OFFLOAD_TIMESTAMP | RTE_ETH_RX_OFFLOAD_VLAN_STRIP |        \
+#define CNXK_NIX_RX_OFFLOAD_CAPA                                                                   \
+	(RTE_ETH_RX_OFFLOAD_CHECKSUM | RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |                             \
+	 RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM | RTE_ETH_RX_OFFLOAD_SCATTER |                        \
+	 RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM | RTE_ETH_RX_OFFLOAD_RSS_HASH |                        \
+	 RTE_ETH_RX_OFFLOAD_TIMESTAMP | RTE_ETH_RX_OFFLOAD_VLAN_STRIP |                            \
 	 RTE_ETH_RX_OFFLOAD_SECURITY)
 
-#define RSS_IPV4_ENABLE                                                        \
-	(RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |                            \
-	 RTE_ETH_RSS_NONFRAG_IPV4_UDP | RTE_ETH_RSS_NONFRAG_IPV4_TCP |         \
-	 RTE_ETH_RSS_NONFRAG_IPV4_SCTP)
+#define RSS_IPV4_ENABLE                                                                            \
+	(RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 | RTE_ETH_RSS_NONFRAG_IPV4_UDP |                 \
+	 RTE_ETH_RSS_NONFRAG_IPV4_TCP | RTE_ETH_RSS_NONFRAG_IPV4_SCTP)
 
-#define RSS_IPV6_ENABLE                                                        \
-	(RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |                            \
-	 RTE_ETH_RSS_NONFRAG_IPV6_UDP | RTE_ETH_RSS_NONFRAG_IPV6_TCP |         \
-	 RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
+#define RSS_IPV6_ENABLE                                                                            \
+	(RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 | RTE_ETH_RSS_NONFRAG_IPV6_UDP |                 \
+	 RTE_ETH_RSS_NONFRAG_IPV6_TCP | RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
 
-#define RSS_IPV6_EX_ENABLE                                                     \
-	(RTE_ETH_RSS_IPV6_EX | RTE_ETH_RSS_IPV6_TCP_EX | RTE_ETH_RSS_IPV6_UDP_EX)
+#define RSS_IPV6_EX_ENABLE (RTE_ETH_RSS_IPV6_EX | RTE_ETH_RSS_IPV6_TCP_EX | RTE_ETH_RSS_IPV6_UDP_EX)
 
 #define RSS_MAX_LEVELS 3
 
-- 
2.42.0

