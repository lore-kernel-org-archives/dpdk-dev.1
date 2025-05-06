Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A0DC3ABC0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:32:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A82340608;
	Tue,  6 May 2025 15:32:47 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by mails.dpdk.org (Postfix) with ESMTP id 878F44042E
 for <dev@dpdk.org>; Tue,  6 May 2025 15:32:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfdJtRDULFRdwyLEsDZkJSvEOREz1RMlLeyWOT0WGnJtW5V0wHTSw8RLlOKNgpuiHgEa+l8tySkX1WhkuPCxhfRg7BiQagMH0mVi2p3OLm8ODe2AaHnBA3AogXrxhPmYPAkJ5oIg3BOI58GA0A31/MsSgPSI0vzm+5KN24DU1AZ/3v5Sc7NRZ+8uHsYwyavENfQCfC0J1lOoJgool/OB3T7KmmFN7kGtsN5JtCe890sUmqmtIVdDOcb/SZNwi739mAKTGwS+QlMNnN8bRuFoUTzlk0YGh9jJZyAU/WDUngqRJKBtB7N3UBo6P639rVcCzMiw2pI0/f9R+hP4FmlqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGkN0WJstzg+BurvBvKKH3jHV/5mbgr0W2rcrklF/6o=;
 b=iDgktPL4wtorRUAaeS3+px2yqGpU3HHH5NunbVyH1f/AwoKWQFkqDkCCzqKiFvBkLbaYjSb8Db5bCMt8k7Ha9Nth3tlios99X7WJQlFHUxsLMe09y1uKRvFB3NcJ2Y0EcsiuSwinDr79g82HV5H8koQRIrjvdyOyCLMwFPMeQK5XSQ8/Adw0s3FI41a5QZ8Jn/DKH8eKeHfVd6t6Bxv+Gu9cO9OJneEbu+Mm2MnDXv0T7G6bfbkoepm3+v2e47tB5CLms/8whFLnULlSPHZxAvjqYpyQs/+I9LzygKvvGvuw4TLEu8JUABiMwuVFWDvEMHSnSGpy/cuQ+ShsQjXgTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGkN0WJstzg+BurvBvKKH3jHV/5mbgr0W2rcrklF/6o=;
 b=l+xbhj2Qnu7tuFPK+z7s4o/f9ic0NmKJJT20NPrQkDIArr6AzXYY4DqaU+1YhsT8WRK5w3UvGOEVeFbWQtgKszWGnXDuXEz04zYC2gnUvUBJWFBWdS7yWoUJHd51u8X5j8cvQUqm6KctRGvV1R1bddv4j3Zln3niCItUDfD6+eg3t7lQP+C0+pKY6Bbg6LTCBA+pjTqZh6v8cMNioW4Ztw/GIDzMzO8noaLwWxMz/xojuf1de6p0FjjSHLSo2HLYMRWjVYgLbEqF+cV3Y1G3deaUnPehBIE+BBAgjVz2rQUHXUG/m3FKfIYXxlPRvOmpctwazV4lInZk9p3niDHMSA==
Received: from DM6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:5:1c0::38)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 13:32:39 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::30) by DM6PR12CA0025.outlook.office365.com
 (2603:10b6:5:1c0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 13:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 13:32:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 06:32:31 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 6 May
 2025 06:32:19 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix error notification for large patterns
Date: Tue, 6 May 2025 16:31:51 +0300
Message-ID: <20250506133206.379993-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: d52072a7-1a7c-4d7e-0ac8-08dd8ca278aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVhMbU4zR0JyL0UwVmthOEE0NkhUejYzYWVMVFp3YWhNVWVpYWR6L1RIMFFo?=
 =?utf-8?B?Y0RYQW9YQ0hHS2xzWTJYb2RHbitFa1BzdDVoa1FGOVQ1aEFTbW41UUFIZ2hy?=
 =?utf-8?B?NVdOa1hVbFg5bjdTMnkrMXpLMm04NEp5eFhwalR2VEg1L3ZBN1I2dmsrdi9w?=
 =?utf-8?B?bnBFZ2pnNG5FdkI2dDhVWURYd2tTaFcwNFdzcGZIRWtEM1RReGl6NGFTQ1Zy?=
 =?utf-8?B?a1BhbEw4SkZhVy9BMjZZdkpTQWY3MHE4ZDhWUTJIRTQxRnFuZ2luTG9ITk0v?=
 =?utf-8?B?UjBwZUU4TGphTysyM0w2dkZXLzc0U25uanBNdE5PMzlFZ2xHSDBpUy9KOTNz?=
 =?utf-8?B?c01aQURSLzRhKzNsaGZkaGh5Z0lDaFVSclNYaDNIcWQxWGtiMUFxeFU4c2hk?=
 =?utf-8?B?OTFIMWVIcW9ZcHFlUzRQc1FQRE93R3NrZU5CVjBFTjY3T0RJMDR0WWNTcEVh?=
 =?utf-8?B?YU1mTFJlQU53YUY5dVhhWGJPYkROd010QnArM3E4bHRnOXVHaXdqRFNBYkh1?=
 =?utf-8?B?YUU0b0FmYnhRL1VZamxjaldrRWlldnhkV3FLNUV6OEtCNlJUOXBDRGJWMHVT?=
 =?utf-8?B?SGZmbW1LdnlPTnJqUXdQNVhpaUlLZXFCT3NIQ1VqQysvZ2J1aGRPaG02dFBW?=
 =?utf-8?B?NFZuTlYrREliMDNCNDFxRXREQVQ1Y3dES04rS0JTS01tQTBzZ0hiVjBGK3JQ?=
 =?utf-8?B?M2V6MEVlODZNSnptNngrUWtaWlRRYWlCN0QxK3hMaHhHbUJuUGVoVlhDQ2wv?=
 =?utf-8?B?aTF2OFdVdXZVdmpFaldzdE12dTZKMld0V3ZWdE1Ma1loNVNHbFA5aTVEdnFW?=
 =?utf-8?B?NjliQ0pwMGE0N1JuWFA2RTZpM1AxbTVuMkRCaWhMMnMwOEJlajN5cUdPOHN3?=
 =?utf-8?B?bmtTRXFBTERYY1JVUG5lOXlTSmJpR3hqUkZvNzhUMUF1eGdvckdRSkJSY1p6?=
 =?utf-8?B?ZHdyOUR5SW15RVROOE1vaGdiQS9Lak5NanNTeElLNFkrVjNuaTlubmE5NFQz?=
 =?utf-8?B?b3pOUWsrWHppTVluNldwN3VneitnaFFSVVlHZmFGeWlvRlFnb1pOTlNqbHd2?=
 =?utf-8?B?L05Rbm84eFEycFNrKzh3S0dYYXFRY3llbERvb1NQTU9hRW1OT3J1UDBZbmQz?=
 =?utf-8?B?SkFWL3oxbWdqcHVzYmY5N3pNK1RGYW5pYS8rbnV0Z1ZWVlNCV0VycTV1d2Fo?=
 =?utf-8?B?YThLL0N5V0NTbGYyOVBwWTliMjdpL0tTY2VLNDJqMU04UTdRanpPOXA3QVhq?=
 =?utf-8?B?SlhPMUw4cEdhRkZHNUZYS2RjdmdiMnhpVC9IaVNsM2VWN1FyYzF1UUZPbFZT?=
 =?utf-8?B?ckFTUmJZWnhQYXY3dFJ5Unp4clZvQnRWbGlwSW91bjIydWJaV1ZwSmFlZGIv?=
 =?utf-8?B?VWtmNm1aaDlEU0E3RFpneEFkanVzRGtzUGVkNzVram9DZUJ1cFgxRnhKRThB?=
 =?utf-8?B?VTdIWW9oaHBqUjJOekdJRmhlMUFmbXd4SmlIaHpxUzQzaVF1dm9Bc004Mlhx?=
 =?utf-8?B?UEFUWnJLbzh3L3JETS9JdWtWbXBtNTFBZFQ4WWhWbzJJSkFyNTFpQ1MvL3lr?=
 =?utf-8?B?bHloSzg1M3o4bEVBQ0hPWStiQjh6SWNuZTFDaENyUmJDY3dwRFJVTUtlQktX?=
 =?utf-8?B?eDNYenFZL3d6UmdJbEJUS1VtNmFrWUFkdXg4WkIvc21RK09yZEZYcEZLaW5k?=
 =?utf-8?B?Tm5GY2VYekwrT2ZsVlhScExKWFAyQzJVM0c4MjQrWjkwTHVmY2ZSbnVqK3Jl?=
 =?utf-8?B?K2Z6OHEwR3QvTWgxdHo4NEUzQStWRzJHcVQrd0xGb3lEdG45L0NzTGpIOFNF?=
 =?utf-8?B?MlZPQjJoVXhmRDlnR3NuQ1N3dkVFdUNSVXhMNUUzNTY2dEVzekhRd1d1cExO?=
 =?utf-8?B?bTU3Z3dvWkEzNFhMSzBlMGdQMCt3YW4vR1dXOGRWdHF4ZWYwOTdjMHBXUDI1?=
 =?utf-8?B?ZmVlS29KcHVId0N5YlNHYllTbjBTaHFPMkoyaUlqcExRRHJRTnJCdE1nYU5Z?=
 =?utf-8?B?ODliN000M2xJVkFlVW1tTWlXMnRHRFdqck9XUG5qV3lEdEJadmNCUVhYNm1R?=
 =?utf-8?Q?TzOzV5?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 13:32:39.2058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d52072a7-1a7c-4d7e-0ac8-08dd8ca278aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
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

HWS has limited resources to translate flow pattern.
When pattern translation does not fit STE, HWS translation fails with
E2BIG error.

The patch verifies that the E2BIG error value is kept during flow
error notification.

Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_bwc.c | 2 +-
 drivers/net/mlx5/mlx5_flow_hw.c   | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_bwc.c b/drivers/net/mlx5/hws/mlx5dr_bwc.c
index 9233452118..0086cd2c90 100644
--- a/drivers/net/mlx5/hws/mlx5dr_bwc.c
+++ b/drivers/net/mlx5/hws/mlx5dr_bwc.c
@@ -137,7 +137,7 @@ mlx5dr_bwc_matcher_create(struct mlx5dr_table *table,
 						     bwc_matcher->num_of_at,
 						     &attr);
 	if (!bwc_matcher->matcher) {
-		rte_errno = EINVAL;
+		/* rte_errno must be set */
 		goto free_at;
 	}
 
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 20d38ce414..b79e629d52 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -13894,7 +13894,7 @@ static int flow_hw_register_matcher(struct rte_eth_dev *dev,
 		if (sub_error.type != RTE_FLOW_ERROR_TYPE_NONE)
 			rte_memcpy(error, &sub_error, sizeof(sub_error));
 	}
-	return rte_flow_error_set(error, ENOMEM,
+	return rte_flow_error_set(error, rte_errno,
 					RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 					NULL, "fail to register matcher");
 }
@@ -14070,8 +14070,12 @@ flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 			goto error;
 		}
 	ret = flow_hw_register_matcher(dev, attr, items, external, *flow, &matcher, error);
-	if (ret)
+	if (ret) {
+		if (rte_errno == E2BIG)
+			rte_flow_error_set(error, E2BIG, RTE_FLOW_ERROR_TYPE_ITEM, NULL,
+				"flow pattern is too big");
 		goto error;
+	}
 
 	/*
 	 * ASO allocation – iterating on actions list to allocate missing resources.
-- 
2.48.1

