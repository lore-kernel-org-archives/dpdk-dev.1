Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59375D2505D
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 09:25:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5999440BA5;
	Mon, 12 Jan 2026 10:25:16 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
 by mails.dpdk.org (Postfix) with ESMTP id E91F740B94;
 Mon, 12 Jan 2026 10:25:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+UetnevBlAX52RUf2MPpM7wCCbiyIokU9OboT58h2HE8eRsNaKBB9lMdD3PZ/XCSRdEyURO/zqPfibqfMQDiWfCXEYNxsTrS7MmKMvOg6QqMUngW0KPR83BmDxPtjnTk8lgf9Tvigh5Y57tinoUl2u1P1piVoLaxY3SW7nb0x9qxkBinPuMzfuR34xNOvWUzC73xxV8btnl3DAJ++rkynq3W7VHtdjtmzHZyC39w3CnIRwXIkj08/urWIoCPxy3tiqQ+VU67N7nJRrQmd+d4GeSIzRC18oWzY5IGLpiWS7uFYGtiohJoFAnbAaFc+5nE4Ghb63f2cGYR6NQw4jiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+VR2+adNGMBKjGzkHdkdOVjf03jCn8P/WaFqzTQTAY=;
 b=BgVjAeYj4IfTmVFoEGOa3mp+bBYXRGlCuuTy3pizV2Ro5FpxUGV5vMI/X1tYGV4M0mYiy1bCPsnMo03q+DIESNP2wSjTZZvqmdpLpO289BA2TcABXulWiksJT2DTzWkyKlC72mkd5CYOU/Kun/vQDh9oRUJ3fptrRlo2TkaQqC2d1LrWD3aGoOwnVEO85Hgpf7lLq2T7FRx64WNRZaWISXTr17uEJF7SibDrW1s6jj9kNyo/5rSaKCZj/8XAGh2ewmD6zXyQYf+OlVB9UIwE6xmCJfyemRwV50GTCgeM6NbestcskPJHVi7fZ2zjSZxZZ1CwwRALduNWWRtc8KAH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+VR2+adNGMBKjGzkHdkdOVjf03jCn8P/WaFqzTQTAY=;
 b=XepRIRbI0fesKfOhdt4XyWiBedYTwNGTdP/nnoKxVt0/0WAbF1nsA/se11+QYjrQ13Nd/vKdU97IZikX8Sfq6S8XXww+JFJqx6QP+BzDCiyCoctKfBI10ZR6FVH6y/g+BBWU/aklBtAhJDTgXm6Ty/H6QJ7r4yfF/wwVysrX13iRuLB7pI9JxoMEzUyCAKDMgWLDGBxIjOHq5oDoJRQ3Km8cHjsv04Q9jDV0izfmHpjh6LCmUJLvXLNXQHMB7PLCmORd2GsxdzJEKmIJc1i3xdi6LvieclIMGxxd2IfqBljEo7WLX1GBKJFkMFQhhbC1mzJz+WU+PXtZ6W7epaFs+Q==
Received: from DM5PR07CA0119.namprd07.prod.outlook.com (2603:10b6:4:ae::48) by
 MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 09:25:10 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::75) by DM5PR07CA0119.outlook.office365.com
 (2603:10b6:4:ae::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:25:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:24:58 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 12 Jan 2026 01:24:57 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 01:24:55 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Gregory
 Etelson" <getelson@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 3/4] net/mlx5: fix internal HWS pattern template creation
Date: Mon, 12 Jan 2026 11:24:37 +0200
Message-ID: <20260112092439.14843-4-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260112092439.14843-1-mkashani@nvidia.com>
References: <20260112092439.14843-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: e72b1e35-b056-4461-f82a-08de51bc7b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NfkuptvZiaxFQKDTMRfQcwmjCPWhqeHnBhL9f96YbjNhiigNWCj2adqZGIDW?=
 =?us-ascii?Q?JZGEjIxZTGznu4B4ff8PxRTr2o6RMKpklMFjJVll4kbtfx543TyeCN9JmtQz?=
 =?us-ascii?Q?3rfoH584IARuFCKi4McaTyzZkTX5+2AaR6fuCc2Q8Ov5SFi+cUmEUveYgmlb?=
 =?us-ascii?Q?5Ap7RGRBy+lTUGyalwe7jDJouHOTYZ4IDUtCJgSkPuRB9LTJHVWtYmPOfSXD?=
 =?us-ascii?Q?Mt4kWB/Euya9BQxDdkrzPPMEpmlnsg/SuYghEl2VtVboaDkddX9l0NBCQQHZ?=
 =?us-ascii?Q?jYh+vMkVIVgU3JPEVeROqQbdr9JJNkIwq7n7UydtaSWyVM3djLZs02yoWV0k?=
 =?us-ascii?Q?jhMP5eRbmd/MBI3Nuz/1IQHzRRh0pd/F+fHjsf0VZoE5NqGvjgzP9eET8CRX?=
 =?us-ascii?Q?qP2V8g/gOPrvB2ci5huD2f7kPXSzi3y8gOwykvGFbmszsTq3UodLh+1MSoWp?=
 =?us-ascii?Q?/XCXyqVwBJZIRa65HF7WFsnHfl4DJ3tUlEpftx0j8et+KWtH2s/3tXEuSTSG?=
 =?us-ascii?Q?C254U+zeL3cYxpVK2qhFLnPvUw7miVSiZrhj1WrwSdxabi1uUp8JVkbdXj+a?=
 =?us-ascii?Q?TdhaXQvKBHRHe3ZKDXv+ca8apRLuRKBaREsoQuO6a+Z4+5gabBfkQjg+scAI?=
 =?us-ascii?Q?cfNrWZ2FVxC3dSl0sd3v3y/ObA9tTS8fw7+ltA4mkezOkgL0bHoq9EOaMqnb?=
 =?us-ascii?Q?y3WjH/BFeZvvvFzTPWBugPnujI7zOrZh891ItK7cTVOLZMXmjBxhUphducTK?=
 =?us-ascii?Q?BOlbiAG7nf6OE5uXlLTdbDeC3pEZnFU4d97QcBHsLat1ArOsvmzuNuImGz9r?=
 =?us-ascii?Q?Y60GlAKAYM8SOHoINDslyh/iL8LZNP5d4kOi7Kyl75ligmCvyH089pPxkROc?=
 =?us-ascii?Q?qKdVi7q9A/aBQeivVVIi5eJYfe08qPsbf6Z2nJgGUUnQrOZnDccMXd1D8xNF?=
 =?us-ascii?Q?H7H71iGtmySmPlMLrnodDhacb3u2G1s+xRZtLes8go/Nwpcn7aMZhaebBtMN?=
 =?us-ascii?Q?CfY/tj9vigfrMfqAvUKPZEhWYj2gVdCSDKYMH4tuEqVTg5gio8Z80wVIGnlu?=
 =?us-ascii?Q?hi+FR9I4l35tqMJOq+OsHpjGrorBa/92gTdM73315n90arZuPxgiaxoz8tAk?=
 =?us-ascii?Q?sedGRq7q1GGz5qF5/3xrDwCTNvzFmBnKhNfQpho71I+e5Ro7mIHyQfTrrVF2?=
 =?us-ascii?Q?cAcfdw3exhXU0M1AoYPu2Ql12N/Kt7hXPDl0Vi35LflfP5GMHW1LLszRgHvD?=
 =?us-ascii?Q?IQYSW9BLI3GOVr5wiPwjAbc1w6GQLqfatgBburYEdoNwYwhvIfKANTFtre/k?=
 =?us-ascii?Q?ANeMfTSiAXQfDMmoqMBKjU1NFweEsKPz+crbaE/pTAxZ25BxSFIhls/5QQzY?=
 =?us-ascii?Q?yX9GIb3ULReRfpCz9akmInoUu2/YEUxvdCI0BwggX2jG+LXIZ9xfs540GpBt?=
 =?us-ascii?Q?ybucyb27zdpCdnpW5Wub6M/X9XJXePOMo80NZkeuj5pJHeoyop5rBrAbOmeH?=
 =?us-ascii?Q?yY1gx0oDDzFyrjrqqs1A2Vdt6VGuy/DdYzxFe5Y+ZZ8Nj89rLlQL2iWrOsqE?=
 =?us-ascii?Q?8+AnfpaASZQbNtey+z8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:25:10.1147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e72b1e35-b056-4461-f82a-08de51bc7b9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
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

HWS pattern template creation tries to build a table with
the tested items after basic verifications to check
if the pattern is valid.

Time consumed in that table creation can be critical for applications
that require fast PMD initialization.

The patch separates pattern templates to internal and external.
Internal templates are created by the PMD and are considered safe and
can skip some validations.
Pattern templates provided by applications will be fully validated.

Fixes: a190f25e6a93 ("net/mlx5: improve pattern template validation")
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 35 +++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 1dada2e7cef..4af654967ca 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9110,6 +9110,7 @@ static struct rte_flow_pattern_template *
 flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 			     const struct rte_flow_pattern_template_attr *attr,
 			     const struct rte_flow_item items[],
+			     bool external,
 			     struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
@@ -9264,9 +9265,11 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 		}
 	}
 	rte_atomic_fetch_add_explicit(&it->refcnt, 1, rte_memory_order_relaxed);
-	rc = pattern_template_validate(dev, &it, 1, error);
-	if (rc)
-		goto error;
+	if (external) {
+		rc = pattern_template_validate(dev, &it, 1, error);
+		if (rc)
+			goto error;
+	}
 	LIST_INSERT_HEAD(&priv->flow_hw_itt, it, next);
 	return it;
 error:
@@ -9285,6 +9288,16 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 	return NULL;
 }
 
+static struct rte_flow_pattern_template *
+flow_hw_external_pattern_template_create
+			(struct rte_eth_dev *dev,
+			 const struct rte_flow_pattern_template_attr *attr,
+			 const struct rte_flow_item items[],
+			 struct rte_flow_error *error)
+{
+	return flow_hw_pattern_template_create(dev, attr, items, true, error);
+}
+
 /**
  * Destroy flow item template.
  *
@@ -9890,7 +9903,7 @@ flow_hw_create_tx_repr_sq_pattern_tmpl(struct rte_eth_dev *dev, struct rte_flow_
 		},
 	};
 
-	return flow_hw_pattern_template_create(dev, &attr, items, error);
+	return flow_hw_pattern_template_create(dev, &attr, items, false, error);
 }
 
 static __rte_always_inline uint32_t
@@ -10182,7 +10195,7 @@ flow_hw_create_ctrl_esw_mgr_pattern_template(struct rte_eth_dev *dev,
 		},
 	};
 
-	return flow_hw_pattern_template_create(dev, &attr, items, error);
+	return flow_hw_pattern_template_create(dev, &attr, items, false, error);
 }
 
 /**
@@ -10236,7 +10249,7 @@ flow_hw_create_ctrl_regc_sq_pattern_template(struct rte_eth_dev *dev,
 		},
 	};
 
-	return flow_hw_pattern_template_create(dev, &attr, items, error);
+	return flow_hw_pattern_template_create(dev, &attr, items, false, error);
 }
 
 /**
@@ -10273,7 +10286,7 @@ flow_hw_create_ctrl_port_pattern_template(struct rte_eth_dev *dev,
 		},
 	};
 
-	return flow_hw_pattern_template_create(dev, &attr, items, error);
+	return flow_hw_pattern_template_create(dev, &attr, items, false, error);
 }
 
 /*
@@ -10309,7 +10322,8 @@ flow_hw_create_lacp_rx_pattern_template(struct rte_eth_dev *dev, struct rte_flow
 			.type = RTE_FLOW_ITEM_TYPE_END,
 		},
 	};
-	return flow_hw_pattern_template_create(dev, &pa_attr, eth_all, error);
+	return flow_hw_pattern_template_create(dev, &pa_attr, eth_all,
+					       false, error);
 }
 
 /**
@@ -11553,7 +11567,7 @@ flow_hw_create_ctrl_rx_pattern_template
 		{ .type = RTE_FLOW_ITEM_TYPE_END }
 	};
 
-	return flow_hw_pattern_template_create(dev, &attr, items, NULL);
+	return flow_hw_pattern_template_create(dev, &attr, items, false, NULL);
 }
 
 int
@@ -15574,6 +15588,7 @@ flow_hw_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 	return 0;
 }
 
+
 const struct mlx5_flow_driver_ops mlx5_flow_hw_drv_ops = {
 	.list_create = flow_hw_list_create,
 	.list_destroy = flow_hw_list_destroy,
@@ -15581,7 +15596,7 @@ const struct mlx5_flow_driver_ops mlx5_flow_hw_drv_ops = {
 	.info_get = flow_hw_info_get,
 	.configure = flow_hw_configure,
 	.pattern_validate = flow_hw_pattern_validate,
-	.pattern_template_create = flow_hw_pattern_template_create,
+	.pattern_template_create = flow_hw_external_pattern_template_create,
 	.pattern_template_destroy = flow_hw_pattern_template_destroy,
 	.actions_validate = flow_hw_actions_validate,
 	.actions_template_create = flow_hw_actions_template_create,
-- 
2.21.0

