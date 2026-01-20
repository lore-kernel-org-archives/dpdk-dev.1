Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CB8D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 12:28:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B549B40268;
	Tue, 20 Jan 2026 13:28:33 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by mails.dpdk.org (Postfix) with ESMTP id 972394013F;
 Tue, 20 Jan 2026 13:28:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7qnMKYw5xm6Wjyk2FiZhlD/pdKFb+ycxypPjaQ7KwLsHw+aJATVA1bowa8QLnZl7aW80+mH+s4F3wRwhWhsswhTmNCQW1zvWqtg1WCVWlbnlRBClGOOfkY2e9AW2gpx391GugnQLdf+73n6AKjhGZ7xsDoAvGow4uCcGoPRRrSnh+r92UlS4csxZR2aeAYAU11qiOQWTjNBKgiJdd0sIJSW/2GgwjpEasBZH9jaclTAaKYfR7ycoGos4LBeysvu6MSH7yyfKlbgwwfC+MsJa1kCpa1o3eMykAB1wuxXx8VZeS13YkO5AGoZduY8NXEpIUsQ0R6+CP+NKrGvAoCfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hFSyhD9yjdCbXgPS5PN4YgFNTzD0K2dLh0gVu3X+D4=;
 b=NoGGbx0Ue3D3F6+8KdnJAQE260ONIAmIMobTpMw2By0H5q2VEbEa5WUhgWZcOplFzweL6YAgdJEyjSzVVkGlWJ/mUQGN9ivPxwAWfEYivUW310gBcONXYAn2dvjk1wdKhZrMWi8Rvony9b/8nAgcosAcFE4ESdMxGbOaXf1HuXTUHWZ/YvVuOhBqS3y49aC11z9HLV6Uloe/+UFrZ5fnXezFGB8TEaopjvkj7BO9D4z6r+ggUFLqaOxKbsC5dMD4GuOMtB3Mn9BMcGD5i43qhqItx8HqshwBnY1SvweVIyn/hvLFQIBSpRW85h6CXKHP4zAOkaQ/uLqds/i42/XOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hFSyhD9yjdCbXgPS5PN4YgFNTzD0K2dLh0gVu3X+D4=;
 b=eRNKZQhBjIlh/pxZ9aQ4ZTa8MMF9pF16uvvo0Bg7EGvzT4IucoFzKCEOI0+aIaJ8HhfXZLS2v6Bt0oSALlrRNSY2ttlYwDwbWnm40i+y0QufqNwbEQ8MAKdrHF4UwLLVRV8NQLXfCeWgR82AR2eZVanECd1u1PiveVls5K5U6Zp55io6vEORyQzftv0gxJl0x6gVu/UXnYP4hL6KfZ/igmnTSqWk/3ob5M0fX27khgJ2sQ+C5e10D2iwRv3bhxKCcDn1iRHlim1Uwwa3ZMWXF5TxqEYL43HtNuVhjfbJCcmDj7czfJj46GSuL1CnhIQJ/c+ojl+R79LZK6W+ZxAD4Q==
Received: from BL1P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::15)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 12:28:26 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::8c) by BL1P221CA0040.outlook.office365.com
 (2603:10b6:208:5b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 12:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 12:28:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 04:28:13 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 04:28:13 -0800
Date: Tue, 20 Jan 2026 13:28:10 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <matan@nvidia.com>,
 <suanmingm@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix flex parser creation length attribute
Message-ID: <ykzazd72jur3z2yvzntwhlsadoauili2nyizml24x523ryiyym@six5beinog5v>
References: <20260120080638.1976999-1-viacheslavo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120080638.1976999-1-viacheslavo@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 35971bcd-aced-49e5-ec00-08de581f68db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H5G/itz7lm0RiZ0jOAQ1wg/rJBa01uUlaE5c9zOFoT0Saniiop1KKUxJDv9u?=
 =?us-ascii?Q?TurA9Vw+WkDLNO2EZTjUwXrREh9JTMbEsv8N2rTsWh5kSfMpHGqYJIMPiKNm?=
 =?us-ascii?Q?h7+BARTveFrpclDe1eDISX5VrJZEFCfZTBwJbvhfxFIMIyK7pU+zHKk8iMJJ?=
 =?us-ascii?Q?RQVA3DvrLRpbF3C3grPdUNEoLQqfzmjlGAgLqB7+MzTCtjLdzKfOx/Aas4Jg?=
 =?us-ascii?Q?W6zV7iG8n53nfyZ0ZsOROn0J6juELmVXp3MRqJLhBTcqyub2xhxsL5NWVZWv?=
 =?us-ascii?Q?orN9ahTmZ0+wRAnYpJXO7OBkqA4MgH++IOmakr+pwtMINlUSuXtjSi7wOPgC?=
 =?us-ascii?Q?uz0eIKn/pB/6lGCE7x8EjHnO3utRdVInfVOyhdNXZHZXziFUDFNUzQHQddS1?=
 =?us-ascii?Q?8qIHGs9EtnSklGhX4u5Vv+4LSrcN/c3bwcwXvQaH9GQKKRdTjnuQqnHY344K?=
 =?us-ascii?Q?arRgD6oy+h1dGhSn6QjPHPMXpofImhs0zw6DO+MHU6cWzC2DwZBxZim2uraK?=
 =?us-ascii?Q?D+KoQIPyZTOhHruD1zi5rYw4bVohiFtQ0h/e15R4RqN/s2ClcB54IyjZ6831?=
 =?us-ascii?Q?4EGztpbnBpHdVnF0DeMQN4TxLKNaNROHnmmMNDPtnq/KTrdPRHaZz+PZghMS?=
 =?us-ascii?Q?v2lEht1SuRHAHqFmaFi1AbwzTtI9KEnvnsfrDT7Ixqnj+fiFEBoFbEXv6Kgp?=
 =?us-ascii?Q?2WPhFzt8ZGuMxl0VSGIFOrwkctOZbGLxNr5jd5r7hEfrM/5cztYENbp3gobk?=
 =?us-ascii?Q?FH9DLD1Xxbiiq0v/SBrxIiAzyBFvJFZHMTlC/+w1ettLz6Yy0C/AcVgYG1AM?=
 =?us-ascii?Q?yJRCBBPPPXLfdST/LaQEDfTA9TKrpSUBip+3mp0uzsNxshX9j4OQGffTQgVM?=
 =?us-ascii?Q?rO9A4Y05H48eHydw2hkFpUPe2p1wTEEm2KfkEhBVYxMmlXMnQzNVcmRKrmpK?=
 =?us-ascii?Q?w0IvZDNpwJWgiqB/9LYlMLRgW68ip4ebN+R+QZZ17cA1K2t4cXuIYAmVM48L?=
 =?us-ascii?Q?KNqyTH9l1NxxS+JXmnFKq5DtsedYRIeqnJ5vyoX8nc/waYKPvtc5pCis7yK1?=
 =?us-ascii?Q?VNwFx1CbTYYS80TY5E5Cal6gjHYRq8+FDGdlzakS2NSr4BgQSNDa6Z93bAUr?=
 =?us-ascii?Q?xslNP1zllexQYvjPpRM3zOL+FBqTbqPszw3v7YELFMI1UjJd8hl0H4kSqudO?=
 =?us-ascii?Q?IoTxee5delFS9VxgDbEnrahoyHkJHWewQOuzbVW89AcIP9Vnb4jvcfV7DGMh?=
 =?us-ascii?Q?F30YSaLB6oGXqUjlrUzYf1BVCRrVW7pySmA3nrg43e/F0TXCM2Te00OcyKoH?=
 =?us-ascii?Q?pH4mOJELXrSqKpmC2ZaG5wUi2CO/9vwVw4nEdTjAyTQ35k9500torQdQ91x2?=
 =?us-ascii?Q?jFY2H04B56dEJONB3DXRSOz2CxH1Tu3Qerw0+7ge5SMDDjSCaNV9ERA9/yLg?=
 =?us-ascii?Q?v4UKynxl9bKPj8sIHgCCOnseP1DmvxqgbKOUBAHCKDIvLrWMoqW910qLb5Fr?=
 =?us-ascii?Q?nXVr4Pnwh9veIjsF9N933X36JrP7P3k9vDuzTGtVozqiYESnYgZGwCABpmez?=
 =?us-ascii?Q?1+F4nbd9TsHWGGig9tbw+5J/+i26cZYFVcHr3JIz7+ErgS54YZjAmhTHw4Mo?=
 =?us-ascii?Q?B96JPX5MvOmrB18gh4h2NvXsCQH7OZeFZxS+xlHJLWIdJC2JkPQR7g6CSh0r?=
 =?us-ascii?Q?LgVvuQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 12:28:25.7800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35971bcd-aced-49e5-ec00-08de581f68db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
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

On Tue, Jan 20, 2026 at 10:06:38AM +0200, Viacheslav Ovsiienko wrote:
> The newer firmware on ConnectX-8 and above always check the
> presence of length mode workaround bit, regardless of the
> flex parser header length mode. The patch sets the workaround
> bit for the all length modes for the parsers created by application.
> The internal parsers for eCPRI and IPv6 SRH are updated as well.
> 
> Fixes: a2234609bf7e ("net/mlx5: fix flex flow item header length")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
