Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3181DC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 02:37:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A456402D9;
	Thu,  8 May 2025 04:37:05 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023083.outbound.protection.outlook.com
 [40.107.44.83]) by mails.dpdk.org (Postfix) with ESMTP id 86CEA4014F
 for <dev@dpdk.org>; Thu,  8 May 2025 04:37:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r89h1ZxcXDy/X3qAAb09JpGpKVh0eHC2tC/8RueiyyGwU3WWLabbjSgg8FngY7+i2+bik2yInciiP+yijulGTeiT9eygduPMqnkFghZt237IT9T9NvFB8AA5XbpailpkdRTyOWECLLdUtxPKYolK5ipe2troCdTzSUxE0sy2Cj0d/X79aLbFSZeFBqkDO3926piby3ljejmgMdS3c+BCBaRxO8+JWxrCgOF0rFdWRqKMxzMemFdqBAYAFcqd9jqlJx5tmLRFmAaczgKWPixCwJntTgW7lh2RfXP9PrMlJZvnuiE9elRjgkCv8hl99QDC4gWnjwyWRRP7PlpNiBdrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RCkCi7TXb4k0RHoSnNkYo7ZYWp3gmK6+Ui918HfrcU=;
 b=jqrugyMsL+V05+6uoKZFoZu2yzh4/LEylwQcaoTwdH4ym8w+jTxfPPTwtiLcmTF3p9luq4L3NXwprJ/hsho/plxzcOmJLxUpWDKeK/6Z9tUSC/e/rtTFIetRxD2vd8I7OHRMV6hri5iBLWPC9kBtdc/sPIn4NstJTcPVps6lEgC/ELxlzEx5gWU5ioW4uwYO+OiyN5v6/LbWZyRuafUEqxREZrA7NwIZk2jsdUfmTtbSV6RA+UUnnlKdpKneCIsljJwOosGEw7dtBg1jmgEpfOrxsjQXAergtcZFMrRjUl9G+4VTlnlcjC1HeALvUXrUjRjleRR7kUMXtWs/L7kmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RCkCi7TXb4k0RHoSnNkYo7ZYWp3gmK6+Ui918HfrcU=;
 b=HcYFKtlyAyTnG+YTUMtJcxT0LRh6JaDinMe9f9FPbCyYunsyagdHMSNNf46ChYC6DAharQ7iOJQULVxCGw5iNTsT+eO9WaUb7I/XYHxQGq1pPD4yjY1bwa2wl7uVyIYUYVwyqFYhxSr/ybjkOoMyYhBCoJV5wR4v8vLkJ5tNkFG9KVFaO1fUZ7ZR6caRm048t7MiS4MDH6HtnKpVCXoUZuswiV+6vTHm5LlZKnehVgSwjFivcCy+3SPRzY49Un9x5zVggGK+L5yUBOlwHWGsAFM19DzFt8CAw+ijM8h2SE8wb2D4tyYQ+7DjuaHaDeUFrix8kKnwF24r0ouBObFGcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by SEZPR06MB5966.apcprd06.prod.outlook.com
 (2603:1096:101:ee::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 8 May
 2025 02:37:00 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%5]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 02:37:00 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: wisamm@nvidia.com
Subject: [PATCH] app/test-flow-perf: support testing the flow tables query rate
Date: Thu,  8 May 2025 10:36:38 +0800
Message-Id: <20250508023638.37812-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|SEZPR06MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 080c6a76-add1-402c-fbfd-08dd8dd93572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EpKOemPfd75ZcM9sfvNQDe5uvZN5/Q8CDBwLtz2g8j+GVShAedPicvXfkd0i?=
 =?us-ascii?Q?5aBKQj/NchIguYDHBcenuuEF46on5ZchoavdBy4k10HqPW6+K18P+cetpLQ/?=
 =?us-ascii?Q?iJK4sXMibI0LOLgH24SbKNFasn9BRh+OHkyw0tH9feiZeHXft0nvoEbGdmbS?=
 =?us-ascii?Q?+XOFF+b5VR3RulGC7zZTFZcwnHBm20EF+66yuq59QY2sMiXlv3RwtW3UF1SX?=
 =?us-ascii?Q?VNbCFRg3wvM+8aIOVpp34qScki2z6IutKXcD1gLcDrTB0wYQ7n0EhYZ5L2Yf?=
 =?us-ascii?Q?E/zM01j+i0IoUs+vSz5wvgIRsfCbpvkctMW2gWbn+vA46vw2G7nKSanzMGyH?=
 =?us-ascii?Q?s/dByHoJcFp0VS1kDoRwbA22B+OvV1/peWcR5Mq1gDK/AmOkCESMLDnuG8Y5?=
 =?us-ascii?Q?KMtJvvD04Zgw88THHo8b7frWX9zzpuSizu6G3fCj6Yjm3xNiHiG3llNAitZ+?=
 =?us-ascii?Q?NfuCDMo1UZE2BQ3OKpcP5yoL+NzBR1cn6C0Pd+Wudw+abCygc8jb5sB9delt?=
 =?us-ascii?Q?2VN4hoE/uu55yJKrQJV1C/KaS/I4YiqggDr8jC67efj+hSQq0IK3tL4VKI0b?=
 =?us-ascii?Q?agobLLbT8Hk1o3rFjG5ODFPpLA+gZAvr7HArv5tDtDXsUlOf+cs9xicIONak?=
 =?us-ascii?Q?Ikj/cOmjlOJVpQX4xinn/v1W2w63APdcLjlgtE0hUys2e4IjcMzkqRSysCJy?=
 =?us-ascii?Q?qn7G7DzKlkrzjZbCgwM6UijhFnLSrKu9WDsfYaZs5YboJLaQR8cJANVOcW4N?=
 =?us-ascii?Q?dxfhiPf7JnIwjPbarbrqPLLC7bkRRx+daGtIjDvqEXRc/XbN9c0JMmIOfHmO?=
 =?us-ascii?Q?JOEQdI6lo82XOwcq6gzU27/D84gX8Gp69X93yPE0MQcJ3efYif1RNTKfZ2R/?=
 =?us-ascii?Q?y+y8haUbV2qDQ9KLuTx66477swBDoKovQvU7P6rIlk2qALrGE1gmZjrDPNhf?=
 =?us-ascii?Q?MheKIi9GzoIZo7FFT1EhjK+wvU1W2EI086H91X4Z7Te7rYWnrcAvfKWMPwB1?=
 =?us-ascii?Q?3YTklIcCNnrJHILaka5m85h14+maBbGp2K5X3e3ngbTe7QcaVyvcxXTj1YsQ?=
 =?us-ascii?Q?n3TxyXFoAT06y4H71lbqV9TkVlVXov4XmLleXltaYDo7jCvRI83hanKDiAEe?=
 =?us-ascii?Q?yViAIMAiE8B+cccc+qbIFHNqFtJjt5UrUnxvTO7U3Fujw9kAmEei10SefBaR?=
 =?us-ascii?Q?xgWQbLB2Do0RQ/Lhe4uoHRYqzXhhDbW3YSDzJ9NqNppGKJYQqwzUPGQYc/uf?=
 =?us-ascii?Q?d1LRzv8jkEd0LfokC450V9oJelP46lgIfdsMSoJo0kcHRllSnP6aM+5IunQD?=
 =?us-ascii?Q?qAb3ajkWglaBfuQGcogeCW8Ld9FErpSb01wlWJZwuRPXqIzgv4e8EB++MSKM?=
 =?us-ascii?Q?QfiCF3FpgIzTCCCfHV5Jx7npAud6Nnyw9tt97EPQp2u06yWlJMSXJv6lIzTs?=
 =?us-ascii?Q?CtPVwM6E7OVoQr0PywmABV02DaRZt2M+hgtoA+0yqDFTiSQeLkwtXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pY1fk+jzMPKtgKiegjrN8SjOP0o6T77zlE0oeq1LpLI9PHrQNPfVoxVPnHr/?=
 =?us-ascii?Q?HbVEbJumkr/+kAtRo0HZalC415Cv8KxcVzxyj6etivgQegW953byk/xnoSyB?=
 =?us-ascii?Q?llU9bwWt8R9MDT3WmGtww/gj7nhQDfR1KFf7zG1K4l/sUpsPxbfJc+o/Xmxg?=
 =?us-ascii?Q?XYCe4QYhX2eaX9RLQZ6Skia/ZQfRJpnKqPeYmoGDLw9a4tNl4su6vmZlu6Tg?=
 =?us-ascii?Q?qVmaRdpv1SVRhLvA17PKzldTakCVLl4L/vziIcgllkLGziRIMVmCE88KrxV4?=
 =?us-ascii?Q?/U35MFih8PW/lNA5jshJNKzC7n3/hAGtqfqhwW/rroQOR7w2N1ZJquZ4HUox?=
 =?us-ascii?Q?a/xhGu09Sb0bRnAAPIO21gu6HtFFhZ5cjTXWWFkSmVxkMTUqXqbf8QytyUN5?=
 =?us-ascii?Q?ASZa+++/FByzzLHHbUcaWXX4I6KsXjSjcOK4SkWl4OASEPLooujZjeefnC5t?=
 =?us-ascii?Q?PDTKk4yfCgyIxsTv9KfyySbQinAzNDsceGgIBkSf5SlXqO9EL2JVZI89yjfm?=
 =?us-ascii?Q?dwJdV1HOeO0mXlb2Ed0cgErJQCYXlogJCuHRtDBnLF2EF4ukHMaC54/MGtCu?=
 =?us-ascii?Q?Ab0ajazEODjJ/a8gb423GIKdpgYBcRI/Y7nuHdo459tZCQyI+D2KwxVQGZGl?=
 =?us-ascii?Q?tCAPh9wmxpWQBVLmalTrIb+QDA4xkGAUkPDyFxOfiuoaH0h77RFF5s9TAILp?=
 =?us-ascii?Q?s6G0r8zOGhxT8CqLQC1Pv3MfTo+amVL6uKRIw9GUDhZuO33QEY5AN2f61sqb?=
 =?us-ascii?Q?7srU5G54mGyPHRvOCzHl+18mrnIRzfwT+neR2dOXJh19cDtjwwIcnSv8oRNf?=
 =?us-ascii?Q?pSs5JDjfYIcQiU6OwqIIz+jWFbBSDJm+Cnw6Yn1QgMXWVi2IYPEPAGkDxFMW?=
 =?us-ascii?Q?kZnAeGJxdAE/r7ylgz93w0ExqUpZahh76o9ZWOq1Ca2M2mWgxLWW9O9rr7Xo?=
 =?us-ascii?Q?T0xaJGHORTSOVZfAVtIXGG3c3AKodnr5erpEaNkxFJwgUXrqzDUCp/5TP8yN?=
 =?us-ascii?Q?l8ubIycD3vumTONVnBGs5OfBNbLnRoZKI+qT557yQt0ufUryZxbgEvJ/VVZS?=
 =?us-ascii?Q?yW1G9zULxhcHgXpisAv3vg2td+lVDhvt+795sXXjOx6uWDhzRVPcQ2AIO/iK?=
 =?us-ascii?Q?GWbn3T47mY3t4iiGxez85xzHYBi8Vu0AMh6/5BgJ7vp3PsRGCnJ/Zaij0U55?=
 =?us-ascii?Q?N4AOMXRCiuPwC94vi34D8DPBG9WyUeRPwoesYkK+kOkGCWZCwc/JCuejVldO?=
 =?us-ascii?Q?sa0pBHyJa8wnPxhUk+zGZHUTqVxgihi2Jy5jKWvZ+UhXTvfnyfPDO1zx93+E?=
 =?us-ascii?Q?15PbWCpQo1UBi8nvgUSjK4Rp85/wORPYFdovr87tPFFHxZsln5OT5x5jFn3P?=
 =?us-ascii?Q?dbHFCwdzdqBYQB3objPXTHdPf16vZmcj0QjG+jqYgUhGtOMGwBXk5/K0N36H?=
 =?us-ascii?Q?NEi/InNfQ/E0+iFHZSMYZPhR5b0SKFV+s3r8XGnDzqogSEqMT99PP8RtqWgo?=
 =?us-ascii?Q?wkEv09DwtLdvyFtsjPe6DD5O4w893RBZJQ744tMwjp4XWRSlMb6q6mYeLn+2?=
 =?us-ascii?Q?XfBUoWqauLvBkn8dXf9qOledjwOgbpKOm3g3nVx2ANRPYFAvKYusbGj5t8v6?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080c6a76-add1-402c-fbfd-08dd8dd93572
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 02:37:00.3291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCPaBn0VR9fhSoK1AK7Y5GQvXSot4RPv0f8QiAw13ELBDvvSiwXE+ftwfVgdeGaMvBrlvwepjolkztM0jDTOjtuymYFe7cTFFpfu5wMTNac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5966
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

Support testing the flow tables query rate.

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>

---
:: [Latency | query] All Cores :: Port 0 :: Total query rate ->
951.138132 K Rules/Sec
:: [Latency | query] All Cores :: Port 0 :: The time for query 10000
rules is 0.010514 seconds
:: [Throughput | query] All Cores :: Port 0 :: Total query rate ->
951.138132 K Rules/Sec
:: [Throughput | query] All Cores :: Port 0 :: The average time for
query 10000 rules is 0.010514 seconds
---
 app/test-flow-perf/main.c | 119 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index 07ddfe0e46..ff9f7b1eaa 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -75,6 +75,7 @@ static uint16_t dst_ports[RTE_MAX_ETHPORTS];
 static volatile bool force_quit;
 static bool dump_iterations;
 static bool delete_flag;
+static bool query_flag;
 static bool dump_socket_mem_flag;
 static bool enable_fwd;
 static bool unique_data;
@@ -129,6 +130,7 @@ static struct lcore_info lcore_infos[RTE_MAX_LCORE];
 struct used_cpu_time {
 	double insertion[MAX_PORTS][RTE_MAX_LCORE];
 	double deletion[MAX_PORTS][RTE_MAX_LCORE];
+	double query[MAX_PORTS][RTE_MAX_LCORE];
 };
 
 struct __rte_cache_aligned multi_cores_pool {
@@ -488,6 +490,7 @@ usage(char *progname)
 		" iteration\n");
 	printf("  --deletion-rate: Enable deletion rate"
 		" calculations\n");
+	printf("  --query-rate: Enable query rate calculations\n");
 	printf("  --dump-socket-mem: To dump all socket memory\n");
 	printf("  --enable-fwd: To enable packets forwarding"
 		" after insertion\n");
@@ -656,6 +659,7 @@ args_parse(int argc, char **argv)
 		{ "rules-batch",                1, 0, 0 },
 		{ "dump-iterations",            0, 0, 0 },
 		{ "deletion-rate",              0, 0, 0 },
+		{ "query-rate",                 0, 0, 0 },
 		{ "dump-socket-mem",            0, 0, 0 },
 		{ "enable-fwd",                 0, 0, 0 },
 		{ "unique-data",                0, 0, 0 },
@@ -883,6 +887,9 @@ args_parse(int argc, char **argv)
 			if (strcmp(lgopts[opt_idx].name,
 					"deletion-rate") == 0)
 				delete_flag = true;
+			if (strcmp(lgopts[opt_idx].name,
+					"query-rate") == 0)
+				query_flag = true;
 			if (strcmp(lgopts[opt_idx].name,
 					"dump-socket-mem") == 0)
 				dump_socket_mem_flag = true;
@@ -1375,6 +1382,81 @@ destroy_flows(int port_id, uint8_t core_id, struct rte_flow **flows_list)
 	mc_pool.flows_record.deletion[port_id][core_id] = cpu_time_used;
 }
 
+static inline void
+query_flows(int port_id, uint8_t core_id, struct rte_flow **flows_list)
+{
+	struct rte_flow_error error;
+	clock_t start_batch, end_batch;
+	double cpu_time_used = 0;
+	double query_rate;
+	double cpu_time_per_batch[MAX_BATCHES_COUNT] = { 0 };
+	double delta;
+	uint32_t i;
+	int rules_batch_idx;
+	int rules_count_per_core;
+	union {
+		struct rte_flow_query_count count;
+		struct rte_flow_action_rss rss_conf;
+		struct rte_flow_query_age age;
+	} query;
+	struct rte_flow_action count_action[] = {
+		{
+			.type = RTE_FLOW_ACTION_TYPE_COUNT,
+			.conf = NULL,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+
+	rules_count_per_core = rules_count / mc_pool.cores_count;
+	/* If group > 0 , should add 1 flow which created in group 0 */
+	if (flow_group > 0 && core_id == 0)
+		rules_count_per_core++;
+
+	memset(&query, 0, sizeof(query));
+	start_batch = rte_get_timer_cycles();
+	for (i = 0; i < (uint32_t)rules_count_per_core; i++) {
+		if (flows_list[i] == 0)
+			break;
+
+		memset(&error, 0x33, sizeof(error));
+		if (rte_flow_query(port_id, flows_list[i],
+				   count_action, &query, &error)) {
+			print_flow_error(error);
+			rte_exit(EXIT_FAILURE, "Error in deleting flow\n");
+		}
+
+		/*
+		 * Save the query rate for rules batch.
+		 * Check if the query reached the rules
+		 * patch counter, then save the query rate
+		 * for this batch.
+		 */
+		if (!((i + 1) % rules_batch)) {
+			end_batch = rte_get_timer_cycles();
+			delta = (double)(end_batch - start_batch);
+			rules_batch_idx = ((i + 1) / rules_batch) - 1;
+			cpu_time_per_batch[rules_batch_idx] = delta / rte_get_timer_hz();
+			cpu_time_used += cpu_time_per_batch[rules_batch_idx];
+			start_batch = rte_get_timer_cycles();
+		}
+	}
+
+	/* Print query rates for all batches */
+	if (dump_iterations)
+		print_rules_batches(cpu_time_per_batch);
+
+	/* query rate for all rules */
+	query_rate = ((double)(rules_count_per_core / cpu_time_used) / 1000);
+	printf(":: Port %d :: Core %d :: Rules query rate -> %f K Rule/Sec\n",
+		port_id, core_id, query_rate);
+	printf(":: Port %d :: Core %d :: The time for query %d rules is %f seconds\n",
+		port_id, core_id, rules_count_per_core, cpu_time_used);
+
+	mc_pool.flows_record.query[port_id][core_id] = cpu_time_used;
+}
+
 static struct rte_flow **
 insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
 {
@@ -1526,6 +1608,9 @@ flows_handler(uint8_t core_id)
 			rte_exit(EXIT_FAILURE, "Error: Insertion Failed!\n");
 		mc_pool.current_alloc[core_id] = (int64_t)dump_socket_mem(stdout);
 
+		if (query_flag)
+			query_flows(port_id, core_id, flows_list);
+
 		/* Deletion part. */
 		if (delete_flag) {
 			destroy_flows(port_id, core_id, flows_list);
@@ -1552,8 +1637,11 @@ dump_used_cpu_time(const char *item,
 	double insertion_throughput_time;
 	double deletion_latency_time;
 	double deletion_throughput_time;
+	double query_latency_time;
+	double query_throughput_time;
 	double insertion_latency, insertion_throughput;
 	double deletion_latency, deletion_throughput;
+	double query_latency, query_throughput;
 
 	/* Save first insertion/deletion rates from first thread.
 	 * Start comparing with all threads, if any thread used
@@ -1569,30 +1657,40 @@ dump_used_cpu_time(const char *item,
 
 	insertion_latency_time = used_time->insertion[port][0];
 	deletion_latency_time = used_time->deletion[port][0];
+	query_latency_time = used_time->query[port][0];
 	insertion_throughput_time = used_time->insertion[port][0];
 	deletion_throughput_time = used_time->deletion[port][0];
+	query_throughput_time = used_time->query[port][0];
 
 	i = mc_pool.cores_count;
 	while (i-- > 1) {
 		insertion_throughput_time += used_time->insertion[port][i];
 		deletion_throughput_time += used_time->deletion[port][i];
+		query_throughput_time += used_time->query[port][i];
 		if (insertion_latency_time < used_time->insertion[port][i])
 			insertion_latency_time = used_time->insertion[port][i];
 		if (deletion_latency_time < used_time->deletion[port][i])
 			deletion_latency_time = used_time->deletion[port][i];
+		if (query_throughput_time < used_time->query[port][i])
+			query_throughput_time = used_time->query[port][i];
 	}
 
 	insertion_latency = ((double) (mc_pool.rules_count
 				/ insertion_latency_time) / 1000);
 	deletion_latency = ((double) (mc_pool.rules_count
 				/ deletion_latency_time) / 1000);
+	query_latency = ((double)(mc_pool.rules_count
+				/ query_latency_time) / 1000);
 
 	insertion_throughput_time /= mc_pool.cores_count;
 	deletion_throughput_time /= mc_pool.cores_count;
+	query_throughput_time /= mc_pool.cores_count;
 	insertion_throughput = ((double) (mc_pool.rules_count
 				/ insertion_throughput_time) / 1000);
 	deletion_throughput = ((double) (mc_pool.rules_count
 				/ deletion_throughput_time) / 1000);
+	query_throughput = ((double)(mc_pool.rules_count
+				/ query_throughput_time) / 1000);
 
 	/* Latency stats */
 	printf("\n%s\n:: [Latency | Insertion] All Cores :: Port %d :: ",
@@ -1630,6 +1728,26 @@ dump_used_cpu_time(const char *item,
 		printf("The average time for deleting %d rules is %f seconds\n",
 			mc_pool.rules_count, deletion_throughput_time);
 	}
+
+	if (query_flag) {
+		/* Latency stats */
+		printf(":: [Latency | query] All Cores :: Port %d :: Total "
+			"query rate -> %f K Rules/Sec\n",
+			port, query_latency);
+		printf(":: [Latency | query] All Cores :: Port %d :: ",
+			port);
+		printf("The time for querying %d rules is %f seconds\n",
+			mc_pool.rules_count, query_latency_time);
+
+		/* Throughput stats */
+		printf(":: [Throughput | query] All Cores :: Port %d :: Total "
+			"query rate -> %f K Rules/Sec\n",
+			port, query_throughput);
+		printf(":: [Throughput | query] All Cores :: Port %d :: ",
+			port);
+		printf("The average time for querying %d rules is %f seconds\n",
+			mc_pool.rules_count, query_throughput_time);
+	}
 }
 
 static void
@@ -2120,6 +2238,7 @@ main(int argc, char **argv)
 	rules_count = DEFAULT_RULES_COUNT;
 	rules_batch = DEFAULT_RULES_BATCH;
 	delete_flag = false;
+	query_flag = false;
 	dump_socket_mem_flag = false;
 	flow_group = DEFAULT_GROUP;
 	unique_data = false;
-- 
2.19.0.rc0.windows.1

