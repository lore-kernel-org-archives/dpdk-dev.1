Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37A9C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:40:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B375410DC;
	Tue, 17 Jun 2025 15:40:38 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by mails.dpdk.org (Postfix) with ESMTP id 0894B40EF1
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:40:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjJtdJTETUBQDwpx5WjV4u8/YIVzXdHksQ3yWy1SClyG446y4tbErt3WnqBZvSaOtpNL5mjDTPiiIcWC2fAUhlSxQOYmVkuLOOAiO4Jc9+ZzHy0Vb2y9HJhiogLFi7dhJwFLpeNvl/clEjUfGZPsnZOJgnELo3MmaiLgSsSE5bIlC97OAzogYYq+74SxloqJ0tq+VR3WptejZ3st8DXj6IwjI9Yf8OXVZ7IfcrJWgkwyqQ/U7rXUpfUNmjToabNU4IzD64xBbD1JGf4Yy1LGPCG8wqfekIboKuVu7Fq3nSS2Ab8yiQDil4u/HltTtZaniUvXSViiCuTPy2NCdC2lag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9+SRt9LhuEzRkIA6MI0dXl1m1Tzewa+M+iGowab7oQ=;
 b=JjTM3C8pOZy5jYo+c82WJUI2jn1MDgF1YDKZXGcgsovLGteYnj2Nd4k+OOic5TFk1SXb35vWvu076SaBJLbhN2kECR3A2eJZ6X3+/KPNvG+NRsZD0Zkysth+nY45pifQeX78B3VBcvplirDOfQG9vsf6GdX5V4pkH1dmHknOuXqk9O+gYs5oCX9SaeqaE5fP9CUlQacGUAIdLywvHOUSlaTwj2+9r4bpjMpWUSNVtu1A3yhNaP79XNV6NqIILBPFWfr/DIm8/kWI+8IQeD3AaLftpYJBPAiUlOozu2tA762loQ0EWKWdmHRmb6jjP5Xf/94J+tLjK/zwTByvrnxH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9+SRt9LhuEzRkIA6MI0dXl1m1Tzewa+M+iGowab7oQ=;
 b=OEKlG5PH3NqpLcDFVirl9iuqVMcmF1YkgeYhtuLJwqZ8w+DKPraGIkic3xAYQR1p5EgHvDGEeZJ57pab+v0k9CoGZPqFCmlK6iB1ZLLNhQXVIYOKwe4r6UqXd+KQGBKN3VFiKCZqM7LFhdOMqAVVT48MD4QTnl8pyiftmUwc5HOCmTnzN1NXGmA0NlJKQrCi/7mVhMGHWQ5hzv2UiAHIb19qdYKEC78/50NCXf6u8UOacydzl1h7yPOMrQG4f0ZKKWkn8PvjPzieaEfRwntxAGfEancrLQubTSi4rKGGVBD0pHgxC3BRNogYjwmAkAHdRgCUq/wAwkwPW9Ksq7C1pw==
Received: from CH0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:610:75::20)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 13:40:32 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::cf) by CH0PR04CA0105.outlook.office365.com
 (2603:10b6:610:75::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Tue,
 17 Jun 2025 13:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 13:40:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Jun
 2025 06:40:16 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 17 Jun
 2025 06:40:10 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 4/5] net/mlx5: add MLX5 mirror flow action
Date: Tue, 17 Jun 2025 16:39:32 +0300
Message-ID: <20250617133933.313443-4-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250617133933.313443-1-getelson@nvidia.com>
References: <20250617133933.313443-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: 36203b07-f5d3-4501-8a2c-08ddada48803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ty1FidOL38vvOrtVRZDunbX/EmhxVIb2ceHxw1aeLkR6JXYEQPH0K+LGAVrP?=
 =?us-ascii?Q?W8QmFXt9pDHTLRKO+bwt8PemzWYaEJWgtLBmqyO4ABDnsRHzeB/A/7mnWZ/4?=
 =?us-ascii?Q?kw4/yO10V6ITiJx8ugWrXe4I90T43DiKh3ld0phlUzD0V0jG58j8S+XCeIHA?=
 =?us-ascii?Q?STcZFuC0Ah4YfW/khDZEWhnp5wEe+FuU1VwC/dZclEjk2jWxHG/SZcAPLlhO?=
 =?us-ascii?Q?a+Mlf0nw1AfD7PE31cpzsqduYqh8fakzDovYHYEENKfJAMvs60A/UO1TMsvs?=
 =?us-ascii?Q?x119LUM18QI+xCBVmhb6sBZyVUVl9BEYqyBr+1gO37Zw022y/f3ioqoFpYlh?=
 =?us-ascii?Q?Y8eRHecn6aBKjHPHGsKNiFicVd7UCbyLFekKDfytUdCjouTB5xPioZHlIFoQ?=
 =?us-ascii?Q?JT6EQiB2aJjrubL1EWckZJZIIyRjKt5hoqmUxtyozQAC59ayoGW1Xhig1zpT?=
 =?us-ascii?Q?JMaRvTcAnganN8kdJXc2/nw988OcDP60Nx/4n5GuHczFCW7L3ghUCCmPmhG9?=
 =?us-ascii?Q?iw3FM0j1xnqyXoo50kIMp3UoOt+ZHPnyHxVqhYvVo3dd9Mj3Pu2McaXiqNH5?=
 =?us-ascii?Q?iEwaSjcA4Ce9Yj2daG+jQCs8dj9NGzXz1nQMDMp50xX3rqvz+Zmd1DTfk4Du?=
 =?us-ascii?Q?aWIY8KX9CmisksSGAOPSBURCxbBnre45A+LwsH1syLjNmf0DsuHMeiyPwOMt?=
 =?us-ascii?Q?9LSWlu+V36llPrY1MjkkTpIHELqF8GFz/F8hrRSWamnxiYaVVkamILoa1DSn?=
 =?us-ascii?Q?u/5PZUteEGvFmHr27nRf8Fy+FL4qHG8zDdCCST5rmDv8RTLf8eXi9yWzAWcK?=
 =?us-ascii?Q?8xJkgsWNnc+rj426iZSxxfV62d3ZTYe8WCrx8Qd6KkUtlfA+7FizrbFERMXC?=
 =?us-ascii?Q?LmyK0y+Zcnfn6620l6mqNywcI29C65wY6G3lLqWQf8aDWXkbt6U40FeFEMPo?=
 =?us-ascii?Q?zLnJ9eA+6Se3sGSx3gpYPIkfaQe/vzCgF6/ZXQNu1d0R9LzdPT9J7UJt6x9v?=
 =?us-ascii?Q?2WOL3wLe1QLi7lv8coOOQELmqaRg75NklhjwfcAKVSCAiHJ2hKKv/f19ODto?=
 =?us-ascii?Q?vffophO1WFZX0qmpr9OIHZrRXIBj7+NuDL1X+VjnV+0h2pqjvF/mwtDNzgNE?=
 =?us-ascii?Q?KBOitPZc4GPEVQB1gZQTqZGPimCjjPDKxtmXMGQ/9X313DQw/zH28M2gKO2k?=
 =?us-ascii?Q?j3mzMoqzzaqlvTt9QtbduNZxiDgdZ7j13nkxkoDZcvCuNF2hK9wVrIy+0ItR?=
 =?us-ascii?Q?uUQJPMOBJlmbOVBfKUA1g1MRyv06e8avIhxlMN7jy1j2Kuj6S1x5HyEdxJsV?=
 =?us-ascii?Q?yFYLnqE21uZwtKIm3gfUM7DCEwieTJmqkMmcHfnYKcvL3HW0+cWGAMALFGpZ?=
 =?us-ascii?Q?klbX937IVUA5sC6UElnrPABF2w9Di6kMll3tbjd9sstyNxdTBGV6e2Rmgn6b?=
 =?us-ascii?Q?0IEi9LhOCm4uMuy3O61liD73Fgnhg09zG092/lm54kFbjdI7xMbIonecG8oJ?=
 =?us-ascii?Q?1j07/J/YpcNFjHJoLpqymc14o1uxgbxG4Bui?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 13:40:32.3519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36203b07-f5d3-4501-8a2c-08ddada48803
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337
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

Add private PMD flow action MLX5_RTE_FLOW_ACTION_TYPE_MIRROR.

The new action type provides direct access to the HWS mirror action.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 4bce136e1f..8186b85ae1 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -49,6 +49,11 @@ enum mlx5_rte_flow_action_type {
 	MLX5_RTE_FLOW_ACTION_TYPE_JUMP,
 	MLX5_RTE_FLOW_ACTION_TYPE_RSS,
 	MLX5_RTE_FLOW_ACTION_TYPE_METER_MARK,
+	MLX5_RTE_FLOW_ACTION_TYPE_MIRROR,
+};
+
+struct mlx5_rte_flow_action_mirror {
+	struct mlx5_mirror *mirror;
 };
 
 /* Private (internal) Field IDs for MODIFY_FIELD action. */
-- 
2.48.1

