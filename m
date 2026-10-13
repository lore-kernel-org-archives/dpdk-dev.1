Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E3ACC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 13:50:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D880A4028B;
	Tue, 13 Oct 2026 15:50:44 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
 by mails.dpdk.org (Postfix) with ESMTP id 00D2940272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:50:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muINA9VmY8hI1dkFvg+37zOCFNEs6NIFgBETIqrvamNJKiUZKJjwVfgjl6cIuR4/b/3MfE3DaGyPKNW318CogyLVaO8MIxkvKaMtJy6RnsC9p+qlpxfvlXGn0ZTuoS45UnkD366A2wHqqzHVD1YaStKmb/zzfqO6HhFVZ4Ke0ewQQZItAvVGgT4KMfgxS7WMFPGKO4oUknhLRNivUXJgLhBnOWSXm/7Vf2UJ2PZBHS0ANn6eIp4nYsUaxCSqweMiGqE4C7YrT1L0cGePvH6B+Y8fx/D1XRFk4c7v+usOmwpdq8lkr1+puK8WJce2D9d6JGNICdu87O6gtSgSttYSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0xT1VV7GgsU1xeswh7zDpFo0n1ka6FRecYELsjtT6s=;
 b=bJNhGz7FuFB4zpfdA+5LhMcsWsf7kNG4aNwCgAOG8JBfGQFW6wTsv3Vzos4aXrKziUG9zKlv8OpFFlHJ4lrYJ5V2Fwg0Jy0j+k18dRhwz1uC4lPazQuRDa7gP0VrFEr+6jMA45qwlobFT+oa+cjaJpSO1BcLfP6MWUVQ7Wu+upHOvVgOVo5a9USKSOJL0vPEQQsHzkk4wKBCK5arpbRfgOsqM21y3jA7rk5WwiDKlwUymd4wJ6eucEK6Om1TFt7zWyLYq7Ct7l5W7aRPcMiotejIDGeGE8Vo9/gMAzTcsxE5get3NS/BC3DfgE+gqcY1gftkJyfPs1WL1Nj86sM94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0xT1VV7GgsU1xeswh7zDpFo0n1ka6FRecYELsjtT6s=;
 b=C8I1+enMA02XMXXSV3yi1kuJpzvVoBqRdzmr4B/v/sQvIupuhWW9XIx9ZYvCdHSkhVvA4b8T5bn4Zlz6wm33TmaKnnIyHIFZ3sbY4nAqgAwnSUuCh99JPXc4xu4DfLrlsNQhLQqMP7qcfeJOgfNF/53yUPty9jW3GHSxWyshQrtTco5wZ0n1xI5meSa1V+sUALS53WOAFYkZhtqnqLkoBrnzSvVi/13Cin1Wj/kL78VsHv+z6WB+5Fcy8QOsZ7APumcRV2kxcGFAN5Q2uLqgVnTLxpG/0WVaAePhTjBV3jYKPPuZHsCB2t0dZbm8fVq0czeNc3MbUOU7aHi8aEoRFQ==
Received: from BN9PR03CA0959.namprd03.prod.outlook.com (2603:10b6:408:108::34)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 13:50:27 +0000
Received: from BN5PEPF0004698B.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::5d) by BN9PR03CA0959.outlook.office365.com
 (2603:10b6:408:108::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 13:50:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN5PEPF0004698B.mail.protection.outlook.com (10.167.245.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 13:50:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 06:50:07 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 06:50:04 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <stephen@networkplumber.org>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH v7] ethdev: support inline calculating masked item value
Date: Tue, 13 Oct 2026 16:49:50 +0300
Message-ID: <20261013134950.310252-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007165904.126976-1-bingz@nvidia.com>
References: <20261007165904.126976-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698B:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: d58160e2-4d1b-4fb3-6410-08df2930f024
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|10067099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0lRcvGFU7OBy4BEDVpiJs2k8kbwafTEwK233pfRbpHg4w4yegiBszSSilhoRFpyAep18U0CGSkxRifB1ptw5BlZ97Oe4PUGeiEy/okuklS7thW7lMmHJiJz5bBOxfOECfRiHUz5ewJ3JUQw+nlEaJdwNwbQrGOhemK91WuStwQlveS7V0Yw2KzV402CbRZr3rcSpqhd7dlKZAdxbeUVWbU9BekYRXs69jm7fCtTBt+5j3vQpI7Bfy5NUSoNGMLBXwOGTWD0mFz0LfONLHO+PlqWxf5h4rkcxuqvwe+/trwJQfT3sGugyiBoe6Xb3/UjDMcLuG7YEDuakZDgEbPGbtdgSV9Hor09h8ngkP+JG/RJU3fALB2nXxB2/Uq+3FMieGRh2gN6agviN52YGjkwmJiFU4UpItvBZuuthGIn0BEZzEWDp8TjoTAxGph0jcLz/cIqek7wOuunH1YNUD1F8l3OkIxZptYxr+oPiXFicM75baM/y1lp9o/9hbYhu2c9pgvmKYFEfl2/pzP+rWFDZmMOYPzO9CrQ0b8pakhUq4OKdPMdSr/Jba4GB/bhWroWTyXTzeh1S8RtBfRCzPBODWJSXmXcwpgwLQpl6+ZR5x2/wou64gJLjsqVfseDNQWbioQGRPZ0BPKNjc7CEfea/ONob1fzepeoVQwAIAwRzVlWa2BlERkC8imj5RWcLsPJ+ua1BosXMhf65IVCqMQuwFA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5C7/2QDuxrm77yatP1VaMBREuIb1rEWTzvlGpijPPuZbbhnNkzlqc1qis7Cvda57+MtWxHJXQgdZ93A0QPQgVBNtOgXTDLXhnH27AhgYZ/bupqZvcoPH3+3PbHjFF0vE5+qp4HrPrdDH3dfHVTjlGGXBNfN6Um1tTX19mV61UwlW1/wV+Y+aApFY8W0WOZlBrUc+o5hKEC+SQM/kCaX93yh1dSnnRnprbTQ10oHTTNXae+NS04NRjfdoExlQW4ikpeNouJkWQbzEe0QB/BjxlYR9ozQusE5+Y2NKVNdPux0Q0N2FxMsGoxPY6KF5mWR0ol/BjKg1y/PgykuYMlGZHACZeCqJG9cACsMgbUIG4/C7g+2mtLvVvxX1VuuNXy0BpxUsNqTau861NuLBaDhsRQCtMBYlYFLo/XB8OhZtPNmL4jS76dqTRTm9jjNxTwAx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:50:27.2128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d58160e2-4d1b-4fb3-6410-08df2930f024
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316
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
---
 app/test/test_ethdev_api.c             | 338 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |   6 +
 lib/ethdev/rte_flow.c                  |  76 +++++-
 lib/ethdev/rte_flow.h                  |  16 ++
 4 files changed, 430 insertions(+), 6 deletions(-)

diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c
index 76afd0345c..ef4c318b7d 100644
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
@@ -15,6 +18,323 @@
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
+	 * to both spec and last. Private items, GENEVE_OPT data and COMPARE
+	 * items are not.
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
+				.mask = &opt_mask,
+			},
+			{
+				.type = RTE_FLOW_ITEM_TYPE_COMPARE,
+				.spec = &cmp_spec,
+				.mask = &cmp_mask,
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
+		TEST_ASSERT_EQUAL(opt->option_len, 0,
+				  "GENEVE_OPT length must be masked");
+		TEST_ASSERT(opt->data != opt_data,
+			    "GENEVE_OPT data must be deep-copied");
+		TEST_ASSERT_BUFFERS_ARE_EQUAL(opt->data, opt_data, sizeof(opt_data),
+					      "GENEVE_OPT data must not be masked");
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
+	}
+
+	return TEST_SUCCESS;
+}
+
 static int32_t
 ethdev_api_queue_status(void)
 {
@@ -162,6 +482,24 @@ ethdev_api_queue_status(void)
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
index a6df347411..31c909dad9 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -82,6 +82,12 @@ New Features
   Added support for the VFIO character device (cdev) API, also known as IOMMUFD.
   DPDK now supports both the group mode and the new cdev mode.
 
+* **Added masked pattern conversion to flow API.**
+
+  Added ``RTE_FLOW_CONV_OP_PATTERN_MASKED`` to ``rte_flow_conv()``.
+  The new operation copies a pattern like ``RTE_FLOW_CONV_OP_PATTERN`` and
+  ANDs each item ``spec`` and ``last`` with the item mask.
+
 * **Updated AF_XDP driver.**
 
   * Changed the default device plugin endpoint path used when
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 1056cfd2c5..f74b5353a0 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -179,6 +179,34 @@ static const struct rte_flow_desc_data rte_flow_desc_item[] = {
 	MK_FLOW_ITEM(COMPARE, sizeof(struct rte_flow_item_compare)),
 };
 
+/**
+ * Leading spec/last bytes that PATTERN_MASKED may AND with the item mask.
+ *
+ * PMD private items and FLEX return 0: their layout is opaque or the
+ * meaningful bytes sit past a pointer. RAW and GENEVE_OPT stop before
+ * that pointer, so the payload it refers to is not masked. COMPARE
+ * returns 0: its field descriptors hold selectors and pointers
+ * (pvalue, flex_handle) rather than match bits.
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
+		return offsetof(struct rte_flow_item_geneve_opt, data);
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
@@ -821,6 +849,16 @@ rte_flow_conv_action_conf(void *buf, const size_t size,
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
@@ -834,6 +872,10 @@ rte_flow_conv_action_conf(void *buf, const size_t size,
  *   Maximum number of pattern items to process from @p src or 0 to process
  *   the entire list. In both cases, processing stops after
  *   RTE_FLOW_ITEM_TYPE_END is encountered.
+ * @param[in] with_mask
+ *   If true, AND each copied spec and last with the item mask.
+ *   A NULL mask is not replaced by the default mask. RAW pattern bytes,
+ *   GENEVE_OPT data, FLEX, COMPARE and PMD private items are not masked.
  * @param[out] error
  *   Perform verbose error reporting if not NULL.
  *
@@ -848,6 +890,7 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 		      const size_t size,
 		      const struct rte_flow_item *src,
 		      unsigned int num,
+		      bool with_mask,
 		      struct rte_flow_error *error)
 {
 	uintptr_t data = (uintptr_t)dst;
@@ -877,16 +920,29 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
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
@@ -894,9 +950,14 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
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
@@ -1043,7 +1104,7 @@ rte_flow_conv_rule(struct rte_flow_conv_rule *dst,
 		off = RTE_ALIGN_CEIL(off, sizeof(double));
 		ret = rte_flow_conv_pattern((void *)((uintptr_t)dst + off),
 					    size > off ? size - off : 0,
-					    src->pattern_ro, 0, error);
+					    src->pattern_ro, 0, false, error);
 		if (ret < 0)
 			return ret;
 		if (size && size >= off + (size_t)ret)
@@ -1144,7 +1205,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 		ret = sizeof(*attr);
 		break;
 	case RTE_FLOW_CONV_OP_ITEM:
-		ret = rte_flow_conv_pattern(dst, size, src, 1, error);
+		ret = rte_flow_conv_pattern(dst, size, src, 1, false, error);
 		break;
 	case RTE_FLOW_CONV_OP_ITEM_MASK:
 		item = src;
@@ -1159,7 +1220,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 		ret = rte_flow_conv_actions(dst, size, src, 1, error);
 		break;
 	case RTE_FLOW_CONV_OP_PATTERN:
-		ret = rte_flow_conv_pattern(dst, size, src, 0, error);
+		ret = rte_flow_conv_pattern(dst, size, src, 0, false, error);
 		break;
 	case RTE_FLOW_CONV_OP_ACTIONS:
 		ret = rte_flow_conv_actions(dst, size, src, 0, error);
@@ -1179,6 +1240,9 @@ rte_flow_conv(enum rte_flow_conv_op op,
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
index 1bfe1b3f61..428e5f4fd4 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4411,6 +4411,22 @@ enum rte_flow_conv_op {
 	 *   @code const char ** @endcode
 	 */
 	RTE_FLOW_CONV_OP_ACTION_NAME_PTR,
+
+	/**
+	 * Convert an entire pattern, applying item masks.
+	 *
+	 * Same as RTE_FLOW_CONV_OP_PATTERN, except each copied spec
+	 * and last is ANDed with the item mask. Not masked:
+	 * - items with a NULL mask (default mask is not applied);
+	 * - RAW pattern and GENEVE_OPT data contents;
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

