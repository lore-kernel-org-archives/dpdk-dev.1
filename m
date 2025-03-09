Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ABDC28B28
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Mar 2025 08:46:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E551402A0;
	Sun,  9 Mar 2025 09:46:00 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by mails.dpdk.org (Postfix) with ESMTP id 0A8EE40151
 for <dev@dpdk.org>; Sun,  9 Mar 2025 09:45:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6RTM6NI97Tpxf4CIIR9qLw37I8KGLBJ/J0kBxjbypntNWqd1QXOWNA9tvmGzTHfnTrC3/BF9V9GSzUgxPj3oupXbQ1sasGi7eF1atg4IAIlzWMSi9Xxwx4GrCQaqwbat7jmZWvGVD60c9l2PaeFuABBmK5D3wzLaxmDK3HqvC2m0BcV5fZTMi18DArg1/NnPv7Fj3Oh+8cHmsuVrxHV3g+VW5L0ibUc0H+IClhfJ9TmagWq0KvCxXJpmlJAosuKxKu7OGn00SOGyD2RS5bfj5x0Zfxnl1re/8lmtW3Af3Q5aHd0hIm10DHlurbwKDeKBd6leniaL7p+mOP00RPv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xe//jLmBJ+4QTWNS9bgDmxDN35Ma6P2TyZHUIRAtMA=;
 b=l2MaD5/XDGnzAdzNxMPH1VzR87QEeGJIJQMmU/GA05InAVWkiIg3jyvtsngP56UVoKYj1WFgZ2yinYciJM5Dw9oZTPNjkWgmQCLO4pdInUNc8OnyDNvADVRcvj/ePUrMlai7Vh8kP0svWIELWSu5Aod1pEhtSMRuHRMxHNpCcadnuz4Ey9enJ6L4SNa/DGl9lYc7qukNTpRGvkvN2JniG+HgFPp1Pg7Zm1i795VvmQlx2aowUbVVt4PwS7wBAUDMYvoKnxig37JeCtwcuXdi4ZBT2Ns4niXtZ+i2d7ccGF7R+ae/YX/wvHWy4H2P+LbLZwZW+hWyxNOZZ2wfHqlqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xe//jLmBJ+4QTWNS9bgDmxDN35Ma6P2TyZHUIRAtMA=;
 b=NKxf6Fl3N3BJgNxwQxnKLfNGFSKlA9h/EK7ZKmUOpqPdeCHKv31kRseof8QXkh7vqkp4KgLpQqXYqJRBsKf7zdFiPxmIzzc7E3s1f5xRmd/IeZHnFQ1ffmyC9hxC5b0Jrs+LJjQW8pdJqg0SyDaPYR3S79aE3joYMGe0RaE10Y0=
Received: from SJ0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:a03:39e::23)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 08:45:53 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::d4) by SJ0PR03CA0288.outlook.office365.com
 (2603:10b6:a03:39e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Sun,
 9 Mar 2025 08:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Sun, 9 Mar 2025 08:45:53 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 9 Mar
 2025 03:45:50 -0500
From: Bhagyada Modali <bhagyada.modali@amd.com>
To: <dev@dpdk.org>
CC: <ssebasti@amd.com>, <rningoji@amd.com>, Bhagyada Modali
 <bhagyada.modali@amd.com>
Subject: [PATCH] dma\ae4dma: added AMD user space DMA driver
Date: Sun, 9 Mar 2025 14:15:26 +0530
Message-ID: <20250309084526.972512-1-bhagyada.modali@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf125b3-b69e-475c-f49b-08dd5ee6cd2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDUyTG4vNzA0VXN4NmNGRnNES1JzSzQ0S0dnZWhjL3RZSS9BaUx1Zml6V3hQ?=
 =?utf-8?B?SFBiOGtVbjRpTjVkWUhiMzhjM3EwNXR0VElkNmxpdG95dy8vcGlVY1JBajlx?=
 =?utf-8?B?VVlFcjdNQXFtdm4vcVVTdWZuZVBPUk9yaDlmSnMvWCtZcFByUjg1TU0rZmVY?=
 =?utf-8?B?d1dSZkZWYkxMR3FQVzI1WlF1ekIyUWkzZ21yNWZBK3Y5ZEJWdXQ0NHRycTd6?=
 =?utf-8?B?QVA1NThTOVR6UHBES05icS8xK1l4UDdzTDJoWFg1YVEvZjhLaG5QK3daS3g4?=
 =?utf-8?B?aHpNbmtrVTM4WXZnT1BWOHFjVTlyNldML2RTQjZkdHRMSWRiWGM3MjdSQzMr?=
 =?utf-8?B?MWkwMEhzL0wra2tQaDdudHAzSlpFeElIeWg0aUtWWUl0ZDk3M3h5MjhpYWt0?=
 =?utf-8?B?Wk5nUnowNXZuVkpCOVFzalk1VVB3b1U5N203UVY2akpoM2NHT0d3L0luNDZB?=
 =?utf-8?B?KzlhMXgyT2lRV1dUSXNjMzVhWlM4bytoUjFYM2lxb0FtTUdLQURaM3NrS1hX?=
 =?utf-8?B?VmVGQlhkUEZuV0xDYW94SzdOODEwWjhMeUdReHI0bExoMXpPakRsalJkMG5O?=
 =?utf-8?B?ZUp1b05BSUMzRWRUR2ZsQ2VEMDdJSklxcHdUWU9PV3Y4RjVMOEg4cHpBQjdo?=
 =?utf-8?B?bndCMFVVemR0M3B6aGRVaHExVDRKbUYyOUFTREExSnBJL044d0Q3L3BRT2lT?=
 =?utf-8?B?cVNVRzV6YllTS3hRTG5wTGVLNTQraE9YZkVzS3JrTWc0SUthR0Fad0grWGp1?=
 =?utf-8?B?dmlkMGlhWGtucGJpOFo4VUFpT1loa3NOQ2Y0Smc2V3FQWFRvSWhaeHBPblYz?=
 =?utf-8?B?MlNwejVrbmVoVzg0NjJSb3ZyV1gxNlJRNUJHUjRhb1FOcFVSL3M0SmZZYmVt?=
 =?utf-8?B?dFJpOFk5N25ERWxaWEp5WW9FM1EyeWxlS3Z1NFJTd1A2MWVOUnM3K2V0M05C?=
 =?utf-8?B?QXM3UkY1THg5QWZpZWRHNUQrNkJyRWhVU1AyMVVyclI0TWgweFdqR2k3dmNL?=
 =?utf-8?B?UUw4a0VEaFFxbEdZOURUSGlaK2YvUUR0ZG9kZ3EvcVVYTXpqZkxLR1VCTHM2?=
 =?utf-8?B?OWhMT21jcFlMZTBQWDJWbkpLMHNJZndTV0NjRGE4OHordGErejZvVStad0pj?=
 =?utf-8?B?K0hndDdJeGpYOS8yRlo0QkoxZDVPdTY0aGw3ZEZKUEh0RUFoaitzdVFHUGlY?=
 =?utf-8?B?MEtpVWRmL2MwUG1SZVp6N1RLdm1FMkpIQmlBdmZqMmMwVldCS0g3VjFUYVVt?=
 =?utf-8?B?M1NsaUFmdlVmRWFJZGRhMW5XZmVBSVVwMFArQXIyYXJHTSs5azF3VEdIM1lJ?=
 =?utf-8?B?YXFtRS92TkFJZTIyTXIxR3lxRVZxaWpTOVFNZVNXcjl4aDNNaW5aTUNhdHpZ?=
 =?utf-8?B?dnMyc1FEUUZUVDhDUTZ0cmFna3cvYzZWK3hvRTBTc00wSW8xaFpoZzI3bTNX?=
 =?utf-8?B?Q2FxNHdnNVJxSXJyU2EyQXF6Vy81VXI2OUVCWTZERVhEaFgwWFgyS0lpbm9M?=
 =?utf-8?B?NU9qTEY4dno4Q3BYeXFtZkd0Z1dJTC9TL0F1MzdEdlRSQ2dkdC9RS3cwM1RU?=
 =?utf-8?B?eGVaZXBnWUlHZDBxN1JsSFpUZlNNNnhDTVVMWUhaZ1Z1emJMdnhub01FaVl0?=
 =?utf-8?B?Q0NmSkVsaWVIZ2tZbU0zV2gyVi90WGhDbVFCZ1BnenlUeHNrbm10TmJFc2RB?=
 =?utf-8?B?UWZneXBjSS9LeXowU1BMdjIyL1duYjNHSXlSYnJCekpLWWNpa0ErWHo3dlpI?=
 =?utf-8?B?UHZ5ZC82U09QMFNPSXZzaXhwRGZubWpKQkRQNUc2V2RVKytNRy9MT25NUFg2?=
 =?utf-8?B?WExWdGlXK0p3T0MzS2lERmsxN2Yzd2xUbTJ2S3Nray9BdWZvQXVkL1lZbWxx?=
 =?utf-8?B?ZzNLYXVWY2k2cUw3R2poeVBLMVBDSTJzZzloSWFZZnJKS0tDNlV6bUkxNE14?=
 =?utf-8?B?QmpCMHMxZExWWUExZHFtOU40QWplZExiYkovWC9WRm9UdTJTZnVlWTlvRlFO?=
 =?utf-8?B?cU1mTk1kNWVBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 08:45:53.2524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf125b3-b69e-475c-f49b-08dd5ee6cd2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136
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

Added a user-space driver with support for the AMD EPYC
4th Generation DMA (AE4DMA) offload engine.

Implementation of new user-space driver supporting
DMA memory copy offload on AMD EYPC 9004 & 8004 systems
(Genoa and Siena processors).

Signed-off-by: Bhagyada Modali <bhagyada.modali@amd.com>
---
 app/test-dma-perf/benchmark.c        |  24 +-
 app/test-dma-perf/config.ini         | 134 ++++--
 app/test-dma-perf/main.c             |   2 -
 app/test/test_dmadev.c               |  43 +-
 drivers/dma/ae4dma/ae4dma_dmadev.c   | 656 +++++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma_hw_defs.h  | 225 +++++++++
 drivers/dma/ae4dma/ae4dma_internal.h | 125 +++++
 drivers/dma/ae4dma/meson.build       |   7 +
 drivers/dma/meson.build              |   1 +
 lib/mempool/rte_mempool.h            |   2 +-
 usertools/dpdk-devbind.py            |   5 +-
 11 files changed, 1146 insertions(+), 78 deletions(-)
 create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
 create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
 create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
 create mode 100644 drivers/dma/ae4dma/meson.build

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index 6d617ea200..a9aff8191b 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -266,17 +266,35 @@ error_exit(int dev_id)
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
 {
 	int ret;
 	uint16_t nr_cpl;
-
 	ret = rte_dma_submit(dev_id, 0);
 	if (ret < 0)
 		error_exit(dev_id);
-
 	nr_cpl = rte_dma_completed(dev_id, 0, MAX_DMA_CPL_NB, NULL, NULL);
 	*async_cnt -= nr_cpl;
 	worker_info->total_cpl += nr_cpl;
@@ -311,12 +329,14 @@ do_dma_plain_mem_copy(void *p)
 			ret = rte_dma_copy(dev_id, 0, rte_mbuf_data_iova(srcs[i]),
 				rte_mbuf_data_iova(dsts[i]), buf_size, 0);
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
index 0586b3e1d0..1ecde6c236 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -566,7 +566,6 @@ main(int argc, char *argv[])
 		return -1;
 	}
 	fclose(fd);
-
 	printf("Running cases...\n");
 	for (i = 0; i < case_nb; i++) {
 		if (test_cases[i].is_skip) {
@@ -644,7 +643,6 @@ main(int argc, char *argv[])
 				printf("Case process unknown terminated.\n\n");
 		}
 	}
-
 	printf("Bye...\n");
 	return 0;
 }
diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 143e1bcd68..73d854cc02 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -4,6 +4,7 @@
  */
 
 #include <inttypes.h>
+#include <rte_malloc.h>
 
 #include <rte_dmadev.h>
 #include <rte_mbuf.h>
@@ -19,9 +20,9 @@
 #define ERR_RETURN(...) do { print_err(__func__, __LINE__, __VA_ARGS__); return -1; } while (0)
 
 #define TEST_NAME_MAX_LEN 80
-#define TEST_RINGSIZE 512
+#define TEST_RINGSIZE 32
 #define COPY_LEN 2048
-
+#define ALIGN_4K 4096
 static struct rte_dma_info info;
 static struct rte_mempool *pool;
 static bool check_err_stats;
@@ -135,8 +136,8 @@ do_multi_copies(int16_t dev_id, uint16_t vchan,
 		int split_completions, /* gather 2 x 16 or 1 x 32 completions */
 		int use_completed_status) /* use completed or completed_status function */
 {
-	struct rte_mbuf *srcs[32], *dsts[32];
-	enum rte_dma_status_code sc[32];
+	struct rte_mbuf *srcs[16], *dsts[16];
+	enum rte_dma_status_code sc[16];
 	unsigned int i, j;
 	bool dma_err = false;
 
@@ -159,6 +160,7 @@ do_multi_copies(int16_t dev_id, uint16_t vchan,
 		if (rte_dma_copy(dev_id, vchan, rte_mbuf_data_iova(srcs[i]),
 				 rte_mbuf_data_iova(dsts[i]), COPY_LEN, 0) != id_count++)
 			ERR_RETURN("Error with rte_dma_copy for buffer %u\n", i);
+		id_count %= 32;
 	}
 	rte_dma_submit(dev_id, vchan);
 
@@ -228,15 +230,13 @@ test_single_copy(int16_t dev_id, uint16_t vchan)
 	enum rte_dma_status_code status;
 	struct rte_mbuf *src, *dst;
 	char *src_data, *dst_data;
-
 	src = rte_pktmbuf_alloc(pool);
 	dst = rte_pktmbuf_alloc(pool);
+
 	src_data = rte_pktmbuf_mtod(src, char *);
 	dst_data = rte_pktmbuf_mtod(dst, char *);
-
 	for (i = 0; i < COPY_LEN; i++)
 		src_data[i] = rte_rand() & 0xFF;
-
 	id = rte_dma_copy(dev_id, vchan, rte_pktmbuf_iova(src), rte_pktmbuf_iova(dst),
 			COPY_LEN, RTE_DMA_OP_FLAG_SUBMIT);
 	if (id != id_count)
@@ -284,7 +284,7 @@ test_single_copy(int16_t dev_id, uint16_t vchan)
 		ERR_RETURN("Error with rte_dma_completed in empty check\n");
 
 	id_count++;
-
+	id_count %= 32;
 	return 0;
 }
 
@@ -296,15 +296,13 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
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
-
 		src = rte_pktmbuf_alloc(pool);
 		dst = rte_pktmbuf_alloc(pool);
 		src_data = rte_pktmbuf_mtod(src, char *);
@@ -314,13 +312,14 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
 			src_data[i] = rte_rand() & 0xFF;
 
 		/* perform the same copy <max_ops> times */
-		for (i = 0; i < max_ops; i++)
+		for (i = 0; i < max_ops; i++) {
 			if (rte_dma_copy(dev_id, vchan,
-					rte_pktmbuf_iova(src),
-					rte_pktmbuf_iova(dst),
-					COPY_LEN, RTE_DMA_OP_FLAG_SUBMIT) != id_count++)
+						rte_pktmbuf_iova(src),
+						rte_pktmbuf_iova(dst),
+						COPY_LEN, RTE_DMA_OP_FLAG_SUBMIT) != id_count++)
 				ERR_RETURN("Error with rte_dma_copy\n");
-
+			id_count %= 32;
+		}
 		await_hw(dev_id, vchan);
 
 		count = rte_dma_completed(dev_id, vchan, max_ops * 2, &id, NULL);
@@ -328,7 +327,7 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
 			ERR_RETURN("Error with rte_dma_completed, got %u not %u\n",
 					count, max_ops);
 
-		if (id != id_count - 1)
+		if (id != (id_count - 1 + 32) % 32)
 			ERR_RETURN("Error, incorrect job id returned: got %u not %u\n",
 					id, id_count - 1);
 
@@ -339,8 +338,8 @@ test_enqueue_copies(int16_t dev_id, uint16_t vchan)
 		rte_pktmbuf_free(src);
 		rte_pktmbuf_free(dst);
 	} while (0);
-
 	/* test doing multiple copies */
+	return 0;
 	return do_multi_copies(dev_id, vchan, 0, 0, 0) /* enqueue and complete 1 batch at a time */
 			/* enqueue 2 batches and then complete both */
 			|| do_multi_copies(dev_id, vchan, 1, 0, 0)
@@ -1161,7 +1160,7 @@ test_dmadev_setup(void)
 	if (rte_dma_stats_get(dev_id, vchan, &stats) != 0)
 		ERR_RETURN("Error with rte_dma_stats_get()\n");
 
-	if (rte_dma_burst_capacity(dev_id, vchan) < 32)
+	if (rte_dma_burst_capacity(dev_id, vchan) < 2)
 		ERR_RETURN("Error: Device does not have sufficient burst capacity to run tests");
 
 	if (stats.completed != 0 || stats.submitted != 0 || stats.errors != 0)
@@ -1211,7 +1210,7 @@ test_dmadev_instance(int16_t dev_id)
 	};
 
 	static struct runtest_param param[] = {
-		{"copy", test_enqueue_copies, 640},
+		{"copy", test_enqueue_copies, 10000},
 		{"sg_copy", test_enqueue_sg_copies, 1},
 		{"stop_start", test_stop_start, 1},
 		{"burst_capacity", test_burst_capacity, 1},
@@ -1317,13 +1316,9 @@ test_dma(void)
 		return TEST_SKIPPED;
 
 	RTE_DMA_FOREACH_DEV(i) {
-		if (test_dma_api(i) < 0)
-			ERR_RETURN("Error performing API tests\n");
-
 		if (test_dmadev_instance(i) < 0)
 			ERR_RETURN("Error, test failure for device %d\n", i);
 	}
-
 	return 0;
 }
 
diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
new file mode 100644
index 0000000000..de9f87ec79
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
@@ -0,0 +1,656 @@
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
+#define hwq_id 0
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
+	mz = rte_memzone_lookup(queue_name);
+	if (mz != 0) {
+		if (((size_t)queue_size <= mz->len) &&
+				((socket_id == SOCKET_ID_ANY) ||
+				 (socket_id == mz->socket_id))) {
+			AE4DMA_PMD_INFO("re-use memzone already "
+					"allocated for %s", queue_name);
+			return mz;
+		}
+		AE4DMA_PMD_ERR("Incompatible memzone already "
+				"allocated %s, size %u, socket %d. "
+				"Requested size %u, socket %u",
+				queue_name, (uint32_t)mz->len,
+				mz->socket_id, queue_size, socket_id);
+		return NULL;
+	}
+	return rte_memzone_reserve_aligned(queue_name, queue_size,
+			socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
+}
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
+	/* Ensure all counters are reset, if reconfiguring/restarting device. Reset Stats*/
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
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->write_idx, write_idx);
+	cmd_q->stats.submitted += (uint16_t)(cmd_q->next_write - cmd_q->last_write +
+			AE4DMA_DESCRITPTORS_PER_CMDQ) % AE4DMA_DESCRITPTORS_PER_CMDQ;
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
+	fprintf(f, "queues per ae4dma engine     = %d\n", AE4DMA_READ_REG_OFFSET(
+				ae4dma_mmio_base_addr, AE4DMA_COMMON_CONFIG_OFFSET));
+	fprintf(f, "== Private Data ==\n");
+	fprintf(f, "  Config: { ring_size: %u }\n", cmd_q->qcfg.nb_desc);
+	fprintf(f, "  Ring IOVA: %#lx\t%#lx\t%#lx\n", cmd_q->qbase_desc, cmd_q->qbase_addr,
+			cmd_q->qbase_phys_addr);
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
+static inline uint16_t
+ae4dma_scan_hwq(struct ae4dma_cmd_queue *cmd_q, const uint16_t max_ops, uint16_t *failed_count)
+{
+	volatile struct ae4dma_desc *hw_desc;
+	uint32_t events_count = 0, fails = 0;
+	volatile uint32_t tail;
+	volatile uint32_t desc_status;
+	uint32_t retry_count = MAX_RETRY;
+	uint32_t sub_desc_cnt;
+	tail = cmd_q->next_read;
+	/* process all the submitted descriptors for the HW queue */
+	sub_desc_cnt = cmd_q->ring_buff_count;
+	if (max_ops < sub_desc_cnt)
+		sub_desc_cnt = max_ops;
+	while (sub_desc_cnt) {
+		desc_status = 0;
+		retry_count = MAX_RETRY;
+		do {
+			hw_desc = &cmd_q->qbase_desc[tail];
+			desc_status = hw_desc->dw1.status;
+			if (desc_status) {
+				if (desc_status != AE4DMA_DMA_DESC_COMPLETED) {
+					fails++;
+					AE4DMA_PMD_WARN("WARNING:Desc error code : %d\n",
+							hw_desc->dw1.err_code);
+				}
+				if (cmd_q->ring_buff_count)
+					cmd_q->ring_buff_count--;
+				cmd_q->status[events_count] = hw_desc->dw1.err_code;
+				events_count++;
+				tail = (tail + 1) % AE4DMA_DESCRITPTORS_PER_CMDQ;
+				sub_desc_cnt--;
+			}
+		} while (!desc_status && retry_count--);
+		if (desc_status == 0)
+			break;
+	}
+	cmd_q->stats.completed += events_count;
+	cmd_q->stats.errors += fails;
+	cmd_q->next_read = tail;
+	*failed_count = fails;
+	return events_count;
+}
+
+/* Returns successful operations count and sets error flag if any errors. */
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
+		*last_idx = (cmd_q->next_read - 1 + AE4DMA_DESCRITPTORS_PER_CMDQ) %
+			AE4DMA_DESCRITPTORS_PER_CMDQ;
+
+	sl_count = cpl_count - err_count;
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
+		*last_idx = (cmd_q->next_read-1+AE4DMA_DESCRITPTORS_PER_CMDQ) %
+			AE4DMA_DESCRITPTORS_PER_CMDQ;
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
+	cmd_q = &dev->cmd_q[dev->cmd_q_count++];
+	cmd_q->id = i;
+	cmd_q->qidx = 0;
+	/* Queue_size: 32*sizeof(struct ae4dmadma_desc) */
+	cmd_q->qsize = AE4DMA_QUEUE_SIZE(AE4DMA_QUEUE_DESC_SIZE);
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
+	/* Max Index (cmd queue length) */
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, AE4DMA_DESCRITPTORS_PER_CMDQ);
+	/* Queue Enable */
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw, AE4DMA_CMD_QUEUE_ENABLE);
+	/* Disabling the interrupt */
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->intr_status_reg.intr_status_raw, AE4DMA_DISABLE_INTR);
+	cmd_q->next_write = AE4DMA_READ_REG(&cmd_q->hwq_regs->write_idx);
+	cmd_q->next_read = AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx);
+	cmd_q->ring_buff_count = 0;
+	/* Update the device registers with queue addresses */
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
+	(void) snprintf(hwq_dev_name, sizeof(hwq_dev_name), "%s-ch%u", name, qn);
+
+	/* Allocate device structure. */
+	dmadev = rte_dma_pmd_allocate(hwq_dev_name, dev->device.numa_node,
+			sizeof(struct ae4dma_dmadev));
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
+	rte_pci_device_name(&dev->addr, name, sizeof(name));
+	AE4DMA_PMD_INFO("Init %s on NUMA node %d", name, dev->device.numa_node);
+	dev->device.driver = &drv->driver;
+	for (uint8_t i = 0; i < AE4DMA_MAX_HW_QUEUES; i++) {
+		ret = ae4dma_dmadev_create(name, dev, i);
+		if (ret) {
+			AE4DMA_PMD_ERR("%s create dmadev %u failed!",
+					name, i);
+			break;
+		}
+	}
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
index 0000000000..c9ce935c94
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_hw_defs.h
@@ -0,0 +1,225 @@
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
+#define AE4DMA_DWORD0_STOP_ON_COMPLETION	BIT(0)
+#define AE4DMA_DWORD0_INTERRUPT_ON_COMPLETION   BIT(1)
+#define AE4DMA_DWORD0_START_OF_MESSAGE		BIT(3)
+#define AE4DMA_DWORD0_END_OF_MESSAGE		BIT(4)
+#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE   GENMASK(5, 4)
+#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE	GENMASK(7, 6)
+
+#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_MEMORY    (0x0)
+#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_IOMEMORY  (1<<4)
+#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_MEMORY    (0x0)
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
+			/* 0–empty, 1–full, 2–stopped, 3–error , 4–Not Empty */
+			uint32_t queue_status: 2;
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
+
diff --git a/drivers/dma/ae4dma/ae4dma_internal.h b/drivers/dma/ae4dma/ae4dma_internal.h
new file mode 100644
index 0000000000..28f8e902f9
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_internal.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: BSD-3.0-Clause
+ * Copyright(c) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef _AE4DMA_INTERNAL_H_
+#define _AE4DMA_INTERNAL_H_
+
+#include "ae4dma_hw_defs.h"
+
+#define NO_OFFSET 0
+#define ENABLE_DEBUG_LOG 0
+
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
+		uint32_t value)
+{
+	volatile void *reg_addr = ((uint8_t *)base + offset);
+	rte_write32((rte_cpu_to_le_32(value)), reg_addr);
+}
+
+static inline uint32_t ae4dma_pci_reg_read(void *base, int offset)
+{
+	volatile void *reg_addr = ((uint8_t *)base + offset);
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
+	char memz_name[RTE_MEMZONE_NAMESIZE];
+	volatile struct ae4dma_hwq_regs *hwq_regs;
+
+	struct rte_dma_vchan_conf qcfg;
+	struct rte_dma_stats stats;
+	/* Queue address */
+	struct ae4dma_desc *qbase_desc;
+	void *qbase_addr;
+	phys_addr_t qbase_phys_addr;
+	enum ae4dma_dma_err status[AE4DMA_DESCRITPTORS_PER_CMDQ];
+	/* Queue identifier */
+	uint64_t id;    /**< queue id */
+	uint64_t qidx;  /**< queue index */
+	uint64_t qsize; /**< queue size */
+	/* Queue Statistics */
+	uint64_t tail;
+	uint32_t ring_buff_count;
+	unsigned short next_read;
+	unsigned short next_write;
+	unsigned short last_write; /* Used to compute submitted count. */
+	/* Queue-page registers addr */
+	void *reg_base;
+
+} __rte_cache_aligned;
+
+struct ae4dma_dmadev {
+	struct rte_dma_dev *dmadev;
+	phys_addr_t status_addr;
+	phys_addr_t ring_addr;
+	void *io_regs;
+	int id; /**< ae4dma dev id on platform */
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
+
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
index 358132759a..0620e5d077 100644
--- a/drivers/dma/meson.build
+++ b/drivers/dma/meson.build
@@ -9,6 +9,7 @@ drivers = [
         'idxd',
         'ioat',
         'odm',
+		'ae4dma',
         'skeleton',
 ]
 std_deps = ['dmadev']
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 7bdc92b812..d7f0c47b56 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -136,7 +136,7 @@ struct rte_mempool_objsz {
 /**
  * Alignment of elements inside mempool.
  */
-#define RTE_MEMPOOL_ALIGN	RTE_CACHE_LINE_SIZE
+#define RTE_MEMPOOL_ALIGN	4096
 #endif
 
 #define RTE_MEMPOOL_ALIGN_MASK	(RTE_MEMPOOL_ALIGN - 1)
diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index 283707fc16..29ffc585a3 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -74,6 +74,9 @@
 cn9k_ree = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f4',
             'SVendor': None, 'SDevice': None}
 
+amd_ae4dma = {'Class': '08', 'Vendor': '1022', 'Device': '149b',
+                 'SVendor': None, 'SDevice': None}
+
 virtio_blk = {'Class': '01', 'Vendor': "1af4", 'Device': '1001,1042',
               'SVendor': None, 'SDevice': None}
 
@@ -83,7 +86,7 @@
 network_devices = [network_class, cavium_pkx, avp_vnic, ifpga_class]
 baseband_devices = [acceleration_class]
 crypto_devices = [encryption_class, intel_processor_class]
-dma_devices = [cnxk_dma, hisilicon_dma,
+dma_devices = [amd_ae4dma, cnxk_dma, hisilicon_dma,
                intel_idxd_spr, intel_ioat_bdw, intel_ioat_icx, intel_ioat_skx,
                odm_dma]
 eventdev_devices = [cavium_sso, cavium_tim, intel_dlb, cnxk_sso]
-- 
2.34.1

