Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90570F54ADF
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C6B940DD1;
	Tue, 24 Mar 2026 18:11:14 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
 by mails.dpdk.org (Postfix) with ESMTP id D964C40B91;
 Tue, 24 Mar 2026 18:11:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI8Id7rbBJuzCSm8crobPyI64g6mz8RmdyqEn72WehEZI8l68NDFSdImTnxnl08UbYnfTF9aTWpnkZeS+pidWOaSR8Ysh3c9etrtLPzlnM7iMRuwXCKj4GGv3tHv3yhhnavI7TPorFjqfxG1nf8a1cqWiVYnCBt0C/6gSbqZLFb5gKkzLwRJM4NJJEWpRVTdGY+XsQ/9AS4pZJ4+Ai7wFtj+M2nwvx3KzjEflH4yFM5Kk17ny4IZV5UsV2Ai7ReBHxsQ9g/nZPgCQq+XlY2v7HK/aRt0OneUfOH27ien/rKab5P30anCWCr3Eg2MHj7OviWUXNHLIk9v2EHYQ2pgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG4TYw7Iy4hPVqupK7z4eAkG73PbnHm3TiPfU0rRoD8=;
 b=QTJUKOo6wNabbNbSyDHfr3RK6lSyihhzEV53it4abSPDejAZiHVI25Wc1gcjMTr53HWvMJnMijR41pB7irk0UTnEbWpZI0buP+cT/mnJIujiik1Eru4I0Le5r2EjWlB16BfM2Zn410tUaLQ47W3OK2g6Xor7cCVH9NVoF0cRK9sMcbVZM/LyQ6rvAvCETTuxAE/GQPUN3Q6wV5Zer58sxcp2u4WqjmFbX+kvt2YoEvhUrttzZJ5xy9LbsqMZ0hH9a6sSsAhDJI1Xf98GhJKqzkW7Xj/uq3dBe8aS+tKnJqw7jYqDFBCR1sDs7ECdy/m3qtU81jeEQxRFGGuDs40bOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG4TYw7Iy4hPVqupK7z4eAkG73PbnHm3TiPfU0rRoD8=;
 b=RWUdW4MYtgvs+e82pfa0DicUrfTYDGszA80sIO25f7JJmNYopZj4QNUUv1NkhFracY/TiF+Mek5gJKErcBbIbX0VkwCGhGWCTo3G8nyaGMVLcYqiD6puVV/KVb4qoLCm6mq5snkNrwWT+Yx8ZM8CN4Bp0XDF68ls5hzxkJk4KSIGgj91v/NsbaFKuzJU5VgkT+bzYR44hyf/KCFMH6t3va34J7MpwYTgKx1rL2unp5L78Jq0BMPfdLkw53PfBL45PXYnGy5Xawz+uTciz6TybgBXl0/Z7UOM9b/2ctTs1lndfbzq6XSquIa29pHu59rgph1xaJrT0dzpasaHEQf6Pw==
Received: from SJ0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:a03:2ef::8)
 by SN7PR12MB7881.namprd12.prod.outlook.com (2603:10b6:806:34a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:11:05 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::55) by SJ0PR03CA0183.outlook.office365.com
 (2603:10b6:a03:2ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:11:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 10:10:50 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 10:10:47 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH 2/2] net/mlx5: report share group and queue ID
Date: Tue, 24 Mar 2026 18:10:28 +0100
Message-ID: <20260324171028.26727-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324171028.26727-1-dsosnowski@nvidia.com>
References: <20260324171028.26727-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SN7PR12MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d0fbf3-3d96-4161-e8f1-08de89c8557a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: oXq6PFgsnvlFC5N01SUYoNJV/7EXeBZ2jQs0wf4haUcI55BN6y4Gb8iaLYdYfdwGD3KP1J+JXlPXPu7+xVaUpOhrXZo17YlQ47oybgn/K9CvnuxTWVQDZOajN1RfSs0TrMsE24jiB7DWlWYWksvE1IxTJ0i8Ssz+jQPwEpevzlE8LpIfaHnnupXepkYB7kuv6XcKlCkSmH381r3Y5UHpsgFs4jvbNt2F9KieY+rBevevs9pGe6+Aes/pBDj7WuGZsMLHdCs45DrSTjTo0xIZgA3KKQLv8mL91rXZt12GCS7vb/qukb/JnvUXU7V3/IwzDZ5M6B7VhcLzWvHBViXt9EW+8IzJ5vR2GaEIkKyjQqDXqOIF7O3ShrWSKRzAvxE80eumGv0VjeIGw99ji3CrwRPK7tPTu7q4FInqnlT1xLbVy6AuhqGUC6uKNN2z44I05K3FwS/WD20KPz1wlMNrO2qPprw5vjuNWEDhyP4D+bob1St6crd/AoTmn5gkkHsY5UI7AIPsMCFsuFK/jAc03rxuxRP6nk2h/B+Veq8RubPDI8axj+Ebt7ZQ3Z/IxaR7W/OworOG1edPTUelZwPQA3vBfciNIw6J7dINWd/yNYz1cePFUfn3FP7EBlp8rcfA2CcsojzgAWiVAORv/W2kxUgwdtklRmcxR3EXGm3u3P4mC3fMqahbbAEdpO/GzuvcFzkkuX0fac3GKlmGto7l1wE2Y1bbe/HMOcNql5dcP+ZF2ysHw1JlYvwsiTdZ3CVepRCSgClSRz2UbiI8T90XpA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jsriPn6NtHCcUp/Mk/dpTJFH6xhM14Pb0WfseQ0G2SlhAJsITlLPfU45q40T0FmRD2PCvJ6+6Vb4Ikrn9iwCfw6TzgQYTTgTs00/FkCUohEzA9bIFc+fSKD9ZbMt7D28NtOAJ0E+FY5LEtVLqFzwT6YuZyVVA5UgTzCMIzQ58xaziEUfLnyfbxIoUsp91/aZ2pvJawtiq+r+YUDYii0mHaTMNo//b9OCUvMH0sFDpdRagtAJiONUE53VDfKcRbsshemagxltDtskHB59Ei1ss1R0YinQG/y4a0+2/EFJ7it/+DkSH0mFw4XdSFvfxCss0terq8lihMSe0ew1z0k9LrsStq+0Xltnie/jg7dAEuCVXNMM2EojzgJ9qJ/eJq2k1pVhDrgqjgxW1c5r315OYYOKoUUBr+aunYxSf+I27VXafKJ0zLeb9/UH4qBx4Ovm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:11:05.3392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d0fbf3-3d96-4161-e8f1-08de89c8557a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7881
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

Add missing share group and queue index to Rx queue info
reported through rte_eth_rx_queue_info_get().

Fixes: 09c2555303be ("net/mlx5: support shared Rx queue")
Cc: xuemingl@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index bc0470e6af..1f818f3c83 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -190,6 +190,10 @@ mlx5_rxq_info_get(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 		RTE_BIT32(rxq->elts_n);
 	qinfo->avail_thresh = rxq_priv ?
 		mlx5_rxq_lwm_to_percentage(rxq_priv) : 0;
+	if (rxq_ctrl != NULL) {
+		qinfo->conf.share_group = rxq_ctrl->share_group;
+		qinfo->conf.share_qid = rxq_ctrl->share_qid;
+	}
 }
 
 /**
-- 
2.47.3

