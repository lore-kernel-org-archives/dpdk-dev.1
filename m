Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42F2CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 09:28:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3E0D402B6;
	Wed,  3 Jun 2026 11:28:52 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by mails.dpdk.org (Postfix) with ESMTP id BFC98402AB
 for <dev@dpdk.org>; Wed,  3 Jun 2026 11:28:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyvHggDXJR5vGzKwqro2SJn3qbvgdrx/i9UcUHjJqtiqgoKwfmvrbjF5z6aZVuBYfKQFt/to9XPlYwy+4wuz6fAzy0litZx8XNE/YhSCfJTkXdV4x5YNmpnP1vqBD/FHbXs3hjMpjTfhi5/gLaJClYe1oOUtYv21YR5cniOR671qjoq11CVRT7CxmpABZy9WqTgINOQmHlyROR7Vx5oe+2P42opY8mEJk8if01s1R+5M+DlvaGj/vDvLDYSc5I/BMSmHaqHtPMoc4c92mMLGoN1PjeDYLW138q1csJqI59AZbjF6XjORgutppca1lBjCL7Y+Z07yZ3v++8KnXQMaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmJnCGIF6kF/6gvDuYSy9ALXhhcxdNm2Hd5JpRzsA+I=;
 b=lu1nekuRsz3+dBUTGq3AehnreXmnPqYWGa64SFMplVxQurBuDT9VMAPahwsa3IJ7N1Wi1oWC/Zk0DlQDpCITw/YvG8V/8aa1Au9CJ5RiHL6QGM+C26JIoAgnJaQ4TOnCm41BpVi9vsU/zIlCOoslyfY6hJbClBTUZ6MqFKN+d5+z/MZbS+4Vzj05QJOuHMgnrnrppVqN4ZMdZO/W9/6nVfqugwn8h6+HDq+ndff+Ck0wS/3N01C/O5GZrszwW+mKoFmLm3VMdngVGIdTHr5RfMEiuzvhkcxkReLiF25Wfa9UXha/BckpD/Cs7uXiyJjLOB4a5qw5tsbUYy6yxiXVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmJnCGIF6kF/6gvDuYSy9ALXhhcxdNm2Hd5JpRzsA+I=;
 b=WXEquOTLQnOKK2S67VyJB2DtlAlhFLCwkQKywb3qUH2OixTyZG7radzEYSXJWgAHOFlYQ/gAymt+yUPuOvf5ZySs2Wy3KA9ITQy4JoinqHXjazi8c4j3s33aWEZsy5hjoe81gsJYZceL9bPxbmQrAVvQTo/wW3WTqhI8gApw8H8Z/JHncCZnc/qaQCCmn9KtDzsS73SNrYAtoYaiJ8+7A2feFC+7EN++lsI42Q6uxscUgcfWuva9b+VK25/Tzc7tUywYZSaKrvK58QWvRX6TNI/Nop0UqthnoZABtrnMD3UNmSKgkh5WEcezoDcJWnXtiB9aiYCzpch45ew37Ed+Mg==
Received: from CY5PR15CA0032.namprd15.prod.outlook.com (2603:10b6:930:1b::8)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 09:28:43 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::45) by CY5PR15CA0032.outlook.office365.com
 (2603:10b6:930:1b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 09:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 09:28:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 02:28:25 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 02:28:22 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <stephen@networkplumber.org>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH v4] ethdev: support inline calculating masked item value
Date: Wed, 3 Jun 2026 12:28:05 +0300
Message-ID: <20260603092805.9837-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603081941.9049-1-bingz@nvidia.com>
References: <20260603081941.9049-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d9280a-0829-4f4e-ec7d-08dec1528107
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: vuWcx51BGpQOXTLlA7yhU5Fgn5jAjDjQsQ3iDNxbg5u6BvMvyJVAZnT4LQwByBv0WjBXBGHmBLyeUoy5AO4nXkf2oWi2mSKn5I/zM/3W4sXw1BRwdZRYrrwG/+4ASqCOQTAYPQyK4gICr7HkEPZkbDycnbPtAlVNTwnjrGekZR6fIBdZZ/KX0QjS6jVeH0Bq0jJj0dNmO84SsnBXtVQlkys9SqozKUVhUYLpUgPj7hoJioUPHPXDaVVy9zxcfMreWKAJE6V55C+GvDzAZT5+StChVIX6nof7601qxiCoLPayQuafrpwZM4OoVzFwjhh7HcTdAL2MnbiXTsaULlsvzxyHoD1pj4pcoMt38SiP3CMhwN9epSYEDgwmCQral29MUUfXC8Kjjif1vL2j3Ma4iQ26N+u4vNz/d7kSuY16jtK4mPbMmXxEd1Rw5paXgePMYWTYg8whvTvZTayECll9V5dgLrcjIz3NL9zgSsQG4VdCc3K1x4JOkvakQw0QT5RPV82SEAPb5zRBVS7WfaLO5d6HaZCdpVM9ITLMa1+rSEoigD8nj7nKxG5DtRM/mwAX8eljLO2svm9WRoaaB24kJ4asVUES5VdkfMWkaYPrsSljtuKyDQ2/J2UiJRpYgkVV5LLNhSTMIpGt3tPBPR50hr6eqPsUjLFBLKM9IAlSb3JnHWpMIJz2vXxGgiHZHf7E0uwFxpJX9liiCX5OPsSEfw3vpTIgGpYWgyZn+eZ4yx8=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NTPwUEs1CbDBRnWi4xYqVKtqrummLbD+j+QxBB1M9rqTIZNJwXZbvblwCLomjpeGpJtGBm4Jh9bTVyfB2MqNR7CKJ/Q8nlMlLfdfZHEftb7M39fNQ7Fv1YUtWzVvD4u5WglHohxa6OADpe2IqcS34vc+z5OwamymAWJYmDP89mL0DqiiDVvmJg34Ie6bd9cJQiph/nKUygrkj7Z/DJQ3OMvhqVa4zGpi/aAcFAqTgWRpoWxEJ97MkUrMY9jBjlukRLFA2f0Dw1FALgcr5cmtGOeW3QtdObDpS1EZ6pDJjGMrwUkmucgnO4B76xfd4tZ+Q+76zTCSQj0n6xBoJbNJhndPH+LjJqFIS/jqXNVkkHy/xjTzojaqBZyTqp1qzZaPzS2xqj+uO30opoMMIMStmUBGgAP5GsznHD2OJn911rkf1DMvtRRPRqxnI2tUmDAn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 09:28:42.8049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d9280a-0829-4f4e-ec7d-08dec1528107
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
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
---
v3:
  - add test code
  - fix the issue found by AI
v4: reabse on top of the main
---
 app/test/test_ethdev_api.c             | 76 ++++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_07.rst |  6 ++
 lib/ethdev/rte_flow.c                  | 46 ++++++++++++++--
 lib/ethdev/rte_flow.h                  | 13 +++++
 4 files changed, 135 insertions(+), 6 deletions(-)

diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c
index 76afd0345c..5cae1cdc1d 100644
--- a/app/test/test_ethdev_api.c
+++ b/app/test/test_ethdev_api.c
@@ -4,6 +4,7 @@
 
 #include <rte_log.h>
 #include <rte_ethdev.h>
+#include <rte_flow.h>
 
 #include <rte_test.h>
 #include "test.h"
@@ -15,6 +16,80 @@
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
+	const struct rte_flow_item pattern[] = {
+		{
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.spec = &spec,
+			.last = &last,
+			.mask = &mask,
+		},
+		{ .type = RTE_FLOW_ITEM_TYPE_END },
+	};
+	union {
+		struct rte_flow_item item;
+		struct rte_flow_item_eth eth;
+		double align;
+		uint8_t raw[256];
+	} dst;
+	const struct rte_flow_item *item;
+	const struct rte_flow_item_eth *conv_spec;
+	const struct rte_flow_item_eth *conv_last;
+	int ret;
+
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, NULL, 0, pattern, NULL);
+	TEST_ASSERT(ret > 0, "Masked pattern conversion size query failed");
+	TEST_ASSERT((size_t)ret <= sizeof(dst.raw),
+		    "Masked pattern conversion needs too much storage");
+
+	memset(&dst, 0, sizeof(dst));
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN_MASKED, dst.raw,
+			    sizeof(dst.raw), pattern, NULL);
+	TEST_ASSERT(ret > 0, "Masked pattern conversion failed");
+
+	item = (const struct rte_flow_item *)dst.raw;
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
+	return TEST_SUCCESS;
+}
+
 static int32_t
 ethdev_api_queue_status(void)
 {
@@ -167,6 +242,7 @@ static struct unit_test_suite ethdev_api_testsuite = {
 	.setup = NULL,
 	.teardown = NULL,
 	.unit_test_cases = {
+		TEST_CASE(ethdev_api_flow_conv_pattern_masked),
 		TEST_CASE(ethdev_api_queue_status),
 		/* TODO: Add deferred_start queue status test */
 		TEST_CASES_END() /**< NULL terminate unit test array */
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index b8a3e2ced9..5f01420d2b 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -134,6 +134,12 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* ethdev: Added masked pattern conversion.
+
+  Added ``RTE_FLOW_CONV_OP_PATTERN_MASKED`` to ``rte_flow_conv()``
+  to copy an entire pattern while applying each item's mask to its
+  ``spec`` and ``last`` fields.
+
 
 ABI Changes
 -----------
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 7a51b667cf..7cf9f6f6f3 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -178,6 +178,14 @@ static const struct rte_flow_desc_data rte_flow_desc_item[] = {
 	MK_FLOW_ITEM(COMPARE, sizeof(struct rte_flow_item_compare)),
 };
 
+static inline size_t
+rte_flow_conv_item_mask_size(const struct rte_flow_item *item)
+{
+	if ((int)item->type >= 0)
+		return rte_flow_desc_item[item->type].size;
+	return sizeof(void *);
+}
+
 /** Generate flow_action[] entry. */
 #define MK_FLOW_ACTION(t, s) \
 	[RTE_FLOW_ACTION_TYPE_ ## t] = { \
@@ -835,6 +843,8 @@ rte_flow_conv_action_conf(void *buf, const size_t size,
  *   RTE_FLOW_ITEM_TYPE_END is encountered.
  * @param[out] error
  *   Perform verbose error reporting if not NULL.
+ * @param[in] with_mask
+ *   If true, @p src mask will be applied to spec and last.
  *
  * @return
  *   A positive value representing the number of bytes needed to store
@@ -847,12 +857,13 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
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
@@ -876,15 +887,27 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
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
@@ -893,9 +916,17 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
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
@@ -1042,7 +1073,7 @@ rte_flow_conv_rule(struct rte_flow_conv_rule *dst,
 		off = RTE_ALIGN_CEIL(off, sizeof(double));
 		ret = rte_flow_conv_pattern((void *)((uintptr_t)dst + off),
 					    size > off ? size - off : 0,
-					    src->pattern_ro, 0, error);
+					    src->pattern_ro, 0, false, error);
 		if (ret < 0)
 			return ret;
 		if (size && size >= off + (size_t)ret)
@@ -1143,7 +1174,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 		ret = sizeof(*attr);
 		break;
 	case RTE_FLOW_CONV_OP_ITEM:
-		ret = rte_flow_conv_pattern(dst, size, src, 1, error);
+		ret = rte_flow_conv_pattern(dst, size, src, 1, false, error);
 		break;
 	case RTE_FLOW_CONV_OP_ITEM_MASK:
 		item = src;
@@ -1158,7 +1189,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 		ret = rte_flow_conv_actions(dst, size, src, 1, error);
 		break;
 	case RTE_FLOW_CONV_OP_PATTERN:
-		ret = rte_flow_conv_pattern(dst, size, src, 0, error);
+		ret = rte_flow_conv_pattern(dst, size, src, 0, false, error);
 		break;
 	case RTE_FLOW_CONV_OP_ACTIONS:
 		ret = rte_flow_conv_actions(dst, size, src, 0, error);
@@ -1178,6 +1209,9 @@ rte_flow_conv(enum rte_flow_conv_op op,
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
index eacfd7c5f7..5f8d4b00f0 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4558,6 +4558,19 @@ enum rte_flow_conv_op {
 	 *   @code const char ** @endcode
 	 */
 	RTE_FLOW_CONV_OP_ACTION_NAME_PTR,
+
+	/**
+	 * Convert an entire pattern.
+	 *
+	 * Duplicates all pattern items at once, applying @p mask to @p spec
+	 * and @p last.
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
2.34.1

