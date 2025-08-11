Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1C1C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 14:37:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A97B40E2C;
	Mon, 11 Aug 2025 16:37:29 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by mails.dpdk.org (Postfix) with ESMTP id B67E440DDC
 for <dev@dpdk.org>; Mon, 11 Aug 2025 16:37:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nam3R/ZO5Zveva/hJaOie8nORrN8c+UBnnG80IRO+StIpEOT1VxJscaQUdM1o7GJeyf+wR4oBKGjvcUEpxN9GZzQT3PnGNUL74XBLv8Bh1MOwD5eiYgeLBXtQBAZ9hT54nbRza1YuBOYjMwPOFrWN4vkG1rx8P1jA0snSUQxX6CURYFOL+uTB9RD0D/k+Sk0x8WZZL1ccVzwL6YIDeTPbduDABXB6YBLDnWjDDjI3Pialxxk7iGyjlBmTfIsl3P1mKVrb+5ty0tlRNRDxsF0DWGavWHJhzTynH0gFvS7i4bRbfn71S1qTFD1IekGjX0Fprs7+bKxrl//mydnRH/v3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJNKRu5XzKRuZ3ffqbTwgUZ2IFny7RijkgrNSfvlYjI=;
 b=H3FdRjCdJ3otj39eHt7qgvWQzeuDU8dsVROHFLJ3dlMcPtZRT/HVUMUBPlqH6C3Bvgto37s9mVh3M0/qR0VNcGGeaFc7YFjDy9U8sz1WyrhjA6KhL9N53xLzZaVxVPajZ4DTGCkSl8ToDtHaip9jcI1DcRUF5aBBH+kRNNSLebaASEbK21UQJEFpS7qhJsQqZ43Tmhh8x4WmHsZ69SxJ040DfR8C6d13I5Pgev4a7C1T86DQR02bl+mH7KTha36nKDJnJYBV8a4eCSeT/KFdKCApA5QziLOU8w5Uodr7tipdme3IApekHZz1F0ijoPrhQQN28p7NWTAd5Z1cHOEHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJNKRu5XzKRuZ3ffqbTwgUZ2IFny7RijkgrNSfvlYjI=;
 b=EO3rinPeJXvU+y9x+dDVTNopxbbKjUIg1KKcnYMnLyxQLqRultaufBMO9lT5rikFvCcKcCBvNR4qC9EU1u5ZOwE1ZBM9VYQU0MPn8p7ryUUGcNFGHBhX+T+Gmmn4qjc5CZttRIechZa3e0pX7C0Iv+nizr4NriAqEFxOhQK1uAQDuPnVoLIufqE1tnTYnCHzKRpo9D/zWN1Yq77o7s3h/aI7C+JrBM4iDkXq2bdBcRkicbnEULKf/QZ27rNgE6IKIwp0a9WJrhw/103auw+praVWeUVxv4nGnOD7KQ78OorrjGwheviyRRSLjeIaff99Tu27Oo9ib8l7zhZSU4crsw==
Received: from BN1PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:e0::11)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 14:37:23 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::41) by BN1PR10CA0006.outlook.office365.com
 (2603:10b6:408:e0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 14:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:37:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 07:37:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 11 Aug 2025 07:37:13 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 11 Aug 2025 07:37:12 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Ori Kam <orika@nvidia.com>
Subject: [PATCH v2 2/2] examples/flow_filtering: add jump flow
Date: Mon, 11 Aug 2025 17:37:04 +0300
Message-ID: <20250811143704.146795-3-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811143704.146795-1-shperetz@nvidia.com>
References: <20250624071538.107876-2-shperetz@nvidia.com>
 <20250811143704.146795-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5b92dd-6153-427b-0631-08ddd8e4956b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dz5RvTzAso9KNWOrLCyFbtJgjMO/vdhrIJfCAKpreJ6hssWXotSIyGlOZpgh?=
 =?us-ascii?Q?EUXpncIY56i3swxwRaXrEAhjO+IT/ZVMHQUh3bNLc+nQnfXHmFO8j+VaH9L/?=
 =?us-ascii?Q?d+ugY8Pwu8EHkvbo09H2O8aID0eaYJczGUBzQSjxWJJqZre5rs0238t2lpFL?=
 =?us-ascii?Q?Phyyu1O8tawi8fj8MKR1JW5RkjX/d8BDtxxZe4RMsMON5IIjZe7ZVZu9xQ80?=
 =?us-ascii?Q?ReJ8i/aTCXYjDvCoPwmi6v16u4A0ZrCRUS6lcbV0I76Nc897maBTSlMeibp5?=
 =?us-ascii?Q?jJXo/AuHXev9BYgb1sa2dn/gkKOI+7hinBtMZFPH6FxHdWaALZVMxRx06Ee5?=
 =?us-ascii?Q?OEU1vptlMRs2X4wYWpJc7vVIqwfbMwuQtRESGNv8/zXRTNySxiKMZrcVI6LC?=
 =?us-ascii?Q?i4/v8RDz0s0x3j07IefUWMOdAVzBGj1X0tmLO3YQW3QC29HAOLxg14c9PvH4?=
 =?us-ascii?Q?pr/UdT6ksF3Z/Euz2D/JHXDN4voxRYGuJUiboJw7sF3JHCQNC3f/lrwfJdqT?=
 =?us-ascii?Q?W5vg2CiKKM5zo/29dpuDjnQz0bnQEcplADE7wfmsWla/7Hy2KkqG7SdXI1IS?=
 =?us-ascii?Q?TzRtgyZmqiCV9f0yQjJkgIXw3baPh4O4yweSvAVI5XcXJug3w1XK6zA4T0Rv?=
 =?us-ascii?Q?W5m71vl2sWiRqv+Shofm7+HudlxGP5caDv4LZgFPD9/MQlh34lX5zzWbaUOP?=
 =?us-ascii?Q?phH9cAWE6XcH2DprrGc3t9z6CSAIPKCMXUefXyaL6seWJdH+chk1AmWdKNiv?=
 =?us-ascii?Q?o0bER7YOXLhTzCylCihfqk/S23sini3z8b+R6nGhbK4DP9esBJuN/DUJLmsI?=
 =?us-ascii?Q?UcntL4PxywLFruZpz84QXguUQxxS29qeoGH4bnfvJZ/RN4y6XF+RGUpAK59S?=
 =?us-ascii?Q?Epv8o28omaczRTfA6oH29049DQ/Xx7TQQrRqMPa194o1a3Znr5aySIlkszAu?=
 =?us-ascii?Q?GhvaMFj+EH7IonqlBxTJ/qEviFvO6aLkl2Ciwouncp/FPNYiXU38jH+bL3mu?=
 =?us-ascii?Q?WPl5T2Mf+hROv6ftyRsf7057GOKw75cdaP+bHMc6FHR3t/X05A5NpRxWF7ZB?=
 =?us-ascii?Q?Nd+2kSNWV88KF24+5F7MnT0f0GgrbvhXvxeOzGPTmv9BRWViA5/3L3qMk/NJ?=
 =?us-ascii?Q?7jN1JEwMSRl8EgWujeC67Vat6VyFE/wKN6/gQSpXP0a8Bi8uBGfQYnGOWd3C?=
 =?us-ascii?Q?gQLg1BA7YYlP2ydVjxsoVWvqkEpdpbfkNFLZM3gndg7UIiqFqvuJnRZDV54o?=
 =?us-ascii?Q?TmvidMqG89zl4EdIzcigpUkSZS8MjDV2AbPjstHcvPIoGyTxIaPBL0Y/bbYV?=
 =?us-ascii?Q?SOpMR5tw3KU3IiS2YZ2EOjheBZ1idEadDGfoerwHSG3Ehvh4P2twgRsnuxp6?=
 =?us-ascii?Q?T1nI58UwDhJxtW0aKaKcAqnME0rkSEycofuTSLQtZ7NjeFeVKznYZIKG4rcT?=
 =?us-ascii?Q?LBj07QqReq/AUy7sXJ4nRc1Mb4psCHXRLlmoz65EB1sh9XSBWVW4r88qSeip?=
 =?us-ascii?Q?yFOGIaGK50UfqHutlRMdzdKsu6PIHegQjweM?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:37:22.6110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5b92dd-6153-427b-0631-08ddd8e4956b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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

Added the option to jump to a specific group.
snippets that are not supported on the root table can now call
create_jump_flow to jump to other group.

Added three new snippets that uses the jump flow:
- match Network Service Header (NSH) snippet
- match RoCE IB BTH opcode/dest_qp snippet
- Switch Granularity rule matching snippet

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 examples/flow_filtering/jump_flow.c           | 40 ++++++++++
 examples/flow_filtering/jump_flow.h           | 13 ++++
 examples/flow_filtering/meson.build           |  4 +
 .../snippets/snippet_match_nsh.c              | 74 +++++++++++++++++++
 .../snippets/snippet_match_nsh.h              | 36 +++++++++
 .../snippets/snippet_match_roce_ib_bth.c      | 69 +++++++++++++++++
 .../snippets/snippet_match_roce_ib_bth.h      | 35 +++++++++
 .../snippets/snippet_switch_granularity.c     | 55 ++++++++++++++
 .../snippets/snippet_switch_granularity.h     | 36 +++++++++
 9 files changed, 362 insertions(+)
 create mode 100644 examples/flow_filtering/jump_flow.c
 create mode 100644 examples/flow_filtering/jump_flow.h
 create mode 100644 examples/flow_filtering/snippets/snippet_match_nsh.c
 create mode 100644 examples/flow_filtering/snippets/snippet_match_nsh.h
 create mode 100644 examples/flow_filtering/snippets/snippet_match_roce_ib_bth.c
 create mode 100644 examples/flow_filtering/snippets/snippet_match_roce_ib_bth.h
 create mode 100644 examples/flow_filtering/snippets/snippet_switch_granularity.c
 create mode 100644 examples/flow_filtering/snippets/snippet_switch_granularity.h

diff --git a/examples/flow_filtering/jump_flow.c b/examples/flow_filtering/jump_flow.c
new file mode 100644
index 0000000000..268c0d597e
--- /dev/null
+++ b/examples/flow_filtering/jump_flow.c
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "jump_flow.h"
+
+
+struct rte_flow *
+create_jump_flow(uint16_t port_id, uint16_t group_id, struct rte_flow_error *error)
+{
+	struct rte_flow_action actions[2] = {0};
+	struct rte_flow_item patterns[2] = {0};
+	struct rte_flow *flow = NULL;
+
+	struct rte_flow_attr flow_attr = {
+		.ingress = 1,
+		.group = 0,
+	};
+
+	struct rte_flow_action_jump jump = {
+		.group = group_id,
+	};
+
+	/* Set up jump action to target group */
+	actions[0].type = RTE_FLOW_ACTION_TYPE_JUMP;
+	actions[0].conf = &jump;
+	actions[1].type = RTE_FLOW_ACTION_TYPE_END;
+
+	/* match on ethernet */
+	patterns[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	patterns[1].type = RTE_FLOW_ITEM_TYPE_END;
+
+	/* Validate the rule and create it. */
+	if (rte_flow_validate(port_id, &flow_attr, patterns, actions, error) == 0)
+		flow = rte_flow_create(port_id, &flow_attr, patterns, actions, error);
+	return flow;
+}
diff --git a/examples/flow_filtering/jump_flow.h b/examples/flow_filtering/jump_flow.h
new file mode 100644
index 0000000000..ebbec85533
--- /dev/null
+++ b/examples/flow_filtering/jump_flow.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef JUMP_FLOW_H
+#define JUMP_FLOW_H
+
+
+struct rte_flow *
+create_jump_flow(uint16_t port_id, uint16_t group_id, struct rte_flow_error *error);
+
+
+#endif /* JUMP_FLOW_H */
diff --git a/examples/flow_filtering/meson.build b/examples/flow_filtering/meson.build
index 3be2bb1ef5..3b644c7029 100644
--- a/examples/flow_filtering/meson.build
+++ b/examples/flow_filtering/meson.build
@@ -12,11 +12,15 @@ deps += ['argparse']
 sources = files(
         'main.c',
         'flow_skeleton.c',
+        'jump_flow.c',
         'snippets/snippet_match_ipv4.c',
         'snippets/snippet_match_gre.c',
         'snippets/snippet_match_mpls.c',
+        'snippets/snippet_match_nsh.c',
         'snippets/snippet_match_port_affinity.c',
+        'snippets/snippet_match_roce_ib_bth.c',
         'snippets/snippet_re_route_to_kernel.c',
+        'snippets/snippet_switch_granularity.c'
 )
 
 # The code snippets are not utilized.
diff --git a/examples/flow_filtering/snippets/snippet_match_nsh.c b/examples/flow_filtering/snippets/snippet_match_nsh.c
new file mode 100644
index 0000000000..262d0c8d81
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_nsh.c
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "../jump_flow.h"
+#include "snippet_match_nsh.h"
+
+static void
+snippet_init_nsh(void)
+{
+	flow_attr.transfer = 1;
+	flow_attr.group = 1;
+	flow_attr.priority = 0;
+}
+
+static void
+snippet_match_nsh_create_actions(uint16_t port_id, struct rte_flow_action *action)
+{
+	/* jump to group 1 */
+	struct rte_flow_error error;
+	create_jump_flow(port_id, 1, &error);
+
+	struct rte_flow_action_port_id *portid = calloc(1, sizeof(struct rte_flow_action_port_id));
+	if (portid == NULL)
+		fprintf(stderr, "Failed to allocate memory for port_id\n");
+
+	/* To match on NSH to port_id 1. */
+	portid->id = 1;
+
+	action[0].type = RTE_FLOW_ACTION_TYPE_PORT_ID;
+	action[0].conf = portid;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+static void
+snippet_match_nsh_create_patterns(struct rte_flow_item *pattern)
+{
+	struct rte_flow_item_udp *spec;
+	struct rte_flow_item_udp *mask;
+
+	spec = calloc(1, sizeof(struct rte_flow_item_udp));
+	if (spec == NULL)
+		fprintf(stderr, "Failed to allocate memory for spec\n");
+
+	mask = calloc(1, sizeof(struct rte_flow_item_udp));
+	if (mask == NULL)
+		fprintf(stderr, "Failed to allocate memory for mask\n");
+
+	/* Set the patterns. */
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_IPV6;
+
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_UDP;
+	spec->hdr.dst_port = RTE_BE16(250);
+	mask->hdr.dst_port = RTE_BE16(0xffff);
+	pattern[2].spec = spec;
+	pattern[2].mask = mask;
+
+	pattern[3].type = RTE_FLOW_ITEM_TYPE_VXLAN_GPE;
+	pattern[4].type = RTE_FLOW_ITEM_TYPE_NSH;
+	pattern[5].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[6].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+static struct rte_flow_template_table *
+snippet_nsh_flow_create_table(__rte_unused uint16_t port_id,
+	__rte_unused struct rte_flow_error *error)
+{
+	return NULL;
+}
diff --git a/examples/flow_filtering/snippets/snippet_match_nsh.h b/examples/flow_filtering/snippets/snippet_match_nsh.h
new file mode 100644
index 0000000000..8df37c2b13
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_nsh.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_MATCH_NSH_H
+#define SNIPPET_MATCH_NSH_H
+
+/* Network Service Header (NSH)
+ * provides a mechanism for metadata exchange along the instantiated service paths.
+ * The NSH is the Service Function Chaining (SFC) encapsulation required to support the
+ * SFC architecture.
+ * NSH, a data-plane protocol can be matched now using the existed item: RTE_FLOW_ITEM_TYPE_NSH.
+ * Currently this is supported ONLY when NSH follows VXLAN-GPE,
+ * and the "l3_vxlan_en=1" and "dv_flow_en=1" (Default) is set.
+ */
+
+#define MAX_PATTERN_NUM		7 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM		2 /* Maximal number of actions for this example. */
+
+static void
+snippet_init_nsh(void);
+#define snippet_init snippet_init_nsh
+
+static void
+snippet_match_nsh_create_actions(uint16_t port_id, struct rte_flow_action *actions);
+#define snippet_skeleton_flow_create_actions snippet_match_nsh_create_actions
+
+static void
+snippet_match_nsh_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_nsh_create_patterns
+
+static struct rte_flow_template_table *
+snippet_nsh_flow_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_nsh_flow_create_table
+
+#endif /* SNIPPET_MATCH_NSH_H */
diff --git a/examples/flow_filtering/snippets/snippet_match_roce_ib_bth.c b/examples/flow_filtering/snippets/snippet_match_roce_ib_bth.c
new file mode 100644
index 0000000000..f3c7e3eb70
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_roce_ib_bth.c
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "../jump_flow.h"
+#include "snippet_match_roce_ib_bth.h"
+
+static void
+snippet_init_roce_ib_bth(void)
+{
+	flow_attr.ingress = 1;
+	flow_attr.group = 1;
+	flow_attr.priority = 1;
+}
+
+static void
+snippet_match_roce_ib_bth_create_actions(uint16_t port_id, struct rte_flow_action *action)
+{
+	/* jump to group 1 */
+	struct rte_flow_error error;
+	create_jump_flow(port_id, 1, &error);
+
+	/* Create one action that moves the packet to the selected queue. */
+	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
+	if (queue == NULL)
+		fprintf(stderr, "Failed to allocate memory for queue\n");
+
+	/* Set the selected queue. */
+	queue->index = 1;
+
+	/* Set the action move packet to the selected queue. */
+	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	action[0].conf = queue;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+static void
+snippet_match_roce_ib_bth_create_patterns(struct rte_flow_item *pattern)
+{
+	struct rte_flow_item_ib_bth *bth;
+
+	bth = calloc(1, sizeof(struct rte_flow_item_ib_bth));
+	if (bth == NULL)
+		fprintf(stderr, "Failed to allocate memory for bth\n");
+
+	bth->hdr.opcode = 0x81;
+	bth->hdr.dst_qp[0] = 0x0;
+	bth->hdr.dst_qp[1] = 0xab;
+	bth->hdr.dst_qp[2] = 0xd4;
+
+	/* Set the patterns. */
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_IPV4;
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_UDP;
+	pattern[3].type = RTE_FLOW_ITEM_TYPE_IB_BTH;
+	pattern[3].spec = bth;
+	pattern[4].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+static struct rte_flow_template_table *
+snippet_match_roce_ib_bth_create_table(__rte_unused uint16_t port_id,
+							__rte_unused struct rte_flow_error *error)
+{
+	return NULL;
+}
diff --git a/examples/flow_filtering/snippets/snippet_match_roce_ib_bth.h b/examples/flow_filtering/snippets/snippet_match_roce_ib_bth.h
new file mode 100644
index 0000000000..a93ced3248
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_roce_ib_bth.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_MATCH_ROCE_IB_BTH_H
+#define SNIPPET_MATCH_ROCE_IB_BTH_H
+
+/* Matching RoCE IB BTH opcode/dest_qp
+ * IB BTH fields (opcode, and dst_qp) can be matched now using the new IB BTH item:
+ * RTE_FLOW_ITEM_TYPE_IB_BTH.
+ * Currently, this item is supported on group > 1, and supports only the RoCEv2 packet.
+ * The input BTH match item is defaulted to match one RoCEv2 packet.
+ */
+
+#define MAX_PATTERN_NUM     5 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM      2 /* Maximal number of actions for this example. */
+
+static void
+snippet_init_roce_ib_bth(void);
+#define snippet_init snippet_init_roce_ib_bth
+
+static void
+snippet_match_roce_ib_bth_create_actions(uint16_t port_id, struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_roce_ib_bth_create_actions
+
+static void
+snippet_match_roce_ib_bth_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_roce_ib_bth_create_patterns
+
+static struct rte_flow_template_table *
+snippet_match_roce_ib_bth_create_table(__rte_unused uint16_t port_id,
+__rte_unused struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_match_roce_ib_bth_create_table
+
+#endif /* SNIPPET_MATCH_ROCE_IB_BTH_H */
diff --git a/examples/flow_filtering/snippets/snippet_switch_granularity.c b/examples/flow_filtering/snippets/snippet_switch_granularity.c
new file mode 100644
index 0000000000..414870bf89
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_switch_granularity.c
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "../jump_flow.h"
+#include "snippet_switch_granularity.h"
+
+static void
+snippet_init_switch_granularity(void)
+{
+	flow_attr.ingress = 0;
+	flow_attr.transfer = 1;
+	flow_attr.group = 1;
+	flow_attr.priority = 1;
+}
+
+static void
+snippet_match_switch_granularity_create_actions(uint16_t port_id, struct rte_flow_action *action)
+{
+	/* jump to group 1 */
+	struct rte_flow_error error;
+	create_jump_flow(port_id, 1, &error);
+
+	struct rte_flow_action_ethdev *represented_port = calloc(1,
+		sizeof(struct rte_flow_action_ethdev));
+	if (represented_port == NULL)
+		fprintf(stderr, "Failed to allocate memory for represented_port\n");
+
+	represented_port->port_id = 0;
+	action[0].type = RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT;
+	action[0].conf = represented_port;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+static void
+snippet_match_switch_granularity_create_patterns(struct rte_flow_item *pattern)
+{
+	/* Set the patterns. */
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT;
+	pattern[1].spec = NULL;
+	pattern[1].mask = NULL;
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+static struct rte_flow_template_table *
+create_table_switch_granularity(__rte_unused uint16_t port_id,
+	__rte_unused struct rte_flow_error *error)
+{
+	return NULL;
+}
diff --git a/examples/flow_filtering/snippets/snippet_switch_granularity.h b/examples/flow_filtering/snippets/snippet_switch_granularity.h
new file mode 100644
index 0000000000..edc15c3ed7
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_switch_granularity.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+ #ifndef SNIPPET_SWITCH_GRANULARITY_H
+ #define SNIPPET_SWITCH_GRANULARITY_H
+
+/* Switch Granularity Rule Matching
+ * supports the represented_port item in pattern.
+ * If the spec and the mask are both set to NULL, the source vPort
+ * will not be added to the matcher, it will match patterns for all
+ * vPort to reduce rule count and memory consumption.
+ * When testpmd starts with a PF, a VF-rep0 and a VF-rep1,
+ * the snippets will redirect packets from VF0 and VF1 to the wire
+ */
+
+ #define MAX_PATTERN_NUM	3 /* Maximal number of patterns for this example. */
+ #define MAX_ACTION_NUM		2 /* Maximal number of actions for this example. */
+
+static void
+snippet_init_switch_granularity(void);
+#define snippet_init snippet_init_switch_granularity
+
+static void
+snippet_match_switch_granularity_create_actions(uint16_t port_id, struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_switch_granularity_create_actions
+
+static void
+snippet_match_switch_granularity_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_switch_granularity_create_patterns
+
+static struct rte_flow_template_table *
+create_table_switch_granularity(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table create_table_switch_granularity
+
+ #endif /* SNIPPET_SWITCH_GRANULARITY_H */
-- 
2.34.1

