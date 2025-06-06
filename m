Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279D9C5B559
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 09:29:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5E7640662;
	Fri,  6 Jun 2025 11:29:15 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id AAF3240265
 for <dev@dpdk.org>; Fri,  6 Jun 2025 11:29:13 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555MU6ww015512;
 Fri, 6 Jun 2025 02:29:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
 1BoBR55B244vyAlcQksihuEwhyzLUK3pxg3uUyeen8=; b=UJTcGukoDhe2pG+E2
 wpOS/UQXG7h+oyxuLXp0NeI2872NRcibX45YLY0ka32EFW4IhwS+6Whxixynmhit
 aV3amtY94fgXM5CZsJipuoDCCa99X1QP3IymFr4EXl/tJ539m1Xo3crzFljoCVVf
 tK0Sf/G3wfq1WqGUlJmc8gFBA3dzB4J+D/lAcdqCc23Z7X4KktX4cd0rRWNkHnyK
 ZmzccdcfAvaSTjg0nXNsGGtUlwY1Q/AnUc1eq2WasbZR70dVrMT5YkGdg4/qFi3Q
 uhcI8n8q+GRYxLEbtBjYJRaIEr27+ajdGVRSCiawzg4whm/X1cSMy5k/yw74mgBQ
 k/8jQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 473m3093tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 02:29:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 6 Jun 2025 02:29:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 6 Jun 2025 02:29:10 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id D6F243F704C;
 Fri,  6 Jun 2025 02:29:07 -0700 (PDT)
From: <skori@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: [PATCH v2 1/1] ethdev: add support to provide link type
Date: Fri, 6 Jun 2025 14:58:06 +0530
Message-ID: <20250606092904.3145608-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605113159.3035480-1-skori@marvell.com>
References: <20250605113159.3035480-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TSKOsqmTei4XLLUjNvF5aL6L1aLWraVG
X-Proofpoint-ORIG-GUID: TSKOsqmTei4XLLUjNvF5aL6L1aLWraVG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA4NSBTYWx0ZWRfX7eNqPGf+lG6i
 GN2JX+FaMMtk5fI+UlP0AYqFQ8qsTbQ9VP1GC19Y7uQGcpfBbNgSMMVGwk2ovhoFVSYGGr/0Nqy
 jp1PFAECNwQeujaY8uWaSfR4X8e/wRW9zMVQprz/RTbZk525LfwRO7aMR0PikEiNZaV9qoimp3B
 QIv9mil658aR1eKGxUO7ozxPkq6S+xKPGGrVB7xvSoHUKm1NSIz1NrU/WzEql93pqZK90fZn3Jv
 U5C8CCmVIa9VKjzjVpgzZRuaTalOBOQ+TaHooN3Iq5ePxjdmvRI+RAEJLDsz3PMKeFjFjOqtIG3
 rdTcsB5eY7SaVU52GQsahAwvuGqpWQwkWEd1TN4BImsetkGXNlXza0WmI1XBZ4tViNwsMnh+OFo
 c2vnJ7FSeqpU4eqHUr+86ocjJMLV5STNy5pOUYnVusSNq+hiCb4z3qLi8Qi8pSZIdYtzkvtp
X-Authority-Analysis: v=2.4 cv=dvbbC0g4 c=1 sm=1 tr=0 ts=6842b4e6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=e7TSJhjt3jzX47LFvJAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_02,2025-06-05_01,2025-03-28_01
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
v1..v2:
 - Updated the commit message.
 - change release version to 25.11

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
index d4197322a0..4464ec00e6 100644
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
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_type_to_str, 25.11)
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

