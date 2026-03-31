Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C700B109B461
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 12:54:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02C7F4042F;
	Tue, 31 Mar 2026 14:54:23 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010004.outbound.protection.outlook.com
 [40.93.198.4]) by mails.dpdk.org (Postfix) with ESMTP id 8FD65402C3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 14:54:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkFd9XWH7Z1+6Vz4XxYbInHGxHkvzDRMSpzU1er7kjfuOA08OWhpmgA/IWpMaxtHUO2ABfnXmZMkcR3UCF7kHXzOOZABqJfmVXGBtRa9XeKWk9WtahPiiQ6YPETWCu/plmEYeL3o1Bdc/koUiMg5m/Ce8DFJMFJJCA7L561S+OGeomkOaoeYs06OfNsevVKn3z5ZiJdnZPDE8F7oeVXMzDX/JgWTvJeytBiFZ+Jmn99YQQRMmSs65N1tyb4/TzS+V7GhY8RKFZoesWg1EGasIiDV3veLHbqR/pmW+hbF2XcDUqLy51xrHDbl2jirKnLtuav0vQcGzxZ2KqH1V7vGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyHa5fhbfFkuQkCWhTWn3WPGnhA8ovhEAB8FyBhx5u0=;
 b=JyYKTzE20VfU8fXMTgCFFB+b2uM73WkEDGoH0Vc5CbkjZNacqqG5bOZfjqe6PXQyVF/pExVCNFERo0K8+sw+17PX61a4hGo69ph3E325el1tGXqdmO7WU9wGHM9HLLPj9NOfsGgb4fLh1PnWA8RJOFTeWS1Up7nJpFtmyYJ7GaXQh3y5UUgnLaRTqu8EGzvvj+AslmTlkSGkcN994Wq1XVIhkhWjJu/joOEw9R2kHnpBRpIx5MWI/Rg36DdsDvYczleqtnbM6WcyjouT8GRzehjt8mIPtP0fUWIiBLlQD4cl/6wLp59xvbxx1/YEFJnekGQn3ITXqW3h7iqBrEc/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyHa5fhbfFkuQkCWhTWn3WPGnhA8ovhEAB8FyBhx5u0=;
 b=ms2vCt9TZEy+dR9UzSgEzA8Ly7Xeq0VTEXSvGwwavMnpbJCAxCE64eMXcQqm+32jGw2+jPCt4apNAlv1JcB+SOXDNLbFrMJaQVzEvcU9jO3Ge+uY4G0DRKTin09qUqKUuNmfaz2f0avg+uf81f+WOpLp0KZoW824Q+jz9Oo66hs5FFXoCambDgBWh51sD9Ty0zbd4mPExoU05VMxPhJBogmmr6jY8dLbbQBYRREpCbvMmDmuGm8XB1Mm8WNYWzZITcm8HiQwIFZH43pZ9/0bBWVtOYk2iTgwH+uSJpBTH2M5C+S5Zu/E8NFPs4vmSrTFoLNVqgzgqq0EvIK4x9uNkA==
Received: from BL1PR13CA0285.namprd13.prod.outlook.com (2603:10b6:208:2bc::20)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 12:54:11 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::22) by BL1PR13CA0285.outlook.office365.com
 (2603:10b6:208:2bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 12:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 12:54:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 05:53:52 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 05:53:52 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 05:53:50 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, Shani Peretz <shperetz@nvidia.com>, Ori Kam
 <orika@nvidia.com>
Subject: [PATCH] examples/flow_filtering: fix null derefs and memory leaks
Date: Tue, 31 Mar 2026 15:53:47 +0300
Message-ID: <20260331125347.346362-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0da0a7-2eb4-4a1c-65f7-08de8f249b14
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: AFJcKa1xCF95ULOFH8Ro1V4h/L74AeeLmvsW5WPPE7R0uI1WPCK/9s88Z/kmnVfERB4XTIrRYjFc1ndBnNzoGInroidK7e2qUl/9zNVUcLTsrzPwbyJVyOO2nVdEmx/Un0MmF+0w/8yumfYZ8AUpb7fTJk25MW83AklOxDUmUqDnIrRq1DDdaoFh+6N8eNh3zpIXtvksR8jAdMMxmSn0fP2DEfnM6EWniUJAaUXixuNTQDFpslYsS08XyYBzjxqzYfFpcROFAXYAG87MYpyTlGItn9qI2NsJgfoXENzNtu5WHMLTS8poWlq+IpOHWeXWvVG+7GfeFhm8Sbm1yrdjFXU4UaCxnR72MsWmmFMAhXhUXFfhbJK18FWLzhh03w71gHxJFmnqo7k0fQ7M4MYtYUXto7mi3UDVG22giO0SAcP7ci8SSlunt8m1Pk4Db5d7LxaccYn4CPfz6G4lrFvNuTkRhIV+2QFsWuO9/0Buls0v73NDEVXnaOF5opyQ3PSO7tf/9c1FimbdbUfcnYCKk7/n+JqhDqolAizklykaj2ChkgxnHtZF/yj6HDLH8ewKCltATo/oX+1AJzEaZpI8vpQd5qXS2nS6+hr4i3CuIbtMHxA/WePR43sB+8ix5OCqaSwSog3zOWSRZSEzrBs8f74bmfDMWCBKVva5SesX9odCKchY8viCus0UQh0Zv5FKtXTzuJ+vl4gxi3zy2HvTZj/fOS7VEifFs0j5aCfzqrp4O5mzQuszNa2gmTzW0TD0Wy16t9KGRZmOa033I+H60Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xJH8x/VNxO1Z5N+GqRwBSl3KgogHQlpIun3ZZZnbemS4QhsNCNCV8TLzNfoWQjoIa6DyppVV1WEiE4wf++IKWT5a3JRJArCRfT4P45izqOrzX5ZZK3MRmvKiRKtwcvsw11is9fl8Uq+/QC+wctIkCcc30MDel5xZxf0jAeBDtxjX6yCwAiCiXE+4MApTs+3jKvggaon0fDv+DZ1nav0A7orubbnlBrvd1esdGKDVBoTTe5IsUQ+YOnja4eyEHsCP2+MUt6dQWR5+vgSV7fPseOUoOEDULwy/le/xol5lE+IbErPGFYsJBKZetgD1yQ94LiJJWmp/1Rnn2Hn6tz397MHVlhKlal6tL9Wp+aCLrtqaiCBt9wQXOcrEcKDlrZfbc1P8mKv9IB5vDLfjKZ2ekCBQ8SsJJRDN/ZKP/rPRBX3D09oGT02pnwcS/8UkRcgS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:54:11.4732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0da0a7-2eb4-4a1c-65f7-08de8f249b14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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

Add missing return statements after failed calloc NULL checks to
prevent null pointer dereferences.

Free previously allocated memory on error paths to prevent
leaked storage when a subsequent allocation fails.

Fixes: 3ebb8789136a ("examples/flow_filtering: add more snippets")

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 .../snippets/snippet_match_gre.c              | 13 +++++++---
 .../snippets/snippet_match_integrity_flags.c  | 26 +++++++++++++++----
 .../snippets/snippet_match_ipv4.c             | 13 +++++++---
 .../snippets/snippet_match_mpls.c             |  8 ++++--
 .../snippets/snippet_match_nsh.c              | 13 +++++++---
 .../snippets/snippet_match_nvgre.c            | 26 +++++++++++++++----
 .../snippets/snippet_match_packet_type.c      | 13 +++++++---
 .../snippets/snippet_match_port_affinity.c    |  1 +
 .../snippets/snippet_match_roce_ib_bth.c      |  8 ++++--
 .../snippets/snippet_match_vxlan_gbp.c        | 13 +++++++---
 .../snippets/snippet_match_vxlan_gpe.c        |  8 ++++--
 .../snippets/snippet_modify_ecn.c             |  9 +++++--
 .../flow_filtering/snippets/snippet_nat64.c   | 10 +++++++
 .../snippets/snippet_random_match.c           |  8 ++++--
 .../snippets/snippet_switch_granularity.c     |  4 ++-
 15 files changed, 137 insertions(+), 36 deletions(-)

diff --git a/examples/flow_filtering/snippets/snippet_match_gre.c b/examples/flow_filtering/snippets/snippet_match_gre.c
index 477ec59451..f1638f38c5 100644
--- a/examples/flow_filtering/snippets/snippet_match_gre.c
+++ b/examples/flow_filtering/snippets/snippet_match_gre.c
@@ -21,8 +21,10 @@ snippet_match_gre_create_actions(__rte_unused uint16_t port_id, struct rte_flow_
 {
 	/* Create one action that moves the packet to the selected queue. */
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
-	if (queue == NULL)
+	if (queue == NULL) {
 		fprintf(stderr, "Failed to allocate memory for queue\n");
+		return;
+	}
 
 	/* Set the selected queue. */
 	queue->index = 1;
@@ -40,12 +42,17 @@ snippet_match_gre_create_patterns(struct rte_flow_item *pattern)
 	struct rte_flow_item_gre_opt *gre_opt_spec;
 
 	gre_spec = calloc(1, sizeof(struct rte_flow_item_gre));
-	if (gre_spec == NULL)
+	if (gre_spec == NULL) {
 		fprintf(stderr, "Failed to allocate memory for gre_spec\n");
+		return;
+	}
 
 	gre_opt_spec = calloc(1, sizeof(struct rte_flow_item_gre_opt));
-	if (gre_opt_spec == NULL)
+	if (gre_opt_spec == NULL) {
 		fprintf(stderr, "Failed to allocate memory for gre_opt_spec\n");
+		free(gre_spec);
+		return;
+	}
 
 	/* Set the Checksum GRE option. */
 	gre_spec->c_rsvd0_ver = RTE_BE16(0x8000);
diff --git a/examples/flow_filtering/snippets/snippet_match_integrity_flags.c b/examples/flow_filtering/snippets/snippet_match_integrity_flags.c
index 0f05c902b9..3d37b5f2a5 100644
--- a/examples/flow_filtering/snippets/snippet_match_integrity_flags.c
+++ b/examples/flow_filtering/snippets/snippet_match_integrity_flags.c
@@ -20,8 +20,10 @@ snippet_match_integrity_flags_create_actions(__rte_unused uint16_t port_id,
 {
 	/* Create one action that moves the packet to the selected queue. */
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
-	if (queue == NULL)
+	if (queue == NULL) {
 		fprintf(stderr, "Failed to allocate memory for queue\n");
+		return;
+	}
 
 	queue->index = 1;
 	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
@@ -38,16 +40,21 @@ snippet_match_integrity_flags_create_patterns(struct rte_flow_item *pattern)
 	struct rte_flow_item_integrity *integrity_mask;
 
 	integrity_spec = calloc(1, sizeof(struct rte_flow_item_integrity));
-	if (integrity_spec == NULL)
+	if (integrity_spec == NULL) {
 		fprintf(stderr, "Failed to allocate memory for integrity_spec\n");
+		return;
+	}
 
 	integrity_spec->level = 0;
 	integrity_spec->l3_ok = 1;
 	integrity_spec->ipv4_csum_ok = 1;
 
 	integrity_mask = calloc(1, sizeof(struct rte_flow_item_integrity));
-	if (integrity_mask == NULL)
+	if (integrity_mask == NULL) {
 		fprintf(stderr, "Failed to allocate memory for integrity_mask\n");
+		free(integrity_spec);
+		return;
+	}
 
 	integrity_mask->level = 0;
 	integrity_mask->l3_ok = 1;
@@ -55,12 +62,21 @@ snippet_match_integrity_flags_create_patterns(struct rte_flow_item *pattern)
 	integrity_mask->ipv4_csum_ok = 1;
 
 	ip_spec = calloc(1, sizeof(struct rte_flow_item_ipv4));
-	if (ip_spec == NULL)
+	if (ip_spec == NULL) {
 		fprintf(stderr, "Failed to allocate memory for ip_spec\n");
+		free(integrity_spec);
+		free(integrity_mask);
+		return;
+	}
 
 	ip_mask = calloc(1, sizeof(struct rte_flow_item_ipv4));
-	if (ip_mask == NULL)
+	if (ip_mask == NULL) {
 		fprintf(stderr, "Failed to allocate memory for ip_mask\n");
+		free(integrity_spec);
+		free(integrity_mask);
+		free(ip_spec);
+		return;
+	}
 
 	ip_spec->hdr.dst_addr = htonl(((192<<24) + (168<<16) + (1<<8) + 1));
 	ip_mask->hdr.dst_addr = 0xffffffff;
diff --git a/examples/flow_filtering/snippets/snippet_match_ipv4.c b/examples/flow_filtering/snippets/snippet_match_ipv4.c
index 7f8aba66bb..6fcaacdc42 100644
--- a/examples/flow_filtering/snippets/snippet_match_ipv4.c
+++ b/examples/flow_filtering/snippets/snippet_match_ipv4.c
@@ -24,8 +24,10 @@ snippet_ipv4_flow_create_actions(__rte_unused uint16_t port_id, struct rte_flow_
 	 * one action only, move packet to queue
 	 */
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
-	if (queue == NULL)
+	if (queue == NULL) {
 		fprintf(stderr, "Failed to allocate memory for queue\n");
+		return;
+	}
 	queue->index = 1; /* The selected target queue.*/
 	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
 	action[0].conf = queue;
@@ -53,12 +55,17 @@ snippet_ipv4_flow_create_patterns(struct rte_flow_item *patterns)
 	patterns[1].type = RTE_FLOW_ITEM_TYPE_IPV4;
 
 	ip_spec = calloc(1, sizeof(struct rte_flow_item_ipv4));
-	if (ip_spec == NULL)
+	if (ip_spec == NULL) {
 		fprintf(stderr, "Failed to allocate memory for ip_spec\n");
+		return;
+	}
 
 	ip_mask = calloc(1, sizeof(struct rte_flow_item_ipv4));
-	if (ip_mask == NULL)
+	if (ip_mask == NULL) {
 		fprintf(stderr, "Failed to allocate memory for ip_mask\n");
+		free(ip_spec);
+		return;
+	}
 
 	/* Match destination IP 192.168.1.1 with full mask */
 	ip_spec->hdr.dst_addr = htonl(((192<<24) + (168<<16) + (1<<8) + 1));
diff --git a/examples/flow_filtering/snippets/snippet_match_mpls.c b/examples/flow_filtering/snippets/snippet_match_mpls.c
index 494a2d873d..0a54586c98 100644
--- a/examples/flow_filtering/snippets/snippet_match_mpls.c
+++ b/examples/flow_filtering/snippets/snippet_match_mpls.c
@@ -25,8 +25,10 @@ snippet_mpls_create_actions(__rte_unused uint16_t port_id, struct rte_flow_actio
 	struct rte_flow_action_queue *queue;
 
 	queue = calloc(1, sizeof(struct rte_flow_item_ipv4));
-	if (queue == NULL)
+	if (queue == NULL) {
 		fprintf(stderr, "Failed to allocate memory for queue\n");
+		return;
+	}
 
 	/* Set the selected queue. */
 	queue->index = UINT16_MAX;
@@ -43,8 +45,10 @@ snippet_mpls_create_patterns(struct rte_flow_item *pattern)
 	struct rte_flow_item_mpls *mpls_item;
 
 	mpls_item = calloc(1, sizeof(struct rte_flow_item_ipv4));
-	if (mpls_item == NULL)
+	if (mpls_item == NULL) {
 		fprintf(stderr, "Failed to allocate memory for mpls_item\n");
+		return;
+	}
 
 	memcpy(mpls_item->label_tc_s, "\xab\xcd\xe1", sizeof(mpls_item->label_tc_s));
 
diff --git a/examples/flow_filtering/snippets/snippet_match_nsh.c b/examples/flow_filtering/snippets/snippet_match_nsh.c
index 262d0c8d81..6a8ac5b942 100644
--- a/examples/flow_filtering/snippets/snippet_match_nsh.c
+++ b/examples/flow_filtering/snippets/snippet_match_nsh.c
@@ -25,8 +25,10 @@ snippet_match_nsh_create_actions(uint16_t port_id, struct rte_flow_action *actio
 	create_jump_flow(port_id, 1, &error);
 
 	struct rte_flow_action_port_id *portid = calloc(1, sizeof(struct rte_flow_action_port_id));
-	if (portid == NULL)
+	if (portid == NULL) {
 		fprintf(stderr, "Failed to allocate memory for port_id\n");
+		return;
+	}
 
 	/* To match on NSH to port_id 1. */
 	portid->id = 1;
@@ -43,12 +45,17 @@ snippet_match_nsh_create_patterns(struct rte_flow_item *pattern)
 	struct rte_flow_item_udp *mask;
 
 	spec = calloc(1, sizeof(struct rte_flow_item_udp));
-	if (spec == NULL)
+	if (spec == NULL) {
 		fprintf(stderr, "Failed to allocate memory for spec\n");
+		return;
+	}
 
 	mask = calloc(1, sizeof(struct rte_flow_item_udp));
-	if (mask == NULL)
+	if (mask == NULL) {
 		fprintf(stderr, "Failed to allocate memory for mask\n");
+		free(spec);
+		return;
+	}
 
 	/* Set the patterns. */
 	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
diff --git a/examples/flow_filtering/snippets/snippet_match_nvgre.c b/examples/flow_filtering/snippets/snippet_match_nvgre.c
index 4ae06c5f1a..3ed62db4a2 100644
--- a/examples/flow_filtering/snippets/snippet_match_nvgre.c
+++ b/examples/flow_filtering/snippets/snippet_match_nvgre.c
@@ -23,8 +23,10 @@ snippet_match_nvgre_create_actions(uint16_t port_id, struct rte_flow_action *act
 	create_jump_flow(port_id, 1, &error);
 
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
-	if (queue == NULL)
+	if (queue == NULL) {
 		fprintf(stderr, "Failed to allocate memory for queue\n");
+		return;
+	}
 	queue->index = 1;
 
 	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
@@ -36,20 +38,34 @@ void
 snippet_match_nvgre_create_patterns(struct rte_flow_item *pattern)
 {
 	struct rte_flow_item_nvgre *nvgre = calloc(1, sizeof(struct rte_flow_item_nvgre));
-	if (nvgre == NULL)
+	if (nvgre == NULL) {
 		fprintf(stderr, "Failed to allocate memory for nvgre\n");
+		return;
+	}
 
 	struct rte_flow_item_udp *udp = calloc(1, sizeof(struct rte_flow_item_udp));
-	if (udp == NULL)
+	if (udp == NULL) {
 		fprintf(stderr, "Failed to allocate memory for udp\n");
+		free(nvgre);
+		return;
+	}
 
 	struct rte_flow_item_nvgre *nvgre_mask = calloc(1, sizeof(struct rte_flow_item_nvgre));
-	if (nvgre_mask == NULL)
+	if (nvgre_mask == NULL) {
 		fprintf(stderr, "Failed to allocate memory for nvgre_mask\n");
+		free(nvgre);
+		free(udp);
+		return;
+	}
 
 	struct rte_flow_item_udp *udp_mask = calloc(1, sizeof(struct rte_flow_item_udp));
-	if (udp_mask == NULL)
+	if (udp_mask == NULL) {
 		fprintf(stderr, "Failed to allocate memory for udp_mask\n");
+		free(nvgre);
+		free(udp);
+		free(nvgre_mask);
+		return;
+	}
 
 	/* build rule to match specific NVGRE:
 	 * tni = 0x12346, flow_id = 0x78, inner_udp_src = 0x1234
diff --git a/examples/flow_filtering/snippets/snippet_match_packet_type.c b/examples/flow_filtering/snippets/snippet_match_packet_type.c
index 3b16d4b0ab..97c0a88f3d 100644
--- a/examples/flow_filtering/snippets/snippet_match_packet_type.c
+++ b/examples/flow_filtering/snippets/snippet_match_packet_type.c
@@ -20,8 +20,10 @@ snippet_match_packet_type_create_actions(__rte_unused uint16_t port_id,
 {
 	/* Create one action that moves the packet to the selected queue. */
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
-	if (queue == NULL)
+	if (queue == NULL) {
 		fprintf(stderr, "Failed to allocate memory for queue\n");
+		return;
+	}
 
 	/*
 	 * create the action sequence.
@@ -38,15 +40,20 @@ snippet_match_packet_type_create_patterns(struct rte_flow_item *pattern)
 {
 	struct rte_flow_item_ptype *ptype_spec;
 	ptype_spec = calloc(1, sizeof(struct rte_flow_item_ptype));
-	if (ptype_spec == NULL)
+	if (ptype_spec == NULL) {
 		fprintf(stderr, "Failed to allocate memory for ptype_spec\n");
+		return;
+	}
 
 	ptype_spec->packet_type = RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP;
 
 	struct rte_flow_item_ptype *ptype_mask;
 	ptype_mask = calloc(1, sizeof(struct rte_flow_item_ptype));
-	if (ptype_mask == NULL)
+	if (ptype_mask == NULL) {
 		fprintf(stderr, "Failed to allocate memory for ptype_mask\n");
+		free(ptype_spec);
+		return;
+	}
 
 	ptype_mask->packet_type = RTE_PTYPE_L3_MASK | RTE_PTYPE_L4_MASK;
 
diff --git a/examples/flow_filtering/snippets/snippet_match_port_affinity.c b/examples/flow_filtering/snippets/snippet_match_port_affinity.c
index 3709121173..a7fb8a49b4 100644
--- a/examples/flow_filtering/snippets/snippet_match_port_affinity.c
+++ b/examples/flow_filtering/snippets/snippet_match_port_affinity.c
@@ -86,6 +86,7 @@ snippet_match_port_affinity_create_patterns(struct rte_flow_item *pattern)
 		calloc(1, sizeof(struct rte_flow_item_aggr_affinity));
 	if (affinity_mask == NULL) {
 		fprintf(stderr, "Failed to allocate memory for affinity_mask\n");
+		free(affinity_spec);
 		return;
 	}
 
diff --git a/examples/flow_filtering/snippets/snippet_match_roce_ib_bth.c b/examples/flow_filtering/snippets/snippet_match_roce_ib_bth.c
index f3c7e3eb70..6714fa734e 100644
--- a/examples/flow_filtering/snippets/snippet_match_roce_ib_bth.c
+++ b/examples/flow_filtering/snippets/snippet_match_roce_ib_bth.c
@@ -26,8 +26,10 @@ snippet_match_roce_ib_bth_create_actions(uint16_t port_id, struct rte_flow_actio
 
 	/* Create one action that moves the packet to the selected queue. */
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
-	if (queue == NULL)
+	if (queue == NULL) {
 		fprintf(stderr, "Failed to allocate memory for queue\n");
+		return;
+	}
 
 	/* Set the selected queue. */
 	queue->index = 1;
@@ -44,8 +46,10 @@ snippet_match_roce_ib_bth_create_patterns(struct rte_flow_item *pattern)
 	struct rte_flow_item_ib_bth *bth;
 
 	bth = calloc(1, sizeof(struct rte_flow_item_ib_bth));
-	if (bth == NULL)
+	if (bth == NULL) {
 		fprintf(stderr, "Failed to allocate memory for bth\n");
+		return;
+	}
 
 	bth->hdr.opcode = 0x81;
 	bth->hdr.dst_qp[0] = 0x0;
diff --git a/examples/flow_filtering/snippets/snippet_match_vxlan_gbp.c b/examples/flow_filtering/snippets/snippet_match_vxlan_gbp.c
index 521e9aae94..ccd66f8d44 100644
--- a/examples/flow_filtering/snippets/snippet_match_vxlan_gbp.c
+++ b/examples/flow_filtering/snippets/snippet_match_vxlan_gbp.c
@@ -21,8 +21,10 @@ snippet_match_vxlan_gbp_create_actions(__rte_unused uint16_t port_id,
 					struct rte_flow_action *action)
 {
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
-	if (queue == NULL)
+	if (queue == NULL) {
 		fprintf(stderr, "Failed to allocate memory for queue\n");
+		return;
+	}
 
 	queue->index = 1;
 
@@ -35,12 +37,17 @@ void
 snippet_match_vxlan_gbp_create_patterns(struct rte_flow_item *pattern)
 {
 	struct rte_flow_item_vxlan *vxlan_gbp = calloc(1, sizeof(struct rte_flow_item_vxlan));
-	if (vxlan_gbp == NULL)
+	if (vxlan_gbp == NULL) {
 		fprintf(stderr, "Failed to allocate memory for vxlan_gbp\n");
+		return;
+	}
 
 	struct rte_flow_item_vxlan *vxlan_gbp_mask = calloc(1, sizeof(struct rte_flow_item_vxlan));
-	if (vxlan_gbp_mask == NULL)
+	if (vxlan_gbp_mask == NULL) {
 		fprintf(stderr, "Failed to allocate memory for vxlan_gbp_mask\n");
+		free(vxlan_gbp);
+		return;
+	}
 
 	uint8_t vni[] = {0x00, 0x00, 0x00};
 	uint16_t group_policy_id = 0x200;
diff --git a/examples/flow_filtering/snippets/snippet_match_vxlan_gpe.c b/examples/flow_filtering/snippets/snippet_match_vxlan_gpe.c
index 08c71a58e0..62b70ba5c9 100644
--- a/examples/flow_filtering/snippets/snippet_match_vxlan_gpe.c
+++ b/examples/flow_filtering/snippets/snippet_match_vxlan_gpe.c
@@ -23,8 +23,10 @@ snippet_match_vxlan_gpe_create_actions(uint16_t port_id, struct rte_flow_action
 	create_jump_flow(port_id, 1, &error);
 
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
-	if (queue == NULL)
+	if (queue == NULL) {
 		fprintf(stderr, "Failed to allocate memory for queue\n");
+		return;
+	}
 	queue->index = 1;
 
 	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
@@ -37,8 +39,10 @@ snippet_match_vxlan_gpe_create_patterns(struct rte_flow_item *pattern)
 {
 	struct rte_flow_item_vxlan_gpe *vxlan_gpe_mask = calloc(1,
 		sizeof(struct rte_flow_item_vxlan_gpe));
-	if (vxlan_gpe_mask == NULL)
+	if (vxlan_gpe_mask == NULL) {
 		fprintf(stderr, "Failed to allocate memory for vxlan_gpe_mask\n");
+		return;
+	}
 	memset(vxlan_gpe_mask->hdr.vni, 0xff, 3);
 
 	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
diff --git a/examples/flow_filtering/snippets/snippet_modify_ecn.c b/examples/flow_filtering/snippets/snippet_modify_ecn.c
index 74bc708036..563a394dc6 100644
--- a/examples/flow_filtering/snippets/snippet_modify_ecn.c
+++ b/examples/flow_filtering/snippets/snippet_modify_ecn.c
@@ -22,13 +22,18 @@ snippet_match_modify_ecn_create_actions(__rte_unused uint16_t port_id,
 {
 	/* Create one action that moves the packet to the selected queue. */
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
-	if (queue == NULL)
+	if (queue == NULL) {
 		fprintf(stderr, "Failed to allocate memory for queue\n");
+		return;
+	}
 
 	struct rte_flow_action_modify_field *modify_field =
 					calloc(1, sizeof(struct rte_flow_action_modify_field));
-	if (modify_field == NULL)
+	if (modify_field == NULL) {
 		fprintf(stderr, "Failed to allocate memory for modify_field\n");
+		free(queue);
+		return;
+	}
 
 	queue->index = 1;
 	modify_field->operation = RTE_FLOW_MODIFY_SET;
diff --git a/examples/flow_filtering/snippets/snippet_nat64.c b/examples/flow_filtering/snippets/snippet_nat64.c
index 5c87abb3be..2190a625fd 100644
--- a/examples/flow_filtering/snippets/snippet_nat64.c
+++ b/examples/flow_filtering/snippets/snippet_nat64.c
@@ -23,7 +23,17 @@ snippet_match_nat64_create_actions(uint16_t port_id, struct rte_flow_action *act
 	create_jump_flow(port_id, 1, &error);
 
 	struct rte_flow_action_nat64 *nat64_v = calloc(1, sizeof(struct rte_flow_action_nat64));
+	if (nat64_v == NULL) {
+		fprintf(stderr, "Failed to allocate memory for nat64_v\n");
+		return;
+	}
+
 	struct rte_flow_action_jump *jump_v = calloc(1, sizeof(struct rte_flow_action_jump));
+	if (jump_v == NULL) {
+		fprintf(stderr, "Failed to allocate memory for jump_v\n");
+		free(nat64_v);
+		return;
+	}
 
 	nat64_v->type = RTE_FLOW_NAT64_4TO6;
 	jump_v->group = 2;
diff --git a/examples/flow_filtering/snippets/snippet_random_match.c b/examples/flow_filtering/snippets/snippet_random_match.c
index 60e252a6ca..36adfdfa6b 100644
--- a/examples/flow_filtering/snippets/snippet_random_match.c
+++ b/examples/flow_filtering/snippets/snippet_random_match.c
@@ -20,8 +20,10 @@ snippet_match_random_value_create_actions(__rte_unused uint16_t port_id,
 					struct rte_flow_action *action)
 {
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
-	if (queue == NULL)
+	if (queue == NULL) {
 		fprintf(stderr, "Failed to allocate memory for queue\n");
+		return;
+	}
 	queue->index = UINT16_MAX; /* The selected target queue.*/
 	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
 	action[0].conf = queue;
@@ -33,8 +35,10 @@ snippet_match_random_value_create_patterns(struct rte_flow_item *pattern)
 {
 	struct rte_flow_item_random *random_item;
 	random_item = calloc(1, sizeof(struct rte_flow_item_random));
-	if (random_item == NULL)
+	if (random_item == NULL) {
 		fprintf(stderr, "Failed to allocate memory for port_representor_spec\n");
+		return;
+	}
 
 	random_item->value = 0;
 
diff --git a/examples/flow_filtering/snippets/snippet_switch_granularity.c b/examples/flow_filtering/snippets/snippet_switch_granularity.c
index 414870bf89..a6b40e8d90 100644
--- a/examples/flow_filtering/snippets/snippet_switch_granularity.c
+++ b/examples/flow_filtering/snippets/snippet_switch_granularity.c
@@ -27,8 +27,10 @@ snippet_match_switch_granularity_create_actions(uint16_t port_id, struct rte_flo
 
 	struct rte_flow_action_ethdev *represented_port = calloc(1,
 		sizeof(struct rte_flow_action_ethdev));
-	if (represented_port == NULL)
+	if (represented_port == NULL) {
 		fprintf(stderr, "Failed to allocate memory for represented_port\n");
+		return;
+	}
 
 	represented_port->port_id = 0;
 	action[0].type = RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT;
-- 
2.43.0

