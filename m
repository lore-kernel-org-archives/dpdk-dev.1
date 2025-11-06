Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F48CCCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6B38402B0;
	Thu,  6 Nov 2025 15:16:51 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011023.outbound.protection.outlook.com
 [40.93.194.23]) by mails.dpdk.org (Postfix) with ESMTP id B42E84013F;
 Thu,  6 Nov 2025 15:16:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bm6kejo0wlktzluApoUjhr7JGJM/Kw6KAzRbmghFnfKWryxZlmRUJlQc/cnr3M80HnyQ7JOEqLoT3KnB/o1hkfm6M/ZCkpEuHxJmLRqrIgehtBkzBP7ex+n9jdeYT/hQh82SlKKjBoOKTukDw1pMiZOOf8ByzCybiN/Q4eUoxB9KO/d217aRwv9AaC60APy0UxmRIHMClxVrrQAlGoUx7aJNSlZmk5UwXK8C0MlUfoCi2Jxva/9vgr+llC9MFnxDj0A+ruF90Rx71JIAnvmXQVOPFx/fDRlqeCx5HXuMT+Us8vrcHx7CjXwAljajLKC718X1u45Z87+hHYJveH+YBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqBN8tgm/jTZDQYDR0f3pyOykGSfTLqX6BixTSXAle8=;
 b=Y7h+dWqoUPceL8X2e7Iq/AU8B9Pyi7eug8taQebSYiQgCWa2QWVNvuifzIlFX7/9swuhwLbKJOUAsZzOpiOIg0mJpJsuDJTS7PmnNoVDN0glG6fY0VGsj4B37OpaQEhV+djQy5rP4TCl1aXW9pqNJlRR+UVAb1GY0z2KtbHgBA4N7luG8gej58wd5pALtKNUXHdRvgbp0RvmLE/+084j3cjiCIxIBucqbr1jP/9qTQsxcdBNXRvQPishjJD9Tl1U7UQq56AtLv+lEhZ8zsYoQnr02M0fCB4PJT5r6RF9wqt6W/u1Ktg5ZeyC4UaeFkVZ3XRcWkldCxdxpo0K5twBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=smartsharesystems.com smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqBN8tgm/jTZDQYDR0f3pyOykGSfTLqX6BixTSXAle8=;
 b=GFgXxzdJT513ud04IkOOQ5aC9WMijodKvBvJj8rdDls6MQci08kgNUJRd+MPSHAQ9Cha4cSW6xD8Xs4BojEHpUIOC8tG2m5OvUyV9CWg85uOSNrkNmtPXnnAOXnkQU1GBLNWhs0ZnHakoh85o4LgnX0L5mQ/Wnko8o2gFi988XI=
Received: from BYAPR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:c0::24)
 by CH1PR12MB9720.namprd12.prod.outlook.com (2603:10b6:610:2b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 14:16:45 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::d2) by BYAPR05CA0011.outlook.office365.com
 (2603:10b6:a03:c0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 14:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 14:16:44 +0000
Received: from volcano-ac5a-os.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 06:16:43 -0800
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>, Huisong Li
 <lihuisong@huawei.com>, Chengwen Feng <fengchengwen@huawei.com>, Jie Hai
 <haijie1@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Venkat Kumar Ande
 <venkatkumar.ande@amd.com>, Dengdui Huang <huangdengdui@huawei.com>, "Pavan
 Nikhilesh" <pbhagavatula@marvell.com>
Subject: [PATCH v3] examples/l3fwd: add Tx burst size configuration option
Date: Thu, 6 Nov 2025 14:16:31 +0000
Message-ID: <20251106141631.179443-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
References: <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|CH1PR12MB9720:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5451c2-4da4-40b2-23db-08de1d3f1d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk9yQnBoM21jdmRzaUJObEM1VmRwcElqdGZoNXJnNk5CZUxmZmtMb0xMZCs1?=
 =?utf-8?B?NmVzTDFiREdTMVZFZmhLTWJCemg5N3lJUGZZSDhSZEo1NzlPRi9mdHljdWxx?=
 =?utf-8?B?dGdiVU0yTmdmajM0d21WbHdUYjI4Q1RTZFhDMmUyZFpWYzlCMlZITzYvZk9O?=
 =?utf-8?B?Tkc1WWJZSUhGa2ZTSHRyUERGWEk4SkR6dm1UWHorNWhwUFdVaVlOUnE4cVNP?=
 =?utf-8?B?b1QrYmZPL1B1bmloVUs5T1Y0V0RCM3FXZHhSc1ovdUExbHFLQXNuUHowT2hS?=
 =?utf-8?B?MktXeUlwUjFTUDVmVkNGeE1vLzByTy92NVkweTV1SWVSMlFOVVJ1TkxiYkFo?=
 =?utf-8?B?V09Xdnp0SW1rcHMrRjg3M1k5bEJOY255ZW5NZGluUGc0U1IrMzFRNlVINzRK?=
 =?utf-8?B?aEtOM3NXN0tseitTQUtlTGh3RTc0amZyb0lRMWVLSEZXbXRXcTR1bVZCay94?=
 =?utf-8?B?M0k2N0VJd3hQYkx4SHk3Zjh1c0NkR2FCT2pBblppUjFhRk9qdy8xaGFHaUpB?=
 =?utf-8?B?SzNndVpHRWdLdGxmUzd2NThENVZWZ3FuOTh3MXhwbUx2ajVIcGNyaHgvSWFQ?=
 =?utf-8?B?TmhNNlNna1p1OVYzNS91NythUUZ0SlNxanVSWlRzYUtGbkVVd3c3ajcvbVUy?=
 =?utf-8?B?aTJWU2JXRVdjcnYzTVF0eHA1eUZsaVZaRkNLK0sxRWZobW5LZWtCamphOWxo?=
 =?utf-8?B?dXpoYk5ZN3lpSXp4YUtMaUJuMDgwejY4SnRTQ042TzdYSU9qS0t0NGpTZTJH?=
 =?utf-8?B?cXpMM0ErNS9tY01hWk82OVY2VnIwNGNOU2xSQjF6dnpSdDVBdSt0TnczV0Vz?=
 =?utf-8?B?dkNMZHBXWHJpTE9FMklzQ09GWndOa1J4SXd3MFYxUmhxS3VEeWJVRlhmYk9G?=
 =?utf-8?B?VjBlalJNNWdaZnB4bGM3QmdWSjQ0ck13WFlCZ2hicm9aZjJ0bFRJNm1zeHl0?=
 =?utf-8?B?NEZGV3JDeklqZmhYV2R5QTlHTWsva0s0N1ZlN25wdml5VUpxNEh2NC9CTUcy?=
 =?utf-8?B?MWFoSjdCNmN4Ri9reEZ5bjluWGFZdzVKaUM0blB1MVg5MEwxWVpzUlFIN05H?=
 =?utf-8?B?SzhQcktqUnErY1JXcXBhd1NRMWI5SFZEcU5XRUF1OVZIUHlpekJDSFV5d3VG?=
 =?utf-8?B?WjkyWkVqaitCUDVWUjZPbjZSbFJjR0JkTzY5dVd5Q2hSYmtzQXN5bmZrNkxw?=
 =?utf-8?B?Wml5TmxKeUxDUUtOYTRacnIxeWgvVVNCTUIyU0R4bjlDZVNXd3VOQkVNUWR0?=
 =?utf-8?B?Zmg2cXV2UHdtMWtmNHlFeFpoR3RFVlNVZGtudXlVTkoyeEtSb2tyK0tDWnNy?=
 =?utf-8?B?WXhpck1CQ3NsWFJnLytZYm9henhKNWR4SWg0Nk1hMGwxNGgvUW9WK3lPZ3Nw?=
 =?utf-8?B?TklaeUpKZ0o4M05DVGwvaGduRWFKVkpDQ3dsSjM0bHlRMFNQczRKRUc2anJa?=
 =?utf-8?B?VE1KdjhSVkdpc2lqL2tWd0MvamdyZEo4cFUxR096d3BzZDd2N3U4WTgvUC9I?=
 =?utf-8?B?cFYxQTNhRjZUR1RHSzBUUDZES2V6YndOcStOYTlCZUdLd0Q2a0xwcWIyMkZZ?=
 =?utf-8?B?RFR1cW5aZ0RnZy9ZQitCZFhDVTVuS1JOOWhjcUVNd2Q2QzZmSy9aSkw1UjhI?=
 =?utf-8?B?Rk5KTW8rWmZuaTJKc0h3ODA1Ri9WV1hKSGswWm1IZ0VQNENWQ3JmWjNSZVdh?=
 =?utf-8?B?N1dSaDJMZEdGZkVGNUxxTmpwR0p6SEUzTkxaNGJzZDJaMllsSFNZYlRRNHF3?=
 =?utf-8?B?TGVIcXN6WSt3YXE4NHBJMFZrL2FJQ05CYjRkK3ppK3ROYjlhZE0vb1dwMUNo?=
 =?utf-8?B?aUJsZ0dyanNGQ1dkVlI3cmw0UHlvbUQzZG1qRTZJOHhWWGdQc1BMUXRrT2tB?=
 =?utf-8?B?a0ROdDJIc2dnYXl1by90QU9EL0grWVNNa3pYQlVYTU8wOUU1cHFmeDhSWEVG?=
 =?utf-8?B?bFh1TW40RFRSS1NWeVY4WjZQY2E0S2ZSZUpJYitCM0NKbHVMMzA4QVZzUVFE?=
 =?utf-8?B?Rk5yZEltQlpxVlZNZ0s2QzRzL3B4TEVYZG9NaGlUSU1ITkh5OS9HVzlSOUFa?=
 =?utf-8?B?QTQ4UnRMV29UaWprdlFrSldNRkN0WFYwUmNVS2VYNGsyWlV5Vm5BdXh1dk1O?=
 =?utf-8?Q?9iyo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:16:44.7040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5451c2-4da4-40b2-23db-08de1d3f1d82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9720
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

Previously, the TX burst size in l3fwd was fixed at 256, which could
lead to suboptimal performance in certain scenarios.

This patch introduces separate --rx-burst and --tx-burst options to
explicitly configure RX and TX burst sizes. By default, the TX burst
size now matches the RX burst size for better efficiency and pipeline
balance.

Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
Cc: haijie1@huawei.com
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Tested-by: Venkat Kumar Ande <venkatkumar.ande@amd.com>
Tested-by: Dengdui Huang <huangdengdui@huawei.com>
Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

v3:
 - Added --tx-burst option to allow independent TX burst configuration
 - Renamed --burst to --rx-burst for clarity
 - Renamed variables for clarity:
     - nb_pkt_per_burst → rx_burst_size
     - max_tx_burst     → tx_burst_size
 - Modified parsing packet burst logic for RX and TX
 - Default TX burst size now equals RX burst size
 - Added logging of selected RX and TX burst sizes
 - Updated documentation for --rx-burst and --tx-burst options
---
 doc/guides/sample_app_ug/l3_forward.rst |  6 ++
 examples/l3fwd/l3fwd.h                  | 10 +--
 examples/l3fwd/l3fwd_acl.c              |  2 +-
 examples/l3fwd/l3fwd_common.h           |  5 +-
 examples/l3fwd/l3fwd_em.c               |  2 +-
 examples/l3fwd/l3fwd_fib.c              |  2 +-
 examples/l3fwd/l3fwd_lpm.c              |  2 +-
 examples/l3fwd/main.c                   | 81 ++++++++++++++++---------
 8 files changed, 68 insertions(+), 42 deletions(-)

diff --git a/doc/guides/sample_app_ug/l3_forward.rst b/doc/guides/sample_app_ug/l3_forward.rst
index 9b0d0350aa..dfe9d68c99 100644
--- a/doc/guides/sample_app_ug/l3_forward.rst
+++ b/doc/guides/sample_app_ug/l3_forward.rst
@@ -77,6 +77,8 @@ The application has a number of command line options::
                              [-P]
                              [--lookup LOOKUP_METHOD]
                              --config(port,queue,lcore)[,(port,queue,lcore)]
+                             [--rx-burst NPKTS]
+                             [--tx-burst NPKTS]
                              [--eth-dest=X,MM:MM:MM:MM:MM:MM]
                              [--max-pkt-len PKTLEN]
                              [--no-numa]
@@ -113,6 +115,10 @@ Where,
 
 * ``--config (port,queue,lcore)[,(port,queue,lcore)]:`` Determines which queues from which ports are mapped to which cores.
 
+* ``--rx-burst NPKTS:`` Optional, RX burst size in decimal (default 32).
+
+* ``--tx-burst NPKTS:`` Optional, TX burst size in decimal (default 32).
+
 * ``--eth-dest=X,MM:MM:MM:MM:MM:MM:`` Optional, ethernet destination for port X.
 
 * ``--max-pkt-len:`` Optional, maximum packet length in decimal (64-9600).
diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 0cce3406ee..471e3b488f 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -32,10 +32,6 @@
 
 #define VECTOR_SIZE_DEFAULT   MAX_PKT_BURST
 #define VECTOR_TMO_NS_DEFAULT 1E6 /* 1ms */
-/*
- * Try to avoid TX buffering if we have at least MAX_TX_BURST packets to send.
- */
-#define	MAX_TX_BURST	  (MAX_PKT_BURST / 2)
 
 #define NB_SOCKETS        8
 
@@ -116,7 +112,7 @@ extern struct acl_algorithms acl_alg[];
 
 extern uint32_t max_pkt_len;
 
-extern uint32_t nb_pkt_per_burst;
+extern uint32_t rx_burst_size;
 extern uint32_t mb_mempool_cache_size;
 
 /* Send burst of packets on an output interface */
@@ -152,8 +148,8 @@ send_single_packet(struct lcore_conf *qconf,
 	len++;
 
 	/* enough pkts to be sent */
-	if (unlikely(len == MAX_PKT_BURST)) {
-		send_burst(qconf, MAX_PKT_BURST, port);
+	if (unlikely(len == rx_burst_size)) {
+		send_burst(qconf, rx_burst_size, port);
 		len = 0;
 	}
 
diff --git a/examples/l3fwd/l3fwd_acl.c b/examples/l3fwd/l3fwd_acl.c
index 4fc4b986cc..a1275e18bc 100644
--- a/examples/l3fwd/l3fwd_acl.c
+++ b/examples/l3fwd/l3fwd_acl.c
@@ -1136,7 +1136,7 @@ acl_main_loop(__rte_unused void *dummy)
 			portid = qconf->rx_queue_list[i].port_id;
 			queueid = qconf->rx_queue_list[i].queue_id;
 			nb_rx = rte_eth_rx_burst(portid, queueid,
-				pkts_burst, nb_pkt_per_burst);
+				pkts_burst, rx_burst_size);
 
 			if (nb_rx > 0) {
 				nb_drop = acl_process_pkts(pkts_burst, hops,
diff --git a/examples/l3fwd/l3fwd_common.h b/examples/l3fwd/l3fwd_common.h
index d94e5f1357..ccaf0cd402 100644
--- a/examples/l3fwd/l3fwd_common.h
+++ b/examples/l3fwd/l3fwd_common.h
@@ -25,6 +25,9 @@
  */
 #define SENDM_PORT_OVERHEAD(x) (x)
 
+extern uint32_t rx_burst_size;
+extern uint32_t tx_burst_size;
+
 /*
  * From http://www.rfc-editor.org/rfc/rfc1812.txt section 5.2.2:
  * - The IP version number must be 4.
@@ -71,7 +74,7 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port, struct rte_mbuf *m[],
 	 * If TX buffer for that queue is empty, and we have enough packets,
 	 * then send them straightway.
 	 */
-	if (num >= MAX_TX_BURST && len == 0) {
+	if (num >= tx_burst_size && len == 0) {
 		n = rte_eth_tx_burst(port, qconf->tx_queue_id[port], m, num);
 		if (unlikely(n < num)) {
 			do {
diff --git a/examples/l3fwd/l3fwd_em.c b/examples/l3fwd/l3fwd_em.c
index da9c45e3a4..58c54ed77e 100644
--- a/examples/l3fwd/l3fwd_em.c
+++ b/examples/l3fwd/l3fwd_em.c
@@ -644,7 +644,7 @@ em_main_loop(__rte_unused void *dummy)
 			portid = qconf->rx_queue_list[i].port_id;
 			queueid = qconf->rx_queue_list[i].queue_id;
 			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
-				nb_pkt_per_burst);
+				rx_burst_size);
 			if (nb_rx == 0)
 				continue;
 
diff --git a/examples/l3fwd/l3fwd_fib.c b/examples/l3fwd/l3fwd_fib.c
index 82f1739df7..4fc6bf90d5 100644
--- a/examples/l3fwd/l3fwd_fib.c
+++ b/examples/l3fwd/l3fwd_fib.c
@@ -239,7 +239,7 @@ fib_main_loop(__rte_unused void *dummy)
 			portid = qconf->rx_queue_list[i].port_id;
 			queueid = qconf->rx_queue_list[i].queue_id;
 			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
-					nb_pkt_per_burst);
+					rx_burst_size);
 			if (nb_rx == 0)
 				continue;
 
diff --git a/examples/l3fwd/l3fwd_lpm.c b/examples/l3fwd/l3fwd_lpm.c
index fec0aeb79c..a71eee69ec 100644
--- a/examples/l3fwd/l3fwd_lpm.c
+++ b/examples/l3fwd/l3fwd_lpm.c
@@ -205,7 +205,7 @@ lpm_main_loop(__rte_unused void *dummy)
 			portid = qconf->rx_queue_list[i].port_id;
 			queueid = qconf->rx_queue_list[i].queue_id;
 			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
-				nb_pkt_per_burst);
+				rx_burst_size);
 			if (nb_rx == 0)
 				continue;
 
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index ae3b4f6439..ddd6fec344 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -57,8 +57,9 @@
 static_assert(MEMPOOL_CACHE_SIZE >= MAX_PKT_BURST, "MAX_PKT_BURST should be at most MEMPOOL_CACHE_SIZE");
 uint16_t nb_rxd = RX_DESC_DEFAULT;
 uint16_t nb_txd = TX_DESC_DEFAULT;
-uint32_t nb_pkt_per_burst = DEFAULT_PKT_BURST;
+uint32_t rx_burst_size = DEFAULT_PKT_BURST;
 uint32_t mb_mempool_cache_size = MEMPOOL_CACHE_SIZE;
+uint32_t tx_burst_size = DEFAULT_PKT_BURST;
 
 /**< Ports set in promiscuous mode off by default. */
 static int promiscuous_on;
@@ -400,7 +401,8 @@ print_usage(const char *prgname)
 		" --config (port,queue,lcore)[,(port,queue,lcore)]"
 		" [--rx-queue-size NPKTS]"
 		" [--tx-queue-size NPKTS]"
-		" [--burst NPKTS]"
+		" [--rx-burst NPKTS]"
+		" [--tx-burst NPKTS]"
 		" [--mbcache CACHESZ]"
 		" [--eth-dest=X,MM:MM:MM:MM:MM:MM]"
 		" [--max-pkt-len PKTLEN]"
@@ -427,7 +429,9 @@ print_usage(const char *prgname)
 		"            Default: %d\n"
 		"  --tx-queue-size NPKTS: Tx queue size in decimal\n"
 		"            Default: %d\n"
-		"  --burst NPKTS: Burst size in decimal\n"
+		"  --rx-burst NPKTS: RX Burst size in decimal\n"
+		"            Default: %d\n"
+		"  --tx-burst NPKTS: TX Burst size in decimal\n"
 		"            Default: %d\n"
 		"  --mbcache CACHESZ: Mbuf cache size in decimal\n"
 		"            Default: %d\n"
@@ -460,8 +464,8 @@ print_usage(const char *prgname)
 		"                    another is route entry at while line leads with character '%c'.\n"
 		"  --rule_ipv6=FILE: Specify the ipv6 rules entries file.\n"
 		"  --alg: ACL classify method to use, one of: %s.\n\n",
-		prgname, RX_DESC_DEFAULT, TX_DESC_DEFAULT, DEFAULT_PKT_BURST, MEMPOOL_CACHE_SIZE,
-		ACL_LEAD_CHAR, ROUTE_LEAD_CHAR, alg);
+		prgname, RX_DESC_DEFAULT, TX_DESC_DEFAULT, DEFAULT_PKT_BURST, DEFAULT_PKT_BURST,
+		MEMPOOL_CACHE_SIZE, ACL_LEAD_CHAR, ROUTE_LEAD_CHAR, alg);
 }
 
 static int
@@ -695,7 +699,7 @@ parse_mbcache_size(const char *optarg)
 }
 
 static void
-parse_pkt_burst(const char *optarg)
+parse_pkt_burst(const char *optarg, bool is_rx_burst, uint32_t *burst_sz)
 {
 	struct rte_eth_dev_info dev_info;
 	unsigned long pkt_burst;
@@ -710,31 +714,38 @@ parse_pkt_burst(const char *optarg)
 
 	if (pkt_burst > MAX_PKT_BURST) {
 		RTE_LOG(INFO, L3FWD, "User provided burst must be <= %d. Using default value %d\n",
-			MAX_PKT_BURST, nb_pkt_per_burst);
+			MAX_PKT_BURST, *burst_sz);
 		return;
 	} else if (pkt_burst > 0) {
-		nb_pkt_per_burst = (uint32_t)pkt_burst;
+		*burst_sz = (uint32_t)pkt_burst;
 		return;
 	}
 
-	/* If user gives a value of zero, query the PMD for its recommended Rx burst size. */
-	ret = rte_eth_dev_info_get(0, &dev_info);
-	if (ret != 0)
-		return;
-	burst_size = dev_info.default_rxportconf.burst_size;
-	if (burst_size == 0) {
-		RTE_LOG(INFO, L3FWD, "PMD does not recommend a burst size. Using default value %d. "
-			"User provided value must be in [1, %d]\n",
-			nb_pkt_per_burst, MAX_PKT_BURST);
-		return;
-	} else if (burst_size > MAX_PKT_BURST) {
-		RTE_LOG(INFO, L3FWD, "PMD recommended burst size %d exceeds maximum value %d. "
-			"Using default value %d\n",
-			burst_size, MAX_PKT_BURST, nb_pkt_per_burst);
-		return;
+	if (is_rx_burst) {
+		/* If user gives a value of zero, query the PMD for its recommended
+		 * Rx burst size.
+		 */
+		ret = rte_eth_dev_info_get(0, &dev_info);
+		if (ret != 0)
+			return;
+		burst_size = dev_info.default_rxportconf.burst_size;
+		if (burst_size == 0) {
+			RTE_LOG(INFO, L3FWD, "PMD does not recommend a burst size. Using default value %d. "
+				"User provided value must be in [1, %d]\n",
+				rx_burst_size, MAX_PKT_BURST);
+			return;
+		} else if (burst_size > MAX_PKT_BURST) {
+			RTE_LOG(INFO, L3FWD, "PMD recommended burst size %d exceeds maximum value %d. "
+				"Using default value %d\n",
+				burst_size, MAX_PKT_BURST, rx_burst_size);
+			return;
+		}
+		*burst_sz = burst_size;
+		RTE_LOG(INFO, L3FWD, "Using PMD-provided RX burst value %d\n", burst_size);
+	} else {
+		RTE_LOG(INFO, L3FWD, "User provided TX burst is 0. Using default value %d\n",
+				*burst_sz);
 	}
-	nb_pkt_per_burst = burst_size;
-	RTE_LOG(INFO, L3FWD, "Using PMD-provided burst value %d\n", burst_size);
 }
 
 #define MAX_JUMBO_PKT_LEN  9600
@@ -768,7 +779,8 @@ static const char short_options[] =
 #define CMD_LINE_OPT_RULE_IPV4 "rule_ipv4"
 #define CMD_LINE_OPT_RULE_IPV6 "rule_ipv6"
 #define CMD_LINE_OPT_ALG "alg"
-#define CMD_LINE_OPT_PKT_BURST "burst"
+#define CMD_LINE_OPT_PKT_RX_BURST "rx-burst"
+#define CMD_LINE_OPT_PKT_TX_BURST "tx-burst"
 #define CMD_LINE_OPT_MB_CACHE_SIZE "mbcache"
 
 enum {
@@ -799,7 +811,8 @@ enum {
 	CMD_LINE_OPT_ENABLE_VECTOR_NUM,
 	CMD_LINE_OPT_VECTOR_SIZE_NUM,
 	CMD_LINE_OPT_VECTOR_TMO_NS_NUM,
-	CMD_LINE_OPT_PKT_BURST_NUM,
+	CMD_LINE_OPT_PKT_RX_BURST_NUM,
+	CMD_LINE_OPT_PKT_TX_BURST_NUM,
 	CMD_LINE_OPT_MB_CACHE_SIZE_NUM,
 };
 
@@ -827,7 +840,8 @@ static const struct option lgopts[] = {
 	{CMD_LINE_OPT_RULE_IPV4,   1, 0, CMD_LINE_OPT_RULE_IPV4_NUM},
 	{CMD_LINE_OPT_RULE_IPV6,   1, 0, CMD_LINE_OPT_RULE_IPV6_NUM},
 	{CMD_LINE_OPT_ALG,   1, 0, CMD_LINE_OPT_ALG_NUM},
-	{CMD_LINE_OPT_PKT_BURST,   1, 0, CMD_LINE_OPT_PKT_BURST_NUM},
+	{CMD_LINE_OPT_PKT_RX_BURST,   1, 0, CMD_LINE_OPT_PKT_RX_BURST_NUM},
+	{CMD_LINE_OPT_PKT_TX_BURST,   1, 0, CMD_LINE_OPT_PKT_TX_BURST_NUM},
 	{CMD_LINE_OPT_MB_CACHE_SIZE,   1, 0, CMD_LINE_OPT_MB_CACHE_SIZE_NUM},
 	{NULL, 0, 0, 0}
 };
@@ -917,8 +931,12 @@ parse_args(int argc, char **argv)
 			parse_queue_size(optarg, &nb_txd, 0);
 			break;
 
-		case CMD_LINE_OPT_PKT_BURST_NUM:
-			parse_pkt_burst(optarg);
+		case CMD_LINE_OPT_PKT_RX_BURST_NUM:
+			parse_pkt_burst(optarg, true, &rx_burst_size);
+			break;
+
+		case CMD_LINE_OPT_PKT_TX_BURST_NUM:
+			parse_pkt_burst(optarg, false, &tx_burst_size);
 			break;
 
 		case CMD_LINE_OPT_MB_CACHE_SIZE_NUM:
@@ -1654,6 +1672,9 @@ main(int argc, char **argv)
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE, "Invalid L3FWD parameters\n");
 
+	RTE_LOG(INFO, L3FWD, "Using RX burst %u TX burst %u\n",
+				rx_burst_size, tx_burst_size);
+
 	/* Setup function pointers for lookup method. */
 	setup_l3fwd_lookup_tables();
 
-- 
2.43.0

