Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF7CCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 16:59:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E19C240268;
	Wed,  7 Oct 2026 18:59:55 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by mails.dpdk.org (Postfix) with ESMTP id AA98740265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 18:59:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OT4DQeQ0bhb011IYLNlGHx5fw3aiUqXtlthKLnQ92jshmvpouZHehLqJSb/5wnDpfuC6zPnp5Aj+aumCFOJq0z+7XzPw2PigTOaWgI39FCiu5CgJCixd6MB5uwqPaCF5EhE8No8pY0f//JdsITMzntCuukqFVNzaudKbvorWxTgx6qSL3cNouhgrJtT7cNgn62Vgi9jUAqpw8cT/nQx6nzONGEGOlElCtSLt1sgAlZlbw2m+pJmmiRkIt19cZ6Sv5gkvazHj+hQ+bJhmrVW9FDEUBQ+DQqObCGnAhl6sjuiJlDGJK7nQYUbm6IA2gITAJf2tBAaZbN2MzlFZPjPL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMKBHZDLWz0sQCI4rMDRg5KugmEID+EjFJwEjjYYeq0=;
 b=m2TLFrKrYxNAo/WANA1bFW1cE0lKQh0tKwpxDOm+HWC+4XsdjFUfavzzNMfp/IxMsgSwrVM5Yvert0Q6XoBJySXFTMxlZTfRzW5GiBP0AWlWTBTDAMrIrfQuKEJs8qofEP0HXPXOD4A0wEVe3wOir5TNSK4r2oGj6AJLVxNtsnBAwp4WxEGxTCltzytriyuyuQBqebfQTtSleN9c0/NTXXLXfaFnLHOTI0Hq+6EGXCMaex4XX089G/MwD5bSqAzvwP/hH3YC4Vp0ghoSZ7OwWWpW7SOIRYZuoFYcM7Yq4vzel5OZJGDPcvusIy6VXNh6F9AorH+cuQxNzIEjsgNMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMKBHZDLWz0sQCI4rMDRg5KugmEID+EjFJwEjjYYeq0=;
 b=orjWAhO73entfL4OfGSHWQra3QDqYK3jvGUITV3yqkJ2fp0o0lvpk4WZewWcw81JFiZvyZkQ1j019O++lpY7Fw/MYXr3EqegP2hCPC031upJqEy7GhhrHUDVcUj9Bn5Ot5IaZhsq7gwft0FmKH/ueiS2RbUXPs7BEmkZ/y21ZJtnxtfSuTZhLydyaxzrzr49Cg14KEFRVpjDj1Jep8nfyKp+K/dgGhwdH0cI1tUQ+e33crXkz7ZGhDME6NhKv1bEkFOpidtXkQYxCdbpr/ymoZDhwEUgoMXW0t8iwhpFx4yrszZ0+G7Njd8SfzAlyN4NIj8qlOJszeva5Lg/yZml+g==
Received: from DS7P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::8) by
 SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 7 Oct
 2026 16:59:47 +0000
Received: from CY5PEPF00000E75.namprd02.prod.outlook.com
 (2603:10b6:8:25b:cafe::41) by DS7P221CA0013.outlook.office365.com
 (2603:10b6:8:25b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 16:59:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY5PEPF00000E75.mail.protection.outlook.com (10.167.247.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 16:59:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 09:59:22 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 09:59:20 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <stephen@networkplumber.org>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH v6] ethdev: support inline calculating masked item value
Date: Wed, 7 Oct 2026 19:57:44 +0300
Message-ID: <20261007165904.126976-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610052729.5637-1-bingz@nvidia.com>
References: <20260610052729.5637-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E75:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 6181db3f-4c01-4837-e34e-08df249464a2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|11063799006|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Isnr5R1hlxpmh3nAgy85Y4HTt6S2nT5dmdug9Sm3omDkbe1G98xGYcJMvawez8twEqmeio2jHJLrW87pZJojW4yY+odFEggcznJFk7shANlr94TxyuxaCDqfA4vjZUh9eyXjGtoMlqX2wYbDstdSXjXQRXmgm77i19EoO8A1sJeJXUy2MY8OqrKOvFRi/dKZZRh6ywIY7PKy9UtIfJX6T3jMUaOvDAc5vsZMNUvvordRHkmgfVo26pnKoxq6JdF6H1eFTzsgciTIi6uFyLQbGZwoZbP8mNFcQ+XZNpUIIcKYUl5fICYVUP/AZ95DpNWg0SuNmTUuNGxKEb7q5KfslLrYOZ4M9+MPBbmF+5RSwy8oO7EEkhUUfiNWk61Nw6+a192RNtZ2GKmUW10aGdlX22UT0/pFw72mREEurHzGhFXkJ0QB8ptFFYEZh5O8ux4izAIx30nUV1pMXT8JVN/1U3SFCR8pSRcJDWSRrS+UsGTM+tl3IhTMIJS9sVl5aMQbjLM5955TwXFamowVr3pX/GmFizmJ+STguXMIiiwnWZv19qOGaQSVOLfyINCAKIxRveEXSLr1BRK3abemENhtX8rbr+5qNLny4b+q2ghdE/AUVrO2eDY860C4ouOnNxO5XAHxCAaLmKx2Acl74PjImK5BzzETKgtKnUor+yHeVuC32wKLt5uPbHnodCaXyxOgababJ5kaZTr63QkQ/SNzqw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2Iu9Z62RrBn+5mOhtYLgdqZ7PdkV8y9qyxSrc4hNZpY8JzuHXh6esXciI3d+JezgwGm+4txpofFe/Jh/4koUwhfmP0MIxv5IKun8PaMSOzlPpC+8I/1bT8IqipSQSqc5lEt8bXwO+N1pXzzWbd2gW5GRlsdgwvP51x/A7iQPObqpTJi7u8bpDRo0YmCN5/BT1Qm9zwOfLKANSsTBCS2Bhxt6/GWmlmiXANtYCGiBTjTzjs4Y7hQzsUz0VK9t8E0U7bEoikNdWmVKEBhLZZw8v51I5wr328zOF8ODDCXw4f0yAtpKsOQfnbrluKSdfpTsFSQjoVJ6lBwXeP+F2m4eCezdualR+9SGpaY4figXSqAYifbdYfupwx4P19ApV1Bk/ahvK7oiOlKBm3yoz5/fhbIjsQRXPOWBGgvMCvGsQM33t5hjWrE3FfGSZewoGW1M
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 16:59:47.0734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6181db3f-4c01-4837-e34e-08df249464a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603
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

In the asynchronous API definition and some drivers, the
rte_flow_item spec value may not be calculated by the driver due to the
reason of speed of light rule insertion rate and sometimes the input
parameters will be copied and changed internally.

After copying, the spec and last will be protected by the keyword
const and cannot be changed in the code itself. And also the driver
needs some extra memory to do the calculation and extra conditions
to understand the length of each item spec. This is not efficient.

To solve the issue and support usage of the following fix, a new OP
was introduced to calculate the spec and last values after applying
the mask inline.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
v3:
  - add test code
  - fix the issue found by AI
v4: reabse on top of the main
v5: handle some items separately and add test for them
v6: resend the correct version instead of v5 with AI defects resolved
---
 app/test/test_ethdev_api.c | 123 +++++++++++++++++++++++++++++++++++++
 lib/ethdev/rte_flow.c      |  55 +++++++++++++++--
 lib/ethdev/rte_flow.h      |  13 ++++
 3 files changed, 185 insertions(+), 6 deletions(-)

diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c
index 00d6a5c614..ba3e785425 100644
--- a/app/test/test_ethdev_api.c
+++ b/app/test/test_ethdev_api.c
@@ -2,8 +2,11 @@
  * Copyright (C) 2023, Advanced Micro Devices, Inc.
  */
 
+#include <string.h>
+
 #include <rte_log.h>
 #include <rte_ethdev.h>
+#include <rte_flow.h>
 
 #include <rte_test.h>
 #include "test.h"
@@ -15,6 +18,125 @@
 #define NUM_MBUF 1024
 #define MBUF_CACHE_SIZE 256
 
+static int32_t
+ethdev_api_flow_conv_pattern_masked(void)
+{
+	const struct rte_flow_item_eth spec = {
+		.hdr.dst_addr.addr_bytes = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06 },
+		.hdr.src_addr.addr_bytes = { 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f },
+		.hdr.ether_type = RTE_BE16(0x1234),
+	};
+	const struct rte_flow_item_eth last = {
+		.hdr.dst_addr.addr_bytes = { 0x11, 0x12, 0x13, 0x14, 0x15, 0x16 },
+		.hdr.src_addr.addr_bytes = { 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f },
+		.hdr.ether_type = RTE_BE16(0x5678),
+	};
+	const struct rte_flow_item_eth mask = {
+		.hdr.dst_addr.addr_bytes = { 0xff, 0xff, 0x00, 0x00, 0xff, 0xff },
+		.hdr.src_addr.addr_bytes = { 0xff, 0x00, 0xff, 0x00, 0xff, 0x00 },
+		.hdr.ether_type = RTE_BE16(0xffff),
+	};
+	const uint8_t raw_pattern[] = { 0xaa, 0xbb, 0xcc, 0xdd };
+	const struct rte_flow_item_raw raw_spec = {
+		.relative = 1,
+		.search = 1,
+		.offset = 8,
+		.limit = 4,
+		.length = sizeof(raw_pattern),
+		.pattern = raw_pattern,
+	};
+	const struct rte_flow_item_raw raw_mask = {
+		.relative = 1,
+		.search = 0,
+		.reserved = 0x3fffffff,
+		.offset = 0xffffffff,
+		.limit = 0xffff,
+		.length = 0xffff,
+		.pattern = NULL,
+	};
+	const struct rte_flow_item pattern[] = {
+		{
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.spec = &spec,
+			.last = &last,
+			.mask = &mask,
+		},
+		{
+			.type = RTE_FLOW_ITEM_TYPE_RAW,
+			.spec = &raw_spec,
+			.mask = &raw_mask,
+		},
+		{ .type = RTE_FLOW_ITEM_TYPE_END },
+	};
+	union {
+		struct rte_flow_item item;
+		struct rte_flow_item_eth eth;
+		struct rte_flow_item_raw raw;
+		double align;
+		uint8_t buf[256];
+	} dst;
+	const struct rte_flow_item *item;
+	const struct rte_flow_item_eth *conv_spec;
+	const struct rte_flow_item_eth *conv_last;
+	const struct rte_flow_item_raw *conv_raw_spec;
+	int ret;
+
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, NULL, 0, pattern, NULL);
+	TEST_ASSERT(ret > 0, "Masked pattern conversion size query failed");
+	TEST_ASSERT((size_t)ret <= sizeof(dst.buf),
+		    "Masked pattern conversion needs too much storage");
+
+	memset(&dst, 0, sizeof(dst));
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, dst.buf,
+			    sizeof(dst.buf), pattern, NULL);
+	TEST_ASSERT(ret > 0, "Masked pattern conversion failed");
+
+	item = (const struct rte_flow_item *)dst.buf;
+	conv_spec = item[0].spec;
+	conv_last = item[0].last;
+	TEST_ASSERT_NOT_NULL(conv_spec, "Converted spec must be set");
+	TEST_ASSERT_NOT_NULL(conv_last, "Converted last must be set");
+
+	TEST_ASSERT_EQUAL(conv_spec->hdr.dst_addr.addr_bytes[0], 0x01,
+			  "Masked spec dst byte 0 mismatch");
+	TEST_ASSERT_EQUAL(conv_spec->hdr.dst_addr.addr_bytes[2], 0x00,
+			  "Masked spec dst byte 2 mismatch");
+	TEST_ASSERT_EQUAL(conv_spec->hdr.src_addr.addr_bytes[1], 0x00,
+			  "Masked spec src byte 1 mismatch");
+	TEST_ASSERT_EQUAL(conv_spec->hdr.ether_type, RTE_BE16(0x1234),
+			  "Masked spec ether type mismatch");
+	TEST_ASSERT_EQUAL(conv_last->hdr.dst_addr.addr_bytes[0], 0x11,
+			  "Masked last dst byte 0 mismatch");
+	TEST_ASSERT_EQUAL(conv_last->hdr.dst_addr.addr_bytes[2], 0x00,
+			  "Masked last dst byte 2 mismatch");
+	TEST_ASSERT_EQUAL(conv_last->hdr.src_addr.addr_bytes[1], 0x00,
+			  "Masked last src byte 1 mismatch");
+	TEST_ASSERT_EQUAL(conv_last->hdr.ether_type, RTE_BE16(0x5678),
+			  "Masked last ether type mismatch");
+
+	conv_raw_spec = item[1].spec;
+	TEST_ASSERT_NOT_NULL(conv_raw_spec, "Converted RAW spec must be set");
+	TEST_ASSERT_NOT_NULL(conv_raw_spec->pattern,
+			     "Converted RAW pattern pointer must be set");
+	TEST_ASSERT(conv_raw_spec->pattern != raw_pattern,
+		    "Converted RAW pattern must be deep-copied");
+	TEST_ASSERT_EQUAL(conv_raw_spec->relative, 1,
+			  "Masked RAW relative mismatch");
+	TEST_ASSERT_EQUAL(conv_raw_spec->search, 0,
+			  "Masked RAW search mismatch");
+	TEST_ASSERT_EQUAL(conv_raw_spec->offset, raw_spec.offset,
+			  "Masked RAW offset mismatch");
+	TEST_ASSERT_EQUAL(conv_raw_spec->limit, raw_spec.limit,
+			  "Masked RAW limit mismatch");
+	TEST_ASSERT_EQUAL(conv_raw_spec->length, raw_spec.length,
+			  "Masked RAW length mismatch");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(conv_raw_spec->pattern, raw_pattern,
+				      sizeof(raw_pattern),
+				      "Converted RAW pattern mismatch");
+
+	return TEST_SUCCESS;
+}
+
 static int32_t
 ethdev_api_queue_status(void)
 {
@@ -167,6 +289,7 @@ static struct unit_test_suite ethdev_api_testsuite = {
 	.setup = NULL,
 	.teardown = NULL,
 	.unit_test_cases = {
+		TEST_CASE(ethdev_api_flow_conv_pattern_masked),
 		TEST_CASE(ethdev_api_queue_status),
 		/* TODO: Add deferred_start queue status test */
 		TEST_CASES_END() /**< NULL terminate unit test array */
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index ca2f85c3fa..e4efcbf10f 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -175,6 +175,23 @@ static const struct rte_flow_desc_data rte_flow_desc_item[] = {
 	MK_FLOW_ITEM(COMPARE, sizeof(struct rte_flow_item_compare)),
 };
 
+static inline size_t
+rte_flow_conv_item_mask_size(const struct rte_flow_item *item)
+{
+	if ((int)item->type < 0)
+		return sizeof(void *);
+	switch (item->type) {
+	case RTE_FLOW_ITEM_TYPE_RAW:
+		return offsetof(struct rte_flow_item_raw, pattern);
+	case RTE_FLOW_ITEM_TYPE_GENEVE_OPT:
+		return offsetof(struct rte_flow_item_geneve_opt, data);
+	default:
+		if (rte_flow_desc_item[item->type].desc_fn != NULL)
+			return 0;
+		return rte_flow_desc_item[item->type].size;
+	}
+}
+
 /** Generate flow_action[] entry. */
 #define MK_FLOW_ACTION(t, s) \
 	[RTE_FLOW_ACTION_TYPE_ ## t] = { \
@@ -797,6 +814,8 @@ rte_flow_conv_action_conf(void *buf, const size_t size,
  *   RTE_FLOW_ITEM_TYPE_END is encountered.
  * @param[out] error
  *   Perform verbose error reporting if not NULL.
+ * @param[in] with_mask
+ *   If true, @p src mask will be applied to spec and last.
  *
  * @return
  *   A positive value representing the number of bytes needed to store
@@ -809,12 +828,13 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 		      const size_t size,
 		      const struct rte_flow_item *src,
 		      unsigned int num,
+		      bool with_mask,
 		      struct rte_flow_error *error)
 {
 	uintptr_t data = (uintptr_t)dst;
 	size_t off;
 	size_t ret;
-	unsigned int i;
+	unsigned int i, j;
 
 	for (i = 0, off = 0; !num || i != num; ++i, ++src, ++dst) {
 		/**
@@ -838,15 +858,27 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 	src -= num;
 	dst -= num;
 	do {
+		uint8_t *c_spec = NULL, *c_last = NULL;
+		const uint8_t *mask = src->mask;
+		size_t item_mask_size = mask ? rte_flow_conv_item_mask_size(src) : 0;
+
 		if (src->spec) {
 			off = RTE_ALIGN_CEIL(off, sizeof(double));
 			ret = rte_flow_conv_item_spec
 				((void *)(data + off),
 				 size > off ? size - off : 0, src,
 				 RTE_FLOW_CONV_ITEM_SPEC);
-			if (size && size >= off + ret)
+			if (size && size >= off + ret) {
 				dst->spec = (void *)(data + off);
+				c_spec = (uint8_t *)(data + off);
+			}
 			off += ret;
+			if (with_mask && c_spec && mask) {
+				size_t mask_size = RTE_MIN(ret, item_mask_size);
+
+				for (j = 0; j < mask_size; j++)
+					c_spec[j] &= mask[j];
+			}
 
 		}
 		if (src->last) {
@@ -855,9 +887,17 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 				((void *)(data + off),
 				 size > off ? size - off : 0, src,
 				 RTE_FLOW_CONV_ITEM_LAST);
-			if (size && size >= off + ret)
+			if (size && size >= off + ret) {
 				dst->last = (void *)(data + off);
+				c_last = (uint8_t *)(data + off);
+			}
 			off += ret;
+			if (with_mask && c_last && mask) {
+				size_t mask_size = RTE_MIN(ret, item_mask_size);
+
+				for (j = 0; j < mask_size; j++)
+					c_last[j] &= mask[j];
+			}
 		}
 		if (src->mask) {
 			off = RTE_ALIGN_CEIL(off, sizeof(double));
@@ -1004,7 +1044,7 @@ rte_flow_conv_rule(struct rte_flow_conv_rule *dst,
 		off = RTE_ALIGN_CEIL(off, sizeof(double));
 		ret = rte_flow_conv_pattern((void *)((uintptr_t)dst + off),
 					    size > off ? size - off : 0,
-					    src->pattern_ro, 0, error);
+					    src->pattern_ro, 0, false, error);
 		if (ret < 0)
 			return ret;
 		if (size && size >= off + (size_t)ret)
@@ -1104,7 +1144,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 		ret = sizeof(*attr);
 		break;
 	case RTE_FLOW_CONV_OP_ITEM:
-		ret = rte_flow_conv_pattern(dst, size, src, 1, error);
+		ret = rte_flow_conv_pattern(dst, size, src, 1, false, error);
 		break;
 	case RTE_FLOW_CONV_OP_ITEM_MASK:
 		item = src;
@@ -1119,7 +1159,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 		ret = rte_flow_conv_actions(dst, size, src, 1, error);
 		break;
 	case RTE_FLOW_CONV_OP_PATTERN:
-		ret = rte_flow_conv_pattern(dst, size, src, 0, error);
+		ret = rte_flow_conv_pattern(dst, size, src, 0, false, error);
 		break;
 	case RTE_FLOW_CONV_OP_ACTIONS:
 		ret = rte_flow_conv_actions(dst, size, src, 0, error);
@@ -1139,6 +1179,9 @@ rte_flow_conv(enum rte_flow_conv_op op,
 	case RTE_FLOW_CONV_OP_ACTION_NAME_PTR:
 		ret = rte_flow_conv_name(1, 1, dst, size, src, error);
 		break;
+	case RTE_FLOW_CONV_OP_PATTERN_MASKED:
+		ret = rte_flow_conv_pattern(dst, size, src, 0, true, error);
+		break;
 	default:
 		ret = rte_flow_error_set
 		(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index f864578f80..2261d1ea06 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4544,6 +4544,19 @@ enum rte_flow_conv_op {
 	 *   @code const char ** @endcode
 	 */
 	RTE_FLOW_CONV_OP_ACTION_NAME_PTR,
+
+	/**
+	 * Convert an entire pattern.
+	 *
+	 * Duplicates all pattern items at once, applying each source item mask
+	 * to its copied specification and range.
+	 *
+	 * - @p src type:
+	 *   @code const struct rte_flow_item * @endcode
+	 * - @p dst type:
+	 *   @code struct rte_flow_item * @endcode
+	 */
+	RTE_FLOW_CONV_OP_PATTERN_MASKED,
 };
 
 /**
-- 
2.43.0

