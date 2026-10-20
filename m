Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A71D60A263E
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eD9ZqNpl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B1C540283;
	Tue, 20 Oct 2026 13:59:25 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59]) by mails.dpdk.org (Postfix) with ESMTP id 7D77C40144;
 Tue, 20 Oct 2026 13:59:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlNw0Cgom8XHEWlrdN/HDA6U+tfmGLO7KWD5UVm9YF+pkUyxKAS6duQayD8DF2XQ21nMN/PuZZaJlql3/mxEEYa+WP7Bp+/Xn5SQ3ziB8yoijceTtXSo1dPkClT3OVqHAM730BcArfwSwie2kT9nqO5DecgEl8mp5DxqFQm+l8iAUgmUcplnP6TLCTKfCClSVDzkDc0LwmarVinFLj4RvlwxrRB5lgX0oX0gRC0Mzn6W6KFCDPRiH5MrvXlSMtXQW7HfZ7hi10n7EsmxrTSQhFa/oTz4Wm8Kp58poA3GKKQdL589q0G6O4hw6oXX8AFCshVann4YopDjLHxuQe2Y3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jP4K0gAyB9vg3gzR55d7nAifx5D9V2SUJMlWhZbDM1I=;
 b=VlzcRqzQNCz41tePjNyptxcs1cHLGOc/uliGmF3HO+gR7WVc+1sWVCKh/gQonfKE3Qz3N7JaQALk8fLUhNwkCFG0rvmHwmiVzgqGisY9LOz/AR+j0U5BJ5jXys9GG5djFE1US1QqaFPy2nXT1f/SrgUZQfrhsaKY16vRY5Qe2VphwZb9P2qn1UASDBh88GXbhOoI/juFGBkE2u4hXf927abS1uOZWnQrfxT/RjIR6bSyh1VqmLLBWBIhRCpT0xjqZ7qT+n8CwsIBWtAyXXTaVPqiWQgQgD4l4nkVp0J8vsQ4WJ7S3vgtVbx7OuLYQEIVUCAapdDwkc4v7V3F62mHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP4K0gAyB9vg3gzR55d7nAifx5D9V2SUJMlWhZbDM1I=;
 b=eD9ZqNplTEd/iWiJopW/mInX5AkSMIJK9HVpT5WZgoIrFJxVHjWSM2W9yOf5so+6jWEvwuO+I+Fx1PGdm8X1CPKOdFenGAaOtZvzEQZ99gDOU3H9OZlFbxh7BweiRPrQho0Pvk4McTV9of4SVCOBH+UAthxTn5CACw3UAG4VLmwR5OejjZEcKsY4+NBSTBtbzlvxZQE/K6dSlbkI5niSYj3buDKyP8cInILpYABqN4FGROK/uPY2BNyUYZT4q4PmHe/4k0xQL3PHgDV3FTCWqmXoQ4Dy0oru4Z9ipu0Zgz9g2yQhsRiI8TUrZufshiUnzpYOAeVabpG6dk4GCqFczw==
Received: from SJ0PR03CA0159.namprd03.prod.outlook.com (2603:10b6:a03:338::14)
 by CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 11:59:20 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::47) by SJ0PR03CA0159.outlook.office365.com
 (2603:10b6:a03:338::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 20
 Oct 2026 11:59:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 11:59:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 04:59:12 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 20 Oct 2026 04:59:11 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 04:59:08 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Banoth Saikumar
 <banoth.saikumar@oracle.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: skip DevX Tx memory allocation for Verbs
Date: Tue, 20 Oct 2026 14:58:59 +0300
Message-ID: <20261020115859.96750-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20261020115859.96750-1-mkashani@nvidia.com>
References: <20261020115859.96750-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: f828512f-50a8-40af-8f46-08df2ea192e4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|5023799004|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 3XRpDikcGYSmgPiULful0nXZaciwzdBH7GEAV3bwUIACXWEOxmJGJ4Ejlj/ada4yK0dxnFlJtC+AvzdF5PdnNLhv6sgixsMUTIzBQGtk8E2HCwflDZ9DWa0rCEKLemJ3c/eJdeHL2U0InEzpIM7N2IvsTAP+TvV5YWz3BVwjjZOxmrM/6B1l7AtYMgbmRKDYtHwtfQoknLlKcEjm+fwVmXOTKeUKhTFjBZ8eKswI2uo8UZtX8PcM/g2Wiw/uZLw2uXdfP3Wep/lx62heZOTMbDFcnTRF4kX40xumrwSlI5PIOxXtKabpQ8AzLDArdQxLRo4RlwYNTM+0xY2TLaXfS36zH0mcHT3tLB+epiiHnqLq1VIlqeG8SuqUj1z5NIbiTJeXHJKvo7VEbpa/qepzsce1Z0L9mH53nzXH5yBvvwR3cAFAlktBSGLSQK1JYCTR8erK38niWjeDuHIBkrRie+3QvJelwD7k2ReqQ6qMwD2yzgDQuzA1d9gYBmFbILkQ2jpfxRcfpHn35MaWipIrWjTMiMngePb6giLd/tUsKho3fpy8dmkRMyukcvXDqHQXD+FFF2OUfcR2/jEqF39VpzWXp0fC0A9eFBCSuittKYibXqtaeYpzRRZOagLqBsvT8UtUYuBObmprF1xT8/sfSAW0dntGjsEgRkZS0PaPD619mfjhgbo8mkojQmxGK8XK8GCCY6FXFda6Ni7PE/mZUQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Anys1lXJjwckdwQdrGobNFOSGP4zw1twT/mqGuoCHMr3P1qKmTlWeyogWgQLTC+W3I8/gjru1Qea/CWgc7rHzPnNZFAh+8PbEVmIkvBJCQhSgTs9sINX4tW1ozEXfM+1eVjon1gufFM+SANjXiOTM58u/YtHalKXAzte/BsW6SdzM0wKnmgT2OHyg8QvLb211lrT5by/rJs2jen3iBOUQ2E5V8uTvOyMLKRWEtBf27h9SIwqcU/D5gV6rNdBKRAxo2FYUqNFoIJn4yzEVDdQRywcQirYuhCiSmtHyD8YV/KCVMnV9Jo2eiKkBzFCXnTD8jdNRPvhbNud9t7W7qNNOeWJWSDRGkrBw/fUBvBspOaNZPROfuR1NXBcIJKP6m9yHkpZy0yLMQM3YC6z9mpT4DUskF6e+fLWfunMnU+u2MzikUJN4aHElXdqzZ9X6zjV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:59:19.8808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f828512f-50a8-40af-8f46-08df2ea192e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680
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

From: Banoth Saikumar <banoth.saikumar@oracle.com>

Previously, the mlx5 PMD attempted to allocate consecutive Tx memory
using DevX without checking whether DevX object operations are used.
This led to allocation failures on legacy or unsupported NICs.

Skip that allocation when the port uses Verbs object operations and let
the Verbs path handle memory allocation and registration.

Fixes: bbfab2eb2528 ("net/mlx5: allocate and release unique resources for Tx queues")
Cc: stable@dpdk.org

Signed-off-by: Banoth Saikumar <banoth.saikumar@oracle.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 .mailmap                        | 1 +
 drivers/net/mlx5/mlx5_trigger.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 6d9e262cfb3..d5cfb05b37e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -190,6 +190,7 @@ Ayuj Verma <ayverma@marvell.com> <ayuj.verma@caviumnetworks.com>
 Balakrishna Bhamidipati <bbhamidipati@marvell.com>
 Balasubramanian Manoharan <balasubramanian.manoharan@caviumnetworks.com>
 Balazs Nemeth <bnemeth@redhat.com> <balazs.nemeth@intel.com>
+Banoth Saikumar <banoth.saikumar@oracle.com>
 Bao-Long Tran <longtb5@viettel.com.vn>
 Baoyuan Li <updoing@sina.com>
 Bar Neuman <bneuman@nvidia.com>
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index ef71b59fe9c..1dbde509d26 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1201,7 +1201,7 @@ static int mlx5_dev_allocate_consec_tx_mem(struct rte_eth_dev *dev)
 	void *umem_buf = NULL;
 
 	/* Legacy per queue allocation, do nothing here. */
-	if (priv->sh->config.txq_mem_algn == 0)
+	if (priv->sh->config.txq_mem_algn == 0 || !mlx5_devx_obj_ops_en(priv))
 		return 0;
 	alignment = (size_t)1 << priv->sh->config.txq_mem_algn;
 	total_size = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;
-- 
2.21.0

