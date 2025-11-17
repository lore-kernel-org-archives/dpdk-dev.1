Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6057CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 07:30:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A00224278A;
	Mon, 17 Nov 2025 08:30:54 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013064.outbound.protection.outlook.com
 [40.93.201.64]) by mails.dpdk.org (Postfix) with ESMTP id EDF65402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 08:30:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3GEGC4UDLXlBc6w884RHsQmFfXZwXkCUe/M7bdT7APVIo9yfrJZXE+ZS9CqpxKEb3aH1KX4fcQcXmG0iWn+IxLzO/xrYd5yHq5fSvHL25GP30jwdMdA0tYCNPqHItidgTGa8uzMhBf+XaTZ8PRDnlT9j+Y5dfGIigv4zf74EyPhmSShvFN9vIYBHRqVUy1XzdELOUZYCVwgl+3MyA8j/ZTX50IsgKa4KrepD/xfRIQAfRJ2RUWtnXgHO6qL9WzVPrg+sMivaRGdK8ymKlpTHe5XgJRNT0oeSQ9amvnPpMgtF4uWx+l9APCCQN4gDmRemfFJ0XgLklqqIWLLearftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYQb1UooP4AL8PiGayyyvBW/EDOGk9WbVMCjlHcqIkc=;
 b=BlXkZukVdMoPISaHN+P+JuSOiMbOdK6TV7akDN4EaE2GC9c+wPcGcBg/P7N19hnDIyrCVfkwittb7zs5KbJfchxa650bFL5Mw1PsdP9vDQVAr5OxkZj0EAliROZjSTmJ/NIQzcM1Ccddq1R5ggCMqZRSFUB0JFSImgsJ8K5XOJEvhWajS9ZQx+ZNpEw1n5UVt9beXMnXoMwVFfyL6GZka4MAwP9PBsn1L03iMGougL7Y0UMxhipfoh0bDVqMBMRBmyi+hhzhds6qn1rlrrXUJ39CVAVeDfU1LlutyynovqtzOBCfYv8sOn2AAFWM/HcYl7uETO5pQvos8nq459cTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYQb1UooP4AL8PiGayyyvBW/EDOGk9WbVMCjlHcqIkc=;
 b=dflZOpw5epyfIZuf6j9y8xJM8+oxpx8RYqiIHH9W8vTnRD6yFUCDlKRVqHXTjEM58zOJyF0JfgECyoIJvAH20jHM8tIZVDAm7hKPXkz0rzKGWpWl2uJaYaIxuOXPeX04VyiyC5/PDwxeWz4Bm+6UF/sBC571k/hnSC0MLEWRs8WcT3HMLDDISsMu2KBM8Ff+aWtzY6R5g7qfZfNZpkNnY76w3Q95+O5KxtkDtSznScLq+qtNqdTdbyIP5ty+l8tM8rK6r61jeb2sSP2gZ+w7PT6qNXniF6tD0lljlTBJm/ENhSL4v5w8JC2D+Si3lDVeYv/KzLx5Z05NesR0+t1wyA==
Received: from DM6PR21CA0025.namprd21.prod.outlook.com (2603:10b6:5:174::35)
 by IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 07:30:48 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::49) by DM6PR21CA0025.outlook.office365.com
 (2603:10b6:5:174::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.2 via Frontend Transport; Mon,
 17 Nov 2025 07:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 07:30:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:30:30 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:30:25 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <wisamm@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH] test-flow-perf: support measuring 2nd round rate
Date: Mon, 17 Nov 2025 09:30:08 +0200
Message-ID: <20251117073008.9344-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b845d4d-a312-430a-acaa-08de25ab3a50
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uGEnHaNmv612DossCwIt4fLNWeB81heJ8vaQqMJ616AkKRYc07O/6o/yEeWY?=
 =?us-ascii?Q?3MNzyZ4NLNSbK60LzRSdLEQaI+BIoxQoeLfw/a2LwM05YnQVtqPXct9cMsLh?=
 =?us-ascii?Q?P2AIhopN633qVkIJJ5KqSmcwI7abeTDdT0xLqFa1P5ukhuS9nYVFkODbaqph?=
 =?us-ascii?Q?1ulv5CbhgDLUZ0FIzHzfsz4AXv63zSNQ2o/roI2l4ux1IrZqZ+7ESjmWnaMs?=
 =?us-ascii?Q?magG7r4Gc02u1oBbRnYKxsckAT0wvADS5LZ6vsbKmK1RFdBKbDL05GhW5PcV?=
 =?us-ascii?Q?WGLgQSHmEXxWS9T1dJW8zN6tKQVwywVZT1Dcd42RPHvV54nlxlincNpe3f6S?=
 =?us-ascii?Q?/bsb14rTrFzJ65EPlopH/sOxwGl2MIlHi9jxSnFHBFWmoBkuvnLlaJcxMPdX?=
 =?us-ascii?Q?/3jrtdKjUpFD/Ap+niLPLNYz2CHTIgRncxS6MNpEzhFJrXDcGrwSD7NxPRcN?=
 =?us-ascii?Q?lO1A/lshijjEewO7ourExkYufbPBjtF1XWv0uGaJ3g+NdrlN1Tt9D1u24Y6v?=
 =?us-ascii?Q?/K0M5WDrjYLo1hxjNoR7bttvPROvYM1LIzVtMeiD82a5yUB/i5u0WQzklYkf?=
 =?us-ascii?Q?9X7FsPfXVtWHsb/hYHx6VzKgVet1Skv8uC12s89GxcnRKLGhrxIAuJpzT+YZ?=
 =?us-ascii?Q?IuUrMMvsIZnYV1CgFlMbz/WoMan6VQD/D8Zh128Bsvs4cHl7uLTBRIbO7IvG?=
 =?us-ascii?Q?0mPFfo5UE9sQIyiKzMw4wjipqbul13bBmCwYyS6N0nmxhkr9MR8iS11OLfFv?=
 =?us-ascii?Q?GlwLwu9lQIKs23VFa2Xbv5+IWJRRP8mKMl46Xv3bpXqwczwucg1xknG3cLzI?=
 =?us-ascii?Q?Gp2PrPFHRWItKDAX5OWwUrpbR1UMM+0kJM1D3UILzSEGLEYT+ZD9hqXjSOda?=
 =?us-ascii?Q?fGgYmg7CxbSFFwecnnrmPAWb70XNa+r6Sw84lDLxOCSlkwN/u1tXsaY5PFdi?=
 =?us-ascii?Q?zcZEVh+eS5WQtzJK81i40lbieXo7A5mciTuwXsJ7w0vIpGBFMu2mKC5QJ0Np?=
 =?us-ascii?Q?IYsWZSL2c0h30vob9vKbqFRtmCSzGwsomlZ2WBOOB4B9i9dJl8RAE122eBtf?=
 =?us-ascii?Q?LXzEygZe4oxe54+ekzBinkrrlldIyNKG2woTJLs8tgFY8Y1WvNx4MdevLw+h?=
 =?us-ascii?Q?mDHhW35RuP8R/DCAI7xHhV0n0oM50xvzCnr6wl2ztfb7ZxOMIzpdAnFJKs1e?=
 =?us-ascii?Q?Hmei97YHdaWZ4OQc7dJl9bKzLtus2SbaPOalj+aPQ3/p2Ex0MWkxNr9+eZ2b?=
 =?us-ascii?Q?EmSbyARA7N6/zYUnd5BGLnx/KYbhuNcFXiuZZDdwJgPwn13aeysxr4w15EU4?=
 =?us-ascii?Q?peh0VOz8w9SZocvx8SJYp35untGa8wFukgRbOuYmC56AXdXKXkrev/xQGreW?=
 =?us-ascii?Q?nNW2olQpK2pE3vYc4RGU8uCCLTmqOsHF+2IIaVShSioVjg//vIif6iwwK5Sk?=
 =?us-ascii?Q?Pf/iJojJirENaU3Wlun4Dohfj4y1T9unw7js5nizde8u+hUPTBfwPvF1pB4w?=
 =?us-ascii?Q?IqYowHVjlIOrakJxA99a7NZ/5oqjuJXNZoCVQGDi74WItdVY0oceAMhpQJoA?=
 =?us-ascii?Q?3jfsRsiY4wAkUyPtUuY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:30:47.9725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b845d4d-a312-430a-acaa-08de25ab3a50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788
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

In some driver, the flow table may start from a small size and
increase based on the rules number. The table resize may not reflact
the actual rules insertion rate due to the extra overhead.

Keeping 1 rule in the table and measuring the 2nd iteration would
be more accurate.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 app/test-flow-perf/main.c | 103 ++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 20 deletions(-)

diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index a8876acf1f..06ebdc2d02 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -81,6 +81,7 @@ static bool enable_fwd;
 static bool unique_data;
 static bool policy_mtr;
 static bool packet_mode;
+static bool no_rehash;
 
 static uint8_t rx_queues_count;
 static uint8_t tx_queues_count;
@@ -142,6 +143,9 @@ struct __rte_cache_aligned multi_cores_pool {
 	int64_t current_alloc[RTE_MAX_LCORE];
 };
 
+/* In case the matcher is destroyed. */
+static struct rte_flow *placeholder_flows[RTE_MAX_ETHPORTS][RTE_MAX_LCORE];
+
 static struct multi_cores_pool mc_pool = {
 	.cores_count = 1,
 };
@@ -659,6 +663,7 @@ args_parse(int argc, char **argv)
 		{ "rules-count",                1, 0, 0 },
 		{ "rules-batch",                1, 0, 0 },
 		{ "dump-iterations",            0, 0, 0 },
+		{ "second-run",                 0, 0, 0 },
 		{ "deletion-rate",              0, 0, 0 },
 		{ "query-rate",                 0, 0, 0 },
 		{ "dump-socket-mem",            0, 0, 0 },
@@ -864,6 +869,9 @@ args_parse(int argc, char **argv)
 					"rules-count") == 0) {
 				rules_count = atoi(optarg);
 			}
+			if (strcmp(lgopts[opt_idx].name, "second-run") == 0) {
+				no_rehash = true;
+			}
 			if (strcmp(lgopts[opt_idx].name, "random-priority") ==
 			    0) {
 				end = NULL;
@@ -1333,21 +1341,27 @@ destroy_flows(int port_id, uint8_t core_id, struct rte_flow **flows_list)
 	double deletion_rate;
 	double cpu_time_per_batch[MAX_BATCHES_COUNT] = { 0 };
 	double delta;
-	uint32_t i;
+	uint32_t i = 0;
 	int rules_batch_idx;
 	int rules_count_per_core;
 
+	memset(&error, 0x33, sizeof(error));
 	rules_count_per_core = rules_count / mc_pool.cores_count;
 	/* If group > 0 , should add 1 flow which created in group 0 */
-	if (flow_group > 0 && core_id == 0)
+	if (flow_group > 0 && core_id == 0 && flows_list[i] != 0) {
+		if (rte_flow_destroy(port_id, flows_list[i], &error)) {
+			print_flow_error(error);
+			rte_exit(EXIT_FAILURE, "Error in deleting default jump flow\n");
+		}
+		i++;
 		rules_count_per_core++;
+	}
 
 	start_batch = rte_get_timer_cycles();
-	for (i = 0; i < (uint32_t) rules_count_per_core; i++) {
+	for (; i < (uint32_t) rules_count_per_core; i++) {
 		if (flows_list[i] == 0)
 			break;
 
-		memset(&error, 0x33, sizeof(error));
 		if (rte_flow_destroy(port_id, flows_list[i], &error)) {
 			print_flow_error(error);
 			rte_exit(EXIT_FAILURE, "Error in deleting flow\n");
@@ -1470,7 +1484,7 @@ insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
 	double cpu_time_per_batch[MAX_BATCHES_COUNT] = { 0 };
 	double delta;
 	uint32_t flow_index;
-	uint32_t counter, start_counter = 0, end_counter;
+	uint32_t counter, start_counter = 0, end_counter, first_tick = 0;
 	uint64_t global_items[MAX_ITEMS_NUM] = { 0 };
 	uint64_t global_actions[MAX_ACTIONS_NUM] = { 0 };
 	int rules_batch_idx;
@@ -1525,15 +1539,8 @@ insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
 			core_id, rx_queues_count,
 			unique_data, max_priority, &error);
 
-		if (!counter) {
-			first_flow_latency = (double) (rte_get_timer_cycles() - start_batch);
-			first_flow_latency /= rte_get_timer_hz();
-			/* In millisecond */
-			first_flow_latency *= 1000;
-			printf(":: First Flow Latency :: Port %d :: First flow "
-				"installed in %f milliseconds\n",
-				port_id, first_flow_latency);
-		}
+		if (!counter && !placeholder_flows[port_id][core_id])
+			first_tick = rte_get_timer_cycles();
 
 		if (force_quit)
 			counter = end_counter;
@@ -1561,6 +1568,29 @@ insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
 		}
 	}
 
+	if (first_tick) {
+		first_flow_latency = (double) (first_tick - start_batch);
+		first_flow_latency /= rte_get_timer_hz();
+		/* In millisecond */
+		first_flow_latency *= 1000;
+		printf(":: First Flow Latency :: Port %d :: First flow "
+			"installed in %f milliseconds\n",
+			port_id, first_flow_latency);
+	}
+
+	if (no_rehash && !placeholder_flows[port_id][core_id]) {
+		flow = generate_flow(port_id, flow_group, flow_attrs, flow_items,
+				     flow_actions, JUMP_ACTION_TABLE, counter,
+				     hairpin_queues_num, encap_data, decap_data,
+				     dst_port_id, core_id, rx_queues_count,
+				     unique_data, max_priority, &error);
+		if (!flow) {
+			print_flow_error(error);
+			rte_exit(EXIT_FAILURE, "Error in creating placeholder flow\n");
+		}
+		placeholder_flows[port_id][core_id] = flow;
+	}
+
 	/* Print insertion rates for all batches */
 	if (dump_iterations)
 		print_rules_batches(cpu_time_per_batch);
@@ -1579,6 +1609,21 @@ insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
 	return flows_list;
 }
 
+static void
+cleanup_placeholder_flow(int port_id, uint8_t core_id)
+{
+	struct rte_flow_error error;
+
+	if (!placeholder_flows[port_id][core_id])
+		return;
+	memset(&error, 0x33, sizeof(error));
+	if (rte_flow_destroy(port_id, placeholder_flows[port_id][core_id], &error)) {
+		print_flow_error(error);
+		rte_exit(EXIT_FAILURE, "Error in deleting placeholder flow\n");
+	}
+	placeholder_flows[port_id][core_id] = NULL;
+}
+
 static void
 flows_handler(uint8_t core_id)
 {
@@ -1613,17 +1658,36 @@ flows_handler(uint8_t core_id)
 			query_flows(port_id, core_id, flows_list);
 
 		/* Deletion part. */
+		if (delete_flag || no_rehash) {
+			destroy_flows(port_id, core_id, flows_list);
+			if (has_meter())
+				meters_handler(port_id, core_id, METER_DELETE);
+			rte_free(flows_list);
+		}
+
+		if (!no_rehash)
+			continue;
+
+		mc_pool.last_alloc[core_id] = (int64_t)dump_socket_mem(stdout);
+		if (has_meter())
+			meters_handler(port_id, core_id, METER_CREATE);
+		flows_list = insert_flows(port_id, core_id, dst_ports[port_idx++]);
+		if (flows_list == NULL)
+			rte_exit(EXIT_FAILURE, "Error: Insertion Failed!\n");
+		mc_pool.current_alloc[core_id] = (int64_t)dump_socket_mem(stdout);
+
 		if (delete_flag) {
 			destroy_flows(port_id, core_id, flows_list);
 			if (has_meter())
 				meters_handler(port_id, core_id, METER_DELETE);
+			rte_free(flows_list);
 		}
+		cleanup_placeholder_flow(port_id, core_id);
 	}
 }
 
 static void
-dump_used_cpu_time(const char *item,
-		uint16_t port, struct used_cpu_time *used_time)
+dump_used_cpu_time(const char *item, uint16_t port, struct used_cpu_time *used_time)
 {
 	uint32_t i;
 	/* Latency: total count of rte rules divided
@@ -1694,10 +1758,8 @@ dump_used_cpu_time(const char *item,
 				/ query_throughput_time) / 1000);
 
 	/* Latency stats */
-	printf("\n%s\n:: [Latency | Insertion] All Cores :: Port %d :: ",
-		item, port);
-	printf("Total flows insertion rate -> %f K Rules/Sec\n",
-		insertion_latency);
+	printf("\n%s\n:: [Latency | Insertion] All Cores :: Port %d :: ", item, port);
+	printf("Total flows insertion rate -> %f K Rules/Sec\n", insertion_latency);
 	printf(":: [Latency | Insertion] All Cores :: Port %d :: ", port);
 	printf("The time for creating %d rules is %f seconds\n",
 		mc_pool.rules_count, insertion_latency_time);
@@ -2296,6 +2358,7 @@ main(int argc, char **argv)
 			printf("Failed to stop device on port %u\n", port);
 		rte_eth_dev_close(port);
 	}
+	rte_eal_cleanup();
 	printf("\nBye ...\n");
 	return 0;
 }
-- 
2.34.1

