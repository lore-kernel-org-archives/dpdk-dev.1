Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6361ACAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:53:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9106140663;
	Fri, 19 Sep 2025 11:53:19 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
 by mails.dpdk.org (Postfix) with ESMTP id 7927440647
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:53:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym18oL0Th5P7rkeI6Y8P6MzJTNWPOM2mgOsisa9YvD20V9u+MtJaq67hORNJOL78XPcIwBy0WflLdiq7/BO3qIfESnWCHHyL65DdyYKa1EpBipDfkVXwdRCdty9LCMJZKzsVrCQn/gvDRuykBJcvTRddnPHGg8dJ00lUqn7PkSN4PFrmG04zNVebC3ERbKBGgcBLLeABD6gd/tqpMKpEfIyw1EyMmZ54OudpTE9XJft9yTerQbob+g0+uUi/abSCMd313l0y27HEjuXVvOHwwUbTMbtRqrwMd9HLZRh+KhSOPwVohk6I3a5tvAg78mfAtBhsJvypT5G/m4UNxi8vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEC9xVTu9kgoUsomBvd4VvVzSD+JuZdCODZOTQc6+cY=;
 b=OGBBUIa/4caSp4FufRqLFW3CNhy1UIsfghf8PylQmPb0SFJ9WIvoyk3MDtlXdBciKb/4SbtFYfAbRWNdTnDx+sNnFbm+TqFz9+wIBpPu05Xf55pvqwFRsjcbrTCO8gtl6NK/ni9PAL4xIBtSnuBZ7And86wbgdZiNFwXfX78cpyla9sGZgEyq6kE6W6dbm3vXidfaNpeJj4Ax6fvydshRIdhT5OxAGG9WyJxz7TKZuL1Q/g7u/3iKjBYc7Z52kuAr8luPXQ7XwIg/hll3KsO6WCDeBI5neXpfEs7cftPMvKw0ekea730703XJE3jqUuV3FB3V9/huB9eNMT3vwvbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEC9xVTu9kgoUsomBvd4VvVzSD+JuZdCODZOTQc6+cY=;
 b=ROEV6wjx1yroV3CQgao6vp+m3eqJ72oTDsHqiDqOAWfX1wnziXPdEKHQghGF/T/+nxj+EsNz48vhDw9pgarYjlFU7g6QbSSfAHX1r9YatmdvoE9jAouqtKO/gasaOkHdCySgonpDaONlXBnpv/aUh6W6kjInsZnLNEhdN76yUwelKNN+2smbXExhEvcngjAwBPSZLb2utkENtc9i3GrIexbIH6JuZl7e62UWjwRcFIOSJdk4CPMdNsacGjuHx3DX+ly72qj+lRrxYLSreZ8zvw1xgInhmv75vTizrlPhpxwlEaee6MEja60aEwjvnkFcuyWgF5XKfOCCuN3TFE32GQ==
Received: from DM6PR08CA0011.namprd08.prod.outlook.com (2603:10b6:5:80::24) by
 BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.16; Fri, 19 Sep 2025 09:53:06 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::ed) by DM6PR08CA0011.outlook.office365.com
 (2603:10b6:5:80::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 09:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 09:53:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 19 Sep
 2025 02:52:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Fri, 19 Sep
 2025 02:52:51 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 19 Sep 2025 02:52:50 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Ori Kam <orika@nvidia.com>
Subject: [PATCH] examples/flow_filtering: add more snippets
Date: Fri, 19 Sep 2025 12:52:46 +0300
Message-ID: <20250919095246.3118-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: bd75612f-4037-42be-8767-08ddf76254e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oE6AS222JClqLtaSa89sCjphLy4XFi9KvaeVlxUxNi96IW781NH1RiW03eQL?=
 =?us-ascii?Q?Iy+qiMz/2cHFBQ+auA5jBjEwSZtN1BA0s01Vhiy+P147+d/i7j0L2JjDQVWZ?=
 =?us-ascii?Q?L0tiu4PVNg6Vul+nH3Ob7noDKLjM0o2qG3sryUpLBeXDwHDahGTED4vjxOu0?=
 =?us-ascii?Q?klR8xIPJgrS8+XS8y7F3NcLCId3rJfN37yFQK8hsbZERiFP/Pj9UZQZZyBia?=
 =?us-ascii?Q?BDhCD9azRgfOvSzhr0k6YUBGu26bNK8tZOEfzyjgP8RIflzuYbAe1fBWjHq7?=
 =?us-ascii?Q?3Gj+NGbl1Opoc/laI6SEddXaVEUZzZ23tljUC3H6VVsG4bZOHwz3kz0ywaX4?=
 =?us-ascii?Q?PG7moAmni+ig2ftSxXC9jXq1NohgJBJO7BAvYNYo3pA9JpXpRbKKYIZ8MpX8?=
 =?us-ascii?Q?v0jcNPfkq4MbjbXZT5Z37UablfTT3TYBiFcqDzWV7FsaTCNOUwVqbSwfRsVX?=
 =?us-ascii?Q?NX+g3o5s+DR6dphyfsZD5aJV847yTb/L5uzT5akNS/i9mQGgqR4OgeQ1mZOv?=
 =?us-ascii?Q?KB/Z+c4lEw+JfTH5UJePehXOFmsVCTC4pcUu2BGJ4MWumWrzCs6ykxmtpwC4?=
 =?us-ascii?Q?uX419wv56KqzT+K88UdmYk5IUopRB9lwVEOKlpI90Po4sL+sCEzzv5xFTVO+?=
 =?us-ascii?Q?H0OOjaD7c4iDzAGqLIz/vrXDoOBHpk1ug/0Ks0qAVVTbFJ236hAHnoqNGSe4?=
 =?us-ascii?Q?s8UIXcavMQ2vMHAYECHtZIAur8dqsUcYIb8Z0kVFaGCZipDavtfnrzIHiQRD?=
 =?us-ascii?Q?pOi49vbrJfpz1KLrMAAU18b8cipWr/Mo4ZNSg9BnpjQl1Vt5iY/Ypqlk8jIC?=
 =?us-ascii?Q?9XVpeY2QSRmOsCfQKMieW7O4uVd0mQI1aACKfmVQ+x/34GV5rdSptesGe7u/?=
 =?us-ascii?Q?W9JC8uNLbjsGid22Sss8bbGb2EmdagXw2P4IVhNXjg2Do211nt6mwL6aQLVP?=
 =?us-ascii?Q?9uMWLS6eTYIhK5dFnQ975EjanJqBZupaxu/kx5dys+zuC8R0aFIJW/5m4xsf?=
 =?us-ascii?Q?Zxorrx2alfDOdGc6R50Mb+mFKYFSjZFvtXhwtQ4x8VJzlwFYf8TW0S1u4EgM?=
 =?us-ascii?Q?TKc5EMN4CEgpYK/LgoOHZv0IafCU65ABesZGqw+ba3QwJokUOHVpW7QdPp/H?=
 =?us-ascii?Q?Q9L0BVTOChCB4kpWreW4zHELMppNQB0EdiKNNnlTrH8RJSHQHSSW2WlfOzi+?=
 =?us-ascii?Q?uzutlqGoHMiDl2juLBgH38eTeIVBd7htw10YuLTNWqRb1boQWHgLgXYt8KHe?=
 =?us-ascii?Q?p3mLeWde6EfdMJBWfJFQBp2DX+HaAuLa4ZQa0UbT97DwReuZSIireE/Xjmoa?=
 =?us-ascii?Q?IH1NV2GYWGvkw4JYpOaPjPczTLk09cw7wV97K/u5XU7O6Ha60/hcJz4NX79W?=
 =?us-ascii?Q?ddkgk8QeEYUfAGo35KiwKg204j73bzd5jAkqZCT/PgcY60EJoYIsI6Gvr0xD?=
 =?us-ascii?Q?1amj68EIzzve/dz5M1wM9zTRv5splvSv49xLnUHG0JClu3kenamI+x4gHpSC?=
 =?us-ascii?Q?uKk+JSK77uV+sxGtJlIZWjHWOQzMO6abu4fM?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:53:05.8258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd75612f-4037-42be-8767-08ddf76254e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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

Added the following snippets:
- Steering by Integrity Check Flags
- Match packet type
- ECN in IP Header Modification
- Random Match
- VXLAN-GPE Header Fields Matching
- VXLAN-GBP Header Fields Matching
- NVGRE Matching
- NAT64 Action Usage

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 examples/flow_filtering/meson.build           |   8 +
 .../flow_filtering/snippets/snippet_NAT64.c   | 130 +++++++++++++
 .../flow_filtering/snippets/snippet_NAT64.h   |  45 +++++
 .../snippets/snippet_match_integrity_flags.c  | 101 ++++++++++
 .../snippets/snippet_match_integrity_flags.h  |  47 +++++
 .../snippets/snippet_match_nvgre.c            | 179 ++++++++++++++++++
 .../snippets/snippet_match_nvgre.h            |  40 ++++
 .../snippets/snippet_match_packet_type.c      | 129 +++++++++++++
 .../snippets/snippet_match_packet_type.h      |  45 +++++
 .../snippets/snippet_match_vxlan_gbp.c        | 154 +++++++++++++++
 .../snippets/snippet_match_vxlan_gbp.h        |  33 ++++
 .../snippets/snippet_match_vxlan_gpe.c        | 149 +++++++++++++++
 .../snippets/snippet_match_vxlan_gpe.h        |  32 ++++
 .../snippets/snippet_modify_ecn.c             |  60 ++++++
 .../snippets/snippet_modify_ecn.h             |  32 ++++
 .../snippets/snippet_random_match.c           | 157 +++++++++++++++
 .../snippets/snippet_random_match.h           |  33 ++++
 17 files changed, 1374 insertions(+)
 create mode 100644 examples/flow_filtering/snippets/snippet_NAT64.c
 create mode 100644 examples/flow_filtering/snippets/snippet_NAT64.h
 create mode 100644 examples/flow_filtering/snippets/snippet_match_integrity_flags.c
 create mode 100644 examples/flow_filtering/snippets/snippet_match_integrity_flags.h
 create mode 100644 examples/flow_filtering/snippets/snippet_match_nvgre.c
 create mode 100644 examples/flow_filtering/snippets/snippet_match_nvgre.h
 create mode 100644 examples/flow_filtering/snippets/snippet_match_packet_type.c
 create mode 100644 examples/flow_filtering/snippets/snippet_match_packet_type.h
 create mode 100644 examples/flow_filtering/snippets/snippet_match_vxlan_gbp.c
 create mode 100644 examples/flow_filtering/snippets/snippet_match_vxlan_gbp.h
 create mode 100644 examples/flow_filtering/snippets/snippet_match_vxlan_gpe.c
 create mode 100644 examples/flow_filtering/snippets/snippet_match_vxlan_gpe.h
 create mode 100644 examples/flow_filtering/snippets/snippet_modify_ecn.c
 create mode 100644 examples/flow_filtering/snippets/snippet_modify_ecn.h
 create mode 100644 examples/flow_filtering/snippets/snippet_random_match.c
 create mode 100644 examples/flow_filtering/snippets/snippet_random_match.h

diff --git a/examples/flow_filtering/meson.build b/examples/flow_filtering/meson.build
index d62d3eddc2..87e0e3591c 100644
--- a/examples/flow_filtering/meson.build
+++ b/examples/flow_filtering/meson.build
@@ -15,10 +15,18 @@ sources = files(
         'jump_flow.c',
         'snippets/snippet_match_ipv4.c',
         'snippets/snippet_match_gre.c',
+        'snippets/snippet_match_integrity_flags.c',
         'snippets/snippet_match_mpls.c',
         'snippets/snippet_match_nsh.c',
+        'snippets/snippet_match_nvgre.c',
+        'snippets/snippet_match_packet_type.c',
         'snippets/snippet_match_port_affinity.c',
         'snippets/snippet_match_roce_ib_bth.c',
+        'snippets/snippet_match_vxlan_gbp.c',
+        'snippets/snippet_match_vxlan_gpe.c',
+        'snippets/snippet_modify_ecn.c',
+        'snippets/snippet_NAT64.c',
+        'snippets/snippet_random_match.c',
         'snippets/snippet_re_route_to_kernel.c',
         'snippets/snippet_switch_granularity.c',
 )
diff --git a/examples/flow_filtering/snippets/snippet_NAT64.c b/examples/flow_filtering/snippets/snippet_NAT64.c
new file mode 100644
index 0000000000..a1ab3fd8f0
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_NAT64.c
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "../jump_flow.h"
+#include "snippet_NAT64.h"
+
+void
+snippet_init_nat64(void)
+{
+	flow_attr.egress = 1;
+	flow_attr.group = 1;
+}
+
+void
+snippet_match_nat64_create_actions(uint16_t port_id, struct rte_flow_action *action)
+{
+	struct rte_flow_error error;
+	create_jump_flow(port_id, 1, &error);
+
+	struct rte_flow_action_nat64 *nat64_v = calloc(1, sizeof(struct rte_flow_action_nat64));
+	struct rte_flow_action_jump *jump_v = calloc(1, sizeof(struct rte_flow_action_jump));
+
+	nat64_v->type = RTE_FLOW_NAT64_4TO6;
+	jump_v->group = 2;
+
+	action[0].type = RTE_FLOW_ACTION_TYPE_NAT64;
+	action[0].conf = nat64_v;
+	action[1].type = RTE_FLOW_ACTION_TYPE_JUMP;
+	action[1].conf = jump_v;
+	action[2].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+void
+snippet_match_nat64_create_patterns(struct rte_flow_item *pattern)
+{
+pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+pattern[1].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+static struct rte_flow_pattern_template *
+snippet_match_nat64_create_pattern_template(uint16_t port_id, struct rte_flow_error *error)
+{
+const struct rte_flow_pattern_template_attr pt_attr = { .egress = 1 };
+const struct rte_flow_item pattern[2] = {
+	[0] = {
+		.type = RTE_FLOW_ITEM_TYPE_ETH,
+	},
+	[1] = {
+		.type = RTE_FLOW_ITEM_TYPE_END,
+	},
+};
+
+return rte_flow_pattern_template_create(port_id, &pt_attr, pattern, error);
+}
+
+static struct rte_flow_actions_template *
+snippet_match_nat64_create_actions_template(uint16_t port_id, struct rte_flow_error *error)
+{
+	const struct rte_flow_action_nat64 nat64_v = { .type = RTE_FLOW_NAT64_4TO6 };
+	const struct rte_flow_action_nat64 nat64_m = { .type = UINT8_MAX };
+	const struct rte_flow_action_jump jump_v = { .group = 2 };
+	const struct rte_flow_action_jump jump_m = { .group = UINT32_MAX };
+
+	const struct rte_flow_action actions[3] = {
+		[0] = {
+			.type = RTE_FLOW_ACTION_TYPE_NAT64,
+			.conf = &nat64_v,
+		},
+		[1] = {
+			.type = RTE_FLOW_ACTION_TYPE_JUMP,
+			.conf = &jump_v,
+		},
+		[2] = {
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+
+	const struct rte_flow_action masks[3] = {
+		[0] = {
+			.type = RTE_FLOW_ACTION_TYPE_NAT64,
+			.conf = &nat64_m,
+		},
+		[1] = {
+			.type = RTE_FLOW_ACTION_TYPE_JUMP,
+			.conf = &jump_m,
+		},
+		[2] = {
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+
+	const struct rte_flow_actions_template_attr at_attr = { .egress = 1 };
+	return rte_flow_actions_template_create(port_id, &at_attr, actions, masks, error);
+}
+
+struct rte_flow_template_table *
+snippet_match_nat64_create_table(uint16_t port_id, struct rte_flow_error *error)
+{
+	struct rte_flow_pattern_template *pt;
+	struct rte_flow_actions_template *at;
+	const struct rte_flow_template_table_attr tbl_attr = {
+		.flow_attr = {
+			.group = 1,
+			.priority = 0,
+			.egress = 1,
+		},
+		.nb_flows = 8,
+	};
+
+	pt = snippet_match_nat64_create_pattern_template(port_id, error);
+	if (pt == NULL) {
+		printf("Failed to create pattern template: %s (%s)\n",
+		error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	at = snippet_match_nat64_create_actions_template(port_id, error);
+	if (at == NULL) {
+		printf("Failed to create actions template: %s (%s)\n",
+		error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	return rte_flow_template_table_create(port_id, &tbl_attr, &pt, 1, &at, 1, error);
+}
diff --git a/examples/flow_filtering/snippets/snippet_NAT64.h b/examples/flow_filtering/snippets/snippet_NAT64.h
new file mode 100644
index 0000000000..91631d9962
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_NAT64.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_NAT64_H
+#define SNIPPET_NAT64_H
+
+/* NAT64 Action Usage
+ * New steering entries will be created per flow rule, even if the action can be shared.
+ * It is recommended to use shared rules for NAT64 actions in some dedicated flow tables
+ * to reduce the duplication of entries.
+ * The default address and other fields conversion will be handled within the NAT64 action.
+ * To support another address, new rule(s) with modify fields on the IP address fields,
+ * should be created after the NAT64.
+ *
+ * The following fields should be handled automatically:
+ * Version
+ * Traffic Class / TOS
+ * Flow Label (0 in v4)
+ * Payload Length / Total length
+ * Next Header / Protocol
+ * Hop Limit / TTL
+ */
+
+#define MAX_PATTERN_NUM		2 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM		3 /* Maximal number of actions for this example. */
+
+void
+snippet_init_nat64(void);
+#define snippet_init snippet_init_nat64
+
+void
+snippet_match_nat64_create_actions(uint16_t port_id, struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_nat64_create_actions
+
+void
+snippet_match_nat64_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_nat64_create_patterns
+
+struct rte_flow_template_table *
+snippet_match_nat64_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_match_nat64_create_table
+
+
+#endif /* SNIPPET_NAT64_H */
diff --git a/examples/flow_filtering/snippets/snippet_match_integrity_flags.c b/examples/flow_filtering/snippets/snippet_match_integrity_flags.c
new file mode 100644
index 0000000000..0f05c902b9
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_integrity_flags.c
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "snippet_match_integrity_flags.h"
+
+void
+snippet_init_integrity_flags(void)
+{
+	init_default_snippet();
+}
+
+void
+snippet_match_integrity_flags_create_actions(__rte_unused uint16_t port_id,
+			struct rte_flow_action *action)
+{
+	/* Create one action that moves the packet to the selected queue. */
+	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
+	if (queue == NULL)
+		fprintf(stderr, "Failed to allocate memory for queue\n");
+
+	queue->index = 1;
+	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	action[0].conf = queue;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+void
+snippet_match_integrity_flags_create_patterns(struct rte_flow_item *pattern)
+{
+	struct rte_flow_item_ipv4 *ip_spec;
+	struct rte_flow_item_ipv4 *ip_mask;
+	struct rte_flow_item_integrity *integrity_spec;
+	struct rte_flow_item_integrity *integrity_mask;
+
+	integrity_spec = calloc(1, sizeof(struct rte_flow_item_integrity));
+	if (integrity_spec == NULL)
+		fprintf(stderr, "Failed to allocate memory for integrity_spec\n");
+
+	integrity_spec->level = 0;
+	integrity_spec->l3_ok = 1;
+	integrity_spec->ipv4_csum_ok = 1;
+
+	integrity_mask = calloc(1, sizeof(struct rte_flow_item_integrity));
+	if (integrity_mask == NULL)
+		fprintf(stderr, "Failed to allocate memory for integrity_mask\n");
+
+	integrity_mask->level = 0;
+	integrity_mask->l3_ok = 1;
+	integrity_mask->l4_ok = 0;
+	integrity_mask->ipv4_csum_ok = 1;
+
+	ip_spec = calloc(1, sizeof(struct rte_flow_item_ipv4));
+	if (ip_spec == NULL)
+		fprintf(stderr, "Failed to allocate memory for ip_spec\n");
+
+	ip_mask = calloc(1, sizeof(struct rte_flow_item_ipv4));
+	if (ip_mask == NULL)
+		fprintf(stderr, "Failed to allocate memory for ip_mask\n");
+
+	ip_spec->hdr.dst_addr = htonl(((192<<24) + (168<<16) + (1<<8) + 1));
+	ip_mask->hdr.dst_addr = 0xffffffff;
+	ip_spec->hdr.src_addr = htonl(((0<<24) + (0<<16) + (0<<8) + 0));
+	ip_mask->hdr.src_addr = 0x0;
+
+	/*
+	 * set the first level of the pattern (ETH).
+	 * since in this example we just want to get the
+	 * ipv4 we set this level to allow all.
+	 */
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+
+	/*
+	 * setting the second level of the pattern (IP).
+	 * in this example this is the level we care about
+	 * so we set it according to the parameters.
+	 */
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_IPV4;
+	pattern[1].spec = ip_spec;
+	pattern[1].mask = ip_mask;
+
+	/* check for a valid ipv4 packet. */
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_INTEGRITY;
+	pattern[2].spec = integrity_spec;
+	pattern[2].mask = integrity_mask;
+
+	/* the final level must be always type end */
+	pattern[3].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+struct rte_flow_template_table *
+snippet_match_integrity_flags_create_table(
+	__rte_unused uint16_t port_id,
+	__rte_unused struct rte_flow_error *error)
+{
+	return NULL;
+}
diff --git a/examples/flow_filtering/snippets/snippet_match_integrity_flags.h b/examples/flow_filtering/snippets/snippet_match_integrity_flags.h
new file mode 100644
index 0000000000..0e62084e0f
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_integrity_flags.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_MATCH_INTEGRITY_FLAGS_H
+#define SNIPPET_MATCH_INTEGRITY_FLAGS_H
+
+/*
+ * Steering by Integrity Check Flags
+ * Now steering can be performed by a new RTE flow item RTE_FLOW_ITEM_TYPE_INTEGRITY
+ * to enable matching on l3_ok, ipv4_csum_ok, l4_ok and l4_csum_ok.
+ *
+ * l3_ok (bit 2): If set, packet is matched to IPv4/IPv6, and the length of the data
+ * is not larger than the packet's length. For IPv4, protocol version is also verified.
+ * l4_ok (bit 3):
+ *      In case of UDP - the packet has a valid length. For bad UDP, the length field
+ *      is greater than the packet.
+ *      In case of TCP - a valid data offset value. For TCP the data offset value
+ *      is greater than the packet size.
+ * ipv4_csum_ok (bit 5): The IPv4 checksum is correct.
+ * l4_csum_ok (bit 6): The UDP/TCP checksum is correct.
+ *
+ * The item parameter `level' select between inner and outer parts:
+ *      0,1 - outer
+ *      Level > 2 - inner
+ */
+
+#define MAX_PATTERN_NUM     4 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM      2 /* Maximal number of actions for this example. */
+
+void
+snippet_init_integrity_flags(void);
+#define snippet_init snippet_init_integrity_flags
+
+void
+snippet_match_integrity_flags_create_actions(uint16_t port_id, struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_integrity_flags_create_actions
+
+void
+snippet_match_integrity_flags_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_integrity_flags_create_patterns
+
+struct rte_flow_template_table *
+snippet_match_integrity_flags_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_match_integrity_flags_create_table
+
+#endif /* SNIPPET_MATCH_INTEGRITY_FLAGS_H */
diff --git a/examples/flow_filtering/snippets/snippet_match_nvgre.c b/examples/flow_filtering/snippets/snippet_match_nvgre.c
new file mode 100644
index 0000000000..4ae06c5f1a
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_nvgre.c
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "../jump_flow.h"
+#include "snippet_match_nvgre.h"
+
+void
+snippet_init_nvgre(void)
+{
+	flow_attr.ingress = 1;
+	flow_attr.group = 1;
+}
+
+void
+snippet_match_nvgre_create_actions(uint16_t port_id, struct rte_flow_action *action)
+{
+	struct rte_flow_error error;
+	create_jump_flow(port_id, 1, &error);
+
+	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
+	if (queue == NULL)
+		fprintf(stderr, "Failed to allocate memory for queue\n");
+	queue->index = 1;
+
+	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	action[0].conf = queue;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+void
+snippet_match_nvgre_create_patterns(struct rte_flow_item *pattern)
+{
+	struct rte_flow_item_nvgre *nvgre = calloc(1, sizeof(struct rte_flow_item_nvgre));
+	if (nvgre == NULL)
+		fprintf(stderr, "Failed to allocate memory for nvgre\n");
+
+	struct rte_flow_item_udp *udp = calloc(1, sizeof(struct rte_flow_item_udp));
+	if (udp == NULL)
+		fprintf(stderr, "Failed to allocate memory for udp\n");
+
+	struct rte_flow_item_nvgre *nvgre_mask = calloc(1, sizeof(struct rte_flow_item_nvgre));
+	if (nvgre_mask == NULL)
+		fprintf(stderr, "Failed to allocate memory for nvgre_mask\n");
+
+	struct rte_flow_item_udp *udp_mask = calloc(1, sizeof(struct rte_flow_item_udp));
+	if (udp_mask == NULL)
+		fprintf(stderr, "Failed to allocate memory for udp_mask\n");
+
+	/* build rule to match specific NVGRE:
+	 * tni = 0x12346, flow_id = 0x78, inner_udp_src = 0x1234
+	 */
+	nvgre->tni[0] = 0x12;
+	nvgre->tni[1] = 0x34;
+	nvgre->tni[2] = 0x56;
+	nvgre->flow_id = 0x78;
+	udp->hdr.src_port = RTE_BE16(0x1234);
+
+	/* define nvgre and udp match mask for all bits */
+	nvgre_mask->tni[0] = 0xff;
+	nvgre_mask->tni[1] = 0xff;
+	nvgre_mask->tni[2] = 0xff;
+	nvgre_mask->flow_id = 0xff;
+	udp_mask->hdr.src_port = 0xffff;
+
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_IPV4;
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_NVGRE;
+	pattern[2].spec = nvgre;
+	pattern[2].mask = nvgre_mask;
+	pattern[3].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[4].type = RTE_FLOW_ITEM_TYPE_IPV4;
+	pattern[5].type = RTE_FLOW_ITEM_TYPE_UDP;
+	pattern[5].spec = udp;
+	pattern[5].mask = udp_mask;
+	pattern[6].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+static struct rte_flow_pattern_template *
+snippet_match_nvgre_create_pattern_template(uint16_t port_id, struct rte_flow_error *error)
+{
+	/* define nvgre and udp match mask for all bits */
+	struct rte_flow_item_nvgre nvgre_mask = {
+		.tni = {0xff, 0xff, 0xff},
+		.flow_id = 0xff,
+	};
+	struct rte_flow_item_udp udp_mask = {
+		.hdr.src_port = RTE_BE16(0xffff),
+	};
+
+	struct rte_flow_item pattern[MAX_PATTERN_NUM] = {{0}};
+
+	/* build the match pattern, match tni + flow_id + inner_udp_src */
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_IPV4;
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_NVGRE;
+	pattern[2].mask = &nvgre_mask;
+	pattern[3].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[4].type = RTE_FLOW_ITEM_TYPE_IPV4;
+	pattern[5].type = RTE_FLOW_ITEM_TYPE_UDP;
+	pattern[5].mask = &udp_mask;
+	pattern[6].type = RTE_FLOW_ITEM_TYPE_END;
+
+	const struct rte_flow_pattern_template_attr pt_attr = {
+		.relaxed_matching = 0,
+		.ingress = 1,
+	};
+
+	return rte_flow_pattern_template_create(port_id, &pt_attr, pattern, error);
+}
+
+static struct rte_flow_actions_template *
+snippet_match_nvgre_create_actions_template(uint16_t port_id, struct rte_flow_error *error)
+{
+	struct rte_flow_action_queue queue_v = {
+		.index = 1
+	};
+	struct rte_flow_action_queue queue_m = {
+		.index = UINT16_MAX
+	};
+	struct rte_flow_action actions[] = {
+		{
+			.type = RTE_FLOW_ACTION_TYPE_QUEUE,
+			.conf = &queue_v,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+	struct rte_flow_action masks[] = {
+		{
+			.type = RTE_FLOW_ACTION_TYPE_QUEUE,
+			.conf = &queue_m,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+	const struct rte_flow_actions_template_attr at_attr = {
+		.ingress = 1,
+	};
+
+	return rte_flow_actions_template_create(port_id, &at_attr, actions, masks, error);
+}
+
+struct rte_flow_template_table *
+snippet_match_nvgre_create_table(uint16_t port_id, struct rte_flow_error *error)
+{
+	struct rte_flow_pattern_template *pt;
+	struct rte_flow_actions_template *at;
+	const struct rte_flow_template_table_attr tbl_attr = {
+		.flow_attr = {
+			.group = 1,
+			.priority = 0,
+			.ingress = 1,
+		},
+		.nb_flows = 1,
+	};
+
+	pt = snippet_match_nvgre_create_pattern_template(port_id, error);
+	if (pt == NULL) {
+		printf("Failed to create pattern template: %s (%s)\n",
+		error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	at = snippet_match_nvgre_create_actions_template(port_id, error);
+	if (at == NULL) {
+		printf("Failed to create actions template: %s (%s)\n",
+		error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	return rte_flow_template_table_create(port_id, &tbl_attr, &pt, 1, &at, 1, error);
+}
diff --git a/examples/flow_filtering/snippets/snippet_match_nvgre.h b/examples/flow_filtering/snippets/snippet_match_nvgre.h
new file mode 100644
index 0000000000..2bf01ce5cd
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_nvgre.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_MATCH_NVGRE_H
+#define SNIPPET_MATCH_NVGRE_H
+
+/* NVGRE Matching
+ * PMD supports matching all NVGRE fields in HWS, including:
+ * _k_s_rsvd0_ver
+ * protocol
+ * tni
+ * flow_id
+ *
+ *  The following example shows how to build the arrays for pattern and rule
+ *  to match the NVGRE packets with tni + flow_id + inner udp_src:
+ *  ETH / IPV4 / NVGRE(TNI+FLOWID) / ETH / IPV4 / UDP(SRC).
+ */
+
+#define MAX_PATTERN_NUM		8 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM		2 /* Maximal number of actions for this example. */
+
+void
+snippet_init_nvgre(void);
+#define snippet_init snippet_init_nvgre
+
+void
+snippet_match_nvgre_create_actions(uint16_t port_id, struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_nvgre_create_actions
+
+void
+snippet_match_nvgre_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_nvgre_create_patterns
+
+struct rte_flow_template_table *
+snippet_match_nvgre_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_match_nvgre_create_table
+
+
+#endif /* SNIPPET_MATCH_NVGRE_H */
diff --git a/examples/flow_filtering/snippets/snippet_match_packet_type.c b/examples/flow_filtering/snippets/snippet_match_packet_type.c
new file mode 100644
index 0000000000..3b16d4b0ab
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_packet_type.c
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "snippet_match_packet_type.h"
+
+void
+snippet_init_packet_type(void)
+{
+	init_default_snippet();
+}
+
+void
+snippet_match_packet_type_create_actions(__rte_unused uint16_t port_id,
+				       struct rte_flow_action *action)
+{
+	/* Create one action that moves the packet to the selected queue. */
+	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
+	if (queue == NULL)
+		fprintf(stderr, "Failed to allocate memory for queue\n");
+
+	/*
+	 * create the action sequence.
+	 * one action only, move packet to queue
+	 */
+	queue->index = 1;
+	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	action[0].conf = queue;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+void
+snippet_match_packet_type_create_patterns(struct rte_flow_item *pattern)
+{
+	struct rte_flow_item_ptype *ptype_spec;
+	ptype_spec = calloc(1, sizeof(struct rte_flow_item_ptype));
+	if (ptype_spec == NULL)
+		fprintf(stderr, "Failed to allocate memory for ptype_spec\n");
+
+	ptype_spec->packet_type = RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP;
+
+	struct rte_flow_item_ptype *ptype_mask;
+	ptype_mask = calloc(1, sizeof(struct rte_flow_item_ptype));
+	if (ptype_mask == NULL)
+		fprintf(stderr, "Failed to allocate memory for ptype_mask\n");
+
+	ptype_mask->packet_type = RTE_PTYPE_L3_MASK | RTE_PTYPE_L4_MASK;
+
+	/* match on RTE_PTYPE_L4_TCP / RTE_PTYPE_L4_MASK */
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_PTYPE;
+	pattern[0].spec = ptype_spec;
+	pattern[0].mask = ptype_mask;
+
+	/* the final level must be always type end */
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+static struct rte_flow_pattern_template *
+snippet_match_packet_type_create_pattern_template(uint16_t port_id, struct rte_flow_error *error)
+{
+	struct rte_flow_item titems[MAX_PATTERN_NUM] = {0};
+	struct rte_flow_item_ptype ptype_mask = {0};
+
+	struct rte_flow_pattern_template_attr attr = {
+		.relaxed_matching = 1,
+		.ingress = 1
+	};
+
+	titems[0].type = RTE_FLOW_ITEM_TYPE_PTYPE;
+	ptype_mask.packet_type = RTE_PTYPE_L3_MASK | RTE_PTYPE_L4_MASK;
+	titems[0].mask = &ptype_mask;
+
+	titems[1].type = RTE_FLOW_ITEM_TYPE_END;
+
+	return rte_flow_pattern_template_create(port_id, &attr, titems, error);
+}
+
+static struct rte_flow_actions_template *
+snippet_match_packet_type_create_actions_template(uint16_t port_id, struct rte_flow_error *error)
+{
+	struct rte_flow_action tactions[MAX_ACTION_NUM] = {0};
+	struct rte_flow_action masks[MAX_ACTION_NUM] = {0};
+	struct rte_flow_actions_template_attr action_attr = {
+		.ingress = 1,
+	};
+
+	tactions[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	tactions[1].type = RTE_FLOW_ACTION_TYPE_END;
+
+	memcpy(masks, tactions, sizeof(masks));
+	return rte_flow_actions_template_create(port_id, &action_attr,
+						tactions, masks, error);
+}
+
+struct rte_flow_template_table *
+snippet_match_packet_type_create_table(uint16_t port_id, struct rte_flow_error *error)
+{
+	struct rte_flow_pattern_template *pt;
+	struct rte_flow_actions_template *at;
+
+	struct rte_flow_template_table_attr table_attr = {
+			.flow_attr = {
+				.group = 0,
+				.priority = 0,
+				.ingress = 1,
+		},
+			.nb_flows = 1,
+	};
+
+	pt = snippet_match_packet_type_create_pattern_template(port_id, error);
+	if (pt == NULL) {
+		printf("Failed to create pattern template: %s (%s)\n",
+		error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	at = snippet_match_packet_type_create_actions_template(port_id, error);
+	if (at == NULL) {
+		printf("Failed to create actions template: %s (%s)\n",
+		error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	return rte_flow_template_table_create(port_id, &table_attr, &pt, 1, &at, 1, error);
+}
diff --git a/examples/flow_filtering/snippets/snippet_match_packet_type.h b/examples/flow_filtering/snippets/snippet_match_packet_type.h
new file mode 100644
index 0000000000..150a838fd1
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_packet_type.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_MATCH_PACKET_TYPE_H
+#define SNIPPET_MATCH_PACKET_TYPE_H
+
+/*
+ * Match packet type
+ * The new RTE flow item RTE_FLOW_ITEM_TYPE_PTYPE provides a quick way of finding
+ * out L2/L3/L4 protocols in each packet.
+ * This helps with optimized flow rules matching, eliminating the need of stacking
+ * all the packet headers in the matching criteria.
+ *
+ * The supported values are:
+ *  L2: ``RTE_PTYPE_L2_ETHER``, ``RTE_PTYPE_L2_ETHER_VLAN``, ``RTE_PTYPE_L2_ETHER_QINQ``
+ *  L3: ``RTE_PTYPE_L3_IPV4``, ``RTE_PTYPE_L3_IPV6``
+ *  L4: ``RTE_PTYPE_L4_TCP``, ``RTE_PTYPE_L4_UDP``, ``RTE_PTYPE_L4_ICMP``
+ *  and their ``RTE_PTYPE_INNER_XXX`` counterparts as well as ``RTE_PTYPE_TUNNEL_ESP``.
+ *  Matching on both outer and inner IP fragmented is supported using
+ *  ``RTE_PTYPE_L4_FRAG`` and ``RTE_PTYPE_INNER_L4_FRAG`` values.
+ *  They are not part of L4 types, so they should be provided as a mask value
+ *  during pattern template creation explicitly.
+ */
+
+#define MAX_PATTERN_NUM     2 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM      2 /* Maximal number of actions for this example. */
+
+void
+snippet_init_packet_type(void);
+#define snippet_init snippet_init_packet_type
+
+void
+snippet_match_packet_type_create_actions(uint16_t port_id, struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_packet_type_create_actions
+
+void
+snippet_match_packet_type_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_packet_type_create_patterns
+
+struct rte_flow_template_table *
+snippet_match_packet_type_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_match_packet_type_create_table
+
+#endif /* SNIPPET_MATCH_PACKET_TYPE_H */
diff --git a/examples/flow_filtering/snippets/snippet_match_vxlan_gbp.c b/examples/flow_filtering/snippets/snippet_match_vxlan_gbp.c
new file mode 100644
index 0000000000..d57688e92a
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_vxlan_gbp.c
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "../jump_flow.h"
+#include "snippet_match_vxlan_gbp.h"
+
+void
+snippet_init_vxlan_gbp(void)
+{
+	flow_attr.ingress = 1;
+	flow_attr.group = 1;
+}
+
+void
+snippet_match_vxlan_gbp_create_actions(uint16_t port_id, struct rte_flow_action *action)
+{
+	struct rte_flow_error error;
+	create_jump_flow(port_id, 1, &error);
+
+	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
+	if (queue == NULL)
+		fprintf(stderr, "Failed to allocate memory for queue\n");
+
+	queue->index = 1;
+
+	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	action[0].conf = queue;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+void
+snippet_match_vxlan_gbp_create_patterns(struct rte_flow_item *pattern)
+{
+	struct rte_flow_item_vxlan *vxlan_gbp = calloc(1, sizeof(struct rte_flow_item_vxlan));
+	if (vxlan_gbp == NULL)
+		fprintf(stderr, "Failed to allocate memory for vxlan_gbp\n");
+
+	struct rte_flow_item_vxlan *vxlan_gbp_mask = calloc(1, sizeof(struct rte_flow_item_vxlan));
+	if (vxlan_gbp_mask == NULL)
+		fprintf(stderr, "Failed to allocate memory for vxlan_gbp_mask\n");
+
+	uint8_t vni[] = {0x00, 0x00, 0x00};
+	uint16_t group_policy_id = 0x200;
+
+	memcpy(vxlan_gbp_mask->hdr.vni, "\xff\xff\xff", 3);
+	vxlan_gbp_mask->hdr.flags = 0xff;
+	vxlan_gbp_mask->hdr.policy_id = 0xffff;
+
+	vxlan_gbp->flags = 0x88;
+	memcpy(vxlan_gbp->vni, vni, 3);
+	vxlan_gbp->hdr.rsvd0[1] = (group_policy_id >> 8) & 0xff;
+	vxlan_gbp->hdr.rsvd0[2] = group_policy_id & 0xff;
+
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_IPV4;
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_UDP;
+	pattern[3].type = RTE_FLOW_ITEM_TYPE_VXLAN;
+	pattern[3].spec = vxlan_gbp;
+	pattern[3].mask = vxlan_gbp_mask;
+	pattern[4].type = RTE_FLOW_ITEM_TYPE_END;
+
+}
+
+static struct rte_flow_pattern_template *
+snippet_match_vxlan_gbp_create_pattern_template(uint16_t port_id,
+	struct rte_flow_error *error)
+{
+	struct rte_flow_item pattern[MAX_PATTERN_NUM] = {0};
+
+	struct rte_flow_item_vxlan vxlan_gbp_mask = {
+		.hdr.vni = "\xff\xff\xff", /* Trying to match VNI as well. */
+		.hdr.flags = 0xff,
+		.hdr.policy_id = 0xffff,
+	};
+
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_IPV4;
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_UDP;
+	pattern[3].type = RTE_FLOW_ITEM_TYPE_VXLAN;
+	pattern[3].mask = &vxlan_gbp_mask;
+	pattern[4].type = RTE_FLOW_ITEM_TYPE_END;
+
+	const struct rte_flow_pattern_template_attr pt_attr = {
+		.relaxed_matching = 0,
+		.ingress = 1,
+	};
+
+	return rte_flow_pattern_template_create(port_id, &pt_attr, pattern, error);
+}
+
+static struct rte_flow_actions_template *
+snippet_match_vxlan_gbp_create_actions_template(uint16_t port_id,
+	struct rte_flow_error *error)
+{
+	struct rte_flow_action action[MAX_ACTION_NUM] = {0};
+	struct rte_flow_action masks[MAX_ACTION_NUM] = {0};
+
+	struct rte_flow_action_queue queue_v = {
+		.index = 1,
+	};
+	struct rte_flow_action_queue queue_m = {
+		.index = UINT16_MAX,
+	};
+
+	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	action[0].conf = &queue_v;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+
+	masks[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	masks[0].conf = &queue_m;
+	masks[1].type = RTE_FLOW_ACTION_TYPE_END;
+
+	const struct rte_flow_actions_template_attr at_attr = {
+		.ingress = 1,
+	};
+
+	return rte_flow_actions_template_create(port_id, &at_attr, action, masks, error);
+}
+
+struct rte_flow_template_table *
+snippet_match_vxlan_gbp_create_table(uint16_t port_id, struct rte_flow_error *error)
+{
+	struct rte_flow_pattern_template *pt;
+	struct rte_flow_actions_template *at;
+	const struct rte_flow_template_table_attr tbl_attr = {
+		.flow_attr = {
+			.group = 1,
+			.priority = 0,
+			.ingress = 1,
+		},
+		.nb_flows = 1000,
+	};
+
+	pt = snippet_match_vxlan_gbp_create_pattern_template(port_id, error);
+	if (pt == NULL) {
+		printf("Failed to create pattern template: %s (%s)\n",
+		error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	at = snippet_match_vxlan_gbp_create_actions_template(port_id, error);
+	if (at == NULL) {
+		printf("Failed to create actions template: %s (%s)\n",
+		error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	return rte_flow_template_table_create(port_id, &tbl_attr, &pt, 1, &at, 1, error);
+}
diff --git a/examples/flow_filtering/snippets/snippet_match_vxlan_gbp.h b/examples/flow_filtering/snippets/snippet_match_vxlan_gbp.h
new file mode 100644
index 0000000000..a50674b746
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_vxlan_gbp.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_MATCH_VXLAN_GBP_H
+#define SNIPPET_MATCH_VXLAN_GBP_H
+
+/* VXLAN-GBP Header Fields Matching
+ * Added support of matching VXLAN-GBP header fields in the PMD,
+ * such as VNI and flags (first 8 bits), group policy ID and reserved field 0.
+ */
+
+#define MAX_PATTERN_NUM		5 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM		2 /* Maximal number of actions for this example. */
+
+void
+snippet_init_vxlan_gbp(void);
+#define snippet_init snippet_init_vxlan_gbp
+
+void
+snippet_match_vxlan_gbp_create_actions(uint16_t port_id, struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_vxlan_gbp_create_actions
+
+void
+snippet_match_vxlan_gbp_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_vxlan_gbp_create_patterns
+
+struct rte_flow_template_table *
+snippet_match_vxlan_gbp_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_match_vxlan_gbp_create_table
+
+
+#endif /* SNIPPET_MATCH_VXLAN_GBP_H */
diff --git a/examples/flow_filtering/snippets/snippet_match_vxlan_gpe.c b/examples/flow_filtering/snippets/snippet_match_vxlan_gpe.c
new file mode 100644
index 0000000000..efe5138c06
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_vxlan_gpe.c
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "../jump_flow.h"
+#include "snippet_match_vxlan_gpe.h"
+
+void
+snippet_init_vxlan_gpe(void)
+{
+	flow_attr.ingress = 1;
+	flow_attr.group = 1;
+}
+
+void
+snippet_match_vxlan_gpe_create_actions(uint16_t port_id, struct rte_flow_action *action)
+{
+	struct rte_flow_error error;
+	create_jump_flow(port_id, 1, &error);
+
+	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
+	if (queue == NULL)
+		fprintf(stderr, "Failed to allocate memory for queue\n");
+	queue->index = 1;
+
+	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	action[0].conf = queue;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+void
+snippet_match_vxlan_gpe_create_patterns(struct rte_flow_item *pattern)
+{
+	struct rte_flow_item_vxlan_gpe *vxlan_gpe_mask = calloc(1,
+		sizeof(struct rte_flow_item_vxlan_gpe));
+	if (vxlan_gpe_mask == NULL)
+		fprintf(stderr, "Failed to allocate memory for vxlan_gpe_mask\n");
+	memset(vxlan_gpe_mask->hdr.vni, 0xff, 3);
+
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_IPV4;
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_UDP;
+	pattern[3].type = RTE_FLOW_ITEM_TYPE_VXLAN_GPE;
+	pattern[3].spec = vxlan_gpe_mask;
+	pattern[4].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+static struct rte_flow_pattern_template *
+snippet_match_vxlan_gpe_create_pattern_template(uint16_t port_id,
+	struct rte_flow_error *error)
+{
+	struct rte_flow_item_vxlan_gpe vxlan_gpe_mask = {
+		.hdr.vni = "\xff\xff\xff",
+	};
+	struct rte_flow_item pattern[] = {
+		{
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+		},
+		{
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+		},
+		{
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+		},
+		{
+			.type = RTE_FLOW_ITEM_TYPE_VXLAN_GPE,
+			.mask = &vxlan_gpe_mask,
+		},
+		{
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	};
+	const struct rte_flow_pattern_template_attr pt_attr = {
+		.relaxed_matching = 0,
+		.ingress = 1,
+	};
+
+	return rte_flow_pattern_template_create(port_id, &pt_attr, pattern, error);
+}
+
+static struct rte_flow_actions_template *
+snippet_match_vxlan_gpe_create_actions_template(uint16_t port_id,
+	struct rte_flow_error *error)
+{
+	struct rte_flow_action_queue queue_v = {
+		.index = 1
+	};
+	struct rte_flow_action_queue queue_m = {
+		.index = UINT16_MAX
+	};
+	struct rte_flow_action actions[] = {
+		{
+			.type = RTE_FLOW_ACTION_TYPE_QUEUE,
+			.conf = &queue_v,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+	struct rte_flow_action masks[] = {
+		{
+			.type = RTE_FLOW_ACTION_TYPE_QUEUE,
+			.conf = &queue_m,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+	const struct rte_flow_actions_template_attr at_attr = {
+		.ingress = 1,
+	};
+
+	return rte_flow_actions_template_create(port_id, &at_attr, actions, masks, error);
+}
+
+struct rte_flow_template_table *
+snippet_match_vxlan_gpe_create_table(uint16_t port_id, struct rte_flow_error *error)
+{
+	struct rte_flow_pattern_template *pt;
+	struct rte_flow_actions_template *at;
+	const struct rte_flow_template_table_attr tbl_attr = {
+		.flow_attr = {
+			.group = 1,
+			.priority = 0,
+			.ingress = 1,
+		},
+		.nb_flows = 1000,
+	};
+
+	pt = snippet_match_vxlan_gpe_create_pattern_template(port_id, error);
+	if (pt == NULL) {
+		printf("Failed to create pattern template: %s (%s)\n",
+		error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	at = snippet_match_vxlan_gpe_create_actions_template(port_id, error);
+	if (at == NULL) {
+		printf("Failed to create actions template: %s (%s)\n",
+		error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	return rte_flow_template_table_create(port_id, &tbl_attr, &pt, 1, &at, 1, error);
+}
diff --git a/examples/flow_filtering/snippets/snippet_match_vxlan_gpe.h b/examples/flow_filtering/snippets/snippet_match_vxlan_gpe.h
new file mode 100644
index 0000000000..63c5f3b61b
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_vxlan_gpe.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_MATCH_VXLAN_GPE_H
+#define SNIPPET_MATCH_VXLAN_GPE_H
+
+#include <rte_flow.h>
+
+/* VXLAN-GPE Header Fields Matching */
+
+#define MAX_PATTERN_NUM		5 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM		2 /* Maximal number of actions for this example. */
+
+void
+snippet_init_vxlan_gpe(void);
+#define snippet_init snippet_init_vxlan_gpe
+
+void
+snippet_match_vxlan_gpe_create_actions(uint16_t port_id, struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_vxlan_gpe_create_actions
+
+void
+snippet_match_vxlan_gpe_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_vxlan_gpe_create_patterns
+
+struct rte_flow_template_table *
+snippet_match_vxlan_gpe_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_match_vxlan_gpe_create_table
+
+
+#endif /* SNIPPET_MATCH_VXLAN_GPE_H */
diff --git a/examples/flow_filtering/snippets/snippet_modify_ecn.c b/examples/flow_filtering/snippets/snippet_modify_ecn.c
new file mode 100644
index 0000000000..74bc708036
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_modify_ecn.c
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "snippet_modify_ecn.h"
+
+void
+snippet_init_modify_ecn(void)
+{
+	flow_attr.ingress = 1;
+	flow_attr.group = 1;
+	flow_attr.priority = 1;
+}
+
+void
+snippet_match_modify_ecn_create_actions(__rte_unused uint16_t port_id,
+				      struct rte_flow_action *action)
+{
+	/* Create one action that moves the packet to the selected queue. */
+	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
+	if (queue == NULL)
+		fprintf(stderr, "Failed to allocate memory for queue\n");
+
+	struct rte_flow_action_modify_field *modify_field =
+					calloc(1, sizeof(struct rte_flow_action_modify_field));
+	if (modify_field == NULL)
+		fprintf(stderr, "Failed to allocate memory for modify_field\n");
+
+	queue->index = 1;
+	modify_field->operation = RTE_FLOW_MODIFY_SET;
+	modify_field->dst.field = RTE_FLOW_FIELD_IPV4_ECN;
+	modify_field->src.field = RTE_FLOW_FIELD_VALUE;
+	modify_field->src.value[0] = 3;
+	modify_field->width = 2;
+
+	action[0].type = RTE_FLOW_ACTION_TYPE_MODIFY_FIELD;
+	action[0].conf = modify_field;
+	action[1].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	action[1].conf = queue;
+	action[2].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+void
+snippet_match_modify_ecn_create_patterns(struct rte_flow_item *pattern)
+{
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_IPV4;
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+struct rte_flow_template_table *
+snippet_match_modify_ecn_create_table(__rte_unused uint16_t port_id,
+							__rte_unused struct rte_flow_error *error)
+{
+	return NULL;
+}
diff --git a/examples/flow_filtering/snippets/snippet_modify_ecn.h b/examples/flow_filtering/snippets/snippet_modify_ecn.h
new file mode 100644
index 0000000000..e2a78adea2
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_modify_ecn.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_MODIFY_ECN_H
+#define SNIPPET_MODIFY_ECN_H
+
+/* ECN in IP Header Modification
+ * ECN field in the IPv4/IPv6 header can now be modified using the modify field action
+ * which now can be modified in the meter policy.
+ */
+
+#define MAX_PATTERN_NUM     3 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM      3 /* Maximal number of actions for this example. */
+
+void
+snippet_init_modify_ecn(void);
+#define snippet_init snippet_init_modify_ecn
+
+void
+snippet_match_modify_ecn_create_actions(uint16_t port_id, struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_modify_ecn_create_actions
+
+void
+snippet_match_modify_ecn_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_modify_ecn_create_patterns
+
+struct rte_flow_template_table *
+snippet_match_modify_ecn_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_match_modify_ecn_create_table
+
+#endif /* SNIPPET_MODIFY_ECN_H */
diff --git a/examples/flow_filtering/snippets/snippet_random_match.c b/examples/flow_filtering/snippets/snippet_random_match.c
new file mode 100644
index 0000000000..e5b8e65f6b
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_random_match.c
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "snippet_random_match.h"
+
+
+static void
+snippet_init_random_match(void)
+{
+	init_default_snippet();
+}
+
+static void
+snippet_match_random_value_create_actions(__rte_unused uint16_t port_id,
+					struct rte_flow_action *action)
+{
+	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
+	if (queue == NULL)
+		fprintf(stderr, "Failed to allocate memory for queue\n");
+	queue->index = UINT16_MAX; /* The selected target queue.*/
+	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	action[0].conf = queue;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+static void
+snippet_match_random_value_create_patterns(struct rte_flow_item *pattern)
+{
+	struct rte_flow_item_random *random_item;
+	random_item = calloc(1, sizeof(struct rte_flow_item_random));
+	if (random_item == NULL)
+		fprintf(stderr, "Failed to allocate memory for port_representor_spec\n");
+
+	random_item->value = 0;
+
+	/* Set the patterns. */
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_RANDOM;
+	pattern[0].spec = random_item;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_ETH;
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+static struct rte_flow_pattern_template *
+snippet_match_random_value_create_pattern_template(uint16_t port_id, struct rte_flow_error *error)
+{
+
+	struct rte_flow_item_random random_item = {
+		.value = 0x3,
+	};
+
+	/* Define the flow pattern template. */
+	struct rte_flow_item pattern[] = {
+		{
+			.type = RTE_FLOW_ITEM_TYPE_RANDOM,
+			.mask = &random_item,
+		},
+		{
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+		},
+		{
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	};
+
+	/* Set the pattern template attributes */
+	const struct rte_flow_pattern_template_attr pt_attr = {
+		.relaxed_matching = 0,
+		.ingress = 1,
+	};
+
+	return rte_flow_pattern_template_create(port_id, &pt_attr, pattern, error);
+}
+
+static struct rte_flow_actions_template *
+snippet_match_random_value_create_actions_template(__rte_unused uint16_t port_id,
+						 struct rte_flow_error *error)
+{
+	struct rte_flow_action_queue queue_v = {
+		.index = 0
+	};
+
+	struct rte_flow_action_queue queue_m = {
+		.index = UINT16_MAX
+	};
+
+	/* Define the actions template. */
+	struct rte_flow_action actions[] = {
+		{
+			.type = RTE_FLOW_ACTION_TYPE_QUEUE,
+			.conf = &queue_v,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+
+	/* Define the actions template masks. */
+	struct rte_flow_action masks[] = {
+		{
+			.type = RTE_FLOW_ACTION_TYPE_QUEUE,
+			.conf = &queue_m,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+
+	const struct rte_flow_actions_template_attr at_attr = {
+		.ingress = 1,
+	};
+
+	return rte_flow_actions_template_create(port_id, &at_attr, actions, masks, error);
+}
+
+static struct rte_flow_template_table *
+snippet_match_random_value_create_table(uint16_t port_id, struct rte_flow_error *error)
+{
+	struct rte_flow_pattern_template *pt;
+	struct rte_flow_actions_template *at;
+
+	/* Define the template table attributes. */
+	const struct rte_flow_template_table_attr tbl_attr = {
+		.flow_attr = {
+			.group = 1,
+			.priority = 0,
+			.ingress = 1,
+		},
+
+		/* set the maximum number of flow rules that this table holds. */
+		.nb_flows = 1,
+	};
+
+	/* Create the pattern template. */
+	pt = snippet_match_random_value_create_pattern_template(port_id, error);
+	if (pt == NULL) {
+		printf("Failed to create pattern template: %s (%s)\n",
+				error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	/* Create the actions template. */
+	at = snippet_match_random_value_create_actions_template(port_id, error);
+	if (at == NULL) {
+		printf("Failed to create actions template: %s (%s)\n",
+				error->message, rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	/* Create the template table. */
+	return rte_flow_template_table_create(port_id, &tbl_attr, &pt, 1, &at, 1, error);
+}
+
diff --git a/examples/flow_filtering/snippets/snippet_random_match.h b/examples/flow_filtering/snippets/snippet_random_match.h
new file mode 100644
index 0000000000..1c6bb42577
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_random_match.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_RANDOM_MATCH_H
+#define SNIPPET_RANDOM_MATCH_H
+
+
+/* Random Match
+ * Add support for random matching 16 bits in template async API.
+ * This value is not based on the packet data/headers.
+ * Application shouldn't assume that this value is kept during the lifetime of the packet.
+ */
+
+#define MAX_PATTERN_NUM     3 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM      2 /* Maximal number of actions for this example. */
+
+static void
+snippet_init_random_match(void);
+#define snippet_init snippet_init_random_match
+
+static void
+snippet_match_random_create_actions(uint16_t port_id, struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_random_create_actions
+
+static void
+snippet_match_random_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_random_create_patterns
+
+static struct rte_flow_template_table *
+snippet_match_random_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_match_random_create_table
+#endif /* SNIPPET_RANDOM_MATCH_H */
-- 
2.34.1

