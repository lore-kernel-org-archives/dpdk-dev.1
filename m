Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D3BC02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 10:50:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD1A3402A0;
	Tue, 18 Feb 2025 11:50:14 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by mails.dpdk.org (Postfix) with ESMTP id 103A94025F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 11:50:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+SICBBbcHr180hKvlayvfrHbar5wdFzS/zfZCrJjBtR3aytJjXCvxhokzyh78TENlg4SXA0rs+ho+gKt7OQnDehPXBUEfElX5oQXJjVFQFv8wlTaEcg5ze8Ekjw1skWx1h3PaG1F0TRN+mK+Y923hqIS6pBHPJnSBS+3MBWwvKOB8Gf6gZF+3XJtQl70ELlCD+sj15ccPmBISnWiMhg9K4VxWb2eEvhvspM2aCdffX1DtDfVTUXsdlcPHB/MfNBWNpkspzuhaVs7r9IRaDfQ7qePgh1MVlu/hPa58Wf1mJXD2lPV7mwrIjmPoPG7Wgb6S3nFPTmXUIYfnZ4whs5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U9QNl78ewvD24EnfD+Nbc/jX1Ol953X9kIM0VPRH2o=;
 b=Y+CMnAqWptI9dA+Q6Kle9HzMoNkYW6VfnIEu0/2RYMQZ4jhiO1qqdulZ20hoEcK5zF42yuNuYG+qRrJ6/hRN7JhP2gx34Sx7uzWpsyZesiTTVpUFpDFJpJAaAdxfTEM0psur8DV4sSB5c578O9+Tc59DUays+nAOYCrvDq7upE7yejiIDiwxM10470QxNUhadwGdA+0jEdIzWadzkwwyLUZW3Y7vU+cX+YhidviaJzztzFK4FH7G+MO+V0Pu8nKeVod/Mx9hRTHq7t2zEFi1r2qbtfMcuZbaRN0I7vOOo2qMOg50vqYIlFS8JzlpYKusrNRN7tYK/dygn2OliwiOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U9QNl78ewvD24EnfD+Nbc/jX1Ol953X9kIM0VPRH2o=;
 b=iC9wvWj1cp6NcHnnaNO8Q3imItAaScjKn8SghUJNI5aTwZIcVPrZm3Vf0vQjDHVi/KzCZTa7OFfm3hI+DXQTE7FeCHWUxgUDZkqsX5/L+APM9TfmXlxHYuNexbQjT7MPk1zPVCbq8grubE64CMp/M5i/eYa5fLZucdKYpTpiF8e+TMWtbeEvMJ3JTtNnkZiubaKnpNqoMtB/0Vp2I+ZzE0LrQ4Mvt28TmP8S8r9m+JG1mebNOejkHQpN4QsnOm5h0/hL8MPJ1MWJprm4uAshvdNaPKgR8m3gA25H659SIOjsW/1MQS+VfKxTu4/hrtFRxD+yKJYPj3pslJ7v9P2NHg==
Received: from SJ0PR05CA0148.namprd05.prod.outlook.com (2603:10b6:a03:33d::33)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 10:50:10 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::8d) by SJ0PR05CA0148.outlook.office365.com
 (2603:10b6:a03:33d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Tue,
 18 Feb 2025 10:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 10:50:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 02:50:00 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Feb
 2025 02:49:58 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>
Subject: [PATCH] config/arm: update NVIDIA BlueField-3 configuration
Date: Tue, 18 Feb 2025 12:49:42 +0200
Message-ID: <20250218104942.81984-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250216140420.216805-1-getelson@nvidia.com>
References: <20250216140420.216805-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 99aec90e-f735-4b38-d77a-08dd500a03d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MHof25/uGB7LYem76SuyMtMxKTO4qWVVVKuKafJY0510kaqUnT8VwYfWIpXb?=
 =?us-ascii?Q?yTIyvwwW6QLBMVCXIiZm/0rl0iEe5xbA7YM7AsDjuFk6dNPP+/g0wUzEa888?=
 =?us-ascii?Q?o7iIOkHDu0LtiB56sIH6E59PzWZLemOQA3DWfaYL1sBCPT93uMabGzhot2Sd?=
 =?us-ascii?Q?CZXR/dIR1PTur1smgVTuQ0LX6uJhaEGTCvka/VEPjBot6DevLPjNxB19f7ZT?=
 =?us-ascii?Q?X+ezPP+cea1rFPgvSZnTZtW9WUP14GhLgq7NjKF020ZZfPaJSfEUeyuK4K/C?=
 =?us-ascii?Q?kjjViEDAQ4Vqp+dlB6yZR9cCj5pLbtepPpKhJq7cZ5R4cpUJBOwy/w0zcMjh?=
 =?us-ascii?Q?vsHPT24qiRlalB3hq7A99chNpkpB7+0QajqdSnoug9amKBtYTW7CyIhoJGYX?=
 =?us-ascii?Q?dVPcN1wkSzv+wNEXZx8YcshX+KsYOOHGTFh2G/EgO2ikSGWn9rHXBhsurflb?=
 =?us-ascii?Q?MA1RlWOLNBNWHhtlnofJfZJC0KvQrfb90ud9+NAVVQWwxvBOn2Ytp399Xl+x?=
 =?us-ascii?Q?I5G9F0FV3zwK3EY+G2/EUul7VX6l5mo7U03bGBoDVPNM/2/UYYovG4nYjcOJ?=
 =?us-ascii?Q?CXRTRVaeTm579Y0wBjtYtVIUpcbGtUqfpfweULN3jhCCXcxu4dSptVmT03cN?=
 =?us-ascii?Q?P/683CvFXAYZPU/tiQVGGgUXz7FV214YFE4pHG3T3rxxogV3iVduYezNHru4?=
 =?us-ascii?Q?CUdEcAMd3y4R17Dymv97BxKoBJ1aGWYHf9Cl6QWu1ZM09sKaMlRt+bQwKy3B?=
 =?us-ascii?Q?20my1ZWbBrBaRrdwhbaJ5MO5XKQxPWna8C0MZtJ9KEupfnecOc2/4K1gwZMF?=
 =?us-ascii?Q?vQclQvS091ucvkpMBYNXv0WLScaU9KhUFD9HQsnK5nim9sgdUDUCM6/x329m?=
 =?us-ascii?Q?cLaRtIvpdkt35E2+ODd1fP6BiMrWR8l0+JBtk3Cl7cmpOTfF+bkWAcA+wRvx?=
 =?us-ascii?Q?F4xmeqse7DlKEstkazlhZdGeIId3uucMJjdqSohiPgo+WhsbzslcGKbutsGE?=
 =?us-ascii?Q?yoz2ajUbtPDti9HX6At4WL/ycFz7elhpF76H9SAowbzaZr5Bm+JXEp4RQ3pS?=
 =?us-ascii?Q?nk6rSDlB0sK/TzSSXpszcikEiNaZarmfoE7d7YLma3BC7MYVTwhfRQLL4Amm?=
 =?us-ascii?Q?y/1kIzkUFhePjwvNQKRWOSA4iBASN5Xk48LYjkiBzXlhpxnGSxhEiWZLiQoj?=
 =?us-ascii?Q?I0s8+VomO0kyKY05ktkWycN+DAAz+bdNyptr1NKXvpezlwK1wNrrTYJAsfgw?=
 =?us-ascii?Q?glr6E1sigs38MFb39+F8r4xZQcaanlDPFXvxAyVQsTLerlwyYfgS0wtpXYXX?=
 =?us-ascii?Q?SUwfntSIZ+b6TDT0S3RI4M51Zuxb7BZ8tMIJr7buPFHIaXEwa5GF2OLuNiHb?=
 =?us-ascii?Q?xf7s0a3AtHq5uEnAh4VSNDUdSJgamdn1OXnGsFKpFEIq4KC3Z+AjSgALNLcX?=
 =?us-ascii?Q?kHeQqUv81/3UEqyrjtzQxdVh5k8vXFofSxasTqnTIwPEecdzG93gMjOHHIRa?=
 =?us-ascii?Q?7aOQ/aEpiX3hpOw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 10:50:09.9756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99aec90e-f735-4b38-d77a-08dd500a03d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
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

ARM configuration requires explicit `mcpu` specifications in the
implementor description.

The patch adds `mcpu` and `flags` description for the NVIDIA
BlueField-3 configuration.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 config/arm/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 5302861e2c..74f4dd4e1f 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -85,6 +85,11 @@ part_number_config_arm = {
     },
     '0xd42': {
         'march': 'armv8.4-a',
+        'mcpu' : 'cortex-a78ae',
+        'flags': [
+            ['RTE_MAX_LCORE', 16],
+            ['RTE_MAX_NUMA_NODES', 1]
+        ],
     },
     '0xd49': {
         'mcpu': 'neoverse-n2',
-- 
2.45.2

