Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ED2D58B0C
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Mar 2026 08:44:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72A9D402E7;
	Sun, 15 Mar 2026 09:44:24 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
 by mails.dpdk.org (Postfix) with ESMTP id AC3DF4013F;
 Sun, 15 Mar 2026 09:44:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEiEwsU14FAXNXvrVuigsLDNMSSsFnxuVQ2ksWQ8osK5j0KcWterq7VUG84KcQfE/sj1PY3jw37B0DDZG6eNJOFEnsyUfxWv40tMr3X6oqm9lDvsgRYMU+nwUN2z01InSmfMaltDGMxq3O0WclaOX29wT7TTg6TqaxEfiVzln2wV2E2VL76IVueTiQA/Jx4y/uZIWAJ4FeSUvw205+Oa+Rt7FxaZjdQ+3d//M6F7gqDV9V5X/t6bQYaaUBHsJGCe1ZLtgVNq0HYFP1eTuigNs6UN2QxOFvV0fMgeI3vW1wj32PLvV7KBk5rV80uTf44c4rntH0ISfxN3EnNAPzrZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbjo4iAGkWaxBqwGSj+WgF/QQY5pEq5rhAgEAhhrso8=;
 b=c8TgBX534LOrCkt5adrt2bZsaXIMEMlSzKXEcUf/R8tUkhiC7C7AzQjjeh/wT9uoHCqLCOJq5CwGR5E84uniRBsGWZrUuQqfY4gbhEfDAYuv7GV0ZIOFZ0sYFzP8foaCCuJt7sdmo04UaYxipMHRPg6YwAQ1pGDK2G4RSiO2pJoUjQpDSeWRoIDNyvwfVTTjTeACZR7cY4+d6RHUKj4sIp8wtxIXTPFsr3igYNxjfQwZmkluKxJHBWX0rylO6dlyRKQE871O7+8UytdJ+N1Q6NyKfu68a6BlD8DdR2XX42jEo1wRXSwVbNZKMzlXiBcpmkGtwJBV5lrAGEPWYsqZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbjo4iAGkWaxBqwGSj+WgF/QQY5pEq5rhAgEAhhrso8=;
 b=ero/Q/o2JQzgE2TalFANYCdepYwr0X55GQRen0QQfOUP03Ie9Ti7NEvzuegP6d8ws3qYkIQx5n+Ti6khO6vonleavyXhdaCWdSMimSCf7/dHdggjR/43bHCtTc1DF6cD2RL9ctNXCIN0qZieUcOgBzVn2BgmrDTnNSsFN/7a4N9yjZqx+VlI5QzY0TTbg3sVFSvNdnV1VC23en1AKkfV6wjeEkMDkMbud2B29wJybE8k3c50V5wVuygCtBRPpMYTH9FwibPMTKsbmZ6OgAOMYGfOMXVy4vgiSzE7KKdCAgmX8CHn53a6cPRyISshlE++222yJXgXXl+Xn3IAF4Of9w==
Received: from CH0P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::13)
 by SAVPR12MB999143.namprd12.prod.outlook.com (2603:10b6:806:4e5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Sun, 15 Mar
 2026 08:44:20 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::f4) by CH0P223CA0017.outlook.office365.com
 (2603:10b6:610:116::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend
 Transport; Sun, 15 Mar 2026 08:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Sun, 15 Mar 2026 08:44:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Mar
 2026 01:44:10 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 15 Mar 2026 01:44:10 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Mar 2026 01:44:07 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH] net/mlx5: fix heap-buffer-overflow in sample group match
Date: Sun, 15 Mar 2026 10:44:04 +0200
Message-ID: <20260315084404.94506-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SAVPR12MB999143:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a5d97c-e6f5-4f16-247d-08de826f0c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: eMjd+WOhWKdGLsT5hnLvqu8a7xYaEP+vOuBqszdKDuW2YEYAb0RS1Trp7MDJz1i2J5pNA93s5nIC+P0O1gOKg73Cmev7wvVeSzj/rqJVOJ9AnUNZuxmlI5dFnlmVZbCPzWzCK4R0sRVYjfdNbM3g/tHytS26xwqm6Vku/1nhwJbADZgZNe3bu8JQyd6ipbsFugXB6k3HjCJPqXh/eUS7IlGHZAVGi8Xcowh5AeADM5xgBFsJAGvFwd3UlLb+t6+D2EIwzFGayvJvB7ewKSkuxEH2psNGsYeT8utE15mi/Sikx/xqjFhFMDR7kRIdYtyG7sUcfnDPbjE+8cKpCI6pMknsknjM1V5Cgi3HSmf2xvBtsyJ/uZpj5JBX5P0I597/Kbw0b1jD7IfnWUO2p4VBXXIe1FYeHtQ4L4enTNtsO1OPw/BlPDOVQn1XJqKs5LyxhK8p4Om7fe7JSG1M/fDl2S2Jii0WjnWaXYTwOD0N+hwi8P2DA0AZR0ZjcORk/aknJ34XbMiMNb/qhNyLB46LEVnKivN2H+OD7ahX3YbMH2CdAB9jAQ4FLn4iP2WDmL7CL+IoGfd8ysHy7h1gNw3JZ9xHtlPfF2355+DVKSjaJoGErGZY0beJ46VTvk4Tt4kTgrgdB3KOuUI5RYu0kthAxjivdCRYVY7JhpXD2GQ2zh2UABuJ70pmREhg83HGPWFSDfHHNgFy3XGH4GsVOd6PD0NA6vvFf0SEsIqnNhlj/r/pYCHIwNoblyppVkV9O13GnL+KGdHeOkafWQlM9Y3N5A==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ci2eb+UdS2MZnLDUWwM2oC4cE3PGHzUGRqKN5bUcIFT8c2nwjW8hfvfMsSgRw9PZz/ouoo2WffAy3N9hS2pI6uPGZpSLfSKbMaFEBKQGaDQhHAYCPkwrccPNMP1BENDayb9L5ot288TTvxfHLtO4oklLIwFJhpDRp0xZXewU/yBHKWLXPlMxsifTvfZ2ceRmVwIa1VfubhRCVJ3Hlu9m4Me5fYCXYBiOooX+/S+cArXFXitvVHOgoG3vdBCXma9wlXlIm4jyz+sPho9xFXI+ZO5E3lpmd8nnGunZHn3WSF5G2eUbaZYbe6/uMywt8dEkJv/bFgh6j8KTG1xBhM2+7moe1mQKFSKsoOyQheHAjFie19L2cNM58slCzr04i27e7pt3mG+oW2Av+XcEZ7QxMqR1MwQZWj19OFiyaRgAhmABgNxtTN5ra0FZNt3ApUaC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 08:44:19.6435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a5d97c-e6f5-4f16-247d-08de826f0c9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999143
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

The cached group match callback compares serialized actions
using memcmp with the size of the new actions buffer.
When the new actions serialize to a larger buffer than an existing
cached entry, memcmp reads past the cached entry's heap allocation,
causing a heap-buffer-overflow detected by AddressSanitizer.

Add a size comparison before the memcmp so that entries with
different serialized sizes are rejected as non-matching immediately,
avoiding the out-of-bounds read.

Fixes: d986f04d6529 ("net/mlx5: add functions for non-template flow sample")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_nta_sample.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_nta_sample.c b/drivers/net/mlx5/mlx5_nta_sample.c
index c637b0ede3..158720fb87 100644
--- a/drivers/net/mlx5/mlx5_nta_sample.c
+++ b/drivers/net/mlx5/mlx5_nta_sample.c
@@ -293,6 +293,8 @@ mlx5_nta_sample_cached_group_match(void *cache_ctx __rte_unused,
 		container_of(entry, struct mlx5_nta_sample_cached_group, entry);
 	if (actions_size < 0)
 		return ~0;
+	if ((size_t)actions_size != cached_obj->actions_size)
+		return ~0;
 	return memcmp(cached_obj->actions, obj_ctx->actions, actions_size);
 }
 
-- 
2.34.1

