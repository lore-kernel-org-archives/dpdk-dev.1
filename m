Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B07CA0EE3
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 08:12:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF4A0402A8;
	Thu, 14 Aug 2025 10:12:24 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id BC5264026D
 for <dev@dpdk.org>; Thu, 14 Aug 2025 10:12:22 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DNVXE0003231;
 Thu, 14 Aug 2025 01:12:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 8gav4Ek2kpS7yvjXA0BfIvkY6X++sJdJPzO+FvbAaI=; b=Jua+Y06tLJ+iJ8bNL
 9v4pz90zpwxJVJxpCxS74AMaxoE0+J2QZgy9LBpV4+CCN6yWMvbgUsw+w8w2Dodw
 /62KF3A/+Kx0KzePp3bpvC4mIDSfUXhNYN2u5GTOGhzKnBiTrI4EmCvpu7bX6CdT
 5bL0T3B8vC/84elGSN6G6aUt5o7c2Jm6m2k99uwOn0iknbMtU/3r0FS99gGgyq+l
 i2unlp6ZQuVwCdwVE7IiWpQLMtFcQoPwmOBhgJQDL03rsRlsI3OKeXN7LzSiMVUf
 ahaifNjMhdrgsnO0veqUk3irDOl5MlAi89K8QHOmh2CVzPmUf097CIBVLPaMooWw
 0vrkA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48h4f2ruug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Aug 2025 01:12:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 14 Aug 2025 01:12:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 14 Aug 2025 01:12:23 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 63E263F70AB;
 Thu, 14 Aug 2025 01:12:17 -0700 (PDT)
From: <skori@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: [PATCH v4 1/1] ethdev: add support to provide link type
Date: Thu, 14 Aug 2025 13:40:05 +0530
Message-ID: <20250814081215.1904078-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813084508.1446318-1-skori@marvell.com>
References: <20250813084508.1446318-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA2NiBTYWx0ZWRfX/MHy+y8QZhTk
 7DjzoFYTRuj2jZLhfiwpnVQj/UGgunFstHwiyZlj0finfTG6+FQPBky2PP6meNjEuMRU3fHfYwb
 smNUbu9qgmzhRsvTIGXNa/h7qmP9Unn0xP1tsyESIDw8kndRQz+GiuchqBxXnkood9hLHS+HLDr
 TBZQgpnkjxBAqBE8hAHEdnSHQUjlXIWlucxH2ySEj8m2PhYrALKWwLPJAm11C2oCDcsvVuQgPGE
 rW8Z1wyBGHpFHTE2IU5JpI8QgApj1TJUTkxH4pUzF4SRHWUixJ5RjinoKVnQIUiw6dU5f/oPQnx
 u+xtuqXlHhDVoBGsIelB4z2HnNDrPriMNuUKXHfuIEQ9XlCKMgXXos4MV5qMZPYQFMi80pVWQVM
 wYwIlIzvNgAEXBKE+RpzXT7GQZ7eMVbMUoFVRDP1ZIIBWj4rwRZ92zETCzgvDR1Ta/7FHflh
X-Authority-Analysis: v=2.4 cv=Fds3xI+6 c=1 sm=1 tr=0 ts=689d9a65 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=OL0klFNNdlNiBaNv_3QA:9
 a=WonHw0LWvj4Cx2or:21 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: zZUz03_TcSBkwLtcdCTvx49LY3mvXDW3
X-Proofpoint-ORIG-GUID: zZUz03_TcSBkwLtcdCTvx49LY3mvXDW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
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
v3..v4:
 - Convert #define into enum.
 - Enhance comments for each port link type.
 - Fix test failures.
v2..v3
 - Extend link type list as per suggestion
 app/test/test_ethdev_link.c      | 18 +++++++-----
 lib/ethdev/ethdev_trace.h        |  7 +++++
 lib/ethdev/ethdev_trace_points.c |  3 ++
 lib/ethdev/rte_ethdev.c          | 46 ++++++++++++++++++++++++++++--
 lib/ethdev/rte_ethdev.h          | 48 ++++++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+), 9 deletions(-)

diff --git a/app/test/test_ethdev_link.c b/app/test/test_ethdev_link.c
index f063a5fe26..5d1a784208 100644
--- a/app/test/test_ethdev_link.c
+++ b/app/test/test_ethdev_link.c
@@ -17,23 +17,25 @@ test_link_status_up_default(void)
 		.link_speed = RTE_ETH_SPEED_NUM_2_5G,
 		.link_status = RTE_ETH_LINK_UP,
 		.link_autoneg = RTE_ETH_LINK_AUTONEG,
-		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX
+		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
+		.link_type = RTE_ETH_LINK_TYPE_NONE
 	};
 	char text[RTE_ETH_LINK_MAX_STR_LEN];
 
 	ret = rte_eth_link_to_str(text, sizeof(text), &link_status);
 	RTE_TEST_ASSERT(ret > 0, "Failed to format default string\n");
 	printf("Default link up #1: %s\n", text);
-	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at 2.5 Gbps FDX Autoneg",
+	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at 2.5 Gbps FDX Autoneg None",
 		text, strlen(text), "Invalid default link status string");
 
 	link_status.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
 	link_status.link_autoneg = RTE_ETH_LINK_FIXED;
 	link_status.link_speed = RTE_ETH_SPEED_NUM_10M;
+	link_status.link_type = RTE_ETH_LINK_TYPE_SGMII;
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
+	link_status.link_type = RTE_ETH_LINK_TYPE_GAUI;
 	ret = rte_eth_link_to_str(text, sizeof(text), &link_status);
 	printf("Default link up #4:len = %d, %s\n", ret, text);
 	RTE_TEST_ASSERT(ret < RTE_ETH_LINK_MAX_STR_LEN,
@@ -92,7 +95,8 @@ test_link_status_invalid(void)
 		.link_speed = 55555,
 		.link_status = RTE_ETH_LINK_UP,
 		.link_autoneg = RTE_ETH_LINK_AUTONEG,
-		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX
+		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
+		.link_type = RTE_ETH_LINK_TYPE_UNKNOWN
 	};
 	char text[RTE_ETH_LINK_MAX_STR_LEN];
 
@@ -100,7 +104,7 @@ test_link_status_invalid(void)
 	RTE_TEST_ASSERT(ret < RTE_ETH_LINK_MAX_STR_LEN,
 		"Failed to format invalid string\n");
 	printf("invalid link up #1: len=%d %s\n", ret, text);
-	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at Invalid FDX Autoneg",
+	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at Invalid FDX Autoneg Unknown",
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
index dd7c00bc94..db496d70c4 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3285,18 +3285,60 @@ rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
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
+rte_eth_link_type_to_str(enum rte_eth_link_type link_type)
+{
+	static const char * const link_type_str[] = {
+		[RTE_ETH_LINK_TYPE_NONE] = "None",
+		[RTE_ETH_LINK_TYPE_TP] = "Twisted Pair",
+		[RTE_ETH_LINK_TYPE_AUI] = "Attachment Unit Interface",
+		[RTE_ETH_LINK_TYPE_MII] = "Media Independent Interface",
+		[RTE_ETH_LINK_TYPE_FIBER] = "Fiber",
+		[RTE_ETH_LINK_TYPE_BNC] = "BNC",
+		[RTE_ETH_LINK_TYPE_DA] = "Direct Attach Copper",
+		[RTE_ETH_LINK_TYPE_SGMII] = "SGMII",
+		[RTE_ETH_LINK_TYPE_QSGMII] = "QSGMII",
+		[RTE_ETH_LINK_TYPE_XFI] = "XFI",
+		[RTE_ETH_LINK_TYPE_SFI] = "SFI",
+		[RTE_ETH_LINK_TYPE_XLAUI] = "XLAUI",
+		[RTE_ETH_LINK_TYPE_GAUI] = "GAUI",
+		[RTE_ETH_LINK_TYPE_XAUI] = "XAUI",
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
+		[RTE_ETH_LINK_TYPE_UNKNOWN] = "Unknown"
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
index f9fb6ae549..92d1ded51f 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -329,6 +329,39 @@ struct rte_eth_stats {
 #define RTE_ETH_SPEED_NUM_UNKNOWN UINT32_MAX /**< Unknown */
 /**@}*/
 
+/**@{@name PORT type
+ * Ethernet port link type
+ */
+enum rte_eth_link_type {
+	RTE_ETH_LINK_TYPE_NONE = 0, /**< Not defined */
+	RTE_ETH_LINK_TYPE_TP,       /**< Twisted Pair */
+	RTE_ETH_LINK_TYPE_AUI,      /**< Attachment Unit Interface */
+	RTE_ETH_LINK_TYPE_MII,      /**< Media Independent Interface */
+	RTE_ETH_LINK_TYPE_FIBER,    /**< Optical Fiber Link */
+	RTE_ETH_LINK_TYPE_BNC,      /**< BNC Link type for RF connection */
+	RTE_ETH_LINK_TYPE_DA,       /**< Direct Attach copper */
+	RTE_ETH_LINK_TYPE_SGMII,    /**< Serial Gigabit Media Independent Interface */
+	RTE_ETH_LINK_TYPE_QSGMII,   /**< Link to multiplex 4 SGMII over one serial link */
+	RTE_ETH_LINK_TYPE_XFI,      /**< 10 Gigabit Attachment Unit Interface */
+	RTE_ETH_LINK_TYPE_SFI,      /**< 10 Gigabit Serial Interface for optical networking */
+	RTE_ETH_LINK_TYPE_XLAUI,    /**< 40 Gigabit Attachment Unit Interface */
+	RTE_ETH_LINK_TYPE_GAUI,     /**< Gigabit Interface for bandwidth like 50/100/200 Gbps */
+	RTE_ETH_LINK_TYPE_XAUI,     /**< 10 Gigabit Attachment Unit Interface */
+	RTE_ETH_LINK_TYPE_CAUI,     /**< 100 Gigabit Attachment Unit Interface */
+	RTE_ETH_LINK_TYPE_LAUI,     /**< 50 Gigabit Attachment Unit Interface */
+	RTE_ETH_LINK_TYPE_SFP,      /**< Pluggable module for 1 Gigabit */
+	RTE_ETH_LINK_TYPE_SFP_PLUS, /**< Pluggable module for 10 Gigabit */
+	RTE_ETH_LINK_TYPE_SFP28,    /**< Pluggable module for 25 Gigabit */
+	RTE_ETH_LINK_TYPE_SFP_DD,   /**< Pluggable module for 100 Gigabit */
+	RTE_ETH_LINK_TYPE_QSFP,     /**< Module to mutiplex 4 SFP i.e. 4*1=4 Gigabit */
+	RTE_ETH_LINK_TYPE_QSFP_PLUS,/**< Module to mutiplex 4 SFP_PLUS i.e. 4*10=40 Gigabit */
+	RTE_ETH_LINK_TYPE_QSFP28,   /**< Module to mutiplex 4 SFP28 i.e. 4*25=100 Gigabit */
+	RTE_ETH_LINK_TYPE_QSFP56,   /**< Module to mutiplex 4 SFP56 i.e. 4*50=200 Gigabit */
+	RTE_ETH_LINK_TYPE_QSFP_DD,  /**< Module to mutiplex 4 SFP_DD i.e. 4*100=400 Gigabit */
+	RTE_ETH_LINK_TYPE_UNKNOWN = 31, /**< Unknown Link Type */
+};
+/**@}*/
+
 /**
  * A structure used to retrieve link-level information of an Ethernet port.
  */
@@ -341,6 +374,7 @@ struct rte_eth_link {
 			uint16_t link_duplex  : 1;  /**< RTE_ETH_LINK_[HALF/FULL]_DUPLEX */
 			uint16_t link_autoneg : 1;  /**< RTE_ETH_LINK_[AUTONEG/FIXED] */
 			uint16_t link_status  : 1;  /**< RTE_ETH_LINK_[DOWN/UP] */
+			uint16_t link_type    : 5;  /**< RTE_ETH_LINK_TYPE_XXX */
 		};
 	};
 };
@@ -3116,6 +3150,20 @@ int rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *link)
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
+const char *rte_eth_link_type_to_str(enum rte_eth_link_type link_type);
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
-- 
2.43.0

