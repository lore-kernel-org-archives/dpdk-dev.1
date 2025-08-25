Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B94CA0FE1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 07:24:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 423C440648;
	Mon, 25 Aug 2025 09:24:35 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by mails.dpdk.org (Postfix) with ESMTP id E086F40608
 for <dev@dpdk.org>; Mon, 25 Aug 2025 09:24:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5/NBOv5g6mWu1P+hqQlj39xlgpyH8nQ3BZpo9xtKb8ofzzimwwsavh6BSIFxhSZ1uNRsZ3ycoDqSJGptz8McDyhgad8ggoa/+3WHWJYhaaBzSoXhln09z29LDYvritCNNfaDJpbDnmun7k2IixgJbB/9USf430Wf2DCLv2pdNOmLChUIbm0ExaGY/azMLQ70anO6OAYqDsj9NuPhfW+mj8IG0E/16NTc2EbaocONZO2Iiu6vKugx/re2u/sKVnQfjd8cUY6a/eE7l2RXn01+LTSPCA9lS10RKznBAyeKL6VrlO7J8FVNciNbH8YCT0ObgTHJy2z497vk9uv+PZWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbt8s6uPejV7JNaEp91yrH0ZoP4RNiN+aRcKIW6h2ys=;
 b=Ag9mjrNx5wS8B5uDpl/Joo5id9GxWT3T0yNlhLXHddtRYcSjh1jMbEgd9Qzlkgdf55QCqjtWraCjr+RnGaKNzO+dZq+z0nbxSLhT2IGTgpxMSfLeZaYFB6nMDj9kPgdMC0ynsaohkDbhHLlwPNdV4B1s4zBqxpARjqYwYf9BDKtiJvvTyTNkdbJ9DnJl5mAbRCLIHMQP4/vVpXqcBkFFzbY6Pq1z0yIbsERKb3RW5wrcvL5KZV8caBl64+wvtvsyaDk9DH3GgB5XcOf5dlJHch71RKpVFAk7Ec9DAHe1K3II8LK8cZzkYh3goBLAqFYR48+g8DBiOGGnrjJq4UsxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbt8s6uPejV7JNaEp91yrH0ZoP4RNiN+aRcKIW6h2ys=;
 b=a7Kp9brHSuq1pxp/MCeEmhs/snTngRiwCWKpqlY6CBKTdzzyu/hQDU/IeKgKjN0l0XBCyk1YdenxIfVmz1Vw+fvX4XkX3ibP0iWHmMWb9i/vjVQQKtZSXHUg81iXmh/MlJNzK7SXkYae/7mkZKrPjgoJwnjUAWV+OMzo9vztxPNhl8SabwRTEimKxOfX6rTszSbT/WhSUlorOs5C9hScY8Ty1TcDIaRI4d+ym1MykY64EWnCK5703QmsdcAkdWOC+OaOoQ8gX91FN8NJOVmGsjCOfDj9W66+l+UbdZu9qqgUpyCtL36BukjZetF/p4p5CBSoo09n85VuFhEcNOCZBA==
Received: from BYAPR07CA0008.namprd07.prod.outlook.com (2603:10b6:a02:bc::21)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Mon, 25 Aug 2025 07:24:26 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::3c) by BYAPR07CA0008.outlook.office365.com
 (2603:10b6:a02:bc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 07:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 07:24:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 00:24:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 00:24:08 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 00:24:07 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Ori Kam <orika@nvidia.com>
Subject: [PATCH v3 2/2] examples/flow_filtering: add jump flow
Date: Mon, 25 Aug 2025 10:23:46 +0300
Message-ID: <20250825072346.25548-3-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825072346.25548-1-shperetz@nvidia.com>
References: <20250811143704.146795-2-shperetz@nvidia.com>
 <20250825072346.25548-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: d069ea8f-195d-49c8-3c90-08dde3a86c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VEdi0b/+Z5eNQf3DtYl921Z89CzPiy8Wq1ZGatVo50fV9mqatiJl1xcpHB4+?=
 =?us-ascii?Q?YidvlOeHbkJTPByxMXGeZSi1/u0/L8nPixGUbbvnKSotnDu2XPitz35cmEog?=
 =?us-ascii?Q?V5bUed5wG5NBoU/+0zeQNmFZN0yPJwKWoR+R4W2O5TGbDAGo2dfkdd1B8d8x?=
 =?us-ascii?Q?yTecP4adqRU7K/e1/0WQsvy7ealBMtOicucOT1YnWktKv5Az3SCqnSlI7QXN?=
 =?us-ascii?Q?Inpa+5CxSJsjFssnWVL1fyFoG/0FTmFt/lM3jriVqMf+vIKR/ufUeUa+QE7d?=
 =?us-ascii?Q?rd04f11xM/i+zRDoSOSJlDKU0K+pWk2kW5TaS6GR1WFxLx8DJN1pDWL7anrv?=
 =?us-ascii?Q?AG27jUWF7kJoGlBNMxvP8uuE6WS+8hkev1ofo/EcKMogVS2hKjdntYddJrLT?=
 =?us-ascii?Q?N9oa5Xx4bqi/7sqYi9ctQbOU6QFi7KyLNRcT/XnrTQXkcqZcUHzQDiNS+fM1?=
 =?us-ascii?Q?zoWp250KnX3lgOO/5RisAf11xKshp17Z83bT7FLuo/N8mKYBdVYQGoR8kOzs?=
 =?us-ascii?Q?psl7bNHgGJtbRN6uGne6a5MkpVPtgtVJVst5h5BhUUkHYpyb8e3PRnAzwn2f?=
 =?us-ascii?Q?+1GZiI2/QVH8SruyXPg2tX92w9ZUIpzS+5/iYhV/0bssP6J+RaHG0d4GDL0P?=
 =?us-ascii?Q?JBGFricCYSEJ0mZv42wjJCnrxkKq0mz3Pn9IjE4psmGg7dUGcBb2fjmEe5bw?=
 =?us-ascii?Q?TO5fm7IvwKjR/H+v+eOryG7yhHiiSCqNxheWDsa5f4w7HlyLnfP6/edG4JPF?=
 =?us-ascii?Q?M8Owl3ftaIB2/ir8xfYWNccRntrjVV8+3fypjtQh3mVxlEa/ISFCGCrOCiIc?=
 =?us-ascii?Q?jm6a3RVzB/fZ1iJ88rPofSVCcU+vRg1XW9p9is5CW6lVknx22j/xbztqTHnc?=
 =?us-ascii?Q?3daQ3xk7bIdcEXVAhWe62rOlOun1l22uhJsxQE+YlTwUsK9xaRoc0LavCDvr?=
 =?us-ascii?Q?RqliD1U6hVxuv2jYP3otWUjwlvaDUEUWTV6a00ADGKGVpZYxBfW1UgKQEFdG?=
 =?us-ascii?Q?osLtNez+UqfBiG0m7t1IdSob+qbQWH46qVjvVd4sL2isC1wUcVeOkfkotemz?=
 =?us-ascii?Q?MD6rhPF0RFKATV6AaJR78KYUppRaFQr+e4jHhfoYEYHBB4ogNsnMsjyMjczT?=
 =?us-ascii?Q?nWNIf4j4OtoMXmRX76001n1OyyjmrTV1A33g5zbmM53LkL8gEcp71n/N2/g6?=
 =?us-ascii?Q?dF+wWXLQuWMYJdrf4ujTQgnlxfZwqinFxIALNVNriybVCn7NT2zyY9gXYjmI?=
 =?us-ascii?Q?acujieNDd+bTuEYAruR8JwtFxOf85OfOqUyXSVlHQGHtUqXj4bAv2npFeVNI?=
 =?us-ascii?Q?sKYh5/kvpqufrJEphRtd7/RzqfrGH7cMEmrVgFfjaz8jejTSOlEbyGYnwp4J?=
 =?us-ascii?Q?NXJa/gv8Dszg0xKMmlHESjE1vlcSu7i0xFfjPMXbt/VoEs+PL4s8EsC6teUB?=
 =?us-ascii?Q?hDjI326u+o+Ip8jGlItGGPsPZ752uFBIzFcuSWGpgEsDv8fz3aqcR27caVqk?=
 =?us-ascii?Q?v/5EtlbYxw+waCjgUe1VSC6RQj3/8t8Ce3wH?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:24:26.5225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d069ea8f-195d-49c8-3c90-08dde3a86c2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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
index 3be2bb1ef5..d62d3eddc2 100644
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
+        'snippets/snippet_switch_granularity.c',
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

