Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D39EC01BD
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:14:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF9DA4064E;
	Mon, 23 Mar 2026 11:14:43 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011066.outbound.protection.outlook.com
 [40.93.194.66]) by mails.dpdk.org (Postfix) with ESMTP id A1BB340268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:14:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2umK1P8MlgEBvhWRRjY/Ah9AaSx+oqhD8DbOd+jtUGjZOj7bS78RLz8lSNQZLKl1JLZIgIGfE/TBGvw98QgTQiZaO+aqF84F4irDHtXALWqBis5Rw3BF71F2x76lPPrjcC5HDz7EetSdQoPOg2dzm9wYubWRnSLKHUTii4LZ6+H9+2c0QHI38a0t/N434gUU64LyI6mEtKCxOLfSVh5+NbtwVJY7DdOICBOAIJZfXmdtzln7jKjE4RAuFp1S55yN3+egYnmHkOz7BGR4Rc9pP+p2x5iNM8G2Mmg/utPzuhRqHBzk6zgyB7dqRbynCLZ7ugAen7HiQUBFzOV/2qHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpQCJUKhtLahkbEDwqLAvqZb7ZfZX3diCPHZWHkEqvs=;
 b=evmSBzcXjlyNEBqINg4FZ9mkT8tMVAUB2lxchHNMKbQEgzlFEFPNQceICr9eg768fb5O0q4El5H8Aq6kAI4xMa5MLFz78MXzXT3l8QOWQ6AgqcX6ke1EH+ZpYgybJcRBBPlKyEdy4Q2xxPm0G7RZIJ/+s8+o3vQeyW3cmMh48KShhzv7BO7fZqy6omVzNcXnFA+c9ulKzqzBIoAiT0Fd7v65KMunn98hg1FGQBFyk1UCiU9k38Vx+2zGD6PDrCjPF66DEhdiK4z3nBk+1TOYhsQq5xEhy4Or5K32cHeVROA77zfZ3R1faiTFZEO7YhNuxV4bEcEbiLDFdcetjT8n/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpQCJUKhtLahkbEDwqLAvqZb7ZfZX3diCPHZWHkEqvs=;
 b=MEMakNRZySX4hll3s90NK3Ow0/QMxcsNcqoxdMns9ZU9eoYp44aw9CXzexj7EK5axYYiI47yX6wcjp8uaWcjiJt6xWKkb0cXXz9eoVHFM/WXhIuJIKxHop7Xh3JmXIBzmw1E66G9CYwl14GrC6WTWdxJo78dMeLgWuy8ROr5JpBlL5eYvXfP7Mk4wR3GZ4pJ2OAZDQ/OKl+YuJsAxmyXpVZmZAWei1oh/a3wOkr7+1DAuMRenAKesIDI4qf5QubQJ3uvFM3QQbJD5gF8po+fg9SOiNazEL0qXhAF5H5IQmrbkz2rR7gWBovr5lQVEwmZD9mhlYuP1LcqRIVtYSYouQ==
Received: from BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 10:14:38 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::4b) by BLAPR03CA0135.outlook.office365.com
 (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 10:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 10:14:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 03:14:25 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 03:14:23 -0700
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <dsosnowski@nvidia.com>
Subject: [PATCH] net/mlx5: cleanup unused Tx doorbelling routine
Date: Mon, 23 Mar 2026 12:14:10 +0200
Message-ID: <20260323101410.393887-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 0364a7e1-3b2a-404d-565d-08de88c4fddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: EcXnNRKmB7LNEhXHUIvtDUsvVoBz9EbnAtR5QjWFkxZnAPbdks1+uD3UBTG++Dn8fOJAWkCCnOp3Ste1+6ap5AT/If3wV1/ZQliSmt/9AgCTM26lnwauapn2mkbVH+SeToB/gOyE2M+FlW/A9rLgdPJKmJo/jb3s8z8vPOGN55/mHsH3i+quh2WS3s3EOsR86cmurl4pkrcsWaRCrddLeumbK69uYiXtX7IH8txBEEZZb8jNAszDZutOn6d1vsa1KZ83w1CXoyTngvwfhg6mpG6Tmk6/UtASzH+gNoBZEQizvhaRWyRc6LYNRmLVzOjKEhu5WdmMhtNDDZIYDpjtVnh0JGNk2Z2H/OOKhcP5h+QTmvB3+HEMaDlwZ+4IRVowHOlZUKUIar7UCunsyDA95fB8N5hWhQ7UA7Y13kj+Gwq6lQka8SPU4Vc768UJGu9vYLztOWgGBSA5PAiR07UznuVEVYmrfKFtWDdB6werVLZQP7Tb9dDSjKn7jO0/mdXi/uC3OgwkdBQroOHdBKILwFqxajyTMHq6EF7Iue+8IO0hXxNTnJrTkGjiIq+Jg9MXfxUUt17f3BmHLWessutjaLht4HozE4CC31eVTDs8J6CJn+Va1iT4+KlqkGfD7D6B+TeL0A2rmZfY6xZlwM7v1XNeTQG1O9SbjBoj+5aAezdujS5IkmkbASb4HcWUffPES6Dg9qRfKcPbGb4NXvsBaUTtRT3Zl5ohPEocOxn7OYVgwvY9ftQJyvF/803c5E+3tJbCvFBEOL36AL0BoFlNyQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rfRRAON7h0NngS8IWJih+j6bQYZhSzNXtvbegN/i7hH7AaVFNL33WbQc86CuEN/TD8g5QxQZyzHk/L6Tx9cWnYVegW6UAhzyE97zYpcxRYOs5NsW1WxucCD0ibQcFWs/jdSpv3G4w/PTH7Kev4H5zLkw+2jsBDHIh9By/P40ZjQceaVLNkSEzxKkBerqkVYLSaa4x+jFXaeJUO3GY+1SjhAv69/rxEhVSfKnPGK1bz1elrS/AmK5lePFcOj4Hsk4oaS5Ggn6VyWT+RWG/twQ48ifkumgthlEbY6LioiQZQoqzg4mXh0KYJkVk6L2U6Rc9ZcpNy20GH7eds2yWVTOz0MTyliN2HEdcifbuBtfbGjN8Iy7vF8kpejZAy9hmL1Z9R5gTMp3blsWfyG+fPDBxNvYaYnvMgzey5a3Qz9pyA1OcPD0GvfWE8naEZlJyvRS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 10:14:38.5495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0364a7e1-3b2a-404d-565d-08de88c4fddd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
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

The mlx5_tx_dbrec() was replaced with common mlx5_doorbell_ring()
routine and is not needed anymore.

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_tx.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 48dbb2d867..016dba0b03 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -301,21 +301,6 @@ mlx5_tx_bfreg(struct mlx5_txq_data *txq)
 	return &MLX5_PROC_PRIV(txq->port_id)->uar_table[txq->idx];
 }
 
-/**
- * Ring TX queue doorbell and flush the update by write memory barrier.
- *
- * @param txq
- *   Pointer to TX queue structure.
- * @param wqe
- *   Pointer to the last WQE posted in the NIC.
- */
-static __rte_always_inline void
-mlx5_tx_dbrec(struct mlx5_txq_data *txq, volatile struct mlx5_wqe *wqe)
-{
-	mlx5_doorbell_ring(mlx5_tx_bfreg(txq), *(volatile uint64_t *)wqe,
-			   txq->wqe_ci, txq->qp_db, 1);
-}
-
 /**
  * Convert timestamp from mbuf format to linear counter
  * of Clock Queue completions (24 bits).
-- 
2.34.1

