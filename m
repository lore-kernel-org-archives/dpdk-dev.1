Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5608C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:30:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 901F640B91;
	Mon, 16 Jun 2025 09:30:09 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by mails.dpdk.org (Postfix) with ESMTP id C1BC440B95
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:30:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qP+mo8yOD+tMW1Kdu/7zT8U03AM78Nw21JSaUV0tsURD8mpLmhqo3/E6VulUH5Mbd0YXK7ofOysqvnib7G5v1Bgoz05onk1k3toP2AmK1xOsZQNup/pzf7gEh2ROXVxw78t9FLitFO8pQQmSN7ZXsiYfEc7T6G9Pre17S4y7tmQ3Wya3XiEkiqfToQbWjk1GXsZp4knuC6cs0tcjF8ekVtbGc85LPsYH5gzo09sXSgFdAIXAOfaYERt3iityd21JFcRnipGoYOUgk1rdsVg9H2bP3N0cxTFPpkz8Dj0c/xffrbRQGWkTZfecjDDF4dWSjqpURNJQA+HDQOGeFGaNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnfUxkgmVEuwoltJsJ0HdUKGD+DKBHU5ODITDOhwwRA=;
 b=Jcq5JK/csjK2exmrRY3pnkmUkOF/l0P9YkSJrVr0TvyYa5XiNNRKviWAO3Um4vFnQY77d9fPTTgYPhiVw8VKRU/gTf2WU/0vJkQfi9+J+6sNLUqWlxdGnKHS1vKb6Y4StSUYVaZudl5HPK9kU1wGvDP/sG3TCWuR4+18NLk99FM1m+RgYMyFfBeSySdle6qVqD+fu7iRTiaxJSU/XkN3phnd/p7ytuXpNuNio0qNc5p4EKfKI9HgeorlNk0JSEinrCDQsuQNUek/PMd5sFhgPdR9dp5FDfXA2601Kyrq6uP3gsP7Ex//yIY35/2PgqlxzliekrX9j9AL2NQzPHRXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnfUxkgmVEuwoltJsJ0HdUKGD+DKBHU5ODITDOhwwRA=;
 b=SfHorkHkjhBTUOCRLZpvgTpVk5BTLzqkmg2+AsFqmPdaMhNZ0B8MzYChtVZZucJ8QChXg9eMSRp23DbRfYitzYLt1oXGVv6Q/4K54r8uAAa60u2rfa0SDqfQSGb9nqDfViJ8hCm1suwm4+YO3DJ/fPTgXd7T2gnPeksuKATey+aZcgDHSL2ZVgOPlM79TDg2KI5aOm1bLPq+jnq5VyxFsq1qfOu6cgYJN9/toOpBjNUuHm8UGG3E834PzalrYWDmB5bZS+cxqF6q7T/6hdIU3Zn0y+e/xUXQkXOa9AJ1N5y9/E5Sa9eoS3xo2YASm6lCcOVjC6v4aUcPrwcA2TWngA==
Received: from CH0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:610:e4::6)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 16 Jun
 2025 07:30:00 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:e4:cafe::3d) by CH0PR03CA0181.outlook.office365.com
 (2603:10b6:610:e4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 16 Jun 2025 07:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.0 via Frontend Transport; Mon, 16 Jun 2025 07:30:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 00:29:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 00:29:46 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 00:29:43 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [RFC PATCH 3/5] net/mlx5: mark an operation in mempool object's
 history
Date: Mon, 16 Jun 2025 10:29:08 +0300
Message-ID: <20250616072910.113042-4-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616072910.113042-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: d676e0cd-2b23-4ce6-c286-08ddaca79a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0SxEbhUpASDQ3age4x8fUAcBAGzhVwc1Qvs7ofH+h6ZP6b+GQNJgeb4FOSsS?=
 =?us-ascii?Q?g378gK5avbeArMuWch+4AMT4CD3sM0IyPX5c+WqXbuGGlHi0H0H7n0IFmdeF?=
 =?us-ascii?Q?u1yFKfPy/6q7qkWvPnCMqpbk+Fg22xoI3JKDtOyauED/qWb5CVwNG7g/PL/0?=
 =?us-ascii?Q?THt9HI/lA08iQbubYIw1WMgoF8Pv6p9kfIfEymcBknmpSUUMAwngalAs1Gmv?=
 =?us-ascii?Q?IWQElRpYxzrFDl8rAgg3mz1OK5Nq4iOJjj+lZJzBDvIpmMstTKZjfwWCoT0g?=
 =?us-ascii?Q?P+mkSP+x4rIRZ3q88dIRpRTnroQlUPG4oK7V0dkJe9HHDeuUsujmKo2Pogyl?=
 =?us-ascii?Q?XFvXn1MCluwjVYOSRHBgsHkOilnyFG30fUu0L4WPDt8xjoYw+2sul16XDeWU?=
 =?us-ascii?Q?7HEqjsJym8wPYaXsYchX3TPDpuBnnVgFXZea/mSyTChv9HjYlAeEa7BM6A1E?=
 =?us-ascii?Q?N05+ceWK2Z5wtiYKbJNz9sjwq1e37nLA0MSNVpwAs5wouokXNw1TB89UPYxA?=
 =?us-ascii?Q?I+oOsV8E44ODFor1AFc6eS4ke9WGpv15ixqs6Ryah/doH5xxWb5SwCD6w8Ki?=
 =?us-ascii?Q?XRdSZH/33ERPJ678hJERdMY9UODuUX1t0cdEaWs4G6zYXyvNCJQ9qiBsYth0?=
 =?us-ascii?Q?YJDIkQ+btSYZ+AKKomu9/M+z+D9kVN+x3VytpIGolCOVSksUvpnDoC4FxCuy?=
 =?us-ascii?Q?GZ9xZK3ZxQGRzLAKpOMfh1fQpH7qb1ofx/2G3Loj68FvJYn/sL9OU1o2wCQH?=
 =?us-ascii?Q?U3rskQYOmV6+Y2x9Hv049adbEZ26yZD77Y9Ap/fl3WrnGBOuWe6sMvWOkYdN?=
 =?us-ascii?Q?EMJC+p/epUuU+DJ0njfRsUp98oukOMY7sjPcRII+vAqCkTyMe/lp4VClQn1Y?=
 =?us-ascii?Q?WuuWh6yEC3XJx1K02p0qmnYv/teAnr7CzMPuKo+K5wCD0zp+MIjZFf/tk6O/?=
 =?us-ascii?Q?Te+1tGXPWm/WGUzGsQFr5NnZSGVOGIIWC2NMqGS/Juurf45b11b8PzQNuk+o?=
 =?us-ascii?Q?Tt3rZ4sLwWrcI0HUcZwqnuJbz7sRNCHnYbTNVGZJMgiiDReaz/ZgoztXlLXF?=
 =?us-ascii?Q?2fw0I5HdvppvRzLp0ZNre5FKFpVzYibC1yt7EhxjykbCFoQndDsJ7OyA3ank?=
 =?us-ascii?Q?UjYBKNw10Z8UYH+Y2++IfZF49s4roOD96W/JVkGwY+Ql+1vfifh60ja3XaVd?=
 =?us-ascii?Q?9Y+Ela5KHdbrrpC2tpfPuEWz+9IwbqJFsSvPNBtZcbXPo/BuogGuApj8HFk/?=
 =?us-ascii?Q?hLknw4L8V5La9HRiXwMyczcDwPIFnypTjXbB6wtPGbqIApKVZpCdBCJG3HK5?=
 =?us-ascii?Q?s+LSeuttkkV23XgFzxpY2TU2UWsDv95uuu+tVPihYi9A7kT5cw2pXophcL9m?=
 =?us-ascii?Q?vLB2FaPMoVg/nozdvO7OD6sGIf8+96rdVNYf1oaJbx+qVTtTA3/uHwQ6kK7g?=
 =?us-ascii?Q?yCrh7TztgzjCgHC9O/9L7d6AqWcvRJAOp+HmQ0Iw95YNdiaEb2MdUt32KdtU?=
 =?us-ascii?Q?H/nreENPArUQZtAcWouf6JxYWWnb9dmePi/7?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:30:00.3196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d676e0cd-2b23-4ce6-c286-08ddaca79a4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587
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

record operations on mempool objects when it is allocated
and released inside the mlx5 PMD.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 drivers/net/mlx5/mlx5_rx.c       | 9 +++++++++
 drivers/net/mlx5/mlx5_rx.h       | 2 ++
 drivers/net/mlx5/mlx5_rxq.c      | 9 +++++++--
 drivers/net/mlx5/mlx5_rxtx_vec.c | 6 ++++++
 drivers/net/mlx5/mlx5_tx.h       | 7 +++++++
 drivers/net/mlx5/mlx5_txq.c      | 1 +
 6 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 5f4a93fe8c..a86ed2180e 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -560,12 +560,15 @@ mlx5_rx_err_handle(struct mlx5_rxq_data *rxq, uint8_t vec,
 					elt_idx = (elts_ci + i) & e_mask;
 					elt = &(*rxq->elts)[elt_idx];
 					*elt = rte_mbuf_raw_alloc(rxq->mp);
+					rte_mempool_history_mark(*elt, RTE_MEMPOOL_PMD_ALLOC);
 					if (!*elt) {
 						for (i--; i >= 0; --i) {
 							elt_idx = (elts_ci +
 								   i) & elts_n;
 							elt = &(*rxq->elts)
 								[elt_idx];
+							rte_mempool_history_mark(*elt,
+									RTE_MEMPOOL_PMD_FREE);
 							rte_pktmbuf_free_seg
 								(*elt);
 						}
@@ -952,6 +955,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		rte_prefetch0(wqe);
 		/* Allocate the buf from the same pool. */
 		rep = rte_mbuf_raw_alloc(seg->pool);
+		rte_mempool_history_mark(rep, RTE_MEMPOOL_PMD_ALLOC);
 		if (unlikely(rep == NULL)) {
 			++rxq->stats.rx_nombuf;
 			if (!pkt) {
@@ -966,6 +970,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 				rep = NEXT(pkt);
 				NEXT(pkt) = NULL;
 				NB_SEGS(pkt) = 1;
+				rte_mempool_history_mark(pkt, RTE_MEMPOOL_PMD_FREE);
 				rte_mbuf_raw_free(pkt);
 				pkt = rep;
 			}
@@ -979,6 +984,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 			len = mlx5_rx_poll_len(rxq, cqe, cqe_n, cqe_mask, &mcqe, &skip_cnt, false);
 			if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
 				/* We drop packets with non-critical errors */
+				rte_mempool_history_mark(rep, RTE_MEMPOOL_PMD_FREE);
 				rte_mbuf_raw_free(rep);
 				if (len == MLX5_CRITICAL_ERROR_CQE_RET) {
 					rq_ci = rxq->rq_ci << sges_n;
@@ -992,6 +998,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 				continue;
 			}
 			if (len == 0) {
+				rte_mempool_history_mark(rep, RTE_MEMPOOL_PMD_FREE);
 				rte_mbuf_raw_free(rep);
 				break;
 			}
@@ -1268,6 +1275,7 @@ mlx5_rx_burst_mprq(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 			++rxq->stats.rx_nombuf;
 			break;
 		}
+		rte_mempool_history_mark(pkt, RTE_MEMPOOL_PMD_ALLOC);
 		len = (byte_cnt & MLX5_MPRQ_LEN_MASK) >> MLX5_MPRQ_LEN_SHIFT;
 		MLX5_ASSERT((int)len >= (rxq->crc_present << 2));
 		if (rxq->crc_present)
@@ -1275,6 +1283,7 @@ mlx5_rx_burst_mprq(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		rxq_code = mprq_buf_to_pkt(rxq, pkt, len, buf,
 					   strd_idx, strd_cnt);
 		if (unlikely(rxq_code != MLX5_RXQ_CODE_EXIT)) {
+			rte_mempool_history_mark(pkt, RTE_MEMPOOL_PMD_FREE);
 			rte_pktmbuf_free_seg(pkt);
 			if (rxq_code == MLX5_RXQ_CODE_DROPPED) {
 				++rxq->stats.idropped;
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index 6380895502..db4ef10ca1 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -516,6 +516,7 @@ mprq_buf_to_pkt(struct mlx5_rxq_data *rxq, struct rte_mbuf *pkt, uint32_t len,
 
 				if (unlikely(next == NULL))
 					return MLX5_RXQ_CODE_NOMBUF;
+				rte_mempool_history_mark(next, RTE_MEMPOOL_PMD_ALLOC);
 				NEXT(prev) = next;
 				SET_DATA_OFF(next, 0);
 				addr = RTE_PTR_ADD(addr, seg_len);
@@ -579,6 +580,7 @@ mprq_buf_to_pkt(struct mlx5_rxq_data *rxq, struct rte_mbuf *pkt, uint32_t len,
 
 			if (unlikely(seg == NULL))
 				return MLX5_RXQ_CODE_NOMBUF;
+			rte_mempool_history_mark(seg, RTE_MEMPOOL_PMD_ALLOC);
 			SET_DATA_OFF(seg, 0);
 			rte_memcpy(rte_pktmbuf_mtod(seg, void *),
 				RTE_PTR_ADD(addr, len - hdrm_overlap),
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index f5df451a32..e95bef9d55 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -164,6 +164,7 @@ rxq_alloc_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
 			rte_errno = ENOMEM;
 			goto error;
 		}
+		rte_mempool_history_mark(buf, RTE_MEMPOOL_PMD_ALLOC);
 		/* Only vectored Rx routines rely on headroom size. */
 		MLX5_ASSERT(!has_vec_support ||
 			    DATA_OFF(buf) >= RTE_PKTMBUF_HEADROOM);
@@ -221,8 +222,10 @@ rxq_alloc_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
 	err = rte_errno; /* Save rte_errno before cleanup. */
 	elts_n = i;
 	for (i = 0; (i != elts_n); ++i) {
-		if ((*rxq_ctrl->rxq.elts)[i] != NULL)
+		if ((*rxq_ctrl->rxq.elts)[i] != NULL) {
+			rte_mempool_history_mark((*rxq_ctrl->rxq.elts)[i], RTE_MEMPOOL_PMD_FREE);
 			rte_pktmbuf_free_seg((*rxq_ctrl->rxq.elts)[i]);
+		}
 		(*rxq_ctrl->rxq.elts)[i] = NULL;
 	}
 	if (rxq_ctrl->share_group == 0)
@@ -324,8 +327,10 @@ rxq_free_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
 		rxq->rq_pi = elts_ci;
 	}
 	for (i = 0; i != q_n; ++i) {
-		if ((*rxq->elts)[i] != NULL)
+		if ((*rxq->elts)[i] != NULL) {
+			rte_mempool_history_mark((*rxq->elts)[i], RTE_MEMPOOL_PMD_FREE);
 			rte_pktmbuf_free_seg((*rxq->elts)[i]);
+		}
 		(*rxq->elts)[i] = NULL;
 	}
 }
diff --git a/drivers/net/mlx5/mlx5_rxtx_vec.c b/drivers/net/mlx5/mlx5_rxtx_vec.c
index 1b701801c5..ffaa10c547 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec.c
+++ b/drivers/net/mlx5/mlx5_rxtx_vec.c
@@ -64,6 +64,7 @@ rxq_handle_pending_error(struct mlx5_rxq_data *rxq, struct rte_mbuf **pkts,
 #ifdef MLX5_PMD_SOFT_COUNTERS
 			err_bytes += PKT_LEN(pkt);
 #endif
+			rte_mempool_history_mark(pkt, RTE_MEMPOOL_PMD_FREE);
 			rte_pktmbuf_free_seg(pkt);
 		} else {
 			pkts[n++] = pkt;
@@ -107,6 +108,7 @@ mlx5_rx_replenish_bulk_mbuf(struct mlx5_rxq_data *rxq)
 			rxq->stats.rx_nombuf += n;
 			return;
 		}
+		rte_mempool_history_bulk((void *)elts, n, RTE_MEMPOOL_PMD_ALLOC);
 		if (unlikely(mlx5_mr_btree_len(&rxq->mr_ctrl.cache_bh) > 1)) {
 			for (i = 0; i < n; ++i) {
 				/*
@@ -171,6 +173,7 @@ mlx5_rx_mprq_replenish_bulk_mbuf(struct mlx5_rxq_data *rxq)
 			rxq->stats.rx_nombuf += n;
 			return;
 		}
+		rte_mempool_history_bulk((void *)elts, n, RTE_MEMPOOL_PMD_ALLOC);
 		rxq->elts_ci += n;
 		/* Prevent overflowing into consumed mbufs. */
 		elts_idx = rxq->elts_ci & wqe_mask;
@@ -224,6 +227,7 @@ rxq_copy_mprq_mbuf_v(struct mlx5_rxq_data *rxq,
 
 		if (!elts[i]->pkt_len) {
 			rxq->consumed_strd = strd_n;
+			rte_mempool_history_mark(elts[i], RTE_MEMPOOL_PMD_FREE);
 			rte_pktmbuf_free_seg(elts[i]);
 #ifdef MLX5_PMD_SOFT_COUNTERS
 			rxq->stats.ipackets -= 1;
@@ -236,6 +240,7 @@ rxq_copy_mprq_mbuf_v(struct mlx5_rxq_data *rxq,
 					   buf, rxq->consumed_strd, strd_cnt);
 		rxq->consumed_strd += strd_cnt;
 		if (unlikely(rxq_code != MLX5_RXQ_CODE_EXIT)) {
+			rte_mempool_history_mark(elts[i], RTE_MEMPOOL_PMD_FREE);
 			rte_pktmbuf_free_seg(elts[i]);
 #ifdef MLX5_PMD_SOFT_COUNTERS
 			rxq->stats.ipackets -= 1;
@@ -586,6 +591,7 @@ mlx5_rx_burst_mprq_vec(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		rte_io_wmb();
 		*rxq->cq_db = rte_cpu_to_be_32(rxq->cq_ci);
 	} while (tn != pkts_n);
+
 	return tn;
 }
 
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 55568c41b1..7b61d87120 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -553,6 +553,7 @@ mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
 	if (!MLX5_TXOFF_CONFIG(MULTI) && txq->fast_free) {
 		mbuf = *pkts;
 		pool = mbuf->pool;
+		rte_mempool_history_bulk((void *)pkts, pkts_n, RTE_MEMPOOL_PMD_FREE);
 		rte_mempool_put_bulk(pool, (void *)pkts, pkts_n);
 		return;
 	}
@@ -608,6 +609,7 @@ mlx5_tx_free_mbuf(struct mlx5_txq_data *__rte_restrict txq,
 			 * Free the array of pre-freed mbufs
 			 * belonging to the same memory pool.
 			 */
+			rte_mempool_history_bulk((void *)p_free, n_free, RTE_MEMPOOL_PMD_FREE);
 			rte_mempool_put_bulk(pool, (void *)p_free, n_free);
 			if (unlikely(mbuf != NULL)) {
 				/* There is the request to start new scan. */
@@ -1223,6 +1225,7 @@ mlx5_tx_mseg_memcpy(uint8_t *pdst,
 			/* Exhausted packet, just free. */
 			mbuf = loc->mbuf;
 			loc->mbuf = mbuf->next;
+			rte_mempool_history_mark(mbuf, RTE_MEMPOOL_PMD_FREE);
 			rte_pktmbuf_free_seg(mbuf);
 			loc->mbuf_off = 0;
 			MLX5_ASSERT(loc->mbuf_nseg > 1);
@@ -1265,6 +1268,7 @@ mlx5_tx_mseg_memcpy(uint8_t *pdst,
 				/* Exhausted packet, just free. */
 				mbuf = loc->mbuf;
 				loc->mbuf = mbuf->next;
+				rte_mempool_history_mark(mbuf, RTE_MEMPOOL_PMD_FREE);
 				rte_pktmbuf_free_seg(mbuf);
 				loc->mbuf_off = 0;
 				MLX5_ASSERT(loc->mbuf_nseg >= 1);
@@ -1715,6 +1719,7 @@ mlx5_tx_mseg_build(struct mlx5_txq_data *__rte_restrict txq,
 			/* Zero length segment found, just skip. */
 			mbuf = loc->mbuf;
 			loc->mbuf = loc->mbuf->next;
+			rte_mempool_history_mark(mbuf, RTE_MEMPOOL_PMD_FREE);
 			rte_pktmbuf_free_seg(mbuf);
 			if (--loc->mbuf_nseg == 0)
 				break;
@@ -2018,6 +2023,7 @@ mlx5_tx_packet_multi_send(struct mlx5_txq_data *__rte_restrict txq,
 			wqe->cseg.sq_ds -= RTE_BE32(1);
 			mbuf = loc->mbuf;
 			loc->mbuf = mbuf->next;
+			rte_mempool_history_mark(mbuf, RTE_MEMPOOL_PMD_FREE);
 			rte_pktmbuf_free_seg(mbuf);
 			if (--nseg == 0)
 				break;
@@ -3317,6 +3323,7 @@ mlx5_tx_burst_single_send(struct mlx5_txq_data *__rte_restrict txq,
 				 * Packet data are completely inlined,
 				 * free the packet immediately.
 				 */
+				rte_mempool_history_mark(loc->mbuf, RTE_MEMPOOL_PMD_FREE);
 				rte_pktmbuf_free_seg(loc->mbuf);
 			} else if ((!MLX5_TXOFF_CONFIG(EMPW) ||
 				     MLX5_TXOFF_CONFIG(MPW)) &&
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 5fee5bc4e8..156f8c2ef8 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -78,6 +78,7 @@ txq_free_elts(struct mlx5_txq_ctrl *txq_ctrl)
 		struct rte_mbuf *elt = (*elts)[elts_tail & elts_m];
 
 		MLX5_ASSERT(elt != NULL);
+		rte_mempool_history_mark(elt, RTE_MEMPOOL_PMD_FREE);
 		rte_pktmbuf_free_seg(elt);
 #ifdef RTE_LIBRTE_MLX5_DEBUG
 		/* Poisoning. */
-- 
2.34.1

