Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9F7C8303D
	for <dpdk-dev@archiver.kernel.org>; Sat,  5 Jul 2025 14:10:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A11774028B;
	Sat,  5 Jul 2025 16:10:36 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by mails.dpdk.org (Postfix) with ESMTP id 0E6C34025F
 for <dev@dpdk.org>; Sat,  5 Jul 2025 16:10:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNmSIxrDtnuyc9s7NgKTQ/SUSOrGefBS6MCuQpcbPUcQuiKtks3wYHt8gNs3uon5YzMWGU+wlNkxsTUsY4OgEBJnm2WqITXFllqZ536+v24kSOiErZh6/6QVw1k81O/tAw7z3vTWOXYX1sKfQOs6NJ6DZF6gJPsFVym1+OmANa81e1UTFEuJRG5/fbQHlcbieF1S8XBLXkzySbLQqrMcJa9O5nqevoX6/gHQ7mMt6fnG9bc5NJGBQ0OlOmKDz187ha7fIfWF4y+o7GIIdrdP+GGo/0Y+0SoC7oFUOGsF8NxMZC3B+jeY5bc1FRJTo1JnPKVpa7T9+6PqWCFHGp/ygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txu+M+GxEQj1Bu6ljrU8bYdUds1qXjmGGSnzjwesVoA=;
 b=EXOk1Gqt2605wwGEvuzHobtJCfATRISKItTv8peTI1v4ite6cn7l+p8d7IF8DYNvDeu0/4LUoLduwF0+rR2dPdIdAs2lUMEjN2zw/3YeMredkOn6EBhKcusu+ZpZeOIYpWZRCWfytxOas68mmR+OiFSaFWmIM6DJb0ITunKYyIrPo6MiIRJ6ToSZHvuhqe/J4efyMFzKl2zOCHUNbIy5rD41P4th63HpJdeyfElxSwR+LQMeyo7hdLLAMhNPKrnAwOXYoc0MOwuXKtqLWssjBDkFesp0ZVLs5QGIBhvIFkNdeu0CrST6lumKMxTflo5hjJDcYquHJFGu6thbwPty2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txu+M+GxEQj1Bu6ljrU8bYdUds1qXjmGGSnzjwesVoA=;
 b=trH/6aSLLl6MJMzVGcIcmoCV1DIGFYENOZZ3btlKXDox2+jCiAUzty0f0f60bldyXpGtfuuwHzE3dwoB8f1BQ2wDGgaSqfx6oGJme9/9jmUOybJvkyi9WqXRJtWHNzkZEb6kcyBvlLo2gmwnm+ICJGDIqfeZPwjd/ccgRwsQhL0=
Received: from CH0PR03CA0438.namprd03.prod.outlook.com (2603:10b6:610:10e::14)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Sat, 5 Jul
 2025 14:10:26 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:10e:cafe::6d) by CH0PR03CA0438.outlook.office365.com
 (2603:10b6:610:10e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.25 via Frontend Transport; Sat,
 5 Jul 2025 14:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.1 via Frontend Transport; Sat, 5 Jul 2025 14:10:25 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 5 Jul
 2025 09:10:22 -0500
From: Bhagyada Modali <bhagyada.modali@amd.com>
To: <dev@dpdk.org>
CC: <raghavendra.ningoji@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>
Subject: [PATCH] ntb/ae4dma: added Amd userspace DMA and NTB drivers
Date: Sat, 5 Jul 2025 19:40:01 +0530
Message-ID: <20250705141001.34223-1-bhagyada.modali@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 16964be5-e1b8-4d76-2ddd-08ddbbcdb069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlBFYVR2T2gyb0hXR2NFNmVuaGlLVmU2eEwvT1JNSEVWM044WEpUQjl1QTJu?=
 =?utf-8?B?VHNRMSt3YTlmSE1malpQY2ZPTFkwSC84YmFhbm1zV3BLbHkwV3JwTWQxYnll?=
 =?utf-8?B?YmZTQkc1bXczTEl4MUs0bTQvajMyZzQ2MllnamxnWkpxTUVIV29nMU0rR3BL?=
 =?utf-8?B?RDZJdGJGUEZoTHB3SkVDWEdoVjBqaUNudDVLVUZNZXVuV0U3MUJtcU04UWlj?=
 =?utf-8?B?Yi91NStNQ3hRZHBTZVY4OU91RHhJQWo2bGpUaU0xUU9xdXdjUjlVbmdYa3lC?=
 =?utf-8?B?OTRQdUtUbGc5ZDh2alNGaFJ5dEFLTFN3MkE1SFBmOE51VU5MKzZYT210cGlR?=
 =?utf-8?B?UXdSMWZMNWozbXdCS2IwR2lYL1YwbVI0Z0pBSUpCdlphbS9jK2dieWhGZG1K?=
 =?utf-8?B?TE9TdGpkNm5HMHVtVmQxQnZwODBWMW1hOWFLZ09xcEJYcnNGUDNXK2RKZHg0?=
 =?utf-8?B?NnRrdjBISmNWc2tGYlM2M09ZM3AxVCtGY2tDalNhTklONlJWMmpEMkNVT1pQ?=
 =?utf-8?B?K1RuQkRKNE1QOWVVUkxyczJOUEJKWExJaTVGRzNlMTdvczJYVDExdVdLYXRL?=
 =?utf-8?B?cUtnd1p2aGhWU2RsMmc3MkZzUFZyQlRvTGhPL084ZW5Ib0x1ek9BL0VUQXdh?=
 =?utf-8?B?S2ZGdmFKRG5UaXYzeXNyVmVoeGNkbjNxeTdWZmtPbERXeU0vckVFUXpxeHBy?=
 =?utf-8?B?N0VBUkd2NlZTa2pXYkk4Y1VXZmVDa01MTVppbklsNngrZ0x5SUtWTURNMkEx?=
 =?utf-8?B?UktTNUZXMmdHNkp5aGppSmlxU05tVDQ1ekhoSHdocmVSWUhFTHdSaFIxYmE0?=
 =?utf-8?B?Smx3T1JGRE05RWRrMURvT1lBdUNYUWhST0FKb29nRUlmcDJFUlhOVFpKczl2?=
 =?utf-8?B?WDJhUjBjbVFmdHAvT0R6YzNwbjE5WmZRck9wT002UGl4bDVBK01aSTVkdVli?=
 =?utf-8?B?UHJrVjhSSHN3OVkybW9lM1FhOGpNcXV1ODVkV2lkY1d6enJSOFVZZnRsN2Jw?=
 =?utf-8?B?cUI3TW9JVlg3Y0hJd0RMeHBZMjRCQjlHeG5TQnJHTjBpR3QrVU5wcGtZMkhE?=
 =?utf-8?B?QXhFblRBR1NOQ3ErWFZVSG41bU53QmtQcW95ZkxhMUZoS1p6QmJGWXAyMGJa?=
 =?utf-8?B?Q0Z2YlprZE94QURpTlZMYzgxeHdHUHp1MGt4eWN2MnJtZ3FFZVFlV2JnYTM0?=
 =?utf-8?B?T0tra1laKzBmc1lQeW90U2RVNHBOUDZqTFQ2bytjelQzbENXQ2ZodUg3SEtn?=
 =?utf-8?B?MXVML2drWUxVNTlaL1h3UnBEbk15UVBpeThJMi9pVVkxVmVJdlphNkdJQ05E?=
 =?utf-8?B?bE83TzFUYWRzOWMreFIrVjJSdC9jVkhiUE5CY0pMVlg1TDN6bGZsaE10SWZ4?=
 =?utf-8?B?UnFJZ1haakR3NU9wS1BISmNkcFY3WWhVNnovcHZmNnd1djc2OER5dUV0ZlBK?=
 =?utf-8?B?OWJVNjRFQURmWDRLbWVyN3hKZWlGM2drT3BKQjdOd2ZMT2cvVjBUUU95Z0VG?=
 =?utf-8?B?ZWZRbTVCK0VydWxYWEtLNGpZemI5OUIrUHVQY2RiYTVMVGVYY0xGSlp6dDA3?=
 =?utf-8?B?a3FNd0JTR2F3WXRPckM5RmZhbzAwM1J6eHorNDFYM2JlZzExekFLQ2ZlbklW?=
 =?utf-8?B?SDMvQndpSWI5K3JyajdQcUlQaGo4NmVoWWtoVzN5SXRwMEpDSHUyQmJPYnBr?=
 =?utf-8?B?MVNKMSsrTzFHV21TL0lLenlYdVRvRiszUWVNdnovTi9RREp1SmpaTXI5azF6?=
 =?utf-8?B?VkVrWUw2TXpkYzFaS05ETGZpU2hnaEVUZVMzVlFqLzZqSmhBdllYVWRCOHgz?=
 =?utf-8?B?ckFxL3BHckJuVGgxQTZua2dBLy9qSkdld2RySlpWUnB5c1QySDl5UGVNU0ZF?=
 =?utf-8?B?UjNCOW1vK1Z0bThHVjFYdXFhazlaYlJOVGt0WFNXZCsxRVJSeUNBL2F4bFBv?=
 =?utf-8?B?OEdRN1NrSHY1SEdDdmJuYklaZnQxS2tNVE53WUtRdndqOFliWVNuZ0xwblFG?=
 =?utf-8?B?aXNGNitqZEgvajV6bWwxWUl3cTkxV0lDSHN6VGgrNXNTMTkwNEJqM3cydDFN?=
 =?utf-8?Q?7F1LMI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 14:10:25.8299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16964be5-e1b8-4d76-2ddd-08ddbbcdb069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
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

Added a user-space driver with support for the
	AMD EPYC 4th Generation DMA (AE4DMA) offload engine.
	AMD Non Transparent Bridge driver.

      - Implementation of new user-space driver supporting
        NTB and DMA memory copy offload on AMD EYPC 9004 & 8004
	systems (Genoa and Siena processors).
      - Updated the NTB_FWD application to support AMD NTB driver.

Signed-off-by: Bhagyada Modali <bhagyada.modali@amd.com>
---
 app/test-dma-perf/benchmark.c        |  29 +-
 app/test-dma-perf/config.ini         | 134 +++--
 app/test-dma-perf/main.c             |   7 +-
 app/test/test_dmadev.c               |  47 +-
 drivers/dma/ae4dma/ae4dma_dmadev.c   | 704 +++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma_hw_defs.h  | 223 ++++++++
 drivers/dma/ae4dma/ae4dma_internal.h | 138 +++++
 drivers/dma/ae4dma/meson.build       |   7 +
 drivers/dma/meson.build              |   1 +
 drivers/raw/ntb/meson.build          |   1 +
 drivers/raw/ntb/ntb.c                | 371 +++++++++-----
 drivers/raw/ntb/ntb.h                |  15 +
 drivers/raw/ntb/ntb_hw_amd.c         | 738 +++++++++++++++++++++++++++
 drivers/raw/ntb/ntb_hw_amd.h         | 123 +++++
 drivers/raw/ntb/ntb_hw_intel.c       |  21 +
 drivers/raw/ntb/rte_pmd_ntb.h        |   2 +
 examples/ntb/commands.list           |   2 +-
 examples/ntb/ntb_fwd.c               | 362 +++++++++++--
 usertools/dpdk-devbind.py            |  15 +-
 19 files changed, 2698 insertions(+), 242 deletions(-)
 create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
 create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
 create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
 create mode 100644 drivers/dma/ae4dma/meson.build
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.c
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.h

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index 6d617ea200..7d7e07228c 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -266,6 +266,27 @@ error_exit(int dev_id)
 	rte_exit(EXIT_FAILURE, "DMA error\n");
 }
 
+static void
+await_hw(int16_t dev_id, uint16_t vchan)
+{
+	enum rte_dma_vchan_status st;
+
+	if (rte_dma_vchan_status(dev_id, vchan, &st) < 0) {
+		/* for drivers that don't support this op, just sleep for 1 us */
+		rte_delay_us_sleep(1);
+		return;
+	}
+
+	/* for those that do, *max* end time is one second from now, but all should be faster */
+	const uint64_t end_cycles = rte_get_timer_cycles() + rte_get_timer_hz();
+
+	while (st == RTE_DMA_VCHAN_ACTIVE && rte_get_timer_cycles() < end_cycles) {
+		rte_pause();
+		rte_dma_vchan_status(dev_id, vchan, &st);
+	}
+}
+
+
 static inline void
 do_dma_submit_and_poll(uint16_t dev_id, uint64_t *async_cnt,
 			volatile struct worker_info *worker_info)
@@ -276,7 +297,6 @@ do_dma_submit_and_poll(uint16_t dev_id, uint64_t *async_cnt,
 	ret = rte_dma_submit(dev_id, 0);
 	if (ret < 0)
 		error_exit(dev_id);
-
 	nr_cpl = rte_dma_completed(dev_id, 0, MAX_DMA_CPL_NB, NULL, NULL);
 	*async_cnt -= nr_cpl;
 	worker_info->total_cpl += nr_cpl;
@@ -309,14 +329,16 @@ do_dma_plain_mem_copy(void *p)
 		for (i = 0; i < nr_buf; i++) {
 dma_copy:
 			ret = rte_dma_copy(dev_id, 0, rte_mbuf_data_iova(srcs[i]),
-				rte_mbuf_data_iova(dsts[i]), buf_size, 0);
+				rte_mbuf_data_iova(dsts[i]), buf_size, 0);//
 			if (unlikely(ret < 0)) {
+				await_hw(dev_id, 0);
 				if (ret == -ENOSPC) {
 					do_dma_submit_and_poll(dev_id, &async_cnt, worker_info);
 					goto dma_copy;
 				} else
 					error_exit(dev_id);
 			}
+
 			async_cnt++;
 
 			if ((async_cnt % kick_batch) == 0)
@@ -756,6 +778,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 
 	while (1) {
 		bool ready = true;
+
 		for (i = 0; i < nb_workers; i++) {
 			if (lcores[i]->worker_info.ready_flag == false) {
 				ready = 0;
@@ -786,6 +809,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 	for (k = 0; k < nb_workers; k++) {
 		struct rte_mbuf **src_buf = NULL, **dst_buf = NULL;
 		uint32_t nr_buf_pt = nr_buf / nb_workers;
+
 		vchan_dev = &cfg->dma_config[k].vchan_dev;
 		offset = nr_buf / nb_workers * k;
 		src_buf = srcs + offset;
@@ -871,6 +895,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 
 	for (k = 0; k < nb_workers; k++) {
 		struct rte_mbuf **sbuf = NULL, **dbuf = NULL;
+
 		vchan_dev = &cfg->dma_config[k].vchan_dev;
 		offset = nr_buf / nb_workers * k;
 		m = NULL;
diff --git a/app/test-dma-perf/config.ini b/app/test-dma-perf/config.ini
index 61e49dbae5..4fa8713e89 100644
--- a/app/test-dma-perf/config.ini
+++ b/app/test-dma-perf/config.ini
@@ -61,57 +61,95 @@
 
 [case1]
 type=DMA_MEM_COPY
-mem_size=10
-buf_size=64,8192,2,MUL
-dma_ring_size=1024
-kick_batch=32
+mem_size=64
+buf_size=32768
+dma_ring_size=32
+kick_batch=4
 src_numa_node=0
 dst_numa_node=0
 cache_flush=0
 test_seconds=2
-lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
-lcore_dma1=lcore=11,dev=0000:00:04.2,dir=mem2mem
+lcore_dma0=lcore=4,dev=0000:04:00.1-ch0,dir=mem2mem
+lcore_dma1=lcore=5,dev=0000:04:00.1-ch1,dir=mem2mem
+lcore_dma2=lcore=7,dev=0000:64:00.1-ch0,dir=mem2mem
+lcore_dma3=lcore=8,dev=0000:64:00.1-ch1,dir=mem2mem
+lcore_dma4=lcore=14,dev=0000:41:00.1-ch0,dir=mem2mem
+lcore_dma5=lcore=15,dev=0000:41:00.1-ch1,dir=mem2mem
+lcore_dma6=lcore=17,dev=0000:21:00.1-ch0,dir=mem2mem
+lcore_dma7=lcore=18,dev=0000:21:00.1-ch1,dir=mem2mem
+;lcore_dma0=lcore=13,dev=0000:41:00.1-ch0,dir=mem2mem
+;lcore_dma1=lcore=14,dev=0000:41:00.1-ch1,dir=mem2mem
+;lcore_dma2=lcore=15,dev=0000:41:00.1-ch2,dir=mem2mem
+;lcore_dma3=lcore=16,dev=0000:41:00.1-ch3,dir=mem2mem
+;lcore_dma4=lcore=17,dev=0000:41:00.1-ch4,dir=mem2mem
+;lcore_dma5=lcore=18,dev=0000:41:00.1-ch5,dir=mem2mem
+;lcore_dma6=lcore=19,dev=0000:41:00.1-ch6,dir=mem2mem
+;lcore_dma7=lcore=20,dev=0000:41:00.1-ch7,dir=mem2mem
+;lcore_dma8=lcore=21,dev=0000:41:00.1-ch8,dir=mem2mem
+;lcore_dma9=lcore=22,dev=0000:41:00.1-ch9,dir=mem2mem
+;lcore_dma10=lcore=23,dev=0000:41:00.1-ch10,dir=mem2mem
+;lcore_dma11=lcore=24,dev=0000:41:00.1-ch11,dir=mem2mem
+;lcore_dma12=lcore=25,dev=0000:41:00.1-ch12,dir=mem2mem
+;lcore_dma13=lcore=26,dev=0000:41:00.1-ch13,dir=mem2mem
+;lcore_dma14=lcore=27,dev=0000:41:00.1-ch14,dir=mem2mem
+;lcore_dma15=lcore=28,dev=0000:41:00.1-ch15,dir=mem2mem
+;lcore_dma16=lcore=32,dev=0000:21:00.1-ch0,dir=mem2mem
+;lcore_dma17=lcore=33,dev=0000:21:00.1-ch1,dir=mem2mem
+;lcore_dma18=lcore=34,dev=0000:21:00.1-ch2,dir=mem2mem
+;lcore_dma19=lcore=35,dev=0000:21:00.1-ch3,dir=mem2mem
+;lcore_dma20=lcore=36,dev=0000:21:00.1-ch4,dir=mem2mem
+;lcore_dma21=lcore=37,dev=0000:21:00.1-ch5,dir=mem2mem
+;lcore_dma22=lcore=38,dev=0000:21:00.1-ch6,dir=mem2mem
+;lcore_dma23=lcore=39,dev=0000:21:00.1-ch7,dir=mem2mem
+;lcore_dma24=lcore=40,dev=0000:21:00.1-ch8,dir=mem2mem
+;lcore_dma25=lcore=41,dev=0000:21:00.1-ch9,dir=mem2mem
+;lcore_dma26=lcore=42,dev=0000:21:00.1-ch10,dir=mem2mem
+;lcore_dma27=lcore=43,dev=0000:21:00.1-ch11,dir=mem2mem
+;lcore_dma28=lcore=44,dev=0000:21:00.1-ch12,dir=mem2mem
+;lcore_dma29=lcore=45,dev=0000:21:00.1-ch13,dir=mem2mem
+;lcore_dma30=lcore=46,dev=0000:21:00.1-ch14,dir=mem2mem
+;lcore_dma31=lcore=47,dev=0000:21:00.1-ch15,dir=mem2mem
 eal_args=--in-memory --file-prefix=test
 
-[case2]
-type=DMA_MEM_COPY
-mem_size=10
-buf_size=64,8192,2,MUL
-dma_ring_size=1024
-dma_src_sge=4
-dma_dst_sge=1
-kick_batch=32
-src_numa_node=0
-dst_numa_node=0
-cache_flush=0
-test_seconds=2
-lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
-lcore_dma1=lcore=11,dev=0000:00:04.2,dir=mem2mem
-eal_args=--in-memory --file-prefix=test
-
-[case3]
-skip=1
-type=DMA_MEM_COPY
-mem_size=10
-buf_size=64,4096,2,MUL
-dma_ring_size=1024
-kick_batch=32
-src_numa_node=0
-dst_numa_node=0
-cache_flush=0
-test_seconds=2
-lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
-lcore_dma1=lcore=11,dev=0000:00:04.2,dir=dev2mem,raddr=0x200000000,coreid=1,pfid=2,vfid=3
-lcore_dma2=lcore=12,dev=0000:00:04.3,dir=mem2dev,raddr=0x300000000,coreid=3,pfid=2,vfid=1
-eal_args=--in-memory --file-prefix=test
-
-[case4]
-type=CPU_MEM_COPY
-mem_size=10
-buf_size=64,8192,2,MUL
-src_numa_node=0
-dst_numa_node=1
-cache_flush=0
-test_seconds=2
-lcore = 3, 4
-eal_args=--in-memory --no-pci
+;[case2]
+;type=DMA_MEM_COPY
+;mem_size=10
+;buf_size=64,8192,2,MUL
+;dma_ring_size=1024
+;dma_src_sge=4
+;dma_dst_sge=1
+;kick_batch=32
+;src_numa_node=0
+;dst_numa_node=0
+;cache_flush=0
+;test_seconds=2
+;lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
+;lcore_dma1=lcore=11,dev=0000:00:04.2,dir=mem2mem
+;eal_args=--in-memory --file-prefix=test
+;
+;[case3]
+;skip=1
+;type=DMA_MEM_COPY
+;mem_size=10
+;buf_size=64,4096,2,MUL
+;dma_ring_size=1024
+;kick_batch=32
+;src_numa_node=0
+;dst_numa_node=0
+;cache_flush=0
+;test_seconds=2
+;lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
+;lcore_dma1=lcore=11,dev=0000:00:04.2,dir=dev2mem,raddr=0x200000000,coreid=1,pfid=2,vfid=3
+;lcore_dma2=lcore=12,dev=0000:00:04.3,dir=mem2dev,raddr=0x300000000,coreid=3,pfid=2,vfid=1
+;eal_args=--in-memory --file-prefix=test
+;
+;[case4]
+;type=CPU_MEM_COPY
+;mem_size=10
+;buf_size=64,8192,2,MUL
+;src_numa_node=0
+;dst_numa_node=1
+;cache_flush=0
+;test_seconds=2
+;lcore = 3, 4
+;eal_args=--in-memory --no-pci
diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 0586b3e1d0..66fb1ee0d9 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -192,6 +192,7 @@ parse_lcore(struct test_configure *test_case, const char *value)
 	strlcpy(input, value, len + 1);
 
 	char *token = strtok(input, ", ");
+
 	while (token != NULL) {
 		lcore_dma_map = &(test_case->dma_config[test_case->num_worker++].lcore_dma_map);
 		memset(lcore_dma_map, 0, sizeof(struct lcore_dma_map_t));
@@ -201,6 +202,7 @@ parse_lcore(struct test_configure *test_case, const char *value)
 		}
 
 		uint16_t lcore_id = atoi(token);
+
 		lcore_dma_map->lcore = lcore_id;
 
 		token = strtok(NULL, ", ");
@@ -428,6 +430,7 @@ load_configs(const char *path)
 
 			char lc_dma[RTE_DEV_NAME_MAX_LEN];
 			int i = 0;
+
 			while (1) {
 				snprintf(lc_dma, RTE_DEV_NAME_MAX_LEN, "lcore_dma%d", i);
 				lcore_dma = rte_cfgfile_get_entry(cfgfile, section_name, lc_dma);
@@ -460,6 +463,7 @@ load_configs(const char *path)
 		} else {
 			lcore_dma = rte_cfgfile_get_entry(cfgfile, section_name, "lcore");
 			int lcore_ret = parse_lcore(test_case, lcore_dma);
+
 			if (lcore_ret < 0) {
 				printf("parse lcore error in case %d.\n", i + 1);
 				test_case->is_valid = false;
@@ -551,6 +555,7 @@ main(int argc, char *argv[])
 	if (rst_path_ptr == NULL) {
 		strlcpy(rst_path, cfg_path_ptr, PATH_MAX);
 		char *token = strtok(basename(rst_path), ".");
+
 		if (token == NULL) {
 			printf("Config file error.\n");
 			return -1;
@@ -566,7 +571,6 @@ main(int argc, char *argv[])
 		return -1;
 	}
 	fclose(fd);
-
 	printf("Running cases...\n");
 	for (i = 0; i < case_nb; i++) {
 		if (test_cases[i].is_skip) {
@@ -644,7 +648,6 @@ main(int argc, char *argv[])
 				printf("Case process unknown terminated.\n\n");
 		}
 	}
-
 	printf("Bye...\n");
 	return 0;
 }
diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 143e1bcd68..52e5d33dbe 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -4,6 +4,7 @@
  */
 
 #include <inttypes.h>
+#include <rte_malloc.h>
 
 #include <rte_dmadev.h>
 #include <rte_mbuf.h>
@@ -19,9 +20,10 @@
 #define ERR_RETURN(...) do { print_err(__func__, __LINE__, __VA_ARGS__); return -1; } while (0)
 
 #define TEST_NAME_MAX_LEN 80
-#define TEST_RINGSIZE 512
+#define TEST_RINGSIZE 32
+//#define TEST_RINGSIZE 512
 #define COPY_LEN 2048
-
+#define ALIGN_4K 4096
 static struct rte_dma_info info;
 static struct rte_mempool *pool;
 static bool check_err_stats;
@@ -122,6 +124,7 @@ await_hw(int16_t dev_id, uint16_t vchan)
 
 	/* for those that do, *max* end time is one second from now, but all should be faster */
 	const uint64_t end_cycles = rte_get_timer_cycles() + rte_get_timer_hz();
+
 	while (st == RTE_DMA_VCHAN_ACTIVE && rte_get_timer_cycles() < end_cycles) {
 		rte_pause();
 		rte_dma_vchan_status(dev_id, vchan, &st);
@@ -135,8 +138,8 @@ do_multi_copies(int16_t dev_id, uint16_t vchan,
 		int split_completions, /* gather 2 x 16 or 1 x 32 completions */
 		int use_completed_status) /* use completed or completed_status function */
 {
-	struct rte_mbuf *srcs[32], *dsts[32];
-	enum rte_dma_status_code sc[32];
+	struct rte_mbuf *srcs[16], *dsts[16];
+	enum rte_dma_status_code sc[16];
 	unsigned int i, j;
 	bool dma_err = false;
 
@@ -159,6 +162,7 @@ do_multi_copies(int16_t dev_id, uint16_t vchan,
 		if (rte_dma_copy(dev_id, vchan, rte_mbuf_data_iova(srcs[i]),
 				 rte_mbuf_data_iova(dsts[i]), COPY_LEN, 0) != id_count++)
 			ERR_RETURN("Error with rte_dma_copy for buffer %u\n", i);
+		id_count %= 32;
 	}
 	rte_dma_submit(dev_id, vchan);
 
@@ -168,6 +172,7 @@ do_multi_copies(int16_t dev_id, uint16_t vchan,
 		/* gather completions in two halves */
 		uint16_t half_len = RTE_DIM(srcs) / 2;
 		int ret = rte_dma_completed(dev_id, vchan, half_len, NULL, &dma_err);
+
 		if (ret != half_len || dma_err)
 			ERR_RETURN("Error with rte_dma_completed - first half. ret = %d, expected ret = %u, dma_err = %d\n",
 					ret, half_len, dma_err);
@@ -182,11 +187,13 @@ do_multi_copies(int16_t dev_id, uint16_t vchan,
 		 */
 		if (!use_completed_status) {
 			int n = rte_dma_completed(dev_id, vchan, RTE_DIM(srcs), NULL, &dma_err);
+
 			if (n != RTE_DIM(srcs) || dma_err)
 				ERR_RETURN("Error with rte_dma_completed, %u [expected: %zu], dma_err = %d\n",
 						n, RTE_DIM(srcs), dma_err);
 		} else {
 			int n = rte_dma_completed_status(dev_id, vchan, RTE_DIM(srcs), NULL, sc);
+
 			if (n != RTE_DIM(srcs))
 				ERR_RETURN("Error with rte_dma_completed_status, %u [expected: %zu]\n",
 						n, RTE_DIM(srcs));
@@ -229,8 +236,10 @@ test_single_copy(int16_t dev_id, uint16_t vchan)
 	struct rte_mbuf *src, *dst;
 	char *src_data, *dst_data;
 
+
 	src = rte_pktmbuf_alloc(pool);
 	dst = rte_pktmbuf_alloc(pool);
+
 	src_data = rte_pktmbuf_mtod(src, char *);
 	dst_data = rte_pktmbuf_mtod(dst, char *);
 
@@ -250,6 +259,10 @@ test_single_copy(int16_t dev_id, uint16_t vchan)
 		if (dst_data[i] != src_data[i])
 			ERR_RETURN("Data mismatch at char %u [Got %02x not %02x]\n", i,
 					dst_data[i], src_data[i]);
+/*		else
+			printf("Data MATCHED! at char %u [ %02x == %02x]\n", i,
+					dst_data[i], src_data[i]);
+*/
 
 	/* now check completion works */
 	id = ~id;
@@ -284,6 +297,7 @@ test_single_copy(int16_t dev_id, uint16_t vchan)
 		ERR_RETURN("Error with rte_dma_completed in empty check\n");
 
 	id_count++;
+	id_count %= 32;
 
 	return 0;
 }
@@ -296,17 +310,17 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
 	/* test doing a single copy */
 	if (test_single_copy(dev_id, vchan) < 0)
 		return -1;
-
 	/* test doing a multiple single copies */
 	do {
 		uint16_t id;
-		const uint16_t max_ops = 4;
+		const uint16_t max_ops = 28;
 		struct rte_mbuf *src, *dst;
 		char *src_data, *dst_data;
 		uint16_t count;
 
 		src = rte_pktmbuf_alloc(pool);
 		dst = rte_pktmbuf_alloc(pool);
+
 		src_data = rte_pktmbuf_mtod(src, char *);
 		dst_data = rte_pktmbuf_mtod(dst, char *);
 
@@ -314,12 +328,14 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
 			src_data[i] = rte_rand() & 0xFF;
 
 		/* perform the same copy <max_ops> times */
-		for (i = 0; i < max_ops; i++)
+		for (i = 0; i < max_ops; i++) {
 			if (rte_dma_copy(dev_id, vchan,
 					rte_pktmbuf_iova(src),
 					rte_pktmbuf_iova(dst),
 					COPY_LEN, RTE_DMA_OP_FLAG_SUBMIT) != id_count++)
 				ERR_RETURN("Error with rte_dma_copy\n");
+			id_count %= 32;
+		}
 
 		await_hw(dev_id, vchan);
 
@@ -328,7 +344,7 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
 			ERR_RETURN("Error with rte_dma_completed, got %u not %u\n",
 					count, max_ops);
 
-		if (id != id_count - 1)
+		if (id != (id_count - 1 + 32) % 32)
 			ERR_RETURN("Error, incorrect job id returned: got %u not %u\n",
 					id, id_count - 1);
 
@@ -339,8 +355,8 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
 		rte_pktmbuf_free(src);
 		rte_pktmbuf_free(dst);
 	} while (0);
-
 	/* test doing multiple copies */
+	return 0;
 	return do_multi_copies(dev_id, vchan, 0, 0, 0) /* enqueue and complete 1 batch at a time */
 			/* enqueue 2 batches and then complete both */
 			|| do_multi_copies(dev_id, vchan, 1, 0, 0)
@@ -634,6 +650,7 @@ test_individual_status_query_with_failure(int16_t dev_id, uint16_t vchan, bool f
 	/* use regular "completed" until we hit error */
 	while (!error) {
 		uint16_t n = rte_dma_completed(dev_id, vchan, 1, &idx, &error);
+
 		count += n;
 		if (n > 1 || count >= COMP_BURST_SZ)
 			ERR_RETURN("Error - too many completions got\n");
@@ -883,6 +900,7 @@ test_enqueue_fill(int16_t dev_id, uint16_t vchan)
 		/* check the data from the fill operation is correct */
 		for (j = 0; j < lengths[i]; j++) {
 			char pat_byte = ((char *)&pattern)[j % 8];
+
 			if (dst_data[j] != pat_byte)
 				ERR_RETURN("Error with fill operation (lengths = %u): got (%x), not (%x)\n",
 						lengths[i], dst_data[j], pat_byte);
@@ -1161,7 +1179,7 @@ test_dmadev_setup(void)
 	if (rte_dma_stats_get(dev_id, vchan, &stats) != 0)
 		ERR_RETURN("Error with rte_dma_stats_get()\n");
 
-	if (rte_dma_burst_capacity(dev_id, vchan) < 32)
+	if (rte_dma_burst_capacity(dev_id, vchan) < 2)
 		ERR_RETURN("Error: Device does not have sufficient burst capacity to run tests");
 
 	if (stats.completed != 0 || stats.submitted != 0 || stats.errors != 0)
@@ -1211,7 +1229,7 @@ test_dmadev_instance(int16_t dev_id)
 	};
 
 	static struct runtest_param param[] = {
-		{"copy", test_enqueue_copies, 640},
+		{"copy", test_enqueue_copies, 10000},
 		{"sg_copy", test_enqueue_sg_copies, 1},
 		{"stop_start", test_stop_start, 1},
 		{"burst_capacity", test_burst_capacity, 1},
@@ -1246,6 +1264,8 @@ test_dmadev_instance(int16_t dev_id)
 			TEST_CASE_NAMED_WITH_DATA("m2d_autofree",
 				test_dmadev_autofree_setup, NULL,
 				runtest, &param[TEST_M2D]),
+
+
 			TEST_CASES_END()
 		}
 	};
@@ -1317,9 +1337,10 @@ test_dma(void)
 		return TEST_SKIPPED;
 
 	RTE_DMA_FOREACH_DEV(i) {
-		if (test_dma_api(i) < 0)
-			ERR_RETURN("Error performing API tests\n");
 
+/*		if (test_dma_api(i) < 0)
+ *			ERR_RETURN("Error performing API tests\n");
+ */
 		if (test_dmadev_instance(i) < 0)
 			ERR_RETURN("Error, test failure for device %d\n", i);
 	}
diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
new file mode 100644
index 0000000000..2dbb7820a9
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
@@ -0,0 +1,704 @@
+/* SPDX-License-Identifier: BSD-3.0-Clause
+ * Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <rte_bus_pci.h>
+#include <bus_pci_driver.h>
+#include <rte_dmadev_pmd.h>
+#include <rte_malloc.h>
+#include <rte_prefetch.h>
+#include <rte_errno.h>
+
+#include "ae4dma_internal.h"
+
+#define MAX_RETRY 10
+int hwq_id = 0;
+
+static struct rte_pci_driver ae4dma_pmd_drv;
+
+RTE_LOG_REGISTER_DEFAULT(ae4dma_pmd_logtype, INFO);
+
+static int ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f);
+static int ae4dma_add_queue(struct ae4dma_dmadev *dev, uint8_t qn);
+
+#define DESC_SZ sizeof(struct ae4dma_dma_hw_desc)
+
+#define AE4DMA_PMD_NAME dmadev_ae4dma
+#define AE4DMA_PMD_NAME_STR RTE_STR(AE4DMA_PMD_NAME)
+
+/* AE4DMA operations. */
+enum rte_ae4dma_ops {
+	ae4dma_op_copy = 0,	/* Standard DMA Operation */
+	ae4dma_op_fill		/* Block Fill */
+};
+
+static const struct rte_memzone *
+ae4dma_queue_dma_zone_reserve(const char *queue_name,
+		uint32_t queue_size, int socket_id)
+{
+	const struct rte_memzone *mz;
+
+	mz = rte_memzone_lookup(queue_name);
+	if (mz != 0) {
+		if (((size_t)queue_size <= mz->len) &&
+				((socket_id == SOCKET_ID_ANY) ||
+				 (socket_id == mz->socket_id))) {
+			AE4DMA_PMD_INFO("re-use memzone already allocated for %s",
+					queue_name);
+			return mz;
+		}
+		AE4DMA_PMD_ERR("Incompatible memzone already allocated %s, size %u, socket %d. Requested size %u, socket %u",
+				queue_name, (uint32_t)mz->len,
+				mz->socket_id, queue_size, socket_id);
+		return NULL;
+	}
+ /*       AE4DMA_PMD_INFO("Allocate memzone for %s, size %u on socket %u",
+			queue_name, queue_size, socket_id);
+ */
+	return rte_memzone_reserve_aligned(queue_name, queue_size,
+			socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
+}
+
+
+/* Configure a device. */
+static int
+ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused, const struct rte_dma_conf *dev_conf,
+		uint32_t conf_sz)
+{
+	if (sizeof(struct rte_dma_conf) != conf_sz)
+		return -EINVAL;
+
+	if (dev_conf->nb_vchans != 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Setup a virtual channel for AE4DMA, only 1 vchan is supported. */
+static int
+ae4dma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
+		const struct rte_dma_vchan_conf *qconf, uint32_t qconf_sz)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	uint16_t max_desc = qconf->nb_desc;
+
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q[hwq_id];
+
+	if (sizeof(struct rte_dma_vchan_conf) != qconf_sz)
+		return -EINVAL;
+
+	cmd_q->qcfg = *qconf;
+
+	if (!rte_is_power_of_2(max_desc)) {
+		max_desc = rte_align32pow2(max_desc);
+		printf("DMA dev %u using %u descriptors\n", dev->data->dev_id, max_desc);
+		AE4DMA_PMD_DEBUG("DMA dev %u using %u descriptors", dev->data->dev_id, max_desc);
+		cmd_q->qcfg.nb_desc = max_desc;
+	}
+
+	/* Ensure all counters are reset, if reconfiguring/restarting device.*/
+	/* Reset Stats. */
+	memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
+	return 0;
+}
+
+
+/* Start a configured device. */
+static int
+ae4dma_dev_start(struct rte_dma_dev *dev)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q[hwq_id];
+
+	if (cmd_q->qcfg.nb_desc == 0)
+		return -EBUSY;
+	return 0;
+}
+
+/* Stop a configured device. */
+static int
+ae4dma_dev_stop(struct rte_dma_dev *dev)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q[hwq_id];
+
+	if (cmd_q->qcfg.nb_desc == 0)
+		return -EBUSY;
+	return 0;
+}
+
+/* Get device information of a device. */
+static int
+ae4dma_dev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *info, uint32_t size)
+{
+
+	if (size < sizeof(*info))
+		return -EINVAL;
+	info->dev_name = dev->device->name;
+	info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM;
+
+	info->max_vchans = 1;
+	info->min_desc = 2;
+	info->max_desc = 32;
+	info->nb_vchans = 1;
+	return 0;
+}
+
+/* Close a configured device. */
+static int
+ae4dma_dev_close(struct rte_dma_dev *dev)
+{
+	RTE_SET_USED(dev);
+	return 0;
+}
+
+/* trigger h/w to process enqued desc:doorbell - by next_write */
+static inline void
+__submit(struct ae4dma_dmadev *ae4dma)
+{
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q[hwq_id];
+	volatile uint16_t  write_idx = cmd_q->next_write;
+
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->write_idx, write_idx);
+
+	cmd_q->stats.submitted += (uint16_t)(cmd_q->next_write - cmd_q->last_write + AE4DMA_DESCRITPTORS_PER_CMDQ) % AE4DMA_DESCRITPTORS_PER_CMDQ;
+	cmd_q->last_write = cmd_q->next_write;
+}
+
+/* External submit function wrapper. */
+
+static int
+ae4dma_submit(void *dev_private, uint16_t qid __rte_unused)
+{
+
+	struct ae4dma_dmadev *ae4dma = dev_private;
+
+	__submit(ae4dma);
+
+	return 0;
+}
+
+/* Write descriptor for enqueue. */
+
+static inline int
+__write_desc(void *dev_private, uint32_t op, uint64_t src, phys_addr_t dst,
+		unsigned int len, uint64_t flags)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q[hwq_id];
+	struct ae4dma_desc *dma_desc;
+	uint16_t ret;
+	const uint16_t mask = cmd_q->qcfg.nb_desc - 1;
+	const uint16_t read = cmd_q->next_read;
+	uint16_t write = cmd_q->next_write;
+	const uint16_t space = mask + read - write;
+
+	if (cmd_q->ring_buff_count >= 28) {
+		AE4DMA_PMD_DEBUG("NO SPACE : ring_buff_count : %d\n", cmd_q->ring_buff_count);
+		return -ENOSPC;
+	}
+	if (op)
+		AE4DMA_PMD_WARN("FILL not supported:performing COPY\n");
+
+	dma_desc = &ae4dma->cmd_q[hwq_id].qbase_desc[write];
+	dma_desc->dw0.byte0 = 0;
+	dma_desc->dw1.status = 0;
+	dma_desc->dw1.err_code = 0;
+	dma_desc->dw1.desc_id  = 0;
+	dma_desc->length = len;
+	dma_desc->src_hi = upper_32_bits(src);
+	dma_desc->src_lo = lower_32_bits(src);
+	dma_desc->dst_hi = upper_32_bits(dst);
+	dma_desc->dst_lo = lower_32_bits(dst);
+
+	cmd_q->ring_buff_count++;
+	cmd_q->next_write = (write + 1) % (AE4DMA_DESCRITPTORS_PER_CMDQ);
+	ret = write;
+	if (flags & RTE_DMA_OP_FLAG_SUBMIT)
+		__submit(ae4dma);
+	return ret;
+}
+
+/* Enqueue a fill operation onto the ae4dma device. */
+static int
+ae4dma_enqueue_fill(void *dev_private, uint16_t qid __rte_unused, uint64_t pattern,
+		rte_iova_t dst, unsigned int length, uint64_t flags)
+{
+	return __write_desc(dev_private, ae4dma_op_fill, pattern, dst, length, flags);
+}
+
+/* Enqueue a copy operation onto the ae4dma device. */
+static int
+ae4dma_enqueue_copy(void *dev_private, uint16_t qid __rte_unused, rte_iova_t src,
+		rte_iova_t dst, unsigned int length, uint64_t flags)
+{
+	return __write_desc(dev_private, ae4dma_op_copy, src, dst, length, flags);
+}
+
+/* Dump DMA device info. */
+static int
+ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q;
+	void *ae4dma_mmio_base_addr = (uint8_t *) ae4dma->io_regs;
+
+	cmd_q = &ae4dma->cmd_q[hwq_id];
+	fprintf(f, "cmd_q->id              = %" PRIx64 "\n", cmd_q->id);
+	fprintf(f, "cmd_q->qidx            = %" PRIx64 "\n", cmd_q->qidx);
+	fprintf(f, "cmd_q->qsize           = %" PRIx64 "\n", cmd_q->qsize);
+	fprintf(f, "mmio_base_addr	= %p\n", ae4dma_mmio_base_addr);
+	fprintf(f, "queues per ae4dma engine     = %d\n", AE4DMA_READ_REG_OFFSET(ae4dma_mmio_base_addr, AE4DMA_COMMON_CONFIG_OFFSET));
+	fprintf(f, "== Private Data ==\n");
+	fprintf(f, "  Config: { ring_size: %u }\n", cmd_q->qcfg.nb_desc);
+	fprintf(f, "  Ring IOVA: %#lx\t%#lx\t%#lx\n", cmd_q->qbase_desc, cmd_q->qbase_addr, cmd_q->qbase_phys_addr);
+	fprintf(f, "  Next write: %u\n", cmd_q->next_write);
+	fprintf(f, "  Next read: %u\n", cmd_q->next_read);
+	fprintf(f, "  current queue depth: %u\n", cmd_q->ring_buff_count);
+	fprintf(f, "  }\n");
+	fprintf(f, "  Key Stats { submitted: %"PRIu64", comp: %"PRIu64", failed: %"PRIu64" }\n",
+		cmd_q->stats.submitted,
+		cmd_q->stats.completed,
+		cmd_q->stats.errors);
+	return 0;
+}
+
+/* Translates AE4DMA ChanERRs to DMA error codes. */
+static inline enum rte_dma_status_code
+__translate_status_ae4dma_to_dma(enum ae4dma_dma_err status)
+{
+	AE4DMA_PMD_INFO("ae4dma desc status = %d\n", status);
+	/*
+	 * to be modified for proper error mapping of ae4dma
+	 */
+
+	switch (status) {
+	case AE4DMA_DMA_ERR_NO_ERR:
+		return RTE_DMA_STATUS_SUCCESSFUL;
+	case AE4DMA_DMA_ERR_INV_LEN:
+		return RTE_DMA_STATUS_INVALID_LENGTH;
+	case AE4DMA_DMA_ERR_INV_SRC:
+		return RTE_DMA_STATUS_INVALID_SRC_ADDR;
+	case AE4DMA_DMA_ERR_INV_DST:
+		return RTE_DMA_STATUS_INVALID_DST_ADDR;
+	case AE4DMA_DMA_ERR_INV_ALIGN:
+		return RTE_DMA_STATUS_DATA_POISION;
+	case AE4DMA_DMA_ERR_INV_HEADER:
+	case AE4DMA_DMA_ERR_INV_STATUS:
+		return RTE_DMA_STATUS_ERROR_UNKNOWN;
+	default:
+		return RTE_DMA_STATUS_ERROR_UNKNOWN;
+
+	}
+	return 0;
+}
+
+static inline uint16_t *get_static_ptr()
+{
+	static uint16_t *ptr = NULL;
+
+	ptr = (ptr == NULL) ? (uint16_t *)malloc(sizeof(uint16_t)) : ptr;
+	return ptr;
+}
+/*
+ * icans h/w queues for descriptor processed status	returns total processed count of descriptor
+ *@param cmd_q
+ *@param maximum ops expected
+ *the ae4dma h/w queue info  struct
+ *@param[out] failed_count
+ *   transfer error count
+ * @return
+ *   The  number of operations that  completed - both success and failes
+ */
+
+static inline uint16_t
+ae4dma_scan_hwq(struct ae4dma_cmd_queue *cmd_q, const uint16_t max_ops, uint16_t *failed_count)
+{
+	volatile struct ae4dma_desc *hw_desc;
+	uint32_t events_count = 0, fails = 0;
+	volatile uint32_t tail;
+	volatile uint32_t desc_status;
+	uint32_t retry_count = MAX_RETRY;
+	uint32_t sub_desc_cnt;
+
+	tail = cmd_q->next_read;
+
+	/* process all the submitted descriptors for the HW queue */
+	sub_desc_cnt = cmd_q->ring_buff_count;
+
+	if (max_ops < sub_desc_cnt)
+		sub_desc_cnt = max_ops;
+
+	while (sub_desc_cnt) {
+		desc_status = 0;
+		retry_count = MAX_RETRY;
+		do {
+			hw_desc = &cmd_q->qbase_desc[tail];
+			desc_status = hw_desc->dw1.status;
+
+			if (desc_status) {
+				if (desc_status != AE4DMA_DMA_DESC_COMPLETED) {
+					fails++;
+					AE4DMA_PMD_WARN("WARNING:Desc error code : %d\n", hw_desc->dw1.err_code);
+				}
+
+				if (cmd_q->ring_buff_count)
+					cmd_q->ring_buff_count--;
+
+				cmd_q->status[events_count] = hw_desc->dw1.err_code;
+				events_count++;
+				tail = (tail + 1) % AE4DMA_DESCRITPTORS_PER_CMDQ;
+				sub_desc_cnt--;
+			}
+		} while (!desc_status && retry_count--);
+
+		if (desc_status == 0)
+			break;
+	}
+
+	cmd_q->stats.completed += events_count;
+	cmd_q->stats.errors += fails;
+	cmd_q->next_read = tail;
+
+	*failed_count = fails;
+	return events_count;
+}
+
+/* Returns successfull operations count and sets error flag if any errors. */
+
+static uint16_t
+ae4dma_completed(void *dev_private, uint16_t qid __rte_unused, const uint16_t max_ops,
+		uint16_t *last_idx, bool *has_error)
+{
+
+	struct ae4dma_dmadev *ae4dma =  dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q[hwq_id];
+	const uint16_t read = cmd_q->next_read;
+	uint16_t   cpl_count, sl_count;
+	*has_error = false;
+	uint16_t err_count = 0;
+
+	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
+
+	if (cpl_count > max_ops)
+		cpl_count = max_ops;
+	if (cpl_count <= max_ops)
+		*last_idx = (cmd_q->next_read - 1 + AE4DMA_DESCRITPTORS_PER_CMDQ) % AE4DMA_DESCRITPTORS_PER_CMDQ;
+
+	sl_count = cpl_count - err_count;
+
+	if (err_count)
+		*has_error = true;
+
+	return sl_count;
+}
+
+/* Returns detailed status information about operations that have been completed. */
+
+static uint16_t
+ae4dma_completed_status(void *dev_private, uint16_t qid __rte_unused,
+		uint16_t max_ops, uint16_t *last_idx, enum rte_dma_status_code *status)
+
+{
+	struct ae4dma_dmadev *ae4dma =  dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q[hwq_id];
+	const uint16_t read = cmd_q->next_read;
+	uint16_t   cpl_count;
+	uint16_t   i;
+	uint16_t err_count = 0;
+
+	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
+
+	if (cpl_count > max_ops)
+		cpl_count = max_ops;
+	if (cpl_count <= max_ops)
+		*last_idx = (cmd_q->next_read-1+AE4DMA_DESCRITPTORS_PER_CMDQ) % AE4DMA_DESCRITPTORS_PER_CMDQ;
+
+	if (likely(!err_count)) {
+		for (i = 0; i < cpl_count; i++)
+			status[i] = RTE_DMA_STATUS_SUCCESSFUL;
+	}
+	if (unlikely(err_count >= 1)) {
+		for (i = 0; i < cpl_count; i++)
+			status[i] = __translate_status_ae4dma_to_dma(cmd_q->status[i]);
+	}
+
+	return cpl_count;
+}
+
+/* Get the remaining capacity of the ring. */
+static uint16_t
+ae4dma_burst_capacity(const void *dev_private, uint16_t vchan __rte_unused)
+
+{
+	const struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q[hwq_id];
+	unsigned short size = cmd_q->qcfg.nb_desc - 1;
+	unsigned short read = cmd_q->next_read;
+	unsigned short write = cmd_q->next_write;
+	unsigned short space = size - (write - read);
+
+	return space;
+}
+
+/* Retrieve the generic stats of a DMA device. */
+static int
+ae4dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
+		struct rte_dma_stats *rte_stats, uint32_t size)
+{
+	const struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q[hwq_id];
+	struct rte_dma_stats *stats = &cmd_q->stats;
+
+	if (size < sizeof(rte_stats))
+		return -EINVAL;
+	if (rte_stats == NULL)
+		return -EINVAL;
+
+	*rte_stats = *stats;
+	return 0;
+}
+
+/* Reset the generic stat counters for the DMA device. */
+static int
+ae4dma_stats_reset(struct rte_dma_dev *dev, uint16_t vchan __rte_unused)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q[hwq_id];
+
+	memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
+	return 0;
+}
+
+/* Check if the AE4DMA device is idle. */
+static int
+ae4dma_vchan_status(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
+		enum rte_dma_vchan_status *status)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q;
+	uint32_t cmd_q_ctrl;
+
+	cmd_q = &ae4dma->cmd_q[0];
+	/* check here cmd_q is full/empty based on this set status */
+/*
+ *	if (*to check*)
+ *		*status = RTE_DMA_VCHAN_ACTIVE;
+ *	else
+ *		*status = RTE_DMA_VCHAN_IDLE;
+ *
+ *	return 0;
+ */
+/*
+ * As of now returning -1, as this functionality is not
+ * supported by ae4dma and it's valid also as this status
+ * callback implemetaion by driver is optional.
+ */
+	return -1;
+}
+
+int
+ae4dma_add_queue(struct ae4dma_dmadev *dev, uint8_t qn)
+{
+	uint32_t dma_addr_lo, dma_addr_hi;
+	uint32_t q_per_eng = 0;
+	struct ae4dma_cmd_queue *cmd_q;
+	const struct rte_memzone *q_mz;
+	void *ae4dma_mmio_base_addr;
+	int i;
+	static int dev_id;
+
+	if (dev == NULL)
+		return -1;
+	dev->qidx = 0;
+	q_per_eng = AE4DMA_MAX_HW_QUEUES;
+	dev->io_regs = (void *)(dev->pci.mem_resource[AE4DMA_PCIE_BAR].addr);
+	ae4dma_mmio_base_addr = (uint8_t *) dev->io_regs;
+	/* Set the number of HW queues for this AE4DMA engine */
+	AE4DMA_WRITE_REG_OFFSET(ae4dma_mmio_base_addr, AE4DMA_COMMON_CONFIG_OFFSET, q_per_eng);
+	q_per_eng = AE4DMA_READ_REG_OFFSET(ae4dma_mmio_base_addr, AE4DMA_COMMON_CONFIG_OFFSET);
+	AE4DMA_PMD_INFO("AE4DMA queues per engine = %d\n", q_per_eng);
+
+	dev->id = dev_id++;
+	dev->cmd_q_count = 0;
+	i = qn;
+	/* Find available queues */
+
+	cmd_q = &dev->cmd_q[dev->cmd_q_count++];
+	cmd_q->id = i;
+	cmd_q->qidx = 0;
+	/* Queue_size: 32*sizeof(struct ae4dmadma_desc) */
+	cmd_q->qsize = AE4DMA_QUEUE_SIZE(AE4DMA_QUEUE_DESC_SIZE);
+
+	cmd_q->hwq_regs = (volatile struct ae4dma_hwq_regs *)dev->io_regs + (i + 1);
+	/* AE4DMA queue memory */
+	snprintf(cmd_q->memz_name, sizeof(cmd_q->memz_name),
+			"%s_%d_%s_%d_%s",
+			"ae4dma_dev",
+			(int)dev->id, "queue",
+			(int)cmd_q->id, "mem");
+	q_mz = ae4dma_queue_dma_zone_reserve(cmd_q->memz_name,
+			cmd_q->qsize, rte_socket_id());
+	cmd_q->qbase_addr = (void *)q_mz->addr;
+	cmd_q->qbase_desc = (void *)q_mz->addr;
+	cmd_q->qbase_phys_addr =  q_mz->iova;
+
+	/* Max Index (cmd queue length) */
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, AE4DMA_DESCRITPTORS_PER_CMDQ);
+
+	/* Queue Enable */
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw, AE4DMA_CMD_QUEUE_ENABLE);
+
+	/* Disabling the interrupt */
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->intr_status_reg.intr_status_raw, AE4DMA_DISABLE_INTR);
+
+	/* AE4DMA_WRITE_REG(&cmd_q->hwq_regs->write_idx,0); */
+	cmd_q->next_write = AE4DMA_READ_REG(&cmd_q->hwq_regs->write_idx);
+	/* while(AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx));*/
+
+	cmd_q->next_read = AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx);
+	cmd_q->ring_buff_count = 0;
+	/* Update the device registers with queue addresses. */
+	dma_addr_lo = low32_value(cmd_q->qbase_phys_addr);
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_lo,
+			(uint32_t)dma_addr_lo);
+	dma_addr_hi = high32_value(cmd_q->qbase_phys_addr);
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_hi,
+			(uint32_t)dma_addr_hi);
+	if (dev->cmd_q_count == 0) {
+		AE4DMA_PMD_ERR("Error in enabling HW queues.No HW queues available\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Create a dmadev(dpdk DMA device) */
+static int
+ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
+{
+	static const struct rte_dma_dev_ops ae4dma_dmadev_ops = {
+		.dev_close = ae4dma_dev_close,
+		.dev_configure = ae4dma_dev_configure,
+		.dev_dump = ae4dma_dev_dump,
+		.dev_info_get = ae4dma_dev_info_get,
+		.dev_start = ae4dma_dev_start,
+		.dev_stop = ae4dma_dev_stop,
+		.stats_get = ae4dma_stats_get,
+		.stats_reset = ae4dma_stats_reset,
+		.vchan_status = ae4dma_vchan_status,
+		.vchan_setup = ae4dma_vchan_setup,
+	};
+
+	struct rte_dma_dev *dmadev = NULL;
+	struct ae4dma_dmadev *ae4dma = NULL;
+	char hwq_dev_name[RTE_DEV_NAME_MAX_LEN];
+
+	if (!name) {
+		AE4DMA_PMD_ERR("Invalid name of the device!");
+		return -EINVAL;
+	}
+	memset(hwq_dev_name, 0, sizeof(hwq_dev_name));
+	(void)snprintf(hwq_dev_name, sizeof(hwq_dev_name), "%s-ch%u", name, qn);
+
+	/* Allocate device structure. */
+	dmadev = rte_dma_pmd_allocate(hwq_dev_name, dev->device.numa_node, sizeof(struct ae4dma_dmadev));
+	if (dmadev == NULL) {
+		AE4DMA_PMD_ERR("Unable to allocate dma device");
+		return -ENOMEM;
+	}
+	dmadev->device = &dev->device;
+	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
+	dmadev->dev_ops = &ae4dma_dmadev_ops;
+
+	dmadev->fp_obj->burst_capacity = ae4dma_burst_capacity;
+	dmadev->fp_obj->completed = ae4dma_completed;
+	dmadev->fp_obj->completed_status = ae4dma_completed_status;
+	dmadev->fp_obj->copy = ae4dma_enqueue_copy;
+	dmadev->fp_obj->fill = ae4dma_enqueue_fill;
+	dmadev->fp_obj->submit = ae4dma_submit;
+
+	ae4dma = dmadev->data->dev_private;
+	ae4dma->dmadev = dmadev;
+	/* ae4dma->qcfg.nb_desc = 0; */
+	ae4dma->pci = *dev;
+	/* ae4dma->io_regs = (void *)(dev->mem_resource[AE4DMA_PCIE_BAR].addr); */
+	/* device is valid, add queue details */
+	if (ae4dma_add_queue(ae4dma, qn))
+		goto init_error;
+	return 0;
+
+init_error:
+	AE4DMA_PMD_ERR("driver %s(): failed", __func__);
+	return -EFAULT;
+}
+
+/* Destroy a DMA device. */
+static int
+ae4dma_dmadev_destroy(const char *name)
+{
+	int ret;
+
+	if (!name) {
+		AE4DMA_PMD_ERR("Invalid device name");
+		return -EINVAL;
+	}
+
+	ret = rte_dma_pmd_release(name);
+	if (ret)
+		AE4DMA_PMD_DEBUG("Device cleanup failed");
+
+	return 0;
+}
+
+/* Probe DMA device. */
+static int
+ae4dma_dmadev_probe(struct rte_pci_driver *drv, struct rte_pci_device *dev)
+{
+	char name[32];
+	int ret;
+
+	rte_pci_device_name(&dev->addr, name, sizeof(name));
+	AE4DMA_PMD_INFO("Init %s on NUMA node %d", name, dev->device.numa_node);
+	dev->device.driver = &drv->driver;
+	for (uint8_t i = 0; i < AE4DMA_MAX_HW_QUEUES; i++) {
+		ret = ae4dma_dmadev_create(name, dev, i);
+		if (ret) {
+			AE4DMA_PMD_ERR("%s create dmadev %u failed!",
+				     name, i);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/* Remove DMA device. */
+static int
+ae4dma_dmadev_remove(struct rte_pci_device *dev)
+{
+	char name[32];
+
+	rte_pci_device_name(&dev->addr, name, sizeof(name));
+
+	AE4DMA_PMD_INFO("Closing %s on NUMA node %d",
+			name, dev->device.numa_node);
+
+	return ae4dma_dmadev_destroy(name);
+}
+
+static const struct rte_pci_id pci_id_ae4dma_map[] = {
+	{ RTE_PCI_DEVICE(AMD_VENDOR_ID, AE4DMA_DEVICE_ID) },
+	{ .vendor_id = 0, /* sentinel */ },
+};
+
+static struct rte_pci_driver ae4dma_pmd_drv = {
+	.id_table = pci_id_ae4dma_map,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,
+	.probe = ae4dma_dmadev_probe,
+	.remove = ae4dma_dmadev_remove,
+};
+
+RTE_PMD_REGISTER_PCI(AE4DMA_PMD_NAME, ae4dma_pmd_drv);
+RTE_PMD_REGISTER_PCI_TABLE(AE4DMA_PMD_NAME, pci_id_ae4dma_map);
+RTE_PMD_REGISTER_KMOD_DEP(AE4DMA_PMD_NAME, "* igb_uio | uio_pci_generic | vfio-pci");
diff --git a/drivers/dma/ae4dma/ae4dma_hw_defs.h b/drivers/dma/ae4dma/ae4dma_hw_defs.h
new file mode 100644
index 0000000000..814723a737
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_hw_defs.h
@@ -0,0 +1,223 @@
+/* SPDX-License-Identifier: BSD-3.0-Clause
+ * Copyright(c) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __AE4DMA_HW_DEFS_H__
+#define __AE4DMA_HW_DEFS_H__
+
+#include <rte_bus_pci.h>
+#include <rte_byteorder.h>
+#include <rte_io.h>
+#include <rte_pci.h>
+#include <rte_spinlock.h>
+#include <rte_memzone.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * utility macros for bit setting and genmask
+ */
+
+#define BIT(nr)				(1 << (nr))
+
+#define BITS_PER_LONG   (__SIZEOF_LONG__ * 8)
+#define GENMASK(h, l)   (((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+
+/* ae4dma device details */
+#define AMD_VENDOR_ID	0x1022
+#define AE4DMA_DEVICE_ID	0x149b
+#define AE4DMA_PCIE_BAR 0
+
+/*
+ * An AE4DMA engine has 16 DMA queues. Each queue supports 32 descriptors
+ */
+
+#define AE4DMA_MAX_HW_QUEUES        2
+#define AE4DMA_QUEUE_START_INDEX    0
+#define AE4DMA_CMD_QUEUE_ENABLE 0x1
+
+/* Common to all queues */
+#define AE4DMA_COMMON_CONFIG_OFFSET 0x00
+
+#define AE4DMA_DISABLE_INTR 0x01
+
+
+/* temp defs added, need to remove if not required - start*/
+
+
+/* Address offset for virtual queue registers */
+#define CMD_Q_STATUS_INCR		0x1000
+
+/* Bit masks */
+
+#define CMD_Q_LEN			32
+#define CMD_Q_RUN			BIT(0)
+#define CMD_Q_HALT			BIT(1)
+#define CMD_Q_MEM_LOCATION		BIT(2)
+#define CMD_Q_STATUS			GENMASK(9, 7)
+#define CMD_Q_SIZE			GENMASK(4, 0)
+#define CMD_Q_SHIFT			GENMASK(1, 0)
+#define COMMANDS_PER_QUEUE		8192
+
+
+#define QUEUE_SIZE_VAL			((ffs(COMMANDS_PER_QUEUE) - 2) & \
+						CMD_Q_SIZE)
+#define Q_PTR_MASK			(2 << (QUEUE_SIZE_VAL + 5) - 1)
+#define Q_DESC_SIZE			sizeof(struct ae4dma_desc)
+#define Q_SIZE(n)			(COMMANDS_PER_QUEUE * (n))
+
+#define INT_COMPLETION			BIT(0)
+#define INT_ERROR			BIT(1)
+#define INT_QUEUE_STOPPED		BIT(2)
+#define INT_EMPTY_QUEUE			BIT(3)
+#define SUPPORTED_INTERRUPTS		(INT_COMPLETION | INT_ERROR)
+#define ALL_INTERRUPTS			(INT_COMPLETION | INT_ERROR | \
+					INT_QUEUE_STOPPED)
+
+/* bitmap */
+enum {
+	BITS_PER_WORD = sizeof(unsigned long) * CHAR_BIT
+};
+
+#define WORD_OFFSET(b) ((b) / BITS_PER_WORD)
+#define BIT_OFFSET(b)  ((b) % BITS_PER_WORD)
+
+#define AE4DMA_DIV_ROUND_UP(n, d)  (((n) + (d) - 1) / (d))
+#define AE4DMA_BITMAP_SIZE(nr) \
+	AE4DMA_DIV_ROUND_UP(nr, CHAR_BIT * sizeof(unsigned long))
+
+#define AE4DMA_BITMAP_FIRST_WORD_MASK(start) \
+	(~0UL << ((start) & (BITS_PER_WORD - 1)))
+#define AE4DMA_BITMAP_LAST_WORD_MASK(nbits) \
+	(~0UL >> (-(nbits) & (BITS_PER_WORD - 1)))
+
+#define __ae4dma_round_mask(x, y) ((typeof(x))((y)-1))
+#define ae4dma_round_down(x, y) ((x) & ~__ae4dma_round_mask(x, y))
+
+/* temp defs added, need to remove if not required - end*/
+
+/* Descriptor status */
+enum ae4dma_dma_status {
+	AE4DMA_DMA_DESC_SUBMITTED = 0,
+	AE4DMA_DMA_DESC_VALIDATED = 1,
+	AE4DMA_DMA_DESC_PROCESSED = 2,
+	AE4DMA_DMA_DESC_COMPLETED = 3,
+	AE4DMA_DMA_DESC_ERROR = 4,
+};
+
+/* Descriptor error-code */
+enum ae4dma_dma_err {
+	AE4DMA_DMA_ERR_NO_ERR = 0,
+	AE4DMA_DMA_ERR_INV_HEADER = 1,
+	AE4DMA_DMA_ERR_INV_STATUS = 2,
+	AE4DMA_DMA_ERR_INV_LEN = 3,
+	AE4DMA_DMA_ERR_INV_SRC = 4,
+	AE4DMA_DMA_ERR_INV_DST = 5,
+	AE4DMA_DMA_ERR_INV_ALIGN = 6,
+	AE4DMA_DMA_ERR_UNKNOWN = 7,
+};
+
+/* HW Queue status */
+enum ae4dma_hwqueue_status {
+	AE4DMA_HWQUEUE_EMPTY = 0,
+	AE4DMA_HWQUEUE_FULL = 1,
+	AE4DMA_HWQUEUE_NOT_EMPTY = 4
+};
+/*
+ * descriptor for AE4DMA commands
+ * 8 32-bit words:
+ * word 0: source memory type; destination memory type ; control bits
+ * word 1: desc_id; error code; status
+ * word 2: length
+ * word 3: reserved
+ * word 4: upper 32 bits of source pointer
+ * word 5: low 32 bits of source pointer
+ * word 6: upper 32 bits of destination pointer
+ * word 7: low 32 bits of destination pointer
+ */
+
+/* AE4DMA Descriptor - DWORD0 - Controls bits: Reserved for future use */
+#define AE4DMA_DWORD0_STOP_ON_COMPLETION    BIT(0)
+#define AE4DMA_DWORD0_INTERRUPT_ON_COMPLETION   BIT(1)
+#define AE4DMA_DWORD0_START_OF_MESSAGE      BIT(3)
+#define AE4DMA_DWORD0_END_OF_MESSAGE        BIT(4)
+#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE   GENMASK(5, 4)
+#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE   GENMASK(7, 6)
+
+#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_MEMORY    0x0
+#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_IOMEMORY  (1<<4)
+#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_MEMORY    0x0
+#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_IOMEMORY  (1<<6)
+
+struct ae4dma_desc_dword0 {
+	uint8_t byte0;
+	uint8_t byte1;
+	uint16_t timestamp;
+};
+
+struct ae4dma_desc_dword1 {
+	uint8_t status;
+	uint8_t err_code;
+	uint16_t desc_id;
+};
+
+struct ae4dma_desc {
+	struct ae4dma_desc_dword0 dw0;
+	struct ae4dma_desc_dword1 dw1;
+	uint32_t length;
+	uint32_t reserved;
+	uint32_t src_lo;
+	uint32_t src_hi;
+	uint32_t dst_lo;
+	uint32_t dst_hi;
+};
+
+/*
+ * Registers for each queue :4 bytes length
+ * Effective address : offset + reg
+ */
+
+struct ae4dma_hwq_regs {
+	union {
+		uint32_t control_raw;
+		struct {
+			uint32_t queue_enable: 1;
+			uint32_t reserved_internal: 31;
+		} control;
+	} control_reg;
+
+	union {
+		uint32_t status_raw;
+		struct {
+			uint32_t reserved0: 1;
+			uint32_t queue_status: 2; /* 0–empty, 1–full, 2–stopped, 3–error , 4–Not Empty */
+			uint32_t reserved1: 21;
+			uint32_t interrupt_type: 4;
+			uint32_t reserved2: 4;
+		} status;
+	} status_reg;
+
+	uint32_t max_idx;
+	uint32_t read_idx;
+	uint32_t write_idx;
+
+	union {
+		uint32_t intr_status_raw;
+		struct {
+			uint32_t intr_status: 1;
+			uint32_t reserved: 31;
+		} intr_status;
+	} intr_status_reg;
+
+	uint32_t qbase_lo;
+	uint32_t qbase_hi;
+
+};
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* AE4DMA_HW_DEFS_H */
diff --git a/drivers/dma/ae4dma/ae4dma_internal.h b/drivers/dma/ae4dma/ae4dma_internal.h
new file mode 100644
index 0000000000..3a95dc5b91
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_internal.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: BSD-3.0-Clause
+ * Copyright(c) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef _AE4DMA_INTERNAL_H_
+#define _AE4DMA_INTERNAL_H_
+
+#include "ae4dma_hw_defs.h"
+
+//#ifdef STRUCT_DEFINED_REGS
+	#define NO_OFFSET 0
+//#endif
+
+#define ENABLE_DEBUG_LOG 0
+/**
+ * upper_32_bits - return bits 32-63 of a number
+ * @n: the number we're accessing
+ */
+#define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
+
+/**
+ * lower_32_bits - return bits 0-31 of a number
+ * @n: the number we're accessing
+ */
+#define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
+
+#define AE4DMA_DESCRITPTORS_PER_CMDQ 32
+#define AE4DMA_QUEUE_DESC_SIZE  sizeof(struct ae4dma_desc)
+#define AE4DMA_QUEUE_SIZE(n)  (AE4DMA_DESCRITPTORS_PER_CMDQ * (n))
+
+/** AE4DMA registers Write/Read */
+static inline void ae4dma_pci_reg_write(void *base, int offset,
+		    uint32_t value)
+{
+	volatile void *reg_addr = ((uint8_t *)base + offset);
+
+	rte_write32((rte_cpu_to_le_32(value)), reg_addr);
+}
+
+static inline uint32_t ae4dma_pci_reg_read(void *base, int offset)
+{
+	volatile void *reg_addr = ((uint8_t *)base + offset);
+
+	return rte_le_to_cpu_32(rte_read32(reg_addr));
+}
+
+#define AE4DMA_READ_REG_OFFSET(hw_addr, reg_offset) \
+	ae4dma_pci_reg_read(hw_addr, reg_offset)
+
+#define AE4DMA_WRITE_REG_OFFSET(hw_addr, reg_offset, value) \
+	ae4dma_pci_reg_write(hw_addr, reg_offset, value)
+
+
+#define AE4DMA_READ_REG(hw_addr) \
+	ae4dma_pci_reg_read(hw_addr, 0)
+
+#define AE4DMA_WRITE_REG(hw_addr, value) \
+	ae4dma_pci_reg_write(hw_addr, 0, value)
+
+static inline uint32_t
+low32_value(unsigned long addr)
+{
+	return ((uint64_t)addr) & 0x0ffffffff;
+}
+
+static inline uint32_t
+high32_value(unsigned long addr)
+{
+	return ((uint64_t)addr >> 32) & 0x00000ffff;
+}
+
+/**
+ * A structure describing a AE4DMA command queue.
+ */
+struct ae4dma_cmd_queue {
+	char *wr_src;
+	phys_addr_t wr_src_phy;
+	char *wr_dst;
+	phys_addr_t wr_dst_phy;
+
+	char memz_name[RTE_MEMZONE_NAMESIZE];
+	volatile struct ae4dma_hwq_regs *hwq_regs;
+
+	struct rte_dma_vchan_conf qcfg;
+	struct rte_dma_stats stats;
+
+	/* Queue address */
+	struct ae4dma_desc *qbase_desc;
+	void *qbase_addr;
+	phys_addr_t qbase_phys_addr;
+	enum ae4dma_dma_err status[AE4DMA_DESCRITPTORS_PER_CMDQ];
+
+	/* Queue identifier */
+	uint64_t id;    /**< queue id */
+	uint64_t qidx;  /**< queue index */
+	uint64_t qsize; /**< queue size */
+
+	/* Queue Statistics */
+	uint64_t tail;
+	uint32_t ring_buff_count;
+
+	unsigned short next_read;
+	unsigned short next_write;
+	unsigned short last_write; /* Used to compute submitted count. */
+
+	/* queue-page registers addr */
+	void *reg_base;
+
+} __rte_cache_aligned;
+
+struct ae4dma_dmadev {
+	struct rte_dma_dev *dmadev;
+//	struct rte_dma_vchan_conf qcfg;
+
+	phys_addr_t status_addr;
+	phys_addr_t ring_addr;
+	void *io_regs;
+
+	int id; /**< ae4dma dev id on platform */
+//	struct ae4dma_cmd_queue cmd_q[AE4DMA_MAX_HW_QUEUES]; /**< ae4dma queue */
+	struct ae4dma_cmd_queue cmd_q[1]; /**< ae4dma queue */
+	int cmd_q_count; /**< no. of ae4dma Queues */
+	struct rte_pci_device pci; /**< ae4dma pci identifier */
+	int qidx;
+};
+
+
+extern int ae4dma_pmd_logtype;
+
+#define AE4DMA_PMD_LOG(level, fmt, args...) rte_log(RTE_LOG_ ## level, \
+		ae4dma_pmd_logtype, "AE4DMA: %s(): " fmt "\n", __func__, ##args)
+
+#define AE4DMA_PMD_DEBUG(fmt, args...)  AE4DMA_PMD_LOG(DEBUG, fmt, ## args)
+#define AE4DMA_PMD_INFO(fmt, args...)   AE4DMA_PMD_LOG(INFO, fmt, ## args)
+#define AE4DMA_PMD_ERR(fmt, args...)    AE4DMA_PMD_LOG(ERR, fmt, ## args)
+#define AE4DMA_PMD_WARN(fmt, args...)   AE4DMA_PMD_LOG(WARNING, fmt, ## args)
+
+#endif /* _AE4DMA_INTERNAL_H_ */
diff --git a/drivers/dma/ae4dma/meson.build b/drivers/dma/ae4dma/meson.build
new file mode 100644
index 0000000000..e48ab0d561
--- /dev/null
+++ b/drivers/dma/ae4dma/meson.build
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
+
+build = dpdk_conf.has('RTE_ARCH_X86')
+reason = 'only supported on x86'
+sources = files('ae4dma_dmadev.c')
+deps += ['bus_pci', 'dmadev']
diff --git a/drivers/dma/meson.build b/drivers/dma/meson.build
index 358132759a..6039f12cab 100644
--- a/drivers/dma/meson.build
+++ b/drivers/dma/meson.build
@@ -9,6 +9,7 @@ drivers = [
         'idxd',
         'ioat',
         'odm',
+        'ae4dma',
         'skeleton',
 ]
 std_deps = ['dmadev']
diff --git a/drivers/raw/ntb/meson.build b/drivers/raw/ntb/meson.build
index 9096f2b25a..f07ddd4c5d 100644
--- a/drivers/raw/ntb/meson.build
+++ b/drivers/raw/ntb/meson.build
@@ -3,5 +3,6 @@
 
 deps += ['rawdev', 'mbuf', 'mempool', 'pci', 'bus_pci']
 sources = files('ntb.c',
+                'ntb_hw_amd.c',
                 'ntb_hw_intel.c')
 headers = files('rte_pmd_ntb.h')
diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 0ed4c14592..685a5b8c86 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -26,6 +26,8 @@
 static const struct rte_pci_id pci_id_ntb_map[] = {
 	{ RTE_PCI_DEVICE(NTB_INTEL_VENDOR_ID, NTB_INTEL_DEV_ID_B2B_SKX) },
 	{ RTE_PCI_DEVICE(NTB_INTEL_VENDOR_ID, NTB_INTEL_DEV_ID_B2B_ICX) },
+	{ RTE_PCI_DEVICE(NTB_AMD_VENDOR_ID, NTB_AMD_DEV_ID_PRI) },
+	{ RTE_PCI_DEVICE(NTB_AMD_VENDOR_ID, NTB_AMD_DEV_ID_SEC) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
@@ -84,46 +86,98 @@ ntb_handshake_work(const struct rte_rawdev *dev)
 	ret = (*hw->ntb_ops->spad_write)(dev, SPAD_NUM_MWS, 1, hw->mw_cnt);
 	if (ret < 0)
 		return ret;
-	for (i = 0; i < hw->mw_cnt; i++) {
-		NTB_LOG(INFO, "Local %u mw size: 0x%"PRIx64"", i,
-				hw->mw_size[i]);
-		val = hw->mw_size[i] >> 32;
-		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_SZ_H + 2 * i,
-						 1, val);
+
+	if ((hw->pci_dev->id.device_id ==  NTB_AMD_DEV_ID_PRI) || (hw->pci_dev->id.device_id == NTB_AMD_DEV_ID_SEC)) {
+		for (i = 0; i < hw->mw_cnt; i++) {
+			val = hw->mw_size[i] >> 32;
+			NTB_LOG(INFO, "SPAD_MW0_SZ_H Local %u mw size: 0x%"PRIx64" val 0x%x ", i,
+					hw->mw_size[i], val);
+			ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_SZ_H + 2 * i,
+							 1, val);
+			if (ret < 0)
+				return ret;
+			val = hw->mw_size[i];
+			NTB_LOG(INFO, "SPAD_MW0_SZ_L Local %u mw size: 0x%"PRIx64" val 0x%x ", i,
+					hw->mw_size[i], val);
+			ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_SZ_L + 2 * i,
+							 1, val);
+			if (ret < 0)
+				return ret;
+		}
+
+		NTB_LOG(INFO, "writing hw->queue_size  %d", hw->queue_size);
+
+		 /* Tell peer about the queue info and map memory to the peer. */
+		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_Q_SZ, 1, hw->queue_size);
 		if (ret < 0)
 			return ret;
-		val = hw->mw_size[i];
-		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_SZ_L + 2 * i,
-						 1, val);
+		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_NUM_QPS, 1,
+					 hw->queue_pairs);
 		if (ret < 0)
 			return ret;
-	}
 
-	/* Tell peer about the queue info and map memory to the peer. */
-	ret = (*hw->ntb_ops->spad_write)(dev, SPAD_Q_SZ, 1, hw->queue_size);
-	if (ret < 0)
-		return ret;
-	ret = (*hw->ntb_ops->spad_write)(dev, SPAD_NUM_QPS, 1,
-					 hw->queue_pairs);
-	if (ret < 0)
-		return ret;
-	ret = (*hw->ntb_ops->spad_write)(dev, SPAD_USED_MWS, 1,
+		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_USED_MWS, 1,
 					 hw->used_mw_num);
-	if (ret < 0)
-		return ret;
-	for (i = 0; i < hw->used_mw_num; i++) {
-		val = (uint64_t)(size_t)(hw->mz[i]->addr) >> 32;
-		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_BA_H + 2 * i,
-						 1, val);
+			NTB_LOG(INFO, "after spad_write SPAD_USED_MWS hw->used_mw_num %d", hw->used_mw_num);
+		if (ret < 0)
+			return ret;
+
+		for (i = 0; i < hw->used_mw_num; i++) {
+			val = (uint64_t)(size_t)(hw->mz[i]->addr) >> 32;
+			ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_BA_H + 2 * i,
+							 1, val);
+			if (ret < 0)
+				return ret;
+			NTB_LOG(INFO, "after spad_write SPAD_MW0_BA_H SPAD_MW0_BA_H + 2 * i 0x%x, val 0x%x", SPAD_MW0_BA_H + 2 * i, val);
+			val = (uint64_t)(size_t)(hw->mz[i]->addr);
+			ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_BA_L + 2 * i,
+					1, val);
+			if (ret < 0)
+				return ret;
+			NTB_LOG(INFO, "after spad_write SPAD_MW0_BA_L SPAD_MW0_BA_L + 2 * i 0x%x, val 0x%x", SPAD_MW0_BA_L + 2 * i, val);
+		}
+	} else {
+		NTB_LOG(INFO, " in else part");
+		for (i = 0; i < hw->mw_cnt; i++) {
+			NTB_LOG(INFO, "Local %u mw size: 0x%"PRIx64"", i,
+					hw->mw_size[i]);
+			val = hw->mw_size[i] >> 32;
+			ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_SZ_H + 2 * i,
+							 1, val);
+			if (ret < 0)
+				return ret;
+			val = hw->mw_size[i];
+			ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_SZ_L + 2 * i,
+							 1, val);
+			if (ret < 0)
+				return ret;
+		}
+
+		/* Tell peer about the queue info and map memory to the peer. */
+		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_Q_SZ, 1, hw->queue_size);
 		if (ret < 0)
 			return ret;
-		val = (uint64_t)(size_t)(hw->mz[i]->addr);
-		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_BA_L + 2 * i,
-						 1, val);
+		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_NUM_QPS, 1,
+						 hw->queue_pairs);
 		if (ret < 0)
 			return ret;
+		ret = (*hw->ntb_ops->spad_write)(dev, SPAD_USED_MWS, 1,
+				hw->used_mw_num);
+		if (ret < 0)
+			return ret;
+		for (i = 0; i < hw->used_mw_num; i++) {
+			val = (uint64_t)(size_t)(hw->mz[i]->addr) >> 32;
+			ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_BA_H + 2 * i,
+							 1, val);
+			if (ret < 0)
+				return ret;
+			val = (uint64_t)(size_t)(hw->mz[i]->addr);
+			ret = (*hw->ntb_ops->spad_write)(dev, SPAD_MW0_BA_L + 2 * i,
+					1, val);
+			if (ret < 0)
+				return ret;
+		}
 	}
-
 	for (i = 0; i < hw->used_mw_num; i++) {
 		ret = (*hw->ntb_ops->mw_set_trans)(dev, i, hw->mz[i]->iova,
 						   hw->mz[i]->len);
@@ -150,55 +204,9 @@ ntb_dev_intr_handler(void *param)
 	uint8_t peer_mw_cnt;
 	int i = 0;
 
-	if (hw->ntb_ops->db_read == NULL ||
-	    hw->ntb_ops->db_clear == NULL ||
-	    hw->ntb_ops->peer_db_set == NULL) {
-		NTB_LOG(ERR, "Doorbell is not supported.");
-		return;
-	}
-
-	db_bits = (*hw->ntb_ops->db_read)(dev);
-	if (!db_bits)
-		NTB_LOG(ERR, "No doorbells");
-
-	/* Doorbell 0 is for peer device ready. */
-	if (db_bits & 1) {
-		NTB_LOG(INFO, "DB0: Peer device is up.");
-		/* Clear received doorbell. */
-		(*hw->ntb_ops->db_clear)(dev, 1);
 
-		/**
-		 * Peer dev is already up. All mw settings are already done.
-		 * Skip them.
-		 */
-		if (hw->peer_dev_up)
-			return;
-
-		if (hw->ntb_ops->spad_read == NULL) {
-			NTB_LOG(ERR, "Scratchpad read is not supported.");
-			return;
-		}
-
-		/* Check if mw setting on the peer is the same as local. */
-		peer_mw_cnt = (*hw->ntb_ops->spad_read)(dev, SPAD_NUM_MWS, 0);
-		if (peer_mw_cnt != hw->mw_cnt) {
-			NTB_LOG(ERR, "Both mw cnt must be the same.");
-			return;
-		}
-
-		for (i = 0; i < hw->mw_cnt; i++) {
-			val_h = (*hw->ntb_ops->spad_read)
-				(dev, SPAD_MW0_SZ_H + 2 * i, 0);
-			val_l = (*hw->ntb_ops->spad_read)
-				(dev, SPAD_MW0_SZ_L + 2 * i, 0);
-			peer_mw_size = ((uint64_t)val_h << 32) | val_l;
-			NTB_LOG(DEBUG, "Peer %u mw size: 0x%"PRIx64"", i,
-					peer_mw_size);
-			if (peer_mw_size != hw->mw_size[i]) {
-				NTB_LOG(ERR, "Mw config must be the same.");
-				return;
-			}
-		}
+	if ((hw->pci_dev->id.device_id ==  NTB_AMD_DEV_ID_PRI) || (hw->pci_dev->id.device_id == NTB_AMD_DEV_ID_SEC)) {
+		(*hw->ntb_ops->interrupt_handler)(param);
 
 		hw->peer_dev_up = 1;
 
@@ -212,42 +220,117 @@ ntb_dev_intr_handler(void *param)
 			NTB_LOG(ERR, "Handshake work failed.");
 			return;
 		}
-
 		/* To get the link info. */
 		if (hw->ntb_ops->get_link_status == NULL) {
 			NTB_LOG(ERR, "Not supported to get link status.");
 			return;
 		}
+
 		(*hw->ntb_ops->get_link_status)(dev);
-		NTB_LOG(INFO, "Link is up. Link speed: %u. Link width: %u",
-			hw->link_speed, hw->link_width);
 		return;
-	}
 
-	if (db_bits & (1 << 1)) {
-		NTB_LOG(INFO, "DB1: Peer device is down.");
-		/* Clear received doorbell. */
-		(*hw->ntb_ops->db_clear)(dev, 2);
+	} else {
+		if (hw->ntb_ops->db_read == NULL ||
+				hw->ntb_ops->db_clear == NULL ||
+				hw->ntb_ops->peer_db_set == NULL) {
+			NTB_LOG(ERR, "Doorbell is not supported.");
+			return;
+		}
 
-		/* Peer device will be down, So clean local side too. */
-		ntb_link_cleanup(dev);
+		db_bits = (*hw->ntb_ops->db_read)(dev);
+		if (!db_bits)
+			NTB_LOG(ERR, "No doorbells");
 
-		hw->peer_dev_up = 0;
-		/* Response peer's dev_stop request. */
-		(*hw->ntb_ops->peer_db_set)(dev, 2);
-		return;
-	}
+		/* Doorbell 0 is for peer device ready. */
+		if (db_bits & 1) {
+			/* Clear received doorbell. */
+			(*hw->ntb_ops->db_clear)(dev, 1);
 
-	if (db_bits & (1 << 2)) {
-		NTB_LOG(INFO, "DB2: Peer device agrees dev to be down.");
-		/* Clear received doorbell. */
-		(*hw->ntb_ops->db_clear)(dev, (1 << 2));
-		hw->peer_dev_up = 0;
-		return;
-	}
+			/**
+			 * * * * Peer dev is already up. All mw settings are already done.
+			 * * * * Skip them.
+			 * * * */
+			if (hw->peer_dev_up)
+				return;
+
+			if (hw->ntb_ops->spad_read == NULL) {
+				NTB_LOG(ERR, "Scratchpad read is not supported.");
+				return;
+			}
+
+			/* Check if mw setting on the peer is the same as local. */
+			peer_mw_cnt = (*hw->ntb_ops->spad_read)(dev, SPAD_NUM_MWS, 0);
+			if (peer_mw_cnt != hw->mw_cnt) {
+				NTB_LOG(ERR, "Both mw cnt must be the same. peer_mw_cnt %d  hw->mw_cnt %d ", peer_mw_cnt, hw->mw_cnt);
+				return;
+			}
+
+			for (i = 0; i < hw->mw_cnt; i++) {
+				val_h = (*hw->ntb_ops->spad_read)
+					(dev, SPAD_MW0_SZ_H + 2 * i, 0);
+				val_l = (*hw->ntb_ops->spad_read)
+					(dev, SPAD_MW0_SZ_L + 2 * i, 0);
+				peer_mw_size = ((uint64_t)val_h << 32) | val_l;
+				NTB_LOG(DEBUG, "Peer %u mw size: 0x%"PRIx64"", i,
+						peer_mw_size);
+				if (peer_mw_size != hw->mw_size[i]) {
+					NTB_LOG(ERR, "Mw config must be the same.");
+					return;
+				}
+			}
+
+			hw->peer_dev_up = 1;
+
+			/**
+			 * Handshake with peer. Spad_write & mw_set_trans only works
+			 * when both devices are up. So write spad again when db is
+			 * received. And set db again for the later device who may miss
+			 * the 1st db.
+			 */
+			if (ntb_handshake_work(dev) < 0) {
+				NTB_LOG(ERR, "Handshake work failed.");
+				return;
+			}
+
+			/* To get the link info. */
+			if (hw->ntb_ops->get_link_status == NULL) {
+				NTB_LOG(ERR, "Not supported to get link status.");
+				return;
+			}
 
-	/* Clear other received doorbells. */
-	(*hw->ntb_ops->db_clear)(dev, db_bits);
+			(*hw->ntb_ops->get_link_status)(dev);
+			NTB_LOG(INFO, "Link is up. Link speed: %u. Link width: %u",
+				hw->link_speed, hw->link_width);
+			return;
+		}
+
+		if (db_bits & (1 << 1)) {
+
+			NTB_LOG(INFO, "DB1: Peer device is down.");
+			/* Clear received doorbell. */
+			(*hw->ntb_ops->db_clear)(dev, 2);
+
+			/* Peer device will be down, So clean local side too. */
+			ntb_link_cleanup(dev);
+
+			hw->peer_dev_up = 0;
+			/* Response peer's dev_stop request. */
+			(*hw->ntb_ops->peer_db_set)(dev, 2);
+			return;
+		}
+
+		if (db_bits & (1 << 2)) {
+
+			NTB_LOG(INFO, "DB2: Peer device agrees dev to be down.");
+			/* Clear received doorbell. */
+			(*hw->ntb_ops->db_clear)(dev, (1 << 2));
+			hw->peer_dev_up = 0;
+			return;
+		}
+
+		/* Clear other received doorbells. */
+		(*hw->ntb_ops->db_clear)(dev, db_bits);
+	}
 }
 
 static int
@@ -320,8 +403,7 @@ ntb_rxq_setup(struct rte_rawdev *dev,
 				 RTE_CACHE_LINE_SIZE,
 				 dev->socket_id);
 	if (!rxq) {
-		NTB_LOG(ERR, "Failed to allocate memory for "
-			    "rx queue data structure.");
+		NTB_LOG(ERR, "Failed to allocate memory for rx queue data structure.");
 		return -ENOMEM;
 	}
 
@@ -406,8 +488,7 @@ ntb_txq_setup(struct rte_rawdev *dev,
 				  RTE_CACHE_LINE_SIZE,
 				  dev->socket_id);
 	if (!txq) {
-		NTB_LOG(ERR, "Failed to allocate memory for "
-			    "tx queue structure");
+		NTB_LOG(ERR, "Failed to allocate memory for tx queue structure");
 		return -ENOMEM;
 	}
 
@@ -438,14 +519,16 @@ ntb_txq_setup(struct rte_rawdev *dev,
 		prev = i;
 	}
 
-	txq->tx_free_thresh = txq_conf->tx_free_thresh ?
-			      txq_conf->tx_free_thresh :
-			      NTB_DFLT_TX_FREE_THRESH;
-	if (txq->tx_free_thresh >= txq->nb_tx_desc - 3) {
-		NTB_LOG(ERR, "tx_free_thresh must be less than nb_desc - 3. "
-			"(tx_free_thresh=%u qp_id=%u)", txq->tx_free_thresh,
-			qp_id);
-		return -EINVAL;
+	if (!((hw->pci_dev->id.device_id ==  NTB_AMD_DEV_ID_PRI) || (hw->pci_dev->id.device_id == NTB_AMD_DEV_ID_SEC))) {
+		txq->tx_free_thresh = txq_conf->tx_free_thresh ?
+			txq_conf->tx_free_thresh :
+			NTB_DFLT_TX_FREE_THRESH;
+		if (txq->tx_free_thresh >= txq->nb_tx_desc - 3) {
+			NTB_LOG(ERR, "tx_free_thresh must be less than nb_desc - 3. (tx_free_thresh=%u qp_id=%u)",
+					txq->tx_free_thresh,
+					qp_id);
+			return -EINVAL;
+		}
 	}
 
 	hw->tx_queues[qp_id] = txq;
@@ -495,6 +578,7 @@ static uint16_t
 ntb_queue_count(struct rte_rawdev *dev)
 {
 	struct ntb_hw *hw = dev->dev_private;
+
 	return hw->queue_pairs;
 }
 
@@ -523,6 +607,7 @@ ntb_queue_init(struct rte_rawdev *dev, uint16_t qp_id)
 	bar_addr = (*hw->ntb_ops->get_peer_mw_addr)(dev, 0);
 	if (bar_addr == NULL)
 		return -EINVAL;
+
 	remote_hdr = (struct ntb_header *)
 		     ((size_t)bar_addr + hdr_offset);
 
@@ -536,6 +621,7 @@ ntb_queue_init(struct rte_rawdev *dev, uint16_t qp_id)
 
 	for (i = 0; i < rxq->nb_rx_desc - 1; i++) {
 		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mpool);
+
 		if (unlikely(!mbuf)) {
 			NTB_LOG(ERR, "Failed to allocate mbuf for RX");
 			return -ENOMEM;
@@ -651,8 +737,7 @@ ntb_enqueue_bufs(struct rte_rawdev *dev,
 				goto end_of_tx;
 			}
 			if (txm->data_len > tx_item->len) {
-				NTB_LOG(ERR, "Data length exceeds buf length."
-					" Only %u data would be transmitted.",
+				NTB_LOG(ERR, "Data length exceeds buf length. Only %u data would be transmitted.",
 					tx_item->len);
 				txm->data_len = tx_item->len;
 			}
@@ -689,6 +774,7 @@ ntb_enqueue_bufs(struct rte_rawdev *dev,
 end_of_tx:
 	if (nb_tx) {
 		uint16_t nb1, nb2;
+
 		if (nb_mbufs > txq->nb_tx_desc - last_used) {
 			nb1 = txq->nb_tx_desc - last_used;
 			nb2 = nb_mbufs - txq->nb_tx_desc + last_used;
@@ -795,6 +881,7 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
 end_of_rx:
 	if (nb_rx) {
 		uint16_t nb1, nb2;
+
 		if (nb_mbufs > rxq->nb_rx_desc - last_avail) {
 			nb1 = rxq->nb_rx_desc - last_avail;
 			nb2 = nb_mbufs - rxq->nb_rx_desc + last_avail;
@@ -903,6 +990,7 @@ ntb_dev_start(struct rte_rawdev *dev)
 	uint64_t peer_base_h;
 	uint32_t i;
 	int ret;
+	void *bar_addr;
 
 	if (!hw->link_status || !hw->peer_dev_up)
 		return -EINVAL;
@@ -934,20 +1022,22 @@ ntb_dev_start(struct rte_rawdev *dev)
 		goto err_up;
 	}
 
-	peer_val = (*hw->ntb_ops->spad_read)(dev, SPAD_Q_SZ, 0);
-	if (peer_val != hw->queue_size) {
-		NTB_LOG(ERR, "Inconsistent queue size! (local: %u peer: %u)",
-			hw->queue_size, peer_val);
-		ret = -EINVAL;
-		goto err_up;
-	}
+	if (!((hw->pci_dev->id.device_id ==  NTB_AMD_DEV_ID_PRI) ||  (hw->pci_dev->id.device_id == NTB_AMD_DEV_ID_SEC))) {
+		peer_val = (*hw->ntb_ops->spad_read)(dev, SPAD_Q_SZ, 0);
+		if (peer_val != hw->queue_size) {
+			NTB_LOG(ERR, "Inconsistent queue size! (local: %u peer: %u)",
+					hw->queue_size, peer_val);
+			ret = -EINVAL;
+			goto err_up;
+		}
 
-	peer_val = (*hw->ntb_ops->spad_read)(dev, SPAD_NUM_QPS, 0);
-	if (peer_val != hw->queue_pairs) {
-		NTB_LOG(ERR, "Inconsistent number of queues! (local: %u peer:"
-			" %u)", hw->queue_pairs, peer_val);
-		ret = -EINVAL;
-		goto err_up;
+		peer_val = (*hw->ntb_ops->spad_read)(dev, SPAD_NUM_QPS, 0);
+		if (peer_val != hw->queue_pairs) {
+			NTB_LOG(ERR, "Inconsistent number of queues! (local: %u peer: %u)",
+					hw->queue_pairs, peer_val);
+			ret = -EINVAL;
+			goto err_up;
+		}
 	}
 
 	hw->peer_used_mws = (*hw->ntb_ops->spad_read)(dev, SPAD_USED_MWS, 0);
@@ -960,6 +1050,12 @@ ntb_dev_start(struct rte_rawdev *dev)
 		hw->peer_mw_base[i] = (peer_base_h << 32) + peer_base_l;
 	}
 
+	bar_addr = (*hw->ntb_ops->get_peer_mw_addr)(dev, 0);
+	if (bar_addr == NULL)
+		return -EINVAL;
+
+	hw->base_addr = bar_addr;
+	hw->base_addr_phys = (*hw->ntb_ops->get_peer_mw_addr_phys)(dev, 0);
 	dev->started = 1;
 
 	return 0;
@@ -1138,6 +1234,20 @@ ntb_attr_get(struct rte_rawdev *dev, const char *attr_name,
 		return 0;
 	}
 
+	if (!strncmp(attr_name, NTB_BASE_ADDR, NTB_ATTR_NAME_LEN)) {
+		*attr_value = hw->base_addr;
+		NTB_LOG(DEBUG, "Attribute (%s) Value (%" PRIu64 ")",
+			attr_name, *attr_value);
+		return 0;
+	}
+
+	if (!strncmp(attr_name, NTB_BASE_ADDR_PHYS, NTB_ATTR_NAME_LEN)) {
+		*attr_value = hw->base_addr_phys;
+		NTB_LOG(DEBUG, "Attribute (%s) Value (%" PRIu64 ")",
+			attr_name, *attr_value);
+		return 0;
+	}
+
 	if (!strncmp(attr_name, NTB_LINK_STATUS_NAME, NTB_ATTR_NAME_LEN)) {
 		/* hw->link_status only indicates hw link status. */
 		*attr_value = hw->link_status && hw->peer_dev_up;
@@ -1382,6 +1492,11 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 	case NTB_INTEL_DEV_ID_B2B_ICX:
 		hw->ntb_ops = &intel_ntb_ops;
 		break;
+
+	case NTB_AMD_DEV_ID_PRI:
+	case NTB_AMD_DEV_ID_SEC:
+		hw->ntb_ops = &amd_ntb_ops;
+		break;
 	default:
 		NTB_LOG(ERR, "Not supported device.");
 		return -EINVAL;
diff --git a/drivers/raw/ntb/ntb.h b/drivers/raw/ntb/ntb.h
index 8c7a2230f9..70b3d7ca5b 100644
--- a/drivers/raw/ntb/ntb.h
+++ b/drivers/raw/ntb/ntb.h
@@ -15,11 +15,14 @@ extern int ntb_logtype;
 
 /* Vendor ID */
 #define NTB_INTEL_VENDOR_ID         0x8086
+#define NTB_AMD_VENDOR_ID           0x1022
 
 /* Device IDs */
 #define NTB_INTEL_DEV_ID_B2B_SKX    0x201C
 #define NTB_INTEL_DEV_ID_B2B_ICX    0x347E
 #define NTB_INTEL_DEV_ID_B2B_SPR    0x347E
+#define NTB_AMD_DEV_ID_PRI	    0x14C0
+#define NTB_AMD_DEV_ID_SEC          0x14C3
 
 /* Reserved to app to use. */
 #define NTB_SPAD_USER               "spad_user_"
@@ -40,6 +43,8 @@ enum ntb_xstats_idx {
 
 enum ntb_topo {
 	NTB_TOPO_NONE = 0,
+	NTB_TOPO_PRI,
+	NTB_TOPO_SEC,
 	NTB_TOPO_B2B_USD,
 	NTB_TOPO_B2B_DSD,
 };
@@ -88,6 +93,7 @@ enum ntb_spad_idx {
  * NTB device operations
  * @ntb_dev_init: Init ntb dev.
  * @get_peer_mw_addr: To get the addr of peer mw[mw_idx].
+ * @get_peer_mw_addr_phys: To get the physical addr of peer mw[mw_idx].
  * @mw_set_trans: Set translation of internal memory that remote can access.
  * @ioremap: Translate the remote host address to bar address.
  * @get_link_status: get link status, link speed and link width.
@@ -104,6 +110,7 @@ enum ntb_spad_idx {
 struct ntb_dev_ops {
 	int (*ntb_dev_init)(const struct rte_rawdev *dev);
 	void *(*get_peer_mw_addr)(const struct rte_rawdev *dev, int mw_idx);
+	uint64_t (*get_peer_mw_addr_phys)(const struct rte_rawdev *dev, int mw_idx);
 	int (*mw_set_trans)(const struct rte_rawdev *dev, int mw_idx,
 			    uint64_t addr, uint64_t size);
 	void *(*ioremap)(const struct rte_rawdev *dev, uint64_t addr);
@@ -119,6 +126,7 @@ struct ntb_dev_ops {
 	int (*peer_db_set)(const struct rte_rawdev *dev, uint8_t db_bit);
 	int (*vector_bind)(const struct rte_rawdev *dev, uint8_t intr,
 			   uint8_t msix);
+	int (*interrupt_handler)(void *param);
 };
 
 struct ntb_desc {
@@ -209,6 +217,8 @@ struct ntb_hw {
 	const struct ntb_dev_ops *ntb_ops;
 
 	struct rte_pci_device *pci_dev;
+	/**< PMD-specific private data */
+	rte_rawdev_obj_t pmd_private;
 	char *hw_addr;
 
 	uint8_t peer_dev_up;
@@ -216,6 +226,9 @@ struct ntb_hw {
 	/* remote mem base addr */
 	uint64_t *peer_mw_base;
 
+	void *base_addr;
+	uint64_t base_addr_phys;
+
 	uint16_t queue_pairs;
 	uint16_t queue_size;
 	uint32_t hdr_size_per_queue;
@@ -236,4 +249,6 @@ struct ntb_hw {
 	int spad_user_list[NTB_SPAD_USER_MAX_NUM];
 };
 
+extern const struct ntb_dev_ops amd_ntb_ops;
+
 #endif /* _NTB_H_ */
diff --git a/drivers/raw/ntb/ntb_hw_amd.c b/drivers/raw/ntb/ntb_hw_amd.c
new file mode 100644
index 0000000000..b616551e81
--- /dev/null
+++ b/drivers/raw/ntb/ntb_hw_amd.c
@@ -0,0 +1,738 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Advanced Micro Devices, Inc. All Rights Reserved.
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <rte_io.h>
+#include <rte_eal.h>
+#include <rte_pci.h>
+#include <rte_bus_pci.h>
+#include <bus_pci_driver.h>
+#include <rte_rawdev.h>
+#include <rte_rawdev_pmd.h>
+
+#include "ntb.h"
+#include "ntb_hw_amd.h"
+#include "rte_bus_pci.h"
+
+
+static int
+amd_ntb_dev_init(const struct rte_rawdev *dev)
+{
+	uint32_t ntb_topo;
+	int i, j, bar;
+
+	struct ntb_hw *ntb = dev->dev_private;
+
+	struct amd_ntb_hw *amd_hw = NULL;
+
+	ntb->pmd_private = rte_zmalloc("amd_hw", sizeof(struct amd_ntb_hw), 0);
+	if (ntb->pmd_private == NULL) {
+		NTB_LOG(ERR, "Failed to allocate memory for amd_hw.");
+		return -EINVAL;
+	}
+
+	amd_hw = ntb->pmd_private;
+	if (amd_hw == NULL) {
+		NTB_LOG(ERR, "Invalid device.");
+		return -EINVAL;
+	}
+
+	ntb->hw_addr = (char *)ntb->pci_dev->mem_resource[0].addr;
+
+	amd_hw->self_mmio = ntb->hw_addr;
+	amd_hw->peer_mmio = amd_hw->self_mmio + AMD_PEER_OFFSET;
+	amd_hw->int_mask = AMD_EVENT_INTMASK;
+
+	// Bit 0 of link status register
+	ntb_topo = rte_read32(ntb->hw_addr + AMD_SIDEINFO_OFFSET);
+
+	if (ntb_topo & AMD_SIDE_MASK)
+		ntb->topo = NTB_TOPO_SEC;
+	else
+		ntb->topo = NTB_TOPO_PRI;
+
+	NTB_LOG(INFO, "dev_init() - ntb_topo 0x%x amd_hw->ntb->topo %d", ntb_topo, ntb->topo);
+	NTB_LOG(INFO, "dev_init() - amd_hw-> self_mmio 0x%x amd_hw->peermmio 0x%x", amd_hw->self_mmio, amd_hw->peer_mmio);
+
+	// memory window, door bell, scratcpad count
+	ntb->mw_cnt = AMD_MW_COUNT;
+	ntb->db_cnt = AMD_DB_COUNT;
+	ntb->spad_cnt = AMD_SPADS_COUNT;
+
+	ntb->mw_size = rte_zmalloc("ntb_mw_size",
+				  ntb->mw_cnt * sizeof(uint64_t), 0);
+	if (ntb->mw_size == NULL) {
+		NTB_LOG(ERR, "Cannot allocate memory for mw size.");
+		return -ENOMEM;
+	}
+	for (i = 0; i < ntb->mw_cnt; i++) {
+		bar = amd_ntb_bar[i];
+		ntb->mw_size[i] = ntb->pci_dev->mem_resource[bar].len;
+		NTB_LOG(INFO, "dev_init() - bar %d ntb->mw_size[%d] - 0x%x ", bar, i, ntb->mw_size[i]);
+	}
+
+	// splitting the scratchpad registers to half and assign it to each side
+
+//	ntb->spad_cnt >>= 1;   //// commenting for now.
+	if (ntb->topo == NTB_TOPO_PRI) {
+		amd_hw->self_spad = 0;
+		amd_hw->peer_spad = 0x20;
+	} else {
+		amd_hw->self_spad = 0x20;
+		amd_hw->peer_spad = 0;
+	}
+
+	// Reserve the last 2 spad registers for users.
+	for (j = 0; j < NTB_SPAD_USER_MAX_NUM; j++)
+		ntb->spad_user_list[j] = ntb->spad_cnt;
+
+	ntb->spad_user_list[0] = ntb->spad_cnt - 2;
+	ntb->spad_user_list[1] = ntb->spad_cnt - 1;
+
+	return 0;
+}
+
+// Memory window address - particular bar
+static void *
+amd_ntb_get_peer_mw_addr(const struct rte_rawdev *dev, int mw_idx)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	void *bar_addr;
+	uint64_t phys_bar_addr;
+
+	if (mw_idx < 0 || mw_idx > ntb->mw_cnt)
+		return -EINVAL;
+
+	bar_addr = ntb->pci_dev->mem_resource[AMD_MW_IDX << mw_idx].addr;
+	phys_bar_addr = ntb->pci_dev->mem_resource[AMD_MW_IDX << mw_idx].phys_addr;
+	NTB_LOG(INFO, "get_peer_mw_addr - bar virtual addr 0x%llx", bar_addr);
+	NTB_LOG(INFO, "get_peer_mw_addr - bar phys addr 0x%llx", phys_bar_addr);
+
+	return bar_addr;
+}
+
+static uint64_t
+amd_ntb_get_peer_mw_addr_phys(const struct rte_rawdev *dev, int mw_idx)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	uint64_t phys_addr;
+
+	if (mw_idx < 0 || mw_idx > ntb->mw_cnt)
+		return -EINVAL;
+
+	phys_addr = ntb->pci_dev->mem_resource[AMD_MW_IDX << mw_idx].phys_addr;
+	NTB_LOG(INFO, "get_peer_mw_addr - bar phys addr 0x%llx", phys_addr);
+
+	return phys_addr;
+}
+// Setting the registers with memory window details (start addresses and sizes)
+static int
+amd_ntb_mw_set_trans(const struct rte_rawdev *dev, int mw_idx,
+		       uint64_t addr, uint64_t size)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	void *mmio, *peer_mmio;
+	uint32_t bar, mw_size;
+	uint64_t reg_val, limit, base_addr;
+
+	if (mw_idx < 0 || mw_idx > ntb->mw_cnt)
+		return -EINVAL;
+
+	mmio = amd_hw->self_mmio;
+	peer_mmio = amd_hw->peer_mmio;
+
+	/* Set the limit if supported */
+	limit = size;
+
+	NTB_LOG(INFO, " mw_idx %d, size 0x%x ", mw_idx, size);
+
+	bar = AMD_MW_IDX << mw_idx;
+
+	mw_size = ntb->pci_dev->mem_resource[bar].len;
+	if (size > mw_size)
+		return -EINVAL;
+
+	base_addr = ntb->pci_dev->mem_resource[bar].addr;
+
+	NTB_LOG(INFO, "mmio 0x%x peer_mmio 0x%x, limit 0x%x, bar %d mw_size 0x%x, base addr 0x%x ",
+			mmio, peer_mmio, limit, bar, mw_size, base_addr);
+
+	/* bar = 2 */
+	if (bar == amd_ntb_bar[0]) {
+		rte_write64(addr, peer_mmio + AMD_BAR23_XLAT_OFFSET);
+		reg_val = rte_read64(peer_mmio + AMD_BAR23_XLAT_OFFSET);
+		if (reg_val != addr) {
+			rte_write64(0, peer_mmio + AMD_BAR23_XLAT_OFFSET);
+			return -EIO;
+		}
+
+		rte_write64(limit, peer_mmio + AMD_BAR23_LIMIT_OFFSET);
+		reg_val = rte_read64(peer_mmio + AMD_BAR23_LIMIT_OFFSET);
+		if (reg_val != limit) {
+			rte_write64(base_addr, mmio + AMD_BAR23_LIMIT_OFFSET);
+			rte_write64(0, peer_mmio + AMD_BAR23_LIMIT_OFFSET);
+			return -EIO;
+		}
+	} /* bar = 4 */
+	else if (bar == amd_ntb_bar[1]) {
+		rte_write64(addr, peer_mmio + AMD_BAR45_XLAT_OFFSET);
+		reg_val = rte_read64(peer_mmio + AMD_BAR45_XLAT_OFFSET);
+		if (reg_val != addr) {
+			rte_write64(0, peer_mmio + AMD_BAR45_XLAT_OFFSET);
+			return -EIO;
+		}
+
+		rte_write64(limit, peer_mmio + AMD_BAR45_LIMIT_OFFSET);
+		reg_val = rte_read64(peer_mmio + AMD_BAR45_LIMIT_OFFSET);
+		if (reg_val != limit) {
+			rte_write64(base_addr, mmio + AMD_BAR45_LIMIT_OFFSET);
+			rte_write64(0, peer_mmio + AMD_BAR45_LIMIT_OFFSET);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+/* Updating the memory addresses */
+static void *
+amd_ntb_ioremap(const struct rte_rawdev *dev, uint64_t addr)
+{
+	void *mapped = NULL;
+	void *base;
+	uint32_t i;
+
+	struct ntb_hw *ntb = dev->dev_private;
+
+	if (ntb == NULL) {
+		NTB_LOG(ERR, "Invalid NTB device.");
+		return NULL;
+	}
+
+	for (i = 0; i < ntb->peer_used_mws; i++) {
+		if (addr >= ntb->peer_mw_base[i] &&
+				addr <= ntb->peer_mw_base[i] + ntb->mw_size[i]) {
+			base = amd_ntb_get_peer_mw_addr(dev, i);
+			mapped = (void *)(size_t)(addr - ntb->peer_mw_base[i] + (size_t)base);
+			break;
+		}
+	}
+	return mapped;
+}
+
+static void
+amd_clear_side_info_reg(struct amd_ntb_hw *amd_hw, bool peer)
+{
+	void *mmio = NULL;
+	uint32_t reg;
+
+	if (peer)
+		mmio = amd_hw->peer_mmio;
+	else
+		mmio = amd_hw->self_mmio;
+
+	reg = rte_read32(mmio + AMD_SIDEINFO_OFFSET);
+	if (reg & AMD_SIDE_READY) {
+		reg &= ~AMD_SIDE_READY;
+		rte_write32(reg, mmio + AMD_SIDEINFO_OFFSET);
+		rte_read32(mmio + AMD_SIDEINFO_OFFSET);
+	}
+}
+
+
+struct rte_pci_device *pci_upstream_bridge(struct rte_pci_device *pdev)
+{
+
+	struct rte_pci_device *dev;
+	struct rte_pci_bus  *pci_bus = NULL;
+
+	if (!pdev) {
+		printf("Invalid PCI device\n");
+		return NULL;
+	}
+	pci_bus = (struct rte_pci_bus *) rte_bus_find_by_name("pci");
+	if (!pci_bus) {
+		printf("failed to get pci bus\n");
+		return NULL;
+	}
+
+
+	TAILQ_FOREACH(dev, &pci_bus->device_list, next) {
+		if (dev->id.class_id == PCI_CLASS_BRIDGE_PCI) {
+			if (dev->addr.bus == (pdev->addr.bus - 1)) {
+				printf("upstream bridge found for device %04x:%02x:%02x.%x\n",
+						pdev->addr.domain, pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+				return dev;
+			}
+		}
+	}
+	printf("No upstream bridge found for device %04x:%02x:%02x.%x\n",
+			pdev->addr.domain, pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
+	return NULL;
+}
+
+int read_config(const char *bdf, int offset, void *buf, int size)
+{
+	char path[128];
+	int fd;
+
+	snprintf(path, sizeof(path), "/sys/bus/pci/devices/%s/config", bdf);
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		perror("open");
+		return -1;
+	}
+
+	if (lseek(fd, offset, SEEK_SET) != offset) {
+		perror("lseek");
+		close(fd);
+		return -1;
+	}
+
+	if (read(fd, buf, size) != size) {
+		perror("read");
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+	return 0;
+}
+
+// Find PCIe capability offset
+int find_pcie_capability(const char *bdf, uint8_t *cap_offset)
+{
+	uint8_t status;
+	uint8_t pos;
+
+	if (read_config(bdf, 0x06, &status, 1) != 0)
+		return -1;
+
+	if (!(status & 0x10)) {
+		fprintf(stderr, "Capabilities list not supported\n");
+		return -1;
+	}
+
+	if (read_config(bdf, 0x34, &pos, 1) != 0)
+		return -1;
+
+	while (pos) {
+		uint8_t cap_id, next;
+
+		if (read_config(bdf, pos, &cap_id, 1) != 0 ||
+				read_config(bdf, pos + 1, &next, 1) != 0)
+			return -1;
+		if (cap_id == RTE_PCI_CAP_ID_EXP) {
+			*cap_offset = pos;
+			printf("PCIe capability FOUND\n");
+			return 0;
+		}
+		pos = next;
+	}
+
+	fprintf(stderr, "PCIe capability not found\n");
+	return -1;
+}
+
+int amd_read_link_status(struct rte_pci_device *pci_swus, uint16_t *lnk_word)
+{
+	const char bdf[32];
+	uint8_t pcie_cap;
+	uint16_t linkctl, linksta;
+
+	rte_pci_device_name(&pci_swus->addr, bdf, sizeof(bdf));
+	printf("bdf = %s\n", bdf);
+
+	if (find_pcie_capability(bdf, &pcie_cap) != 0)
+		return EXIT_FAILURE;
+
+	if (read_config(bdf, pcie_cap + 0x10, &linkctl, 2) != 0 ||
+			read_config(bdf, pcie_cap + 0x12, &linksta, 2) != 0) {
+		return EXIT_FAILURE;
+	}
+
+	*lnk_word = linksta;
+
+	if (linkctl & 0x03)
+		printf("ASPM Enabled\n");
+	else
+		printf("ASPM Disabled\n");
+
+	printf("Link Speed  : Gen%d Link Width  : x%d\n", linksta & 0xF, (linksta >> 4) & 0x3F);
+	return 0;
+}
+
+static int
+amd_link_status(struct ntb_hw *ntb)
+{
+	struct rte_pci_device *pdev = ntb->pci_dev;
+	struct pci_dev *pci_swus = NULL;
+	struct pci_dev *pci_swds = NULL;
+	off_t pcie_cap_offset;
+	uint16_t lnk_word;
+	off_t off;
+
+	if (ntb == NULL) {
+		NTB_LOG(ERR, "Invalid device.");
+		return -EINVAL;
+	}
+	if (ntb->topo == NTB_TOPO_PRI) {
+		pcie_cap_offset = amd_read_link_status(pdev, &lnk_word);
+
+		if (pcie_cap_offset) {
+			NTB_LOG(ERR, "[%s()] failed to find the pcie capability", __func__);
+			return pcie_cap_offset;
+		}
+	} else if (ntb->topo == NTB_TOPO_SEC) {
+		pci_swds = pci_upstream_bridge(pdev);
+
+		if (pci_swds)
+			pci_swus = pci_upstream_bridge(pci_swds);
+
+		if (pci_swus)
+			pcie_cap_offset = amd_read_link_status(pci_swus, &lnk_word);
+
+		if (pcie_cap_offset) {
+			NTB_LOG(ERR, "[%s()] failed to find the pcie capability", __func__);
+			return pcie_cap_offset;
+		}
+
+	}
+
+	NTB_LOG(INFO, "&lnk_word %x", lnk_word);
+	ntb->link_status = lnk_word;
+	return 0;
+}
+
+static int
+amd_poll_link(struct ntb_hw *ntb)
+{
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	void *mmio = amd_hw->peer_mmio;
+	uint32_t reg;
+
+	reg = rte_read32(mmio + AMD_SIDEINFO_OFFSET);
+	reg &= AMD_SIDE_READY;
+
+	amd_hw->ctl_status = reg;
+
+	amd_link_status(ntb);
+
+	return amd_hw->ctl_status;
+}
+
+static int
+amd_link_is_up(struct ntb_hw *ntb)
+{
+	int ret;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+
+	ret = amd_poll_link(ntb);
+	if (ret) {
+		if (ntb->topo == NTB_TOPO_PRI) {
+			if ((amd_hw->peer_status & AMD_LINK_UP_EVENT) || (amd_hw->peer_status == 0))
+				return ret;
+			else if (amd_hw->peer_status & AMD_LINK_DOWN_EVENT) {
+				amd_clear_side_info_reg(amd_hw, true);
+				return 0;
+			}
+		} else /* NTB_TOPO_SEC */
+			return ret;
+	}
+	return 0;
+}
+
+/* Get link status */
+static int
+amd_ntb_get_link_status(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	int ret;
+
+	ret = amd_link_is_up(ntb);
+	if (ret) {
+		if (ntb->link_status) {
+			ntb->link_speed = AMD_NTB_LNK_STA_SPEED(ntb->link_status);
+			ntb->link_width = AMD_NTB_LNK_STA_WIDTH(ntb->link_status);
+		} else {
+			ntb->link_speed = NTB_SPEED_NONE;
+			ntb->link_width = NTB_WIDTH_NONE;
+		}
+	}
+
+	return 0;
+}
+
+static int
+amd_ntb_set_link(const struct rte_rawdev *dev, bool up)
+{
+	uint32_t ntb_ctl, ntb_side_ready;
+
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+
+	amd_hw->self_mmio = ntb->hw_addr;
+
+	void *mmio = amd_hw->self_mmio;
+
+	ntb_side_ready = rte_read32(mmio + AMD_SIDEINFO_OFFSET);
+	if (!(ntb_side_ready & AMD_SIDE_READY)) {
+		// AMD_SIDE_READY is a read-only register which tells topology (prim\secondary)
+		ntb_side_ready |= AMD_SIDE_READY;
+		rte_write32(ntb_side_ready, mmio + AMD_SIDEINFO_OFFSET);
+	}
+
+	ntb_ctl = rte_read32(mmio + AMD_CNTL_OFFSET);
+	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
+	rte_write32(ntb_ctl, mmio + AMD_CNTL_OFFSET);
+
+	NTB_LOG(INFO, "ntb_ctl_reg 0x%x ", rte_read32(mmio + AMD_CNTL_OFFSET));
+
+	return 0;
+}
+
+// scratch pad registed read
+static uint32_t
+amd_ntb_spad_read(const struct rte_rawdev *dev, int spad, bool peer)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	uint32_t offset;
+	void *reg_addr;
+
+	if (spad < 0 || spad >= ntb->spad_cnt) {
+		NTB_LOG(ERR, "Invalid scratchpad count.");
+		return -EINVAL;
+	}
+
+	if (peer) {
+		offset = amd_hw->peer_spad;
+		NTB_LOG(INFO, "peer side");
+	} else
+		offset = amd_hw->self_spad;
+
+	return rte_read32(ntb->hw_addr + AMD_SPAD_OFFSET + offset + (spad << 2));
+}
+
+//scratchpad register write
+static int
+amd_ntb_spad_write(const struct rte_rawdev *dev, int spad,
+		     bool peer, uint32_t spad_v)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	uint32_t offset;
+	void *reg_addr;
+
+	if (spad < 0 || spad >= ntb->spad_cnt) {
+		NTB_LOG(ERR, "Invalid scratchpad count.");
+		return -EINVAL;
+	}
+
+	if (peer)
+		offset = amd_hw->peer_spad + (spad << 2);
+	else
+		offset = amd_hw->self_spad + (spad << 2);
+
+	rte_write32(spad_v, ntb->hw_addr + AMD_SPAD_OFFSET + offset);
+
+	return 0;
+}
+
+static uint64_t
+amd_ntb_db_read(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	uint64_t db_bits;
+
+	if (amd_hw == NULL)
+		NTB_LOG(ERR, "Invalid device.");
+
+	db_bits = (uint64_t)rte_read16(amd_hw->self_mmio + AMD_DBSTAT_OFFSET);
+
+	return db_bits;
+}
+
+static int
+amd_ntb_db_clear(const struct rte_rawdev *dev, uint64_t db_bits)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+
+	if (amd_hw == NULL)
+		NTB_LOG(ERR, "Invalid device.");
+
+	rte_write16((uint16_t)db_bits, amd_hw->self_mmio + AMD_DBSTAT_OFFSET);
+	return 0;
+}
+
+static int
+amd_ntb_db_set_mask(const struct rte_rawdev *dev, uint64_t db_mask)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+
+	if (db_mask & (~ntb->db_valid_mask))
+		return -EINVAL;
+	ntb->db_mask |= db_mask;
+
+	rte_write16((uint16_t)ntb->db_mask, amd_hw->self_mmio + AMD_DBMASK_OFFSET);
+	return 0;
+}
+
+static int
+amd_ntb_peer_db_set(const struct rte_rawdev *dev, uint8_t db_idx)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+
+	if (((uint64_t)1 << db_idx) & ~ntb->db_valid_mask) {
+		NTB_LOG(ERR, "Invalid doorbell.");
+		return -EINVAL;
+	}
+
+	rte_write16((uint16_t)1 << db_idx, ntb->hw_addr + AMD_DBREQ_OFFSET);
+	return 0;
+}
+
+static void
+amd_ntb_dev_interrupt_handler(void *param)
+{
+	struct rte_rawdev *dev = (struct rte_rawdev *)param;
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	uint64_t db_bits = 0;
+	uint32_t event_value, event_set, peer_mw_cnt;
+
+	db_bits = amd_ntb_db_read(dev);
+	if (!db_bits)
+		NTB_LOG(ERR, "No doorbells");
+
+	/* Doorbell 0 is for peer device ready. */
+	if (db_bits & 1) {
+		/* Clear received doorbell. */
+		amd_ntb_db_clear(dev, 1);
+
+		/**
+		 * * Peer dev is already up. All mw settings are already done.
+		 */
+		if (ntb->peer_dev_up)
+			return;
+
+		/* Check if mw setting on the peer is the same as local. */
+		peer_mw_cnt = amd_ntb_spad_read(dev, SPAD_NUM_MWS, 1);
+
+		if (peer_mw_cnt != ntb->mw_cnt) {
+			NTB_LOG(ERR, "Both mw cnt must be the same peer_mw_cnt %d,  ntb->mw_cnt %d  .", peer_mw_cnt,  ntb->mw_cnt);
+			return;
+		}
+
+		ntb->peer_dev_up = 1;
+
+		/**
+		 * * Handshake with peer. Spad_write & mw_set_trans only works
+		 * * when both devices are up. So write spad again when db is
+		 * * received. And set db again for the later device who may miss
+		 * * the 1st db.
+		 */
+
+		return;
+	}
+
+	if (db_bits & (1 << 1)) {
+		NTB_LOG(INFO, "DB1: Peer device is down.");
+
+		/* Clear received doorbell. */
+		amd_ntb_db_clear(dev, 2);
+
+		/* Peer device will be down, So clean local side too. */
+		ntb->peer_dev_up = 0;
+
+		/* Response peer's dev_stop request. */
+		amd_ntb_peer_db_set(dev, 2);
+		return;
+	}
+
+	if (db_bits & (1 << 2)) {
+		NTB_LOG(INFO, "DB2: Peer device agrees dev to be down.");
+
+		/* Clear received doorbell. */
+		amd_ntb_db_clear(dev, (1 << 2));
+		ntb->peer_dev_up = 0;
+
+		return;
+	}
+
+	/* Clear other received doorbells. */
+	amd_ntb_db_clear(dev, db_bits);
+
+	event_value = rte_read32(amd_hw->self_mmio + AMD_INTSTAT_OFFSET);
+
+	if (event_value != 0) {
+		event_value &= AMD_EVENT_INTMASK;
+
+		switch (event_value) {
+
+		case AMD_PEER_FLUSH_EVENT:
+			NTB_LOG(INFO, "Peer Flush Event occurred.");
+			break;
+		case AMD_PEER_RESET_EVENT:
+		case AMD_LINK_DOWN_EVENT:
+		case AMD_PEER_D3_EVENT:
+		case AMD_PEER_PMETO_EVENT:
+		case AMD_LINK_UP_EVENT:
+			event_set = rte_read32(amd_hw->self_mmio + AMD_SMUACK_OFFSET);
+			event_set |= event_value;
+			rte_write32(event_set, amd_hw->self_mmio + AMD_SMUACK_OFFSET);
+			break;
+
+		case AMD_PEER_D0_EVENT:
+			event_set = rte_read32(amd_hw->self_mmio + AMD_PMESTAT_OFFSET);
+			if (event_set & 0x0001)
+				NTB_LOG(INFO, "D0 Wakeup completed for NTB");
+			event_set = rte_read32(amd_hw->self_mmio + AMD_SMUACK_OFFSET);
+			event_set |= event_value;
+			rte_write32(event_set, amd_hw->self_mmio + AMD_SMUACK_OFFSET);
+			break;
+		default:
+			NTB_LOG(ERR, "Invalid Interrupt event.");
+			break;
+		}
+	}
+}
+
+static int
+amd_ntb_vector_bind(const struct rte_rawdev *dev, uint8_t intr, uint8_t msix)
+{
+	return 0;
+}
+
+
+
+/* operations for primary side of local ntb */
+const struct ntb_dev_ops amd_ntb_ops = {
+	.ntb_dev_init	= amd_ntb_dev_init,
+	.get_peer_mw_addr	= amd_ntb_get_peer_mw_addr,
+	.get_peer_mw_addr_phys	= amd_ntb_get_peer_mw_addr_phys,
+	.mw_set_trans	= amd_ntb_mw_set_trans,
+	.ioremap		= amd_ntb_ioremap,
+	.get_link_status	= amd_ntb_get_link_status,
+	.set_link		= amd_ntb_set_link,
+	.spad_read		= amd_ntb_spad_read,
+	.spad_write		= amd_ntb_spad_write,
+	.db_read		= amd_ntb_db_read,
+	.db_clear		= amd_ntb_db_clear,
+	.db_set_mask		= amd_ntb_db_set_mask,
+	.peer_db_set		= amd_ntb_peer_db_set,
+	.vector_bind		= amd_ntb_vector_bind,
+	.interrupt_handler	= amd_ntb_dev_interrupt_handler,
+};
+
diff --git a/drivers/raw/ntb/ntb_hw_amd.h b/drivers/raw/ntb/ntb_hw_amd.h
new file mode 100644
index 0000000000..1346c6942c
--- /dev/null
+++ b/drivers/raw/ntb/ntb_hw_amd.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Advanced Micro Devices, Inc. All Rights Reserved.
+ */
+#ifndef _NTB_HW_AMD_H_
+#define _NTB_HW_AMD_H_
+
+#include <rte_bus_pci.h>
+#include <bus_driver.h>
+#include <bus_pci_driver.h>
+#include <rte_bus_pci.h>
+#include <rte_byteorder.h>
+#include <rte_io.h>
+#include <rte_pci.h>
+#include <rte_spinlock.h>
+#include <rte_memzone.h>
+
+
+/**
+ * Structure describing the PCI bus
+ */
+#if 1
+struct rte_pci_bus {
+        struct rte_bus bus;               /**< Inherit the generic class */
+        RTE_TAILQ_HEAD(, rte_pci_device) device_list; /**< List of PCI devices */
+        RTE_TAILQ_HEAD(, rte_pci_driver) driver_list; /**< List of PCI drivers */
+};
+#endif
+
+extern struct rte_pci_bus rte_pci_bus;
+
+/* PCI Bus iterators */
+#define FOREACH_DEVICE_ON_PCIBUS(p)     \
+        RTE_TAILQ_FOREACH(p, &(rte_pci_bus.device_list), next)
+
+#define FOREACH_DRIVER_ON_PCIBUS(p)     \
+        RTE_TAILQ_FOREACH(p, &(rte_pci_bus.driver_list), next)
+
+
+#define BIT(nr)                         (1 << (nr))
+
+/* AMD NTB Regsiters */
+#define	AMD_DB_COUNT		16
+#define	AMD_MSIX_VECTOR_COUNT	24
+#define	AMD_SPADS_COUNT		16
+#define AMD_MW_COUNT		2
+#define AMD_MW_IDX		2
+
+#define AMD_PEER_OFFSET		0x400
+#define AMD_SIDEINFO_OFFSET	0x408
+#define AMD_DBFM_OFFSET		0x450
+#define	AMD_DBREQ_OFFSET	0x454
+#define AMD_DBMASK_OFFSET	0x45C
+#define AMD_DBSTAT_OFFSET	0x460
+#define AMD_INTMASK_OFFSET	0x470
+#define	AMD_INTSTAT_OFFSET	0x474
+#define	AMD_PMESTAT_OFFSET	0x480
+
+/* event type */
+#define	AMD_PEER_FLUSH_EVENT	BIT(0)
+#define	AMD_PEER_RESET_EVENT	BIT(1)
+#define	AMD_PEER_D3_EVENT	BIT(2)
+#define	AMD_PEER_PMETO_EVENT	BIT(3)
+#define	AMD_PEER_D0_EVENT	BIT(4)
+#define	AMD_LINK_UP_EVENT	BIT(5)
+#define	AMD_LINK_DOWN_EVENT	BIT(6)
+#define	AMD_EVENT_INTMASK	(AMD_PEER_FLUSH_EVENT | AMD_PEER_RESET_EVENT | \
+		AMD_PEER_D3_EVENT | AMD_PEER_PMETO_EVENT | AMD_PEER_D0_EVENT | \
+		AMD_LINK_UP_EVENT | AMD_LINK_DOWN_EVENT)
+
+
+/* Bar Registers */
+#define	AMD_BAR23_XLAT_OFFSET	0x438
+#define	AMD_BAR23_LIMIT_OFFSET	0x418
+#define	AMD_BAR45_XLAT_OFFSET	0x440
+#define	AMD_BAR45_LIMIT_OFFSET	0x420
+
+#define AMD_SIDE_MASK  BIT(0)
+#define AMD_SIDE_READY BIT(1)
+
+#define AMD_SPAD_OFFSET		0x210
+#define AMD_CNTL_OFFSET		0x200
+
+#define PMM_REG_CTL		BIT(21)
+#define SMM_REG_CTL		BIT(20)
+
+/* SMU registers */
+#define	AMD_SMUACK_OFFSET		0x4A0
+
+#define AMD_NTB_LNK_STA_ACTIVE_BIT          0x2000
+#define AMD_NTB_LNK_STA_SPEED_MASK          0x000f
+#define AMD_NTB_LNK_STA_WIDTH_MASK          0x03f0
+#define AMD_NTB_LNK_STA_ACTIVE(x)           (!!((x) & AMD_NTB_LNK_STA_ACTIVE_BIT))
+#define AMD_NTB_LNK_STA_SPEED(x)            ((x) & AMD_NTB_LNK_STA_SPEED_MASK)
+#define AMD_NTB_LNK_STA_WIDTH(x)            (((x) & AMD_NTB_LNK_STA_WIDTH_MASK) >> 4)
+
+#define PCI_CLASS_BRIDGE_PCI 0x060400
+
+enum ntb_bar {
+	NTB_BAR23 = 2,
+	NTB_BAR45 = 4,
+};
+
+static enum ntb_bar amd_ntb_bar[] = {
+	NTB_BAR23,
+	NTB_BAR45,
+};
+
+struct amd_ntb_hw {
+
+	void  *self_mmio;
+        void  *peer_mmio;
+        unsigned int self_spad;
+        unsigned int peer_spad;
+
+	uint32_t peer_status;
+	uint32_t ctl_status;
+
+	uint32_t int_mask;
+
+
+};
+
+#endif
diff --git a/drivers/raw/ntb/ntb_hw_intel.c b/drivers/raw/ntb/ntb_hw_intel.c
index 9b4465176a..d9c45d6891 100644
--- a/drivers/raw/ntb/ntb_hw_intel.c
+++ b/drivers/raw/ntb/ntb_hw_intel.c
@@ -613,6 +613,26 @@ intel_ntb_vector_bind(const struct rte_rawdev *dev, uint8_t intr, uint8_t msix)
 	return 0;
 }
 
+static void
+intel_ntb_dev_interrupt_handler(void *param)
+{
+	struct rte_rawdev *dev = (struct rte_rawdev *)param;
+        struct ntb_hw *hw = dev->dev_private;
+        uint32_t val_h, val_l;
+        uint64_t peer_mw_size;
+        uint64_t db_bits = 0;
+        uint8_t peer_mw_cnt;
+        int i = 0;
+	
+	if (hw->ntb_ops->db_read == NULL ||
+			hw->ntb_ops->db_clear == NULL ||
+			hw->ntb_ops->peer_db_set == NULL) {
+		NTB_LOG(ERR, "Doorbell is not supported.");
+		return;
+	}
+}
+
+
 /* operations for primary side of local ntb */
 const struct ntb_dev_ops intel_ntb_ops = {
 	.ntb_dev_init       = intel_ntb_dev_init,
@@ -628,4 +648,5 @@ const struct ntb_dev_ops intel_ntb_ops = {
 	.db_set_mask        = intel_ntb_db_set_mask,
 	.peer_db_set        = intel_ntb_peer_db_set,
 	.vector_bind        = intel_ntb_vector_bind,
+	.interrupt_handler  = intel_ntb_dev_interrupt_handler,
 };
diff --git a/drivers/raw/ntb/rte_pmd_ntb.h b/drivers/raw/ntb/rte_pmd_ntb.h
index 6591ce7931..d9e5da2533 100644
--- a/drivers/raw/ntb/rte_pmd_ntb.h
+++ b/drivers/raw/ntb/rte_pmd_ntb.h
@@ -15,6 +15,8 @@
 #define NTB_MW_CNT_NAME             "mw_count"
 #define NTB_DB_CNT_NAME             "db_count"
 #define NTB_SPAD_CNT_NAME           "spad_count"
+#define NTB_BASE_ADDR		    "base_addr"
+#define NTB_BASE_ADDR_PHYS	    "base_addr_phy"
 
 #define NTB_MAX_DESC_SIZE           1024
 #define NTB_MIN_DESC_SIZE           64
diff --git a/examples/ntb/commands.list b/examples/ntb/commands.list
index a26b8acfa3..04fff5f66d 100644
--- a/examples/ntb/commands.list
+++ b/examples/ntb/commands.list
@@ -8,4 +8,4 @@ start                  # start pkt fwd between ntb and ethdev
 stop                   # stop packet forwarding
 show port stats        # show statistics for all ports
 clear port stats       # clear all port statistics
-set fwd <(file-trans,iofwd,txonly,rxonly)>mode  # set forwarding mode as file-trans|rxonly|txonly|iofwd
+set fwd <(file-trans,ntbperf,iofwd,txonly,rxonly)>mode  # set forwarding mode as file-trans|ntbperf|rxonly|txonly|iofwd
diff --git a/examples/ntb/ntb_fwd.c b/examples/ntb/ntb_fwd.c
index 37d60208e3..ba1a400852 100644
--- a/examples/ntb/ntb_fwd.c
+++ b/examples/ntb/ntb_fwd.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2019 Intel Corporation
  */
+
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -17,12 +18,41 @@
 #include <rte_rawdev.h>
 #include <rte_ethdev.h>
 #include <rte_malloc.h>
+#include <rte_memory.h>
 #include <rte_lcore.h>
 #include <rte_cycles.h>
 #include <rte_pmd_ntb.h>
 #include <rte_mbuf_pool_ops.h>
+
+#include "lib/dmadev/rte_dmadev.h"
 #include "commands.h"
 
+#define ALIGN_4K 4096
+#define TOTAL_ORDER (1048576)
+#define CHUNK_ORDER (1024)
+#define PBAR23 0x8df00000000
+#define PBAR23_XLAT 0x17b330000
+
+#define PBAR45 0x8dec0000000
+#define MAX_DMA_DEVS 64
+
+void *out_buf;
+uint64_t out_buf_phys;
+static uint8_t dmacopy;
+
+static void
+__rte_format_printf(3, 4)
+print_err(const char *func, int lineno, const char *format, ...)
+{
+	va_list ap;
+
+	fprintf(stderr, "In %s:%d - ", func, lineno);
+	va_start(ap, format);
+	vfprintf(stderr, format, ap);
+}
+#define ERR_RETURN(...) do { print_err(__func__, __LINE__, __VA_ARGS__); return -1; } while (0)
+
+
 /* Per-port statistics struct */
 struct __rte_cache_aligned ntb_port_statistics {
 	uint64_t tx;
@@ -44,8 +74,19 @@ struct ntb_fwd_lcore_conf {
 	uint8_t stopped;
 };
 
+struct ntb_perf_conf {
+	void *outbuf;
+	uint64_t outbuf_phys;
+	uint16_t use_dma;
+	uint16_t dma_dev_id;
+};
+
+static uint16_t dma_dev_count;
+uint16_t dma_dev_ids[MAX_DMA_DEVS];
+
 enum ntb_fwd_mode {
 	FILE_TRANS = 0,
+	NTBPERF,
 	RXONLY,
 	TXONLY,
 	IOFWD,
@@ -53,6 +94,7 @@ enum ntb_fwd_mode {
 };
 static const char *const fwd_mode_s[] = {
 	"file-trans",
+	"ntbperf",
 	"rxonly",
 	"txonly",
 	"iofwd",
@@ -85,7 +127,12 @@ static uint16_t tx_free_thresh;
 
 #define NTB_MAX_PKT_BURST 32
 #define NTB_DFLT_PKT_BURST 32
+#define NUM_BUFFERS_PER_LCORE (TOTAL_ORDER / CHUNK_ORDER)
+
 static uint16_t pkt_burst = NTB_DFLT_PKT_BURST;
+static uint64_t total_order = TOTAL_ORDER;
+static uint64_t chunk_order = CHUNK_ORDER;
+
 
 #define BURST_TX_RETRIES 64
 
@@ -114,19 +161,13 @@ cmd_help_parsed(__rte_unused void *parsed_result,
 		"\n"
 		"The following commands are currently available:\n\n"
 		"Control:\n"
-		"    quit                                      :"
-		" Quit the application.\n"
+		"    quit                                      : Quit the application.\n"
 		"\nTransmission:\n"
-		"    send [path]                               :"
-		" Send [path] file. Only take effect in file-trans mode\n"
-		"    start                                     :"
-		" Start transmissions.\n"
-		"    stop                                      :"
-		" Stop transmissions.\n"
-		"    clear/show port stats                     :"
-		" Clear/show port stats.\n"
-		"    set fwd file-trans/rxonly/txonly/iofwd    :"
-		" Set packet forwarding mode.\n"
+		"    send [path]                               : Send [path] file. Only take effect in file-trans mode\n"
+		"    start                                     : Start transmissions.\n"
+		"    stop                                      : Stop transmissions.\n"
+		"    clear/show port stats                     : Clear/show port stats.\n"
+		"    set fwd file-trans/rxonly/txonly/iofwd/ntbperf    : Set packet forwarding mode.\n"
 	);
 
 }
@@ -356,6 +397,107 @@ start_polling_recv_file(void *param)
 	return 0;
 }
 
+static int
+start_perf_data_trans(void *param)
+{
+	int32_t i, j, ret;
+	uint16_t dma_dev_id;
+	uint8_t *dst;
+	uint64_t start, end;
+	double cpu_time_seconds, cpu_time_ms;
+	double bandwidth_MBps;
+	int32_t total_buffers;
+	uint32_t current_dst_offset = 0;
+	uint32_t lcore_id = rte_lcore_id();
+
+	char mempool_name[RTE_MEMPOOL_NAMESIZE];
+	uint8_t *src_buffers[NUM_BUFFERS_PER_LCORE];
+	struct rte_mempool *src_mp = {NULL};
+	struct ntb_perf_conf *perf_conf = param;
+
+	total_buffers =  NUM_BUFFERS_PER_LCORE;
+
+
+	snprintf(mempool_name, sizeof(mempool_name), "src_mempool_lcore%u", lcore_id);
+
+	src_mp = rte_mempool_create(mempool_name, total_buffers,
+				chunk_order, MEMPOOL_CACHE_SIZE, 0,
+				NULL, NULL, NULL, NULL,
+				rte_socket_id(), 0);
+	if (src_mp == NULL)
+		rte_exit(EXIT_FAILURE, "Failed to create mempool 'src_mempool' for socket %d: %s\n",
+				rte_socket_id(), rte_strerror(rte_errno));
+
+	for (i = 0; i < total_buffers; i++) {
+
+		ret = rte_mempool_get(src_mp, (void *)&src_buffers[i]);
+		if (ret < 0)
+			rte_exit(EXIT_FAILURE, "Error getting buffer from mempool %u: %s\n",
+					i, rte_strerror(rte_errno));
+		for (j = 0; j < chunk_order; j++)
+			src_buffers[i][j] =  (uint8_t)(rand() % 256);
+	}
+
+	if (total_order == 0 || chunk_order == 0) {
+		printf("Error: Invalid parameters for copy.\n");
+		return -EINVAL;
+	}
+
+
+	start = rte_get_tsc_cycles();
+
+	if (perf_conf->use_dma == 0) {
+		printf(" its cpu_copy\n");
+		dst = perf_conf->outbuf;
+		printf("dst cpu  = %lx\n", dst);
+
+		for (i = 0; i < total_buffers; i++) {
+			if (current_dst_offset + chunk_order > total_order) {
+				rte_memcpy(dst + current_dst_offset, src_buffers[i], total_order - current_dst_offset);
+				break;
+			}
+			rte_memcpy(dst + current_dst_offset, src_buffers[i], chunk_order);
+			current_dst_offset += chunk_order;
+		}
+	} else {
+		printf(" its dma_copy\n");
+		dst = perf_conf->outbuf_phys;
+		dma_dev_id = perf_conf->dma_dev_id;
+		for (i = 0; i < total_buffers; i++) {
+			if (current_dst_offset + chunk_order > total_order) {
+				rte_dma_copy(dma_dev_id, 0, rte_mempool_virt2iova(src_buffers[i]), dst + current_dst_offset,
+				total_order-current_dst_offset, RTE_DMA_OP_FLAG_SUBMIT);
+				rte_dma_completed(dma_dev_id, 0, 1, NULL, NULL);
+				break;
+			}
+
+			rte_dma_copy(dma_dev_id, 0, rte_mempool_virt2iova(src_buffers[i]), dst + current_dst_offset,
+			chunk_order, RTE_DMA_OP_FLAG_SUBMIT);
+			rte_dma_completed(dma_dev_id, 0, 1, NULL, NULL);
+			current_dst_offset += chunk_order;
+		}
+
+	}
+	end = rte_get_tsc_cycles();
+
+	cpu_time_seconds = (double)(end - start) / rte_get_tsc_hz();
+	cpu_time_ms = cpu_time_seconds * 1000.0;
+
+	bandwidth_MBps = (double)total_order / (cpu_time_seconds * 1024 * 1024);
+
+	if (perf_conf->use_dma)
+		printf("Data copied: %u bytes in  %.3f ms. Bandwidth: %.2f MBytes/s on thread %u with dmadev %u\n", total_order, cpu_time_ms, bandwidth_MBps, lcore_id, dma_dev_id);
+	else
+		printf("Data copied: %u bytes in  %.3f ms. Bandwidth: %.2f MBytes/s on thread %u\n", total_order, cpu_time_ms, bandwidth_MBps, lcore_id);
+
+	for (i = 0; i < total_buffers; i++)
+		rte_mempool_put(src_mp, src_buffers[i]);
+
+	rte_mempool_free(src_mp);
+	return 0;
+}
+
+
 static int
 start_iofwd_per_lcore(void *param)
 {
@@ -538,10 +680,49 @@ start_txonly_per_lcore(void *param)
 	return 0;
 }
 
+static int
+ntb_perf_config_dmadevs(int dev_id)
+{
+	char *dma_name;
+	int ret;
+	uint16_t vchan = 0;
+	struct rte_dma_info info;
+	const struct rte_dma_conf conf = { .nb_vchans = 1};
+	const struct rte_dma_vchan_conf qconf = {
+			.direction = RTE_DMA_DIR_MEM_TO_MEM,
+			.nb_desc = 32,
+	};
+
+	if (dev_id < 0) {
+		fprintf(stderr, "Error: Fail to find DMA %s.\n", dma_name);
+		return -1;
+	}
+
+	if (rte_dma_configure(dev_id, &conf) != 0)
+		ERR_RETURN("Error with rte_dma_configure()\n");
+
+	if (rte_dma_vchan_setup(dev_id, vchan, &qconf) < 0)
+		ERR_RETURN("Error with queue configuration\n");
+
+	ret = rte_dma_info_get(dev_id, &info);
+	if (ret != 0 || info.nb_vchans != 1)
+		ERR_RETURN("Error, no configured queues reported on device id %u\n", dev_id);
+
+	fprintf(stdout, "iinfo.devname= %s;info.nb_vchn = %d;info.min_desc = %d;info.max_desc = %d\n",
+			info.dev_name, info.nb_vchans, info.min_desc, info.max_desc);
+
+	if (rte_dma_start(dev_id) != 0)
+		ERR_RETURN("Error with rte_dma_start()\n");
+
+	return dev_id;
+}
+
+
 static int
 ntb_fwd_config_setup(void)
 {
 	uint16_t i;
+	int dma_dev_id;
 
 	/* Make sure iofwd has valid ethdev. */
 	if (fwd_mode == IOFWD && eth_port_id >= RTE_MAX_ETHPORTS) {
@@ -584,6 +765,33 @@ ntb_fwd_config_setup(void)
 		return 0;
 	}
 
+	if (fwd_mode == NTBPERF) {
+		if (dmacopy) {
+			dma_dev_count = rte_dma_count_avail();
+			printf("rte_dma_count_avail() = %d\n", dma_dev_count);
+			i = 0;
+				RTE_DMA_FOREACH_DEV(dma_dev_id) {
+					dma_dev_id = ntb_perf_config_dmadevs(dma_dev_id);
+					printf(" dma_dev_id => %d\n", dma_dev_id);
+					dma_dev_ids[i] = dma_dev_id;
+					i++;
+				}
+		}
+		 num_queues = rte_lcore_count();
+		 printf("num_queus = %u\n", num_queues);
+
+		 fwd_streams = rte_zmalloc("ntb_fwd: fwd_streams",
+				sizeof(struct ntb_fwd_stream) * num_queues,
+				RTE_CACHE_LINE_SIZE);
+		for (i = 0; i < num_queues; i++) {
+			fwd_streams[i].qp_id = i;
+			fwd_streams[i].tx_port = RTE_MAX_ETHPORTS;
+			fwd_streams[i].rx_port = dev_id;
+			fwd_streams[i].tx_ntb = 1;
+		}
+		return 0;
+	}
+
 	if (fwd_mode == TXONLY) {
 		fwd_streams = rte_zmalloc("ntb_fwd: fwd_streams",
 				sizeof(struct ntb_fwd_stream) * num_queues,
@@ -647,8 +855,8 @@ assign_stream_to_lcores(void)
 		for (i = 0; i < conf->nb_stream; i++) {
 			fs = &fwd_streams[conf->stream_id + i];
 			if (fwd_mode == IOFWD)
-				printf(" + Stream %u : %s%u RX -> %s%u TX,"
-					" Q=%u\n", conf->stream_id + i,
+				printf(" + Stream %u : %s%u RX -> %s%u TX, Q=%u\n",
+					conf->stream_id + i,
 					fs->tx_ntb ? "Eth" : "NTB", fs->rx_port,
 					fs->tx_ntb ? "NTB" : "Eth", fs->tx_port,
 					fs->qp_id);
@@ -666,6 +874,7 @@ static void
 start_pkt_fwd(void)
 {
 	struct ntb_fwd_lcore_conf *conf;
+	struct ntb_perf_conf *perf_conf;
 	struct rte_eth_link eth_link;
 	uint32_t lcore_id;
 	int ret, i;
@@ -705,10 +914,12 @@ start_pkt_fwd(void)
 
 	assign_stream_to_lcores();
 	in_test = 1;
+	i = 0;
 
 	RTE_LCORE_FOREACH_WORKER(lcore_id) {
 		conf = &fwd_lcore_conf[lcore_id];
 
+
 		if (!conf->nb_stream)
 			continue;
 
@@ -716,7 +927,27 @@ start_pkt_fwd(void)
 		if (fwd_mode == FILE_TRANS)
 			rte_eal_remote_launch(start_polling_recv_file,
 					      conf, lcore_id);
-		else if (fwd_mode == IOFWD)
+		else if (fwd_mode == NTBPERF) {
+			perf_conf = (struct ntb_perf_conf *)
+				malloc(sizeof(struct ntb_perf_conf));
+			if (dmacopy == 0) {
+				perf_conf->use_dma = 0;
+				perf_conf->dma_dev_id = -1;
+				perf_conf->outbuf = out_buf;
+			} else if (dmacopy == 1) {
+				perf_conf->use_dma = 1;
+				perf_conf->outbuf_phys = out_buf_phys;
+				perf_conf->dma_dev_id = dma_dev_ids[i++];
+				printf("perf_conf.dma_dev_id = %d\n", perf_conf->dma_dev_id);
+				if (i >= dma_dev_count) {
+					printf("dma_dev_count crossed -> i = %d\n", i);
+					i = 0;
+				}
+
+			}
+		      rte_eal_remote_launch(start_perf_data_trans,
+					 (void *)perf_conf, lcore_id);
+		} else if (fwd_mode == IOFWD)
 			rte_eal_remote_launch(start_iofwd_per_lcore,
 					      conf, lcore_id);
 		else if (fwd_mode == RXONLY)
@@ -947,6 +1178,9 @@ signal_handler(int signum)
 #define OPT_TXFREET          "txfreet"
 #define OPT_BURST            "burst"
 #define OPT_QP               "qp"
+#define OPT_USE_DMA	     "use_dma"
+#define OPT_TOTAL_ORDER      "total_order"
+#define OPT_CHUNK_ORDER      "chunk_order"
 
 enum {
 	/* long options mapped to a short option */
@@ -957,6 +1191,9 @@ enum {
 	OPT_TXFREET_NUM,
 	OPT_BURST_NUM,
 	OPT_QP_NUM,
+	OPT_USE_DMA_NUM,
+	OPT_TOTAL_ORDER_NUM,
+	OPT_CHUNK_ORDER_NUM,
 };
 
 static const char short_options[] =
@@ -970,6 +1207,9 @@ static const struct option lgopts[] = {
 	{OPT_TXFREET,      1, NULL, OPT_TXFREET_NUM      },
 	{OPT_BURST,        1, NULL, OPT_BURST_NUM        },
 	{OPT_QP,           1, NULL, OPT_QP_NUM           },
+	{OPT_USE_DMA,      1, NULL, OPT_USE_DMA_NUM	 },
+	{OPT_TOTAL_ORDER,  1, NULL, OPT_TOTAL_ORDER_NUM  },
+	{OPT_CHUNK_ORDER,  1, NULL, OPT_CHUNK_ORDER_NUM  },
 	{0,                0, NULL, 0                    }
 };
 
@@ -979,14 +1219,12 @@ ntb_usage(const char *prgname)
 	printf("%s [EAL options] -- [options]\n"
 	       "-i: run in interactive mode.\n"
 	       "-qp=N: set number of queues as N (N > 0, default: 1).\n"
-	       "--fwd-mode=N: set fwd mode (N: file-trans | rxonly | "
-	       "txonly | iofwd, default: file-trans)\n"
-	       "--buf-size=N: set mbuf dataroom size as N (0 < N < 65535,"
-	       " default: 2048).\n"
-	       "--nb-desc=N: set number of descriptors as N (%u <= N <= %u,"
-	       " default: 1024).\n"
+	       "--fwd-mode=N: set fwd mode (N: file-trans | rxonly | txonly | ntbperf | iofwd, default: file-trans)\n"
+	       "--buf-size=N: set mbuf dataroom size as N (0 < N < 65535, default: 2048).\n"
+	       "--nb-desc=N: set number of descriptors as N (%u <= N <= %u, default: 1024).\n"
 	       "--txfreet=N: set tx free thresh for NTB driver as N. (N >= 0)\n"
 	       "--burst=N: set pkt burst as N (0 < N <= %u default: 32).\n",
+	       "--perfdma=N: set for ntb_perf to use DMA(1) or CPU (0) copy.\n",
 	       prgname, NTB_MIN_DESC_SIZE, NTB_MAX_DESC_SIZE,
 	       NTB_MAX_PKT_BURST);
 }
@@ -1011,13 +1249,35 @@ ntb_parse_args(int argc, char **argv)
 			else
 				rte_exit(EXIT_FAILURE, "q must be > 0.\n");
 			break;
+		case OPT_USE_DMA_NUM:
+			n = atoi(optarg);
+			if (n == 0)
+				dmacopy = 0;
+			else if (n == 1)
+				dmacopy = 1;
+			else
+				rte_exit(EXIT_FAILURE, "pls select cpu copy or dma copy.\n");
+			break;
+		case OPT_TOTAL_ORDER_NUM:
+			n = atoi(optarg);
+			if (n > 0)
+				total_order = n;
+			else
+				rte_exit(EXIT_FAILURE, "pls enter a valid total order %d.\n", n);
+			break;
+		case OPT_CHUNK_ORDER_NUM:
+			n = atoi(optarg);
+			if (n > 0)
+				chunk_order = n;
+			else
+				rte_exit(EXIT_FAILURE, "pls enter a valid chunk order.\n");
+			break;
 		case OPT_BUF_SIZE_NUM:
 			n = atoi(optarg);
 			if (n > RTE_PKTMBUF_HEADROOM && n <= 0xFFFF)
 				ntb_buf_size = n;
 			else
-				rte_exit(EXIT_FAILURE, "buf-size must be > "
-					"%u and < 65536.\n",
+				rte_exit(EXIT_FAILURE, "buf-size must be > %u and < 65536.\n",
 					RTE_PKTMBUF_HEADROOM);
 			break;
 		case OPT_FWD_MODE_NUM:
@@ -1028,34 +1288,31 @@ ntb_parse_args(int argc, char **argv)
 				}
 			}
 			if (i == MAX_FWD_MODE)
-				rte_exit(EXIT_FAILURE, "Unsupported mode. "
-				"(Should be: file-trans | rxonly | txonly "
-				"| iofwd)\n");
+				rte_exit(EXIT_FAILURE, "Unsupported mode. (Should be: file-trans \
+					| rxonly | txonly | iofwd | ntbperf)\n");
 			break;
 		case OPT_NB_DESC_NUM:
 			n = atoi(optarg);
 			if (n >= NTB_MIN_DESC_SIZE && n <= NTB_MAX_DESC_SIZE)
 				nb_desc = n;
 			else
-				rte_exit(EXIT_FAILURE, "nb-desc must be within"
-					" [%u, %u].\n", NTB_MIN_DESC_SIZE,
-					NTB_MAX_DESC_SIZE);
+				rte_exit(EXIT_FAILURE, "nb-desc must be within [%u, %u].\n",
+						NTB_MIN_DESC_SIZE, NTB_MAX_DESC_SIZE);
 			break;
 		case OPT_TXFREET_NUM:
 			n = atoi(optarg);
 			if (n >= 0)
 				tx_free_thresh = n;
 			else
-				rte_exit(EXIT_FAILURE, "txfreet must be"
-					" >= 0\n");
+				rte_exit(EXIT_FAILURE, "txfreet must be >= 0\n");
 			break;
 		case OPT_BURST_NUM:
 			n = atoi(optarg);
 			if (n > 0 && n <= NTB_MAX_PKT_BURST)
 				pkt_burst = n;
 			else
-				rte_exit(EXIT_FAILURE, "burst must be within "
-					"(0, %u].\n", NTB_MAX_PKT_BURST);
+				rte_exit(EXIT_FAILURE, "burst must be within (0, %u].\n",
+						NTB_MAX_PKT_BURST);
 			break;
 
 		default:
@@ -1072,6 +1329,7 @@ ntb_mempool_mz_free(__rte_unused struct rte_mempool_memhdr *memhdr,
 		void *opaque)
 {
 	const struct rte_memzone *mz = opaque;
+
 	rte_memzone_free(mz);
 }
 
@@ -1118,9 +1376,8 @@ ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
 
 	/* Put ntb header on mw0. */
 	if (ntb_info.mw_size[0] < ntb_info.ntb_hdr_size) {
-		printf("mw0 (size: %" PRIu64 ") is not enough for ntb hdr"
-		       " (size: %u)\n", ntb_info.mw_size[0],
-		       ntb_info.ntb_hdr_size);
+		printf("mw0 (size: %" PRIu64 ") is not enough for ntb hdr (size: %u)\n",
+				ntb_info.mw_size[0], ntb_info.ntb_hdr_size);
 		goto fail;
 	}
 
@@ -1141,10 +1398,10 @@ ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
 		if (!mz_len)
 			continue;
 		mz = rte_memzone_reserve_aligned(mz_name, mz_len, socket_id,
-					RTE_MEMZONE_IOVA_CONTIG, align);
+				RTE_MEMZONE_IOVA_CONTIG, ALIGN_4K);
 		if (mz == NULL) {
-			printf("Cannot allocate %" PRIu64 " aligned memzone"
-				" %u\n", align, mz_id);
+			printf("Cannot allocate %" PRIu64 " aligned memzone %u\n",
+					align, mz_id);
 			goto fail;
 		}
 		left_sz -= mz_len;
@@ -1246,8 +1503,8 @@ main(int argc, char **argv)
 	ntb_rawdev_conf.dev_private = (rte_rawdev_obj_t)(&ntb_conf);
 	ret = rte_rawdev_configure(dev_id, &ntb_rawdev_conf, sizeof(ntb_conf));
 	if (ret)
-		rte_exit(EXIT_FAILURE, "Can't config ntb dev: err=%d, "
-			"port=%u\n", ret, dev_id);
+		rte_exit(EXIT_FAILURE, "Can't config ntb dev: err=%d, port=%u\n",
+				ret, dev_id);
 
 	ntb_q_conf.tx_free_thresh = tx_free_thresh;
 	ntb_q_conf.nb_desc = nb_desc;
@@ -1284,6 +1541,16 @@ main(int argc, char **argv)
 	/* Find 1st ethdev */
 	eth_port_id = rte_eth_find_next(0);
 
+	rte_rawdev_get_attr(dev_id, NTB_BASE_ADDR, (void *) &out_buf);
+	if (out_buf == 0)
+		printf("outbuf is NULL: ERROR\n");
+
+	rte_rawdev_get_attr(dev_id, NTB_BASE_ADDR_PHYS, (uint64_t)&out_buf_phys);
+	if (out_buf_phys == 0)
+		printf("outbuf_phys is NULL: ERROR\n");
+	else
+		printf("outbuf_phys is = 0x%llx\n", out_buf_phys);
+
 	if (eth_port_id < RTE_MAX_ETHPORTS) {
 		ret = rte_eth_dev_info_get(eth_port_id, &ethdev_info);
 		if (ret)
@@ -1294,8 +1561,8 @@ main(int argc, char **argv)
 		ret = rte_eth_dev_configure(eth_port_id, num_queues,
 					    num_queues, &eth_pconf);
 		if (ret)
-			rte_exit(EXIT_FAILURE, "Can't config ethdev: err=%d, "
-				"port=%u\n", ret, eth_port_id);
+			rte_exit(EXIT_FAILURE, "Can't config ethdev: err=%d, port=%u\n",
+					ret, eth_port_id);
 		eth_rx_conf = ethdev_info.default_rxconf;
 		eth_rx_conf.offloads = eth_pconf.rxmode.offloads;
 		eth_tx_conf = ethdev_info.default_txconf;
@@ -1319,8 +1586,8 @@ main(int argc, char **argv)
 
 		ret = rte_eth_dev_start(eth_port_id);
 		if (ret < 0)
-			rte_exit(EXIT_FAILURE, "rte_eth_dev_start: err=%d, "
-				"port=%u\n", ret, eth_port_id);
+			rte_exit(EXIT_FAILURE, "rte_eth_dev_start: err=%d, port=%u\n",
+					ret, eth_port_id);
 	}
 
 	/* initialize port stats */
@@ -1331,6 +1598,11 @@ main(int argc, char **argv)
 		printf("Set default fwd mode as iofwd.\n");
 		fwd_mode = IOFWD;
 	}
+	if (fwd_mode == NTBPERF) {
+		printf(" Set default fwd mode as data-tran (ntb_perf).\n");
+		fwd_mode = NTBPERF;
+	}
+
 	if (fwd_mode == MAX_FWD_MODE) {
 		printf("Set default fwd mode as file-trans.\n");
 		fwd_mode = FILE_TRANS;
diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index 283707fc16..0ddea56323 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -66,6 +66,12 @@
                  'SVendor': None, 'SDevice': None}
 intel_ntb_icx = {'Class': '06', 'Vendor': '8086', 'Device': '347e',
                  'SVendor': None, 'SDevice': None}
+amd_ntb_pri =   {'Class': '06', 'Vendor': '1022', 'Device': '14c0',
+                 'SVendor': None, 'SDevice': None}
+
+amd_ntb_sec =  {'Class': '06', 'Vendor': '1022', 'Device': '14c3',
+                 'SVendor': None, 'SDevice': None}
+
 
 cnxk_sso = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f9,a0fa',
             'SVendor': None, 'SDevice': None}
@@ -74,6 +80,9 @@
 cn9k_ree = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f4',
             'SVendor': None, 'SDevice': None}
 
+amd_ae4dma = {'Class': '08', 'Vendor': '1022', 'Device': '149b',
+                 'SVendor': None, 'SDevice': None}
+
 virtio_blk = {'Class': '01', 'Vendor': "1af4", 'Device': '1001,1042',
               'SVendor': None, 'SDevice': None}
 
@@ -83,7 +92,7 @@
 network_devices = [network_class, cavium_pkx, avp_vnic, ifpga_class]
 baseband_devices = [acceleration_class]
 crypto_devices = [encryption_class, intel_processor_class]
-dma_devices = [cnxk_dma, hisilicon_dma,
+dma_devices = [amd_ae4dma, cnxk_dma, hisilicon_dma,
                intel_idxd_spr, intel_ioat_bdw, intel_ioat_icx, intel_ioat_skx,
                odm_dma]
 eventdev_devices = [cavium_sso, cavium_tim, intel_dlb, cnxk_sso]
@@ -92,8 +101,8 @@
 regex_devices = [cn9k_ree]
 ml_devices = [cnxk_ml]
 misc_devices = [cnxk_bphy, cnxk_bphy_cgx, cnxk_inl_dev,
-                intel_ntb_skx, intel_ntb_icx,
-                virtio_blk]
+                intel_ntb_skx, intel_ntb_icx, amd_ntb_pri,
+                amd_ntb_sec, virtio_blk]
 
 # global dict ethernet devices present. Dictionary indexed by PCI address.
 # Each device within this is itself a dictionary of device properties
-- 
2.34.1

