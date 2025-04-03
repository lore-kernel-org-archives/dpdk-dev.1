Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E90AC3601B
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 07:08:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B7DF4060C;
	Thu,  3 Apr 2025 09:08:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 49A894060A
 for <dev@dpdk.org>; Thu,  3 Apr 2025 09:08:46 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5333BUGo003083;
 Thu, 3 Apr 2025 00:08:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Xn6yiTY3v6aTGl3d18Qcjd6
 DTSqukM+kAkcY4Upnq84=; b=dftF5sAX6iHzoD/SZCnrwF3f9sq0C4intS+0iwI
 PUjKVY3g+dqvDgjxSU0SPeTPYRNBlE76nDld8bV/pNvG+/fqjJND5xA7hcCURQcN
 SfXoBVkwfVVI4ctxfaA4HrHbuh3CTMGcj5CC69FQJH3p53Eo8cSoeRZlhClNKRa9
 RLsFmLtaWwj3fV6zp7jwHoGGyoUaV894mKzSXQLjrv/Su8FE3Lq1stcdGjd/mNaL
 QVA7KAEGvnia48cM/gO0YCm72ykkjG3Py1RnRgxH6duTGjo/gwJg/QyPQCXzp8mM
 DWyYc1IONsFuBk+L2eL3nlMk4hspwUg7m038kZ+z9g5KwFA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45s5h526b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 00:08:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 00:08:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Apr 2025 00:08:42 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id AD3A53F70DA;
 Thu,  3 Apr 2025 00:08:40 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>
Subject: [RFC PATCH 1/4] ethdev: add support to provide link type
Date: Thu, 3 Apr 2025 12:38:34 +0530
Message-ID: <20250403070837.926292-1-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: P_BH9g4Nwx_tu9tkGtdHVUemPAW7Yw4w
X-Authority-Analysis: v=2.4 cv=FYE3xI+6 c=1 sm=1 tr=0 ts=67ee33fb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=e7TSJhjt3jzX47LFvJAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: P_BH9g4Nwx_tu9tkGtdHVUemPAW7Yw4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
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

Add support to provide link type as part of link status
if available from ethdev driver. Link type such as Fibre,
Twisted-Pair etc is generally available information in PMD or
lower layer software and is a useful information for DPDK
applications. Similar info is also available via ethtool
for Linux kernel netdevs.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 lib/ethdev/ethdev_trace.h        |  7 +++++
 lib/ethdev/ethdev_trace_points.c |  3 +++
 lib/ethdev/rte_ethdev.c          | 44 ++++++++++++++++++++++++++++++--
 lib/ethdev/rte_ethdev.h          | 28 ++++++++++++++++++++
 lib/ethdev/version.map           |  1 +
 5 files changed, 81 insertions(+), 2 deletions(-)

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
index cb99cf91fc..e6dee5f668 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -199,6 +199,9 @@ RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_speed_to_str,
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_to_str,
 	lib.ethdev.link_to_str)
 
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_type_to_str,
+	lib.ethdev.link_type_to_str)
+
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_stats_get,
 	lib.ethdev.stats_get)
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 85798d0ebc..9e993199f5 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3221,18 +3221,58 @@ rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
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
 int
 rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
 {
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ea7f8c4a1a..ccbb657fb9 100644
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
+			uint16_t link_type    : 5;  /**< RTE_ETH_LINK_TYPE_* */
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
diff --git a/lib/ethdev/version.map b/lib/ethdev/version.map
index 3aacba8614..5910ed10a5 100644
--- a/lib/ethdev/version.map
+++ b/lib/ethdev/version.map
@@ -216,6 +216,7 @@ EXPERIMENTAL {
 	rte_eth_hairpin_unbind;
 	rte_eth_link_speed_to_str;
 	rte_eth_link_to_str;
+	rte_eth_link_type_to_str;
 	rte_eth_fec_get_capability;
 	rte_eth_fec_get;
 	rte_eth_fec_set;
-- 
2.34.1

