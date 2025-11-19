Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3217CF319D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:12:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14A884065B;
	Wed, 19 Nov 2025 12:12:45 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8E22540265;
 Wed, 19 Nov 2025 12:12:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXHv4ar8Qi4r/GbdFzo1iTpTFRzEoRJVZrWyyrKJGKEJm96WUZMf2RDDtHSkqhrpfyhhDxXKooszkuxprybnQMHjCIEU35TGKWAKDeJG1NhLerPfGAK00kPpSs77y2fB+od5UUZW3vgbo6nquCpa0/u9YsoIyx60oyJIxAYRcewM01ioofTUFb2UYZu4dWAEnjGd8ffNPRQ4KYPXbALylDt8LKG8uCXDqmbZcUjpf/IZC3MhbEy+X+m6/GlmpIHojA1xJVDHjntHMeT6W38QG6p9cf3VDq/5yoSOhzU76wmfh9LjHS6tfueM9a7fX9RTSLJhq0qMQGf3MOPlG0R1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYEH86gYjDVxM2xg7Qksb23bIz6BrSm3+HsR9DvWoFg=;
 b=NDOD1m5C/+EfUKFl3UNBpa9OTA3c8qo8g9SC5pLZEJ6DUAQAGd36QoCCa8LsbrVDJzwND0xCKx+Mp6z6OUR7PYR+fHXYpXDeEWnTWaph2jnvjFLHhG7fjsxtVLTetbwQMqI1fgQjA/jOrHFPQopzoYSzqlkLNJRZS6AiJl7RLr2mbfNJQv9lbxFUkEbVurncqRyWMdWV83Fjdd/8Up5sMBpzl0MWbIZ1++qA+wJU5nVXWoGs9xBh+1SmizQAc5xrXEXxj8d29A5ToWA9Gtd89UKP2R0qpByVWc0X+AItdPiIOUyZYkVCQ9FQQWvVXBBEIQ/rslNexP6IxiY68TY0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYEH86gYjDVxM2xg7Qksb23bIz6BrSm3+HsR9DvWoFg=;
 b=IZOt3gSGI96gdLW2Ddr0I1NXlAfUQD4rss0RuRFEtyX5Az8d4ROw49Ssb8nL6O6LmYEGO57xoQRnuzsF6bkuQzxpbxK34YtJbZrBrJ0pIJ0VN/+Q2aRnTCOP9ZAYQVhcuaPUDebtPtg+NSGYqU2oMw0qusUsxSCM3P1ydkksI3XGwJf6T91fWUn2mS5XCjTjsy7zo5IHLjCKrkHaW+ojBorNUNauPnWHAZRHD0bbq64ZYENrYII3FqyfqXTesWplVsFo15yHnei2tCngCfDEa8Riv5qy3xpDjnHGgsEh/C9AVenG/7GWk44hF7Dcq6BSm2aBWoJSMq9TZ/9PjihLXw==
Received: from SJ0PR13CA0145.namprd13.prod.outlook.com (2603:10b6:a03:2c6::30)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 11:12:32 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::51) by SJ0PR13CA0145.outlook.office365.com
 (2603:10b6:a03:2c6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 11:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 11:12:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 03:12:20 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 03:12:19 -0800
Date: Wed, 19 Nov 2025 12:12:13 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Junfeng Guo <junfengg@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <viacheslavo@nvidia.com>,
 <bingz@nvidia.com>, <orika@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <rasland@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix IP tunnel detection for IPIP and IPv6 ENCAP
Message-ID: <20251119111213.2uqimokwzvcaluls@ds-vm-debian.local>
References: <20251119103554.44203-1-junfengg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251119103554.44203-1-junfengg@nvidia.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: a1766519-5d9f-46f3-e105-08de275c892e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qwsGyGMjeXipokb2M8P5rYkFa43CLKUGgCS0Kv3y4nKIkFJJHxdttVOa38eQ?=
 =?us-ascii?Q?c5yaPlnoRd0hMoYc/hRMHmseH0DlXrwgeOwyWazDk7txhCDpJmaaqI6154pJ?=
 =?us-ascii?Q?OmF0n/kulo2atih0Mns4chgeudgueLqlD5OT+OgAoLuMoAlVK+AbbOQqoBsS?=
 =?us-ascii?Q?0R09y4g6cvovcradpa7thYI5dtBEO0dwVVdiBFnDZgN8zJzc3p7srbGnRQIc?=
 =?us-ascii?Q?UAw3xqXQC6d0WKfpiP/m6CTQ5tvvjP4I/DJ4dkEhpqV3zlbuC6Jxiz1UcZ0I?=
 =?us-ascii?Q?CWRxNju08d+3XMYqbDzedDwg4mQgXB7gfoRv9X7LbZP30DDkykEj1FBiuoZA?=
 =?us-ascii?Q?T98wXtRBScThA2R7c0vlwWsOqwKE6y76Il+Egj4s8oHvdxG/yM94okLUwcpk?=
 =?us-ascii?Q?pJJJNcFBWBv6WvfxsWNFdERZAwvxhGnIo/Ef++oQ8HN5uYLJEPu8B7tJE4Uc?=
 =?us-ascii?Q?x79t9Lq8h0qRyNVbsnlC6WluEddISlw21YoQDXg6LvnISLU2d40UscGIqAUc?=
 =?us-ascii?Q?cy/BkQqBPRglxhF+9cv7/Fop5EDTrJMTfkjHIMeoHZsQqyDQsitmC2kfpUsQ?=
 =?us-ascii?Q?eiA+Dh89JZdfmlRLinlYoiOmhuRWPfX+xtgdUbQyYoC+Nyr5fv9JfPRIlV+K?=
 =?us-ascii?Q?UdLHAbSSjIzlmxg/9+AjI+hsCAtRgcUp0ZSciycqlNks3FfrA7y/fU6Si4on?=
 =?us-ascii?Q?ifQxmqoT2wY/bvyz36d7gI7bQs6C33Srzh4hBr5Fwg+Ihpl3TDm2xh8bjfgP?=
 =?us-ascii?Q?hOZJsQkkLa77Gu7hk87JEdVn6D0v0Bf5BSIxdmSh1h4caJ0xZgzFKKBDzk0Z?=
 =?us-ascii?Q?DE9sGzAjZ2bhpIT+6+sB7mR78Xoc+h88s+z+pzY04R+Y8Tb8/0RUK0t/NpPO?=
 =?us-ascii?Q?t6whzc+PDlF28rEnn64HKe13snXqmrH8usESpOkE1Ra0tjcgMnHJcmeU8pO2?=
 =?us-ascii?Q?7VPeC49DKVvcc4D+Oru1l4fPVS3a8wifszzTM8USDEa5IxpFl68Nfl3eL9L3?=
 =?us-ascii?Q?PBIfF7Jg46f4NeskD4DDOje3NkqS/G9SaI0qvOKeEqHTIQLhVqj66bgJbAFo?=
 =?us-ascii?Q?5KdBUrQ/bRukK1ilkM3dRPewNM96ByGOUIP+PafHMiZDJd9V1ABXEZwpfdoR?=
 =?us-ascii?Q?IASb+D5FpvtYrPMESHnfQX2DOWECgZs/vry8ID5r6ruCnxG4KDPyG0H/4iSx?=
 =?us-ascii?Q?+tvLXEdcS02icfNSJrBUYJZKXKt4cWDQVi35NHUGhKJV6OuJaSCzU2ThjRPT?=
 =?us-ascii?Q?X1un3lB/28lR/ooKSclLAALSA9V2mAeb+ydMQnSo5bqZMMHSKc/eDC0UCVQY?=
 =?us-ascii?Q?zDGBZPMTe8HL+NLzLiCwlloweY+OUAY2mnr45w/sX0rjPcTSPvPJ8wARIvMg?=
 =?us-ascii?Q?XfjxQYWsFSTqGfXzQ/6oJptjybRuLlpr0X9AX/o6Yt9xLf2s6yM37qLpxnYI?=
 =?us-ascii?Q?Jq3E2QfddrPk1v0jfoXw9/lfgLzFgWy9I2u2ihYio7tUP1oNHVkonbR8sHfC?=
 =?us-ascii?Q?KqBhG6Ch3y9KhH5qKfCkL33Yg0JbEjRndjeGYYyp0jI0yK16QKv9Fs+goasa?=
 =?us-ascii?Q?aiJek/7xrrWy8R6Su74=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:12:32.3876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1766519-5d9f-46f3-e105-08de275c892e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
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

On Wed, Nov 19, 2025 at 12:35:54PM +0200, Junfeng Guo wrote:
> The HWS (Hardware Steering) IP tunnel detection implementation was not
> recognizing IPIP tunnel types based on the next protocol value in the
> outer IP header as specified by RFC 2003 (IP-in-IP) and RFC 2473
> (IPv6 Encapsulation).
> 
> The issue was that the code treated all combinations of [IPv4|6] / [IPv4|6]
> as IPIP tunnels, setting MLX5_FLOW_LAYER_IPIP flag regardless of the actual
> protocol. While this happened to work for simple cases due to the fallback
> classification, it violated RFC compliance and could cause issues with
> protocol validation.
> 
> The fix adds RFC-compliant tunnel detection by
> 1. Checking the protocol field (IPPROTO_IPIP=4 or IPPROTO_IPV6=41) in the
>    outer IP header to determine tunnel type
> 2. Adding protocol mismatch validation to ensure outer protocol matches
>    inner header type
> 3. Correctly setting MLX5_FLOW_LAYER_IPV6_ENCAP for IPv6 encapsulation
> 
> The expected tunnel patterns are now:
> - [ipv4 | ipv6] proto is 4 / ipv4 -> MLX5_FLOW_LAYER_IPIP
> - [ipv4 | ipv6] proto is 41 / ipv6 -> MLX5_FLOW_LAYER_IPV6_ENCAP
> 
> For cases without protocol specification, fallback classification based on
> inner header type is still supported.
> 
> Fixes: f66c7c3ab983 ("net/mlx5/hws: recognize IP-in-IP tunnel in definer layer")
> Fixes: 4b7044562f59 ("net/mlx5: support IP-in-IP tunnel for all combinations")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Junfeng Guo <junfengg@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
