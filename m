Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B0C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 08:38:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5262402A0;
	Tue,  8 Jul 2025 10:38:06 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by mails.dpdk.org (Postfix) with ESMTP id 0ACD94028C
 for <dev@dpdk.org>; Tue,  8 Jul 2025 10:38:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8RE38cWBgOj5ax3QHv+IHsGUQ8EZiJybs71OpYlx71Ojuky//GEgc8YyjNxkPAc2oLN++s7//ZF2aWSLeVRfznJ6WXrTSuK96ksl2tgyUPFFJdozICPs139ak8LXdOG0IPFZ9nX7cfsPw7R/VjRjizEsBGyvMdiMHEnfoNZG/11q9WGTIxJsPZHDoMY4c4uPzjxXqAZmXyewbYKdOdfwDSLx/LfcBSgXJNszSK3VSSqc77xqbMMpkj4VIyCfFgGUVr1TpDjYwXxAxmaKV9m2WEChvTUWtn4wLZPHSEor7yULgcvzFh59KtoJeGcF62zOr+PHUn6talCLaIbvzq36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhLz9vKSjTYu+JRNuT3toBKK5Yg4jFa71QT8LTDSCXM=;
 b=cwgGvjmwjijxIPP7tOh9YvRM8FoGDdIzZI1LfUuYB91bmU3SGaznOvRxM+fSP9f8RHBrkglrXSgP38ekAgNbHNRVua6zrD62sriHUlj4vV6OQ1fisgBistbLGo56J0S/HP9CGc75gGxDOQwI4r5nmH0dhweWQuKx+sP/xoz9AjYfKjDdEJwe32CEcGB5QSe6Z64kN4twv/RY4AlnArVnWKRyPQzT5nJ7N19sTWtI9pqPBgV0xd47MjPitXt06QT+AwS3B47fnyptllFgC0VFSR6W5434bU5czUByTXf5XwtX27U5ZEqfTRUDnt+PS7w1L2OzomBBdz6xMAyp7wuXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhLz9vKSjTYu+JRNuT3toBKK5Yg4jFa71QT8LTDSCXM=;
 b=Ty4Yauds+4EboS4CrG9iB5yDRhSdTV+cfyIaJeReF1UYWAEQptr14ibVd03iQH4DFU5HF4VweqqaL5t0btTTOarBqBA9krTkfUQZfjw3HD0JwJoQzzhhy2We0gRI47RGJKyLjGpZDx4ECWMKptJd+Ly2mcgmCELHft63uVxE00WJlvAZMloI9jKsjrVYtgu245MuAEkks14RzF5deppxiqjT9SxngZFhsi2Hay5KTAY2w7Fs3/A4hK0jUkDZ5JfaGxAqIJ2t0wZl1x42YA8pAJHAR4padr9xN8GQTjDaeSWzTOGvWGnJYqjGB6iiNmwA6dhMXcsTCGh+/rS0dd3x3A==
Received: from MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::26)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 08:38:01 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::18) by MW4P220CA0021.outlook.office365.com
 (2603:10b6:303:115::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Tue,
 8 Jul 2025 08:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 08:37:59 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 01:37:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 01:37:45 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 01:37:44 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <thomas@monjalon.net>, Shani Peretz
 <shperetz@nvidia.com>
Subject: [PATCH v8 0/1]  fix inconsistent representation of PCI device name
Date: Tue, 8 Jul 2025 11:37:39 +0300
Message-ID: <20250708083740.128610-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212163836.178976-2-shperetz@nvidia.com>
References: <20250212163836.178976-2-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc696a0-455f-424f-7d2d-08ddbdfabedb
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vkVYHzGE27ciIiCil2oaxvVedDi3NKaZN8IE2JqFxGolgIBzBWG/zGu34Iiv?=
 =?us-ascii?Q?LyvFUs7kQ1uMCUiTO933p9x+yOJAqncUf0KVSXWC717I7ILnQaUT1z1DeBoY?=
 =?us-ascii?Q?z0SKdNq6wtTy889KgVZbktyUmHpJQACGGEG2kD7nDETgOmczlBAR4XsA7N4z?=
 =?us-ascii?Q?hbm+tSpvmF/w68wT6OuncTsiwcYPYxThkYU7kwbsIj7CU5nNGBz31ZZgjvN6?=
 =?us-ascii?Q?qiF6WHy9OvbH+sgLVEqcMYJRQdEWFE8nBTbuCY+lug4atOPAFSr6xT/r5VGz?=
 =?us-ascii?Q?ML8v66XjttxtS5JPt0NMF81poVASh6BGA55qh4GeYqIq4Y3STfe0jysnM0Jw?=
 =?us-ascii?Q?+jvsUWP5L5u/05ypyk8RseGCac+5mbAYjrgRUTlZWmGjT7VXavY6aRrOwcVG?=
 =?us-ascii?Q?0pNOKK2PiiG8w9nY8bcl/x1wjUUKbegVBotWB38T41NKGY6ssDoZ6W0Enn/X?=
 =?us-ascii?Q?Bz4HRvPT6oJahb7uqeL4tCf65hVXjVnFbUeMJgeobDMcRY5aI91VoAOAlwJl?=
 =?us-ascii?Q?xniLArStplLx33pU7s3RysyjsFZx7tf45363kuyxEhzTZgLmP6pJxSfJm+oC?=
 =?us-ascii?Q?w4I7fwIZS9XIwPS+uk+e/GOREQ2Xw1yNgmqUs8NsJPG0b8NoRo4SIcAgeJ6a?=
 =?us-ascii?Q?rTxuZUlliFThyunfOAQkCwkCBz3GJ3v5b9yrKPpXX3NOYD5PxvuZIG9DBzvU?=
 =?us-ascii?Q?3M/FXaWoIL+1m+YuYIfwYHpdQ3vO1iq0nOr+BbNaT+avoZIjuSyWpHgE0TW8?=
 =?us-ascii?Q?6SCCcdIIMH6zwo0aJWX6bFByEXNjIfHKrzAhHHvBpSmr+0j3Ub+n02/S7Wa9?=
 =?us-ascii?Q?rEGMI1B1l6HfDrUXgrID5iRtWfR+NwNslVYPHl5HnJDOjyx4UrlgdyLayfJ5?=
 =?us-ascii?Q?FREouO+Bkz7su5MlMlyAh/KhSbT8m6Dc27VjkhmjFGUyffJIcp06p/Ysofb8?=
 =?us-ascii?Q?QoA0Q+v0aCM0yCfaCxfKs5wbZ3D2UA6RQJiTI3KZOrf/ONbLU5WGTYMVF1aE?=
 =?us-ascii?Q?tiwnkrrXBMZCE+YnNwYPGog0NP4hvKB6LcIYPzhD0tLfuhIBklvZ7KPZArHA?=
 =?us-ascii?Q?JZy5NN+03N/tz+PD6Uy0hN/6c4pbAFNxefMKbtbctFQMkszCSR/YuMK2gxY9?=
 =?us-ascii?Q?LvelEfTXoJgBGW7LZwlHvWrK53oz2ki8+CyPmtvyJnbqyYn/E7kZN9v4rGJC?=
 =?us-ascii?Q?xqA7vaTP5A9Ya+uUl8Xyq9lkmY31PyfbnbO/oiZcdjc9lYQ3gcMZy9uyglAI?=
 =?us-ascii?Q?GfnH0syRo+mbm8+citiwacWYPWheppmjGjN3PZTkFTGDaCP9ITztNp5K7pzg?=
 =?us-ascii?Q?fwy0KR9rQHrYtlLtm/LtTMSf97rnegfEQ2Mo526gMkwSNjIVqmEevcX5rnfD?=
 =?us-ascii?Q?yjT1ZibyY0Oq7cn5viWqko8plOmbSZI4O87dbmAVuzuiYRt5hab3OftUPKcf?=
 =?us-ascii?Q?44a5dnRNbNfEii7q5uqmEUToWc7OhbdDFm03AkY6inotx8JwTvQGPQl/S/GQ?=
 =?us-ascii?Q?SjrvFT7YdzL0jbLsfwMj4OqEWWWo9OM4S7Hq?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 08:37:59.7342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc696a0-455f-424f-7d2d-08ddbdfabedb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
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

v8:
Keep cmp_dev_name as string comparison and create a function within testpmd that converts the PCI name to its long format before passing it to the find_device function.

v1-v7:
The fix focuses on improving cmp_dev_name to perform a smarter comparison instead of a direct string match to find the device.

Shani Peretz (1):
  app/testpmd: canonicalize short PCI name format

 app/test-pmd/testpmd.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

-- 
2.34.1

