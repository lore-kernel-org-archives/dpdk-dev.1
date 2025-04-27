Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37F9C369D1
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Apr 2025 11:23:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 780B6402C3;
	Sun, 27 Apr 2025 13:23:13 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by mails.dpdk.org (Postfix) with ESMTP id 857124021F;
 Sun, 27 Apr 2025 13:23:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W033nw0/34HuJ18dXjOIv3ARNI0BfIaUctwDajNtPfDt+Xhb3ggB0cwt1h86cCIPnnBKSO+RhZVTY6L5nlx80ivCGxe93Z49peQn7VjSEH7T+Z7276anFkiDN1pHDc3DtlRhx5wGHoa6F1SfR4NdS0cl3BVMLuMwgI4jiOq11H3HZbREkzhpddkWCkFcZwZIhEeu/FO/bfnCz7pcZfrfGgP3xhxBbakVuVvwq08C70Hh3X8R5YaeqNtcRJrKdOqornR0tHb8hP4Vj3BxvdXMT5j29wvFl8nTqoyLP+Y2n20WJ03iGrlFtFtTkkR8E1sYMs0FbKoc6T9Tm0SVADSTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSsjVrHNe32yciuJn8OxD1WEwiTJxd9EZi0ifbnLRCE=;
 b=QwrDU3KA0NdgMcoR327MKOSPy/4CgCBsagIS1ysTdTkZtTFG1Y2hJMLT34hynCtVsS3loEPENcEEpnYTsZg1sM0a+Z3vj1OGy7kFbCD/h/7OGcn4nivm6e7PWjUbMgxjgyJoRAFAEv9G/oAsGpIW84tNpZLujDDNz8PeyLqiyZUur7b9QyzKY5B1EDz4ajUqun6wmKhZ3/g9K4uHrtiPDW5++RpRBzCT322r1crBdnPnDY6TTtGhvKrHgFEET+WHJepFYuXkceMN0mDMFMZXQQai3s2zresTRyqvmTt/3ZjvI5nDvWezbVCC1qbMUaCmTZMeSzQP1GTuamC2owqWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSsjVrHNe32yciuJn8OxD1WEwiTJxd9EZi0ifbnLRCE=;
 b=P4CEKVy4AfboMLI3n1IJ+Z4hzXLtTbmru2HXxTVyPlKg+rxE+QnNyNG0bUJqYST78sG9r7wBcZnh6VmqZk7VBCU1p9YQvmdGscv3+2Oa8qeIu8ecTyZJENqCkSmzp4GnsiwUX0IP2y5qRIe0vNeBXKhBJbTELlHHLLZBweDdixCuWkBfdB31ZuZG/Eyk58MONF26bpZYwbXwdCQuy4bDDqXj4jZYKpII+MqXWhwT0ZtfyDGfk40zE8IkL08LM5wFdo4f7NzGCllmo1Rn2QwYYQsug3E0hheCjhK9LjZm2eIwHc3Rgia1RI/sb1uEbOFcXVBlSfyIe6v5BMNC7MOm7A==
Received: from SA1P222CA0065.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::16)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sun, 27 Apr
 2025 11:23:07 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::c0) by SA1P222CA0065.outlook.office365.com
 (2603:10b6:806:2c1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Sun,
 27 Apr 2025 11:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sun, 27 Apr 2025 11:23:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 27 Apr
 2025 04:23:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 27 Apr 2025 04:23:05 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 27 Apr 2025 04:23:01 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: [PATCH 1/2] net/mlx5: non template - fix validation for GENEVE options
Date: Sun, 27 Apr 2025 14:22:56 +0300
Message-ID: <20250427112257.108544-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 2daa60d9-9fe9-4905-eab6-08dd857de21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YkyxFB1EVVuxqBK3hIMvG1JdcDb+2yL7gtS+cC7xf/p3w7cUDN0f6bxmefb5?=
 =?us-ascii?Q?tfOmvCr2qPN4u+hmBwtouM7fDzc5uQAnQp2vG6bzRskC2mUr3Qvg5oBQFsrK?=
 =?us-ascii?Q?33xD7CpqrxXpjipFm817O2rCvyL+WlzqT8PYdz0Yi6OKYIlCXfjwnsbNP90j?=
 =?us-ascii?Q?a6Co8rVW9iLDgQ8HaSTSeX0klnuqxxuuuTy3reRu+WYcTaVxABDEZBMBzOme?=
 =?us-ascii?Q?LGY5bsm/AD0XXRqFtlGKAeV3RFYLMP3QUvKsdqTznGbdoZU5jvgrJruI3DPO?=
 =?us-ascii?Q?vS6Uf8MYaxIxJIBdebBok78TKqUhGWEjlc5lFyY5XBSvTPnHUk71yYuAkPiE?=
 =?us-ascii?Q?jGZU2pjbrNLqESLjFqs9YqAdxNauoijMejfS3xlIuf52IUxFrSl4uAO1QjkT?=
 =?us-ascii?Q?vaTjxWXAI8vjwS5XSa7M9GmtyaG/rJvsJwTbucsCUuloIA04rGjgP8Xqh20W?=
 =?us-ascii?Q?SstOoc2yLMqeVjENo5/CHTtBo2Oda96YZdAXs7pNzGn2kW5G6Afiky+nQGiP?=
 =?us-ascii?Q?TUjOcLoSWX0XX6uUIzIS/XrkBBJv+e6DZwV39u/ASancEni0tWK5UA37iSjq?=
 =?us-ascii?Q?G5nLaunOubFTSYZOiYPCX4bEtF/ZRLHJpgjEEkpdxcUyS2AYhJ6yoRmh9fka?=
 =?us-ascii?Q?VfEz3/kjzj/rx3sPv5Den+/WMzM8XGohqmAQ7eaHh5WKGO+FzGdb+5n0gGxN?=
 =?us-ascii?Q?4P8qcSvYfmXBN7maXDVCob7JzxkLb0q1IIXCcyWN2sqVXa5VG8fOSwP8IcZH?=
 =?us-ascii?Q?va4yjmJ/gmSPwh2hHHd9M9L6Ruqby2BUcPL1ka+dWgJnmceWReI0plgTDI76?=
 =?us-ascii?Q?yfSkmhIOTOioTOEhEpAHugx3Oz0a5XIg2n+6qnNjtTGaGzP+hIYMHbdKAEw6?=
 =?us-ascii?Q?nZ2HqWknEsSRA5tZYwKnPjHDyDFk5U9P6aqB0VNh03DurSqzXuZzSW5EYvsc?=
 =?us-ascii?Q?/Wr3e559j+c53wX6EXDAoR+B0VPv2lTwdyT0pRz/yQQUqFqbnhEZjK8pdcyG?=
 =?us-ascii?Q?IYc4D84G2KEguH7nCpqz6Oq/PPxYdVTXppHNwbUKnSjtmQDFEz+xPRp0Ot6d?=
 =?us-ascii?Q?TDU1z85xZlIm3OCFU13yeJ5G868lu7t0S6MWSX+YkEWFG8OvzKuUdr4sCc1Q?=
 =?us-ascii?Q?dyM/0SZXWv5Agn3MPQk5ZC9RQgSSNTIWSUbaX4rfL09p4IxdnDmbgQElr7Og?=
 =?us-ascii?Q?ygJjSJvSf5h81TmPuQ2OPXUNgZ1Xfzqrs2WMUWEzXgHvjy8YloPtZ+uz0/mW?=
 =?us-ascii?Q?FBLhoT6F5mMNMowvVZntPk01ULr8fFGg6OoV9esYiAMYSfgUZD/WDAEYewVi?=
 =?us-ascii?Q?P7egXWS3S1AxEeL4dxA9MUkScymw7GyPbzgnPetDe2EJDVWXd+PmpQwf8izT?=
 =?us-ascii?Q?6JPyJ7Ey+sujF/UPkTDgWowPlX/1ElI+fSwNtHuG+MdCl8w85wAyXHdAxC2Y?=
 =?us-ascii?Q?HEVjWw5nlImX+/wAmVtbJAsl11MDjGurjWuZJ94PNPGUZ0+ee4CC6AHZCrcl?=
 =?us-ascii?Q?mKqcrg3h1eyA1D+DHZC7eJNu5K2gsCN+XBlt?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 11:23:06.6115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2daa60d9-9fe9-4905-eab6-08dd857de21b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
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

For non-template API on top of HWS,
geneve options parser is created by the pmd and not by the user,
therefore during validation , the parser is not yet created.

The fix is to ignore the validation of geneve options in
case the rule is a non-template rule.
The parser will be created later during rule create.

Fixes: 80c676259a04 ("net/mlx5: validate HWS template items")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 35 ++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 20d38ce4141..09157e30090 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -8475,10 +8475,11 @@ struct mlx5_hw_pattern_validation_ctx {
 };
 
 static int
-flow_hw_pattern_validate(struct rte_eth_dev *dev,
+__flow_hw_pattern_validate(struct rte_eth_dev *dev,
 			 const struct rte_flow_pattern_template_attr *attr,
 			 const struct rte_flow_item items[],
 			 uint64_t *item_flags,
+			 bool nt_flow,
 			 struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
@@ -8646,10 +8647,16 @@ flow_hw_pattern_validate(struct rte_eth_dev *dev,
 		case RTE_FLOW_ITEM_TYPE_GENEVE_OPT:
 		{
 			last_item = MLX5_FLOW_LAYER_GENEVE_OPT;
-			ret = mlx5_flow_geneve_tlv_option_validate(priv, item,
-								   error);
-			if (ret < 0)
-				return ret;
+			/*
+			 * For non template the parser is internally created before
+			 * the flow creation.
+			 */
+			if (!nt_flow) {
+				ret = mlx5_flow_geneve_tlv_option_validate(priv, item,
+									   error);
+				if (ret < 0)
+					return ret;
+			}
 			break;
 		}
 		case RTE_FLOW_ITEM_TYPE_COMPARE:
@@ -8913,6 +8920,16 @@ flow_hw_pattern_validate(struct rte_eth_dev *dev,
 	return 1 + RTE_PTR_DIFF(item, items) / sizeof(item[0]);
 }
 
+static int
+flow_hw_pattern_validate(struct rte_eth_dev *dev,
+			 const struct rte_flow_pattern_template_attr *attr,
+			 const struct rte_flow_item items[],
+			 uint64_t *item_flags,
+			 struct rte_flow_error *error)
+{
+	return __flow_hw_pattern_validate(dev, attr, items, item_flags, false, error);
+}
+
 /*
  * Verify that the tested flow patterns fits STE size limit in HWS group.
  *
@@ -14252,8 +14269,8 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	};
 
 	/* Validate application items only */
-	ret = flow_hw_pattern_validate(dev, &pattern_template_attr, items,
-						&item_flags, error);
+	ret = __flow_hw_pattern_validate(dev, &pattern_template_attr, items,
+						&item_flags, true, error);
 	if (ret < 0)
 		return 0;
 
@@ -15388,8 +15405,8 @@ flow_hw_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 
 	if (external) {
 		/* Validate application items only */
-		ret = flow_hw_pattern_validate(dev, &pattern_template_attr, items,
-						    &item_flags, error);
+		ret = __flow_hw_pattern_validate(dev, &pattern_template_attr, items,
+						    &item_flags, true, error);
 		if (ret < 0)
 			return -rte_errno;
 	}
-- 
2.21.0

