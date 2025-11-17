Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652BCEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 07:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17143427A7;
	Mon, 17 Nov 2025 08:54:46 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
 by mails.dpdk.org (Postfix) with ESMTP id CFBA1427A6
 for <dev@dpdk.org>; Mon, 17 Nov 2025 08:54:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0JrkE6q60ZUmTYw1GIDagfhU/wBFuEVSzbC/kw+44n2vpoUw/G2krDrMhyDBEzql7J1Q9cUChb3Kc7AVKup1NrnEHLhwF51mYK5u5QpdKJj38TF8jPBn36bpx6pwm/K55y9e+qIfV7sZIwEe/Jnbezje3+NLw2CRL7uj0cfpKxB7tiD+LcXJpFKub/6Ogvb5io3SiOZx8S2xMREjpt5Nr886tlHMygC4m0cBtXL5Gy7QP5i8uWMkO5kCmi51Xhp7vDNs5OjCBcw8KqlQJuK38Ho945R6bWtwjmZm8NVTK/7b8iix0QVVtWwhY9olOCImCKxZ+kHTFEaTYfnMp00Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIEz5G8XDkKr8BQN/M4huTHpMSPK0BfqsI0nNU4GhfM=;
 b=f1Qz4pbev1bYwrdKOa9ZgvQo9TiJ6/Mw87Lrz0fPLur0DiP+6yuezWUrs6Xgo1WIwd5iO4UhBMa5lFaA4XTPCUtvRMY6LRCiHDQ9QtIXTBi6xZTMkt99ZZ1YMRygQpTc+5bXIRBNUOWOMwPFyPFP5mGs9rYq0JbSmr7q3n/sVzpLtObTYmGH5AweudTecb82rpXsdbRKp9YKzfe8cfhO+FsNDUOijon1qOG4UT+8VQCFWr2DF/IRrRUkzhgB2RK59qwcQtZtwCV7xZAVrye2ZpA82pGwQD962odOnvt/BOoIMHFuNBUiTd+bd0knpGCgHAh1ZB/IGUEXj4tck/qJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIEz5G8XDkKr8BQN/M4huTHpMSPK0BfqsI0nNU4GhfM=;
 b=Dy8LP80T1hUrEJjBaDD3iYAM5ByxcaljVfO/Y3O27v4acqAPiwGxcoXCf+vFF99E2YEaMSbWmOyQYIdHJwuxc2G1I3loY0ZxlfpCIXKyBeY7Iv4al7KqNyhnki4vTDojuL8anZ3puED41artgKriRqsAnS3wHno2XTfwTiqHvZpkn2nHUEbiuawomgO3onpvMvHBaxx306hjtU8tbdw/Z5cY0i1DtiZ8tGHg0vUiUBs7LEr1AffwMTHDAnOGid3h3RWogkMRqohYy4bevRC/qbzIVQxOHeLR5PwJydfBebTwBpBT9aAdWG+LKdF4WFsU1lkEqMyZcyCVk+MNsij/Pg==
Received: from BN9PR03CA0847.namprd03.prod.outlook.com (2603:10b6:408:13d::12)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 07:54:40 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::75) by BN9PR03CA0847.outlook.office365.com
 (2603:10b6:408:13d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.19 via Frontend Transport; Mon,
 17 Nov 2025 07:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 07:54:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:54:24 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:54:21 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH 1/2] lib/ethdev: support inline calculating masked item value
Date: Mon, 17 Nov 2025 09:54:07 +0200
Message-ID: <20251117075407.9632-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: cddabc70-2af2-4bca-7e0e-08de25ae8fb4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OlGmuM6hqZDbuhKa1YikH22GktkWPFEJxQFLDFTBnG/LexD4afTpTOGLeZez?=
 =?us-ascii?Q?QoUWvUXXrsj8u3muidvKcK/JBJ8UmXTQ6p64DhpMa5+tXPs7DPoBJ5+A5Faw?=
 =?us-ascii?Q?UCnhVz+e9UrVIuEGXOfwXeNMiEOzjfdxeUlmUN1upPk7fQYtgbl102J+gz6c?=
 =?us-ascii?Q?bkVddEcil0n3LQCjKbhvbJvx1zd/Ji3fwMaq5RM9la2LTd/7M1nySebIyDuA?=
 =?us-ascii?Q?1nPJdASd3BKunQ0I7LdGqHdyWouDXQMu+g7Oczm7ogGJWS2MG7OmR9du+AJV?=
 =?us-ascii?Q?yGuidI7sp//Y0j9o48IJYrs98D4e7trSyLnTOHSS3jeMRE01BVuZ4rD6nmY5?=
 =?us-ascii?Q?ZKQCksoagWxHFvWZx7L1X45bNnZ5L/wVqTidS4sLtd1vLUkBcxBQlT2crztB?=
 =?us-ascii?Q?jeCyHK8r0sbCt88/vkF0SHhjNgakr26Bt4LULHWnXf0is5mqCd1Q+f5zF9vr?=
 =?us-ascii?Q?Gg0UUwSP9JR0/OP6bvGiYQ2YrK1vTCA4+USICSJBJxUv1Up/fvI9e74ZloyN?=
 =?us-ascii?Q?SR8Sqmq7iRSTrWeVliwfzI9eBHW8tL25r9CTMriu1mIUrn7w/1X7XY3vovso?=
 =?us-ascii?Q?JHeqrIxgn67wgj8P+Xjv8wNckBd6dFqYdaROdLDHDSt1wuYg2DpcO7pDx5p9?=
 =?us-ascii?Q?UhJq2atsFklLPEZf5b5JWcmVLqymThEEfIWPViYvbutZxcq743ovQtFfUEkx?=
 =?us-ascii?Q?DvzNaUzn+ECFfVBlGqcaRIayMULemQlANp55xxRO9qV1gAL7DV50Oy5l/Exf?=
 =?us-ascii?Q?cC3STDzgLFaYqDa0F5QNnjT/g2MWlD2eLOtQXvXScT0qMXnL6niZ6CQ2etob?=
 =?us-ascii?Q?luG5zx35HmEztDinZA8jgkeMQ+jZDFGRTKZhPN24aszybYBFJszYG4gb1Win?=
 =?us-ascii?Q?erOnDGC0w5ty5WZO/560RUmuyUaQ8pppBeCoF4oguTyt0DzWJcpTuoPWZ7sL?=
 =?us-ascii?Q?okhcYe6oiBtq23cW5sNeaUoRIvmVTUAdpqFOqyY6TcAqQem8I7R07KXRHf76?=
 =?us-ascii?Q?g+ysPIU7C3lLFIb0vMt5VzFf0lRYao2qR62HVBm7mFxQeDbNR5aDad0cIUOu?=
 =?us-ascii?Q?0c9eDXGv8iW7XxtXuGbuvPh0jYYEI1+rIuC7RRdLAAlYHhvhK3+ILL5A9H7n?=
 =?us-ascii?Q?LOsTt04ion7/Ts9jKlyZSlPWig0BCj7F8GHoNw3VcFdR9L1mKB70doS/S0j4?=
 =?us-ascii?Q?EI+MJ/TFQfaF4eDL5VgUUEkVtXxMVQ5s3jBCTTKpElF68ONQAc2QaJY4RrIO?=
 =?us-ascii?Q?iBQgZQ0KNF2PWvbsiRxhS+X6Odju2RHdxxOro05oHTPJsBbsKyrIyvEDErQ8?=
 =?us-ascii?Q?N+thIdOXcksipgXD5X3QLjhwRIvd6/f9ekwlqxFBapPPle813gu+jyfauCOz?=
 =?us-ascii?Q?KlxIor5thXNnrgTyjAQqr+mT3L/PEFQ/qEOoaHjt5QLX6yGTm1ztMcVFRn0G?=
 =?us-ascii?Q?ceKrMc8qYA/LA5XaS618vW7CAsgDoBWBZ81Ss+o5exRuNkjbQ2yhExDXoPw1?=
 =?us-ascii?Q?9UrUTbbt989RnZ55ed/a4ydghCN7ZDQf4QhWNkc+ExL8V+ug2yxO8tp7J8Cm?=
 =?us-ascii?Q?kl13lCJMmc1A2oXyXZs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:54:39.6718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cddabc70-2af2-4bca-7e0e-08de25ae8fb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798
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
 lib/ethdev/rte_flow.c | 29 +++++++++++++++++++++++------
 lib/ethdev/rte_flow.h | 12 ++++++++++++
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index fe8f43caff..b94f0e304d 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -831,6 +831,8 @@ rte_flow_conv_action_conf(void *buf, const size_t size,
  *   RTE_FLOW_ITEM_TYPE_END is encountered.
  * @param[out] error
  *   Perform verbose error reporting if not NULL.
+ * @param[in] with_mask
+ *   If true, @p src mask will be applied to spec and last.
  *
  * @return
  *   A positive value representing the number of bytes needed to store
@@ -843,12 +845,14 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
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
+	uint8_t *c_spec = NULL, *c_last = NULL;
 
 	for (i = 0, off = 0; !num || i != num; ++i, ++src, ++dst) {
 		/**
@@ -878,9 +882,14 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 				((void *)(data + off),
 				 size > off ? size - off : 0, src,
 				 RTE_FLOW_CONV_ITEM_SPEC);
-			if (size && size >= off + ret)
+			if (size && size >= off + ret) {
 				dst->spec = (void *)(data + off);
+				c_spec = (uint8_t *)(data + off);
+			}
 			off += ret;
+			if (with_mask && c_spec && src->mask)
+				for (j = 0; j < ret; j++)
+					*(c_spec + j) &= *((const uint8_t *)src->mask + j);
 
 		}
 		if (src->last) {
@@ -889,9 +898,14 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 				((void *)(data + off),
 				 size > off ? size - off : 0, src,
 				 RTE_FLOW_CONV_ITEM_LAST);
-			if (size && size >= off + ret)
+			if (size && size >= off + ret) {
 				dst->last = (void *)(data + off);
+				c_last = (uint8_t *)(data + off);
+			}
 			off += ret;
+			if (with_mask && c_last && src->mask)
+				for (j = 0; j < ret; j++)
+					*(c_last + j) &= *((const uint8_t *)src->mask + j);
 		}
 		if (src->mask) {
 			off = RTE_ALIGN_CEIL(off, sizeof(double));
@@ -1038,7 +1052,7 @@ rte_flow_conv_rule(struct rte_flow_conv_rule *dst,
 		off = RTE_ALIGN_CEIL(off, sizeof(double));
 		ret = rte_flow_conv_pattern((void *)((uintptr_t)dst + off),
 					    size > off ? size - off : 0,
-					    src->pattern_ro, 0, error);
+					    src->pattern_ro, 0, false, error);
 		if (ret < 0)
 			return ret;
 		if (size && size >= off + (size_t)ret)
@@ -1139,7 +1153,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 		ret = sizeof(*attr);
 		break;
 	case RTE_FLOW_CONV_OP_ITEM:
-		ret = rte_flow_conv_pattern(dst, size, src, 1, error);
+		ret = rte_flow_conv_pattern(dst, size, src, 1, false, error);
 		break;
 	case RTE_FLOW_CONV_OP_ITEM_MASK:
 		item = src;
@@ -1154,7 +1168,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 		ret = rte_flow_conv_actions(dst, size, src, 1, error);
 		break;
 	case RTE_FLOW_CONV_OP_PATTERN:
-		ret = rte_flow_conv_pattern(dst, size, src, 0, error);
+		ret = rte_flow_conv_pattern(dst, size, src, 0, false, error);
 		break;
 	case RTE_FLOW_CONV_OP_ACTIONS:
 		ret = rte_flow_conv_actions(dst, size, src, 0, error);
@@ -1174,6 +1188,9 @@ rte_flow_conv(enum rte_flow_conv_op op,
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
index 3d2ccdeb92..85acb26752 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4559,6 +4559,18 @@ enum rte_flow_conv_op {
 	 *   @code const char ** @endcode
 	 */
 	RTE_FLOW_CONV_OP_ACTION_NAME_PTR,
+
+	/**
+	 * Convert an entire pattern.
+	 *
+	 Duplicates all pattern items at once, applying @p mask to @p spec and @p spec.
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

