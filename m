Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3376F54ADA
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:57:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E85040DD3;
	Tue, 24 Mar 2026 17:57:36 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71]) by mails.dpdk.org (Postfix) with ESMTP id 680F14021F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:57:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEmLrBzfvrt4u73G9iNUfwkQZeDeD8+SurraQcbnRZ0jScUrWVmDui8SqGQ1FwKUr8f9OBKoYwUByoAkjlwTk6fHlCQ6tZG/dKj+J3GO/sbARczu8elrdIY0sS6u7E7Qu1LFdWcTcZIslxfGe2H+ZdY8RahWfIgLoHG0w1FTLv2mU5MUFphrTeNepiXYkoWDdZm7CH1w8bJ3eYojYXk7tKK98v07Ir+h0MpuxXrcffkC6Se/o+y8CsHUBlqRCwzAIvfRm4XtCmiDzZ3zHZCxPjKoYqV8M4BeJXX1TB8tOCt/gou2LjwtWesMwmG01mvo11JNlzayzcOBj9nlFCVpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBJ7QDoH64GBjFQLxu7No/SqLaZhhWyhVZNinS7MW9E=;
 b=c4QY4HY12eVYLyMbRGtEl0YZB5c6DLWtliwD+mUJFp0bSDDHFH4Qu5BLiD4b3C5uUQAvVjv8OV91u1PSmeecmB43KIPCpG8kGRPVfcG+Hr8dHeTVfnimtDGxsbMsGPkQNoyb4gZBj4JuFj64ltM8L7aczjowHAqWzeJg85TTnGEETx65QyOs9i1PBbA53RnFB64p3WHsf1szs6qqSZ9Dj+MXm4ttvb4wZpuoZSH+liz6ubq0tC4gzK02n/sF9cm0lxVuoOfIqz0yHUYug9f/ZXcMPUOvSWoj/kgLqmeUfCWRaZSUN1PmmWbwiRFgufdxgu7rywgBsqqh4hR/52gYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBJ7QDoH64GBjFQLxu7No/SqLaZhhWyhVZNinS7MW9E=;
 b=VC6c6A4PcLqSPLMZjnEDSYs6u0RP8V7fAjTiJaCHVjTcYsVPYQ2tiCCatFlSLLAxjHQJrjANajN0XramiwINwYaqgNz3G3FLmz/gm31UCbtGuNiZELgqgi0NcYDoLcOo55cNDhRcy5BkkpjE1R7Tg+Ui9HBtHel8PWhuRBQrAQfVBFYCkLiwVtZBRF/sB3AQDmrrceYvJ1QaquK7S9G1qW1ghTeLzketZD6s2S8ec1gVG+xbqfLeMgo5lFxVqouWK8GlrgKwHr7eFaLwUofWKTTys81qhVDpoEqJ4X8dbCvCczcCih7e+OHd5qdDHruZ3tiACWjODopGME4OGcN/uQ==
Received: from DM6PR18CA0009.namprd18.prod.outlook.com (2603:10b6:5:15b::22)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 16:57:31 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::35) by DM6PR18CA0009.outlook.office365.com
 (2603:10b6:5:15b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 16:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 16:57:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:57:12 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:57:10 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH v2 1/2] app/testpmd: assign share group dynamically
Date: Tue, 24 Mar 2026 17:56:56 +0100
Message-ID: <20260324165657.23945-2-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324165657.23945-1-dsosnowski@nvidia.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
 <20260324165657.23945-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: a596d447-bd8b-4c6f-135d-08de89c67005
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wVx1erxeMmJbky3Mlb1SUgC8nq2GQqR716cQxl/s3Jm0Lk329ZMNFyi3MGhIeraRs40ywdvYo0v/eJkbfyUMLg6qb5tYTD+v92FLiduaMXd+9pjfe2ZSSmnYJZNthpm7rXDbCPPTD/lC9hHnS4WQiHTUxRjw7LHgvS+GImI/IF3fIpzSnvaUAf2pPplKtaGQSP0TjbX8ozeHzPIhmyTA73w87sLi+N77b5as1NJqBXJIykA+P+XnTxkIE5ieTTFhJ911nHYI0NuNBVJnKov3xPSOnVbmDqa2YaexhKDWvtXW/dFaSxXI48pJ7wHi/gfETIqh3Unv+HqsVRQZbq8IiqPmQWk89Im2lYzo6zsMcVW/vsFTpuKql9AcrKjwqexR89zCEdeOEvI+3ByuZUbESIH+GxvjEQ+KO6ruyPUlalfocDATL1ifVTm6xtgT7HlZd1+1l1oHBI+ULpTAY0crFMKRl856WO93145gE3eMXsEK7gdVgtsYdH7QF83FuptiDiynJcMwXUL+xt6qlA4pc+0V2eG7fh4Rb3FRF6/VTILk5bkyP2FbpIoVI70JUUUPmaYRTrMG8bfyTa5CZEL9ewg878bb9x+lJEf4VxP2YlXLV2e62VFsRAQn0g/mZcwVzSDgVh038oBPgcjIv6QFLNkJrp0jjhe5nnY5a2ZIKyu2BS5/XVKNA9C32yW4rfiYKOWRg3VVqk8SaGhA4XFMFSFIopLTHTNIVD9Fs9d8XJppLVO0KJu7M9G/7EDZINMIQJrQwNbFvc7/CvI3Pkbeeg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 10ZUUst9XE6v2heMEt9EE9UJsun24otaXfTOO/gdNNJf1HZtrD6yyz2JaFPJ7RrZxxORpb3C/NW+alHx3EAKTdEzsXsvJEQIrqnORDQ0Cq4LXOmH7pg4utFP6eM8Ndryq5zpTsReILsI6NYwXealMZ/gohQspuoaFHGNlIPsy14SXYOzi7TGUr1MgknpJaT3uVaQ/J3DLxKR7e7OXw7IqPnGaxurXJ0DbQsvwJNG/uitHxMbJi/+LBO0hAh+yYaZzJmCTiueurggXUxCPEaXWNe67n/uv0sXfUAi7s5JTaKh7UDs946fq6HKSvNT6mILKPs7CRhpp0lxDVw+OEZKoCUOjUyE9+uWk8c8WXp4/Bj3BiA635yL/x7ixVyNB7F9SNH7U6wryMmJw4XJ4d5JqBEvwTnd9kHp50FGm7pE0yU86B9Z2QuDGp9fIpDpeGE7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:57:30.7737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a596d447-bd8b-4c6f-135d-08de89c67005
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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

Testpmd exposes "--rxq-share=[N]" parameter which controls
sharing Rx queues. Before this patch logic was that either:

- all queues were assigned to the same share group
  (when N was not passed),
- or ports were grouped in subsets of N ports,
  each subset got different share group index.

2nd option did not work well with dynamic representor probing,
where new representors would be assigned to new share group.

This patch changes the logic in testpmd to dynamically
assign share group index. Each unique switch and Rx domain
will get different share group.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 app/test-pmd/parameters.c             | 12 +---
 app/test-pmd/testpmd.c                | 82 ++++++++++++++++++++++++++-
 app/test-pmd/testpmd.h                |  2 +-
 doc/guides/testpmd_app_ug/run_app.rst | 10 ++--
 4 files changed, 87 insertions(+), 19 deletions(-)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 3617860830..5d9a5f2501 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -507,7 +507,7 @@ usage(char* progname)
 	printf("  --tx-ip=src,dst: IP addresses in Tx-only mode\n");
 	printf("  --tx-udp=src[,dst]: UDP ports in Tx-only mode\n");
 	printf("  --eth-link-speed: force link speed.\n");
-	printf("  --rxq-share=X: number of ports per shared Rx queue groups, defaults to UINT32_MAX (1 group)\n");
+	printf("  --rxq-share: enable Rx queue sharing per switch and Rx domain\n");
 	printf("  --disable-link-check: disable check on link status when "
 	       "starting/stopping ports.\n");
 	printf("  --disable-device-start: do not automatically start port\n");
@@ -1579,15 +1579,7 @@ launch_args_parse(int argc, char** argv)
 				rte_exit(EXIT_FAILURE, "txonly-flows must be >= 1 and <= 64\n");
 			break;
 		case TESTPMD_OPT_RXQ_SHARE_NUM:
-			if (optarg == NULL) {
-				rxq_share = UINT32_MAX;
-			} else {
-				n = atoi(optarg);
-				if (n >= 0)
-					rxq_share = (uint32_t)n;
-				else
-					rte_exit(EXIT_FAILURE, "rxq-share must be >= 0\n");
-			}
+			rxq_share = 1;
 			break;
 		case TESTPMD_OPT_NO_FLUSH_RX_NUM:
 			no_flush_rx = 1;
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index aad880aa34..81b220466f 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -545,9 +545,17 @@ uint8_t record_core_cycles;
 uint8_t record_burst_stats;
 
 /*
- * Number of ports per shared Rx queue group, 0 disable.
+ * Enable Rx queue sharing between ports in the same switch and Rx domain.
  */
-uint32_t rxq_share;
+uint8_t rxq_share;
+
+struct share_group_slot {
+	uint16_t domain_id;
+	uint16_t rx_domain;
+	uint16_t share_group;
+};
+
+static struct share_group_slot share_group_slots[RTE_MAX_ETHPORTS];
 
 unsigned int num_sockets = 0;
 unsigned int socket_ids[RTE_MAX_NUMA_NODES];
@@ -586,6 +594,73 @@ int proc_id;
  */
 unsigned int num_procs = 1;
 
+static uint16_t
+assign_share_group(struct rte_eth_dev_info *dev_info)
+{
+	unsigned int first_free = RTE_DIM(share_group_slots);
+	bool found = false;
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(share_group_slots); i++) {
+		if (share_group_slots[i].share_group > 0) {
+			if (dev_info->switch_info.domain_id == share_group_slots[i].domain_id &&
+			    dev_info->switch_info.rx_domain == share_group_slots[i].rx_domain) {
+				found = true;
+				break;
+			}
+		} else if (first_free == RTE_DIM(share_group_slots)) {
+			first_free = i;
+		}
+	}
+
+	if (found)
+		return share_group_slots[i].share_group;
+
+	/*
+	 * testpmd assigns all queues on a given port to single share group.
+	 * There are RTE_MAX_ETHPORTS share group slots,
+	 * so at least one should always be available.
+	 */
+	RTE_ASSERT(first_free < RTE_DIM(share_group_slots));
+
+	share_group_slots[first_free].domain_id = dev_info->switch_info.domain_id;
+	share_group_slots[first_free].rx_domain = dev_info->switch_info.rx_domain;
+	share_group_slots[first_free].share_group = first_free + 1;
+	return share_group_slots[first_free].share_group;
+}
+
+static void
+try_release_share_group(struct share_group_slot *slot)
+{
+	uint16_t pi;
+	bool group_not_used = true;
+
+	/* Check if any port still uses this share group. */
+	RTE_ETH_FOREACH_DEV(pi) {
+		if (ports[pi].dev_info.switch_info.domain_id == slot->domain_id &&
+		    ports[pi].dev_info.switch_info.rx_domain == slot->rx_domain) {
+			group_not_used = false;
+			break;
+		}
+	}
+	if (group_not_used) {
+		slot->share_group = 0;
+		slot->domain_id = 0;
+		slot->rx_domain = 0;
+	}
+}
+
+static void
+try_release_share_groups(void)
+{
+	unsigned int i;
+
+	/* Try release each used share group. */
+	for (i = 0; i < RTE_DIM(share_group_slots); i++)
+		if (share_group_slots[i].share_group > 0)
+			try_release_share_group(&share_group_slots[i]);
+}
+
 static void
 eth_rx_metadata_negotiate_mp(uint16_t port_id)
 {
@@ -3315,6 +3390,7 @@ remove_invalid_ports(void)
 	remove_invalid_ports_in(ports_ids, &nb_ports);
 	remove_invalid_ports_in(fwd_ports_ids, &nb_fwd_ports);
 	nb_cfg_ports = nb_fwd_ports;
+	try_release_share_groups();
 }
 
 static void
@@ -4097,7 +4173,7 @@ rxtx_port_config(portid_t pid)
 		if (rxq_share > 0 &&
 		    (port->dev_info.dev_capa & RTE_ETH_DEV_CAPA_RXQ_SHARE)) {
 			/* Non-zero share group to enable RxQ share. */
-			port->rxq[qid].conf.share_group = pid / rxq_share + 1;
+			port->rxq[qid].conf.share_group = assign_share_group(&port->dev_info);
 			port->rxq[qid].conf.share_qid = qid; /* Equal mapping. */
 		}
 
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index af185540c3..9b60ebd7fc 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -675,7 +675,7 @@ extern enum tx_pkt_split tx_pkt_split;
 extern uint8_t txonly_multi_flow;
 extern uint16_t txonly_flows;
 
-extern uint32_t rxq_share;
+extern uint8_t rxq_share;
 
 extern uint16_t nb_pkt_per_burst;
 extern uint16_t nb_pkt_flowgen_clones;
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index ae3ef8cdf8..f4a30e5da9 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -393,13 +393,13 @@ The command line options are:
     Valid range is 1 to 64. Default is 64.
     Reducing this value limits the number of unique UDP source ports generated.
 
-*   ``--rxq-share=[X]``
+*   ``--rxq-share``
 
     Create queues in shared Rx queue mode if device supports.
-    Shared Rx queues are grouped per X ports. X defaults to UINT32_MAX,
-    implies all ports join share group 1. Forwarding engine "shared-rxq"
-    should be used for shared Rx queues. This engine does Rx only and
-    update stream statistics accordingly.
+    Testpmd will assign unique share group index per each
+    unique switch and Rx domain.
+    Forwarding engine "shared-rxq" should be used for shared Rx queues.
+    This engine does Rx only and update stream statistics accordingly.
 
 *   ``--eth-link-speed``
 
-- 
2.47.3

