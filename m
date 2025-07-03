Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F105C83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 15:03:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3A2B40267;
	Thu,  3 Jul 2025 17:03:40 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by mails.dpdk.org (Postfix) with ESMTP id A899940264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 17:03:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhBOgBONY+tq+WyBY7sUryxtxbtthXTxcgz1+RxHEMMKaBPesDIhUr9ZLNXC9MJZ0RMLaAD5OAReJCTQn4/Kn1Ycb7mnt24p+/pFFRCN/JgVNq2hHK7ihuMnHusg1vXcVX+zg7WsDwY+yFjUfuBNlua/qnGVxyEqvjKYoctBdsXe33ec/FGPMHqLk/ZKYA46aysqspJp3CMIpoY+CZjzpVzwSCUEvRbef3JUhkvWl1JTHToSvXSGT44/XQA4ofxaivqgtaLdnfYQXcft4OY+/1t8alPWhlaRqs5IMLCPgPD3f5stzVkLwr8Ak1NVj7Ct+Itwh/30E/Z9QGQRNKSkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKYwktw3qJkpcYtSrqJwsN8r/G+U28/L+2ZXllVXphE=;
 b=zRTAQTKsqwK+wHJQ6rb6i53OksQPBpSuq+U3Oy2Efl2ZvumKqoFjrWfrouSJtJCSXasbp+zeL5uS2+7CoksQlVixNRgnpdfFdHfH1fqb1iJb8ru8T1gd/ugfjZLhA0Sg99/Tir1fJatvfXsC7hytrbbxyN0EEPjnsNfYQJql2zM/b+VeBdpG7MJHZk70bzQQxmppELTzr+K/id2L3S4DMQk9Sk4TB/JdGgpslL3wES/GlyjJj+x93kqhBFZc0KBUf85mLs6s4lkVNUWnhpcJT+oZPZZPE+HjyZszTMjzaqoKt7xZy9ychoM+yU+ywiK1vg807jrI3WVbbIfwtw0gMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKYwktw3qJkpcYtSrqJwsN8r/G+U28/L+2ZXllVXphE=;
 b=p/1p3qjOE1gNmJOtO335v6li2bR6NtX6D67HeeftOusE6+J0cQkWtI6T4eE0t73VMiLapXBRnqNJgHYJzQa9PlRNqcS6rjUlp8PeFAV3rRb5jaTWZ99Jl9liNc1vFJf7nJ7Doi+dwz+zM04B0HKOdMDG7rKxoF4BHxBHJphvP2zu/QAhfBE8ZF0xwRJh3/u9Dlf/1gR4tc8Ya9rR6B5XaYMaoU+4MgzeUNlghYQOBlwIbl4kBbwvdEOsBSnp88jS/zyEF+Nv16DBr+ZUR/efxqkSg7Eg/yQhbqDJKJNREszx0lg35xzijQS8OFNwO3WCp1KawFfpojMr+cOz0Wr7gA==
Received: from BN1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:408:e2::7)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 15:03:34 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::f3) by BN1PR13CA0002.outlook.office365.com
 (2603:10b6:408:e2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.11 via Frontend Transport; Thu,
 3 Jul 2025 15:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 15:03:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 08:03:11 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 08:03:08 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH] net/mlx5: fix decreasing the reference count of a Tx queue
Date: Thu, 3 Jul 2025 18:02:52 +0300
Message-ID: <20250703150252.145065-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd25839-e386-46b0-0ea9-08ddba42c795
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+iny3BUpZ5qNPNuvU7MWxYsUezCl3Qh0CdKE1PlqHZHSuox6FPaKfwomz5QV?=
 =?us-ascii?Q?AK17hlxf/JcmIh6i/XuyBcEDr6vwbN6Y22K0k5n2jGV32p02f7Bf6oJan6tT?=
 =?us-ascii?Q?QuXX1lBsYw1mSYWhteY+DFLRXfQmVYypw6bQic+dqHxx2M/QxWQPg5rChZdM?=
 =?us-ascii?Q?JVE+sNnKBBWzUJSht4BXYhR1BLRnAWKb/ymZBaun3j9VjaCZdY7+YrGCjLz4?=
 =?us-ascii?Q?Lp0c1lNKcvZuyHqX24cCS+136Q8WK2X0GWRssYQMGHyzUU0fABQYL4AbzNDP?=
 =?us-ascii?Q?FzOF4oWQp2lK/gEUu2PkQntpOINrIRfFxrMXPxVWQSEKrOT5Vg38WRutzOex?=
 =?us-ascii?Q?VWtJ/HNriLTzziofqenK3apKsxv2kavOPcpsGDC9kvbRNWTBRSRpyjZMANYf?=
 =?us-ascii?Q?lSQI1MEtdoMeORXJ5fO2sQw1RUAu2pfn1K+Vnf2TgaVWRBulcZmmsI+PrlWU?=
 =?us-ascii?Q?r9UWBY7XGPVRVcKaMUUE6mTsnzQuBvQQFUn+pAQBXbzrJXXgP1uJ5Ad597qg?=
 =?us-ascii?Q?FygMnHSMA6sLzJ89auoaWYoZpWOOKFeo4ckqCVOUSc8adDcpZOpEyrAvrEZS?=
 =?us-ascii?Q?d5ky56EB7PGjZjNSvWeM1sRg+lMFs5nJoDCziuVFu2NofSNE11GnngdbvmEW?=
 =?us-ascii?Q?FmWgRIM6utHSKZ2dP/0ayiZ0gyDKbc8apB86Hg1/vJnar0gYDa4Ls9bV3zLJ?=
 =?us-ascii?Q?l/rrjO/egJVaawTfcQvYRnyDEt6QBCYVOG3L36cHLy4M/CvlRc3ST6oOWUix?=
 =?us-ascii?Q?n5eu5QZtrleHhCE0xGcvjoKCyGRvl916RBciEUxRrBMy0W2LoCDTg3lFW5kR?=
 =?us-ascii?Q?U7MMSatoxjACyKWfNFe0qDP1jNQCjywPbb5N/Jw/qfTOb3d9Sew+KlrsajlG?=
 =?us-ascii?Q?Ibfs2pb96auidL6R+SCTzY8gE8PJCQxXHkXZZ1cZMKLOE5Ot7VyBeN1HhYoH?=
 =?us-ascii?Q?JPBYKEg7U5SaDwvTJWXkXyLm8SYNGTTZVljRhP26P5+AZyVKi18UePNxqgtm?=
 =?us-ascii?Q?OCDsh42X/vd7/nvxZF6RvRT/1M9+/zgfhIOOpFAYP03XVifGUuX7pQ3PzcQ2?=
 =?us-ascii?Q?EvkcWXIBN7gz+Ff0tdUsDxTxPguOMoSaQzlmaKayrucnm+bjewPS64klyhBd?=
 =?us-ascii?Q?l+N7gNBbxxpbKuijgeXRkb2lmg1vOte2ThOCXE7bzCJ8ZoGfzd68Vqrim8Uo?=
 =?us-ascii?Q?hHBDqqkTjk+qMIxVHzpinXXvTxfEDBn9t9rJ2zEpNpnkEG5nSvwBrv4suyWM?=
 =?us-ascii?Q?rSD5VAES2Jjk87GD2YTaVfAP9XPj6Xj9ydEThwJQJY31AS4CZEx60yCwcUzR?=
 =?us-ascii?Q?SROvXQOr4bF8+IPpJ9LXF4PlTW8/Z1WPIswtnsTCiecxhxj87xA6wYBhCblN?=
 =?us-ascii?Q?eAMG7WNsuZWWcTVn8JgmePWtbgctkdxzPTSuNXqvU68HiA0mpTxPVEO00t4X?=
 =?us-ascii?Q?Rbo+WUqKUWUQ+qQ5LafLF+Nfa/liA9WY74J8yAlrMncP1Y3hkZxCT/I4PJqL?=
 =?us-ascii?Q?lhvkzx3Bf5kxCfn6uTIRqbD1ERFKSgnoRkU4?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:03:33.3729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd25839-e386-46b0-0ea9-08ddba42c795
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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

When changing the order of the Tx queues startup, the depth of the
queue is compared. If not equal to the current big log2 value, next
queue will be checked and the current one will be skipped for the
next iteration.

The mlx5_txq_get() will increase the reference count number, and the
size check no match is not an error and the startup will continue but
not fall into the error roll-back label. The reference count should
be decreased by 1 to dereference the count, or else in the device
close stage, the queue cannot be released in the FW and the TIS, PD
will be leaked as well.

By calling the mlx5_txq_release() before continue will recover the
reference count to the initial state and solve the leak.

Fixes: 6f356d3840e6 ("net/mlx5: pass DevX object info in Tx queue start")

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_trigger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 90287a1b75..6c6f228afd 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -61,8 +61,12 @@ mlx5_txq_start(struct rte_eth_dev *dev)
 			struct mlx5_txq_ctrl *txq_ctrl = mlx5_txq_get(dev, i);
 			struct mlx5_txq_data *txq_data = &txq_ctrl->txq;
 
-			if (!txq_ctrl || txq_data->elts_n != cnt)
+			if (!txq_ctrl)
+				continue;
+			if (txq_data->elts_n != cnt) {
+				mlx5_txq_release(dev, i);
 				continue;
+			}
 			if (!txq_ctrl->is_hairpin)
 				txq_alloc_elts(txq_ctrl);
 			MLX5_ASSERT(!txq_ctrl->obj);
-- 
2.34.1

