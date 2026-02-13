Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0A8EDF15B
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 13:32:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 277A6402C0;
	Fri, 13 Feb 2026 14:32:23 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50]) by mails.dpdk.org (Postfix) with ESMTP id 71E99402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 14:32:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBKmGFIk6OKrfuc6pRqVb/5rhdK7T8WSuQuTRPrddtMFCpxoMh8oahfFdTC/Y3PNDrqoeHhGVUK8YUgphM4Fc9oyW0mIw/IRWSkqUILpMgshbElGQzNZFH9fge1HCOucOJ7AwUqBlFGfyRaG3sEVPBO42UYHhmVqvhvqO+U1vM8YCTQY8tvcQVT8eW6zaUMvz4zZuJja6TvqHJvwMCqjgZjUINHkm9Jnrs6HtrBVWzwzoEo5RfuhiOGm/8mjR//rkJNoxxPDTK4nlwZ8FzAObMApeZX5oW9b32F3Siu7t6fA8aFm0T88Rw4LTAS8aPxIJ74iQahCOkMx/RQrRhOMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr1KSn9VljMM6kYx09r4tYWn8m4LRta/RysYWoWl3MU=;
 b=Q57eeGa2anxNt9YuvJIj2ywXEFUuutIfLTgXCLIoOHqRoiWTsmcfjfsRE6bUuKQMi58WF9EBRIlf8d/F5ZTKNJLSK1PwmrhLLg52m88BTVzJKzC24hNBVMMnEqRG+T4nkJOHv6gjETQlIT/w1nZlePZEdO8j4m9utwujea9t03Wz9DmTlYALyyXE99owQQnNauveK/uSizxkMpvJxRQLMOUte7bPevTEUFW5xAOsRx9RhmE4WuKYCqrRQq384Hu0kKVjYoeRUK6/m8XoefJ80soTgArJ6j4l7iFE+d2sHdNMw50YHXkPP+yiZVy+N+siXRsTfIMr2A98pdY7Pcc4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr1KSn9VljMM6kYx09r4tYWn8m4LRta/RysYWoWl3MU=;
 b=S3zdMFKRBPH4z35cLRBQqCm1ql6KXgtbKXdfVe6bhuOghJCiL/EamvzOfojXr2fubwG4oTnQTsMKgHEZxq8GPenhtoFWSekK1NS1O3BNtF3mnbfFIoKcIgMN8VmRpZU1m4sGQeojJf5XZT7c7gMqvt4kvArO7008WIP17a6fOuyQmmDag6gQ5tAMeNirAra81TPM7PYk2RYm6GG9x3xRwmMYXDl/HOAERfbvy3YFTr6dhaUCp0a2djP14+i6w9a5/zmujSSyMZ6uu8R1FyXHEGe5P7zcUgWt0UBWHRaJu69OytbgFdyLra+lkhuGk67t3PRggq0W3vJ3iXQqoMx+fA==
Received: from DS7PR03CA0084.namprd03.prod.outlook.com (2603:10b6:5:3bb::29)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 13:32:18 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::14) by DS7PR03CA0084.outlook.office365.com
 (2603:10b6:5:3bb::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.14 via Frontend Transport; Fri,
 13 Feb 2026 13:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 13:32:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 05:32:00 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 05:31:57 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <stephen@networkplumber.org>
Subject: [PATCH v2] lib/ethdev: support inline calculating masked item value
Date: Fri, 13 Feb 2026 15:31:43 +0200
Message-ID: <20260213133143.22120-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117075407.9632-1-bingz@nvidia.com>
References: <20251117075407.9632-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 77372a7d-8341-4fe8-3317-08de6b044e66
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UI7dgm2qu4WsqZfbBGj9jT99vvbMN+nQJVpI6ashWVy1UaZ0qYm8cZ3PGGSf?=
 =?us-ascii?Q?PmMq1D3J/vrRunGwqfB2nx53qnNvpSoRRfVGfIsHivSE1I7ZbofMkC1eqstm?=
 =?us-ascii?Q?1JnT/PrJsskZcTolijfHc6nf8AjpQw10INbhDYjb8WH0HxFHoACg/UAbm1EW?=
 =?us-ascii?Q?g04uAXnleDmYRojnD5BdN2Z/srkA8lJW1EsWxFpuqGl7VE6Ind+G0scu6Bmk?=
 =?us-ascii?Q?526TdeV4QBP40NtDcGXJBQ8/8yW2Zfw4+BG/K5g1YgWNTAzrY9j4N+E85hIn?=
 =?us-ascii?Q?5XzPZoTyPrMXOaIFWq7/9mcxcoGFKOuzF1p7gCRNLWxFCMrEUudwa/mF+iOk?=
 =?us-ascii?Q?1gZl+Rkqga2td2QA9nWxQUgQeucWQGyLT6uSphLciBdP9sammJQmCJlupX05?=
 =?us-ascii?Q?A9jJEXUqHEjDVCuNMM3jz6hCr6GaYG/vVBcKEtdI+7U7acOnP653ZME61g19?=
 =?us-ascii?Q?dqxEoB0Y3FEJBDkpWEScVdpIwA5K091elmfnY2S4PTnCnKZdxCAYNQT0O/U1?=
 =?us-ascii?Q?W0HCiWcu3OVeCP4R91r/Y8aFZiuzV6lrA33/y3aUwkfFK800MsS0TMTGAGdL?=
 =?us-ascii?Q?X+t5l8W1rxoT3CB+2pNbwyI8Wd8mXLIdyRrINz5gtGXjEXS9onRFi8kEekv8?=
 =?us-ascii?Q?eFLOFfEOkV7FyMTAjoPtAMKEIZG015J1hckmzAy7vyWogNIfzUyGmtp32WzE?=
 =?us-ascii?Q?bvcFtVCh8dq7DHcSAAtAxVK5jy1AS+HJ5oriqUyr7kH3XWVgGDB7YorWBmgA?=
 =?us-ascii?Q?DRVuzaYlWEZhoAMZIV5MhEIQVaRdeFXpfeesBgOJxqpzzh1EuK/PON0rLdxn?=
 =?us-ascii?Q?0EU7HZuipN1wfXmfVgDjfo/J8j9vwwZ6JltnVlUR0TXX07Nkr5J3h3M7PpRV?=
 =?us-ascii?Q?yvOid7nNDfX1yerhZRWqgdGdMw9ruXR5Gt3VH0iZhuDBJUoRHqqVwGGH8hah?=
 =?us-ascii?Q?27SaFNhdwP4ryi3imyh5Sc89JKbYRBtTVWN2f4+lqWmS2GFzbPqfYClnxCs3?=
 =?us-ascii?Q?FFEFrAvzpUQbvpSesTDbtEyi5mfD2nyB5tHpDqnA8+ZQNuB8M7wOytRfoZM4?=
 =?us-ascii?Q?X0VNvkW1TD/4rT4osbi1zJPiYC+15zlC3ynHLjqSZVy9jbQAEZAIO/opfPSE?=
 =?us-ascii?Q?VQ/Agdd+6B4ohoam4R5ptwae3mxR6yQgjupJ6A8T7I9eZo15Gs0X1bYqQt57?=
 =?us-ascii?Q?t+ch/DAmtQQBTpEtb7GiS+cObThw7pa60qnin6T2WFB/Diqaaf4WlXPPHtdH?=
 =?us-ascii?Q?PMXLS1qOf9WIdvMoimU28+aDbumaRfoJ5QG3Ko6Mgcix8sVHLLpVutuOCbH7?=
 =?us-ascii?Q?eG0yVsSFRhkPXzvq/Qs9gAL+PxfcfE0lFF93cjkKXhbvj4JXQ7HBbMdl05fg?=
 =?us-ascii?Q?MRD+ITXNhEPmi31+6Q/nQKCGS7m/KxLbVrPwvcaYZ4POIqAFuQWZtepxQlOl?=
 =?us-ascii?Q?ajJ0MpQM8jWCupZAfDu5V9bye4iUhJWWDTQgmnTNnnioYZKRbUjyBJnxOX/L?=
 =?us-ascii?Q?d28wzRK5eY+Dr5b3y4bdia11b/6H716VU1A7A3yDFDEDgON+VtKw/A40W8fW?=
 =?us-ascii?Q?I2dKkLtfD9Gra8K+VCWpwex8nmrb8ZKJAqNNFzaLOAq+sSA1Rs7YbCQ9HDdc?=
 =?us-ascii?Q?4U22snfkm1C3Me0RnZw8vM8KEYBBh2Pc6/8eWejlM97jvkrvNFot7FJ1Gj1f?=
 =?us-ascii?Q?vEjeLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fYV3+3Vtkgn6ZLLLs6UCmT8rNWOZAGC3uaapDg2+YwEZDBeyqWLl1UDKNu8GjmaP50rnw9u0EXqVMxv5v07G+oa5UVAagtmywQy/+xcLS9+1NMXryF5U3EJWRhqa8lN2O/Jk8zyFDDgfV62m6iF1ItunXsVXfMRG/HJxcIkrIi1qfkLzJX2dsk0dqnbsTgUt8fycV6v2BPeRfTMc2TgzlTU3SD/z39aJ9kl44YnjRc0ZRPfk2rxnBYBBp7sVGUpxhlGA6C8iBAtVaFczEOqJJtn2X9XFH5fqNrn8p222aEfgc7NoQ3gSpxC1N5NtpbLGttCu0FF4PCk2cbMiey4hTVILvWsae57n2psIyNjR0uBEM0fhn6aTV7rOeOk8HfHhDn3ItP29df2y3kNuQQiAsVeqYG4P1JIrTaOIFKiJU/Q1EuBRKHhaZCQMJNN6w26x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 13:32:17.0946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77372a7d-8341-4fe8-3317-08de6b044e66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
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
index ba3bcc89a3..f56b328537 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4558,6 +4558,18 @@ enum rte_flow_conv_op {
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

