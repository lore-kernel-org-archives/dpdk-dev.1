Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BABCC6B2D
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 05:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C385740297;
	Fri, 16 Oct 2026 07:27:35 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by mails.dpdk.org (Postfix) with ESMTP id BA32540291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 07:27:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7IAcla1RqaTltWeIxlZ5wsmwh6FwnJgxF5QtPuTk5L1zJNccmCfO5Ye7NtRkcVJ+6lvQ20n5mXkHDbFCWAB4oMUeBw+zKWklbCqURhbZY+Y1/CA+I+g/0Blr7BT7vG2++gCtPQP5j+/5lS25UQoJbd0ppF4SQQZY8sl2fr9G12tlcDQBPlSG6BpmVu2T7PUGGJF20+vCZGEfdFYRcLe+UM/EGij4wpLim/aKChi3UZl6FiD4z4+88xlPKD16ZbJ36r3/CU+obItI0XAdUVJrmLuyXHN1XNPO4ld9g4V521CWekVBhKOCw2vGZdzOpu42NVLkVp1Haj2marScFLQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4ixbkXLRFzEM8cVe3qLiqb/nPWUUhO3YTXMOKPeL50=;
 b=O8NkXbKNYLkI0OzjoAZJq6+GPmtiR7cGEIuwzJqtFG/NuNq2oogqCFfw+IIUdy7QRgVohEZh2EEsPFeSh+5333g2vu0enyp9rR1ljU4xq6ozIMSv4IO5zmnN4GSRroYVCwRTGK4u2eRzJgei6vieYufQ2BbCHy/mHCjK5kZc/3+fqd5DwE4RMyaJKQGJH6omqLZont5qdH4UB3URDMshJziKqltFDVMDi4B45sBPKF4ABGiC3i4tom6ldLr9LoO3q2WA+xUweQnd4pg74GVoL7O+sG2Du3biDgLHAylIuxURjwU+Bw3rr64wE8jMA0Wex3LkBBcgCodcVS2scWI55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4ixbkXLRFzEM8cVe3qLiqb/nPWUUhO3YTXMOKPeL50=;
 b=X6QhbQKm61uAEGMgsgS49uTLfS7xVZEzTQa7NL/rhC3SEI/vana/IPL0QJff2axx+2WfFm8VdsbERSwLkappHYH0yidaGyAH94lL9yb2OQGBpEdKSLPrWxww7YBqqSA2SH3hDTsySadbAZqeDc6q1GwHWYyf/17KIOB/nKTrmVpY55QIyebBvrswGOaFp/A2oc3EhSkgypgXv7ujZq1ZK2/K3kWkIkiWaJurFZFLTlwmNK1wgTEvQJuyN3e0zNrbAAMvcsBqXGrz6yqX7sOhzloi9uAFCPHufC3lePcUI9K93NjV1+n3xgb6RuefKnGMX7tfMTS4ys7/3pUJBhWtcw==
Received: from BN0PR02CA0037.namprd02.prod.outlook.com (2603:10b6:408:e5::12)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 05:27:26 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::6b) by BN0PR02CA0037.outlook.office365.com
 (2603:10b6:408:e5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 05:27:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 05:27:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 15 Oct
 2026 22:27:07 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 22:27:04 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <stephen@networkplumber.org>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH v8] ethdev: support inline calculating masked item value
Date: Fri, 16 Oct 2026 08:26:45 +0300
Message-ID: <20261016052645.288851-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013134950.310252-1-bingz@nvidia.com>
References: <20261013134950.310252-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ed60a6-f966-439f-8e34-08df2b462a0b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: SmxOFAwPeGcQY8iiLgijA/UpU3RP5mixgMOM/zRfwT5BRzHKD4bgMMhTSNbFMGP57AWxxFqhCaENXRFwHfM+x+q41rHaWu6IXUwB2GZWp53GX9iqesf9QLn96gjYVYldHFTmwMB0p7uGzDcGSqe/sohWFxdhWeNXm5kuQG6Wj0apL5o+PgF65/2NmjmWOI3nGMWsrNOiSRaPGeXbi0WunlCICgEMybmatAjT0MyyJ6l2u8QcoyEe74YabpJE2wlAkcV/n9JnW1sqfcp7QjR5/PvaCSwdiRJ0uo1dDEW8yp688kTLbpNhrRhqWPOkQ8smCJIWIuV4BIYik5tRn6FNYF/nwMqV5eB+9oRC+i0tDYMdf1de5w9EHQATjkShCsnRKGLML0usbNPaRHIZTH7xZTmJS+a2x2ORr0DkC/rx/YrqmFHoPEt8VRwG85P32gNAC4vGkxyE5aOarETgYp0fbHvEi+AQ8qq30mPYcbCqDwUA2uCMY2nTZT1gm00uLt0mYJWEYFq6hQrguApMpMitJ7wAJoIF8F0ztPJQOthZ0dAM8P6cDflGUlpdRFTPSBIrJXhxk7ZpbSYJKMgu1Or0gw7zrt/fdmcRljQvp5xYFN/ZjVgOiudgjBap9P0SkhQ9coVLMEYrainpEx1vOBZQ14TfF7VzlNuqUIMu/WD+jx1n5bGYgbxEKQ7iaCWpnjN+17H83RaoL/W7XOx/3wiKzA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yJNh0b8KS0CAyPtu+XRIhjkCkmQ5POH+K0heV3+POaKVVRJj5Kuj1QPu3xaU+XD+wWCgGKWQ6CaPwhlYBldkgjS5r4XNzbiItBrjSgBvyGzvkCSA0ryIf76FXjH1pT3MX3G0/bEzLWlSzdRWpwMGJkOcjMMc2Vv4CBMUfsEbxdvOAbeiwi3OkcN79c4tQ/ZBv0b20jG0+dqRaN6iQFFcPV8iMGvu2d8eRwX7ESsRJN/3LOiXqk7sWn32vksZNSWPkfUuZ6RIdkQTjf9K/UkYNf/D2nVIUobdm2ymCTHk+QvsT6MNNv5h3g1Kq+utkbub+Mo+ChOdZ7w+cFdjTL5e2e4A2dlAIkXPMt/qyi9hRx4OUE1lqIXgi8WH1ISAJRT/f96fCYV9uXJCmVfdX6q4X3rFAxOMAilWKtKC2RxxBbGst2xXMbvH3TmAPlzhycB0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 05:27:26.1116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ed60a6-f966-439f-8e34-08df2b462a0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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

Drivers implementing synchronous flow rules through the asynchronous
template API need to apply item masks before creating a rule. The spec
and last pointers are const, so this requires writable copies and
per-item knowledge of their sizes.

Add RTE_FLOW_CONV_OP_PATTERN_MASKED to rte_flow_conv(). It copies the
pattern like RTE_FLOW_CONV_OP_PATTERN and ANDs the inline fields of each
copied spec and last with an explicit item mask. A NULL mask leaves the
values unchanged; default masks are not substituted.

Preserve GENEVE_OPT.option_len and TAG.index because they describe the
pointed-to data length and select the tag register, respectively.
RAW pattern and GENEVE_OPT data are copied without applying their
payload masks. Limit this operation to inline fields, leaving
variable-length payload masking to the caller. FLEX, COMPARE and PMD
private items are not masked.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Reviewed-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
v2: add review comments from Dariusz Sosnowski
v3:
  - add test code
  - fix the issue found by AI
v4: reabse on top of the main
v5: handle some items separately and add test for them
v6: resend the correct version instead of v5 with AI defects resolved
v7: address the review comments from AI
v8:
  - preserve GENEVE_OPT option_len and TAG index
  - test spec and last preservation, TAG data masking and unchanged masks
  - document the masking exceptions and explicit-mask behavior
  - clarify the inline-only scope without insertion-rate claims
  - rebase on the latest main, retaining the default-mask lookup operation
---
 app/test/test_ethdev_api.c             | 389 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |   9 +
 lib/ethdev/rte_flow.c                  |  80 ++++-
 lib/ethdev/rte_flow.h                  |  17 ++
 4 files changed, 489 insertions(+), 6 deletions(-)

diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c
index 76afd0345c..69cb38a0a1 100644
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
@@ -15,6 +18,374 @@
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
+	const uint8_t raw_pattern_mask[] = { 0x0f, 0xf0, 0x00, 0xff };
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
+		.pattern = raw_pattern_mask,
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
+				      "RAW pattern bytes must not be masked");
+
+	/*
+	 * NULL mask keeps spec and last unchanged: the IPv4 default mask
+	 * (addresses only) is not substituted. An explicit mask is applied
+	 * to both spec and last. Private items, GENEVE_OPT length and data,
+	 * TAG index and COMPARE items are not masked.
+	 */
+	{
+		const struct rte_flow_item_ipv4 ipv4_open = {
+			.hdr = {
+				.type_of_service = 0xab,
+				.time_to_live = 0x40,
+				.src_addr = RTE_BE32(0x0a010203),
+				.dst_addr = RTE_BE32(0xc0a80001),
+			},
+		};
+		const struct rte_flow_item_ipv4 ipv4_spec = {
+			.hdr = {
+				.type_of_service = 0xab,
+				.time_to_live = 0x40,
+				.src_addr = RTE_BE32(0x0a000001),
+				.dst_addr = RTE_BE32(0x0a000002),
+			},
+		};
+		const struct rte_flow_item_ipv4 ipv4_last = {
+			.hdr = {
+				.type_of_service = 0xcd,
+				.time_to_live = 0x20,
+				.src_addr = RTE_BE32(0x0a0000ff),
+				.dst_addr = RTE_BE32(0x0a00ffff),
+			},
+		};
+		const struct rte_flow_item_ipv4 ipv4_mask = {
+			.hdr = {
+				.type_of_service = 0x0f,
+				.src_addr = RTE_BE32(0xffffffff),
+				.dst_addr = RTE_BE32(0x0000ffff),
+			},
+		};
+		const struct {
+			uint64_t value;
+			uint32_t tail;
+		} priv_spec = {
+			.value = 0x1122334455667788ULL,
+			.tail = 0xaabbccdd,
+		};
+		const struct {
+			uint64_t value;
+			uint32_t tail;
+		} priv_mask = {
+			.value = 0,
+			.tail = 0,
+		};
+		uint32_t opt_data[2] = { 0xffffffff, 0x11111111 };
+		uint32_t opt_data_mask[2] = { 0, 0 };
+		const struct rte_flow_item_geneve_opt opt_spec = {
+			.option_class = RTE_BE16(0x1234),
+			.option_type = 0xaa,
+			.option_len = 2,
+			.data = opt_data,
+		};
+		const struct rte_flow_item_geneve_opt opt_mask = {
+			.option_type = 0xff,
+			.data = opt_data_mask,
+		};
+		uint32_t cmp_value = 0x12345678;
+		const struct rte_flow_item_compare cmp_spec = {
+			.operation = RTE_FLOW_ITEM_COMPARE_GT,
+			.a = {
+				.field = RTE_FLOW_FIELD_TAG,
+				.tag_index = 1,
+			},
+			.b = {
+				.field = RTE_FLOW_FIELD_POINTER,
+				.pvalue = &cmp_value,
+			},
+			.width = 32,
+		};
+		const struct rte_flow_item_compare cmp_mask = {
+			.width = UINT32_MAX,
+		};
+		const struct rte_flow_item_tag tag_spec = {
+			.data = 0x12345678,
+			.index = 3,
+		};
+		const struct rte_flow_item_tag tag_last = {
+			.data = 0xabcdef01,
+			.index = 3,
+		};
+		const struct rte_flow_item_tag tag_mask = {
+			.data = 0x00ff00ff,
+			.index = 0,
+		};
+		const struct rte_flow_item limits[] = {
+			{
+				.type = RTE_FLOW_ITEM_TYPE_IPV4,
+				.spec = &ipv4_open,
+				.last = &ipv4_open,
+			},
+			{
+				.type = RTE_FLOW_ITEM_TYPE_IPV4,
+				.spec = &ipv4_spec,
+				.last = &ipv4_last,
+				.mask = &ipv4_mask,
+			},
+			{
+				.type = (enum rte_flow_item_type)-1,
+				.spec = &priv_spec,
+				.mask = &priv_mask,
+			},
+			{
+				.type = RTE_FLOW_ITEM_TYPE_GENEVE_OPT,
+				.spec = &opt_spec,
+				.last = &opt_spec,
+				.mask = &opt_mask,
+			},
+			{
+				.type = RTE_FLOW_ITEM_TYPE_COMPARE,
+				.spec = &cmp_spec,
+				.mask = &cmp_mask,
+			},
+			{
+				.type = RTE_FLOW_ITEM_TYPE_TAG,
+				.spec = &tag_spec,
+				.last = &tag_last,
+				.mask = &tag_mask,
+			},
+			{ .type = RTE_FLOW_ITEM_TYPE_END },
+		};
+		union {
+			struct rte_flow_item item;
+			uint8_t buf[1024];
+		} conv;
+		const struct rte_flow_item *out;
+		const struct rte_flow_item_ipv4 *ipv4;
+		const struct rte_flow_item_geneve_opt *opt;
+		const struct rte_flow_item_compare *cmp;
+		const struct rte_flow_item_tag *tag;
+
+		memset(&conv, 0, sizeof(conv));
+		ret = rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, conv.buf,
+				    sizeof(conv.buf), limits, NULL);
+		TEST_ASSERT(ret > 0, "Limit pattern conversion failed");
+		TEST_ASSERT((size_t)ret <= sizeof(conv.buf),
+			    "Limit pattern conversion needs too much storage");
+
+		out = (const struct rte_flow_item *)conv.buf;
+		TEST_ASSERT_NULL(out[0].mask, "NULL mask must stay NULL");
+		ipv4 = out[0].spec;
+		TEST_ASSERT_NOT_NULL(ipv4, "Unmasked IPv4 spec must be set");
+		TEST_ASSERT_EQUAL(ipv4->hdr.type_of_service, 0xab,
+				  "NULL mask must not clear IPv4 TOS");
+		TEST_ASSERT_EQUAL(ipv4->hdr.time_to_live, 0x40,
+				  "NULL mask must not clear IPv4 TTL");
+		TEST_ASSERT_EQUAL(ipv4->hdr.src_addr, ipv4_open.hdr.src_addr,
+				  "NULL mask must keep IPv4 source address");
+		TEST_ASSERT_EQUAL(ipv4->hdr.dst_addr, ipv4_open.hdr.dst_addr,
+				  "NULL mask must keep IPv4 destination address");
+		ipv4 = out[0].last;
+		TEST_ASSERT_NOT_NULL(ipv4, "Unmasked IPv4 last must be set");
+		TEST_ASSERT_EQUAL(ipv4->hdr.type_of_service, 0xab,
+				  "NULL mask must not clear IPv4 last TOS");
+		TEST_ASSERT_EQUAL(ipv4->hdr.time_to_live, 0x40,
+				  "NULL mask must not clear IPv4 last TTL");
+
+		ipv4 = out[1].spec;
+		TEST_ASSERT_NOT_NULL(ipv4, "Masked IPv4 spec must be set");
+		TEST_ASSERT_EQUAL(ipv4->hdr.type_of_service, 0x0b,
+				  "IPv4 spec TOS mask mismatch");
+		TEST_ASSERT_EQUAL(ipv4->hdr.time_to_live, 0,
+				  "IPv4 spec TTL must be cleared by the mask");
+		TEST_ASSERT_EQUAL(ipv4->hdr.src_addr, ipv4_spec.hdr.src_addr,
+				  "IPv4 spec source address mismatch");
+		TEST_ASSERT_EQUAL(ipv4->hdr.dst_addr, RTE_BE32(0x00000002),
+				  "IPv4 spec destination address mismatch");
+		ipv4 = out[1].last;
+		TEST_ASSERT_NOT_NULL(ipv4, "Masked IPv4 last must be set");
+		TEST_ASSERT_EQUAL(ipv4->hdr.type_of_service, 0x0d,
+				  "IPv4 last TOS mask mismatch");
+		TEST_ASSERT_EQUAL(ipv4->hdr.time_to_live, 0,
+				  "IPv4 last TTL must be cleared by the mask");
+		TEST_ASSERT_EQUAL(ipv4->hdr.src_addr, ipv4_last.hdr.src_addr,
+				  "IPv4 last source address mismatch");
+		TEST_ASSERT_EQUAL(ipv4->hdr.dst_addr, RTE_BE32(0x0000ffff),
+				  "IPv4 last destination address mismatch");
+
+		TEST_ASSERT_NOT_NULL(out[2].spec, "Private spec must be set");
+		TEST_ASSERT_BUFFERS_ARE_EQUAL(out[2].spec, &priv_spec,
+					      sizeof(void *),
+					      "PMD private spec must not be masked");
+
+		opt = out[3].spec;
+		TEST_ASSERT_NOT_NULL(opt, "GENEVE_OPT spec must be set");
+		TEST_ASSERT_EQUAL(opt->option_class, 0,
+				  "GENEVE_OPT class must be masked");
+		TEST_ASSERT_EQUAL(opt->option_type, 0xaa,
+				  "GENEVE_OPT type mask mismatch");
+		TEST_ASSERT_EQUAL(opt->option_len, opt_spec.option_len,
+				  "GENEVE_OPT length must not be masked");
+		TEST_ASSERT(opt->data != opt_data,
+			    "GENEVE_OPT data must be deep-copied");
+		TEST_ASSERT_BUFFERS_ARE_EQUAL(opt->data, opt_data, sizeof(opt_data),
+					      "GENEVE_OPT data must not be masked");
+		opt = out[3].last;
+		TEST_ASSERT_NOT_NULL(opt, "GENEVE_OPT last must be set");
+		TEST_ASSERT_EQUAL(opt->option_class, 0,
+				  "GENEVE_OPT last class must be masked");
+		TEST_ASSERT_EQUAL(opt->option_type, 0xaa,
+				  "GENEVE_OPT last type mask mismatch");
+		TEST_ASSERT_EQUAL(opt->option_len, opt_spec.option_len,
+				  "GENEVE_OPT last length must not be masked");
+		TEST_ASSERT(opt->data != opt_data,
+			    "GENEVE_OPT last data must be deep-copied");
+		TEST_ASSERT_BUFFERS_ARE_EQUAL(opt->data, opt_data, sizeof(opt_data),
+					      "GENEVE_OPT last data must not be masked");
+
+		cmp = out[4].spec;
+		TEST_ASSERT_NOT_NULL(cmp, "COMPARE spec must be set");
+		TEST_ASSERT_EQUAL(cmp->operation, RTE_FLOW_ITEM_COMPARE_GT,
+				  "COMPARE operation must not be masked");
+		TEST_ASSERT_EQUAL(cmp->a.field, RTE_FLOW_FIELD_TAG,
+				  "COMPARE field a must not be masked");
+		TEST_ASSERT_EQUAL(cmp->a.tag_index, 1,
+				  "COMPARE field a tag index must not be masked");
+		TEST_ASSERT_EQUAL(cmp->b.field, RTE_FLOW_FIELD_POINTER,
+				  "COMPARE field b must not be masked");
+		TEST_ASSERT(cmp->b.pvalue == &cmp_value,
+			    "COMPARE pointer must not be masked");
+
+		tag = out[5].spec;
+		TEST_ASSERT_NOT_NULL(tag, "TAG spec must be set");
+		TEST_ASSERT_EQUAL(tag->data, 0x00340078,
+				  "TAG spec data mask mismatch");
+		TEST_ASSERT_EQUAL(tag->index, tag_spec.index,
+				  "TAG spec index must not be masked");
+		tag = out[5].last;
+		TEST_ASSERT_NOT_NULL(tag, "TAG last must be set");
+		TEST_ASSERT_EQUAL(tag->data, 0x00cd0001,
+				  "TAG last data mask mismatch");
+		TEST_ASSERT_EQUAL(tag->index, tag_last.index,
+				  "TAG last index must not be masked");
+		tag = out[5].mask;
+		TEST_ASSERT_NOT_NULL(tag, "TAG mask must be set");
+		TEST_ASSERT_EQUAL(tag->data, tag_mask.data,
+				  "TAG data mask must not change");
+		TEST_ASSERT_EQUAL(tag->index, tag_mask.index,
+				  "TAG index mask must not change");
+	}
+
+	return TEST_SUCCESS;
+}
+
 static int32_t
 ethdev_api_queue_status(void)
 {
@@ -162,6 +533,24 @@ ethdev_api_queue_status(void)
 	return TEST_SUCCESS;
 }
 
+static struct unit_test_suite ethdev_flow_conv_testsuite = {
+	.suite_name = "ethdev flow conversion tests",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(ethdev_api_flow_conv_pattern_masked),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_ethdev_flow_conv(void)
+{
+	return unit_test_suite_runner(&ethdev_flow_conv_testsuite);
+}
+
+REGISTER_FAST_TEST(ethdev_flow_conv, NOHUGE_OK, ASAN_OK, test_ethdev_flow_conv);
+
 static struct unit_test_suite ethdev_api_testsuite = {
 	.suite_name = "ethdev API tests",
 	.setup = NULL,
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c02..c318e961ea 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -123,6 +123,15 @@ New Features
   Added internal ``flow_graph`` API in ethdev
   for PMD drivers to build graph-based flow pattern parsers.
 
+* **Added masked pattern conversion to flow API.**
+
+  Added ``RTE_FLOW_CONV_OP_PATTERN_MASKED`` to ``rte_flow_conv()``.
+  The new operation copies a pattern like ``RTE_FLOW_CONV_OP_PATTERN`` and
+  ANDs inline fields of each item ``spec`` and ``last`` with an explicit mask.
+  It preserves ``GENEVE_OPT.option_len`` and ``TAG.index``.
+  RAW pattern bytes, GENEVE_OPT data, FLEX, COMPARE and PMD private items
+  are not masked. Items with a NULL mask remain unchanged.
+
 * **Updated AF_XDP driver.**
 
   * Changed the default device plugin endpoint path used when
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 0ebf59165d..25611c712c 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -245,6 +245,37 @@ static const struct rte_flow_desc_data rte_flow_desc_item[] = {
 	MK_FLOW_ITEM(COMPARE, sizeof(struct rte_flow_item_compare)),
 };
 
+/**
+ * Leading spec/last bytes that PATTERN_MASKED may AND with the item mask.
+ *
+ * PMD private items and FLEX return 0: their layout is opaque or the
+ * meaningful bytes sit past a pointer. RAW stops before its pattern
+ * pointer; GENEVE_OPT stops before option_len to preserve the data
+ * length and pointer. TAG stops before index to preserve its selector.
+ * Pointed-to data is not masked. COMPARE returns 0: its field descriptors
+ * hold selectors and pointers (pvalue, flex_handle) rather than match bits.
+ */
+static inline size_t
+rte_flow_conv_item_mask_size(const struct rte_flow_item *item)
+{
+	if ((int)item->type < 0)
+		return 0;
+	switch (item->type) {
+	case RTE_FLOW_ITEM_TYPE_RAW:
+		return offsetof(struct rte_flow_item_raw, pattern);
+	case RTE_FLOW_ITEM_TYPE_GENEVE_OPT:
+		return offsetof(struct rte_flow_item_geneve_opt, option_len);
+	case RTE_FLOW_ITEM_TYPE_TAG:
+		return offsetof(struct rte_flow_item_tag, index);
+	case RTE_FLOW_ITEM_TYPE_COMPARE:
+		return 0;
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
@@ -887,6 +918,16 @@ rte_flow_conv_action_conf(void *buf, const size_t size,
 	return off;
 }
 
+/** AND @p len bytes of @p buf with @p mask. */
+static inline void
+rte_flow_conv_apply_mask(uint8_t *buf, const uint8_t *mask, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		buf[i] &= mask[i];
+}
+
 /**
  * Copy a list of pattern items.
  *
@@ -900,6 +941,11 @@ rte_flow_conv_action_conf(void *buf, const size_t size,
  *   Maximum number of pattern items to process from @p src or 0 to process
  *   the entire list. In both cases, processing stops after
  *   RTE_FLOW_ITEM_TYPE_END is encountered.
+ * @param[in] with_mask
+ *   If true, AND each copied spec and last with the item mask.
+ *   A NULL mask is not replaced by the default mask. RAW pattern bytes,
+ *   GENEVE_OPT option_len and data, TAG index, FLEX, COMPARE and PMD
+ *   private items are not masked.
  * @param[out] error
  *   Perform verbose error reporting if not NULL.
  *
@@ -914,6 +960,7 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 		      const size_t size,
 		      const struct rte_flow_item *src,
 		      unsigned int num,
+		      bool with_mask,
 		      struct rte_flow_error *error)
 {
 	uintptr_t data = (uintptr_t)dst;
@@ -943,16 +990,29 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 	src -= num;
 	dst -= num;
 	do {
+		uint8_t *c_spec = NULL, *c_last = NULL;
+		const uint8_t *mask = NULL;
+		size_t item_mask_size = 0;
+
+		if (with_mask && src->mask) {
+			mask = src->mask;
+			item_mask_size = rte_flow_conv_item_mask_size(src);
+		}
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
-
+			if (c_spec && mask && item_mask_size)
+				rte_flow_conv_apply_mask(c_spec, mask,
+							 RTE_MIN(ret, item_mask_size));
 		}
 		if (src->last) {
 			off = RTE_ALIGN_CEIL(off, sizeof(double));
@@ -960,9 +1020,14 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 				((void *)(data + off),
 				 size > off ? size - off : 0, src,
 				 RTE_FLOW_CONV_ITEM_LAST);
-			if (size && size >= off + ret)
+			if (size && size >= off + ret) {
 				dst->last = (void *)(data + off);
+				c_last = (uint8_t *)(data + off);
+			}
 			off += ret;
+			if (c_last && mask && item_mask_size)
+				rte_flow_conv_apply_mask(c_last, mask,
+							 RTE_MIN(ret, item_mask_size));
 		}
 		if (src->mask) {
 			off = RTE_ALIGN_CEIL(off, sizeof(double));
@@ -1109,7 +1174,7 @@ rte_flow_conv_rule(struct rte_flow_conv_rule *dst,
 		off = RTE_ALIGN_CEIL(off, sizeof(double));
 		ret = rte_flow_conv_pattern((void *)((uintptr_t)dst + off),
 					    size > off ? size - off : 0,
-					    src->pattern_ro, 0, error);
+					    src->pattern_ro, 0, false, error);
 		if (ret < 0)
 			return ret;
 		if (size && size >= off + (size_t)ret)
@@ -1228,7 +1293,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 		ret = sizeof(*attr);
 		break;
 	case RTE_FLOW_CONV_OP_ITEM:
-		ret = rte_flow_conv_pattern(dst, size, src, 1, error);
+		ret = rte_flow_conv_pattern(dst, size, src, 1, false, error);
 		break;
 	case RTE_FLOW_CONV_OP_ITEM_MASK:
 		item = src;
@@ -1243,7 +1308,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 		ret = rte_flow_conv_actions(dst, size, src, 1, error);
 		break;
 	case RTE_FLOW_CONV_OP_PATTERN:
-		ret = rte_flow_conv_pattern(dst, size, src, 0, error);
+		ret = rte_flow_conv_pattern(dst, size, src, 0, false, error);
 		break;
 	case RTE_FLOW_CONV_OP_ACTIONS:
 		ret = rte_flow_conv_actions(dst, size, src, 0, error);
@@ -1266,6 +1331,9 @@ rte_flow_conv(enum rte_flow_conv_op op,
 	case RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR:
 		ret = rte_flow_conv_item_default_mask(dst, size, src, error);
 		break;
+	case RTE_FLOW_CONV_OP_PATTERN_MASKED:
+		ret = rte_flow_conv_pattern(dst, size, src, 0, true, error);
+		break;
 	default:
 		ret = rte_flow_error_set
 		(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index df8101e439..3cbe27bac4 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4426,6 +4426,23 @@ enum rte_flow_conv_op {
 	 *   @code const void ** @endcode
 	 */
 	RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR,
+
+	/**
+	 * Convert an entire pattern, applying item masks.
+	 *
+	 * Same as RTE_FLOW_CONV_OP_PATTERN, except each copied spec
+	 * and last is ANDed with the item mask. Not masked:
+	 * - items with a NULL mask (default mask is not applied);
+	 * - RAW pattern and GENEVE_OPT data contents;
+	 * - GENEVE_OPT option_len and TAG index;
+	 * - FLEX, COMPARE and PMD private items.
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
