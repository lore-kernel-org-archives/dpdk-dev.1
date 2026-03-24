Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A36D58CC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 12:38:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0A6040613;
	Tue, 24 Mar 2026 13:37:57 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50]) by mails.dpdk.org (Postfix) with ESMTP id 41F2740664
 for <dev@dpdk.org>; Tue, 24 Mar 2026 13:37:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5dr5+SI4mArwsrN1IEp00/jYzGgLkROfsSkC/IHtkkgA8zuEFY7MryQA5ChBa3ktpRyW159G7lxvcYIpz7zouS5VKM0fvvch5hdVyHeE/2awKp82OPe51sWNP3nlvKoMgP6XFCT8MTxVDMuyOTICmszcF3KZ9X8eEJ4YHKmOoDFpuvIQbT2tBXmxgUydE7eFr0YIeXF0Xq0D99u6twkJseHLLTjmRPUhpfBVhqvHL74ad2/Y+Wkx24WOzjtCG3op2Uqc1/Y0q/l3wyrq04nFaUz9zbfpwGuLQEP+Cgz3vFTGHU1EWCY2oBx51mqj+DAvK+nqzaTCPV5dxoTaaSJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80osBzKfpEZA0z+ZvGpxMdIH5YZS/+s+9EEHDXAvPl0=;
 b=JvYlHpWl/EKp/ZqflfT4rblSgCs371K1OjdcNZlbxs1U9ZxPOy2mz1HtPDkPZGZdA/zu+e4K1cResMD3UOfXygNFLIshX5MqOKBtglusNq0ylnRkU5uOj82PveH4Y+uq67WdOs8KvmoQjJF2yNv+8X1bAbblvwbhG3h3wkL+idfmIlFO7SZljY1l6XknnGXxYXTV3VJ++DubCobeHBbF3H9XzeW6K/RlPlsB08cJtGGdFBEA0MovREXMna0/PJKeLub/rJgLuFYO7hDxUJjqLuSLRo+bQPzpZZbah1Qgr5dPdffRObT2rf1eJMr0QuSyvadNRmqbLyRQhEaAJ2YMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80osBzKfpEZA0z+ZvGpxMdIH5YZS/+s+9EEHDXAvPl0=;
 b=f4LEcXS1saezIPKydmvgv49YcKfBbdKIz05E8g/fEI5yqf9zg3K0kwa9WpcfMaYzfKvG7P69KgSgXTnYm7WP9jCUyz//LXXoPSdrBwmbuJhx2ZcJmANn2DuiInWbafNZTIqBKeyTsDvngV1ygrWQgk6/zCRVv8VOAHnpJCJj+c18n3w1NLrWJe3U5n5nwhEr5wPU64c0lyrQfBXA6s9Cqv4mrHjBvaf3UOHkyhR1H2z3/QXh6kBAWAa0Eu93R1UdhsIiEFuohyikFVwFw3jofl1wIF+8+hySifl2kJgwdgOG8psC01JcRDdtSq4pSySHczQhv6uic4x6d7NE/HBJTA==
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:37:49 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:fb:cafe::f5) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:37:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:37:32 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:37:30 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH 1/2] app/testpmd: assign share group dynamically
Date: Tue, 24 Mar 2026 13:37:08 +0100
Message-ID: <20260324123709.3471-2-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324123709.3471-1-dsosnowski@nvidia.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 42eab592-70af-4176-23e2-08de89a22823
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1fsU+hmMyqvGI/CUqjBTWeM60G9Taa8pATAp5IZ00wH9ZW4hWyxL4c6kk46oeSkgXPhxBl87u2i4/pchrM6CXRYUuw5UWC16BI7NTBDSuL7G4fHuWRXNfTutH9QsSNqedBzG3WzH3a0pqfXqpuBOnRkYjaHvDgmDjV2PJSxgjtqsVnGJ9mvfudX3DorUPPfPlGdsLd1aSCLoBnva08ghNvHcaSNzhtL2YgloX/uKDIrr7B/RrB45MdWeHdxLTMHY/Rmb02wMO53FSAmaIadBM8SytYan7c+3wN7fJ2AiPMWvfo/T8X9kiejFOtHy5MVAxdj3d/hiLJNQCGo6QTA2v6Azd05LMaag8O4ojcYp4lEQb+qf8GrC40aH9T60Vn6DtnCmDl8hPM9NBsMXCdpu3v+XTBAlqsR0nn2zvHYdhK6pVoibsudc0ssfqjcVA2warakkzFaPsTyfbyCnT60hCGwd9p3K3zoR/l3Rjj+2ZFuOBiU516igFddPBgnHresp6qCRNMeN11YgiLKbYJ8GkMtoDYu3+X/2a61NO9GtEreqn0UyQuvZcpNUy6sFNXFqaw9KqkX2Y9MZuM6TpxqXQBo/h5KvukUxDueGaxQOYNOHC/Zc5eYO0YAcAwtFFK9qjyx9ez3e+TNmHh7tdsrohsIoZROZim43CPwWx4bFoJf8u4rwab9wcSv7u8ueTyRCgNaPy6GTTiyBKhOHtWguus/QXmEpMMMlFKZ+8mUEBmxUzLBNa0uWwyhDPp2yxB9I16F35t2W1PET4QSK9s0JFA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G/PztvK3oWbHRBS7C33a6jIOOELUdZQjDZlZyGJcE34D14gmzALRXfUdXfVhULOLfdJgDuTFnZst2FmHQcSe6kyvHKIGSwFaGdJLuNuJ17cC+gdfqCz2vWN9twN2cFHpr22gTuVvPCZ3Q8cF0KFH0t9/SuNYzv14+vGEDsY3DKsLJrXGN1/CVgGxx+ED1voc7BWsrOIXz3XQrVOWKtktUfUIz4fRhkqgu5rdUKy40GF7k2kPKqi1Y3QD1eV0JSA5v+RRREq0R5TCKmB7LhwYDN7PmYG3bWZHBlD4e9K3KjL132hBO3eYZXbLK4EQ+vdrXP8jkzy//XaALulOoJpxYsMvBldQvbj49cIcCrFW7yadT0CoqSp2yBpYKoFZY5sgqhdlFsA9HGwnF2y1Oixcj0XnrfskprLAHOlQqE2BzyWtIVAdnBrmrq+HBELiIJVL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:37:48.2449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eab592-70af-4176-23e2-08de89a22823
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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
 app/test-pmd/parameters.c             | 12 ++-----
 app/test-pmd/testpmd.c                | 49 +++++++++++++++++++++++++--
 app/test-pmd/testpmd.h                |  2 +-
 doc/guides/testpmd_app_ug/run_app.rst | 10 +++---
 4 files changed, 54 insertions(+), 19 deletions(-)

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
index aad880aa34..be8e8299e3 100644
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
+struct share_group_slot share_group_slots[RTE_MAX_ETHPORTS];
 
 unsigned int num_sockets = 0;
 unsigned int socket_ids[RTE_MAX_NUMA_NODES];
@@ -586,6 +594,41 @@ int proc_id;
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
 static void
 eth_rx_metadata_negotiate_mp(uint16_t port_id)
 {
@@ -4097,7 +4140,7 @@ rxtx_port_config(portid_t pid)
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

