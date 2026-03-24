Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB6CF54ADE
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:11:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F365040B95;
	Tue, 24 Mar 2026 18:11:10 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
 by mails.dpdk.org (Postfix) with ESMTP id 01F5E40B91;
 Tue, 24 Mar 2026 18:11:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkbxGiwywqbplW6p7GZtfUPjbkyJOKxeDCqxabI7E5z4M1rXDo+S3bSZZ/doK3MvMTzih3QzpLjYjsmm2vbVZSLKjsiLnrpT/bbwtBpJwdlQJhoOpv0F+o4VOF/ehUp3bSahds8fBrYL+QYbLwxMhv4xr57N4X2ax1L+c+u5v6eLvlKJvbs9Xr8w+aj1ooeWc789/0S7EFFHB0zzSfCqM/QWuKobJ9gWBdL2KvPjMylDOsZ9gNsIt5Lig3MR1242OYuyoXNJ4RlyFhQd+GgwbJmUTmE3oNiRMFciVN8ERxOkRx2qGmHgC6Fi3eu7qHIyB0tA/3gF59jG5M1kD12Lxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RramDX1TGPdIh39X2GnZn/NWr7X7PnC+ROImt4osjr8=;
 b=SyHNugnS253aETlf+a5a2msz4jXWD6vinAo6CLZltNmYpaRixnIRl0AG9AVgNASlcUuR6MMVeSg2HxIZubm4c2U9LbSCmlTB6teoOVJEdFBv67569fJO2WQDJZuX+iQG+aT/jNpelCosOhOy0gyoOSh//4WsDoDYStP/PgHmIpS1U8LHisQ5lYraBDg5J07roAdFCzfowfxQ7ZqiNz/mjVA2YJW9jCeDPDl6LEB5dNzO2bmHNMCqFrfClyq0A6Owyt2MwP7FJ68I2uXu/ylvY/u+trh1+4TcWFNdbjYidab7ZgrRv9xYVICc0gOewQLQfH7w9RV2whLCeBeS/Qen/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RramDX1TGPdIh39X2GnZn/NWr7X7PnC+ROImt4osjr8=;
 b=NQw03UVbnePAm8xCqNd9uG7ItFSJmYrskQZ6Ln4Oy1E1mGZ582bkMnMFp81mfR0iZ+jnoFtekJqg5FAvfhx4GBy2agk+gNX7ASKse9zauO0SoRopSHVXVgBvg+AUzCCUF/JXPuLWygjfuxA+anGbf6YbWvizwEOU+DZId3PuTMWEQI9PXhU1QV2k9wIRnyU5n070kI5fZJRSJhqlqyuXrIHQSOFpwa2qzVWhgvwUQd997xr6TUl/LYwVQ/pEOwZHhaR74hIekKNWlBXC4DoF1mEKQ7P2JQ8RVmcJbrW7G0HvTMsQLIHAhnyeZm2qqUv05EEmn3sXVRg1rHGX3uluiw==
Received: from SA1P222CA0195.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::8)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:11:04 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::6d) by SA1P222CA0195.outlook.office365.com
 (2603:10b6:806:3c4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:11:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 10:10:47 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 10:10:45 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH 1/2] common/mlx5: fix error logging for queue modify
Date: Tue, 24 Mar 2026 18:10:27 +0100
Message-ID: <20260324171028.26727-2-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d436e4-559f-411e-e870-08de89c854e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DuHoIbfOK49Jw7p4YuJA/bgBfjoQY3hsHnDSgzOVg+7Fv5tqypChfYvkUA/noVoQEYljclmB6kmNOZTJ4KAXg8g3K+lSqbPXZK++R66pq6yAuwc6CS3RhmxWkvuaxWmZUe6xiAG07eDz14viQSHWUZL26LTb3UA9b5xUc3a1MXfs0qqIlzoLyTX3dBQppXr/yvrwHSQq3uBvqPhjWE6OHMF9OBJsaffBkaXFgUdNTKgwP4lETkPgVYOPD3pBE7kO8+go+DfxPAHsHdcQi22ic7HGS2280Pn3+mOEbF8gun1nNAs4l02qrBbK7Wqtfn9W7h4qoG+BHICMWvstuIULVriOa2gSABiXvUEL5m9r5TntfBzeoaPJSiSHennOQjwe2UkghTs9AdA1jlWo6xe8JIpjaJHBWD8DZBekRkDuFkTiMgNvoXSg7vWWvK+0odKy+nUSS9jtujcDxpTmWcOvdl5OU7J+yO38rjbu+9lqEQWsU2OO4bK2+aTs6Ch+U1CV01lKWIR4I7KmFWZYNQgJ6hJIaSdn7nLS14QPXknI3Oc873UDp8jzlLGjKwqgvB4TRaMHCSPG6x6YZ2Xun2dffQyAWinegBmmvxRkk5+8MUiBK0gECzoO28nSheEH9g6RKHGse05cfPfOhX3o7CLWX+McIvYrJIGdpiy6ABq5tTmZwRHDGFE0d4LQekIhSQrJuMlfm5cgWij//f2bh525grFI3NxNztOUIUe+fmVfuG0dphCqrr1A0biviXSttVv2sK8OmVhO+RbMso6I6OmBGA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: phILEd5bR6aNOZdM6JMsqLe1vX4U82Eg0XtXoXF0YbvdMrkaFaoOkWlzSEk7xFQuE5rJUpVxALySP4xbJ2fTjPWrzhxx/mMWaBmiN9dMYZ77YcHxlRbmIaoyNmqV3s0kdcB0W2XWxojoKa1VP/V0WPiVkfq4lgbO4gb8x6hM8WKFiFbk2IIiKIavfsiWbCRS+tk/Zmy9Q1HF2BnqWXrNg6TrV8WkVIVNOeUNYc5whEKjM/mgsBDbWUGkT84cL2f2rRR6VmfNeNML82qUSrqJoqOhhhaOw78HJeJecd8wV2a9RzGWls/riXKaPIU++TJSRb879+Skz5nziUyrnABRVqeYl9EgVtCtCV7gFTCCca231dSkVUBdmcbmKB5R0mW/sKHHuLfu/nJaIBhOMF/m3ULN2eUec9hIS7cNiruCud/6jwIbW2D4eP6ILQ5I717/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:11:04.2393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d436e4-559f-411e-e870-08de89c854e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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

Add missing verbose log of FW errors when modifying SQ and RQ.

Fixes: b0067860959d ("common/mlx5: update log for DevX general command failure")
Cc: getelson@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index d12ebf8487..d46aa045df 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -1672,13 +1672,11 @@ mlx5_devx_cmd_modify_rq(struct mlx5_devx_obj *rq,
 	}
 	ret = mlx5_glue->devx_obj_modify(rq->obj, in, sizeof(in),
 					 out, sizeof(out));
-
-	if (ret) {
-		DRV_LOG(ERR, "Failed to modify RQ using DevX");
-		rte_errno = errno;
-		return -errno;
+	if (ret || MLX5_FW_STATUS(out)) {
+		DEVX_DRV_LOG(ERR, out, "RQ modify", "rq_id", rq->id);
+		return MLX5_DEVX_ERR_RC(ret);
 	}
-	return ret;
+	return 0;
 }
 
 /*
@@ -2116,12 +2114,11 @@ mlx5_devx_cmd_modify_sq(struct mlx5_devx_obj *sq,
 	MLX5_SET(sqc, sq_ctx, hairpin_peer_vhca, sq_attr->hairpin_peer_vhca);
 	ret = mlx5_glue->devx_obj_modify(sq->obj, in, sizeof(in),
 					 out, sizeof(out));
-	if (ret) {
-		DRV_LOG(ERR, "Failed to modify SQ using DevX");
-		rte_errno = errno;
-		return -rte_errno;
+	if (ret || MLX5_FW_STATUS(out)) {
+		DEVX_DRV_LOG(ERR, out, "SQ modify", "sq_id", sq->id);
+		return MLX5_DEVX_ERR_RC(ret);
 	}
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.47.3

