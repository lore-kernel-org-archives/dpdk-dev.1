Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E48C02199
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 12:09:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F08A402AB;
	Sun,  9 Feb 2025 13:09:29 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by mails.dpdk.org (Postfix) with ESMTP id 062E840280
 for <dev@dpdk.org>; Sun,  9 Feb 2025 13:09:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euK/0nNNsuEdAFGc5DUl7mQDZkaL81tO0f6Bbe5KX8fPwRQq46P21YT6/MLQ7emZRfQUeIJba0FsdfeNtWqZdKYepXAK54Ew8784oWH2aAIqxfuSxe9v6ARGq1baNhfS5LCgk8vnJxX1dzUAfkrR9DHLvmQGuH9fdZh4EWV8PB/RfhwXiVbY/WA9hcHhS7/ixP4GdHqAEqqBal4FDwUZjq5+8xxKS6jvEiGCU9hzSqgyOf3WTP39evcGi8uRsE+Xwl0l2UXBmX65CUGEviBHVT7Rrb3LB9m95z9Ah3H5c2xapv6UWL3djL8bkO6CDvlIhLKyn2kQXg++W9BGV9PCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1K/qOCxsm31x/kB1TIhrLMUz6os9Aw7xpUxn8U0VDs=;
 b=iTrf3XnYnyFDxModJZNrmhtmYrG/GRESW3Rpkhmtwv9glSRC9r6y3b1ebIXMMNgl+fFE+Y/eUniLt6dc5rN+zy3gjRkMatA/FjhK+5EJUgh9fiuThH9CjbkvBrNXoJ7ctMOEwyEQYq6yAXA1c/VQimnFhxGqZovMa2uxRvZ6UIV/TbNp/fnKldUGkCzQkI7Gnm/SOnhmthdotOqF6tcDT1dCaMau9sH388S4BR6d/ikYMympVUvcDRGoAJQbimGKX6QNZiX6avCmBdHbi/mB/YZELzg9Pm9UOBI+KSCvA7ZvZNBfmNlJea+qZYfH+wZYKV7F8e3khuvUTUlRIqfxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1K/qOCxsm31x/kB1TIhrLMUz6os9Aw7xpUxn8U0VDs=;
 b=sZipEdKEDbL/a7GHJxDzI/CTbNV8kMBzwA02Oud4F2SCEp02Y1S7j0bqUKO/djC4CKwS3jt/Q+OqiokKmxY0YzRQh/b2EX/Bsh6QzN3GfNwJW4rbCJnHBbfikZ+C2WkiQccTJbeAiczG+uJ24lDhGj3D8N9iVR+BZYc4W1THwIRLiz0Pr6hleOTD2Q79HqOdB9j1zhfGiRGaOgxRmneA8mT+qXzZuReMUcQ3suWTQuoqDoPNB3rVVACeDeErYo3Xz2MKp6x3zTc7eyReyQHRipdJlOtB8ksXTGaTtWWYW8kCfhnBUR3DglIDBK1/68L1pZ1eBB82xQMBUDmkt6hGRQ==
Received: from BLAPR03CA0119.namprd03.prod.outlook.com (2603:10b6:208:32a::34)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sun, 9 Feb
 2025 12:09:24 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::db) by BLAPR03CA0119.outlook.office365.com
 (2603:10b6:208:32a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 12:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 12:09:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 04:09:09 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 9 Feb
 2025 04:09:07 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH] crypto/mlx5: log when num of segs exceed max segs
Date: Sun, 9 Feb 2025 14:08:51 +0200
Message-ID: <20250209120851.254695-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: e8560f17-11c9-4f66-1ba6-08dd490297ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bv5Ycnh14HJ1p5oOOG0pxpmAzn+JEE0E9ZK1VzG/BkrAhPRpgCri8OGLHJOH?=
 =?us-ascii?Q?JDfY8loqakDD1Lqwxd7FFY855F5bj58KlAryN9nfmuYv++Q4vXgEgk1wOwtK?=
 =?us-ascii?Q?3PoJEj2OhtiOMo063uPfXzI6fx0cIGtyNvPoM0iXueAdLSwIFoxogfyLduHR?=
 =?us-ascii?Q?40Q9SlP4q4u8Jk4PeflDJqTwgkYYHUBHNUTFvz73rB5uKBsGSzK2haqw08yN?=
 =?us-ascii?Q?r6S9NFzK4NE/CPVQuMi7E+6DoEDyog9qgRUjgV2/YEXbZXX9WAfYCgJGyZtl?=
 =?us-ascii?Q?3PYi2rIL6/5hNLFOXBnsiXrA9OQw0Se5tXVJNPYYYQrx2T2rXWBsvCxW0Nl3?=
 =?us-ascii?Q?3+5dptY72Z3GEuKcRNBx9+xXKBzPudvhXT/cPG4jsN2nBfoGko6eNrQ+O94O?=
 =?us-ascii?Q?aGJ/CgJtEKkCPTsDvwRLIxv4ekx74Pi+agutZIPUcqbE+HdqZSAEHbfdM8aU?=
 =?us-ascii?Q?6yZkZMW8bH80lLt+ovKYdGA/QJBBWFCXnvETnskY+XMFkjI/q+I/2qeivI64?=
 =?us-ascii?Q?Fgp+n/6sDh0uGm6I+6xP8N4Uws+R1jCIMSqm2B/Df4AK1F6bKk+ZzEISzryy?=
 =?us-ascii?Q?dbvZ+1P75tLGCh/+h9rHyRJ0N7EZDMHamNdZgl6Yt7jQo9ABoHVXXqHdgyVc?=
 =?us-ascii?Q?EFTjUE/E5Ne4A/9xitYqq5NDtj8eDdRGt+lrx59AFtxq7gHFf9RD9bXyp3Kd?=
 =?us-ascii?Q?/fgM3MebOfCoDAYmcSid6XSnP319Wc7urd2ac0G5lqq/zI2weDf2/tDX2Lrk?=
 =?us-ascii?Q?okRK8DtCPddwJJpA/ORf7agbdjDbLlmZMz0I3HuMK24Rq367xCY6zY6gwm3I?=
 =?us-ascii?Q?bOf3elmtHH6Xy/cZxG8RcvLLoC/pi6crCUGaAqIr5GpRzQqE3nG5lAwHQfxY?=
 =?us-ascii?Q?RunzJ8s7aJyQWk0CFUXHP2vbB/Fsn8YbapRNt5bw00XPI21imIIunM8uUCef?=
 =?us-ascii?Q?PyPCNmAH/qGAsa2+SHiVMiM1rZ2Y+IYdN2DMiN+zl7mfPwTI4cNO2yKGjB9t?=
 =?us-ascii?Q?NmI8qPVq7wTpXQpRaNTOdrI/QEClf32ds/J99quTQTWrmg0ugwZCLSCwPPld?=
 =?us-ascii?Q?6GUgF52jKhOKu3C/NNoEAOuMlO2XVXhjXa3hdL1NC7FtTvK5fhDkmpRfiIR+?=
 =?us-ascii?Q?cGw10hSrWa7HVZpbXB0f8HUDp/CTf9N+n+1saC8tE8ojcKAF7fFdUNeie1Pr?=
 =?us-ascii?Q?g8WQEIHZu2gLYWfqhpXl9bhCYL+/AUPBVH/+jSV7BDFmPReoesUPY08wgvDp?=
 =?us-ascii?Q?wvXJODKC/NyjSMBT0ho7DP2YE7NB93dDnTvHMchL7+C+SrhTqTYGSpV4Ilhn?=
 =?us-ascii?Q?oWk78sByrOns6YP17deFT+zBvgGyIGvqB+B+WMfWlQyWdgQNiBA6l+ZV93Az?=
 =?us-ascii?Q?JAALuYgSj+Xm0CPBnGnYfDeoctv/yMGYEUiBjdsts3R4PBgEqyEqSh3nD0K4?=
 =?us-ascii?Q?CfPUNDAHqyDIeW6O54T5ap4TDCwe46O7/moNg14ctLKTEotV99DvZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 12:09:24.0076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8560f17-11c9-4f66-1ba6-08dd490297ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
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

From: Shani Peretz <shperetz@nvidia.com>

This patch logs and aborts when mbuf segment count exceeding max_segs_num.
The log message suggests the user to either increase the segment size
or set a higher value for the max_segs_num devarg.

Fixes: b01095830734 ("crypto/mlx5: add GCM enqueue/dequeue operations")

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 drivers/crypto/mlx5/mlx5_crypto_gcm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/mlx5/mlx5_crypto_gcm.c b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
index 89f32c7722..d7156a6abc 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_gcm.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
@@ -554,7 +554,15 @@ mlx5_crypto_gcm_build_mbuf_chain_klms(struct mlx5_crypto_qp *qp,
 	uint32_t klm_n = 0;
 
 	/* mbuf seg num should be less than max_segs_num. */
-	MLX5_ASSERT(nb_segs <= qp->priv->max_segs_num);
+	if (nb_segs > qp->priv->max_segs_num) {
+		DRV_LOG(WARNING, "Segment count exceeds limit. "
+				"Current segments: %d, Maximum allowed: %d. "
+				"To resolve, either increase the segment size "
+				"or set a higher value for the devargs max_segs_num parameter.",
+			nb_segs, qp->priv->max_segs_num);
+		RTE_VERIFY(nb_segs <= qp->priv->max_segs_num);
+		return 0;
+	}
 	/* First mbuf needs to take the data offset. */
 	if (unlikely(_mlx5_crypto_gcm_umr_build_mbuf_klm(qp, mbuf, klm,
 		     op->sym->aead.data.offset, &remain_len) == UINT32_MAX)) {
-- 
2.45.2

