Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D5FC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 07:28:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C43140EAB;
	Wed, 21 May 2025 09:28:16 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by mails.dpdk.org (Postfix) with ESMTP id A67E140EA5
 for <dev@dpdk.org>; Wed, 21 May 2025 09:28:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARnxA9895BB6HSozA6+4oMtG/TtstzJ/nkEDm8eX9Y+ZYrbn2gzEDJ7sIKgqywdTBn+ZuvTP5zxmbYlJefBoF33ZgK9MyEQ7QaktX4WKmJ6lVsyrmx8BvGOitRthHXduNhOx8PGPPA5u3R1kYEkP+Lv/1OAFxvwgviG84JYdkSMAWfvv/dhjh/C8vSay4t4TjvSsfYeHwPB9sunWAV5YAaSYSWaTCsoe3Qtw+3Jn1yS13KdDt4p/mlB/DAD5GtHMKnE8btMYcsdyFQG6XVBdoyolU9vaVg1lTJ5ajdVPQVCw6KyJqrltXHRAL0r4Szpwv+WuuVSvYRJNXPZyTG8FOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wfQUPtKt+pnUsjcGOpK25g8MJmVBlHtsGrSdTg1NPU=;
 b=YxO3Ar/YMM2FsPt8VsoQeGM4GvEBj2fANVBpINWqOQmB4cmDjaoaOlnstBQjrHCprhT3qW7k0MMQE+02rrMOkQ77AaS6ycJo8uueJLbi5Uu8gPm2vLoqrpD5hxy8o3r71p3AV2YDT5qQ2hADMGC942Qtw/ACRqOFkIIkeV+CHitDJYLH3up6FFmyMgXOJ6XRaTm1uEjlGoUurBqqcJZKUmrlQaHTVEJnPbFba57xCl0vWcmJBZ018enAhVmGuNhWPHkx4G23qrtZqlONrPobCBPvubriAOq+ahhP33L6oFJeJxZ9tCh2QbaLB7F41BWyLVFAKXS2pm5gVoV+F5mdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wfQUPtKt+pnUsjcGOpK25g8MJmVBlHtsGrSdTg1NPU=;
 b=LEz3hjatqyW4BBcbRJzkuhIIxRHQNsjhPeEEcgEgK8xn9G4M38YscBsQSJRo6SZovUJdECws1wJBKvG4Vorz1JT2Nd7mHJbumeyWd6grh6a7k8ecQgH+eFRq2DhqcLE2YS75sscrg4mmARrbxKO9wf+yink+SqSZoYvhWmWZt6TPtDT7GOVbCkLoLmcBABbkv3jenn5kMb6izCWtMLCzVXfvVwmpAMaLPHZdcL6XjnrjP5Sky4pEi4fjjHGBpltrYHXaU2S6A6Z6JQzQy/RdvRkl15zHjw+/s5P1x2OCn29Kse2BXgRgrZ5p06dXTdtXW6caRmJnnpDNC0bVNv0AGQ==
Received: from CH0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:76::11)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 07:28:04 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::38) by CH0PR04CA0006.outlook.office365.com
 (2603:10b6:610:76::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Wed,
 21 May 2025 07:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 07:28:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 00:27:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 21 May 2025 00:27:50 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 21 May 2025 00:27:48 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, Shani Peretz <shperetz@nvidia.com>, Ori Kam
 <orika@nvidia.com>
Subject: [PATCH] examples/flow_filtering: add re-route to kernel snippet
Date: Wed, 21 May 2025 10:27:36 +0300
Message-ID: <20250521072736.141817-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ce76aa-06e7-47fe-6345-08dd9839065f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PoJaPwk7UhGto9j98zIU2h6tjaDcJ3+8BSkk40MqGJJ7VbwgH6vpaV5VearH?=
 =?us-ascii?Q?v6G0u40+Y/Sf13xqQy9DZMtvLiFPFrRzi+ic7jKkg5BdRckHHDNkpDsq6ane?=
 =?us-ascii?Q?7yD5ABUmLclV/pjmFpx1QQDB5jkk43gnkJHOk0mQ95LvBRfKSDtAqPvtRZcZ?=
 =?us-ascii?Q?5x1JfiOEt+OHou5qmRZqFPFGl1eso7L5QndGnQ6Gw404WLiTNlwSwuzKGQ3f?=
 =?us-ascii?Q?PFE00APAMNoOjS4Ncy9143kh9froYEzohoLFgrKA/Yt83p9WHVKzktgChLeU?=
 =?us-ascii?Q?GtvC0MZDBJRfIKQlqI9r7DhRDfFpXDTggazasr4VDXkLXhsL/ea3zu2UEi0I?=
 =?us-ascii?Q?OqRjSGzgt91bO1EuAbuZeksPTxDPktkGNM8STYZ5JMbY8V1xVf9dUR8l9nTh?=
 =?us-ascii?Q?qaaE5I+ZkGF7vqWbKQZzRv3Cbv/wT/JdXG4/NZesoBcJ8JV/OZRugpllIRZr?=
 =?us-ascii?Q?Mws/Q7KVKh9JTEIMcUq08w4+69PHk6m9WLslOeMtilhGzLztrfCalIOFdRkX?=
 =?us-ascii?Q?aQXoviEfgbcwKdK7evH3XV2RjGPZ8RsDQmMA63yhKaPuN0dQhvcNRKUsvNqN?=
 =?us-ascii?Q?Ohlky7ASPSWC+xzGVI1R0HeVz6AxoIok9NyVbpuJJGAKim61pIXtvRGYyunP?=
 =?us-ascii?Q?F0oQsZzciKo8MHpliWnEmbytl+4LZbQVIBhVUqsBVOOjihHwcbn+fTs/hJI5?=
 =?us-ascii?Q?Fl8SUURzQRHprGFVJ/AIdw8ToHQOdRqGB4zhK83f44wrQGsg1/M8ZVk9QXBN?=
 =?us-ascii?Q?TRs5aeacT+9zHxo8ohZtnqv/Re7zuFDf8c5Lpq52MHEk3tsJlICVXd4VK7Sr?=
 =?us-ascii?Q?tI4kjeOWwTAtpKMZejyVthqNocZ9AvhI583dxhIelmhl+T7DuMdnu5H/VNMI?=
 =?us-ascii?Q?zxP3jIC2XqxGWgT+BU9M6fRqNjvRRkDe+cjY9YyCt9v/SnQjUUkMs6EciMxf?=
 =?us-ascii?Q?yK96arrdybGiyOmu9wuByl7mjox+F/hNf3gfzPnJrbz6fbwrbo3wpsYeNJwv?=
 =?us-ascii?Q?pDiTXI1I57zmvCldLehDLMj7iHfoQq+5m1xy7wuXuMWCWdUNNPiNLuSS0x1d?=
 =?us-ascii?Q?r1CIwe4F0/cQO4+eOMMMRvU+4+QQGZSOLbNp6LO8I9mkaayXfSc1jtmiEhub?=
 =?us-ascii?Q?cDf4aCO3JDkd0wg1fp5dlLTwn+H6LXwYphMWKc5V14V6BHv3ViROd/m8b78f?=
 =?us-ascii?Q?No3eFGLDjj8F3eufz+czWSk5M1mgQOqNO8j8YH3gmmK4RbLAb3ni3J26ZpI3?=
 =?us-ascii?Q?MCYeSPuom64sm4oyHjSOohUaHk9DlGK16mX1fQLDARYpnk6g/pN/lDH8ebWJ?=
 =?us-ascii?Q?PGz61WWZ3DG3W6hqk3VnDw1NjZ61v0OArMYuozCFVUC3SVYpjVMyofExsEYx?=
 =?us-ascii?Q?xXvtPJ3TUvDRwYb0AO4gRi0F4TOS47yqE7xsxdWFPewHLoUgoQcbJXyncXkL?=
 =?us-ascii?Q?FUz4HC0qJutH5N22eifmAn8XhKGK8Kiggqvm3Q5fkiJjplT0SEhSsf1GczCd?=
 =?us-ascii?Q?Kp+ORVO/PSKTC3D/y7LLYpky2JlAmJmEcCjP?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 07:28:04.2678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ce76aa-06e7-47fe-6345-08dd9839065f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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

The snippet enables direct packet re-routing to kernel by using
the new RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL action.

Added support for snippet-specific configurations:
  * port configuration: set promiscuous mode / flow isolation mode
  * Flow configuration: Setup beyond basic ingress flows

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 doc/guides/sample_app_ug/flow_filtering.rst   |  19 +++-
 examples/flow_filtering/common.h              |  12 ++-
 examples/flow_filtering/flow_skeleton.c       |  28 ++---
 examples/flow_filtering/main.c                |  31 ++++--
 examples/flow_filtering/meson.build           |   1 +
 .../snippets/snippet_match_gre.c              |  16 +++
 .../snippets/snippet_match_gre.h              |  17 ++-
 .../snippets/snippet_match_ipv4.c             |  24 +++--
 .../snippets/snippet_match_ipv4.h             |  12 ++-
 .../snippets/snippet_match_mpls.c             |   7 ++
 .../snippets/snippet_match_mpls.h             |  14 ++-
 .../snippets/snippet_re_route_to_kernel.c     | 100 ++++++++++++++++++
 .../snippets/snippet_re_route_to_kernel.h     |  34 ++++++
 13 files changed, 264 insertions(+), 51 deletions(-)
 create mode 100644 examples/flow_filtering/snippets/snippet_re_route_to_kernel.c
 create mode 100644 examples/flow_filtering/snippets/snippet_re_route_to_kernel.h

diff --git a/doc/guides/sample_app_ug/flow_filtering.rst b/doc/guides/sample_app_ug/flow_filtering.rst
index 8b07ab552c..e006ff67f2 100644
--- a/doc/guides/sample_app_ug/flow_filtering.rst
+++ b/doc/guides/sample_app_ug/flow_filtering.rst
@@ -78,6 +78,15 @@ Allocate a memory pool for managing mbufs used within the application:
    :end-before: >8 End of allocating a mempool to hold the mbufs.
    :dedent: 1
 
+Some snippets may require different configuration of the port and flow attributes,
+those configuration are defined in the snippet file.
+
+.. literalinclude:: ../../../examples/flow_filtering/main.c
+   :language: c
+   :start-after: Add snippet-specific configuration. 8<
+   :end-before: >8 End of snippet-specific configuration.
+   :dedent: 1
+
 Initialize the ports using the user-defined ``init_port()`` function,
 configuring Ethernet ports with default settings, including both Rx and Tx queues for a single port:
 
@@ -183,5 +192,11 @@ For example, within ``snippet_match_ipv4_flow.c``, developers can find the funct
 - ``snippet_ipv4_flow_create_patterns()`` for setting packet matching patterns,
 - ``snippet_ipv4_flow_create_table()`` for creating the patterns and actions template table.
 
-These functions can simply be called in the appropriate place
-in ``flow_skeleton.c`` to change the default created flow.
+To use a different snippet, simply update the include statement in "flow_skeleton.c" to point to
+the desired snippet file, this will change the default created flow.
+
+some snippets may require different configuration, those configuration are defined in the snippet file:
+
+- ``snippet_init_ipv4`` for configuration of the port and flow attributes.
+
+In order to use them the developer should include the snippet header file in main.c
diff --git a/examples/flow_filtering/common.h b/examples/flow_filtering/common.h
index 00545e9eea..3a73520723 100644
--- a/examples/flow_filtering/common.h
+++ b/examples/flow_filtering/common.h
@@ -5,10 +5,16 @@
 #ifndef COMMON_H
 #define COMMON_H
 
-#define QUEUE_ID 1
+extern bool enable_promiscuous_mode;
+extern bool enable_flow_isolation;
+extern struct rte_flow_attr flow_attr;
 
-extern struct rte_flow_attr attr;
-extern struct rte_flow_op_attr ops_attr;
+static inline void init_default_snippet(void)
+{
+	enable_promiscuous_mode = true;
+	enable_flow_isolation = false;
+	flow_attr.ingress = 1;
+}
 
 /**
  * Skeleton for creation of a flow rule using template and non template API.
diff --git a/examples/flow_filtering/flow_skeleton.c b/examples/flow_filtering/flow_skeleton.c
index 54f0d4599f..471302d8b3 100644
--- a/examples/flow_filtering/flow_skeleton.c
+++ b/examples/flow_filtering/flow_skeleton.c
@@ -10,12 +10,11 @@
 #include "common.h"
 #include "snippets/snippet_match_ipv4.h"
 
-
-struct rte_flow_attr attr = { .ingress = 1 };
+struct rte_flow_attr flow_attr;
 struct rte_flow_op_attr ops_attr = { .postpone = 0 };
 
 static struct rte_flow *
-create_flow_non_template(uint16_t port_id, struct rte_flow_attr *attr,
+create_flow_non_template(uint16_t port_id, struct rte_flow_attr *flow_attr,
 						struct rte_flow_item *patterns,
 						struct rte_flow_action *actions,
 						struct rte_flow_error *error)
@@ -23,8 +22,8 @@ create_flow_non_template(uint16_t port_id, struct rte_flow_attr *attr,
 	struct rte_flow *flow = NULL;
 
 	/* Validate the rule and create it. */
-	if (rte_flow_validate(port_id, attr, patterns, actions, error) == 0)
-		flow = rte_flow_create(port_id, attr, patterns, actions, error);
+	if (rte_flow_validate(port_id, flow_attr, patterns, actions, error) == 0)
+		flow = rte_flow_create(port_id, flow_attr, patterns, actions, error);
 	return flow;
 }
 
@@ -34,10 +33,7 @@ create_flow_template(uint16_t port_id, struct rte_flow_op_attr *ops_attr,
 					struct rte_flow_action *actions,
 					struct rte_flow_error *error)
 {
-	/* Replace this function call with
-	 * snippet_*_create_table() function from the snippets directory.
-	 */
-	struct rte_flow_template_table *table = snippet_ipv4_flow_create_table(port_id, error);
+	struct rte_flow_template_table *table = snippet_skeleton_flow_create_table(port_id, error);
 	if (table == NULL) {
 		printf("Failed to create table: %s (%s)\n",
 		error->message, rte_strerror(rte_errno));
@@ -45,7 +41,7 @@ create_flow_template(uint16_t port_id, struct rte_flow_op_attr *ops_attr,
 	}
 
 	return rte_flow_async_create(port_id,
-		QUEUE_ID, /* Flow queue used to insert the rule. */
+		1, /* Flow queue used to insert the rule. */
 		ops_attr,
 		table,
 		patterns,
@@ -63,15 +59,9 @@ generate_flow_skeleton(uint16_t port_id, struct rte_flow_error *error, int use_t
 	struct rte_flow_action actions[MAX_ACTION_NUM] = {0};
 	struct rte_flow_item patterns[MAX_PATTERN_NUM] = {0};
 
-	/* Replace this function call with
-	 * snippet_*_create_actions() function from the snippets directory
-	 */
-	snippet_ipv4_flow_create_actions(actions);
+	snippet_skeleton_flow_create_actions(actions);
 
-	/* Replace this function call with
-	 * snippet_*_create_patterns() function from the snippets directory
-	 */
-	snippet_ipv4_flow_create_patterns(patterns);
+	snippet_skeleton_flow_create_patterns(patterns);
 	/* >8 End of setting the common action and pattern structures. */
 
 	/* Create a flow rule using template API 8< */
@@ -80,6 +70,6 @@ generate_flow_skeleton(uint16_t port_id, struct rte_flow_error *error, int use_t
 	/* >8 End of creating a flow rule using template API. */
 
 	/* Validate and create the rule 8< */
-	return create_flow_non_template(port_id, &attr, patterns, actions, error);
+	return create_flow_non_template(port_id, &flow_attr, patterns, actions, error);
 	/* >8 End of validating and creating the rule. */
 }
diff --git a/examples/flow_filtering/main.c b/examples/flow_filtering/main.c
index c0bc1938ce..5f2356f5bf 100644
--- a/examples/flow_filtering/main.c
+++ b/examples/flow_filtering/main.c
@@ -30,6 +30,10 @@
 #include <rte_argparse.h>
 
 #include "common.h"
+#include "snippets/snippet_match_ipv4.h"
+
+bool enable_promiscuous_mode = true; /* default configuration of promiscuous mode */
+bool enable_flow_isolation; /* some snippet may need isolation mode instead of promiscuous mode */
 
 /* Template API enabled by default. */
 static int use_template_api = 1;
@@ -212,12 +216,23 @@ init_port(void)
 		}
 	}
 
-	/* Setting the RX port to promiscuous mode. */
-	ret = rte_eth_promiscuous_enable(port_id);
-	if (ret != 0)
-		rte_exit(EXIT_FAILURE,
-			":: promiscuous mode enable failed: err=%s, port=%u\n",
-			rte_strerror(-ret), port_id);
+	if (enable_promiscuous_mode) {
+		/* Setting the RX port to promiscuous mode. */
+		ret = rte_eth_promiscuous_enable(port_id);
+		printf(":: promiscuous mode enabled\n");
+		if (ret != 0)
+			rte_exit(EXIT_FAILURE,
+				":: promiscuous mode enable failed: err=%s, port=%u\n",
+				rte_strerror(-ret), port_id);
+	} else if (enable_flow_isolation) {
+		/* Setting the RX port to isolate mode. */
+		ret = rte_flow_isolate(port_id, 1, NULL);
+		printf(":: isolate mode enabled\n");
+		if (ret != 0)
+			rte_exit(EXIT_FAILURE,
+				":: isolate mode enable failed: err=%s, port=%u\n",
+				rte_strerror(-ret), port_id);
+	}
 
 	ret = rte_eth_dev_start(port_id);
 	if (ret < 0) {
@@ -328,6 +343,10 @@ main(int argc, char **argv)
 	if (mbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot init mbuf pool\n");
 
+	/* Add snippet-specific configuration. 8< */
+	snippet_init();
+	/* >8 End of snippet-specific configuration. */
+
 	/* Initializes all the ports using the user defined init_port(). 8< */
 	init_port();
 	/* >8 End of Initializing the ports using user defined init_port(). */
diff --git a/examples/flow_filtering/meson.build b/examples/flow_filtering/meson.build
index 60a6b14638..6413dbc947 100644
--- a/examples/flow_filtering/meson.build
+++ b/examples/flow_filtering/meson.build
@@ -15,6 +15,7 @@ sources = files(
         'snippets/snippet_match_ipv4.c',
         'snippets/snippet_match_gre.c',
         'snippets/snippet_match_mpls.c',
+        'snippets/snippet_re_route_to_kernel.c',
 )
 
 # The code snippets are not utilized.
diff --git a/examples/flow_filtering/snippets/snippet_match_gre.c b/examples/flow_filtering/snippets/snippet_match_gre.c
index 8d840ab98b..723d399dd6 100644
--- a/examples/flow_filtering/snippets/snippet_match_gre.c
+++ b/examples/flow_filtering/snippets/snippet_match_gre.c
@@ -5,8 +5,16 @@
 #include <stdlib.h>
 #include <rte_flow.h>
 
+#include "common.h"
+#include "rte_common.h"
 #include "snippet_match_gre.h"
 
+void
+snippet_init_gre(void)
+{
+	init_default_snippet();
+}
+
 static void
 snippet_match_gre_create_actions(struct rte_flow_action *action)
 {
@@ -52,3 +60,11 @@ snippet_match_gre_create_patterns(struct rte_flow_item *pattern)
 	pattern[3].mask = gre_opt_spec;
 	pattern[4].type = RTE_FLOW_ITEM_TYPE_END;
 }
+
+static struct rte_flow_template_table *
+snippet_gre_flow_create_table(
+	__rte_unused uint16_t port_id,
+	__rte_unused struct rte_flow_error *error)
+{
+	return NULL;
+}
diff --git a/examples/flow_filtering/snippets/snippet_match_gre.h b/examples/flow_filtering/snippets/snippet_match_gre.h
index 49c0339c97..25f9fd5dd8 100644
--- a/examples/flow_filtering/snippets/snippet_match_gre.h
+++ b/examples/flow_filtering/snippets/snippet_match_gre.h
@@ -11,15 +11,24 @@
  * c_bit/k_bit/s_bit in the GRE pattern.
  */
 
-#define MAX_PATTERN_NUM		5 /* Maximal number of patterns for this example. */
-#define MAX_ACTION_NUM		2 /* Maximal number of actions for this example. */
+#define MAX_PATTERN_NUM     5 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM      2 /* Maximal number of actions for this example. */
+
+static void
+snippet_init_gre(void);
+#define snippet_init snippet_init_gre
 
-/* Replace this function with the snippet_*_create_actions() function in flow_skeleton.c. */
 static void
 snippet_match_gre_create_actions(struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_gre_create_actions
 
-/* Replace this function with the snippet_*_create_patterns() function in flow_skeleton.c. */
 static void
 snippet_match_gre_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_gre_create_patterns
+
+static struct rte_flow_template_table *
+snippet_gre_flow_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_gre_flow_create_table
+
 
 #endif /* SNIPPET_MATCH_GRE_H */
diff --git a/examples/flow_filtering/snippets/snippet_match_ipv4.c b/examples/flow_filtering/snippets/snippet_match_ipv4.c
index d32f4ebfdc..4082dc660d 100644
--- a/examples/flow_filtering/snippets/snippet_match_ipv4.c
+++ b/examples/flow_filtering/snippets/snippet_match_ipv4.c
@@ -10,6 +10,12 @@
 #include "snippet_match_ipv4.h"
 #include "../common.h"
 
+void
+snippet_init_ipv4(void)
+{
+	init_default_snippet();
+}
+
 void
 snippet_ipv4_flow_create_actions(struct rte_flow_action *action)
 {
@@ -20,7 +26,7 @@ snippet_ipv4_flow_create_actions(struct rte_flow_action *action)
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
 	if (queue == NULL)
 		fprintf(stderr, "Failed to allocate memory for queue\n");
-	queue->index = QUEUE_ID; /* The selected target queue.*/
+	queue->index = 1; /* The selected target queue.*/
 	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
 	action[0].conf = queue;
 	action[1].type = RTE_FLOW_ACTION_TYPE_END;
@@ -54,10 +60,14 @@ snippet_ipv4_flow_create_patterns(struct rte_flow_item *patterns)
 	if (ip_mask == NULL)
 		fprintf(stderr, "Failed to allocate memory for ip_mask\n");
 
-	ip_spec->hdr.dst_addr = htonl(DEST_IP); /* The dest ip value to match the input packet. */
-	ip_mask->hdr.dst_addr = FULL_MASK; /* The mask to apply to the dest ip. */
-	ip_spec->hdr.src_addr = htonl(SRC_IP); /* The src ip value to match the input packet. */
-	ip_mask->hdr.src_addr = EMPTY_MASK; /* The mask to apply to the src ip. */
+	/* Match destination IP 192.168.1.1 with full mask */
+	ip_spec->hdr.dst_addr = htonl(((192<<24) + (168<<16) + (1<<8) + 1));
+	ip_mask->hdr.dst_addr = 0xffffffff;
+
+	/* Match any source IP by using empty mask */
+	ip_spec->hdr.src_addr = htonl(((0<<24) + (0<<16) + (0<<8) + 0));
+	ip_mask->hdr.src_addr = 0x0;
+
 	patterns[1].spec = ip_spec;
 	patterns[1].mask = ip_mask;
 
@@ -102,8 +112,8 @@ snippet_ipv4_flow_create_pattern_template(uint16_t port_id, struct rte_flow_erro
 
 	titems[0].type = RTE_FLOW_ITEM_TYPE_ETH;
 	titems[1].type = RTE_FLOW_ITEM_TYPE_IPV4;
-	ip_mask.hdr.src_addr = EMPTY_MASK;
-	ip_mask.hdr.dst_addr = FULL_MASK;
+	ip_mask.hdr.src_addr = 0x0;  /* empty mask */
+	ip_mask.hdr.dst_addr = 0xffffffff;  /* full mask */
 	titems[1].mask = &ip_mask;
 	titems[2].type = RTE_FLOW_ITEM_TYPE_END;
 
diff --git a/examples/flow_filtering/snippets/snippet_match_ipv4.h b/examples/flow_filtering/snippets/snippet_match_ipv4.h
index 597a1c954e..8d169589b0 100644
--- a/examples/flow_filtering/snippets/snippet_match_ipv4.h
+++ b/examples/flow_filtering/snippets/snippet_match_ipv4.h
@@ -9,22 +9,24 @@
  * sends packets with matching src and dest ip to selected queue.
  */
 
-#define SRC_IP ((0<<24) + (0<<16) + (0<<8) + 0) /* src ip = 0.0.0.0 */
-#define DEST_IP ((192<<24) + (168<<16) + (1<<8) + 1) /* dest ip = 192.168.1.1 */
-#define FULL_MASK 0xffffffff /* full mask */
-#define EMPTY_MASK 0x0 /* empty mask */
-
 #define MAX_PATTERN_NUM		3 /* Maximal number of patterns for this example. */
 #define MAX_ACTION_NUM		2 /* Maximal number of actions for this example. */
 
+void
+snippet_init_ipv4(void);
+#define snippet_init snippet_init_ipv4
+
 void
 snippet_ipv4_flow_create_actions(struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_ipv4_flow_create_actions
 
 void
 snippet_ipv4_flow_create_patterns(struct rte_flow_item *patterns);
+#define snippet_skeleton_flow_create_patterns snippet_ipv4_flow_create_patterns
 
 struct rte_flow_template_table *
 snippet_ipv4_flow_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_ipv4_flow_create_table
 
 
 #endif /* SNIPPET_MATCH_IPV4_H */
diff --git a/examples/flow_filtering/snippets/snippet_match_mpls.c b/examples/flow_filtering/snippets/snippet_match_mpls.c
index 8382ec7041..df499fcdb7 100644
--- a/examples/flow_filtering/snippets/snippet_match_mpls.c
+++ b/examples/flow_filtering/snippets/snippet_match_mpls.c
@@ -11,6 +11,13 @@
 #include "../common.h"
 #include "snippet_match_mpls.h"
 
+
+static void
+snippet_init_mpls(void)
+{
+	init_default_snippet();
+}
+
 static void
 snippet_mpls_create_actions(struct rte_flow_action *actions)
 {
diff --git a/examples/flow_filtering/snippets/snippet_match_mpls.h b/examples/flow_filtering/snippets/snippet_match_mpls.h
index 59d5ea6f5d..ed08b736eb 100644
--- a/examples/flow_filtering/snippets/snippet_match_mpls.h
+++ b/examples/flow_filtering/snippets/snippet_match_mpls.h
@@ -11,19 +11,23 @@
  * The maximum supported MPLS headers is 5.
  */
 
-#define MAX_PATTERN_NUM		6 /* Maximal number of patterns for this example. */
-#define MAX_ACTION_NUM		2 /* Maximal number of actions for this example. */
+#define MAX_PATTERN_NUM     6 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM      2 /* Maximal number of actions for this example. */
+
+static void
+snippet_init_mpls(void);
+#define snippet_init snippet_init_mpls
 
-/* Replace this function with the snippet_*_create_actions() function in flow_skeleton.c. */
 static void
 snippet_mpls_create_actions(struct rte_flow_action *actions);
+#define snippet_skeleton_flow_create_actions snippet_mpls_create_actions
 
-/* Replace this function with the snippet_*_create_patterns() function in flow_skeleton.c. */
 static void
 snippet_mpls_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_mpls_create_patterns
 
-/* Replace this function with the snippet_*_create_table() function in flow_skeleton.c. */
 static struct rte_flow_template_table *
 snippet_mpls_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_mpls_create_table
 
 #endif /* SNIPPET_MATCH_MPLS_H */
diff --git a/examples/flow_filtering/snippets/snippet_re_route_to_kernel.c b/examples/flow_filtering/snippets/snippet_re_route_to_kernel.c
new file mode 100644
index 0000000000..a7d44e0d42
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_re_route_to_kernel.c
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdbool.h>
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "common.h"
+#include "snippet_re_route_to_kernel.h"
+
+void
+snippet_init_re_route_to_kernel(void)
+{
+	enable_flow_isolation = true; /* enable flow isolation mode */
+	enable_promiscuous_mode = false; /* default disable promiscuous mode */
+	flow_attr.group = 1;
+	flow_attr.ingress = 1;
+}
+
+void
+snippet_re_route_to_kernel_create_actions(struct rte_flow_action *action)
+{
+	action[0].type = RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+void
+snippet_re_route_to_kernel_create_patterns(struct rte_flow_item *pattern)
+{
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	/* Fill-in any matching criteria */
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+static struct rte_flow_pattern_template *
+snippet_re_route_to_kernel_create_pattern_template(uint16_t port_id, struct rte_flow_error *error)
+{
+
+	const struct rte_flow_pattern_template_attr attrp = {
+		.ingress = 1
+	};
+
+	struct rte_flow_item pattern[] = {
+		[0] = {.type = RTE_FLOW_ITEM_TYPE_ETH},
+		[1] = {.type = RTE_FLOW_ITEM_TYPE_END},
+	};
+
+	return rte_flow_pattern_template_create(port_id, &attrp, pattern, error);
+}
+
+static struct rte_flow_actions_template *
+snippet_re_route_to_kernel_create_actions_template(uint16_t port_id, struct rte_flow_error *error)
+{
+	struct rte_flow_action actions[] = {
+		[0] = {.type = RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL},
+		[1] = {.type = RTE_FLOW_ACTION_TYPE_END},
+	};
+	struct rte_flow_action masks[] = {
+		[0] = {.type = RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL},
+		[1] = {.type = RTE_FLOW_ACTION_TYPE_END,},
+	};
+
+	const struct rte_flow_actions_template_attr at_attr = {
+		.ingress = 1,
+	};
+
+	return rte_flow_actions_template_create(port_id, &at_attr, actions, masks, error);
+}
+
+struct rte_flow_template_table *
+snippet_re_route_to_kernel_create_table(uint16_t port_id, struct rte_flow_error *error)
+{
+	struct rte_flow_pattern_template *pt;
+	struct rte_flow_actions_template *at;
+
+	/* Define the template table attributes. */
+	const struct rte_flow_template_table_attr table_attr = {
+		.flow_attr = {
+			.ingress = 1,
+			.group = 1,
+		},
+		.nb_flows = 10000,
+	};
+
+	pt = snippet_re_route_to_kernel_create_pattern_template(port_id, error);
+	if (pt == NULL) {
+		printf("Failed to create pattern template: %s (%s)\n",
+				error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	at = snippet_re_route_to_kernel_create_actions_template(port_id, error);
+	if (at == NULL) {
+		printf("Failed to create actions template: %s (%s)\n",
+				error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+	return rte_flow_template_table_create(port_id, &table_attr, &pt, 1, &at, 1, error);
+}
diff --git a/examples/flow_filtering/snippets/snippet_re_route_to_kernel.h b/examples/flow_filtering/snippets/snippet_re_route_to_kernel.h
new file mode 100644
index 0000000000..9845cc839d
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_re_route_to_kernel.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_REROUTE_TO_KERNEL_H
+#define SNIPPET_REROUTE_TO_KERNEL_H
+
+/* Packet Re-Routing to the Kernel
+ * This feature introduces a new rte_flow action (RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL)
+ * which allows application to re-route packets directly to the kernel without software involvement.
+ * The packets will be received by the kernel sharing the same device as the DPDK port
+ * on which this action is configured.
+ */
+
+#define MAX_PATTERN_NUM    2 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM     2 /* Maximal number of actions for this example. */
+
+static void
+snippet_init_re_route_to_kernel(void);
+#define snippet_init snippet_init_re_route_to_kernel
+
+static void
+snippet_re_route_to_kernel_create_actions(struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_re_route_to_kernel_create_actions
+
+static void
+snippet_re_route_to_kernel_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_re_route_to_kernel_create_patterns
+
+static struct rte_flow_template_table *
+snippet_re_route_to_kernel_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_re_route_to_kernel_create_table
+
+#endif /* SNIPPET_REROUTE_TO_KERNEL_H */
-- 
2.34.1

