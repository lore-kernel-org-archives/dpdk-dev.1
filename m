Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E545CC55162
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 13:56:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02C6040280;
	Thu, 30 Jul 2026 15:56:57 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by mails.dpdk.org (Postfix) with ESMTP id 91C3A40276;
 Thu, 30 Jul 2026 15:56:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ex+k/DHVa0RcgtlvkXzGhtrPH9uEQfUCbndp9ZGP0oYfElMVxsv602BgNNhZpJTzDUSC1IxjAp66+2k6orImPzyNxWpExLuKXFaHkj7SEAPAZGJlhXg92KhesfqcXJ1UvQo0W/Lc0DsR8cYGIY7HbsGuYIigdgESNaIpLi9GinT4jYbrRbPgfRi8ZxZGN/p16TscxjOUIi/FABANfBc+ngqgozvjugYi/CZWkxVzxYashoGSJdS3mg4gW2ptRox44QvUglJycYpS/e6LIWjUSHnhHm5ikPPfwCXP61e02BBwS9/FSb1oC/nCM8tVCpj/E5ahMc+LaE51+30FvDzcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CBFoKtsl6JQDmkjZ0WOKt+BSwDNuVtD7xQ8VDurnGM=;
 b=nEjfluANKSIGwAJhRb9zBdBfMoUr/HtICj/K6SEVi1WeIVNtisxnflwHdcDmz9MCQzTgplayJikMuWCKxzVn9AJaPdhFRvmAj3v9kHU7sq5/pvF3Hg1tsJxokxaCryIn8fdSXfjNcKCPxXG41RO+3PfRSebRLaQI2c6/Pl4HHTxyhZOvinieLBUKVEBixniU7/v/0ae6HKKoR6pB7RU878TYffp020sUKqRiUY09iGRpFS9ndOVsum1fwASa/Nsa9cfJL7fOd7Ij+NlDpOj/9mLFGED2tliYnAOCac/BVRUbYCwoxFDacUxCJyerHSeL0WPclBfyG6Bv1+b0A9JlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CBFoKtsl6JQDmkjZ0WOKt+BSwDNuVtD7xQ8VDurnGM=;
 b=BurnZ5NPYJk9mJws+RH0nYLpvoWhs2ZBlx1gxfG3GlMp3jXG/84n2wgerIi+FWlhDnbMJpfcVJKPs1orucxFWy2e0Gx0ITswAAJoBFvnaxUZ3ZKlm8o3+ZBjD1H5+iAiFrchHJTH73zqDKQX+k/iqUQDGnXZyfa7c9ZGXqJKg0LZHjfLyg1g5YqkNJzHDQegYA4EaWhkyzYfo/k9F2Ij+vEI6GWUI/TpinLXHHI5RFh259X7T/aCTXV6xKiRRfgC74p2y4jnOdyMLdKiIyhrx2d1C3fnZzKzKJhe7wXGHNX24or6/cyB+3J+GaJhPSsOJyq6KPVKV1B1t/VPN5DDmg==
Received: from PH1PEPF000132FC.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2d)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 13:56:48 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF000132FC.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Thu,
 30 Jul 2026 13:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 30 Jul 2026 13:56:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 30 Jul
 2026 06:56:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Jul
 2026 06:56:26 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Jul 2026 06:56:23 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, Gregory Etelson
 <getelson@nvidia.com>
Subject: [PATCH] net/mlx5: fix uint16 underflow on Rx queue error path
Date: Thu, 30 Jul 2026 16:56:19 +0300
Message-ID: <20260730135620.213682-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f559efc-0a1b-423e-f358-08deee4265cc
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: EC9OubevFv8uDjNc/T1qr9/D9nf4oXo9OvyKllttveYS/T9k7Enxit5mrPT8JFrnxUnCxCe4INrQFzzO0ubSmntG1BfG/BZTdLD2nGqgLcE4KzZgzyTqmk0UuXoFgXfdjEd472d4KTTcDxPdBuYlpTRzl2MJYDaSrxKPcu0c7F1wUEK06pSD2xJ9TU7PqAQkI3Fu7odz9KcjMr5YBSjvUVJOSJbO+HQJAEHM+i7z3Vvy4EX2OuQf5D6ANRArJldJ36FXwmtx010PkA47xfjeY+XQCW8R5U/Lj+CaWKpXHF4+iu1HWHOc4cifEjOvXhXQssq7rNte1lBbymKwXV3fmNXQVQjK4rxbuQsI9FMGbxJIjVsYb0zvMVrlPZCN8peeU0dLsGOyF2kMvGlHrE9a/pyhCpkSFyCujn2uwzPg6SOVEwOJ6GoDe1La2yHUlV8dxBgGrH75X3eWYxbWIXgDmChfnk9WmeLhIEZo8YwMIXTgNKt7QCsaoqUmTlyz6UU42JDI/5u6o3xHvW3weYZomC0x60zLnaKWSJ5Ey0vdZ+/iIuVeM35CFUI2vo9lkZ988t03mZx1yMKz9B4n7LH8tLkpMUMQjmp3cVhYQs0kay6CcDc2F7isrg1+APIR0koV4fMNTq2Tn17X0Oa9OEcLTiKWcKi/LUBr9QRso6QBM+5udNPDrhmyTqm2tVI9eANk
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: azRTg5P/RscPCyQdr8S9R1IM5PYqboAZEYkk3n9FL8utgdxl2Q6jl0H88GKs6jQMp1dvql8NYMFlOAAiD14OW6Ppo9XFAIG3yDE8M12RY7RcH8wjKvdaq1wJKT4at7QA/FMOhiLrXzrkSsI3v9cQz1uA3k00zW13V0jPBJG8ASIpSnRJ7X/espXgvBPjloNrHRJ63hL7LA2ScV9bj8qKDDDSY0f5xF+FpXzGM4H/A52S3Jmf6LyL+4mvmFMG1B1AmFSSJMn3EJqPJriXeRHWT0Nksw8ULKUoI4JU2FfbRy1uckNXm/wsE2DHTfEWkm4lHhFSozJJqPx4zRL6hhGJ9EHWVfZVy4TNk3s3Eq0s5usigX6lLZxawbVuytfXETJqoIeSaxR9+5tccnh7LufnuoILniyZgaw1PAotz8bT6kWNBfsfZi1KmS4wW14v9cyj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:56:47.5007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f559efc-0a1b-423e-f358-08deee4265cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
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

Avoid post-decrementing the segment index when it is zero in the
error cleanup path of mlx5_rxq_mempool_register().

Coverity issue: 503770
Fixes: 8d1cb02da5b7 ("net/mlx5: support selective Rx")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 drivers/net/mlx5/mlx5_trigger.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index c2804c58974..b6ce0133c93 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -187,10 +187,13 @@ mlx5_rxq_mempool_register(struct mlx5_rxq_ctrl *rxq_ctrl)
 	return 0;
 
 error:
-	while (s-- > 0) {
+	while (s > 0) {
+		s--;
 		seg = &rxq_ctrl->rxq.rxseg[s];
-		mlx5_free(seg->null_mbuf);
-		seg->null_mbuf = NULL;
+		if (!seg->mp) {
+			mlx5_free(seg->null_mbuf);
+			seg->null_mbuf = NULL;
+		}
 	}
 	return ret;
 }
-- 
2.21.0

