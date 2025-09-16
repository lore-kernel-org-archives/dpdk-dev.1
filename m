Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B853CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:12:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6934F40674;
	Tue, 16 Sep 2025 17:12:49 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by mails.dpdk.org (Postfix) with ESMTP id E605F4066E
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:12:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uifdYVOTYHvrj2IsCCqj1amTJgT2dobLBmO6LIsa9MhSsisrfFaT9KCeB8bhVexOpNi6YjlUv7VG8ipEEKhntUWQUePLBNr0U+MlhKuqqXWp054KKLqUiOf7r3EJ6G/8Xwoy/IIXQJ/FFvWBTWbQfwUmuPZKzlVsktRagO247Ak/+9IeG42JXZV6vUDfxw444JQPIhA230UrZwawlcAwoos13JuWY4v5LQy7e/pLMqx1tmHzxM67ALyBr3yHQ7urcdlKsB5c7XVTHYbPDJkj+Gmc/Sclpz+LD5FW6k35Sb+6ZyW3D4qpxezRv8N1SNBabdSLFo2Qb+3E519tk6/wuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuyjluf/DTtBJvimHusnEAN7VNJf6iH3XKeWL/01K5Y=;
 b=gegtmLkexZIFZUIgP99QI2z///oVFHsdnwGBGJdVRWr9yzOxAETpm5C9DKk31UsKnX3aZf3HtpJURRTsGPUaCB5CaofSYChhY4Kg0IdWEaxLMrIemQqA7IPqSygw5gB8vAznSHlgDEQxJhXuHeAPY8wUhD6t8U0rRdmtTOQB8Y2eH+f+oxcXakSJgbQeNnKcTHePvwE+mJdbcuO3ZYyU3mhFbsmfFhtx3kAYknI5g7k99q28MP89zP04UnE0FtnVTiQsP1VpESdKyZSrBed6mwvZmUpu6QiJHISM5lqCvEpKkORRWIkl5g3f7xYUiCsoT0A7aMF4k4QDxb0Gw9eQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuyjluf/DTtBJvimHusnEAN7VNJf6iH3XKeWL/01K5Y=;
 b=cbMhO7qlGb05Pa173Pvwv/HfcJp+XbXr9JbStLp1MCKHABaenvnMKOB3ECMcksLt9PfmBekA780lUxOM09alCn3tL7//RWIVnNDoIudJy5JvryCLgL9QIxEBnSfGzWoCdnSWj3W6kBOqmWr8tZUPnhIdhMfFBE1FeRnubtp01EaTQnRX0akzYIZCo0eG1Ke7XirLcsjElPkqmnMpPzabbY9fiihAPvvj/EBfDmFvYRhfBYJCoAQD5gnHYVz7yxw9DyV3xGuAHUlJaIxz3iteObTfrgJznGd96/g5Wjz6SEpkFzhuhOywMJrq/8u1uwAPUV2sQGLoSxJTQvjbsgaCbw==
Received: from CH0PR03CA0266.namprd03.prod.outlook.com (2603:10b6:610:e5::31)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 15:12:43 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::5c) by CH0PR03CA0266.outlook.office365.com
 (2603:10b6:610:e5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 15:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 15:12:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 08:12:25 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 08:12:25 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 16 Sep 2025 08:12:20 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <mb@smartsharesystems.com>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, <ajit.khaparde@broadcom.com>,
 <jerinj@marvell.com>, <konstantin.v.ananyev@yandex.ru>,
 <david.marchand@redhat.com>, <maxime.coquelin@redhat.com>,
 <gakhil@marvell.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>, "Shani
 Peretz" <shperetz@nvidia.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 1/4] mbuf: record mbuf operations history
Date: Tue, 16 Sep 2025 18:12:04 +0300
Message-ID: <20250916151207.556618-2-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916151207.556618-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250916151207.556618-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: cbdbd607-0de8-4f21-25a8-08ddf5337c29
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1GJ8kn/K0p29sdt5ZYsAqqvylKikCm4/GlXGV6gmJt8Lc1jKRFjA7Yi7pIU2?=
 =?us-ascii?Q?aZkU4WeVy5YpjopHA5SGSLoxWtxnezqHHPR13+3Q9nD6EUozzl/7QRm8wHA7?=
 =?us-ascii?Q?kMpbnRMhdSRC7fPAbb9XSpaaMr/dcsm7ublp1g5l5GPw6sujsCw/EWDfvgyl?=
 =?us-ascii?Q?whWvpfRmW/wmrbEQkx6JgteOay91gMG+I98A9V7TvWmurmu+DbiPLPUkDkeV?=
 =?us-ascii?Q?nXHR5IntNlBA3QDXpqtMJ0l6kfp8xSl+X3Tl8DFAHjIKUIqNk1gXJeIBLfMp?=
 =?us-ascii?Q?fvW3ypq1A4VgxuXkvoB6nMCnkq2p/Uy8Dee1r6qNKcFosSk3K7MQj99BlS15?=
 =?us-ascii?Q?3gIsWT2iD4lqWbebEhzsL+XGrexrJZAC0xnLUiFuj6PEGQLPoCyph9thVUzF?=
 =?us-ascii?Q?OoG2uZU2dtR00Px4d57jSzTaGZFC1/YhxmsovMtpDn+if5a0WoE5qQSqm8I9?=
 =?us-ascii?Q?sN+g8LRmQMVgWAS/EW2ukMz0etL43jWXeliIdc65e8GnNY1oeDN2/q2v4U6B?=
 =?us-ascii?Q?X8/2y3tmCsBP2Ip4Tmqr5Z/vFScHqE5S5i71Wt0i8m63D37JBh+H4wN7mURm?=
 =?us-ascii?Q?iwaGIx6iNTv8RsH7e6+94HHQXwRBlYSkVAt0/xglScWDtnTPvTtWaNqWQX4B?=
 =?us-ascii?Q?Xqc8rM5nucreB7MrVAKt3Lzf0OlH/XruNboVjl7eBnZNNXVgCwvfpUMBmmIB?=
 =?us-ascii?Q?8rDshlMLKSTaBgnUU0NbeunYkT3DTEqZ9jWniI0QaDW4SRHb6L06kAobnFtU?=
 =?us-ascii?Q?VVQqAbnyXI02S9C2JqSIQtsUD/M2g8+tEIkRHFBHGD0B9F7WmA0mdxjtE93T?=
 =?us-ascii?Q?IJoHhRsme3DPaLD7QWqRl7Xo3U/86Q/IrnWoUcbZJw7s/bw4Gr5Nn4Kx/oH8?=
 =?us-ascii?Q?LKFkBS8Rg/MPOP3CTum76SoNOYk1+K7Bc803zpMRwbOC45MLnyGSvM+VUg7G?=
 =?us-ascii?Q?bvDWAa0mCSeS79PdgjkhnYUplo/PDWzi0STE9vwDXV36fWYhDWViUzMJJn+b?=
 =?us-ascii?Q?Doh+PNRYvO0QJ4qWWdYGYqnrXDiis6MKGPu5H9VBRNgzwIxtJ9ZqOeMQEYkv?=
 =?us-ascii?Q?HBG7hvTjgItGDoMu8yU38y3CCtCM3fZST67KZdEg18rcI2tIe4ntqjXZzB88?=
 =?us-ascii?Q?dqgs2vqEah/kQ92Hf5Jz0fhIjR8LnG7e9qoS9kDjKe3OmQs3y2zr9V4ynCm6?=
 =?us-ascii?Q?4YRXz5hShPA2wgucN+YkbJEL1bdRAH31ZlMxn0MWmrK7pqxBrJbp2/T6ZyQT?=
 =?us-ascii?Q?WXitLsmaBTnBc1icHgW/6hvBTLyoRsMkGsoeDObkT29H54xDHCYN1YOJ4Nbz?=
 =?us-ascii?Q?ILgMZaOiY5d/4QkzSvSk49is2MVTKNgmWIH8TaCmu6pBsZ9B4m23FAUIboX4?=
 =?us-ascii?Q?KjbQjRawd1w2K42c7475wrv8iW4LmUZdJoDCrN6pmVVsOBX2a2B1uQBC3xWO?=
 =?us-ascii?Q?Gchd/SzSvbdFHeZx5REoGqs2Ha5U8AOl10qVbsx4krl23fWIWvMsSryHEaxn?=
 =?us-ascii?Q?HVZvCdil5xMi5Y61v/SunoEDQgkAoux58rts?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:12:43.0057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdbd607-0de8-4f21-25a8-08ddf5337c29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
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

This feature is designed to monitor the lifecycle of mbufs
as they move between the applicationand the PMD.

It will allow us to track the operations and transitions
of each mbuf  throughout the system, helping in debugging
and understanding objects flow.

The implementation uses a dynamic field to store a 64-bit
history value in each mbuf. Each operation is represented
by a 4-bit value, allowing up to 16 operations to be tracked
per mbuf. The dynamic field is automatically initialized
when the first mbuf pool is created.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 config/meson.build          |   1 +
 lib/ethdev/rte_ethdev.h     |  15 +++
 lib/mbuf/meson.build        |   2 +
 lib/mbuf/rte_mbuf.c         |  10 +-
 lib/mbuf/rte_mbuf.h         |  23 ++++-
 lib/mbuf/rte_mbuf_dyn.h     |   7 ++
 lib/mbuf/rte_mbuf_history.c | 181 ++++++++++++++++++++++++++++++++++++
 lib/mbuf/rte_mbuf_history.h | 154 ++++++++++++++++++++++++++++++
 meson_options.txt           |   2 +
 9 files changed, 392 insertions(+), 3 deletions(-)
 create mode 100644 lib/mbuf/rte_mbuf_history.c
 create mode 100644 lib/mbuf/rte_mbuf_history.h

diff --git a/config/meson.build b/config/meson.build
index 55497f0bf5..d1f21f3115 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -379,6 +379,7 @@ if get_option('mbuf_refcnt_atomic')
     dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)
 endif
 dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))
+dpdk_conf.set10('RTE_MBUF_HISTORY_DEBUG', get_option('enable_mbuf_history'))
 
 compile_time_cpuflags = []
 subdir(arch_subdir)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index d23c143eed..d0f6cd2582 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6336,6 +6336,10 @@ rte_eth_rx_burst(uint16_t port_id, uint16_t queue_id,
 
 	nb_rx = p->rx_pkt_burst(qd, rx_pkts, nb_pkts);
 
+#if RTE_MBUF_HISTORY_DEBUG
+	rte_mbuf_history_bulk(rx_pkts, nb_rx, RTE_MBUF_APP_RX);
+#endif
+
 #ifdef RTE_ETHDEV_RXTX_CALLBACKS
 	{
 		void *cb;
@@ -6688,8 +6692,19 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
+#if RTE_MBUF_HISTORY_DEBUG
+	uint16_t requested_pkts = nb_pkts;
+	rte_mbuf_history_bulk(tx_pkts, nb_pkts, RTE_MBUF_PMD_TX);
+#endif
+
 	nb_pkts = p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
 
+#if RTE_MBUF_HISTORY_DEBUG
+	if (requested_pkts > nb_pkts)
+		rte_mbuf_history_bulk(tx_pkts + nb_pkts,
+				     requested_pkts - nb_pkts, RTE_MBUF_BUSY_TX);
+#endif
+
 	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts, nb_pkts);
 	return nb_pkts;
 }
diff --git a/lib/mbuf/meson.build b/lib/mbuf/meson.build
index 0435c5e628..2c840ee2f2 100644
--- a/lib/mbuf/meson.build
+++ b/lib/mbuf/meson.build
@@ -6,6 +6,7 @@ sources = files(
         'rte_mbuf_ptype.c',
         'rte_mbuf_pool_ops.c',
         'rte_mbuf_dyn.c',
+        'rte_mbuf_history.c',
 )
 headers = files(
         'rte_mbuf.h',
@@ -13,5 +14,6 @@ headers = files(
         'rte_mbuf_ptype.h',
         'rte_mbuf_pool_ops.h',
         'rte_mbuf_dyn.h',
+        'rte_mbuf_history.h',
 )
 deps += ['mempool']
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 9e7731a8a2..362dd252bc 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -281,6 +281,10 @@ rte_pktmbuf_pool_create(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size, uint16_t data_room_size,
 	int socket_id)
 {
+#if RTE_MBUF_HISTORY_DEBUG
+		if (rte_mbuf_history_init() < 0)
+			RTE_LOG(ERR, MBUF, "Failed to enable mbuf history\n");
+#endif
 	return rte_pktmbuf_pool_create_by_ops(name, n, cache_size, priv_size,
 			data_room_size, socket_id, NULL);
 }
@@ -516,8 +520,12 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
 		} while (m != NULL);
 	}
 
-	if (nb_pending > 0)
+	if (nb_pending > 0) {
+#if RTE_MBUF_HISTORY_DEBUG
+		rte_mbuf_history_bulk(pending, nb_pending, RTE_MBUF_FREE);
+#endif
 		rte_mempool_put_bulk(pending[0]->pool, (void **)pending, nb_pending);
+	}
 }
 
 /* Creates a shallow copy of mbuf */
diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 06ab7502a5..8126f09de4 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -40,6 +40,7 @@
 #include <rte_branch_prediction.h>
 #include <rte_mbuf_ptype.h>
 #include <rte_mbuf_core.h>
+#include "rte_mbuf_history.h"
 
 #ifdef __cplusplus
 extern "C" {
@@ -607,6 +608,9 @@ static inline struct rte_mbuf *rte_mbuf_raw_alloc(struct rte_mempool *mp)
 	if (rte_mempool_get(mp, &ret.ptr) < 0)
 		return NULL;
 	__rte_mbuf_raw_sanity_check(ret.m);
+#if RTE_MBUF_HISTORY_DEBUG
+	rte_mbuf_history_mark(ret.m, RTE_MBUF_ALLOC);
+#endif
 	return ret.m;
 }
 
@@ -642,9 +646,14 @@ static __rte_always_inline int
 rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigned int count)
 {
 	int rc = rte_mempool_get_bulk(mp, (void **)mbufs, count);
-	if (likely(rc == 0))
-		for (unsigned int idx = 0; idx < count; idx++)
+	if (likely(rc == 0)) {
+		for (unsigned int idx = 0; idx < count; idx++) {
 			__rte_mbuf_raw_sanity_check(mbufs[idx]);
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_mark(mbufs[idx], RTE_MBUF_ALLOC);
+#endif
+		}
+	}
 	return rc;
 }
 
@@ -667,6 +676,9 @@ rte_mbuf_raw_free(struct rte_mbuf *m)
 {
 	__rte_mbuf_raw_sanity_check(m);
 	rte_mempool_put(m->pool, m);
+#if RTE_MBUF_HISTORY_DEBUG
+	rte_mbuf_history_mark(m, RTE_MBUF_FREE);
+#endif
 }
 
 /**
@@ -701,6 +713,9 @@ rte_mbuf_raw_free_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigned
 		RTE_ASSERT(m != NULL);
 		RTE_ASSERT(m->pool == mp);
 		__rte_mbuf_raw_sanity_check(m);
+#if RTE_MBUF_HISTORY_DEBUG
+		rte_mbuf_history_mark(mbufs[idx], RTE_MBUF_FREE);
+#endif
 	}
 
 	rte_mempool_put_bulk(mp, (void **)mbufs, count);
@@ -1013,6 +1028,10 @@ static inline int rte_pktmbuf_alloc_bulk(struct rte_mempool *pool,
 	if (unlikely(rc))
 		return rc;
 
+#if RTE_MBUF_HISTORY_DEBUG
+	rte_mbuf_history_bulk(mbufs, count, RTE_MBUF_ALLOC);
+#endif
+
 	/* To understand duff's device on loop unwinding optimization, see
 	 * https://en.wikipedia.org/wiki/Duff's_device.
 	 * Here while() loop is used rather than do() while{} to avoid extra
diff --git a/lib/mbuf/rte_mbuf_dyn.h b/lib/mbuf/rte_mbuf_dyn.h
index 865c90f579..8ae31b4e65 100644
--- a/lib/mbuf/rte_mbuf_dyn.h
+++ b/lib/mbuf/rte_mbuf_dyn.h
@@ -240,6 +240,13 @@ void rte_mbuf_dyn_dump(FILE *out);
  * and parameters together.
  */
 
+/**
+ * The mbuf history dynamic field provides lifecycle tracking for mbuf objects through the system.
+ * It records a fixed set of predefined operations to maintain performance
+ * while providing debugging capabilities.
+ */
+#define RTE_MBUF_DYNFIELD_HISTORY_NAME "rte_mbuf_dynfield_history"
+
 /*
  * The metadata dynamic field provides some extra packet information
  * to interact with RTE Flow engine. The metadata in sent mbufs can be
diff --git a/lib/mbuf/rte_mbuf_history.c b/lib/mbuf/rte_mbuf_history.c
new file mode 100644
index 0000000000..5be56289ca
--- /dev/null
+++ b/lib/mbuf/rte_mbuf_history.c
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 NVIDIA Corporation & Affiliates
+ */
+
+#include <rte_mbuf_history.h>
+#include <rte_mbuf_dyn.h>
+#include <rte_log.h>
+#include <rte_errno.h>
+#include <eal_export.h>
+#include <rte_mempool.h>
+#include <rte_tailq.h>
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+
+/* Global offset for the history field */
+int rte_mbuf_history_field_offset = -1;
+RTE_EXPORT_SYMBOL(rte_mbuf_history_field_offset);
+
+#if RTE_MBUF_HISTORY_DEBUG
+/* Dynamic field definition for mbuf history */
+static const struct rte_mbuf_dynfield mbuf_dynfield_history = {
+	.name = RTE_MBUF_DYNFIELD_HISTORY_NAME,
+	.size = sizeof(uint64_t),
+	.align = RTE_ALIGN(sizeof(uint64_t), 8),
+};
+
+/* Context structure for combined statistics counting and mbuf history printing */
+struct count_and_print_ctx {
+	uint64_t *stats;
+	FILE *f;
+};
+
+static void
+mbuf_history_count_stats_and_print(struct rte_mempool *mp __rte_unused, void *opaque,
+					void *obj, unsigned obj_idx __rte_unused)
+{
+	struct count_and_print_ctx *ctx = (struct count_and_print_ctx *)opaque;
+
+	struct rte_mbuf *mbuf = (struct rte_mbuf *)obj;
+
+	if (obj == NULL || ctx == NULL || ctx->stats == NULL || ctx->f == NULL)
+		return;
+
+	/* Get mbuf history */
+	uint64_t history = rte_mbuf_history_get(mbuf);
+
+	ctx->stats[0]++; /* n_total */
+
+	if (history == 0) {
+		ctx->stats[1]++; /* n_never */
+		return;
+	}
+
+	/* Extract the most recent operation */
+	uint64_t op = history & RTE_MBUF_HISTORY_MASK;
+
+	switch (op) {
+	case RTE_MBUF_FREE:
+		ctx->stats[2]++; /* n_free */
+		break;
+	case RTE_MBUF_PMD_FREE:
+		ctx->stats[3]++; /* n_pmd_free */
+		break;
+	case RTE_MBUF_PMD_TX:
+		ctx->stats[4]++; /* n_pmd_tx */
+		break;
+	case RTE_MBUF_APP_RX:
+		ctx->stats[5]++; /* n_app_rx */
+		break;
+	case RTE_MBUF_PMD_ALLOC:
+		ctx->stats[6]++; /* n_pmd_alloc */
+		break;
+	case RTE_MBUF_ALLOC:
+		ctx->stats[7]++; /* n_alloc */
+		break;
+	case RTE_MBUF_BUSY_TX:
+		ctx->stats[8]++; /* n_busy_tx */
+		break;
+	default:
+		break;
+	}
+
+	/* Print the mbuf history value */
+	fprintf(ctx->f, "mbuf %p: %016" PRIX64 "\n", mbuf, history);
+
+}
+
+static void
+mbuf_history_get_stat(struct rte_mempool *mp, void *arg)
+{
+	FILE *f = (FILE *)arg;
+	uint64_t stats[9] = {0};
+
+	if (f == NULL)
+		return;
+
+	/* Output mempool header */
+	fprintf(f, "=== Mempool: %s ===\n", mp->name);
+
+	/* Create context structure for combined counting and printing */
+	struct count_and_print_ctx ctx = { .stats = stats, .f = f };
+
+	/* Single pass: collect statistics and print mbuf history */
+	rte_mempool_obj_iter(mp, mbuf_history_count_stats_and_print, &ctx);
+
+	/* Calculate total allocated mbufs */
+	uint64_t total_allocated = stats[3] + stats[4] + stats[5] +
+	stats[6] + stats[7] + stats[8];
+
+	/* Print statistics summary */
+	fprintf(f, "\n"
+		"Populated:       %u\n"
+		"Never allocated: %" PRIu64 "\n"
+		"Free:            %" PRIu64 "\n"
+		"Allocated:       %" PRIu64 "\n"
+		"PMD owned Tx:    %" PRIu64 "\n"
+		"PMD owned Rx:    %" PRIu64 "\n"
+		"App owned alloc: %" PRIu64 "\n"
+		"App owned Rx:    %" PRIu64 "\n"
+		"App owned busy:  %" PRIu64 "\n"
+		"Counted total:   %" PRIu64 "\n",
+		mp->populated_size, stats[1], stats[2], total_allocated,
+		stats[4], stats[6], stats[7], stats[5], stats[8], stats[0]);
+
+	fprintf(f, "---\n");
+}
+#endif
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump, 25.11)
+#if RTE_MBUF_HISTORY_DEBUG
+void rte_mbuf_history_dump(FILE *f)
+{
+	if (f == NULL) {
+		RTE_LOG(ERR, MBUF, "Invalid file pointer\n");
+		return;
+	}
+
+	fprintf(f, "=== MBUF History Statistics ===\n");
+	fprintf(f, "Dumping complete mbuf history for all mempools...\n");
+
+	/* Check if mbuf history is initialized */
+	if (rte_mbuf_history_field_offset == -1) {
+		fprintf(f, "WARNING: MBUF history not initialized. Call rte_mbuf_history_init() first.\n\n");
+		return;
+	}
+
+	/* Use rte_mempool_walk to iterate over all mempools */
+	rte_mempool_walk(mbuf_history_get_stat, f);
+}
+
+int rte_mbuf_history_init(void)
+{
+	if (rte_mbuf_history_field_offset != -1) {
+		/* Already initialized */
+		return 0;
+	}
+
+	rte_mbuf_history_field_offset = rte_mbuf_dynfield_register(&mbuf_dynfield_history);
+	if (rte_mbuf_history_field_offset < 0) {
+		RTE_LOG(ERR, MBUF, "Failed to register mbuf history dynamic field: %s\n",
+			rte_strerror(rte_errno));
+		return -1;
+	}
+	return 0;
+}
+#else
+void rte_mbuf_history_dump(FILE *f)
+{
+	RTE_SET_USED(f);
+	RTE_LOG(INFO, MBUF, "Mbuf history recorder is not supported\n");
+}
+
+int rte_mbuf_history_init(void)
+{
+	rte_errno = ENOTSUP;
+	return -1;
+}
+#endif
+RTE_EXPORT_SYMBOL(rte_mbuf_history_init);
+RTE_EXPORT_SYMBOL(rte_mbuf_history_dump);
diff --git a/lib/mbuf/rte_mbuf_history.h b/lib/mbuf/rte_mbuf_history.h
new file mode 100644
index 0000000000..4448ad1557
--- /dev/null
+++ b/lib/mbuf/rte_mbuf_history.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef _RTE_MBUF_HISTORY_H_
+#define _RTE_MBUF_HISTORY_H_
+
+/**
+ * @file
+ * MBUF History
+ *
+ * This module provides history tracking for mbuf objects using dynamic fields.
+ * It tracks the lifecycle of mbuf objects through the system with a fixed set
+ * of predefined events to maintain performance.
+ *
+ * The history is stored as a 64-bit value in the mbuf dynamic field area,
+ * with each event encoded in 4 bits, allowing up to 16 events to be tracked.
+ */
+
+#include <stdint.h>
+#include <rte_mbuf_dyn.h>
+#include <rte_common.h>
+#include <rte_branch_prediction.h>
+#include "mbuf_log.h"
+
+/* Forward declaration to avoid circular dependency */
+struct rte_mbuf;
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * Number of bits for each history operation
+ */
+#define RTE_MBUF_HISTORY_BITS          4
+
+/**
+ * Maximum number of history operations that can be stored
+ */
+#define RTE_MBUF_HISTORY_MAX_OPS       16
+
+/**
+ * Mask for extracting the most recent operation from history
+ */
+#define RTE_MBUF_HISTORY_MASK          ((1ULL << RTE_MBUF_HISTORY_BITS) - 1)
+
+/**
+ * History operation types
+ */
+enum rte_mbuf_history_op {
+	RTE_MBUF_NEVER = 0,        /* Initial state - never allocated */
+	RTE_MBUF_FREE = 1,         /* Freed back to pool */
+	RTE_MBUF_PMD_FREE = 2,     /* Freed by PMD back to pool*/
+	RTE_MBUF_PMD_TX = 3,       /* Sent to PMD for Tx */
+	RTE_MBUF_APP_RX = 4,       /* Returned to application on Rx */
+	RTE_MBUF_PMD_ALLOC = 5,    /* Allocated by PMD for Rx */
+	RTE_MBUF_ALLOC = 6,        /* Allocated by application */
+	RTE_MBUF_BUSY_TX = 7,      /* Returned to app due to Tx busy */
+	RTE_MBUF_USR3 = 13,        /* Application-defined event 3 */
+	RTE_MBUF_USR2 = 14,        /* Application-defined event 2 */
+	RTE_MBUF_USR1 = 15,        /* Application-defined event 1 */
+	RTE_MBUF_MAX = 16,          /* Maximum trace operation value */
+};
+
+
+/**
+ * Global offset for the history field (set during initialization)
+ */
+extern int rte_mbuf_history_field_offset;
+
+/**
+ * Initialize the mbuf history system
+ *
+ * This function registers the dynamic field for mbuf history tracking.
+ * It should be called once during application initialization.
+ *
+ * Note: This function is called by rte_pktmbuf_pool_create,
+ * so explicit invocation is usually not required unless initializing manually.
+ *
+ * @return
+ *   0 on success, -1 on failure with rte_errno set
+ */
+int rte_mbuf_history_init(void);
+
+#if RTE_MBUF_HISTORY_DEBUG
+/**
+ * Get the history value from an mbuf
+ *
+ * @param m
+ *   Pointer to the mbuf
+ * @return
+ *   The history value, or 0 if history is not available
+ */
+static inline uint64_t rte_mbuf_history_get(const struct rte_mbuf *m)
+{
+	if (unlikely(m == NULL || rte_mbuf_history_field_offset == -1))
+		return 0;
+
+	return *RTE_MBUF_DYNFIELD(m, rte_mbuf_history_field_offset, uint64_t *);
+}
+
+/**
+ * Mark an mbuf with a history event
+ *
+ * @param m
+ *   Pointer to the mbuf
+ * @param op
+ *   The operation to record
+ */
+static inline void rte_mbuf_history_mark(struct rte_mbuf *m, uint32_t op)
+{
+	if (unlikely(m == NULL || op >= RTE_MBUF_MAX || rte_mbuf_history_field_offset == -1))
+		return;
+
+	uint64_t *history = RTE_MBUF_DYNFIELD(m, rte_mbuf_history_field_offset, uint64_t *);
+	*history = (*history << RTE_MBUF_HISTORY_BITS) | op;
+}
+
+/**
+ * Mark multiple mbufs with a history event
+ *
+ * @param mbufs
+ *   Array of mbuf pointers
+ * @param n
+ *   Number of mbufs to mark
+ * @param op
+ *   The operation to record
+ */
+static inline void rte_mbuf_history_bulk(struct rte_mbuf * const *mbufs,
+					uint32_t n, uint32_t op)
+{
+	if (unlikely(mbufs == NULL || op >= RTE_MBUF_MAX || rte_mbuf_history_field_offset == -1))
+		return;
+
+	while (n--)
+		rte_mbuf_history_mark(*mbufs++, op);
+}
+#endif
+
+/**
+ * Dump mbuf history statistics for all mempools to a file
+ *
+ * @param f
+ *   File pointer to write the history statistics to
+ */
+__rte_experimental
+void rte_mbuf_history_dump(FILE *f);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_MBUF_HISTORY_H_ */
diff --git a/meson_options.txt b/meson_options.txt
index e49b2fc089..48f6d4a9a5 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -16,6 +16,8 @@ option('drivers_install_subdir', type: 'string', value: 'dpdk/pmds-<VERSION>', d
        'Subdirectory of libdir where to install PMDs. Defaults to using a versioned subdirectory.')
 option('enable_docs', type: 'boolean', value: false, description:
        'build documentation')
+option('enable_mbuf_history', type: 'boolean', value: false, description:
+       'Enable mbuf history tracking for debugging purposes. This will track mbufs allocation and free operations. Default is false.')
 option('enable_apps', type: 'string', value: '', description:
        'Comma-separated list of apps to build. If unspecified, build all apps.')
 option('enable_deprecated_libs', type: 'string', value: '', description:
-- 
2.34.1

