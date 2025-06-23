Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4115C77B7C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 18:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBA5D40659;
	Mon, 23 Jun 2025 20:35:35 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by mails.dpdk.org (Postfix) with ESMTP id B9BA640657
 for <dev@dpdk.org>; Mon, 23 Jun 2025 20:35:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ce1E/UBbGRMd33LcDpURY3rxP7uq08ybR6Y1pahMMbTbHuQCGU9fNuFCcyn8iVA/6SuDOWVNN95QI8Jgw6PJuTZ54Wq826V43pC3Z9GZwkjXfnuEV6gEJoA87tT/jhjinpUKEgMKclu6KSfoCaIoLsScNqqRwZN3TwyKM7d/J8pgfiwPxbIJOhJkqgQSM6CwlyMr7MTh7hunXKiUPlWih0r9G7lTnV/jm/oxKLbMuazd1H9HkzoAGPnAU/rVINY4xiJwjElvVslgXUzg+ZFsybMb0nWeqlymxIDiUwBmHkgtw3AHQruwCD7iiVgvfdtOe/fAwT3rBkj10KChHrYl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXKlk4gAejk7qrwuCELoCvy3wl6wor+I0QclGNVG3To=;
 b=qtArUleUucMQiTTJTIRHih2NniVgreX/tuMMaTvzfF9psCKQquu7zO1YPdQpDtOq0Y1ifNtIbddOCOntIOgB0cc7IXpG7eDkZ8OAMJATepeInY1+KztZO9FR4ryNaMEDMM+t9gv15asiMZZmVAFvXdgK4WMAygavjwppgS6FBE2xVim/W1fEhe+y3ZNsq0iW1UUdUM2jz5bFNN/6Y05KHbFnIVM5gi91EiEVJmBiJK2WYPttggESpst3Upg1TDH/LJUxl9RsI9U1bcNQwaZoSaHMtMYVWfSrsRmmi71Y1WbYJLvZP4WwEQV4ghoZD5JU4B4j7Bjj5IOUTuWDmdrL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXKlk4gAejk7qrwuCELoCvy3wl6wor+I0QclGNVG3To=;
 b=BXKuSVQWmT21DcPHrDcbYMnv3cqqr2c0GgeWtXR87gzymDU1IoME9LV6x2G05HrAA7IXYZZg9QLgIVDpKmWGJ5aOWHXZ8WYmwujkqTeOH6VD39P7MpiOHreImJ3ASundVnB5LxFF5Ib7S3jNpklVXceKip1yr4u81CRcyaGsxkiyBt6hRFwm3QpEbla6jXQdqibxuPfXKVeGVCN4olgEi9tH54i0XzrSemXvPEl/AqPuR6roPRo6F+gFLB/ocdOkBEzctQblfn5slXpq/5mANb4k9tU8Kimv/VZOD1hUpPr2oywGjdi8tLo3EkWI9d+hPRw/5boLRTzO1Bm11tw7qQ==
Received: from MW4PR03CA0322.namprd03.prod.outlook.com (2603:10b6:303:dd::27)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 18:35:32 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::4d) by MW4PR03CA0322.outlook.office365.com
 (2603:10b6:303:dd::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Mon,
 23 Jun 2025 18:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 18:35:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Jun
 2025 11:35:16 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 23 Jun
 2025 11:35:14 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <matan@nvidia.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <dsosnowski@nvidia.com>,
 <suanmingm@nvidia.com>, <rasland@nvidia.com>, <viacheslavo@mellanox.com>
Subject: [PATCH v2 1/3] net/mlx5: fix the WQE size calculation for Tx queue
Date: Mon, 23 Jun 2025 21:34:54 +0300
Message-ID: <20250623183456.130666-2-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623183456.130666-1-bingz@nvidia.com>
References: <20250623173524.128125-1:x-bingz@nvidia.com>
 <20250623183456.130666-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e7e5eb-0fc3-4319-4bca-08ddb284bc14
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gNbyJb0IoQObJxUMDEbyRwu50yRvVDjB8G6r6/DNyTndK6FwBfjdjxpXfvP0?=
 =?us-ascii?Q?T2yfleqhafJVUkfJ8nwv6q2A5DkkcC/nY/JzQMHKGIJZYbyn0yKrETyTnxA3?=
 =?us-ascii?Q?XAA0lGV8bgUDju3Zgg0caM6jU7p7zsuqHdUK5LvYLAIB04JTW1mMfIyHyB5u?=
 =?us-ascii?Q?71NZF+W3fjOJ8ClNj2mz2R3H7EM1jfJrBy1Jgi1Jkhbl+R2E2D/bQ8iAlBzb?=
 =?us-ascii?Q?euCWvr9lnXqVM7utdA4Sxa16vm0bJf87U+h3oiiwApZNnohgURxtFbZzNTq8?=
 =?us-ascii?Q?CAIzBkR33FABnLiwm8lu4q9cTQNJv66uei4Nuwk27QCDXEiWUYbYt0XGEHp6?=
 =?us-ascii?Q?V5Fq5V5mNAoGq1Oia3wirnEjS7Nqizgsox3asqwPOCRptWdHH0rXEuDsbLh+?=
 =?us-ascii?Q?ZlMN0WX5sWiph14TPoUadT2yqOKD7Asnao59ZF+yhv4bk4BUX+Z1kpDQEiRc?=
 =?us-ascii?Q?2MZp+f//miNj0WATCDlnNEAEgQbAO2S5wwlulXZcVBB+6R300GyiAMNkvKnr?=
 =?us-ascii?Q?zE+82HK2G7DDm2kUXRdreGLEISmhvG45VwRqTtBPL8GCO/Bsyu/oM33ISzT8?=
 =?us-ascii?Q?BamGS8qI8WaHrEGaqVFKtwUc6+hNY9ylcD8FxU8RYqJ9Eeucb3vPtJbdtqWT?=
 =?us-ascii?Q?4lhHelSWl4YTirZv/bp41YwGbiT984yaTmN34fLNhq/h88Aj8Hqt60CR8GyT?=
 =?us-ascii?Q?C1pLVLWVFdh1YvXleOMWt4AsGA5Raxr+KHUbcEGyo+4ugu8VpRBicCmi1rE0?=
 =?us-ascii?Q?tpLHilo4CGUzhxW+u8QnFdMyBAkHuMQO22eunDvpEGu02UNRw49Q+QrToNED?=
 =?us-ascii?Q?hwTYn0UpNMdB3ZXHpOqhYI/fuuMQZh68E0RqjtE1byFNWigf/GRuqz2utlhw?=
 =?us-ascii?Q?IO6Br14hk7ihGsoJtQdiuzJCSFZkQWL9AsphUgUusENQWktCZMPS/8TRflX6?=
 =?us-ascii?Q?/wfSZc3fSH6/CroqUSIIFvEJFm+8YIe+FjdvwKFTeUsXSCUjMPitaouutd9y?=
 =?us-ascii?Q?Sdl3YemUqFsGx9oNxpfg67IR2eoHla2NV9EE1PmEY3LilxkM/vHsYw7n6+4v?=
 =?us-ascii?Q?DDM9lPgYK7fs69jsR+krf1JX9CmJtg6OE20PyON6YQ1C00fT9vpwpxePfU4w?=
 =?us-ascii?Q?UM7coNL/TdR6mUY6Ol9nXpaITO71DA3a4XWrkO09LPDu2Wccie7F/O3LOc8d?=
 =?us-ascii?Q?gnaJC33UetyMeR/8EGf3HhbNWyz8HXxlLJhySG0/ByX37Q+aQKqbp9GXvvTO?=
 =?us-ascii?Q?4iUv3qdgrlxud9Y9tEHRT4ilYGlX2k0+gvId+sqwtxCZurVGxYsQSs8pYIW/?=
 =?us-ascii?Q?BP9GxuBZWaPb9rgbVC6KuZY+hIP5j8t6yUdCvXpqi4kNOuLNw0dOWAM7ggus?=
 =?us-ascii?Q?dUsW7hNDKgLk8xGP/LfHctxh5SsivcwOLN88ZCDKr/BTSsUnXcGhmVZA8Eir?=
 =?us-ascii?Q?1qZJBESltIfJDF+sLngAg56MluJVed2GBsAaNGSC0LUpzV10Jwpbzulu1cJ7?=
 =?us-ascii?Q?bkGxBtvshsoq7gCeInKkLUFIJwkIpRefljbf?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 18:35:31.7208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e7e5eb-0fc3-4319-4bca-08ddb284bc14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
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

The txq_calc_wqebb_cnt() should be aligned with the calculation in
the function mlx5_txq_devx_obj_new(). Or when the input descriptor
number is 512, the WQE size will be wrongly considered to be 30 when
no max_inline_data is set. The total number of WQE will be considered
as 256 and that is incorrect.

Fixes: 38b4b397a57d ("net/mlx5: add Tx configuration and setup")
Cc: viacheslavo@mellanox.com

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_txq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 5fee5bc4e8..2fdb472ab3 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -706,9 +706,15 @@ txq_calc_wqebb_cnt(struct mlx5_txq_ctrl *txq_ctrl)
 
 	wqe_size = MLX5_WQE_CSEG_SIZE +
 		   MLX5_WQE_ESEG_SIZE +
-		   MLX5_WSEG_SIZE -
-		   MLX5_ESEG_MIN_INLINE_SIZE +
-		   txq_ctrl->max_inline_data;
+		   MLX5_WSEG_SIZE;
+	wqe_size += txq_ctrl->txq.tso_en ?
+		    RTE_ALIGN(txq_ctrl->max_tso_header, MLX5_WSEG_SIZE) : 0;
+	if (txq_ctrl->txq.inlen_send)
+		wqe_size = RTE_MAX(wqe_size, MLX5_WQE_CSEG_SIZE +
+					     MLX5_WQE_ESEG_SIZE +
+					     RTE_ALIGN(txq_ctrl->txq.inlen_send +
+						       sizeof(uint32_t),
+						       MLX5_WSEG_SIZE));
 	return rte_align32pow2(wqe_size * desc) / MLX5_WQE_SIZE;
 }
 
-- 
2.34.1

