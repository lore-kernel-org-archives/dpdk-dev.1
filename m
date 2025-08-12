Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8530CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 09:45:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BB874026A;
	Tue, 12 Aug 2025 11:45:28 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by mails.dpdk.org (Postfix) with ESMTP id A2E104013F;
 Tue, 12 Aug 2025 11:45:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrJaAeghw39Z6V5kqUcyA7tMvy5qyu0l45Kosuls332kk/N4wM4UTX3UBvzo9WT09WJakfExVEAreuPNPNJUDl5M+QOA3XuCpYotUGxiQco+BkBjvE6iqTtsmVeVDlBZNVbfPRnHbi9cbd0Bxj1ORLZ0GHGyT2pOBXk304nvbkVHWdTs16O7TpgRdjqQzjsaRVH3i2sDhrlsHPbVxDDClZtR0NPoMzx3g3al4EGNK2W4ezqiAJSbXBFZLT55cyatlhxiXeTdzbVUrXRVT8UGi1rV1fKwBsxWAplwyuQGln+9Ld4Xn4focJiD6urFZbCb/1R1Lz7gF7kSJvokrHh+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whM27cOHOopSoBfG3PQif+04wnCS2R1RZkdCJP+TGoI=;
 b=eEey+hqGeBNMbgAtai8gs7vz60/O02h49tHtKmtRochk1UULbTzUhrT9s8EDjOIysMmleXtMwZioCX+QcZO4w7Y9RCgiI1PFoMGWpTCdl8klDoCYmyX2Mqgu5DRNMrUImXw8ZOjN8Nnchivth8CAL9CyJ6GIPak9YXorwu2dF4WQ9tGONqV4Db+o07W7pTB3VtFcbR9j+ixxuFrulGBrGiuVjdgwQV7RfobMTamcrWK+MxlIM8Vb7mghxrROrGm0xYv1KXF7ehKvAfOz7/I1NYXpTLbYVRBhF55RWMuI+3QY2LjP81gnud8rpF3W86P1DKFLwA2effg/kI4QIXQ0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whM27cOHOopSoBfG3PQif+04wnCS2R1RZkdCJP+TGoI=;
 b=YDfWBe4BhCbZzhciuEhuBM9/Wl2ZJJnVnrk0GdI2Ehpj3wmddczo6jSOQwhs8W47V4nzISXecwoqvpYQUP5raPYCvVtBviWM391fvIU5aRz0XiHrfAjlFss0Jb5N+kC6TCw4DQ9jhkNFlWHbawDs/MEy3sYFOQnWJe0jaCNFWpYm1AW52CDOQA05XYcHht/PmlB/8vjD/ayCzbFWT8+/cGP0e41fy/2YI/pspceiX3DBUbpkrAJJXjFiG5/7fA3MMWbQozvBo6gDn7fUljppsFfaQ/5v8B0fbOqcCfgpxT/UYxz22+zoJDKbXgmkeLt88/oQxhgBM5o8FqqeoYtnIw==
Received: from CH0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:610:cd::29)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 09:45:23 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::12) by CH0PR03CA0114.outlook.office365.com
 (2603:10b6:610:cd::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 09:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 09:45:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 02:45:14 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 02:45:12 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>, Bing Zhao <bingz@nvidia.com>, "Ori
 Kam" <orika@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] app/testpmd: fix conntrack action query
Date: Tue, 12 Aug 2025 11:43:23 +0200
Message-ID: <20250812094323.712559-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7df7e7-dd87-4229-27c1-08ddd984f533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MSV62jJZ3kTpd5ZHO5JXtWfyM8eqs1MnLCPC6tJKZSyRgjp5lyuYCYKc/JLK?=
 =?us-ascii?Q?M/j2wiI4xPEP2BT099yq1vr97FPr0q4cK7/9AEdRTqk8pb+wuHTUi8lfu4gy?=
 =?us-ascii?Q?EqZHWVL+HAG1SA42jiVtt+bucEdBma7LGxf3jH6gHQKkJoO4k2zDOxm4hvnH?=
 =?us-ascii?Q?b7veH3w/r0nBtasZJ9Z+eelxd2C4+bJLdTn7us2DJ+0O6H2s24TPamWEoDgT?=
 =?us-ascii?Q?Y6p6TA2yuE4p72o1mc7cYzfAUw3En+EmFGWdzJbC5En6q3Drxelv1RWmUNc/?=
 =?us-ascii?Q?X3+3sUcJBZhbuLl2+1+7MIfP/PXPvrYGqYIUwGFuQsem9WrN1URAihhCNIzi?=
 =?us-ascii?Q?OGsaCSe65A6XyYwBwRSJQf4CogBSEgdDcJ+xGp/ibtDdK2V343sTLgJQ/PGB?=
 =?us-ascii?Q?n5uJM3U0GQBF5RtrwHusCmr03QAol+maIBvfHdYyfysECWPH7+hUqn5DmP1q?=
 =?us-ascii?Q?8qatmutYo0N44Ukp1o/XYmEa2R5JLWLOJLte9JvNh6SZwqQCEg79IxOCGlA2?=
 =?us-ascii?Q?7HVMSybd8tjqWzJxfgY/TUFTUWuPGsbAP916hDWNlg593SxwPod0ap2OXr07?=
 =?us-ascii?Q?Z2u+TKgZSnA4M0rj44/VK+C+mJQc1qTBoLnB/VDy4y1tZreOwZ6C5jCaEonR?=
 =?us-ascii?Q?dhPiS90fPUJrV/TPko2U4lajWjcvMZIFrRcgrwFZB+Jw24abepe5i5smA2t7?=
 =?us-ascii?Q?5T2LMpeX25JcX2gD9x2odSIk5g3U3GaSKsCjfHs5Q7u4gWVVmCooRqUSfzvK?=
 =?us-ascii?Q?++6tkqxRzKk+9le6w95atIr+nebuNsIBNa5iS2B15QeRm7eQjVpPASf5/I/G?=
 =?us-ascii?Q?nN5sgRi7yabdg6s9RRBIQzhNE0COlwrRRZjUb9aBu2uryggVs02rQlCw7QJO?=
 =?us-ascii?Q?bkv0lpjnrSRdBbrAhMqTJ9h+GwLBA+RVW22asyH5TRTMOpJs6oo0ydEbNyBY?=
 =?us-ascii?Q?B8EhCrKLlrw40HAB32HhA5mb273KlOzL5bYmU8sv5m0mm2iHh4UVK40/Rrlr?=
 =?us-ascii?Q?XMwdgX7/K7gxJl+4/3Qm6zSi9qUFQSopRDhwdQOXL2cYaHCo90qB/1EYiyY5?=
 =?us-ascii?Q?MfpZZwVWLzrjeuSTxpR0sLD31oWKdHfNjiFaH2zGNI9bVIyzwPklDbJugLqs?=
 =?us-ascii?Q?vYYQpEUH0LkD2LIAQ+3ADJlbu8v+BgjyAV5T71qCojpVxISqnXdllZ22uk7e?=
 =?us-ascii?Q?/W2S2gZnItnG2e0GHsrIhvQZdtpAF5+ZjEIetiZUGUp+T17A9kG3WGECMMcC?=
 =?us-ascii?Q?vEvvAaS3r38mjHtzWDP5FAbc2sIamkTLn/trscFsvALtPSj3Yq+ES9hNLwKx?=
 =?us-ascii?Q?GN7oZyZ7h9MxPTJF6wEZsh2vOZkW0Dp081RdeZ6JAst4dKrOY/tMp4aTbx0H?=
 =?us-ascii?Q?S+y8SbOJeRlV59FEyNRNjQQSJ1BCWaQi2obTRED/3EJBUDRUBC6GKscmTROC?=
 =?us-ascii?Q?+JoNiL9EAojpbLyrBFnOwgA9KY49F4ChqNfHMee8c6wCliW31+GNhX59YjGy?=
 =?us-ascii?Q?0y58yWMSnuz2sF6FV9pRmjTaOOl9gQdSP68c?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:45:22.7908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7df7e7-dd87-4229-27c1-08ddd984f533
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944
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

RTE_FLOW_ACTION_TYPE_CONNTRACK handling was missing in a switch case
which filtered action types which have action query support in testpmd.
This prevented the conntrack query to succeed.

Fixes: 4d07cbefe3ba ("app/testpmd: add commands for conntrack")
Cc: bingz@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 app/test-pmd/config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 0fda8e99f8..dc91966a95 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -2167,6 +2167,7 @@ port_action_handle_query(portid_t port_id, uint32_t id)
 	case RTE_FLOW_ACTION_TYPE_AGE:
 	case RTE_FLOW_ACTION_TYPE_COUNT:
 	case RTE_FLOW_ACTION_TYPE_QUOTA:
+	case RTE_FLOW_ACTION_TYPE_CONNTRACK:
 		break;
 	default:
 		fprintf(stderr,
-- 
2.39.5

