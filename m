Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E9606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lIBE9FL7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19600402D6;
	Wed, 21 Oct 2026 20:17:43 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013020.outbound.protection.outlook.com
 [40.93.196.20]) by mails.dpdk.org (Postfix) with ESMTP id 545CB402B3;
 Wed, 21 Oct 2026 20:17:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKteZ7thfCA0tTO6ho4pU8k+y4mCNSwWkMEKFpxsUg2bCMMf4S19o89fWH8wRB4IhBH53QUE+Sz2x3uqiVXLyxWkB/W8xHAev+BoglggdW2F/nWRe18rounFZUSt5oKBdlXuh+BcgdF/1jtgaGzgvqn2PagozNSGwibu8H50BbjkbQlJq/2OQyJlW7TgdC4Lrx9bYnu28aZ1yJakt9fz5EKn4q4akDB3JdT6IxPHhvnlQ6G5Br4T48pJHr/0sQIkmx7Vs8nQBt4AK8bkOF7Xoi0uy6MUClhffKg+ms066PvZDNbzqIWo196G2Em3XMPxOYJt7ZVUmceYpWmvCHywEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/4b7ZamWy3TpqFWJjfRAqbaMs1dxlI8mG5xgcVT2As=;
 b=Nss3dldJKxl0+ZKK06/xgaa1F0Xv/l2PJ83VNg/6+JfQOlIkzgz3S1UodVWr1n8yBTQ0MpIyycifqv4rKcoseIU4ZAtWjK2dDYvlOerL8tpIoTOYdcRa0KFP3Yc0g/jsrzwA4pZ2aGzx/8A3HABIj1yLEDsAuMy4XZ1pKM089i9wgaUG4GNOyZS8obmHJGnWGa+g15ilODGKs49iOYCqtCj1VL/QHCKzgZPdD07Rryp8+EcvAWRkj/d+qA0Dka/4USFFRezkjGVFOdRndkvcsDTwm/h0HMGNUGVlKWSUsCFrjrjw3+CejZAudKBrNv3w2WAQzjy6Nc502150zki0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/4b7ZamWy3TpqFWJjfRAqbaMs1dxlI8mG5xgcVT2As=;
 b=lIBE9FL7URWURcwVFw1MRyvBBV+nOt0rQ/oZMBZBGeGhVrFfr3dYTQf48HS0zmZ2E1YtfECA3a7pYg0Hy0eWzrgFyA2UiABhgstCkxE/a2+q/qtNqXRdkfJkKQzikGPaIG221Tw8DkSbxKw3Ut9kV6+H4YOmPY6dbTLjdtIKuXOoMSBm0fTcLYqIQ3pJ81suu0V7cgl2KV6Yt3Q/RdZ8TxEGyMvsz+aOBh4qa+Yp0bY7kxP3mmDndpbXPoqXOEzl3w1PjtsR4fBwLzdyul0dy2RAa8O0vKQ60UTrAajooAkTb4qkYjjd2KkcyvxsaauSwpzQ5W1rR95CbWpFOe09Ig==
Received: from BLAPR03CA0101.namprd03.prod.outlook.com (2603:10b6:208:32a::16)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 18:17:35 +0000
Received: from MN1PEPF000793FE.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::8b) by BLAPR03CA0101.outlook.office365.com
 (2603:10b6:208:32a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 18:17:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF000793FE.mail.protection.outlook.com (10.167.249.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 18:17:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 11:17:04 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 11:17:02 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Alexander Kozyrev
 <akozyrev@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix mini CQE compression format log
Date: Wed, 21 Oct 2026 20:16:45 +0200
Message-ID: <20261021181646.1385008-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FE:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: c37454d5-751c-4b5d-ad34-08df2f9f93f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|10067099003|261021123027099003|11063799006|261021135927099003|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3aqJP4Ca5hnGawdrpGstrvR+qj3rylLyhtCA4MopxHheFguhppHh+BbBz4S0vQP4pLp62FWIwA/wx9dl6CkjbSqW92VqiUl5dFxdZuvXgkuOrU08AsAIVOu0I23VSv5/pocbQxAgxFKVp3eDav3BPJHr9PSBUWgnWUkrbaT4qOZQ7+X/Pwr972ETwSV7p+h/CHt0e/esU+r4tqRBklvtaLT9JWqhBDf0GNRM+RHmI0TsdadorXo9YZaxjZ/WNqS3sVP4/3UxWPCVtztL9pqJX8E6d5TcIIa76fQYrFGx2vYHnA9qGuRRgtfPbsNk4gaZF/upiSAEA60fI/ZGM77KDOLnDMr5dNvmSg3kf3PW90WE6lOekCe+l3loN/x4Y1ZwBh7w81vZh60oZFSmsRGzSMiJ6ehmFuTwQsAL6aBKwU0oamAbPbH58VZI+IqAevkXLwbJWXvdFDowG1EFRxk9KLqUA4YaTvJcPLs7Ku3X8oGnoVeSveeSg8XOrGKxWZ1ZVVm3rlN/yPZpeVy7AGWGSoKSfy7UIEwwvlsr/2oHVEOPBQxRe6/sKE+rfnR424CTn0VOJ9cQxxUpOnjiHbzvmc6borbvvRFe/xNa9Iz0o40u5LaMdblUvRa9oyqVQdEjxyw29JgDZFWTcwgwZkKjvZ1H+ZhsBfG4UpV+krrCTvUS7Ud5q39alr2q57IEvXLYcR1C+2ablxLDm3q12c4zlQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(261021123027099003)(11063799006)(261021135927099003)(261009223027099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j0qko69G3/XTMrGh7lMf8R+eTgv0EEj861VhjToSAX09vVFGdJ4H9Bqjab+dSlGhVDG+bwuTIx5h1xnOFqrKbc5TeHhTb9IhxoF9075zxko2i/JFRe67M6wmIp9/tgqVYmLxj8SzfzJmmG+d9scVhx3uDUUjbW9cjQpbsGsN+Q13lNP2Mt9ypNlKmXBHGNMRCNJcNiF5DWHsoUl5G2+09ZDCX2ejwyAVkHNzYUV4cNNpTxq7oGRYQ5jW7kZpxuSiLWv+C9J68M9A1e+RH5toRcaUFwVGFLqeh6CwIZQy0TahZRuWeBFERbVF6OBBirREduUIOLqkl0rhs1bh1OTy1p760SB5kMvwaFIz/hFEPjuHqmNjXApopFO2y+VlgtjrpzOUZ3BHWsDWGbmxn41qvD4yb/v9ZJHBM0GXUD1bBYu3JHMAyGM/Pvc33auPN8MM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 18:17:33.6445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37454d5-751c-4b5d-ad34-08df2f9f93f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF000793FE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Configured mini CQE compression format was logged on CQ creation,
but not the actually used one. This patch adds logging of both.
Also Rx queue index is added to the log.

Fixes: 54c2d46b160f ("net/mlx5: support flow tag and packet header miniCQEs")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_devx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index 4b30a4fade..374d15a07c 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -478,8 +478,8 @@ mlx5_rxq_create_devx_cq_resources(struct mlx5_rxq_priv *rxq)
 			break;
 		}
 		DRV_LOG(DEBUG,
-			"Port %u Rx CQE compression is enabled, format %d.",
-			port_id, priv->config.cqe_comp_fmt);
+			"Port %u Rx queue %u CQE compression is enabled, format %u (configured %u)",
+			port_id, rxq->idx, rxq_data->mcqe_format, priv->config.cqe_comp_fmt);
 		/*
 		 * For vectorized Rx, it must not be doubled in order to
 		 * make cq_ci and rq_ci aligned.
--
2.43.0

