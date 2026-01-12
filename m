Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30A0CF45B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 17:24:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE79340281;
	Mon, 12 Jan 2026 18:24:24 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
 by mails.dpdk.org (Postfix) with ESMTP id E048240041;
 Mon, 12 Jan 2026 18:24:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrtpxTs1v1hiEqGHxfI2SKGB83bniYOKzZM1tZU7op8bs9mqUWpgRKDqxV+6BIdMQgOsuIeSFXu6fKQFUQKBvp8qPkSdsLKsoQfemeKWqnfifFtqiOC1mPXwuEXu/IWbf2lDUqxPB994mtKMF0fafcfg+DzLSWfBwaqOP/bvR5aKVqx1UsLAM/AeIhv5PbNuafIbdZj+q67qC6H3luwjLPMs8PDKWZAp8U7rLLS0A1JVKi5g1NlQE6ugCtTaLaUT8H6rtjoCrBbNv/E61LlFGKIrOBTOcL5y4NgnKZMzLki4Zvvvj8Pkpec2v4NU4Q/r1TI3oiTu3Go6LDwdb/viHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=742fbyeHHMW0N+HmMP0g3729rFdXXM84zzkqndn2Txs=;
 b=Q0n8a3U48iHYKOKTgIcBrp0b6DEvytLRwdEtr47Z5SN40G4XL+2vrEJdvdLTHzmxiLAr/yCquYZxCpVyaI+y7DJevXbXmob/ENT+7t64FNWGtQMWQgDkKsDi4j1hPtL3ETHjvwTweRD/MaxtN6tmYQsM8G4GI+D/zAUhRRUhqXbCHelsPGHD/2RSujgfdcVbJpTABdly4wd+ZyI4aYviG4j3deVBjVYj/UuVi2eiowtOSz4X8BipCayWWfwN4IPEpEusjzi8bCBPOlUdEFJZUTFuuvou6crnygsRSia5GUn1tdx6x2Y0icFVZF4D3Yqk1OuoU2aRd3L7XFHXtx78xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=742fbyeHHMW0N+HmMP0g3729rFdXXM84zzkqndn2Txs=;
 b=DW2XWA+YPBeaD+HkLmlKY+fqwxb+a0D+1l+FlWgIamYWxzDXI1psHWSg+QZuHFVRlvsJVtNv92fbXMErPtSHB3Vy0u1ZRJjGcmv2W/ZEKayHwbjGr1P+ezUmZ+bX9KSJk2Kv2VQSkc43LWvr7ML9KPuAUtlrFsfktxGU25ejBA3fnyvZRsno522POeWH0rcOTR9x46/WF+WxI5TQWFSVTSzX2vvDChR1t6gTfg2dLGVeOdNm0fu/8cN2U1UfxQFzXGakUT4aTizP5bmHK6YK/M8vl+Y7BYy2wQnbDz1IuyLfn/TmOmMp2x4ESzJGKJWX/lKoxXUgNp11UTvovpmj/w==
Received: from CYXPR02CA0033.namprd02.prod.outlook.com (2603:10b6:930:cc::8)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 17:24:13 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:cc:cafe::22) by CYXPR02CA0033.outlook.office365.com
 (2603:10b6:930:cc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 17:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 17:24:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:23:50 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:23:47 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, Xiaoyu Min
 <jackmin@nvidia.com>, <stable@dpdk.org>, Mohand Alrasheed
 <mrasheed@wirefilter.com>
Subject: [PATCH] net/mlx5: fix HW flow counter query
Date: Mon, 12 Jan 2026 18:23:24 +0100
Message-ID: <20260112172324.1523241-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c95e37-b4eb-47ca-38f4-08de51ff6798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r3FKKmSVv9Tut+VOtGVyYto0/nlQV+wpox/xZGPQcZL+Dwlb6lQEv7Ee+Gt8?=
 =?us-ascii?Q?bnlFSxoKEumjF3/qf61swQ88pjJZXaiD0bcyL96irYJ+FxW+LhSe4F/zSJdc?=
 =?us-ascii?Q?ddi0kicKIQ58BajrGrg5D0gCIOVsuMNZq1mykDDOV5i28Zi4QHdLAQFjySlX?=
 =?us-ascii?Q?TF3eoAHJjU302xue1zvDacJU3MwsNbCAUcwn0MkDmeJ1KmdG5+1Rkt/Q87hg?=
 =?us-ascii?Q?xdeRhYDPQF1+VmLSscceqST5CO5v9eY7Qyjd4jzKX4NeLLr6aElDKETVMsFO?=
 =?us-ascii?Q?+6asylc1XAXSkmN1XY042lulWU3z22h0G16kpuhBPTr70S7gy1IubVv0C3wy?=
 =?us-ascii?Q?4DgiRVSXB0KN0hH7qRMB1aSHgqNoHZfXL2zO+RByuNdN9hl/3yhWPq50ItYL?=
 =?us-ascii?Q?r5rCQZqK6PTMKXSAl23bgBmvNjqRfqa2WSF3T9ou4iSzYSeVcvyhGzacU5kc?=
 =?us-ascii?Q?llq2mLU4X/jnKTKrL/SixOF09XDijNxfxqvbonrGV/yJ34zAXTRzo4i/Eo7J?=
 =?us-ascii?Q?Uzx+OJKCamORXjChooA5CDZETQBOkTdUp83QYCBu6u0+YJ2w1RJEL9NogJkN?=
 =?us-ascii?Q?b3O0WQBSlXiFYDt73Rnkqfict0Z5YpGrpY2jvok3bk58lynb5SYqtXXlgKc6?=
 =?us-ascii?Q?Q1S5sXOaSIhoV5R3qvgmMUCq4dQlmzzoYeooR5+5LnVvZP0b2HFBxrpJt1jP?=
 =?us-ascii?Q?uS6geEUCU0E2B5e8wbkSLNJpPnflYKBc9nZhOZle+45IeY4YeBeAqkzUfacE?=
 =?us-ascii?Q?j0/Tb8l/g/PPybLJ8f+oreckTsPixCBeKBb5cXMrOyuZ1/Re6vqGavBba80X?=
 =?us-ascii?Q?NzmGx+lwDaeYyMLXlSy9CtXbKtgf8i6earTK37ZtPsWV/1ntnMr9I4o5DA0h?=
 =?us-ascii?Q?DtODWeBDFoT21T1uwDaLfmRisbECIilGP9JvUY7hj6MK2N6KtSuDZRmKQYY7?=
 =?us-ascii?Q?nvatF2l+bSKq5suk9vPT41ddLI5tKe2qa2ITmhDU2TiOpmHh4BMGW43/tUfw?=
 =?us-ascii?Q?prmIEuiT5yo86Y1x6xAtzWqDWRj5rMyjCT3yb2jfSRtB4xOUQL7CTUC8c02k?=
 =?us-ascii?Q?xVcrSW9IpfFFQnCPTQQYuZa7yumCyHEZA5P/hHL5e/Wq2etdohsZAm/Hm0An?=
 =?us-ascii?Q?KahTG/TrMG2qaH7ymQ75EvlpFtfntT5gBg5SNcEcjgyhLJ0NGDcxiC7ZPQQJ?=
 =?us-ascii?Q?WafHF05AfzmsaFHFLUzJ6sNETLzlvu/28A3QkVIi2sQ5ueAq7CqGOFpHpWgn?=
 =?us-ascii?Q?wuW5mg6Vt7wpnrO9v3//vDXZCzOZuzCZoY9ZJaMdvHJb2/HJmqcOSq383+qo?=
 =?us-ascii?Q?K4MeyBzfmaJ4vikZY4lp4pDFBjK7Xzcz8VEOn7ms/XW3sulaxHX/7I6whgbZ?=
 =?us-ascii?Q?9CQE6noF85KLdbQ7pRtI5hYjydCgAHi3/01Vqcb9NU+dpetPk1DQfYxQIG3F?=
 =?us-ascii?Q?xLU8YMsXbUIEflMtoSnwMnSD6uPDdyFhEXA6udt5ScSldmfjltLoaMThP+vH?=
 =?us-ascii?Q?ZO+iiVOyt49Yur0AULiTP74o3c/c1DHHtn5Rb+1NX1Xe90/yPWdBGbXvmubN?=
 =?us-ascii?Q?hcoQANgAy+8IGnStuc4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 17:24:12.8319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c95e37-b4eb-47ca-38f4-08de51ff6798
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093
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

From: Xiaoyu Min <jackmin@nvidia.com>

There are a couple of issues in the logic used by
counter service thread to refresh flow counter values
in HW Steering mode:

1. Flow counter offset in bulk is not taken into account
   correctly during query.
2. Number of WQEs used up during query is not tracked correctly.

Regarding the 1st issue, HW flow counters are queried by posting WQEs.
Each WQE queries 4 flow counters at once.
Flow counters are addressed by base ID (ASO object ID)
and offset (divided by 4).
During periodic counter refresh, mlx5 PMD fills whole queue with WQEs
and waits for query completion. This is repeated until all known
counters are refreshed.

The issue is that, between different iterations the base offset was not
adjusted. This lead to the same 64k counters (max achievable through
single queue) were being queried. Any flow counters above that limit
would get incorrect values.
This patch addresses that by adding proper offset calculation during
query loop.

Regarding the 2nd issue, tracking of how many counters were really
queried during single loop was incorrect.
In case when there weren't enough free WQEs in the queue,
fewer counters were queried than expected.
This mismatch was not taken into account, which in the resulted in some
counters not being queried.
This patch addresses that by adding proper reporting of the number
of queried counters to mlx5_aso_cnt_sq_enqueue_burst().

Fixes: 4d368e1da3a4 ("net/mlx5: support flow counter action for HWS")
Cc: stable@dpdk.org

Reported-by: Mohand Alrasheed <mrasheed@wirefilter.com>
Signed-off-by: Xiaoyu Min <jackmin@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 .mailmap                         |  1 +
 drivers/net/mlx5/mlx5_flow_aso.c | 44 +++++++++++++++++---------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..0f537306ba 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1108,6 +1108,7 @@ Mohamed Feroz Abdul Majeeth <mabdulmajeet@marvell.com>
 Mohammad Abdul Awal <mohammad.abdul.awal@intel.com>
 Mohammad Iqbal Ahmad <mahmad@marvell.com>
 Mohammed Gamal <mgamal@redhat.com>
+Mohand Alrasheed <mrasheed@wirefilter.com>
 Mohsin Kazmi <mohsin.kazmi14@gmail.com>
 Mohsin Mazhar Shaikh <mohsinmazhar_shaikh@trendmicro.com>
 Mohsin Shaikh <mohsinshaikh@niometrics.com>
diff --git a/drivers/net/mlx5/mlx5_flow_aso.c b/drivers/net/mlx5/mlx5_flow_aso.c
index feca8c3e89..5e2a81ef9c 100644
--- a/drivers/net/mlx5/mlx5_flow_aso.c
+++ b/drivers/net/mlx5/mlx5_flow_aso.c
@@ -1851,37 +1851,37 @@ mlx5_aso_cnt_queue_uninit(struct mlx5_dev_ctx_shared *sh)
 	sh->cnt_svc->aso_mng.sq_num = 0;
 }
 
-static uint16_t
+static uint32_t
+aso_hw_id(uint32_t base, uint32_t offset)
+{
+	return (base + offset) / 4;
+}
+
+static uint32_t
 mlx5_aso_cnt_sq_enqueue_burst(struct mlx5_hws_cnt_pool *cpool,
 		struct mlx5_dev_ctx_shared *sh,
 		struct mlx5_aso_sq *sq, uint32_t n,
-		uint32_t offset, uint32_t dcs_id_base)
+		uint32_t stats_mem_idx, uint32_t aso_id)
 {
 	volatile struct mlx5_aso_wqe *wqe;
 	uint16_t size = 1 << sq->log_desc_n;
 	uint16_t mask = size - 1;
 	uint16_t max;
-	uint32_t upper_offset = offset;
 	uint64_t addr;
-	uint32_t ctrl_gen_id = 0;
 	uint8_t opcmod = sh->cdev->config.hca_attr.flow_access_aso_opc_mod;
 	rte_be32_t lkey = rte_cpu_to_be_32(cpool->raw_mng->mr.lkey);
 	uint16_t aso_n = (uint16_t)(RTE_ALIGN_CEIL(n, 4) / 4);
-	uint32_t ccntid;
+	uint32_t bursted_cnts = 0;
 
 	max = RTE_MIN(size - (uint16_t)(sq->head - sq->tail), aso_n);
 	if (unlikely(!max))
 		return 0;
-	upper_offset += (max * 4);
 	/* Because only one burst at one time, we can use the same elt. */
 	sq->elts[0].burst_size = max;
-	ctrl_gen_id = dcs_id_base;
-	ctrl_gen_id /= 4;
 	do {
-		ccntid = upper_offset - max * 4;
 		wqe = &sq->sq_obj.aso_wqes[sq->head & mask];
 		rte_prefetch0(&sq->sq_obj.aso_wqes[(sq->head + 1) & mask]);
-		wqe->general_cseg.misc = rte_cpu_to_be_32(ctrl_gen_id);
+		wqe->general_cseg.misc = rte_cpu_to_be_32(aso_id);
 		wqe->general_cseg.flags = RTE_BE32(MLX5_COMP_ONLY_FIRST_ERR <<
 							 MLX5_COMP_MODE_OFFSET);
 		wqe->general_cseg.opcode = rte_cpu_to_be_32
@@ -1891,22 +1891,24 @@ mlx5_aso_cnt_sq_enqueue_burst(struct mlx5_hws_cnt_pool *cpool,
 						 (sq->pi <<
 						  WQE_CSEG_WQE_INDEX_OFFSET));
 		addr = (uint64_t)RTE_PTR_ADD(cpool->raw_mng->raw,
-				ccntid * sizeof(struct flow_counter_stats));
+				stats_mem_idx * sizeof(struct flow_counter_stats));
 		wqe->aso_cseg.va_h = rte_cpu_to_be_32((uint32_t)(addr >> 32));
 		wqe->aso_cseg.va_l_r = rte_cpu_to_be_32((uint32_t)addr | 1u);
 		wqe->aso_cseg.lkey = lkey;
 		sq->pi += 2; /* Each WQE contains 2 WQEBB's. */
 		sq->head++;
 		sq->next++;
-		ctrl_gen_id++;
+		aso_id++;
 		max--;
+		stats_mem_idx += 4;
 	} while (max);
 	wqe->general_cseg.flags = RTE_BE32(MLX5_COMP_ALWAYS <<
 							 MLX5_COMP_MODE_OFFSET);
 	mlx5_doorbell_ring(&sh->tx_uar.bf_db, *(volatile uint64_t *)wqe,
 			   sq->pi, &sq->sq_obj.db_rec[MLX5_SND_DBR],
 			   !sh->tx_uar.dbnc);
-	return sq->elts[0].burst_size;
+	bursted_cnts = RTE_MIN((uint32_t)(sq->elts[0].burst_size * 4), n);
+	return bursted_cnts;
 }
 
 static uint16_t
@@ -1949,7 +1951,7 @@ mlx5_aso_cnt_completion_handle(struct mlx5_aso_sq *sq)
 	return i;
 }
 
-static uint16_t
+static uint64_t
 mlx5_aso_cnt_query_one_dcs(struct mlx5_dev_ctx_shared *sh,
 			   struct mlx5_hws_cnt_pool *cpool,
 			   uint8_t dcs_idx, uint32_t num)
@@ -1958,7 +1960,7 @@ mlx5_aso_cnt_query_one_dcs(struct mlx5_dev_ctx_shared *sh,
 	uint64_t cnt_num = cpool->dcs_mng.dcs[dcs_idx].batch_sz;
 	uint64_t left;
 	uint32_t iidx = cpool->dcs_mng.dcs[dcs_idx].iidx;
-	uint32_t offset;
+	uint32_t bursted, dcs_offset = 0;
 	uint16_t mask;
 	uint16_t sq_idx;
 	uint64_t burst_sz = (uint64_t)(1 << MLX5_ASO_CNT_QUEUE_LOG_DESC) * 4 *
@@ -1978,12 +1980,12 @@ mlx5_aso_cnt_query_one_dcs(struct mlx5_dev_ctx_shared *sh,
 				continue;
 			}
 			n = RTE_MIN(left, qburst_sz);
-			offset = cnt_num - left;
-			offset += iidx;
-			mlx5_aso_cnt_sq_enqueue_burst(cpool, sh,
-					&sh->cnt_svc->aso_mng.sqs[sq_idx], n,
-					offset, dcs_id);
-			left -= n;
+			bursted = mlx5_aso_cnt_sq_enqueue_burst(cpool, sh,
+							&sh->cnt_svc->aso_mng.sqs[sq_idx], n,
+							iidx, aso_hw_id(dcs_id, dcs_offset));
+			left -= bursted;
+			dcs_offset += bursted;
+			iidx += bursted;
 		}
 		do {
 			for (sq_idx = 0; sq_idx < sh->cnt_svc->aso_mng.sq_num;
-- 
2.47.3

