Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B377ECAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:12:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D43F640695;
	Tue, 16 Sep 2025 17:12:51 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
 by mails.dpdk.org (Postfix) with ESMTP id EFB724067B
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:12:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/3krgP0q5lzoUcnK5VAXujlw3IQG7CTuhlDcZWBrI+OKKHaZ54QJARw8qfew77qW41szwUcuW3xlMqX82QHHAt301Ke0I2WnU+ovcluwJdveZ+cLNAzecH1mJqRDQ4t4EMCTCBnOHE+aM15nGfK6Jgi6xSCEn7FMScKbMW8pmAVGtJ77Mp9mV/Ugd27uShUleRg4+cflUAi3QOysC0WPrJW5BNemaFzZPSeBsqQbIPbfZJnZhrJsi5rgL3gRIOX9qZQnSLXMn+0ck2AlpuYZ9lp0nZrf4FeNKOaZ4yEJCthBdjFC4I5nSnm2yE4l0OjH4i71cabpN4ANtE9oEa63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T36s7a1L0QJStRvRhk/0+rNZkN/zb2jenhG201TYgg=;
 b=lCYoIecUxspUCpSEyJB/Tp6m9bJRtDDQGve3qCdg0BcBCo0XJZjF2BsGvWWBDXtt0digpUpxewqo5V4GmqwZdBfJdhvOpL/SaDY8HSb9vRHlrqtIOgzDnZqSRTDm1P+pDio9aMK6Fve64EsO7CbFXutjsXuHV4D7MFkuC6qphASmzhpevpQyOtaIm/4oW3vvYIh+Lr8kJ2daySPAdOfW2bF5AiXbX0oSu92HOqZtLjHpcx/Qp75ge3peFTQ+jEt6SgXdjmvE6oIjBB/T8XYLwyp1CaPM3TFLgqwuB+eVU/7p35bAtVJebG+RazwFIf7cDhTAsN00CdktNvVzeylN+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T36s7a1L0QJStRvRhk/0+rNZkN/zb2jenhG201TYgg=;
 b=FZQkDPqbOi7Mtkl2op2Szee/zO0LwpF5SXWu7z4qwOnp0FQ9tm49Z51YiZ/fHYsmX0kzQ7LXBDh06OflJkrWH0TzwJjwNj0fNo7p0HL6O3ViwIzYLU3ZFUhcPHEnUFx8QtRcz/B8yGe8Xafa9OF0x5LWwBxJJGhz+dBKOKmwaHFgdnApQIJPIpCYbYjYQ7dQNlgAPYXuuycEnmAyDh9cyuhm+8xCkF5MsihcwwbGiOn5qYYj79LWmS/ue3h7iBtx+eShiQ7wUeu7VsReXMWpcoW7C7jt6hXgw62P4W1hd/t9NhZNFGCrXMIO8AZZi1ugFOfCtV7HakUflHX+sE/16w==
Received: from CH5P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::11)
 by DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 15:12:47 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::20) by CH5P222CA0023.outlook.office365.com
 (2603:10b6:610:1ee::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 15:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 15:12:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 08:12:32 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 08:12:31 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 16 Sep 2025 08:12:26 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <mb@smartsharesystems.com>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, <ajit.khaparde@broadcom.com>,
 <jerinj@marvell.com>, <konstantin.v.ananyev@yandex.ru>,
 <david.marchand@redhat.com>, <maxime.coquelin@redhat.com>,
 <gakhil@marvell.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>, "Shani
 Peretz" <shperetz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 "Bing Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 2/4] net/mlx5: mark an operation in mbuf's history
Date: Tue, 16 Sep 2025 18:12:05 +0300
Message-ID: <20250916151207.556618-3-shperetz@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 4114465b-ffe6-4a43-53f7-08ddf5337ea8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sNXPfvlxF5kkm7ffThS94bL+DA/AQ8eESZzc1FsGmls8tEe7+R3rSqNbGqS0?=
 =?us-ascii?Q?LgUKGiGI5eBtYiGST7R1uYK8cTv9vLW/laTA/McsCwB3Kuc7wduV+0EvbIEj?=
 =?us-ascii?Q?EUK9vkByfhs8QtSWVukh8gU0UHesCY9pz7TNAeStR0GyQ61S9TcPHEl0boJw?=
 =?us-ascii?Q?lDJe5xnqXjDHrMZt19X2qa++DKvnvnjYczEXpKyPTh1QAbQLhPX8G8yVmdqn?=
 =?us-ascii?Q?mX54cS0oJVqpkMqG6ifvkI1KTOf1GnVu8Dwqtmzuny7+fcK/rm+c28UmnghT?=
 =?us-ascii?Q?cBQCD0JsWn04xo3rLvRw+6cUP0UlQdUAOGX9ZpRhX1mkQmSqlMJSmN+ABipY?=
 =?us-ascii?Q?RJqftD68FLEwyss12ZPT8Xei7pnZI5WrLbJaavLQI6QGjBJqAbH03pyJM453?=
 =?us-ascii?Q?1fXjQWFzStPJeFc1prfP/fleaWnqMjypwWfjFoR2ouQ5tbVq3G6kN+Ucdsyz?=
 =?us-ascii?Q?jTKgEOl+z6kh/++xjOqt3mkhWZL68JCP2kcmcDkTgtqFZlT6LV1+Y3ZfdHaQ?=
 =?us-ascii?Q?elmw8uJyQTd7SDOVYBAZtZCa0NKijL9hf+R9h7GmHWj3SRkJqgW39tPGFdPI?=
 =?us-ascii?Q?fC6fw9I42wqDslR3R+Zavcrx5vlzhcfEj10uj6ZWPZayJ+NIoGlSRDYgv+HH?=
 =?us-ascii?Q?DjCQdh7X6tGHTsxLsI2vrThoXv3O+jW+qzOTij/h0SJt4KavdA1rylzirvth?=
 =?us-ascii?Q?f9zmTyt6QezonIO0lERW/dsU6U2xjA2JfaWY3h4uTDv8f9k31HM1FoOBcNrH?=
 =?us-ascii?Q?dp71E37YsEf3Aggm5yFZiRVyBcI1fC34GnV/BoU8OzbdI8eskhzZtllPZlmt?=
 =?us-ascii?Q?1BwSdRU3c906fMoSBGNMFofoFsA/ijVnDiGZPqBQSB/0h0vEtO/9rNgSqRqR?=
 =?us-ascii?Q?ZqfAs6z2DVqjWfWt9aZ2SK8xNI3u3v32NZmRkMl8KQJImGh9Y1RvMVAlK8bg?=
 =?us-ascii?Q?LuicK9PXPDmbGcKuUNMi1B3VvvlNfYP2mnwjQV6AN7Z8Xr0ZFGvjHtwYiA9+?=
 =?us-ascii?Q?mNVgUeAa/MDdbLxqRY0SwaoLLIi+gQdCfRmA4vVUNDe5ESinO4bIDyhgLdwR?=
 =?us-ascii?Q?WbxXR6PAVZ4ZffTNpKxnhUIemeb4Sg3MzSOV84VZPV9H5uD+a7i/t9YwVHpF?=
 =?us-ascii?Q?u9nPqsVQeRjyD7yoXfnXKe39Jm5hFAz22uoLzqYtAXvYitP9UclP7ZRnSpZf?=
 =?us-ascii?Q?p54MLXJtHR5dxpHKtFJISyGfZKMNpH1XPQQuSjl8n5lMOGjZuFc7t9XCXUOQ?=
 =?us-ascii?Q?TzmBfqJY/8lW+fXaikndweYr3u6bQReJHVmf64SlNCosDENY+5KijMNOCUia?=
 =?us-ascii?Q?usCsfVn3OXFRcniVOQavLIlqO1yC4yjCxzdS15Q5+/YXZ68kZEQpKBr1U6s4?=
 =?us-ascii?Q?5tJgnGU30OY1F1q4DacQXhJqVt9CliF6lVTEuAmGW5mhXGhyBSLv0s41kUSS?=
 =?us-ascii?Q?mS5YshT+L/0cQUzEQ7QyCuJtW2jWjKJbHYFWYTvCF8fR2QgmDkbMBXneeqin?=
 =?us-ascii?Q?/gWdfA3Mg8mk5RDdVlm3KXI+uNZ2eT7dAMnW?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:12:47.1906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4114465b-ffe6-4a43-53f7-08ddf5337ea8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820
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

record operations on mbufs when it is allocated
and released inside the mlx5 PMD.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 drivers/net/mlx5/mlx5_rx.c       | 25 +++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_rx.h       |  6 ++++++
 drivers/net/mlx5/mlx5_rxq.c      | 15 +++++++++++++--
 drivers/net/mlx5/mlx5_rxtx_vec.c | 16 ++++++++++++++++
 drivers/net/mlx5/mlx5_tx.h       | 21 +++++++++++++++++++++
 drivers/net/mlx5/mlx5_txq.c      |  3 +++
 6 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 420a03068d..4e44892d93 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -640,12 +640,19 @@ mlx5_rx_err_handle(struct mlx5_rxq_data *rxq, uint8_t vec,
 					elt_idx = (elts_ci + i) & e_mask;
 					elt = &(*rxq->elts)[elt_idx];
 					*elt = rte_mbuf_raw_alloc(rxq->mp);
+#if RTE_MBUF_HISTORY_DEBUG
+					rte_mbuf_history_mark(*elt, RTE_MBUF_PMD_ALLOC);
+#endif
 					if (!*elt) {
 						for (i--; i >= 0; --i) {
 							elt_idx = (elts_ci +
 								   i) & elts_n;
 							elt = &(*rxq->elts)
 								[elt_idx];
+#if RTE_MBUF_HISTORY_DEBUG
+							rte_mbuf_history_mark(*elt,
+								RTE_MBUF_PMD_FREE);
+#endif
 							rte_pktmbuf_free_seg
 								(*elt);
 						}
@@ -1048,6 +1055,9 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		rte_prefetch0(wqe);
 		/* Allocate the buf from the same pool. */
 		rep = rte_mbuf_raw_alloc(seg->pool);
+#if RTE_MBUF_HISTORY_DEBUG
+		rte_mbuf_history_mark(rep, RTE_MBUF_PMD_ALLOC);
+#endif
 		if (unlikely(rep == NULL)) {
 			++rxq->stats.rx_nombuf;
 			if (!pkt) {
@@ -1062,6 +1072,9 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 				rep = NEXT(pkt);
 				NEXT(pkt) = NULL;
 				NB_SEGS(pkt) = 1;
+#if RTE_MBUF_HISTORY_DEBUG
+				rte_mbuf_history_mark(pkt, RTE_MBUF_PMD_FREE);
+#endif
 				rte_mbuf_raw_free(pkt);
 				pkt = rep;
 			}
@@ -1076,6 +1089,9 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 					       &mcqe, &skip_cnt, false, NULL);
 			if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
 				/* We drop packets with non-critical errors */
+#if RTE_MBUF_HISTORY_DEBUG
+				rte_mbuf_history_mark(rep, RTE_MBUF_PMD_FREE);
+#endif
 				rte_mbuf_raw_free(rep);
 				if (len == MLX5_CRITICAL_ERROR_CQE_RET) {
 					rq_ci = rxq->rq_ci << sges_n;
@@ -1089,6 +1105,9 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 				continue;
 			}
 			if (len == 0) {
+#if RTE_MBUF_HISTORY_DEBUG
+				rte_mbuf_history_mark(rep, RTE_MBUF_PMD_FREE);
+#endif
 				rte_mbuf_raw_free(rep);
 				break;
 			}
@@ -1540,6 +1559,9 @@ mlx5_rx_burst_mprq(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 			++rxq->stats.rx_nombuf;
 			break;
 		}
+#if RTE_MBUF_HISTORY_DEBUG
+		rte_mbuf_history_mark(pkt, RTE_MBUF_PMD_ALLOC);
+#endif
 		len = (byte_cnt & MLX5_MPRQ_LEN_MASK) >> MLX5_MPRQ_LEN_SHIFT;
 		MLX5_ASSERT((int)len >= (rxq->crc_present << 2));
 		if (rxq->crc_present)
@@ -1547,6 +1569,9 @@ mlx5_rx_burst_mprq(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		rxq_code = mprq_buf_to_pkt(rxq, pkt, len, buf,
 					   strd_idx, strd_cnt);
 		if (unlikely(rxq_code != MLX5_RXQ_CODE_EXIT)) {
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_mark(pkt, RTE_MBUF_PMD_FREE);
+#endif
 			rte_pktmbuf_free_seg(pkt);
 			if (rxq_code == MLX5_RXQ_CODE_DROPPED) {
 				++rxq->stats.idropped;
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index 7be31066a5..075b4bfc4b 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -525,6 +525,9 @@ mprq_buf_to_pkt(struct mlx5_rxq_data *rxq, struct rte_mbuf *pkt, uint32_t len,
 
 				if (unlikely(next == NULL))
 					return MLX5_RXQ_CODE_NOMBUF;
+#if RTE_MBUF_HISTORY_DEBUG
+				rte_mbuf_history_mark(next, RTE_MBUF_PMD_ALLOC);
+#endif
 				NEXT(prev) = next;
 				SET_DATA_OFF(next, 0);
 				addr = RTE_PTR_ADD(addr, seg_len);
@@ -588,6 +591,9 @@ mprq_buf_to_pkt(struct mlx5_rxq_data *rxq, struct rte_mbuf *pkt, uint32_t len,
 
 			if (unlikely(seg == NULL))
 				return MLX5_RXQ_CODE_NOMBUF;
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_mark(seg, RTE_MBUF_PMD_ALLOC);
+#endif
 			SET_DATA_OFF(seg, 0);
 			rte_memcpy(rte_pktmbuf_mtod(seg, void *),
 				RTE_PTR_ADD(addr, len - hdrm_overlap),
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index aeefece8c1..434a57ca32 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -164,6 +164,9 @@ rxq_alloc_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
 			rte_errno = ENOMEM;
 			goto error;
 		}
+#if RTE_MBUF_HISTORY_DEBUG
+		rte_mbuf_history_mark(buf, RTE_MBUF_PMD_ALLOC);
+#endif
 		/* Only vectored Rx routines rely on headroom size. */
 		MLX5_ASSERT(!has_vec_support ||
 			    DATA_OFF(buf) >= RTE_PKTMBUF_HEADROOM);
@@ -221,8 +224,12 @@ rxq_alloc_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
 	err = rte_errno; /* Save rte_errno before cleanup. */
 	elts_n = i;
 	for (i = 0; (i != elts_n); ++i) {
-		if ((*rxq_ctrl->rxq.elts)[i] != NULL)
+		if ((*rxq_ctrl->rxq.elts)[i] != NULL) {
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_mark((*rxq_ctrl->rxq.elts)[i], RTE_MBUF_PMD_FREE);
+#endif
 			rte_pktmbuf_free_seg((*rxq_ctrl->rxq.elts)[i]);
+		}
 		(*rxq_ctrl->rxq.elts)[i] = NULL;
 	}
 	if (rxq_ctrl->share_group == 0)
@@ -324,8 +331,12 @@ rxq_free_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
 		rxq->rq_pi = elts_ci;
 	}
 	for (i = 0; i != q_n; ++i) {
-		if ((*rxq->elts)[i] != NULL)
+		if ((*rxq->elts)[i] != NULL) {
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_mark((*rxq->elts)[i], RTE_MBUF_PMD_FREE);
+#endif
 			rte_pktmbuf_free_seg((*rxq->elts)[i]);
+		}
 		(*rxq->elts)[i] = NULL;
 	}
 }
diff --git a/drivers/net/mlx5/mlx5_rxtx_vec.c b/drivers/net/mlx5/mlx5_rxtx_vec.c
index 1b701801c5..c7ca808f43 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec.c
+++ b/drivers/net/mlx5/mlx5_rxtx_vec.c
@@ -63,6 +63,9 @@ rxq_handle_pending_error(struct mlx5_rxq_data *rxq, struct rte_mbuf **pkts,
 		if (pkt->packet_type == RTE_PTYPE_ALL_MASK || rxq->err_state) {
 #ifdef MLX5_PMD_SOFT_COUNTERS
 			err_bytes += PKT_LEN(pkt);
+#endif
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_mark(pkt, RTE_MBUF_PMD_FREE);
 #endif
 			rte_pktmbuf_free_seg(pkt);
 		} else {
@@ -107,6 +110,9 @@ mlx5_rx_replenish_bulk_mbuf(struct mlx5_rxq_data *rxq)
 			rxq->stats.rx_nombuf += n;
 			return;
 		}
+#if RTE_MBUF_HISTORY_DEBUG
+		rte_mbuf_history_bulk(elts, n, RTE_MBUF_PMD_ALLOC);
+#endif
 		if (unlikely(mlx5_mr_btree_len(&rxq->mr_ctrl.cache_bh) > 1)) {
 			for (i = 0; i < n; ++i) {
 				/*
@@ -171,6 +177,9 @@ mlx5_rx_mprq_replenish_bulk_mbuf(struct mlx5_rxq_data *rxq)
 			rxq->stats.rx_nombuf += n;
 			return;
 		}
+#if RTE_MBUF_HISTORY_DEBUG
+		rte_mbuf_history_bulk(elts, n, RTE_MBUF_PMD_ALLOC);
+#endif
 		rxq->elts_ci += n;
 		/* Prevent overflowing into consumed mbufs. */
 		elts_idx = rxq->elts_ci & wqe_mask;
@@ -224,6 +233,9 @@ rxq_copy_mprq_mbuf_v(struct mlx5_rxq_data *rxq,
 
 		if (!elts[i]->pkt_len) {
 			rxq->consumed_strd = strd_n;
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_mark(elts[i], RTE_MBUF_PMD_FREE);
+#endif
 			rte_pktmbuf_free_seg(elts[i]);
 #ifdef MLX5_PMD_SOFT_COUNTERS
 			rxq->stats.ipackets -= 1;
@@ -236,6 +248,9 @@ rxq_copy_mprq_mbuf_v(struct mlx5_rxq_data *rxq,
 					   buf, rxq->consumed_strd, strd_cnt);
 		rxq->consumed_strd += strd_cnt;
 		if (unlikely(rxq_code != MLX5_RXQ_CODE_EXIT)) {
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_mark(elts[i], RTE_MBUF_PMD_FREE);
+#endif
 			rte_pktmbuf_free_seg(elts[i]);
 #ifdef MLX5_PMD_SOFT_COUNTERS
 			rxq->stats.ipackets -= 1;
@@ -586,6 +601,7 @@ mlx5_rx_burst_mprq_vec(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		rte_io_wmb();
 		*rxq->cq_db = rte_cpu_to_be_32(rxq->cq_ci);
 	} while (tn != pkts_n);
+
 	return tn;
 }
 
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 16307206e2..c3d69942a8 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -555,6 +555,9 @@ mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
 	if (!MLX5_TXOFF_CONFIG(MULTI) && txq->fast_free) {
 		mbuf = *pkts;
 		pool = mbuf->pool;
+#if RTE_MBUF_HISTORY_DEBUG
+		rte_mbuf_history_bulk(pkts, pkts_n, RTE_MBUF_PMD_FREE);
+#endif
 		rte_mempool_put_bulk(pool, (void *)pkts, pkts_n);
 		return;
 	}
@@ -610,6 +613,9 @@ mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
 			 * Free the array of pre-freed mbufs
 			 * belonging to the same memory pool.
 			 */
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_bulk(p_free, n_free, RTE_MBUF_PMD_FREE);
+#endif
 			rte_mempool_put_bulk(pool, (void *)p_free, n_free);
 			if (unlikely(mbuf != NULL)) {
 				/* There is the request to start new scan. */
@@ -1225,6 +1231,9 @@ mlx5_tx_mseg_memcpy(uint8_t *pdst,
 			/* Exhausted packet, just free. */
 			mbuf = loc->mbuf;
 			loc->mbuf = mbuf->next;
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_mark(mbuf, RTE_MBUF_PMD_FREE);
+#endif
 			rte_pktmbuf_free_seg(mbuf);
 			loc->mbuf_off = 0;
 			MLX5_ASSERT(loc->mbuf_nseg > 1);
@@ -1267,6 +1276,9 @@ mlx5_tx_mseg_memcpy(uint8_t *pdst,
 				/* Exhausted packet, just free. */
 				mbuf = loc->mbuf;
 				loc->mbuf = mbuf->next;
+#if RTE_MBUF_HISTORY_DEBUG
+				rte_mbuf_history_mark(mbuf, RTE_MBUF_PMD_FREE);
+#endif
 				rte_pktmbuf_free_seg(mbuf);
 				loc->mbuf_off = 0;
 				MLX5_ASSERT(loc->mbuf_nseg >= 1);
@@ -1717,6 +1729,9 @@ mlx5_tx_mseg_build(struct mlx5_txq_data *__rte_restrict txq,
 			/* Zero length segment found, just skip. */
 			mbuf = loc->mbuf;
 			loc->mbuf = loc->mbuf->next;
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_mark(mbuf, RTE_MBUF_PMD_FREE);
+#endif
 			rte_pktmbuf_free_seg(mbuf);
 			if (--loc->mbuf_nseg == 0)
 				break;
@@ -2020,6 +2035,9 @@ mlx5_tx_packet_multi_send(struct mlx5_txq_data *__rte_restrict txq,
 			wqe->cseg.sq_ds -= RTE_BE32(1);
 			mbuf = loc->mbuf;
 			loc->mbuf = mbuf->next;
+#if RTE_MBUF_HISTORY_DEBUG
+			rte_mbuf_history_mark(mbuf, RTE_MBUF_PMD_FREE);
+#endif
 			rte_pktmbuf_free_seg(mbuf);
 			if (--nseg == 0)
 				break;
@@ -3319,6 +3337,9 @@ mlx5_tx_burst_single_send(struct mlx5_txq_data *__rte_restrict txq,
 				 * Packet data are completely inlined,
 				 * free the packet immediately.
 				 */
+#if RTE_MBUF_HISTORY_DEBUG
+				rte_mbuf_history_mark(loc->mbuf, RTE_MBUF_PMD_FREE);
+#endif
 				rte_pktmbuf_free_seg(loc->mbuf);
 			} else if ((!MLX5_TXOFF_CONFIG(EMPW) ||
 				     MLX5_TXOFF_CONFIG(MPW)) &&
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 2aa2475a8a..445d1d62c4 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -79,6 +79,9 @@ txq_free_elts(struct mlx5_txq_ctrl *txq_ctrl)
 		struct rte_mbuf *elt = (*elts)[elts_tail & elts_m];
 
 		MLX5_ASSERT(elt != NULL);
+#if RTE_MBUF_HISTORY_DEBUG
+		rte_mbuf_history_mark(elt, RTE_MBUF_PMD_FREE);
+#endif
 		rte_pktmbuf_free_seg(elt);
 #ifdef RTE_LIBRTE_MLX5_DEBUG
 		/* Poisoning. */
-- 
2.34.1

