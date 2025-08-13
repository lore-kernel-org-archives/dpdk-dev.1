Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6561ECA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 08:45:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FBA54021F;
	Wed, 13 Aug 2025 10:45:16 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4AD10400EF
 for <dev@dpdk.org>; Wed, 13 Aug 2025 10:45:15 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNSqSF030202;
 Wed, 13 Aug 2025 01:45:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
 Q+eYZMrKZSEr6p5Rrsykr0iNBaWWJWaf6uvk3e8ok4=; b=HkVmBmc2qAuj9+XkT
 OrpqfljaLVjJKtLE0TtRQzffRLL5EAzm6oH01fYQnm2SSFrcdfXDgf0L01FRMWKD
 k4iyWNwn4FBTm4wBLnhSaqHJLq/ISKClZXs2rbXxCWPOkMTfdCKymVfU6tTIPv3i
 eZv7YNo99WAxYqRJ3Jiu3l3zZNbDqVI6gMjG41w2J1LEvrg97FssunRPQRJebee+
 E45EHyOzwyv8d0yqeEa8k3UCr8Kp0V1y3aBKhb6NRyUZza4knKwn+KxZWHRB05WO
 hM21fsGJT1p/Pjqm+20HqpRxPjGOsvrd+k42ga+LRl4UKHqDRvVNSH0wlAmsvokt
 DEXag==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48gfan8vxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 01:45:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Aug 2025 01:45:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Aug 2025 01:45:16 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 6E8BC5B6922;
 Wed, 13 Aug 2025 01:45:11 -0700 (PDT)
From: <skori@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: [PATCH v3 1/1] ethdev: add support to provide link type
Date: Wed, 13 Aug 2025 14:13:56 +0530
Message-ID: <20250813084508.1446318-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606092904.3145608-1-skori@marvell.com>
References: <20250606092904.3145608-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA4NCBTYWx0ZWRfXzut7m2QYVaob
 /1Pj3G7MfGuFkzmbRqhXTsc387LdFxfZX9Cg8WIGipei8sZkqKxZQiPXLBefGFzBHCgcZJ7dzn9
 S4qoolx2iO+r5BBZiJLB3umywerSfc7UZUoKPab8P2eGcudWyooaNKDs8BmI0o3A8q2e1Y9C4GB
 WJ7DQBATEFB4R19O2UhFw2eVfyp968ODwnA1TYX5969e20mkSqYEFwCP/xLhlsi0ktKZp2l9xky
 644SGY9mAwg7HIAaMwjadE6YQ21yOfI+AIw2CtoaTKptodZy0aalGlUWmPRsQDwemLhERftd4g6
 Q7Okof02SYBnQdZT19UqNYJ6PMkI6Ownj4/E9l/KQPgKHGaveAKz4sJrV+4Qpa0ADNbuOha1FlX
 tHTgQna0IJxjtbXySEuzGszW+s+Ab0TuRrCkl4ESjcLq1D4xTTMDmRJ6zMKuwTazTTNddF/h
X-Proofpoint-ORIG-GUID: GsSOYtzyvnP3H2kctN1H4ORAEDGfapNz
X-Authority-Analysis: v=2.4 cv=bNMWIO+Z c=1 sm=1 tr=0 ts=689c5099 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=iVWQqrl_jNQ_lGDvCO0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: GsSOYtzyvnP3H2kctN1H4ORAEDGfapNz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
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

Adding link type parameter to provide the type
of port like twisted pair, fibre etc.

Also added an API to convert the RTE_ETH_LINK_TYPE_XXX
to a readable string.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
v2..v3
 - Extend link type list as per suggestion

 lib/ethdev/ethdev_trace.h        |  7 +++++
 lib/ethdev/ethdev_trace_points.c |  3 ++
 lib/ethdev/rte_ethdev.c          | 47 ++++++++++++++++++++++++++++++--
 lib/ethdev/rte_ethdev.h          | 47 ++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index 482befc209..c5cba0edba 100644
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
index dd7c00bc94..0cf4a805b7 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3285,18 +3285,61 @@ rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
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
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_type_to_str, 25.11)
+const char *
+rte_eth_link_type_to_str(uint8_t link_type)
+{
+	static const char * const link_type_str[] = {
+		[RTE_ETH_LINK_TYPE_NONE] = "None",
+		[RTE_ETH_LINK_TYPE_TP] = "Twisted Pair",
+		[RTE_ETH_LINK_TYPE_AUI] = "Attachment Unit Interface",
+		[RTE_ETH_LINK_TYPE_MII] = "Media Independent Interface",
+		[RTE_ETH_LINK_TYPE_FIBRE] = "Fibre",
+		[RTE_ETH_LINK_TYPE_BNC] = "BNC",
+		[RTE_ETH_LINK_TYPE_DA] = "Direct Attach Copper",
+		[RTE_ETH_LINK_TYPE_SGMII] = "SGMII",
+		[RTE_ETH_LINK_TYPE_QSGMII] = "QSGMII",
+		[RTE_ETH_LINK_TYPE_XFI] = "XFI",
+		[RTE_ETH_LINK_TYPE_SFI] = "SFI",
+		[RTE_ETH_LINK_TYPE_XLAUI] = "XLAUI",
+		[RTE_ETH_LINK_TYPE_GAUI] = "GAUI",
+		[RTE_ETH_LINK_TYPE_XAUI] = "XAUI",
+		[RTE_ETH_LINK_TYPE_GBASE] = "GBASE",
+		[RTE_ETH_LINK_TYPE_CAUI] = "CAUI",
+		[RTE_ETH_LINK_TYPE_LAUI] = "LAUI",
+		[RTE_ETH_LINK_TYPE_SFP] = "SFP",
+		[RTE_ETH_LINK_TYPE_SFP_DD] = "SFP_DD",
+		[RTE_ETH_LINK_TYPE_SFP_PLUS] = "SFP_PLUS",
+		[RTE_ETH_LINK_TYPE_SFP28] = "SFP28",
+		[RTE_ETH_LINK_TYPE_QSFP] = "QSFP",
+		[RTE_ETH_LINK_TYPE_QSFP_PLUS] = "QSFP_PLUS",
+		[RTE_ETH_LINK_TYPE_QSFP28] = "QSFP28",
+		[RTE_ETH_LINK_TYPE_QSFP56] = "QSFP56",
+		[RTE_ETH_LINK_TYPE_QSFP_DD] = "QSFP_DD",
+		[RTE_ETH_LINK_TYPE_OTHER] = "Unknown"
+	};
+	const char *str = NULL;
+
+	if ((link_type < RTE_DIM(link_type_str)) && link_type_str[link_type])
+		str = link_type_str[link_type];
+
+	rte_eth_trace_link_type_to_str(link_type, str);
+	return str;
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_stats_get)
 int
 rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index f9fb6ae549..e82e50017f 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -329,6 +329,38 @@ struct rte_eth_stats {
 #define RTE_ETH_SPEED_NUM_UNKNOWN UINT32_MAX /**< Unknown */
 /**@}*/
 
+/**@{@name PORT type
+ * Ethernet port type
+ */
+#define RTE_ETH_LINK_TYPE_NONE     0  /**< Not defined */
+#define RTE_ETH_LINK_TYPE_TP       1  /**< Twisted Pair */
+#define RTE_ETH_LINK_TYPE_AUI      2  /**< Attachment Unit Interface */
+#define RTE_ETH_LINK_TYPE_MII      3  /**< Media Independent Interface */
+#define RTE_ETH_LINK_TYPE_FIBRE    4  /**< Fibre */
+#define RTE_ETH_LINK_TYPE_BNC      5  /**< BNC */
+#define RTE_ETH_LINK_TYPE_DA       6  /**< Direct Attach copper */
+#define RTE_ETH_LINK_TYPE_SGMII    7  /**< SGMII */
+#define RTE_ETH_LINK_TYPE_QSGMII   8  /**< QSGMII */
+#define RTE_ETH_LINK_TYPE_XFI      9  /**< XFI */
+#define RTE_ETH_LINK_TYPE_SFI     10  /**< SFI */
+#define RTE_ETH_LINK_TYPE_XLAUI   11  /**< XLAUI */
+#define RTE_ETH_LINK_TYPE_GAUI    12  /**< GAUI */
+#define RTE_ETH_LINK_TYPE_XAUI    13  /**< XAUI */
+#define RTE_ETH_LINK_TYPE_GBASE   14  /**< GBASE */
+#define RTE_ETH_LINK_TYPE_CAUI    15  /**< CAUI */
+#define RTE_ETH_LINK_TYPE_LAUI    16  /**< LAUI */
+#define RTE_ETH_LINK_TYPE_SFP     17  /**< SFP */
+#define RTE_ETH_LINK_TYPE_SFP_DD  18  /**< SFP_DD */
+#define RTE_ETH_LINK_TYPE_SFP_PLUS 19  /**< SFP_PLUS */
+#define RTE_ETH_LINK_TYPE_SFP28   20  /**< SFP28 */
+#define RTE_ETH_LINK_TYPE_QSFP    21  /**< QSFP */
+#define RTE_ETH_LINK_TYPE_QSFP_PLUS 22  /**< QSFP_PLUS */
+#define RTE_ETH_LINK_TYPE_QSFP28  23  /**< QSFP28 */
+#define RTE_ETH_LINK_TYPE_QSFP56  24  /**< QSFP56 */
+#define RTE_ETH_LINK_TYPE_QSFP_DD 25  /**< QSFP_DD */
+#define RTE_ETH_LINK_TYPE_OTHER  0x1F /**< Other type */
+/**@}*/
+
 /**
  * A structure used to retrieve link-level information of an Ethernet port.
  */
@@ -341,6 +373,7 @@ struct rte_eth_link {
 			uint16_t link_duplex  : 1;  /**< RTE_ETH_LINK_[HALF/FULL]_DUPLEX */
 			uint16_t link_autoneg : 1;  /**< RTE_ETH_LINK_[AUTONEG/FIXED] */
 			uint16_t link_status  : 1;  /**< RTE_ETH_LINK_[DOWN/UP] */
+			uint16_t link_type    : 5;  /**< RTE_ETH_LINK_TYPE_XXX */
 		};
 	};
 };
@@ -3116,6 +3149,20 @@ int rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *link)
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

