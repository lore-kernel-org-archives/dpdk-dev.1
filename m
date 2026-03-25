Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDE9109C04D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:03:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F155F402CE;
	Wed, 25 Mar 2026 19:03:53 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by mails.dpdk.org (Postfix) with ESMTP id F32E14028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 19:03:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKkOhDtvtsl9lBmHsPluAoj4+U5RMnpPg2gZ6H5E9jo+yFGoqYSAmWnjI5aUNSZ8uYPD8ZX2oVCO8LtVkji8APXqyA2ZJNXq0pXR9iIPk7l07w9teKLwMBsJ2z/7jngih9fXt81/sAp5XqoZkt7gY+i/ByutFBBwcWxMe+Y3kXKt7V48dDWzhxfxD1HY/4s3+a5xD5Yog8xN2TP4wdTg5nxmzNd6TymkP5s+Y7keHDJBQEM6gCqnqhXoUIDF9KKVGxKQPt9o0VTgWkrGmAm8M3fvpr57nXM7R3KoR+lD8yGqvgycp1bjJGiCAA8JiALsiB5+y+ieKq9FBntGv/JrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU3CM3tRAJFqQHUfZi72PBiBzOlhn91mCQNtyO/vKUU=;
 b=S1Rdq5ojejQZISj82x+4QrgCXO+uDAgQD8mHpHqcnfQIpNo7ISqkmdj5gqpFcpkM5/BIDYLKYGb1AqGkHo/O66V8pv46mLusPHHNcNXYp3cC0xXdGNa2xEzSYp58/vur/RIzsnJKDjhnAo09LiwYK4OYBxjmgjuoWilMMN4J0B37qu4UjpmrNdyxSbntTR81F5HZfSBUv4z3+R596UviTtG06rkIlSn/grU604tnKWeMP1vWNOISKYjYNBXUQPUFktu1w3upISWg+uWq6hF1EWpnrzd5U7X+HsRDJQvyhwjDW0BZ/WD9UWIH0LrJLMl/ma50g0Kv1u3XK8Ctn83I1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU3CM3tRAJFqQHUfZi72PBiBzOlhn91mCQNtyO/vKUU=;
 b=Kzo04NccheWBE/8TnUJZoAPllcNMyfLOAr0sBhA5H7NLxSd9A1iL48vSVIJts96rtcRfBY1uhXB6eRNOgjLxabhhujl82hf69s1roIChVea+0anXfLMrbMNeULlr7F37oDmzsMG3cG5cSHoVXAJONIxpkR9ZX8PRucOHU5P26KhN7fCcuON/bIIrakd8DcXzBpDzjMmhuDlSTpGyrGcH/Qb94ydae3W94ZHZFL06o8bOfihq6Ie0YrAMp2+vs/2SZuxJ73ZeZVQXiZBogThnU/I6dqsKh2W7Kgm9lPrVhHA9GO2S7cd13nDgkG/XXyg8fkivu+et7ohhYxilzv8g2Q==
Received: from BY5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:1d0::40)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::984) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 18:03:47 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::f1) by BY5PR04CA0030.outlook.office365.com
 (2603:10b6:a03:1d0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 18:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 18:03:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 11:03:29 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 11:03:27 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH v3 1/2] app/testpmd: assign share group dynamically
Date: Wed, 25 Mar 2026 19:02:53 +0100
Message-ID: <20260325180255.57489-2-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325180255.57489-1-dsosnowski@nvidia.com>
References: <20260324165657.23945-1-dsosnowski@nvidia.com>
 <20260325180255.57489-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: 4843fd1a-c6a9-4143-9773-08de8a98dcb2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 02VbEa9FGAx/MEW8FzPOINQEGbqHsezRN0bSKjol6cV5Ez8J6YAioh5ce/zcb8ViH/AUeAhZcHjEJ01R/oghqY9OamHRKrDJKAjeRl78GcDIfum6G7ZcuOJ/hNj2aT6cMPD4AZCGivyQp9FQ9Sks42x1X/kPTAmGlRdNV1OyVONnRwKZ2NV9nlKfboVHlRSrOe/SroUgCPaLCEuKUa/nFg0ZpRnD3RG1/CYCJWwUD6449jsFVQRS/1Ie9ahWVQO64DKO+OaSzfjN7SiC1YwH0ul8ZRE30yjba4WIV39ZhgkX76T8jzYpyfiRyKHb+nqfzCHPwqY1WFsY4vOOyjgz4zRTPNxSC5Sivxyp5pMBld/ekR1SUfsJKqv5TbQs0xVtw6WXRSu+sdGxf9p9fH5tRbEIov+DZcurWchB6O74LfpIXsi9mHkyT8Xd1ywt5Z5TOUsnfkZ9Pn9/+N0MA2OfzK/sK3DIj3czkQ4kI5mHr6LiG0J6wDOCCY7DSVQdO2l2GNfOg37t4n7kO9Kfy3iJsukxFkyIFvuZSxCotCGGS6mwfp16Xdt6PxBcKXmLlcpKVaN45vMZUkL4+8+R0TOQWG+gqcmWmMV3/ezbkPXGSVg4rUgS1lfEOSdTJ5Fw3ddVqgmK2ZmlHRvlG93tA+KPsnOHWChdbX8A/t0TxJ+UQFvF8p2lQDb7/RyzvphToSk4Zmp50ORy1sna4ka84t75KBpEeH68Bk8a3vNytl6RZSZiO1n7v4fgp5MnSGFSiIwk7p+qqVitzipyaZAVKkOKvA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GcXncfPI/s50q33NAw0qIyXZgLuoKHDYWKfwe5yDmKfBvB+H8MDdTMQaKx/p0Z1VouZ/DL61kS2So5GMtYFc19B3ncsO8ElnNvnqhufWQ0Fs6VGMW6QsGLV6nKHlvuYeAKg1RRnW1sDfufT2zObgGAw24hAymqbS0Z6uLCTUA9TrQ8mzBAfoCVZMjYgmqOV6etANIeq2kv6I5pVYZCWxV+3hxr/FzgC5syVW5p7JX2JuAAGQxzrr8ioC2TTAtiWFz50EMFO/HWZkP1C4nXN7bO4+tDjx87wpIXa8hW8ZKRqsqW7Anmf7/mWs7tTEqi5HqHGFzmsjoBcWCYpNEUSmlHViVi9mM8S8nRYOzwmk3D9l8jqAnWPnzupCh5nUFYkFPmpQwhi1i8QwjqNJIv1hKK2YxSrOvyg9P//w7OHvjVNijY147x1zsnYfDN8k8LNl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 18:03:47.4964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4843fd1a-c6a9-4143-9773-08de8a98dcb2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
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
 app/test-pmd/parameters.c             | 14 +----
 app/test-pmd/testpmd.c                | 84 +++++++++++++++++++++++++--
 app/test-pmd/testpmd.h                |  2 +-
 doc/guides/testpmd_app_ug/run_app.rst | 10 ++--
 4 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 3617860830..ecbd618f00 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -351,7 +351,7 @@ static const struct option long_options[] = {
 	NO_ARG(TESTPMD_OPT_MULTI_RX_MEMPOOL),
 	NO_ARG(TESTPMD_OPT_TXONLY_MULTI_FLOW),
 	REQUIRED_ARG(TESTPMD_OPT_TXONLY_FLOWS),
-	OPTIONAL_ARG(TESTPMD_OPT_RXQ_SHARE),
+	NO_ARG(TESTPMD_OPT_RXQ_SHARE),
 	REQUIRED_ARG(TESTPMD_OPT_ETH_LINK_SPEED),
 	NO_ARG(TESTPMD_OPT_DISABLE_LINK_CHECK),
 	NO_ARG(TESTPMD_OPT_DISABLE_DEVICE_START),
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
index aad880aa34..a70efbb03f 100644
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
@@ -586,6 +594,67 @@ int proc_id;
  */
 unsigned int num_procs = 1;
 
+static int
+assign_share_group(struct rte_eth_dev_info *dev_info, uint16_t *share_group)
+{
+	unsigned int first_free = RTE_DIM(share_group_slots);
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(share_group_slots); i++) {
+		if (share_group_slots[i].share_group > 0) {
+			if (dev_info->switch_info.domain_id == share_group_slots[i].domain_id &&
+			    dev_info->switch_info.rx_domain == share_group_slots[i].rx_domain) {
+				*share_group = share_group_slots[i].share_group;
+				return 0;
+			}
+		} else if (first_free == RTE_DIM(share_group_slots)) {
+			first_free = i;
+		}
+	}
+
+	if (first_free == RTE_DIM(share_group_slots))
+		return -ENOSPC;
+
+	share_group_slots[first_free].domain_id = dev_info->switch_info.domain_id;
+	share_group_slots[first_free].rx_domain = dev_info->switch_info.rx_domain;
+	share_group_slots[first_free].share_group = first_free + 1;
+	*share_group = share_group_slots[first_free].share_group;
+
+	return 0;
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
@@ -3315,6 +3384,7 @@ remove_invalid_ports(void)
 	remove_invalid_ports_in(ports_ids, &nb_ports);
 	remove_invalid_ports_in(fwd_ports_ids, &nb_fwd_ports);
 	nb_cfg_ports = nb_fwd_ports;
+	try_release_share_groups();
 }
 
 static void
@@ -4097,8 +4167,14 @@ rxtx_port_config(portid_t pid)
 		if (rxq_share > 0 &&
 		    (port->dev_info.dev_capa & RTE_ETH_DEV_CAPA_RXQ_SHARE)) {
 			/* Non-zero share group to enable RxQ share. */
-			port->rxq[qid].conf.share_group = pid / rxq_share + 1;
-			port->rxq[qid].conf.share_qid = qid; /* Equal mapping. */
+			uint16_t share_group;
+
+			if (assign_share_group(&port->dev_info, &share_group) == 0) {
+				port->rxq[qid].conf.share_group = share_group;
+				port->rxq[qid].conf.share_qid = qid; /* Equal mapping. */
+			} else {
+				TESTPMD_LOG(INFO, "port %u: failed assigning share group\n", pid);
+			}
 		}
 
 		if (offloads != 0)
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
index ae3ef8cdf8..d0a05d6311 100644
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
+    This engine does Rx only and updates stream statistics accordingly.
 
 *   ``--eth-link-speed``
 
-- 
2.47.3

