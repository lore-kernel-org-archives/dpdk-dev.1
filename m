Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC2EC71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:29:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BB3C40658;
	Mon, 16 Jun 2025 09:29:53 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by mails.dpdk.org (Postfix) with ESMTP id 3E16340658
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:29:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbFPPyxNIp3v829cQX6hKgzeFrWrCqnQeQpS6HTBDLuteCKZEBgoFvBqrOd1aRr9Wp8oCudjA2p0p0+IFB/oxaze8DqAW+q650L2PWxcHIUAVRL/pqFOOM8oHSqjEQD43OZWAeGmvtxFsRhJdMCyh2ncikzg6+l+wlBy2ef9ucTSs/m6lgQ/MCl4zDyhUNIcUqrUV+zUOFbdtZ5bpj5oMB6ni57cFrUtW/Ps/LLXKzK0qxTFcTEj5vNQrUgBn3OcAgh7FVYztiIscNLhoIS7XDQJK66q4EyentPfLjMQT1KcHhja1CAG1MpqRANoXDfxvUNxSbkL5jLfntdTQTJh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LUGthiruU0PLfpwdW2YyVu6hbrplsu44vVrJyH+t2c=;
 b=qwjqJLJIvbwItRPpapvzsPcI9lUFr/94mJbjUDJZ+H2/fj+lrl6LTZtmq6cP7WQxCyMSkvz1bwAs2jpVws5fOwPSbSflfodloFFy9IxcWzJMbLlhZ0wzV934IPD+Y9jhPzX70oG9FjFjjGLiXCReEPpnlXFPZbqIG7rTbRVe+/xrlcpf5JhCvBf/Q8s5389g/tuF/SNnkMZ8ALGNbiVHjp4aYKTEchdqhanX80oIuvox2s6ax55vIDls/njjK2tI0lRe/3M2Gt60FtzJ8AVvt4Yyw9CFpU0IHumSOrDbavOqnhNSQc7okbKkMsaWsb/AEfhhyZVs1Lj3ZfaysgMO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LUGthiruU0PLfpwdW2YyVu6hbrplsu44vVrJyH+t2c=;
 b=YkUZADWo+CM1v/fYwuu1g87XtrlBTNcGSdD/p7Y7k4XoVbnRV0eEmM/n/EAlRl1ze8sCM+NwJ+DGleaSCl/Q0jFHv3TtVe5GO13OgpWsw2tQHaMSLxNZmeT9gN+bqv6ijm+b7bpDv0qWp/SD+1pLtYAgVLeJbr3X8gjfBVxdWwl0ITZYm+5thgzJ5o0zHQ/trn/4Q6gHEmLc2VkMY+mlmkE6AiI8YnNAw7X9QNszpD7Vptt21cPy8wu+00TGITZt8Kzspx9lHZl7JQDJsm79t/IZPWYRAoG08MZ06kiVLz0lO/T7m8aAkGwD8BKtfG+8+i2fvN/YplngpMMyKwBO3A==
Received: from BN9PR03CA0887.namprd03.prod.outlook.com (2603:10b6:408:13c::22)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 07:29:34 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::f3) by BN9PR03CA0887.outlook.office365.com
 (2603:10b6:408:13c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 07:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 07:29:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 00:29:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 00:29:19 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 00:29:17 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, 
 Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, =?UTF-8?q?Morten=20Br=C3=B8rup?=
 <mb@smartsharesystems.com>
Subject: [RFC PATCH 1/5] mempool: record mempool objects operations history
Date: Mon, 16 Jun 2025 10:29:06 +0300
Message-ID: <20250616072910.113042-2-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616072910.113042-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 979fdff2-c114-4855-d5c3-08ddaca78a56
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jTO2TtlCz3wwE315UFnad9vgC75eng9xqesghB93h4mGREo3iAJX37jZKlMJ?=
 =?us-ascii?Q?V7xCgxCuCLnKL910otjOcPxezxrpl6hqUz7eGBq7vYQ9EgfcUUutA2a/tLOG?=
 =?us-ascii?Q?2SlERM5VUPkKjESMg820WeaGf95sdBwyNR/RrBl/2GAGXQqtt/8Lat5p4p/V?=
 =?us-ascii?Q?MkVc1n2+eQel6SivRIoH5dYa4NgGLUEL8jYulWhPL31mGAjrlf+lkQwXUJ9e?=
 =?us-ascii?Q?Es9H81Pid4q2MQQqoDeOyVUaJ4A2xgmPnTHoU6AOTMnIpy3+YYtssNj6enPS?=
 =?us-ascii?Q?LCNP1S8vn+Oni4H8CCk8tLEFnzyePVPogngS19jd8dOY8pJuG1XJ1IWcgjtN?=
 =?us-ascii?Q?uOk0XIIZzk2xABD7HYaYwdstO8Q3KEqhxcLYDNB30bMXjsOUTROPW1hP3yJL?=
 =?us-ascii?Q?9PrJ+3FuXSLk1+wBT9satAT1krqURIWxQ3aCn5UZufFFXhlF8beAusQu51o1?=
 =?us-ascii?Q?/N1qwougf11dwt/3x/mCG5OAAd5CZQFa8CxlIz2/K7VAJ0tk02ePVmiUPVcs?=
 =?us-ascii?Q?plWVbYIjjcoYg9IiP0Et4m+ZAetnWJZxHd7Bab+3CuKwFCHV6yg2pGqYrlZV?=
 =?us-ascii?Q?PpQB+ICNoBnlkBrendNmqsSmyVuhoaQ466KECxSBB+tgLCD55B08TIAkn0B2?=
 =?us-ascii?Q?O0RdkUKs29wmlrweNBP3/IPlTjicQc2NbXAzQskpw+C45TG8Nlip/Ix5bh3e?=
 =?us-ascii?Q?f71rJ/wshU79s0Ri23/y9qs7E7CL+LxySgW+CQM2aGbXRVrvfMwi/X/WYQBi?=
 =?us-ascii?Q?noX6aQPs2kbhjsZu3JDBx0UdDo1WK0mMQ7/yLyci8qxH1GEKRpFA0yXZohiH?=
 =?us-ascii?Q?ad8EQdl0iFWot1UBqxYeX3ZXdACzSJXfoH4JzSRg1Tj62IazMUrSqr+ZbvGv?=
 =?us-ascii?Q?YTdfJs2SVMhkhs1gbL+QeEcwpe6eamLCztVNRrhg76LbpAX2jzMIF7TugSKC?=
 =?us-ascii?Q?W8J9Cy8WkTU3ksE9TfAwL6U6gY1oviBS62GTyHZ5/OF5zt3vhReeX2i9fVkv?=
 =?us-ascii?Q?Nh5MvvHmya6tKVMWphZGfnZ/vfAv+z/0iFY45o6hEiFKoqS4R/NPyNy5oOqZ?=
 =?us-ascii?Q?ErNVkMjNKIOSkJEakiAcIGntO1vFXKiLIaZr8e1FIqCAhiw2Jmzqbh0Z7VlH?=
 =?us-ascii?Q?yS9PdfZ0wcp5hOFUKrs7tYlpMZHriCWsNCXLXeQyRhAKV0/I3MyBs1UwOJL8?=
 =?us-ascii?Q?2H273tAw+0mYKw7Q/agVkt17t4gpzmOOi+gm20AQPGDpQiwoNMjyNmNQdfXi?=
 =?us-ascii?Q?BheIu5cDax8c+MJbEn2bAI8P7mgtvju31oPaB33i9q9W3PcIALgUhK+be8FV?=
 =?us-ascii?Q?75SI0SsvS43m2bb7nDCRtoMPypvj5LS08mTkzYtFE0OgA4Csi687ZtLOetA6?=
 =?us-ascii?Q?aSIpkoL3Fiuqr+w//QEXvUfFwDuDHyIwP7+rcjh2RiETawlxmSb5jRo9C1g/?=
 =?us-ascii?Q?6Yo2InbSKLsq6W+8h/ckw2VYCqAlO39Qk0bhb7ZqqwTPyXUHZ3wcM4Tpp4Y6?=
 =?us-ascii?Q?2FGDIknWnxHqd0D236KqZ+f13daKh/txSFjD?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:29:33.4997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 979fdff2-c114-4855-d5c3-08ddaca78a56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
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

This feature is designed to monitor the lifecycle of
mempool objects as they move between the application
and the PMD.

It will allow us to track the operations and transitions
of each mempool object throughout the system, helping in
debugging and understanding objects flow.

added a bitmap to the mempool object header that records
the most recent operations.
Each operation is represented by a 4-bit value, and for each mempool
object the history field stores 16 steps.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 lib/ethdev/rte_ethdev.h   |  14 +++++
 lib/mempool/rte_mempool.c | 111 ++++++++++++++++++++++++++++++++++++++
 lib/mempool/rte_mempool.h | 106 ++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index f9fb6ae549..77d15f1bcb 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -167,6 +167,7 @@
 #include <rte_common.h>
 #include <rte_config.h>
 #include <rte_power_intrinsics.h>
+#include <rte_mempool.h>
 
 #include "rte_ethdev_trace_fp.h"
 #include "rte_dev_info.h"
@@ -6334,6 +6335,8 @@ rte_eth_rx_burst(uint16_t port_id, uint16_t queue_id,
 
 	nb_rx = p->rx_pkt_burst(qd, rx_pkts, nb_pkts);
 
+	rte_mempool_history_bulk((void **)rx_pkts, nb_rx, RTE_MEMPOOL_APP_RX);
+
 #ifdef RTE_ETHDEV_RXTX_CALLBACKS
 	{
 		void *cb;
@@ -6692,8 +6695,19 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
+#if RTE_MEMPOOL_DEBUG_OBJECTS_HISTORY
+	uint16_t requested_pkts = nb_pkts;
+	rte_mempool_history_bulk((void **)tx_pkts, nb_pkts, RTE_MEMPOOL_PMD_TX);
+#endif
+
 	nb_pkts = p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
 
+#if RTE_MEMPOOL_DEBUG_OBJECTS_HISTORY
+	if (requested_pkts > nb_pkts)
+		rte_mempool_history_bulk((void **)tx_pkts + nb_pkts,
+				    requested_pkts - nb_pkts, RTE_MEMPOOL_BUSY_TX);
+#endif
+
 	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts, nb_pkts);
 	return nb_pkts;
 }
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 1021ede0c2..1d84c72ba0 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -32,6 +32,7 @@
 #include "mempool_trace.h"
 #include "rte_mempool.h"
 
+
 RTE_EXPORT_SYMBOL(rte_mempool_logtype)
 RTE_LOG_REGISTER_DEFAULT(rte_mempool_logtype, INFO);
 
@@ -1632,3 +1633,113 @@ RTE_INIT(mempool_init_telemetry)
 	rte_telemetry_register_cmd("/mempool/info", mempool_handle_info,
 		"Returns mempool info. Parameters: pool_name");
 }
+
+#if RTE_MEMPOOL_DEBUG_OBJECTS_HISTORY
+static void
+rte_mempool_get_object_history_stat(FILE *f, struct rte_mempool *mp)
+{
+	struct rte_mempool_objhdr *hdr;
+
+	uint64_t n_never = 0;   /* never been allocated. */
+	uint64_t n_free = 0;    /* returned to the pool. */
+	uint64_t n_alloc = 0;   /* allocated from the pool. */
+	uint64_t n_ref = 0;     /* freed by pmd, not returned to the pool. */
+	uint64_t n_pmd_tx = 0;  /* owned by PMD Tx. */
+	uint64_t n_pmd_rx = 0;  /* owned by PMD Rx. */
+	uint64_t n_app_rx = 0;  /* owned by Application on Rx. */
+	uint64_t n_app_alloc = 0; /* owned by Application on Alloc. */
+	uint64_t n_busy_tx = 0; /* owned by Application on Busy Tx. */
+	uint64_t n_total = 0;   /* Total amount. */
+
+	if (f == NULL)
+		return;
+
+	STAILQ_FOREACH(hdr, &mp->elt_list, next) {
+		uint64_t hs = hdr->history;
+
+		rte_rmb();
+		n_total++;
+		if (hs == 0) {
+			n_never++;
+			continue;
+		}
+		switch (hs & RTE_MEMPOOL_HISTORY_MASK) {
+		case RTE_MEMPOOL_FREE:
+			n_free++;
+			break;
+		case RTE_MEMPOOL_PMD_FREE:
+			n_alloc++;
+			n_ref++;
+			break;
+		case RTE_MEMPOOL_PMD_TX:
+			n_alloc++;
+			n_pmd_tx++;
+			break;
+		case RTE_MEMPOOL_APP_RX:
+			n_alloc++;
+			n_app_rx++;
+			break;
+		case RTE_MEMPOOL_PMD_ALLOC:
+			n_alloc++;
+			n_pmd_rx++;
+			break;
+		case RTE_MEMPOOL_ALLOC:
+			n_alloc++;
+			n_app_alloc++;
+			break;
+		case RTE_MEMPOOL_BUSY_TX:
+			n_alloc++;
+			n_busy_tx++;
+			break;
+		default:
+			break;
+		}
+		fprintf(f, "%016" PRIX64 "\n", hs);
+	}
+
+	fprintf(f, "\n"
+		"Populated:       %u\n"
+		"Never allocated: %" PRIu64 "\n"
+		"Free:            %" PRIu64 "\n"
+		"Allocated:       %" PRIu64 "\n"
+		"Referenced free: %" PRIu64 "\n"
+		"PMD owned Tx:    %" PRIu64 "\n"
+		"PMD owned Rx:    %" PRIu64 "\n"
+		"App owned alloc: %" PRIu64 "\n"
+		"App owned Rx:    %" PRIu64 "\n"
+		"App owned busy:  %" PRIu64 "\n"
+		"Counted total:   %" PRIu64 "\n",
+		mp->populated_size, n_never, n_free + n_never, n_alloc,
+		n_ref, n_pmd_tx, n_pmd_rx, n_app_alloc, n_app_rx,
+		n_busy_tx, n_total);
+}
+#endif
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mempool_objects_dump, 24.07)
+void
+rte_mempool_objects_dump(__rte_unused FILE *f)
+{
+	#if RTE_MEMPOOL_DEBUG_OBJECTS_HISTORY
+	if (f == NULL) {
+		RTE_MEMPOOL_LOG(ERR, "Invalid file pointer");
+		return;
+	}
+
+	struct rte_mempool *mp = NULL;
+	struct rte_tailq_entry *te;
+	struct rte_mempool_list *mempool_list;
+
+	mempool_list = RTE_TAILQ_CAST(rte_mempool_tailq.head, rte_mempool_list);
+
+	rte_mcfg_mempool_read_lock();
+
+	TAILQ_FOREACH(te, mempool_list, next) {
+		mp = (struct rte_mempool *) te->data;
+		rte_mempool_get_object_history_stat(f, mp);
+	}
+
+	rte_mcfg_mempool_read_unlock();
+#else
+	RTE_MEMPOOL_LOG(INFO, "Mempool history recorder is not supported");
+#endif
+}
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index aedc100964..4c0ea6d0a7 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -60,6 +60,26 @@ extern "C" {
 #define RTE_MEMPOOL_HEADER_COOKIE2  0xf2eef2eedadd2e55ULL /**< Header cookie. */
 #define RTE_MEMPOOL_TRAILER_COOKIE  0xadd2e55badbadbadULL /**< Trailer cookie.*/
 
+/**
+ * Mempool trace operation bits and masks.
+ * Used to record the lifecycle of mempool objects through the system.
+ */
+#define RTE_MEMPOOL_HISTORY_BITS          4 /*Number of bits for history operation*/
+#define RTE_MEMPOOL_HISTORY_MASK          ((1ULL << RTE_MEMPOOL_HISTORY_BITS) - 1)
+
+/* History operation types */
+enum rte_mempool_history_op {
+	RTE_MEMPOOL_NEVER = 0,     /* Initial state - never allocated */
+	RTE_MEMPOOL_FREE = 1,      /* Freed back to mempool */
+	RTE_MEMPOOL_PMD_FREE = 2,  /* Freed by PMD back to mempool */
+	RTE_MEMPOOL_PMD_TX = 3,    /* Sent to PMD for Tx */
+	RTE_MEMPOOL_APP_RX = 4,    /* Returned to application on Rx */
+	RTE_MEMPOOL_PMD_ALLOC = 5, /* Allocated by PMD for Rx */
+	RTE_MEMPOOL_ALLOC = 6,     /* Allocated by application */
+	RTE_MEMPOOL_BUSY_TX = 7,   /* Returned to app due to Tx busy */
+	RTE_MEMPOOL_MAX = 8        /* Maximum trace operation value */
+};
+
 #ifdef RTE_LIBRTE_MEMPOOL_STATS
 /**
  * A structure that stores the mempool statistics (per-lcore).
@@ -157,6 +177,9 @@ struct rte_mempool_objhdr {
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
 	uint64_t cookie;                 /**< Debug cookie. */
 #endif
+#if RTE_MEMPOOL_DEBUG_OBJECTS_HISTORY
+	uint64_t history;                 /**< Debug object history. */
+#endif
 };
 
 /**
@@ -457,6 +480,83 @@ void rte_mempool_contig_blocks_check_cookies(const struct rte_mempool *mp,
 
 #define RTE_MEMPOOL_OPS_NAMESIZE 32 /**< Max length of ops struct name. */
 
+
+#if RTE_MEMPOOL_DEBUG_OBJECTS_HISTORY
+/**
+ * Get the history value from a mempool object header.
+ *
+ * @param obj
+ *   Pointer to the mempool object.
+ * @return
+ *   The history value from the object header.
+ */
+static inline uint64_t rte_mempool_history_get(void *obj)
+{
+	struct rte_mempool_objhdr *hdr;
+
+	if (unlikely(obj == NULL))
+		return 0;
+
+	hdr = rte_mempool_get_header(obj);
+	return hdr->history;
+}
+
+/**
+ * Mark a mempool object with the history value.
+ *
+ * @param obj
+ *   Pointer to the mempool object.
+ * @param mark
+ *   The history mark value to add.
+ */
+static inline void rte_mempool_history_mark(void *obj, uint32_t mark)
+{
+	struct rte_mempool_objhdr *hdr;
+
+	if (unlikely(obj == NULL))
+		return;
+
+	hdr = rte_mempool_get_header(obj);
+	hdr->history = (hdr->history << RTE_MEMPOOL_HISTORY_BITS) | mark;
+}
+
+/**
+ * Mark multiple mempool objects with the history value.
+ *
+ * @param b
+ *   Array of pointers to mempool objects.
+ * @param n
+ *   Number of objects to mark.
+ * @param mark
+ *   The history mark value to add to each object.
+ */
+static inline void rte_mempool_history_bulk(void * const *b, uint32_t n, uint32_t mark)
+{
+	if (unlikely(b == NULL))
+		return;
+
+	while (n--)
+		rte_mempool_history_mark(*b++, mark);
+}
+#else
+static inline uint64_t rte_mempool_history_get(void *obj)
+{
+	RTE_SET_USED(obj);
+	return 0;
+}
+static inline void rte_mempool_history_mark(void *obj, uint32_t mark)
+{
+	RTE_SET_USED(obj);
+	RTE_SET_USED(mark);
+}
+static inline void rte_mempool_history_bulk(void * const *b, uint32_t n, uint32_t mark)
+{
+	RTE_SET_USED(b);
+	RTE_SET_USED(n);
+	RTE_SET_USED(mark);
+}
+#endif
+
 /**
  * Prototype for implementation specific data provisioning function.
  *
@@ -1395,6 +1495,7 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
 	/* Increment stats now, adding in mempool always succeeds. */
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_objs, n);
+	rte_mempool_history_bulk(obj_table, n, RTE_MEMPOOL_FREE);
 
 	__rte_assume(cache->flushthresh <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
 	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
@@ -1661,6 +1762,7 @@ rte_mempool_generic_get(struct rte_mempool *mp, void **obj_table,
 	ret = rte_mempool_do_generic_get(mp, obj_table, n, cache);
 	if (likely(ret == 0))
 		RTE_MEMPOOL_CHECK_COOKIES(mp, obj_table, n, 1);
+	rte_mempool_history_bulk(obj_table, n, RTE_MEMPOOL_ALLOC);
 	rte_mempool_trace_generic_get(mp, obj_table, n, cache);
 	return ret;
 }
@@ -1876,6 +1978,10 @@ static inline void *rte_mempool_get_priv(struct rte_mempool *mp)
 		RTE_MEMPOOL_HEADER_SIZE(mp, mp->cache_size);
 }
 
+__rte_experimental
+void
+rte_mempool_objects_dump(FILE *f);
+
 /**
  * Dump the status of all mempools on the console
  *
-- 
2.34.1

