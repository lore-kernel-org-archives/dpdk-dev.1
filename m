Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481C7CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:48:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E10940696;
	Wed, 12 Nov 2025 10:48:30 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5]) by mails.dpdk.org (Postfix) with ESMTP id A7F534067E
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:48:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaMhOkbCEWYjKMccTCqVaVLyBgrqJRqG0kPkr2CnzW5yZezJqcwY1Lve7UmylucqOq5v/YXZU01MwTokGTSjFRX/2mW+IGfo1OBTCeuwlXlvgmB6n1APnO9aQfnq1OSirgLim+GFexvi3OES/auNw5AYy25QT37z2zvONzIh4VOryWMBP7LXKR2j0BvJ3/pdzZzqizbBWR9rc1wl5GsM+xaNyhZoAAquLnO1GPzD/CzWczsak32pJn1uwDc4LqElTrJL0jZSz+o42oqUE18ktunLJtttAvsQMZDHwNxlB3GcbggbSjHe8sCiPYsMwfAfOtkLEP9UMO+oNuthdE71Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PILbs2zgIzGTD9kdrqzwjnvThOAw5axjhYxt5K0pZA=;
 b=msNI+Cy8twKc9mkUvsdsKyskZN39vt/YLcupxXNqxR6HPOZ71LLlc+bMJ46N8j63YWreYayfSpdv7gF/xvcDynSJpNNLgofOvbPfRDaS+whoyQf2Mn5y8P6D4PMQ7C7PmLd8h9m9UppPuAT8tiNZ7KIIiERkX9+KLTzC8oUm1TkCNKkBGAWBe1tH7Q0hEY2uOeQXg7NXv5TujGPqAZGCOuXmm2bA3wryI88UHRxFZA1nQfgBuMaDEOb/iLZADaUymc1/jehQjn71iYOonG12Bx3D8901evYS6eyyfo++3wct0x51PpBxETe7cgVOslxjrbSeCnogac+SL3Pr0D+YSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PILbs2zgIzGTD9kdrqzwjnvThOAw5axjhYxt5K0pZA=;
 b=Eic7KdIp7cuHBASSbeznsWrd6cD+zl3Nfwg7TA4HBnq9XOyEUkCAyKGakHlzfhipunoWP3HfFtViKbqBfWnAECnaYdE8eL/lqG9baV3FWleQfmgkx2iGV/A+zEjakFwEYihzgdOzQfa9agH5aBF9gMNy7tAHNldNKVLR8ZQmklQoZgl/aoJ8fs2b3sL4MZmVnOn9hE1hOS714sXicb7eOjoAO+Fc8uz8AbucPC1NaqjECjN525Hb3feKlUI0KxJ6A8LFG9q+hGiJu/MsPYzbJyz59wOOfnTw7ik1TJ2bKeptfoZdJDatqtssYq/ZTL5ZNEOndSmNaDRMjZNqgCIKdg==
Received: from MN2PR22CA0012.namprd22.prod.outlook.com (2603:10b6:208:238::17)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 09:48:24 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::9b) by MN2PR22CA0012.outlook.office365.com
 (2603:10b6:208:238::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 09:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 09:48:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:48:11 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:48:11 -0800
Date: Wed, 12 Nov 2025 10:48:08 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>
CC: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <thomas@monjalon.net>, Nupur Uttarwar <nuttarwar@nvidia.com>
Subject: Re: [PATCH 3/4] net/mlx5: fix incorrect buddy mempool init
Message-ID: <20251112094808.v3f5iwzldsmnmvlu@ds-vm-debian.local>
References: <20251112074739.8996-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112074739.8996-1-bingz@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: cd43bb85-8bee-479b-34eb-08de21d09f60
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D10Fz8L9Vg/5mJKAouyCnfsUP9sg8KOF0P8DDkwYgxg2Ch3qPS3eBBaqQvIh?=
 =?us-ascii?Q?9q8HyLYKAzDWPwvbQVh8eMnk9uaeLAdodNXr16WgPpXJM7Q8jZA/9DjYW1Lv?=
 =?us-ascii?Q?bsMtiPSbGQUOGZ4FMnx08Yr336Adzldh7KAI6WJerhGoiSIrnOsolabd2Ci8?=
 =?us-ascii?Q?XDuP8mT4T8ayXH5wxZZfp6vIthX32lLa1U69exp7Joc1lPDX/STaNo2mNS7L?=
 =?us-ascii?Q?y11eU4yUzcBT+c3+z1PAk6yfEgr9hdyRzI0M+4NUiXbohb/twDnIH/6HNRU3?=
 =?us-ascii?Q?J13mpuqPk7bpQi0TAGahqYvjx96MF8bQq/+x7yx97OIJLyGPO1aEKX3eZRzg?=
 =?us-ascii?Q?fSAEABMrEsTiGGv712wJrGlRcnhDdSaqkMYdtBflAbe5rVLULzfuXIL7LQAN?=
 =?us-ascii?Q?CBiA1sP159vPckR2tmKZahxaj6TMZKWdLwmzkXsovqdvaCmMMVqS8eWRe8gI?=
 =?us-ascii?Q?ASMzEby+1Etu6NadP0w5N9VXlfUHtMHe6cguqinLGiWOoX4tzCzBrhOB7nsX?=
 =?us-ascii?Q?rLHJh2WeCKAysjx5QOaA4pko41Nc7Y+QrU/8oi1FvQEIUOkfX8KVCZndf2AH?=
 =?us-ascii?Q?yBPLGJI3DMgTYJhRz7Ay21fsoKLghKOdtIw25zEAg1lr6KqTAo2maFvb8CJf?=
 =?us-ascii?Q?1GNs89P/aHl6Dv8anLO645ifa7xqKTb5+D46MLn50/e2Kq/DGJ+LMYtAVc1P?=
 =?us-ascii?Q?/xMMLKDLH6gNM0h0zxRmfK0ZSBShT3I/q/khZgMVNI1xrE325geWHIig6WFP?=
 =?us-ascii?Q?tUEHKsPw45nvjUpubtUVSfZoqBqdiG4r1fzFMNd9CK2eeUa1DW5/yHMhOo3a?=
 =?us-ascii?Q?6aKnDsGMUpPaZOX1wgiNiVbDUN+/41ytZRYnRgAxz89A2w4xHPFmdyDEfJyl?=
 =?us-ascii?Q?lTSEatql1m/SavhV7I9XNCOhRWq5fdp6Qrlv+vkr0q4/HRhA05JZo70SGdIR?=
 =?us-ascii?Q?CkZezsdlWHhFOly1crV1Dxf8xsWHAqjMRLPK5QtDJ3u85WtWHuvfUJiRGSia?=
 =?us-ascii?Q?Lg8ZRV7VXq04tJFiqJBbI9kI2JCFdlCno9TrOfuVve72fo/VfC1NFtNRIYLw?=
 =?us-ascii?Q?YQA3SrQ7HXiBT+hb9ypoB7okIIE/Ly2QtR5pm0g5JYrxFwUziYysSc5SbJxM?=
 =?us-ascii?Q?gA5djT6vmi4wp/qkSto9sJMUrtvz3/SUad9VBgeTlIiXLxWAdcs45pfn3+uH?=
 =?us-ascii?Q?gQ1K0rNvHoY8/FMjmaq0SrY2Mcind+CQZ0gL1qhgufU2Aq7WNAv9QyXhIyuH?=
 =?us-ascii?Q?p7ikg5hGpKOblAN+CLW61qT1g2Z0rie8LcG97CNbRKcEXRDzSQNVa/wrqV4A?=
 =?us-ascii?Q?OoJ+NMcuxZiasQplJ7iByp84hrb3vc4rmXCqUjFIAUA0wAPQir3GJUNvOXEh?=
 =?us-ascii?Q?aAAKkmeuuftL/SlIeMYTM0T9sI4DAnfwlDhz2N2v6Y9lgQgUJqxWKRTGr0r1?=
 =?us-ascii?Q?gaxnJW8dgvZU4oigR4xqltKGSQ0LEUGONPNjfdSAKKTQOZBvUKoU5E1BeqJq?=
 =?us-ascii?Q?JNu4CMoYkty3lk9QKSaoCEs77xkxhckibl2ithBBokeyLNR0H8kmgOg0gHKh?=
 =?us-ascii?Q?0/F9itYJQA69WGvfukg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:48:24.2125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd43bb85-8bee-479b-34eb-08de21d09f60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
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

On Wed, Nov 12, 2025 at 09:47:39AM +0200, Bing Zhao wrote:
> From: Nupur Uttarwar <nuttarwar@nvidia.com>
> 
> `buddy` was erroroneously declared as static. When multiple
> threads call this routine, they set the same static variable
> corrupting pool data and can cause potential double free when
> releasing resources.
> 
> Fixes: b4dd7bcb0dcb ("net/mlx5/hws: add pool and buddy")
> 
> Signed-off-by: Nupur Uttarwar <nuttarwar@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
