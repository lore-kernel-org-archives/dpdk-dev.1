Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD3BCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 11:13:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D61C040292;
	Wed, 20 Aug 2025 13:13:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0CBF34027D
 for <dev@dpdk.org>; Wed, 20 Aug 2025 13:13:56 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KABaZ5010264;
 Wed, 20 Aug 2025 04:13:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 A3O8WxC/cT4CEcJ72UvTKh4+UnRDn/Od4EjQV5iMaY=; b=cDT2p1RRJHrWyEDqx
 lwJCuRDr6Ilu6QIUxFADCduGyc33+XyE5qT1f4YD+BOmfGZ/PW8C5Nq8P5apP1Qt
 xO621h7sfr1Uo2CvPB8fVb5wHhYRRx3n/qgBIUhAZmM5YzV7OyZcur6xf/xd4PjM
 /XlyphMevVMdDr3wOWADJptj1OkkkX3B1GblMv84D3sYGBX+A4owv/UuuGsZhzi/
 rG79o9+ZTybCCLcahmWBBONC5d0eITyc10Pmfzu0JfQjfTSQcdz7lF4LOcgqQ7Nq
 w+iAtm0137lFZWi4+Y2hc3xfTyuO6Bf6DguqIXAFE5TJc/EEZxrl8Qmoph+x756a
 mFc1g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nccs83an-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 04:13:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 04:13:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 04:13:59 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 226633F7091;
 Wed, 20 Aug 2025 04:13:52 -0700 (PDT)
From: <skori@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: [PATCH v6 1/1] ethdev: add support to provide link type
Date: Wed, 20 Aug 2025 16:43:11 +0530
Message-ID: <20250820111350.2992591-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819055126.2745262-1-skori@marvell.com>
References: <20250819055126.2745262-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=J6TzLAnS c=1 sm=1 tr=0 ts=68a5adf3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=1cRrDpktbWZE8ceIGrAA:9
 a=D7HC5XXFw0fsHaIj:21 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDA5OCBTYWx0ZWRfX8dJTYtfIdZnf
 +f9v8Qqph9VFWNu0HcYrRMgP9+FAhKMzotuWCuYPrkz+8sUJJxuNv9vvDLZBydloJcqeziVN41M
 pO0QBIZEg/VE9b6IGQY28m3l+YTk32hyiWgpPIEH9VkRMqKDoiLndAH4omirCwm9qI9VvXt9DIV
 eWTyKHghbN07WZ9TSsOXPvSiYc79J2XNenxxhS09VMEpp6enTwMXyH26h6k1df6QcDwhW+qfyc6
 fAY/R71ct/B5+N2RYnLlszm1Jeem/DJPHOX79mqU/s58e0iktW+9GICbldwMUBSrv6b6M+TF9uD
 xeKgqIHxJcunkEavnkqIegpcEwM/D/vSYMye2Ffjly7/49a1++oo+BQ9sE3i7h1EEa0FwgmXdw3
 K0ic02yIRGHlOdkCd53qn/L8/+KmbiJpZBrQBZLFfmhZYTsrznm/GFYCNtKdkqfbkPOA9yBM
X-Proofpoint-GUID: wwTUelpBpH703csczrIdjLsN7s-MgEni
X-Proofpoint-ORIG-GUID: wwTUelpBpH703csczrIdjLsN7s-MgEni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
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
v5..v6:
 - Fix doxygen error.
v4..v5:                                                                                             
 - Convert link type to connector.
 - Fix build error on Windows.
 - Handle comsmetic review comments.
v3..v4:
 - Convert #define into enum.
 - Enhance comments for each port link type.
 - Fix test failures.
v2..v3
 - Extend link type list as per suggestion

 app/test/test_ethdev_link.c      | 18 +++++++-----
 lib/ethdev/ethdev_trace.h        |  7 +++++
 lib/ethdev/ethdev_trace_points.c |  3 ++
 lib/ethdev/rte_ethdev.c          | 47 ++++++++++++++++++++++++++++--
 lib/ethdev/rte_ethdev.h          | 50 ++++++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 9 deletions(-)

diff --git a/app/test/test_ethdev_link.c b/app/test/test_ethdev_link.c
index f063a5fe26..a951d64faa 100644
--- a/app/test/test_ethdev_link.c
+++ b/app/test/test_ethdev_link.c
@@ -17,23 +17,25 @@ test_link_status_up_default(void)
 		.link_speed = RTE_ETH_SPEED_NUM_2_5G,
 		.link_status = RTE_ETH_LINK_UP,
 		.link_autoneg = RTE_ETH_LINK_AUTONEG,
-		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX
+		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
+		.link_type = RTE_ETH_LINK_CONNECTOR_OTHER
 	};
 	char text[RTE_ETH_LINK_MAX_STR_LEN];
 
 	ret = rte_eth_link_to_str(text, sizeof(text), &link_status);
 	RTE_TEST_ASSERT(ret > 0, "Failed to format default string\n");
 	printf("Default link up #1: %s\n", text);
-	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at 2.5 Gbps FDX Autoneg",
+	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at 2.5 Gbps FDX Autoneg Other",
 		text, strlen(text), "Invalid default link status string");
 
 	link_status.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
 	link_status.link_autoneg = RTE_ETH_LINK_FIXED;
 	link_status.link_speed = RTE_ETH_SPEED_NUM_10M;
+	link_status.link_type = RTE_ETH_LINK_CONNECTOR_SGMII;
 	ret = rte_eth_link_to_str(text, sizeof(text), &link_status);
 	printf("Default link up #2: %s\n", text);
 	RTE_TEST_ASSERT(ret > 0, "Failed to format default string\n");
-	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at 10 Mbps HDX Fixed",
+	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at 10 Mbps HDX Fixed SGMII",
 		text, strlen(text), "Invalid default link status "
 		"string with HDX");
 
@@ -41,7 +43,7 @@ test_link_status_up_default(void)
 	ret = rte_eth_link_to_str(text, sizeof(text), &link_status);
 	printf("Default link up #3: %s\n", text);
 	RTE_TEST_ASSERT(ret > 0, "Failed to format default string\n");
-	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at Unknown HDX Fixed",
+	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at Unknown HDX Fixed SGMII",
 		text, strlen(text), "Invalid default link status "
 		"string with HDX");
 
@@ -49,7 +51,7 @@ test_link_status_up_default(void)
 	ret = rte_eth_link_to_str(text, sizeof(text), &link_status);
 	printf("Default link up #3: %s\n", text);
 	RTE_TEST_ASSERT(ret > 0, "Failed to format default string\n");
-	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at None HDX Fixed",
+	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at None HDX Fixed SGMII",
 		text, strlen(text), "Invalid default link status "
 		"string with HDX");
 
@@ -57,6 +59,7 @@ test_link_status_up_default(void)
 	link_status.link_speed = RTE_ETH_SPEED_NUM_400G;
 	link_status.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
 	link_status.link_autoneg = RTE_ETH_LINK_AUTONEG;
+	link_status.link_type = RTE_ETH_LINK_CONNECTOR_GAUI;
 	ret = rte_eth_link_to_str(text, sizeof(text), &link_status);
 	printf("Default link up #4:len = %d, %s\n", ret, text);
 	RTE_TEST_ASSERT(ret < RTE_ETH_LINK_MAX_STR_LEN,
@@ -92,7 +95,8 @@ test_link_status_invalid(void)
 		.link_speed = 55555,
 		.link_status = RTE_ETH_LINK_UP,
 		.link_autoneg = RTE_ETH_LINK_AUTONEG,
-		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX
+		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
+		.link_type = RTE_ETH_LINK_CONNECTOR_OTHER
 	};
 	char text[RTE_ETH_LINK_MAX_STR_LEN];
 
@@ -100,7 +104,7 @@ test_link_status_invalid(void)
 	RTE_TEST_ASSERT(ret < RTE_ETH_LINK_MAX_STR_LEN,
 		"Failed to format invalid string\n");
 	printf("invalid link up #1: len=%d %s\n", ret, text);
-	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at Invalid FDX Autoneg",
+	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at Invalid FDX Autoneg Other",
 		text, strlen(text), "Incorrect invalid link status string");
 
 	return TEST_SUCCESS;
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
index dd7c00bc94..7b267a81a4 100644
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
+rte_eth_link_type_to_str(enum rte_eth_link_connector link_type)
+{
+	static const char * const link_type_str[] = {
+		[RTE_ETH_LINK_CONNECTOR_NONE] = "None",
+		[RTE_ETH_LINK_CONNECTOR_TP] = "Twisted Pair",
+		[RTE_ETH_LINK_CONNECTOR_AUI] = "Attachment Unit Interface",
+		[RTE_ETH_LINK_CONNECTOR_MII] = "Media Independent Interface",
+		[RTE_ETH_LINK_CONNECTOR_FIBER] = "Fiber",
+		[RTE_ETH_LINK_CONNECTOR_BNC] = "BNC",
+		[RTE_ETH_LINK_CONNECTOR_DAC] = "Direct Attach Copper",
+		[RTE_ETH_LINK_CONNECTOR_SGMII] = "SGMII",
+		[RTE_ETH_LINK_CONNECTOR_QSGMII] = "QSGMII",
+		[RTE_ETH_LINK_CONNECTOR_XFI] = "XFI",
+		[RTE_ETH_LINK_CONNECTOR_SFI] = "SFI",
+		[RTE_ETH_LINK_CONNECTOR_XLAUI] = "XLAUI",
+		[RTE_ETH_LINK_CONNECTOR_GAUI] = "GAUI",
+		[RTE_ETH_LINK_CONNECTOR_XAUI] = "XAUI",
+		[RTE_ETH_LINK_CONNECTOR_CAUI] = "CAUI",
+		[RTE_ETH_LINK_CONNECTOR_LAUI] = "LAUI",
+		[RTE_ETH_LINK_CONNECTOR_SFP] = "SFP",
+		[RTE_ETH_LINK_CONNECTOR_SFP_DD] = "SFP-DD",
+		[RTE_ETH_LINK_CONNECTOR_SFP_PLUS] = "SFP+",
+		[RTE_ETH_LINK_CONNECTOR_SFP28] = "SFP28",
+		[RTE_ETH_LINK_CONNECTOR_QSFP] = "QSFP",
+		[RTE_ETH_LINK_CONNECTOR_QSFP_PLUS] = "QSFP+",
+		[RTE_ETH_LINK_CONNECTOR_QSFP28] = "QSFP28",
+		[RTE_ETH_LINK_CONNECTOR_QSFP56] = "QSFP56",
+		[RTE_ETH_LINK_CONNECTOR_QSFP_DD] = "QSFP-DD",
+		[RTE_ETH_LINK_CONNECTOR_OTHER] = "Other",
+	};
+	const char *str = NULL;
+
+	if ((link_type < ((enum rte_eth_link_connector)RTE_DIM(link_type_str))) &&
+		link_type_str[link_type])
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
index f9fb6ae549..4ed7e20d0b 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -329,6 +329,41 @@ struct rte_eth_stats {
 #define RTE_ETH_SPEED_NUM_UNKNOWN UINT32_MAX /**< Unknown */
 /**@}*/
 
+/**
+ * @enum rte_eth_link_connector
+ * @brief Ethernet port link connector type
+ *
+ * This enum defines the possible types of Ethernet port link connectors.
+ */
+enum rte_eth_link_connector {
+	RTE_ETH_LINK_CONNECTOR_NONE = 0,     /**< Not defined */
+	RTE_ETH_LINK_CONNECTOR_TP,           /**< Twisted Pair */
+	RTE_ETH_LINK_CONNECTOR_AUI,          /**< Attachment Unit Interface */
+	RTE_ETH_LINK_CONNECTOR_MII,          /**< Media Independent Interface */
+	RTE_ETH_LINK_CONNECTOR_FIBER,        /**< Optical Fiber Link */
+	RTE_ETH_LINK_CONNECTOR_BNC,          /**< BNC Link type for RF connection */
+	RTE_ETH_LINK_CONNECTOR_DAC,          /**< Direct Attach copper */
+	RTE_ETH_LINK_CONNECTOR_SGMII,        /**< Serial Gigabit Media Independent Interface */
+	RTE_ETH_LINK_CONNECTOR_QSGMII,       /**< Link to multiplex 4 SGMII over one serial link */
+	RTE_ETH_LINK_CONNECTOR_XFI,          /**< 10 Gigabit Attachment Unit Interface */
+	RTE_ETH_LINK_CONNECTOR_SFI,          /**< 10 Gigabit Serial Interface for optical network */
+	RTE_ETH_LINK_CONNECTOR_XLAUI,        /**< 40 Gigabit Attachment Unit Interface */
+	RTE_ETH_LINK_CONNECTOR_GAUI,         /**< Gigabit Interface for 50/100/200 Gbps */
+	RTE_ETH_LINK_CONNECTOR_XAUI,         /**< 10 Gigabit Attachment Unit Interface */
+	RTE_ETH_LINK_CONNECTOR_CAUI,         /**< 100 Gigabit Attachment Unit Interface */
+	RTE_ETH_LINK_CONNECTOR_LAUI,         /**< 50 Gigabit Attachment Unit Interface */
+	RTE_ETH_LINK_CONNECTOR_SFP,          /**< Pluggable module for 1 Gigabit */
+	RTE_ETH_LINK_CONNECTOR_SFP_PLUS,     /**< Pluggable module for 10 Gigabit */
+	RTE_ETH_LINK_CONNECTOR_SFP28,        /**< Pluggable module for 25 Gigabit */
+	RTE_ETH_LINK_CONNECTOR_SFP_DD,       /**< Pluggable module for 100 Gigabit */
+	RTE_ETH_LINK_CONNECTOR_QSFP,         /**< Module to mutiplex 4 SFP i.e. 4*1=4 Gbps */
+	RTE_ETH_LINK_CONNECTOR_QSFP_PLUS,    /**< Module to mutiplex 4 SFP_PLUS i.e. 4*10=40 Gbps */
+	RTE_ETH_LINK_CONNECTOR_QSFP28,       /**< Module to mutiplex 4 SFP28 i.e. 4*25=100 Gbps */
+	RTE_ETH_LINK_CONNECTOR_QSFP56,       /**< Module to mutiplex 4 SFP56 i.e. 4*50=200 Gbps */
+	RTE_ETH_LINK_CONNECTOR_QSFP_DD,      /**< Module to mutiplex 4 SFP_DD i.e. 4*100=400 Gbps */
+	RTE_ETH_LINK_CONNECTOR_OTHER = 31,   /**< non-physical interfaces like virtio, ring etc */
+};
+
 /**
  * A structure used to retrieve link-level information of an Ethernet port.
  */
@@ -341,6 +376,7 @@ struct rte_eth_link {
 			uint16_t link_duplex  : 1;  /**< RTE_ETH_LINK_[HALF/FULL]_DUPLEX */
 			uint16_t link_autoneg : 1;  /**< RTE_ETH_LINK_[AUTONEG/FIXED] */
 			uint16_t link_status  : 1;  /**< RTE_ETH_LINK_[DOWN/UP] */
+			uint16_t link_type    : 5;  /**< RTE_ETH_LINK_TYPE_XXX */
 		};
 	};
 };
@@ -3116,6 +3152,20 @@ int rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *link)
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
+const char *rte_eth_link_type_to_str(enum rte_eth_link_connector link_type);
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
-- 
2.43.0

