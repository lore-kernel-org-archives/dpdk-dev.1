Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D48CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 07:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86E29402E9;
	Mon, 25 Aug 2025 09:24:31 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by mails.dpdk.org (Postfix) with ESMTP id EBF2E402E7
 for <dev@dpdk.org>; Mon, 25 Aug 2025 09:24:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbOMRXdJLhOsRE6YRzycLnZ4KR+dQ9aW8YyqQrFn+LdkbY9cxxy/ZZqXEJ/aTEQdYjy55bkWNWSBjwQSE6Nfk8N35hceohRgvx7zjZYVUseSpzQecQc18Vl46ZS+GNZ4tW0QjS1Zr8hWPW2bjrYTBXx3dAzcmcRYzbnW4JMfLGzD6qJRm6huDoYaHinhX1LKwagi4C6E/e6themi/U41Oos+KfDRwBAQboLwR8DegJhjYQ6OuJvnuH2RAuiK4p70xBDf44eMLpYAD7t6HbH/EdMvOJC+F1BW+cwYeq0sRQbUaXqnSBuL3vAw+HKFI3wEo/oKxXekskOb1ehJzw6T+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPXLHaTrnn8EWdvs2WR72L2KfxS7XrQDkxCW7tBsWtk=;
 b=ZBlTVM1qoBVMVpNCr3cvuR1v3hTc9pVcNxC8nhXCUkHraefRP0z8/Kk5ejM/CnCDgEXClNRZm623XXlfDHxMkC1OeLCYd2RFHEwTMN9IH0qlg1XQ6OUgQdqcGUDE4qqE5WA2DHrO7MdjNchYfTD+HDzOyMBCi+HPngloOlOdeNNraTebrhBD0pFeWGK7sdAngzIKO26A5/B7dB82Zxv1/FumYJK2GVuy51KE378HNLROAmKi9Qs50QCbHK0boNBK8+GnUCtt4X9A+kSiHjGiJyqhLmTHl9vYi19/PRRqUw261OCREmLt48Ithg+ZhBs3+MkOv1+NocL8E+KNRWJZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPXLHaTrnn8EWdvs2WR72L2KfxS7XrQDkxCW7tBsWtk=;
 b=iioQhKg2gjuO8/zPBklAiceZkQPupp82BtMJvC3t28xdX+pk7kZzgNIWJpjuS3rFfUZpieoZIn1ngPS/1S2I2081bLKtTCrx/FPvSiHApHgb4nFv1PzFiFKrCgxx9DUX47KrUcV4dwUg/5GqkBNrO0ySxVijUBHVXz0g2tKEq7CcXzs35+HZvkOx2UBFa8cfxZ7uuyvbC9oXH5yJqfdeUgIXbCqKq2em+Pi33PjEMHT5ig9tHAx9YtR7c2Ftb7Q0XZp7zevqf/rD0i74WoGtswCE78oLxpmIRMteucaeYW/Yp3PUVOcQdXfmsKyDz1FX0b0Qfpht0O4W9ZR6D2k0CQ==
Received: from DS7PR03CA0250.namprd03.prod.outlook.com (2603:10b6:5:3b3::15)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 25 Aug
 2025 07:24:23 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::77) by DS7PR03CA0250.outlook.office365.com
 (2603:10b6:5:3b3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 07:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 07:24:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 00:24:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 00:24:04 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 00:24:03 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Ori Kam <orika@nvidia.com>
Subject: [PATCH v3 1/2] examples/flow_filtering: add match port affinity
 snippet
Date: Mon, 25 Aug 2025 10:23:45 +0300
Message-ID: <20250825072346.25548-2-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825072346.25548-1-shperetz@nvidia.com>
References: <20250811143704.146795-2-shperetz@nvidia.com>
 <20250825072346.25548-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 24afca03-4254-479f-b203-08dde3a86a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzVTTWJoZ2Q4RzBuNG1TN1FObHhmS3FhUDRSTThpMHFaSExHc2RTdVZVV0hx?=
 =?utf-8?B?UzRQVk9yUUJVWHhwUm9TdFA3WWE4UnFwRVRxQlhabTlVVEZ3bFBGcHMvWUc3?=
 =?utf-8?B?enR4blRzY1RMaVNtTXNuRWMyOVZiQUtzYUhLWDVDZkN1R3VScGExNlpYazRk?=
 =?utf-8?B?RnN0Y0FmalBnclhBVDVoK1lmOFdad3NHaUdkUGJMcDZuK1cyeVlvMDdtVEJX?=
 =?utf-8?B?VjgwdHhDaDdINlNCeVY1VXVqcTBkdlpiWGtWZ3NFTGMrUEJVb1VPblJ1cjUz?=
 =?utf-8?B?ZTZIcDlhd2wrUTl5ZkNoYURkREZwTm00NzBOemhQQkxNL1gzZCtLaGNOUjkx?=
 =?utf-8?B?Njd4eDVtcVFKanhPZ3pDOG9GOVM5MFg4KzgxNnBtbk4yMTRKZmFIdm1WUFFM?=
 =?utf-8?B?dVpLQzM3QlVRdW9vQkNtMU9lZytRZDNzTk1mODdJQ1pzSThQRm8vVEtDbGph?=
 =?utf-8?B?b2lwTFZ0U3BlNk9RN3MrTUxaemE2czVMa0V0RHJ0ZnQrbFF2ZkxyVG5kM0V3?=
 =?utf-8?B?ZkFZSGFKN2p1MTdqTm13SkRFa3hDdUNjS050NzVBY0t1MkR0TzdoM0lMakVr?=
 =?utf-8?B?Q0NqNkh6L2pvOUlUSjdZbmNrd0VBZ3h4ekVKL0ZEWmVGU2RYSU41c1V3Z0pu?=
 =?utf-8?B?MzhPYldHQWkzcEUxTWxYRmFBMGFHYnNzMnN3MFpJcm1abmZKYmZsclY3ZEsw?=
 =?utf-8?B?MEZzcklIdm1LRFl2dnlDTzl1VzFuMm0yQXRyNnZFZDlUZHBrWGVHZ0RIcTdH?=
 =?utf-8?B?NHFycmd2akZMZEJhVWF5SnNaK0pQRm9iM08vdSt3dGVrT3NQU015ekkyWTZR?=
 =?utf-8?B?OG44SmgxS25CVDFSdWVjODZMTERKQU9qaDNucXhOM3FGVTV2UFpwV1NTMHNM?=
 =?utf-8?B?eldGMW5LWXF2cEdMYjJCcjFSMVpBVExNaG1FeG9vWHp4VTZQbVJ0N2h0dDBj?=
 =?utf-8?B?dlJveHZTRkxvUFJGMnZDQmxEN215cDl5a3QyMkNtUWx3NktnOExnNEZQY1di?=
 =?utf-8?B?Z3Q5WW5ManQvZmhTMEFCbXk5MnpPVDVidzkzSzZQZ0FXSnNFNGdUVWsrc2hT?=
 =?utf-8?B?bDNCNFJpSGRKaWdYVS9VMjhJMDg1K3dwNDlRcFRBbCtLM2pJZENkZ2lONW1u?=
 =?utf-8?B?VjZ0Y2xWcWEwUUs2UitTVTU3cUFweUhjQ2NsL0NEWFJIeWNFTDd6c3k4L011?=
 =?utf-8?B?RUQxZFAzWnpneDhjaGswYXJja1p0NHhydCtjeWxMSDczTE53M2xmdCt0ZXRO?=
 =?utf-8?B?RTlNNGhLR0JaVHY1K24rTTAwRzJna0JaUHZhcVpsRDFCMjl0T0QxUzVrdUxz?=
 =?utf-8?B?WEkvR1g1MFBLWlJqMXJtdTJ4enRRTXNUQkptVXNDbUpvb3dqd0pzZUlON3U0?=
 =?utf-8?B?T0dyWTlvdjI5dGlZTUYzUVZ4NVVaRENVU0xZbUlQVlBidzBiVW1jbHIvY1JJ?=
 =?utf-8?B?YUo0bXpqS0pRTDByRC9hbjQxTitJU2NFdFQ1Yi9EZ0F6VWdueGNiTUQ3NmJ5?=
 =?utf-8?B?L1I5T0w0bGlKY0x0VzJiTFJvV093R1ZYTGNuSTVTZmtHUE1iUytsbkVOOW5O?=
 =?utf-8?B?M2M3SmpuTFIySWdrUmMrYU14ZVpvN09nQlpidm14bkhuWHRoYXRKVEVLYjI2?=
 =?utf-8?B?Znc4RUtVQ3QzWkR0cVZ5dFc1SXhEQU5TYi9aaDJzdWVseFFvbjdWWWRpbGJT?=
 =?utf-8?B?N2lydnRnVVBLL2ZFTjJ4R2U5S3RxQmQrMDRWWFJVRk5uWkNBVFNuOEp6LzBw?=
 =?utf-8?B?SDgzNmJRY01aYUdUOXJmakN3ZDdqUHVCck1jZ1lFdG45V0NLUEpJK3N3MG1p?=
 =?utf-8?B?bHV2Y00zVFJia2hsR0pkaFlhTDhoenVHTm9mV24wNGM0aHR6QXgzTnZ4REcx?=
 =?utf-8?B?MWFZVHdLRWFiOEJDV0prTk1hZHFQc09LUjlubENKTE9OazFjdGxJRDVZeTlZ?=
 =?utf-8?B?cEhpYlBVMnY4YWlac013N3pwNnZNNGdVUEdCalV2MWdzS0gvcHUvZWdXaFM4?=
 =?utf-8?B?eGtJNWdrcE82Wk9EU0QwWHpRN0JpOW00cFNodVNjSTFWWkFVK1hoeDJwUWJM?=
 =?utf-8?Q?xnCpZ5?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:24:23.4498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24afca03-4254-479f-b203-08dde3a86a6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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
 .../snippets/snippet_match_port_affinity.c    | 108 ++++++++++++++++++
 .../snippets/snippet_match_port_affinity.h    |  39 +++++++
 .../snippets/snippet_re_route_to_kernel.c     |   3 +-
 .../snippets/snippet_re_route_to_kernel.h     |   2 +-
 14 files changed, 165 insertions(+), 15 deletions(-)
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
index 38eca83415..477ec59451 100644
--- a/examples/flow_filtering/snippets/snippet_match_gre.c
+++ b/examples/flow_filtering/snippets/snippet_match_gre.c
@@ -17,7 +17,7 @@ snippet_init_gre(void)
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
index 0000000000..3709121173
--- /dev/null
+++ b/examples/flow_filtering/snippets/snippet_match_port_affinity.c
@@ -0,0 +1,108 @@
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
index d9edcac47f..1bc49666a3 100644
--- a/examples/flow_filtering/snippets/snippet_re_route_to_kernel.c
+++ b/examples/flow_filtering/snippets/snippet_re_route_to_kernel.c
@@ -20,7 +20,8 @@ snippet_init_re_route_to_kernel(void)
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

