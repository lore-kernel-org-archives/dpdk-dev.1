Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1086ECA1016
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 10:36:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16066402D3;
	Thu, 11 Sep 2025 12:36:18 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BA9BD402C4
 for <dev@dpdk.org>; Thu, 11 Sep 2025 12:36:16 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B7LIsD000325;
 Thu, 11 Sep 2025 03:36:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 M0x+WyCcvMEeO8MvbKu30xWD6SeJmEPtVwQVkhB5+c=; b=GU+WS0+PjHTJJtqtP
 pNYfSPBhsBEE+3V32/xeuXhxxp1F5EeenSPO9zRGcon1+REZH9ohc4zWdasQ5rFi
 6Aw/wb0SE0qyLDkuqN9I8cp0m2V0YB6aZWRCoAfj4rQlnPyRfjJSFq2vQiQwNxdF
 ca5/7yfmuF0UzD9h6+Q1PBjfKckeDOphh/hBuin0iQLx3Mc91okmpgRjch7XZ8uD
 ywXY4uL4bN/o0Bh5gdGuz029H9jdUbFzNqGtSjQiAOJU1kkme1YproXJDrPdaOe+
 MnwCBP0Kd0c7zPg/avTTLQofgafshAENwM+sPQcPnWTfWbsFyVXgnCMnbm6/hMBg
 a9/Hw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 493sxv8cay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 03:36:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Sep 2025 03:36:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Sep 2025 03:36:21 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 771A03F708F;
 Thu, 11 Sep 2025 03:36:12 -0700 (PDT)
From: <skori@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: [PATCH v12 1/1] ethdev: add link connector type
Date: Thu, 11 Sep 2025 16:04:57 +0530
Message-ID: <20250911103610.2405666-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911084943.2383151-1-skori@marvell.com>
References: <20250911084943.2383151-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FvuLAAkRrHqABRL949cEMW7Hr4C0_rKP
X-Authority-Analysis: v=2.4 cv=LrKSymdc c=1 sm=1 tr=0 ts=68c2a61f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=zbKAp0b2BLt1whPCMNgA:9
 a=B2Fw7Gp7Epu5W2Z-:21 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: FvuLAAkRrHqABRL949cEMW7Hr4C0_rKP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA2NCBTYWx0ZWRfX6rjgfJb79ydh
 3IxwiBa/XjTwqAq/+BZVzdY6mQMF5t31eos4d8+69OL/UBk641knOi4EFvXVLOjI0hZCkEjfbKK
 A3N40NyJCYoIMQpp4aPBNsChrZBzVRhBz7atzznf7iL9JitPdCzVOwXLfvbg/49kDWwfoapYuJH
 rT75hj2J6litYZv4xdt6iGJAK+rtVQFyYaIMaR5neGmxyIvtUW5X4H3XrH/mPiP80vgJvYaqSkV
 A6M1LdHWVEdONU9D0v0m2GaAAY6Qz5NNisYBKlSYQidlf4ylXwyaWD5PPK3NbKuVhSEBfE940GB
 aNtXV9FRkxrQYzYmmqdVMKi0zrSHivI3khwC+hv3Qa1oTGkHIJeVovCUwWA3gKJRS6LpCa99ZQc
 XllumXs9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
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

Adding link connector parameter to provide the type
of connection for a port like twisted pair, fiber etc.

Also added an API to convert the RTE_ETH_LINK_CONNECTOR_XXX
to a readable string.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
v11..v12:
 - Increase size of link_connector field.
v10..v11
 - Fix review comments on documentation.
 - Rebase on top of next-net:main branch.
v9..v10:
 - Rebase on top of next-net:main branch.

 app/test/test_ethdev_link.c            | 18 +++++----
 doc/guides/rel_notes/release_25_11.rst | 25 ++++++++++++
 lib/ethdev/rte_ethdev.c                | 45 ++++++++++++++++++++-
 lib/ethdev/rte_ethdev.h                | 54 ++++++++++++++++++++++++++
 4 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/app/test/test_ethdev_link.c b/app/test/test_ethdev_link.c
index 47c526eb0c..359b879fae 100644
--- a/app/test/test_ethdev_link.c
+++ b/app/test/test_ethdev_link.c
@@ -17,23 +17,25 @@ test_link_status_up_default(void)
 		.link_speed = RTE_ETH_SPEED_NUM_2_5G,
 		.link_status = RTE_ETH_LINK_UP,
 		.link_autoneg = RTE_ETH_LINK_AUTONEG,
-		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX
+		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
+		.link_connector = RTE_ETH_LINK_CONNECTOR_OTHER
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
+	link_status.link_connector = RTE_ETH_LINK_CONNECTOR_SGMII;
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
 	link_status.link_speed = RTE_ETH_SPEED_NUM_800G;
 	link_status.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
 	link_status.link_autoneg = RTE_ETH_LINK_AUTONEG;
+	link_status.link_connector = RTE_ETH_LINK_CONNECTOR_GAUI;
 	ret = rte_eth_link_to_str(text, sizeof(text), &link_status);
 	printf("Default link up #4:len = %d, %s\n", ret, text);
 	RTE_TEST_ASSERT(ret < RTE_ETH_LINK_MAX_STR_LEN,
@@ -92,7 +95,8 @@ test_link_status_invalid(void)
 		.link_speed = 55555,
 		.link_status = RTE_ETH_LINK_UP,
 		.link_autoneg = RTE_ETH_LINK_AUTONEG,
-		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX
+		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
+		.link_connector = RTE_ETH_LINK_CONNECTOR_OTHER
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
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index efb88bbbb0..fccf3d1366 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -55,6 +55,28 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added ethdev API to get link connector.**
+
+  * Added API to report type of link connector for a port.
+    The following connectors are enumerated:
+
+   * None
+   * Twisted Pair
+   * Attachment Unit Interface (AUI)
+   * Optical Fiber Link
+   * BNC
+   * Direct Attach Copper
+   * XFI, SFI
+   * Media Independent Interface (MII)
+   * SGMII, QSGMII
+   * XLAUI, GAUI, AUI, CAUI, LAUI
+   * SFP, SFP+, SFP28, SFP-DD
+   * QSFP, QSFP+, QSFP28, QSFP56, QSFP-DD
+   * OTHER
+
+    By default, it reports ``RTE_ETH_LINK_CONNECTOR_NONE``
+    unless driver specifies it.
+
 * **Added speed 800G.**
 
   Added Ethernet link speed for 800 Gb/s as it is well standardized in IEEE,
@@ -124,6 +146,9 @@ ABI Changes
 * eal: The structure ``rte_mp_msg`` alignment has been updated to 8 bytes to limit unaligned
   accesses in messages payload.
 
+* ethdev: Added ``link_connector`` field to ``rte_eth_link`` structure
+  to report type of link connector for a port.
+
 * stack: The structure ``rte_stack_lf_head`` alignment has been updated to 16 bytes
   to avoid unaligned accesses.
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index f22139cb38..60f4ca34e0 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3330,18 +3330,59 @@ rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
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
+			rte_eth_link_connector_to_str(eth_link->link_connector));
 
 	rte_eth_trace_link_to_str(len, eth_link, str, ret);
 
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_connector_to_str, 25.11)
+const char *
+rte_eth_link_connector_to_str(enum rte_eth_link_connector link_connector)
+{
+	static const char * const link_connector_str[] = {
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
+	if (link_connector < ((enum rte_eth_link_connector)RTE_DIM(link_connector_str)))
+		str = link_connector_str[link_connector];
+
+	return str;
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_stats_get)
 int
 rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index d23c143eed..996d9b212a 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -331,6 +331,45 @@ struct rte_eth_stats {
 #define RTE_ETH_SPEED_NUM_UNKNOWN UINT32_MAX /**< Unknown */
 /**@}*/
 
+/**
+ * @enum rte_eth_link_connector
+ * @brief Ethernet port link connector type
+ *
+ * This enum defines the possible types of Ethernet port link connectors.
+ */
+enum rte_eth_link_connector {
+	RTE_ETH_LINK_CONNECTOR_NONE = 0,     /**< None. Default unless driver specifies it */
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
+	RTE_ETH_LINK_CONNECTOR_OTHER = 63,   /**< non-physical interfaces like virtio, ring etc.
+					       * It also includes unknown connector types,
+					       * i.e. physical connectors not yet defined in this
+					       * list of connector types.
+					       */
+};
+
 /**
  * A structure used to retrieve link-level information of an Ethernet port.
  */
@@ -343,6 +382,7 @@ struct rte_eth_link {
 			uint16_t link_duplex  : 1;  /**< RTE_ETH_LINK_[HALF/FULL]_DUPLEX */
 			uint16_t link_autoneg : 1;  /**< RTE_ETH_LINK_[AUTONEG/FIXED] */
 			uint16_t link_status  : 1;  /**< RTE_ETH_LINK_[DOWN/UP] */
+			uint16_t link_connector : 6;  /**< RTE_ETH_LINK_CONNECTOR_XXX */
 		};
 	};
 };
@@ -3118,6 +3158,20 @@ int rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *link)
 __rte_experimental
 const char *rte_eth_link_speed_to_str(uint32_t link_speed);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * This function converts an Ethernet link type to a string.
+ *
+ * @param link_connector
+ *   The link type to convert.
+ * @return
+ *   NULL for invalid link connector values otherwise the string representation of the link type.
+ */
+__rte_experimental
+const char *rte_eth_link_connector_to_str(enum rte_eth_link_connector link_connector);
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
-- 
2.43.0

