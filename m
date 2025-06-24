Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E870C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 07:16:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8733F4066C;
	Tue, 24 Jun 2025 09:16:11 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by mails.dpdk.org (Postfix) with ESMTP id 5024540667
 for <dev@dpdk.org>; Tue, 24 Jun 2025 09:16:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wATE2c10836h0uPwNSsHrfcBTPvs09OQnsUfdGFR4vgbtU6A0soh1jh5X+0R61KLQowbEIR+uXbLxyaz7ER2l/Iati4WJB88pZS9Tb9o5tlrwT4cK1/hIfsRrtNYde7YiobmPwvOL/DbmjXohbRqig6Usy3jxh4l6rtuJuF4Hw+xKOPcjkjDNUwCfTQKUmsyHySM9XzX2Fm5wUHUfEtWXGVdbfmSG5AbtnaSTWM4oHpGawa2L0ChcQQslAlHKrXuPDGCbPJDBqoLT2N2J1Wls//CFUJhXNNUOIYJGKRBohl7YFnusspy8WQRjbVQETvW9nCqhtVk0kWZ8Ezo09yZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5B4CXtt/Vw615oWgILGeKfhXSP02L1ke02VqS7XKxU=;
 b=M0V0vqAFxA0erShUkkAC5WTkgF+oEiGPoJRUMR9+9nCmBaHejhb99d8E1I3tXBcWlmmABZEXH2agLAlGyOl5gt/yHRN4ylZsPi2NdHzZ3wRFRYLOsfxstYgo+vj6WRePqzVG0KiNdYHVdP8ReM0fhF11S6hZkrb7NCncHbG+g8H6y1zL7S4+L8V1CJBfg0V/oAjdJ9itaGRfFwvo2kXv7cSVaGePpFzeqoWjmK9t7hw3G9y6+CbFkTrMmQ6+T3n1ISUtqT2bTmAiJQjuOLj31oQA+AoML3SvqUZVNleF9PuM4eL4ZKYaRMeOKvnJmPYD1oXq4tnd4VvCGFpX+u/D9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5B4CXtt/Vw615oWgILGeKfhXSP02L1ke02VqS7XKxU=;
 b=bC8Qt+u+gQNa8jUqarE40Ef0rdsY+Iw+munAzwx8juknuhXXkAedyPDOI20NAu1z0PhgEG95bBukTmuhGopPVYd4jqeeeIYsZQLjoG8ClgJp3ygHKdq1wlvxMhtR4ITPKsW4c8okogiZzN9a0U/4054QeeK3r5OSi9CT1MTSJrwSWfMjNAOPQk2V7y6SCNclMTIKtuX9Yb3WuKbnP+0M8s0SLKIlBVCyhY1cFgi3UyMxm0kt1wUIxWdD9EyqEof/UX3iUF45nGElLIAtZk8Wv+cDf76S22KQYAX4CYEItmb6TUztZmO0C+VyvH2+Hs8czXWE9GvM7Hx4d4HqpdKFCA==
Received: from BL1PR13CA0087.namprd13.prod.outlook.com (2603:10b6:208:2b8::32)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 24 Jun
 2025 07:16:02 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::2d) by BL1PR13CA0087.outlook.office365.com
 (2603:10b6:208:2b8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 07:16:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 07:16:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Jun
 2025 00:15:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 24 Jun
 2025 00:15:45 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 24 Jun 2025 00:15:44 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Ori Kam <orika@nvidia.com>
Subject: [RFC PATCH 1/2] examples/flow_filtering: add match port affinity
 snippet
Date: Tue, 24 Jun 2025 10:15:36 +0300
Message-ID: <20250624071538.107876-2-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624071538.107876-1-shperetz@nvidia.com>
References: <20250624071538.107876-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 0097b419-ffe3-496e-13f8-08ddb2eefa46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3IwT29DTWVUL3YvUk5Uam1KazI1SkVCbWsyUHNyeEduMjZEUW9hT1gxTkVE?=
 =?utf-8?B?elRwekFiVWZXL2xhWEM3R0N0NWl3eGFNWnF6am5CcGZKN25vMktGaFBMNVdz?=
 =?utf-8?B?VFBVYnpxbHg3ZmNxaVJ2Vk5Tc3ZsWlp3RjZQekZYMUJOanI0M25kcERhR3dD?=
 =?utf-8?B?UDFtZGZaZHZxbkZNcHY4ZStWVTZJclJ5UUlTK0dLTWFFdDZSTVovK1lON3Bz?=
 =?utf-8?B?VnRlUEJDNFk3cVhZMCtucjgzY2xpMHJYUDduK2tGKzhmSjcwcXl2WjdQUncy?=
 =?utf-8?B?NUxTc281L01VTHFITDJMeHNsM0lQNXAwYnczaEo4elR4YWdnRXZXaHM0UTRp?=
 =?utf-8?B?dTgyai9nQ3hDTHVoSURoSjRDM2pKdjdrV3RBeTM2RnMxNGRBYzNySnZvcUlE?=
 =?utf-8?B?YTFtOUpVejhpbzVKb0s1RnZLSW0zU2M1V3RIN005MXFiYkZ6RitIa0x2Ti9m?=
 =?utf-8?B?N1J5eitRVG5SM2xidGFWRWl4c1NkcTVvYzl6QzVTVUVPa1NVM1ZWZW1CeWsx?=
 =?utf-8?B?T0FCYnRtNGliN20yN2pLd3QwdkE1MzRqdWh0b29BT2VhSWFpTWFERklQZExw?=
 =?utf-8?B?dXUyN3ZDcjlLL2lCZEVOWXRFUTRhS1dNWFZVSGJWalpDRmdvVWNWZkh5dlVn?=
 =?utf-8?B?OGw0UURaYVpGVk9qdTJ1MU4reDFKQWR6Vkl6cDN5eXczTTRNK1YyYW40OThE?=
 =?utf-8?B?TFgvNlF0Tis0SmhQTTFyUWVwbmR1b2pMVXBERkppaHFkaGQ3L0VxV1h5bkxJ?=
 =?utf-8?B?YzdqV05zMlFESkpIdThHUy92elJOOFBLeVd1SjIrbmpsd3ZVUXlnUFp2N0Na?=
 =?utf-8?B?WHZNMXlibG1YMDNDbkxFMW1UVktmRkRzNkdDSk4zUmo4a1BoYVlMWkxMeERr?=
 =?utf-8?B?dDlUNSs2VFRzNDN0WTlLcHdoMWIycXJ5Sm5Ub0VabnJ2cUl0TkRkaWhvWmdO?=
 =?utf-8?B?WUNYRGw3WDZ1QXBIS2JydUF6TEJ3dXdjTFNZdFhoUXVTRlpqU3RsU2xYa21B?=
 =?utf-8?B?OFJGNEJpR0ZtdmhpMjRJbEhESXRJSlBEazhtYkQ2K1psQ0hML08rUWxKekYv?=
 =?utf-8?B?Zkc4NVY3Yi9paVUxVVlzbGx4UGpTbFpWMmZ5ME9HTTFWTWlaQmp6RlM1Y0d6?=
 =?utf-8?B?QWovQVhsOHJQNGxYNjVmd2hHOWROS3FPZERXVFR0U0taNXhmQ3NJR0NyL2Iv?=
 =?utf-8?B?U2REYkVlQnJibHZrRlFOWUNKT2NiSXFQbWlhQ3Y0YUtxNHpuckhuT2FON0lm?=
 =?utf-8?B?ZDFKS1ZiYVdJZzlZb1VKZ0JyUCtLWmdqMmtzNVVIaS9SUXErV0hSWU50QXM4?=
 =?utf-8?B?N1pzd0RFWWU0WTJ4dUhCVFltMzdCeEJHMlVoSXNQRktRU2x6S0xOQnpjckVq?=
 =?utf-8?B?Qi96YU0yY0d2K0FTRUxCNTZTM3pIZXM0NXJzWWJJaXpPK0ZoRzJ0Rit0N3Bz?=
 =?utf-8?B?SU52TWxibXZLYS9IVlp5KzV5czQ3YXVjUjN5VmlubkhWZ3NWbE5YcWtLOGt5?=
 =?utf-8?B?SHM1ck9Walg3TFl4Q01ydURyZElkRW41Y1B5dzcrNzBOVDA1ZktYWHZ5SDNX?=
 =?utf-8?B?N1N4bjZNUUVxNU1NaUp5NHpsdUdjc2NKdnJOKzZOR2wzYVl5TzExa0JtNTVs?=
 =?utf-8?B?U0FOdnZvMUNnZm5vY1pTV3MzaHNEem9Wa2FFUE1JUE93cGg4S2VPTGprOXg1?=
 =?utf-8?B?YnZqUVVXa3hFUVE0Y0h5ZitqYXZtUUUwcXFNYStBdVVQZXFtUysyRjR5d1Zp?=
 =?utf-8?B?WG1zbWhzTDR3Zkx6bTVodCsweTZ4NTVTUTB3SysxSkdka3F2UnBuSjBGNnNM?=
 =?utf-8?B?aElZM3NIZklOYmxzUm50N0h6UHN5NEhjR0VWaGdvTWttVzhYanFFTkcwUmpv?=
 =?utf-8?B?SXlJRTJYODJLMlF4ZFdJTHRtSzFoc0w5aE9DZUxLR0dhaDRjZkxXeHRPNVpP?=
 =?utf-8?B?OHI0QTZvbFR1N0NLcENzTDRiczZ3L0hpMmlGdWFaK20zTmhDQmdHajVPcUJn?=
 =?utf-8?B?MER1TXYvVjFxRGoxV0dNU0VjRDZOQktTUkVjcFpBVHdQTDZyUnB3T21ISjlj?=
 =?utf-8?Q?PNDU4O?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 07:16:02.5265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0097b419-ffe3-496e-13f8-08ddb2eefa46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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

This snippet demonstrates port affinity matching in bonded ports,
ensuring packets are sent back through their ingress port.

The NR_QUEUES constant was moved to common.h to support mapping
four TX queues (0-3) to two port affinities (0,1→1 and 2,3→2).

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 examples/flow_filtering/common.h              |   2 +
 examples/flow_filtering/flow_skeleton.c       |   2 +-
 examples/flow_filtering/main.c                |   9 +-
 examples/flow_filtering/meson.build           |   1 +
 .../snippets/snippet_match_gre.c              |   2 +-
 .../snippets/snippet_match_gre.h              |   2 +-
 .../snippets/snippet_match_ipv4.c             |   4 +-
 .../snippets/snippet_match_ipv4.h             |   2 +-
 .../snippets/snippet_match_mpls.c             |   2 +-
 .../snippets/snippet_match_mpls.h             |   2 +-
 .../snippets/snippet_match_port_affinity.c    | 110 ++++++++++++++++++
 .../snippets/snippet_match_port_affinity.h    |  39 +++++++
 .../snippets/snippet_re_route_to_kernel.c     |   3 +-
 .../snippets/snippet_re_route_to_kernel.h     |   2 +-
 14 files changed, 167 insertions(+), 15 deletions(-)
 create mode 100644 examples/flow_filtering/snippets/snippet_match_port_affinity.c
 create mode 100644 examples/flow_filtering/snippets/snippet_match_port_affinity.h

diff --git a/examples/flow_filtering/common.h b/examples/flow_filtering/common.h
index 3a73520723..9d579aff74 100644
--- a/examples/flow_filtering/common.h
+++ b/examples/flow_filtering/common.h
@@ -5,6 +5,8 @@
 #ifndef COMMON_H
 #define COMMON_H
 
+#define NR_QUEUES 4
+
 extern bool enable_promiscuous_mode;
 extern bool enable_flow_isolation;
 extern struct rte_flow_attr flow_attr;
diff --git a/examples/flow_filtering/flow_skeleton.c b/examples/flow_filtering/flow_skeleton.c
index 471302d8b3..7e57b13b55 100644
--- a/examples/flow_filtering/flow_skeleton.c
+++ b/examples/flow_filtering/flow_skeleton.c
@@ -59,7 +59,7 @@ generate_flow_skeleton(uint16_t port_id, struct rte_flow_error *error, int use_t
 	struct rte_flow_action actions[MAX_ACTION_NUM] = {0};
 	struct rte_flow_item patterns[MAX_PATTERN_NUM] = {0};
 
-	snippet_skeleton_flow_create_actions(actions);
+	snippet_skeleton_flow_create_actions(port_id, actions);
 
 	snippet_skeleton_flow_create_patterns(patterns);
 	/* >8 End of setting the common action and pattern structures. */
diff --git a/examples/flow_filtering/main.c b/examples/flow_filtering/main.c
index 13ad17a712..8ea6596ed4 100644
--- a/examples/flow_filtering/main.c
+++ b/examples/flow_filtering/main.c
@@ -40,7 +40,6 @@ static int use_template_api = 1;
 
 static volatile bool force_quit;
 static uint16_t port_id;
-static uint16_t nr_queues = 5;
 struct rte_mempool *mbuf_pool;
 struct rte_flow *flow;
 
@@ -67,7 +66,7 @@ main_loop(void)
 
 	/* Reading the packets from all queues. */
 	while (!force_quit) {
-		for (i = 0; i < nr_queues; i++) {
+		for (i = 0; i < NR_QUEUES; i++) {
 			nb_rx = rte_eth_rx_burst(port_id,
 						i, mbufs, 32);
 			if (nb_rx) {
@@ -179,7 +178,7 @@ init_port(void)
 	port_conf.txmode.offloads &= dev_info.tx_offload_capa;
 	printf(":: initializing port: %d\n", port_id);
 	ret = rte_eth_dev_configure(port_id,
-				nr_queues, nr_queues, &port_conf);
+				NR_QUEUES, NR_QUEUES, &port_conf);
 	if (ret < 0) {
 		rte_exit(EXIT_FAILURE,
 			":: cannot configure device: err=%d, port=%u\n",
@@ -190,7 +189,7 @@ init_port(void)
 	rxq_conf.offloads = port_conf.rxmode.offloads;
 
 	/* Configuring number of RX and TX queues connected to single port. */
-	for (i = 0; i < nr_queues; i++) {
+	for (i = 0; i < NR_QUEUES; i++) {
 		ret = rte_eth_rx_queue_setup(port_id, i, 512,
 					 rte_eth_dev_socket_id(port_id),
 					 &rxq_conf,
@@ -205,7 +204,7 @@ init_port(void)
 	txq_conf = dev_info.default_txconf;
 	txq_conf.offloads = port_conf.txmode.offloads;
 
-	for (i = 0; i < nr_queues; i++) {
+	for (i = 0; i < NR_QUEUES; i++) {
 		ret = rte_eth_tx_queue_setup(port_id, i, 512,
 				rte_eth_dev_socket_id(port_id),
 				&txq_conf);
diff --git a/examples/flow_filtering/meson.build b/examples/flow_filtering/meson.build
index 6413dbc947..3be2bb1ef5 100644
--- a/examples/flow_filtering/meson.build
+++ b/examples/flow_filtering/meson.build
@@ -15,6 +15,7 @@ sources = files(
         'snippets/snippet_match_ipv4.c',
         'snippets/snippet_match_gre.c',
         'snippets/snippet_match_mpls.c',
+        'snippets/snippet_match_port_affinity.c',
         'snippets/snippet_re_route_to_kernel.c',
 )
 
diff --git a/examples/flow_filtering/snippets/snippet_match_gre.c b/examples/flow_filtering/snippets/snippet_match_gre.c
index b1d6edaad0..8c290328ec 100644
--- a/examples/flow_filtering/snippets/snippet_match_gre.c
+++ b/examples/flow_filtering/snippets/snippet_match_gre.c
@@ -15,7 +15,7 @@ snippet_init_gre(void)
 }
 
 static void
-snippet_match_gre_create_actions(struct rte_flow_action *action)
+snippet_match_gre_create_actions(__rte_unused uint16_t port_id, struct rte_flow_action *action)
 {
 	/* Create one action that moves the packet to the selected queue. */
 	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
diff --git a/examples/flow_filtering/snippets/snippet_match_gre.h b/examples/flow_filtering/snippets/snippet_match_gre.h
index 25f9fd5dd8..11054ba144 100644
--- a/examples/flow_filtering/snippets/snippet_match_gre.h
+++ b/examples/flow_filtering/snippets/snippet_match_gre.h
@@ -19,7 +19,7 @@ snippet_init_gre(void);
 #define snippet_init snippet_init_gre
 
 static void
-snippet_match_gre_create_actions(struct rte_flow_action *action);
+snippet_match_gre_create_actions(uint16_t port_id, struct rte_flow_action *action);
 #define snippet_skeleton_flow_create_actions snippet_match_gre_create_actions
 
 static void
diff --git a/examples/flow_filtering/snippets/snippet_match_ipv4.c b/examples/flow_filtering/snippets/snippet_match_ipv4.c
index 4082dc660d..7f8aba66bb 100644
--- a/examples/flow_filtering/snippets/snippet_match_ipv4.c
+++ b/examples/flow_filtering/snippets/snippet_match_ipv4.c
@@ -7,8 +7,8 @@
 #include <rte_errno.h>
 #include <rte_flow.h>
 
-#include "snippet_match_ipv4.h"
 #include "../common.h"
+#include "snippet_match_ipv4.h"
 
 void
 snippet_init_ipv4(void)
@@ -17,7 +17,7 @@ snippet_init_ipv4(void)
 }
 
 void
-snippet_ipv4_flow_create_actions(struct rte_flow_action *action)
+snippet_ipv4_flow_create_actions(__rte_unused uint16_t port_id, struct rte_flow_action *action)
 {
 	/*
 	 * create the action sequence.
diff --git a/examples/flow_filtering/snippets/snippet_match_ipv4.h b/examples/flow_filtering/snippets/snippet_match_ipv4.h
index 8d169589b0..93f284ad23 100644
--- a/examples/flow_filtering/snippets/snippet_match_ipv4.h
+++ b/examples/flow_filtering/snippets/snippet_match_ipv4.h
@@ -17,7 +17,7 @@ snippet_init_ipv4(void);
 #define snippet_init snippet_init_ipv4
 
 void
-snippet_ipv4_flow_create_actions(struct rte_flow_action *action);
+snippet_ipv4_flow_create_actions(uint16_t port_id, struct rte_flow_action *action);
 #define snippet_skeleton_flow_create_actions snippet_ipv4_flow_create_actions
 
 void
diff --git a/examples/flow_filtering/snippets/snippet_match_mpls.c b/examples/flow_filtering/snippets/snippet_match_mpls.c
index df499fcdb7..494a2d873d 100644
--- a/examples/flow_filtering/snippets/snippet_match_mpls.c
+++ b/examples/flow_filtering/snippets/snippet_match_mpls.c
@@ -19,7 +19,7 @@ snippet_init_mpls(void)
 }
 
 static void
-snippet_mpls_create_actions(struct rte_flow_action *actions)
+snippet_mpls_create_actions(__rte_unused uint16_t port_id, struct rte_flow_action *actions)
 {
 	/* Create one action that moves the packet to the selected queue. */
 	struct rte_flow_action_queue *queue;
diff --git a/examples/flow_filtering/snippets/snippet_match_mpls.h b/examples/flow_filtering/snippets/snippet_match_mpls.h
index ed08b736eb..791e96efa1 100644
--- a/examples/flow_filtering/snippets/snippet_match_mpls.h
+++ b/examples/flow_filtering/snippets/snippet_match_mpls.h
@@ -19,7 +19,7 @@ snippet_init_mpls(void);
 #define snippet_init snippet_init_mpls
 
 static void
-snippet_mpls_create_actions(struct rte_flow_action *actions);
+snippet_mpls_create_actions(uint16_t port_id, struct rte_flow_action *actions);
 #define snippet_skeleton_flow_create_actions snippet_mpls_create_actions
 
 static void
diff --git a/examples/flow_filtering/snippets/snippet_match_port_affinity.c b/examples/flow_filtering/snippets/snippet_match_port_affinity.c
new file mode 100644
index 0000000000..8d946ec797
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_port_affinity.c
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#include <stdlib.h>
+#include <rte_flow.h>
+
+#include "../common.h"
+#include "snippet_match_port_affinity.h"
+
+void
+snippet_init_match_port_affinity(void)
+{
+	init_default_snippet();
+}
+
+static void
+map_tx_queue_to_aggregated_port(uint16_t port_id)
+{
+	int ret;
+	uint16_t queues[] = {0, 1, 2, 3};
+	uint16_t affinities[] = {1, 1, 2, 2};
+	int i;
+
+	ret = rte_eth_dev_stop(port_id);
+	if (ret < 0)
+		rte_exit(EXIT_FAILURE,
+			"rte_eth_dev_stop:err=%d, port=%u\n",
+			ret, port_id);
+
+	ret = rte_eth_dev_count_aggr_ports(port_id);
+	if (ret < 0) {
+		printf("Failed to count the aggregated ports: (%s)\n",
+				strerror(-ret));
+		return;
+	}
+
+	/* Configure TxQ index 0,1 with tx affinity 1 and TxQ index 2,3 with tx affinity 2 */
+	for (i = 0; i < NR_QUEUES; i++) {
+		ret = rte_eth_dev_map_aggr_tx_affinity(port_id, queues[i], affinities[i]);
+		if (ret != 0) {
+			printf("Failed to map tx queue with an aggregated port: %s\n",
+					rte_strerror(-ret));
+			return;
+		}
+		printf(":: tx queue %d mapped to aggregated port %d with affinity %d\n",
+				queues[i], port_id, affinities[i]);
+	}
+
+	ret = rte_eth_dev_start(port_id);
+	if (ret < 0)
+		rte_exit(EXIT_FAILURE,
+			"rte_eth_dev_start:err=%d, port=%u\n",
+			ret, port_id);
+}
+
+void
+snippet_match_port_affinity_create_actions(uint16_t port_id, struct rte_flow_action *action)
+{
+	/* Configure affinity in TxQ */
+	map_tx_queue_to_aggregated_port(port_id);
+
+	struct rte_flow_action_queue *queue = calloc(1, sizeof(struct rte_flow_action_queue));
+	if (queue == NULL) {
+		printf("Failed to allocate memory for queue\n");
+		return;
+	}
+	queue->index = 1;
+	/* Create the Queue action. */
+	action[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	action[0].conf = queue;
+	action[1].type = RTE_FLOW_ACTION_TYPE_END;
+}
+
+void
+snippet_match_port_affinity_create_patterns(struct rte_flow_item *pattern)
+{
+	struct rte_flow_item_aggr_affinity *affinity_spec =
+		calloc(1, sizeof(struct rte_flow_item_aggr_affinity));
+	if (affinity_spec == NULL) {
+		fprintf(stderr, "Failed to allocate memory for affinity_spec\n");
+		return;
+	}
+
+	struct rte_flow_item_aggr_affinity *affinity_mask =
+		calloc(1, sizeof(struct rte_flow_item_aggr_affinity));
+	if (affinity_mask == NULL) {
+		fprintf(stderr, "Failed to allocate memory for affinity_mask\n");
+		return;
+	}
+
+	affinity_spec->affinity = 2;	/* Set the request affinity value. */
+	affinity_mask->affinity = 0xff;	/* Set the mask for the affinity value. */
+
+	/* Create a rule that matches the port affinity values */
+	pattern[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+	// pattern[0].spec = eth;
+	// pattern[0].mask = NULL;
+	pattern[1].type = RTE_FLOW_ITEM_TYPE_AGGR_AFFINITY;
+	pattern[1].spec = affinity_spec;
+	pattern[1].mask = affinity_mask;
+	pattern[2].type = RTE_FLOW_ITEM_TYPE_END;
+}
+
+struct rte_flow_template_table *
+snippet_match_port_affinity_create_table(__rte_unused uint16_t port_id,
+	__rte_unused struct rte_flow_error *error)
+{
+	return NULL;
+}
diff --git a/examples/flow_filtering/snippets/snippet_match_port_affinity.h b/examples/flow_filtering/snippets/snippet_match_port_affinity.h
new file mode 100644
index 0000000000..5e9f032763
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_port_affinity.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef SNIPPET_MATCH_PORT_AFFINITY_H
+#define SNIPPET_MATCH_PORT_AFFINITY_H
+
+/* Port Affinity Match
+ * indicates in the DPDK level the physical port a packet belongs to.
+ * This capability is available by using a new pattern item type for aggregated port affinity,
+ * its value reflects the physical port affinity of the received packets.
+ * Additionally, the tx_affinity setting was added by calling rte_eth_dev_map_aggr_tx_affinity(),
+ * its value reflects the physical port the packets will be sent to.
+ * This new capability is enables the app to receive the ingress port of a packet,
+ * and send the ACK out on the same port when dual ports devices are configured as a bond in Linux.
+ * This feature is used in conjunction with link aggregation, also known as port bonding,
+ * where multiple physical ports are combined into a single logical interface.
+ */
+
+#define MAX_PATTERN_NUM     3 /* Maximal number of patterns for this example. */
+#define MAX_ACTION_NUM      2 /* Maximal number of actions for this example. */
+
+void
+snippet_init_match_port_affinity(void);
+#define snippet_init snippet_init_match_port_affinity
+
+void
+snippet_match_port_affinity_create_actions(uint16_t port_id, struct rte_flow_action *action);
+#define snippet_skeleton_flow_create_actions snippet_match_port_affinity_create_actions
+
+void
+snippet_match_port_affinity_create_patterns(struct rte_flow_item *pattern);
+#define snippet_skeleton_flow_create_patterns snippet_match_port_affinity_create_patterns
+
+struct rte_flow_template_table *
+snippet_match_port_affinity_create_table(uint16_t port_id, struct rte_flow_error *error);
+#define snippet_skeleton_flow_create_table snippet_match_port_affinity_create_table
+
+#endif /* SNIPPET_MATCH_PORT_AFFINITY_H */
diff --git a/examples/flow_filtering/snippets/snippet_re_route_to_kernel.c b/examples/flow_filtering/snippets/snippet_re_route_to_kernel.c
index 1e5a875164..15214a0244 100644
--- a/examples/flow_filtering/snippets/snippet_re_route_to_kernel.c
+++ b/examples/flow_filtering/snippets/snippet_re_route_to_kernel.c
@@ -19,7 +19,8 @@ snippet_init_re_route_to_kernel(void)
 }
 
 void
-snippet_re_route_to_kernel_create_actions(struct rte_flow_action *action)
+snippet_re_route_to_kernel_create_actions(__rte_unused uint16_t port_id,
+					struct rte_flow_action *action)
 {
 	action[0].type = RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL;
 	action[1].type = RTE_FLOW_ACTION_TYPE_END;
diff --git a/examples/flow_filtering/snippets/snippet_re_route_to_kernel.h b/examples/flow_filtering/snippets/snippet_re_route_to_kernel.h
index 9845cc839d..47df34d711 100644
--- a/examples/flow_filtering/snippets/snippet_re_route_to_kernel.h
+++ b/examples/flow_filtering/snippets/snippet_re_route_to_kernel.h
@@ -20,7 +20,7 @@ snippet_init_re_route_to_kernel(void);
 #define snippet_init snippet_init_re_route_to_kernel
 
 static void
-snippet_re_route_to_kernel_create_actions(struct rte_flow_action *action);
+snippet_re_route_to_kernel_create_actions(uint16_t port_id, struct rte_flow_action *action);
 #define snippet_skeleton_flow_create_actions snippet_re_route_to_kernel_create_actions
 
 static void
-- 
2.34.1

