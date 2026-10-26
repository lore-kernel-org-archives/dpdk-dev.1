Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3498606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g/OhtOGs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AFF5402A3;
	Mon, 26 Oct 2026 13:54:44 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by mails.dpdk.org (Postfix) with ESMTPS id B4EC340275;
 Mon, 26 Oct 2026 13:54:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOACORtKcaQb0nRuyFgoDvJAKjGusxJUEGG92pH5J8rynjGAmn7641IUPldN3uRHAUkVRN54XmR/Pz5qCAyD7b7iyrTCXLMQlXpi919h6kt90i1rmsfmju4/V0Wx+e4hiqvP/g8PQB3xKpKQuf05+Bhi4QcccthqH1mQo5FFW3BIJALK/A5Z3Q0Visdo1qWyD2Y8uMZkboExiUVNggM520taL/QATY1W4x/mBh5SODoOBTy8LB392Nc56mQbIy+oGjXpmurFkN/P9dRlRkP+CjU/zladO9e7jhJvRQzs6Pr20DQ+WKny2pWLARQyrMuRCacXgp/8S+K7Dalht4IKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TodSdHeXjDh116cNvh39b0DsBx5wrXEDiEYWW76Wnq4=;
 b=gYPpBAStDQIzXK/e3A7HZXG0DMvMwC/WbbUKvMC80He87urMQOd6kV1sEntjPAJn7tHe3DrTOXQcxyd7kHd0LiJnLveVd8FgJBttaDq50qIxBwe3SorWkZtH7s3lZu3fY3pBqxif3UDDtlsSJybNh9WEETcQsaeWWsE1/68YT+4IrqeK7w9Aix4u/tlvTX7SVbgwORd7Xbq1b2tps+7e7AWkZvQ9qaH44L5aZfEGgBQ7zzjKnIpgUSaWm6StAfvrmCsUAceUozHKnPovyVKgcXnR3KqIixeCSsCHDiHOohpWIu8vE+01SzgeJ6fSo5Bg+M5ydkS4EFg49y2llDFUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TodSdHeXjDh116cNvh39b0DsBx5wrXEDiEYWW76Wnq4=;
 b=g/OhtOGsGtDpKRrBeFTMX0EBytrA/QW0Pwu6eEFvrsW7SKEPO1xlSD0/wWWPEoNXH8D5mjxaWJQSJPWiKQNYIYIzV4ab0Ub/sPqdEAkliVyzcwxZ9YSqjy5LvZ37nKP4MEeuR51X1nwBajqyLRTNcnOIoI/tm6tGc4wJhIN0ZQ2jSu04d2v4i3AeJoz36sTAZnfEz+6hIcRXAN3TETtzN7oumPyFD0mu2tB/FJwPp7IYVoBe9FZ+uQpyROHN2WW49UgDg+ox45P5r1P4lC9/JcC11OOOtGnElkdEemV0wzLK+KlqJwGR4CHp3guYoXij6bmE1cbzFgAN7Qky17xTcw==
Received: from CH0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:610:e4::18)
 by SJ0PR12MB8613.namprd12.prod.outlook.com (2603:10b6:a03:44d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:54:33 +0000
Received: from CH2PEPF000166C2.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::1) by CH0PR03CA0193.outlook.office365.com
 (2603:10b6:610:e4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 12:54:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000166C2.mail.protection.outlook.com (10.167.244.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 12:54:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 05:54:15 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 05:54:15 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport;
 Mon, 26 Oct 2026 05:54:12 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <bingz@nvidia.com>, <dsosnowski@nvidia.com>,
 <viacheslavo@nvidia.com>, <orika@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, Maayan Kashani <mkashani@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH v3] common/mlx5: fix mkey ordering enum
Date: Mon, 26 Oct 2026 14:54:11 +0200
Message-ID: <20261026125411.2973829-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022073013.72607-1-mkashani@nvidia.com>
References: <20261022073013.72607-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C2:EE_|SJ0PR12MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: e21792b6-bf90-4a6a-a01e-08df336047f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|22082099003|6133799003|56012099006|11063799006|261021123027099003|261021121427099003|10067099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: otR/VTwWuPzpGanhSzhGT1s9ME3zCpceJUeDiQTaeB7cWkV870qANLyvZt9ELGva22fpaJ9zZfmE3cU/c1gIOgUYsUwkqQKVNt0f4s7TIlwYc9ZumN0GiBIWy/6FNtJRU3M9Ra/RDlL1FiYJqCBlTKkRbBCL9wKSW9XjuWsXr+/v6j26fZjwQtva48n64zDg0578rmiOHogQR3LVQxGOwJgW1UWqoGBsvsZlc5wHYIRmGeVN134IaEItr2z5oR8jZVPFN04o7CPz0JKpN772YdDu7zt+HD61SBGesol05vJSQ8EUwvfc1KZ1KJNyaxI8Q0ruHlSRr3n48OD09LBw/CSqHt2+CA8W0kpAznfUSQzYqii5UP/0X2esX0nvAOhwVFP777M7OzR4UeM3pvT8KEH/gtF+2IQdp36DxgZD3ztrRDvWJie/J9J//5yNXQfw5oIwLbJk5OecxGzfw0ptqsBTVq9JBO/ohC5jxeE88UPIm4X2K1UVppqoibl47/4u8CoG039Ymnr2XdzV71TmNyTWuHR5AzO/RioU3wXLZProC4t06b+zPPXX7Nvt+aEW+fs4Hnzdss6q9vHwIZSA1vp1huunQATaE1Gc4ty2XbM5Q2SRshyHOI1LdBI+7yAqCSwycSKhDx+3pke3kbChcZuCh1VvXij2GHtvNJjPhfOjYNuTSgvJFeJNBtPrOYgJjw6A8lzj0NHGtv8hLPBsbw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lg1mLaqXCgiSaReppYX3V+HE2RYMvkxqhE2/JjhsU2XKEFYzaUyPEu0uiP/jbthq8rg7vqQquOdr95yvG3fKkkJg4BDu69wBDYDj7jJBm1KnpXSpwaQh1+C0eZ3DHwTD0hOjO0d/nTty1VvvL+E62bNHQeeIrVLZV91LzCugjpPoEGm+Qy1D93NYax8lBpYhYqxBihrtP5fpgGNz2XJ4xToJaB8OPDohv1bE3EkLQ8GtBQyQxN1gMlGdGo0XwwrpVR7xn5taCuQ7Vj7BV17KKwrRDX7KJTL8cJ0X+D7TREOYiNqQufLqHUcXriJp9ppMX9CGQMz1CWc+PXE8UpRYjaJiyUawJUQUWnS/AL4BGIar1ofHqrsqIynSmwqhDP7e6kDpbIqjqrPW2yrLdklKQOqbaHCcH85WDhg5e5x1DljE17GF8xuSDe4pfoYNFqt+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:54:32.5753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e21792b6-bf90-4a6a-a01e-08df336047f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8613
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

The updated device specification defines relaxed ordering as 0x1 and
reserves 0x2. Update the mkey read-after-write ordering values
accordingly.

Windows MR registration applies full MKC ordering, including
read-after-write, on every non-Haswell CPU. Other mlx5 drivers apply
that ordering only when firmware reports relaxed-order-only mode.
Keep relaxed-ordering read and write enabled from HCA capabilities, and
apply read-after-write ordering only when
mkc_order_write_after_write_ro_only is set.

Fixes: 5003eaab7e49 ("common/mlx5: update relaxed ordering policy for mkeys")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
v3:
- On Windows, set relaxed-ordering read and write from HCA capabilities
  and apply read-after-write ordering only when firmware requires
  relaxed-order-only mode.

 drivers/common/mlx5/mlx5_prm.h               | 3 +--
 drivers/common/mlx5/windows/mlx5_common_os.c | 9 +++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index c2810194f8e..7ae5ece6c32 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -1483,8 +1483,7 @@ enum {
 /* MKC read_after_write_ordering field (2-bit, dword 0x38 bits 9:8). */
 enum mlx5_mkc_raw_ordering {
 	MLX5_MKC_RAW_ORDERING_SO = 0x0,
-	MLX5_MKC_RAW_ORDERING_SAO = 0x1,
-	MLX5_MKC_RAW_ORDERING_RO = 0x2,
+	MLX5_MKC_RAW_ORDERING_RO = 0x1,
 };
 
 struct mlx5_ifc_create_mkey_out_bits {
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index bdafb95df98..ca68ca05d66 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -403,8 +403,13 @@ mlx5_os_reg_mr(void *pd,
 	mkey_attr.size = length;
 	mkey_attr.umem_id = ((struct mlx5_devx_umem *)(obj))->umem_id;
 	mkey_attr.pd = mlx5_pd->pdn;
-	if (!mlx5_haswell_broadwell_cpu)
-		mlx5_devx_mkey_attr_set_ordering(&mkey_attr, &attr);
+	if (!mlx5_haswell_broadwell_cpu) {
+		mkey_attr.relaxed_ordering_write = attr.relaxed_ordering_write;
+		mkey_attr.relaxed_ordering_read =
+			attr.relaxed_ordering_read || attr.pci_relaxed_ordered_read;
+		if (attr.mkc_order_write_after_write_ro_only)
+			mlx5_devx_mkey_attr_set_ordering(&mkey_attr, &attr);
+	}
 	mkey = mlx5_devx_cmd_mkey_create(mlx5_pd->devx_ctx, &mkey_attr);
 	if (!mkey) {
 		claim_zero(mlx5_os_umem_dereg(obj));
-- 
2.25.1

