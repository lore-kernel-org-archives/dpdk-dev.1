Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F356C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 07:16:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51DD740685;
	Tue, 24 Jun 2025 09:16:16 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by mails.dpdk.org (Postfix) with ESMTP id 08C8E40685
 for <dev@dpdk.org>; Tue, 24 Jun 2025 09:16:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiNejhKIA6ojwAI1KpTMzDmNO85Flu5i4h38kUEfTlj/M0Ym7fv6s3Dm61BcHnLU3ITk3IwpH5sC3K4fQ6rr3Z65sFqkudPSSNO0ecKz95HSD3pRWLGcmdEuzEaQtIXEKhPNHLb0A46AXTVzbm3lImR06BVzil9mYgGrgjDQrqgkaQfbNJF0q8r/WaM748AdSUGioJ8PwkxeTpL4Rp1+dn+LercqGdsopRaIs6D1mOm11gPf/TT8DCLu1N5AwOGlIgWjKt4eq4WWwb+n2U7VL4ot2h24X4HPJDrljro3o+kdMrR2x2k/Fwha7neZ/42LL8kqz1csFIaqw73gWn47BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJNKRu5XzKRuZ3ffqbTwgUZ2IFny7RijkgrNSfvlYjI=;
 b=bA8cCZ65q451aE9I65cnffSV0vZgfhfaRO0nT5rjcFcLSkElvV6lES5EwxM4rNbEGrglTRuPpCdEBoVsXZd0bYpiiB/YDtpmll1DWamWbEBowaFV7vSJYBTqIy6bqSsJyzKflNztQehKblRmP2DGAruSsu8EoRd8fyWXApE5/DP1Lv76F3T3X5emk0kcAaGMA97eppQCgPz3d1YZccu7L/fp3CVT6BqIJ30vAzP4brlJMwy0LUcft7b+dnE8CBePchZsBtRvcVfxsjrmQw8Cgw8WZaxz3V6GUO08m8r1SpNthJN1fMtL84S+OO3eGWEGW7CMQnNS6Cy7iSO1gM96pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJNKRu5XzKRuZ3ffqbTwgUZ2IFny7RijkgrNSfvlYjI=;
 b=Kax6V53VJBjlfxvDKL8TR5ZKGHx7mjYvYgfGC57ZA4JcFpusXJFK+VBmm9owokMdPNAIB6obE2heViuKoWpx2h8Gt7qsXQjVtEOUYxVkUUYKheJOTfGgHnSLzgK3broufjQRh/2wzhP+FueKpUohCppFIutQU/TM93Re61LO+apy1L9Nq1gKyUZsUOl6E66BDrfz/tPBs+oowXRqL0C9ycj8sCiQ7a81hxTt8N3HG8i43nrir+rypZo//TW89ice1kzmnB9C1ZinGPABkbTTl9chqfiN9HYhcPITnnk0nUN+IwKz/zaTXn6uGseAydEyQ9vCeWvAP0wLUVTK/fUlaw==
Received: from BN9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::27)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Tue, 24 Jun
 2025 07:16:06 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:408:10b:cafe::7c) by BN9P223CA0022.outlook.office365.com
 (2603:10b6:408:10b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 07:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 07:16:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Jun
 2025 00:15:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 24 Jun
 2025 00:15:47 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 24 Jun 2025 00:15:46 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Ori Kam <orika@nvidia.com>
Subject: [RFC PATCH 2/2] examples/flow_filtering: add jump flow
Date: Tue, 24 Jun 2025 10:15:37 +0300
Message-ID: <20250624071538.107876-3-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624071538.107876-1-shperetz@nvidia.com>
References: <20250624071538.107876-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: a82c5628-5de7-4289-641d-08ddb2eefc4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OcBx5wdbykRfaqDltFsR10hXwADzTYK5GHzs5RGb50ruCIQVnG2Kiwoc3Llr?=
 =?us-ascii?Q?4d7AYjnqYOgv7vHDVfoWclshDYD2ny1wGGw5LkRmYi8BnU9C64sosYfKELC7?=
 =?us-ascii?Q?Dt4kMYI4HykY4S2u+pKPbkC/3mR6bc3usGWm2qwEGho1/nfn6S5yEeHRDeIp?=
 =?us-ascii?Q?bI92QoPO/4iJ854iFJktu7TpamxZJhXNg5NWUBkIYKE2NEOeQNgEN39VMXoJ?=
 =?us-ascii?Q?2PkMSAGO2yu1CVncEh3g/00I6F0Q3hzq5ZcHRnEGA81IZhwkZBBNFuV6EKn9?=
 =?us-ascii?Q?NoiLP5DElLV+uuKq8JyZ39+UVtki9rT7E1/598gwCGDl9ZB+Qg2FCO13ZIuA?=
 =?us-ascii?Q?1x/r/tqNEln1q9bwdSd9eWzlb5ae+H46Im7VvszkqGvlZaF+676j7PG1eLJO?=
 =?us-ascii?Q?ZSskkBxLqJbz8LIvvneZuvFDK/CA7vh/fwQdWp/s1qJhmdHp2zS+2A9nCpUa?=
 =?us-ascii?Q?W1WQ2jXqn/YUYxrUcaACnTnWPMRAkawgZQnN4CMEwiJ8CTVlM8eLOiWTNSwn?=
 =?us-ascii?Q?YVueec/C8sWVpFSVR5kgqi7bus2gpBKd2Mu0+/SJKG/knY/fl0w8bxGudchZ?=
 =?us-ascii?Q?9y7vsS8QBcxARlIMtlzB6gkqS3Z5p1KHeWek23P4ZR4hkqwfGspvgAdIWFbH?=
 =?us-ascii?Q?XXFqRCC1Wtjje40j9wnHX1+7SEhwo58/gm7GjJO10NJBqcs/dfIymaVSPEcV?=
 =?us-ascii?Q?Z0WwHTkQ+qPE1V9d0CalCZnoRFRkgfyDxzNzqegILrPhdM4oOv6jYxE1WiUI?=
 =?us-ascii?Q?JS/p83rR1lnCuxHZjzxoAn10rjZTBIzuf4RVqnAVBAsMQvSerNYGj1A9SaVT?=
 =?us-ascii?Q?Ep8IARSUZDAer+fevG0L1RnlyWMs+qM/X6qWWJRjALvFCFBPbmEuuabXYHjF?=
 =?us-ascii?Q?8Vx4x4AJqjos4CVRFvyzJ+2t1kTIZ2XAP07/7G9Z4HOhpTNevm+FoL27tsHe?=
 =?us-ascii?Q?TVeEafvUwCgbeflaU/w1UGQORbSDyCyoa7LzYfiyDSHoPTN5h81eTP8G5frf?=
 =?us-ascii?Q?4CWnWMpyoxSEONz1+KMe9j0iALca+cXV1U1lAegZmPQNL24ZxYlPo1ru+QGe?=
 =?us-ascii?Q?lNXjsdeHil5KeYVh5Puk3JpEDWb1gNL2Nc/om8lN+PgFAH4/4EtOAo7fDpY/?=
 =?us-ascii?Q?CD1x8v/l1+puN/CMfdXMkm64HrxS5lkI+Uf7gP+S7WGcU3/4aWespCv1lQe8?=
 =?us-ascii?Q?6bXCKta/9pMS3QqftGea1dkOUbVyT0gFSvGl2KMxTSelyFrXYMlEqZg3DZPI?=
 =?us-ascii?Q?pq2NcvEtcTUwuAcAVOVkrQkE1WtNVfyfQdPVfB2TfCs5tUiYGVf0nqIukW6W?=
 =?us-ascii?Q?XPWNS6aPVYV5i/bzrOwmjXDP7QnrVz8+FE2rVbelrrySm4VEpEMscuKbebl9?=
 =?us-ascii?Q?VzVWtLdIUXQj9LMvC7/Crc6awVFNetdoHFycF23xHNYs3IbOQKebuHCoDysv?=
 =?us-ascii?Q?PgdVCDBZ5cb+J2OHVSBmbF0s+a6xW8JpKEysXd4NGP+2WbMZ4KYmvNskxFaS?=
 =?us-ascii?Q?dJcOG6tFEjWoXUrT1DYlw2eoCMzuNbcX2zTq?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 07:16:05.9669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a82c5628-5de7-4289-641d-08ddb2eefc4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889
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

