Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF24ECC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 07:49:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C498140291;
	Fri, 16 Oct 2026 09:49:09 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by mails.dpdk.org (Postfix) with ESMTP id 322EE400D5;
 Fri, 16 Oct 2026 09:49:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsHKmHce+EhCdzaz64vrfDWKaRn+7CSOjp3WwHniHR7LsiL5mqArZ5miVk1yxNrP/J4Kat0QXFFKKDCcVCCSJERYq1h9jJrgLQ22OnU3vHWa+5ZVqm+CLnoDGqVD34c+5c/x9WADn8gRcLRakb+T2OjRsvcZKjhOpDRdK7otre6xO6WknnnRXpuSmaLmJfPhDAbjkjctMA+eEfXQZ5n7c7X8hj0kC3p7D8ck+lAl6lLtEaM1WapQLYm1u+V6l1Qh41dXYpUvov3Za/zg0ULqy52cqbTHwST/FOUK3osDnOMULoQBcCgmIKDkGY87mslJznsJYAoA3sy9UbbjeOOpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvyaJOihLI8ayYswy6qxakb/sbVmuoF4eQd2KnPufEM=;
 b=RgBUcvcXAnd8srPROPn/TCDy/qknAX95Gv43iNF8dd4SDMqQ+a7WExbG92cVWcW3eWLjNtscTVCZuuIhGMLFGZtYZN5GD5F1UMGs7/Ay3+HJMxN0QoW0WOV/aPK+x2H8bNYJMbhM0TIEM4KMBZyOI2uJsZWhsKxqWXOQ85g4zY0R18VNLZL49W6OGH17nSlSLn+PJrg1gZpN5vyqLxq1UdLBn2itKDo4C/lWQWCI0O1dx8CvWDOpJSzviwBtrRw7un2I+zpSzgJC+nYKbpmytKP+/dQ2FwQM+xQwxnzu80DnKGzUYNoCvTjvc1Y+sxuo2w7+0noizRQ9haGVIiG5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvyaJOihLI8ayYswy6qxakb/sbVmuoF4eQd2KnPufEM=;
 b=VHF+2ZgderRiaq4ynY3WFgwPuHGfmjX/7vXkMsPZEvBUgsZfkyxCjKsjWRkDahTReze75cg8/0fd4PzkJeLHFG40wD3IzH6XhGnKyYr2wGmFvaeOOrbmzWBRRCDkPZzMFpC9fzuyyTBZizjQtpGMQcZSbu8HEPJtFh1q3K0ks56ltiBtCJH3KaM0mJY2oR8Vm2sa0DR69ElmuuToowjyX36PAS1wChmjuPF46v7AssApQY8eFcsY0dGDytF4/3V0P9Jxkqij7jqYCkZOJmnWIkKIJf1QCVStZiO6I1BCeC+ZrYHvTAHOg2paa2H4L1VqlCfQgUFQrrfXC+HYoHm2+g==
Received: from BN9PR03CA0474.namprd03.prod.outlook.com (2603:10b6:408:139::29)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:49:02 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::80) by BN9PR03CA0474.outlook.office365.com
 (2603:10b6:408:139::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 07:49:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 07:49:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 16 Oct
 2026 00:48:38 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 16 Oct
 2026 00:48:35 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, <stable@dpdk.org>, Bing Zhao
 <bingz@nvidia.com>
Subject: [PATCH v1] net/mlx5: fix suffix groups without default FDB rule
Date: Fri, 16 Oct 2026 10:48:06 +0300
Message-ID: <20261016074817.2831545-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 46431dd0-c68e-43dc-8482-08df2b59f1d7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9vnr5I+yuAE0H5Ep6fGJ6byq/43uIH+AjabfzoHMCdEx0gfM+Mnu2ffSnXrhsYEbyBvnm7IClRnWGujHBl9JQJW1itlu1Vfs2XmdaNZQ1wsmhdX+vEjLsSGVJnLF0Pv+kEeYeJWCNij5ZB1W9pP6yQwaBRkf/PKlvgtuWz+Ir1lGZdwsMzelSlQ3iyOw/583hwfi+7rTdmfzagkOKRqkaQhG/JT65rhyt6z5lO59O9Q3ptGT8wKsxAAIGn2RVvhBatj3B0iQdkbV7vC/xZQJWV0ERH6+pVfY4yfbhm8Yhs+63DiH1zU8TymLo9NwrOsh0ghIB2JzIV9xei7L392bPgi7Gr5pbUuOpSB1j18+I822MqluPz8/LdsmktuRmtlU5oHnehTbq6+ZqyST8S8brgeCPGWKx7VLiapmpNy1AAsWWynjqeOFBAUroFEUz99lbpvtkgzN3g99amREWnYTTaOjii9yWtvXoMzf03MI8Do9/r+oIEKvq1tlGfYMb38Ud4TSNaiGGfac4SOUThYiit93eCrNOII5BZRAPodbU9fgyNswuk1VUzRbbKM1z2JAkd1IR7QcIv2tx25U6cdM0hToJuo8GW9q4tiEiD2nuvMZyZep47J0QTapGPHylBjbzy9N/f9Kkjxc4xodSNrJE6zdm7q3qhohJttegWcLhv64AHlwJYDyQ5lc20unXPYSt2oX5VAEYGizWkijHO/c7A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pyp9jxY61CS7gscksvNAFUCRQ4W6SOTaOIaxNIZz6jADc3qU7jPJ/OGrX46MNreQqxFz0j5YM4/bcV19ACYC8lIqKEvgvr+EGDR5v1ebl7VBnpyzBb5d5K+HaMsJBx2hVXof9xqo5sQHuFt48p61L1TUXqDuHTmLFLZbIX/4YitIF4CtIbBc3REGNt7P0pCwx4S87SILJKihjmmPXRPr75kM3wF3sGh64SSk3bEvWvlrka2pDQhDu4GYeMme5fZ9HfvgK21x3bEFtf+RmpmHkBtfeEYOly5g5ubPV69tQnuyGTWdm5+2rU90hnL56TZasaFy3OKISxgPMZ/KPGkel4FsEPzMSsxHD1McodKL1TzKdnVMGJ/ETSdIG3EUuffRuSE2IwzWyDSYv7oBdZBd15IE6LyXDInmnFSGBEkCA70To7wdDEYOrtR7PdYTeWMl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:49:01.7525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46431dd0-c68e-43dc-8482-08df2b59f1d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
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

With fdb_def_rule_en=0, mlx5 SWS still decrements meter and sampler
suffix groups, causing continuation rules to be installed in the
wrong tables.

Decrement these groups only when the default FDB rule is active,
keeping suffix placement consistent with group-to-table translation.

Fixes: 1939eb6f660c ("net/mlx5: support flow port action with HWS")
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: stable@dpdk.org

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index b0eac185b5..37654918b5 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -7048,7 +7048,7 @@ flow_create_split_meter(struct rte_eth_dev *dev,
 			goto exit;
 		}
 		/* Setting the sfx group atrr. */
-		sfx_attr.group = sfx_attr.transfer ?
+		sfx_attr.group = (sfx_attr.transfer && priv->fdb_def_rule) ?
 				(MLX5_FLOW_TABLE_LEVEL_METER - 1) :
 				 MLX5_FLOW_TABLE_LEVEL_METER;
 		flow_split_info->prefix_layers =
@@ -7229,7 +7229,7 @@ flow_create_split_sample(struct rte_eth_dev *dev,
 			sfx_tbl_data = container_of(sfx_tbl,
 						struct mlx5_flow_tbl_data_entry,
 						tbl);
-			sfx_attr.group = sfx_attr.transfer ?
+			sfx_attr.group = (sfx_attr.transfer && priv->fdb_def_rule) ?
 			(sfx_tbl_data->level - 1) : sfx_tbl_data->level;
 		} else {
 			MLX5_ASSERT(attr->transfer);
-- 
2.53.0

