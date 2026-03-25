Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017DF109C058
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 19:10:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C70B42790;
	Wed, 25 Mar 2026 20:10:02 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68]) by mails.dpdk.org (Postfix) with ESMTP id 801194275B
 for <dev@dpdk.org>; Wed, 25 Mar 2026 20:09:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHVIRULNb31OTzeiQRHPP7hJoNUvoM8HXAhSkN9j3qAB1/HWqoOptonGU+1n2mrPkR/d/+ALxAZYLD4nQ1DwFll8oOGUIxG0WSuquU84vty2XKT5N8N2waz/W6Vx7xRThHcxzp3TknyB8NzS6R2EMeymeFC87vyc2VS4vswTUJ04JRmJJl1P4OYa6J0ADakTovlkkCU4/X8HFH8JGMTJyGRxc9v/OcA2X5HkSl7D8yo1zMgO7kud5qemorjwkwCzhfbn63cGnn7Hf405SxjbG4lmcW9vWKlM8nR99NrkiDf4NLNtFDs3axxQKZGlLGPPK5RRY4nvOp5vM7G6cQVvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP/nO90JHRckFQT8u4qYKqPKMHxxgIcrUcE9bzrGOSw=;
 b=wVK0OsCxJ6H7zjXkp9hLSY76jjQpMb9D0ttoF1Jwd65KbCVSy4Bq/S++95Jo+8Ry6c4VBZpXTtkscrp2eeGlQGY5UdgLmEVJsLRLI+mWsR5agnKaSzNbBGrrCuRqFE3wSnxrYheN6Ruh9YGdhXayXSDmgole9WxfeM5Ot3ZDbnbR1UYtyhWP4+JFDlh2Bbl2vuI75v95vIt2XCAD71Zv9mt4rdCrjwkoV8pKjKrSS1UiPXloilFET/mQvKC43zT2qkcC8v6MwcNRA6zE/38ctpOCXpMQMli5/Wex2ws/qO4ihudmqy3qleHoMlCZMpllQyNkZ5v8NbF6fQE816d1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP/nO90JHRckFQT8u4qYKqPKMHxxgIcrUcE9bzrGOSw=;
 b=alSJAQLVccoWlH0ODuh7/nwle28xl8Otd4LDlHJES0n0VuLvJJqzVG3r+WJCJzwSvVEINTW/lsSwhzyI6rAZNNmCkwwq1kHqaohK5Wu0UMh7DX+emHXQyCF2dXOoaTKXnqlrNuUJjZE9Rik14GuqmmiS9fSKFOwHdmke/maYfRmz3pYlB2jf4RcCubhhlF+dnrC6AwXvtKi6AVWX2J//jZTTrOJBLWnSCLp4f3kqqEqRLo3BcqrTiGX5ffW4MnD580krXt3hG0ffXykntNlGH0BprPpTWZGkUp/Enx5Uztl1tvPV+S5YbiDykhK+dpwsh2t0Ws4H0mF7r/r0HWadYw==
Received: from CH0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:610:b3::20)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 25 Mar
 2026 19:09:53 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::65) by CH0PR03CA0045.outlook.office365.com
 (2603:10b6:610:b3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 19:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:09:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:09:37 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:09:35 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH v4 1/2] app/testpmd: assign share group dynamically
Date: Wed, 25 Mar 2026 20:09:05 +0100
Message-ID: <20260325190906.68531-2-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325190906.68531-1-dsosnowski@nvidia.com>
References: <20260325180255.57489-1-dsosnowski@nvidia.com>
 <20260325190906.68531-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: c746cb14-9373-448e-f2bc-08de8aa2184d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vQ8D3vvPuPK13VMLdTwl1kryZlL7ILs1pCRSb1qiQHBFJBuqV3mNsHepq4bmiI9uHMmxuC0ys/NsPShJ5twIHScU8Vl1ZBilLB0N+4go5Xd0FsphnTjkYfAkGF+swmvZffeiQUhuD8cT32MtCdaT9uJsJftEX1D4dRGgIz8KqBjEid4Ku+IA163GSPklGEkMokTYgqrAQpDQhC/WBkUL5UeHQVg7NEoR+KDlOQcXj2RqfglQjAtsYnCgJ+BgtzTqcqCvRUvqO7QmRii5QAuKM1rY+qtassVGrGXgToE50h+6PcnkgQ2SIasXmCQ21pbiQD3/W9j2LNbL4svzUV2vK7xZ6p9LRDb142vpwRW9wxR9u78xXyaY4fZ72q6dzbvp2OxdaiDejrnaCQdyp5xFA9zWf1akZdAItI1RBiIPGv2dyxE8gxP9iuhAj5/7V1vmfdaj7JHHp73Qp5YGF7Sk4SSqv1cIydtjzUnKI3dTeoYirvRXjBv9XqOebpAbd67GWPP8p3aT4Nr7MCmcHQXxltg6XC4Inw3Y4Bfm73VEbqR7pGvuXr5388dsmKvTTp/QGdPZYKuEwo7SPzSiIi1F1c/uXCAzsOrfTZSi6D3tE8Sse+6qELREi/GqoagA7OwaD+p4k6RXGs166j0ogsmowggS3dsiNbEQ8y/PBzqs7AVSBREFUPlBnyECO+v31ENtoNtAuOsbJ5pOIGH7+MYxo0BQ7giFM/bc32d/3d0fZa0wiNyKBLBTBjX9Z0xgKowTo/jOhoj28fa3PX35459h1g==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: USo7IORRBRjsxCfKlAOp2uIw+y+87iRCG+ztYlgCAMZbjzg+erngaNVARlailAbD2skOLLGULeE/bTFy9clpByoGUvGY2Ns3dJ40BaXldc/cjIij2U3D+AAGB+rlIjp40ouzJ4Wa2XVhsz2HflKkJHO1VQ+fy0hpCVbDs+bXtXK+buOXaC1FBqhwwWaI+0qJ4MDgnYzR+C1NaMYdCK4V3mEARAOyuUPpl5gIfBqOYhMQl+jgy1JKQg8S4OiEACfl/x8xfJyhtE/WTcdeIrVkZqVhPFsToYMNuFI+zuphAZcDd8V49fJ5iCbLN2qqXUEfmSDh+ECd0q0wQ+iEekC1tN5J7r0DIVVoUz8D/1VL/EsGnHiKcqgJ1WgIfXADIKTZ0qF9YXax/ZbKLrMtf7JdVE/AEQNlrVDr58G4JOeDOql3BCi4pp0w+0EQjDdTNTTl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:09:52.9115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c746cb14-9373-448e-f2bc-08de8aa2184d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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
 app/test-pmd/testpmd.c                | 81 +++++++++++++++++++++++++--
 app/test-pmd/testpmd.h                |  2 +-
 doc/guides/testpmd_app_ug/run_app.rst | 10 ++--
 4 files changed, 86 insertions(+), 21 deletions(-)

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
index aad880aa34..e655ddd247 100644
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
@@ -586,6 +594,64 @@ int proc_id;
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
+
+	/* Check if any port still uses this share group. */
+	RTE_ETH_FOREACH_DEV(pi) {
+		if (ports[pi].dev_info.switch_info.domain_id == slot->domain_id &&
+		    ports[pi].dev_info.switch_info.rx_domain == slot->rx_domain) {
+			return;
+		}
+	}
+
+	slot->share_group = 0;
+	slot->domain_id = 0;
+	slot->rx_domain = 0;
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
@@ -3315,6 +3381,7 @@ remove_invalid_ports(void)
 	remove_invalid_ports_in(ports_ids, &nb_ports);
 	remove_invalid_ports_in(fwd_ports_ids, &nb_fwd_ports);
 	nb_cfg_ports = nb_fwd_ports;
+	try_release_share_groups();
 }

 static void
@@ -4097,8 +4164,14 @@ rxtx_port_config(portid_t pid)
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

