Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD18C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 11:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A50FE40281;
	Thu,  5 Jun 2025 13:32:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 91D494026C
 for <dev@dpdk.org>; Thu,  5 Jun 2025 13:32:06 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5553uHB3023744;
 Thu, 5 Jun 2025 04:32:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=MvUUZq/VO6Dt2Z1LLONkvOh
 51wzlBIqdLBYp8qdujQA=; b=Q/6EwH+Vwfl92Jwl1+d0wyTUUPEGZmEBZ27FOXn
 86+DYmtNafQpLP4BNoRnnje2u0NJDIv/MJTTxmRZmTFZSzpn0hQjAoW1Jc3xfw4n
 lRuLekODD7h0VIyndvKvBNLvBxUELtJFEFT1ruKrFBx2HKvKrMfcFFpsQwwXDp03
 p9aal3U7GN+2FAn9aUVYZ57q3+BALnzA5aj9Hyubeoc4IKHa+egvUdWsKqbyWvat
 fvtoCvZffGRIE+/NARXrUSttBrYoWqYMGZ+HKG548Bh1O7oF33F5cK4kLm4BBb2k
 CS5aLJ2qbmxcAiTeiI324Y/fSyrvc5aH+lbwz5AaE+rrHKw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 472yursa3s-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 04:32:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Jun 2025 04:32:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Jun 2025 04:32:03 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 169B53F7051;
 Thu,  5 Jun 2025 04:32:00 -0700 (PDT)
From: <skori@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: [PATCH] ethdev: add support to provide link type
Date: Thu, 5 Jun 2025 17:01:51 +0530
Message-ID: <20250605113159.3035480-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=YuQPR5YX c=1 sm=1 tr=0 ts=68418034 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=e7TSJhjt3jzX47LFvJAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: v7pDPnpvPBsDMF142F3glX0N7NQIl7us
X-Proofpoint-ORIG-GUID: v7pDPnpvPBsDMF142F3glX0N7NQIl7us
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA5OSBTYWx0ZWRfX77NPR9KE9vun
 79HZqceBWgbiKDmvQR+Bj6hC+jGlTd9kE1n4G0ID+91fh1+RlfndPZB+aNkd37r4TR8HGpPTBpE
 pDxM8mOsdhrvbIJGUcfqCjd9imz0PT6cJeaIUrS5T59amp1yoKZQj5aqL9WSB+fKUqdjocDUQJD
 EtEtIA5u+/zodvsicg4zt/kIN1LQZExYk/FsH+JCZrc3fIUPhKFsQa9W7V3t3JRDCRm02HuBlGi
 6179xQ/nOX3R1FWIvYnM0PYASFbT1flEYa6jJLZxhfa+TxJiKeWB3JJkTVSLAbqNeNFzawgpaYM
 7+YA8gDFIptZ1LFPaBfxnkNhTH9bo5Mvi2Un9T7HA7mQNgROfHnhwSTYenxcz+7s1v8KmWfHBgs
 Q9a//bhkwH4gnH7L2bzOE1oSQpgUmwk+Bw1G/xIhqB4eG5zqyfkL8AJw0X0TK+cR4T3o4rLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
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

From: Sunil Kumar Kori <skori@marvell.com>

As a port can be configured at one of the supported speed
which can be part of specific link mode.

Port type helps to translate speed into the respective mode.

Hence add support to provide link type as part of link
status if available from ethdev driver.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 lib/ethdev/ethdev_trace.h        |  7 +++++
 lib/ethdev/ethdev_trace_points.c |  3 +++
 lib/ethdev/rte_ethdev.c          | 45 ++++++++++++++++++++++++++++++--
 lib/ethdev/rte_ethdev.h          | 28 ++++++++++++++++++++
 4 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index c65b78590a..a060e2de03 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -2110,6 +2110,13 @@ RTE_TRACE_POINT_FP(
 	rte_trace_point_emit_string(ret);
 )
 
+RTE_TRACE_POINT_FP(
+	rte_eth_trace_link_type_to_str,
+	RTE_TRACE_POINT_ARGS(uint8_t link_type, const char *ret),
+	rte_trace_point_emit_u8(link_type);
+	rte_trace_point_emit_string(ret);
+);
+
 /* Called in loop in examples/bond and examples/ethtool */
 RTE_TRACE_POINT_FP(
 	rte_eth_trace_macaddr_get,
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index 071c508327..706acdf356 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -206,6 +206,9 @@ RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_speed_to_str,
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_to_str,
 	lib.ethdev.link_to_str)
 
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_type_to_str,
+	lib.ethdev.link_type_to_str)
+
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_stats_get,
 	lib.ethdev.stats_get)
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d4197322a0..73a38ea2ca 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3286,18 +3286,59 @@ rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
 	if (eth_link->link_status == RTE_ETH_LINK_DOWN)
 		ret = snprintf(str, len, "Link down");
 	else
-		ret = snprintf(str, len, "Link up at %s %s %s",
+		ret = snprintf(str, len, "Link up at %s %s %s %s",
 			rte_eth_link_speed_to_str(eth_link->link_speed),
 			(eth_link->link_duplex == RTE_ETH_LINK_FULL_DUPLEX) ?
 			"FDX" : "HDX",
 			(eth_link->link_autoneg == RTE_ETH_LINK_AUTONEG) ?
-			"Autoneg" : "Fixed");
+			"Autoneg" : "Fixed",
+			rte_eth_link_type_to_str(eth_link->link_type));
 
 	rte_eth_trace_link_to_str(len, eth_link, str, ret);
 
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_type_to_str, 25.07)
+const char *
+rte_eth_link_type_to_str(uint8_t link_type)
+{
+	const char *ret;
+
+	switch (link_type) {
+	case RTE_ETH_LINK_TYPE_NONE:
+		ret = "None";
+		break;
+	case RTE_ETH_LINK_TYPE_TP:
+		ret = "Twisted Pair";
+		break;
+	case RTE_ETH_LINK_TYPE_AUI:
+		ret = "AUI";
+		break;
+	case RTE_ETH_LINK_TYPE_MII:
+		ret = "MII";
+		break;
+	case RTE_ETH_LINK_TYPE_FIBRE:
+		ret = "Fibre";
+		break;
+	case RTE_ETH_LINK_TYPE_BNC:
+		ret = "BNC";
+		break;
+	case RTE_ETH_LINK_TYPE_DA:
+		ret = "Direct Attach Copper";
+		break;
+	case RTE_ETH_LINK_TYPE_OTHER:
+		ret = "Other";
+		break;
+	default:
+		ret = "Invalid";
+	}
+
+	rte_eth_trace_link_type_to_str(link_type, ret);
+
+	return ret;
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_stats_get)
 int
 rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ea7f8c4a1a..19417242ca 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -329,6 +329,19 @@ struct rte_eth_stats {
 #define RTE_ETH_SPEED_NUM_UNKNOWN UINT32_MAX /**< Unknown */
 /**@}*/
 
+/**@{@name PORT type
+ * Ethernet port type
+ */
+#define RTE_ETH_LINK_TYPE_NONE  0x00 /**< Not defined */
+#define RTE_ETH_LINK_TYPE_TP    0x01 /**< Twisted Pair */
+#define RTE_ETH_LINK_TYPE_AUI   0x02 /**< Attachment Unit Interface */
+#define RTE_ETH_LINK_TYPE_MII   0x03 /**< Media Independent Interface */
+#define RTE_ETH_LINK_TYPE_FIBRE 0x04 /**< Fibre */
+#define RTE_ETH_LINK_TYPE_BNC   0x05 /**< BNC */
+#define RTE_ETH_LINK_TYPE_DA    0x06 /**< Direct Attach copper */
+#define RTE_ETH_LINK_TYPE_OTHER 0x1F /**< Other type */
+/**@}*/
+
 /**
  * A structure used to retrieve link-level information of an Ethernet port.
  */
@@ -341,6 +354,7 @@ struct rte_eth_link {
 			uint16_t link_duplex  : 1;  /**< RTE_ETH_LINK_[HALF/FULL]_DUPLEX */
 			uint16_t link_autoneg : 1;  /**< RTE_ETH_LINK_[AUTONEG/FIXED] */
 			uint16_t link_status  : 1;  /**< RTE_ETH_LINK_[DOWN/UP] */
+			uint16_t link_type    : 5;  /**< RTE_ETH_LINK_TYPE_XXX */
 		};
 	};
 };
@@ -3113,6 +3127,20 @@ int rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *link)
 __rte_experimental
 const char *rte_eth_link_speed_to_str(uint32_t link_speed);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * This function converts an Ethernet link type to a string.
+ *
+ * @param link_type
+ *   The link type to convert.
+ * @return
+ *   The string representation of the link type.
+ */
+__rte_experimental
+const char *rte_eth_link_type_to_str(uint8_t link_type);
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
-- 
2.43.0

