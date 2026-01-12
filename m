Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3011ACF45B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 17:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 231AB40281;
	Mon, 12 Jan 2026 18:26:40 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by mails.dpdk.org (Postfix) with ESMTP id 5F7C440041
 for <dev@dpdk.org>; Mon, 12 Jan 2026 18:26:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhJvb+sq6whxMHGn77eF4m4t7gkN064KHj6+Q7j/7lVCCZkg58lYKy2Ri9knDG7ccjvRnrHoOL2zr2GWk1uk9puXXTJmldc7w2Nq84GBmjpaQfVXuxQ/acU8M7F/Lm/Eb3rL96ZXu67Fo778V4VmYfcHX/BL4Tp9zTr107EMQSOuzO2SPgIK19WwP29TLxaI6fKV+i323dgF4NqANJd65+iZNoXhnntm0+TsJXUAtEqQ1J3+LONodCGMPkuEP8MOE9jgLhzn4awFCGju97iuv41/jt7q2lORVSxyKub6Ssf91kQ0IHV2Qz6+JJPG/PFefOe3wjrKJr5EejZMWDASjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pujZAgM2Xoaf8s552gpXCgDrV/kOxKZmN7vcpXNyeoU=;
 b=WEZ9GBkiYQGkNfy+FHAC3rpWlV/MvqcHYcNp5cAvHSu1d0fv4eyCnKx258PT9RPOimaqhyS/coVIlu1rwzTvxiyC7sW+tw8pe0etODbXVu7+PQ/kxBt/bEtbvHQ5L3sng1kJuDCUvBU4Z6I5p61RaErYSXq3wzXIUTv880PhTe7l0S3JoCCex9sVsxS8MMPPKlhzz3Y9z02Wd1/xdnY2lvGnOzH4GeArvrH9e8v7ee9F9U+dSpl/9OxtG/HA2njiMgdGr4VZ915+pqnNkGfa34k0lEHqljNS2hRam0HnVpNC1Hudg5q9ZvpAhloxRXPR7iOOXiiBIYHJvvD1UFBrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=wirefilter.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pujZAgM2Xoaf8s552gpXCgDrV/kOxKZmN7vcpXNyeoU=;
 b=qFHjZ4YEr21ehYmPJt1gbi4x+6abYGRcjARew7E7Ti89jXjdgjScJ+VAONxH16VrGuge0JW0hXX7zMrjFyi8oRcpZoZ2TSWYf6QHDkn2ZTaNRCgEvvAu43ufFx2FuW2aoNSL3UQ+guC3tFZT5Ccr2UaBgP/DQ+ooGnO51x12h3kyINRgnhby6O2H8bvfB1d5okm/alTBnBdonzos0C1YpeY6UCukw/n+453RnXMH4blPhtQQSO0wwQ8b0dg8Nxbl7huXRzgc+tNbYpnrzxItOF0KRUWdKAPKdQ+aU0hSZzaxm362/UVhuyz0geh/FUEHrm/fpkdtakfDQJTaBMgodg==
Received: from PH7P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::31)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 17:26:34 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::6f) by PH7P221CA0043.outlook.office365.com
 (2603:10b6:510:33c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 17:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 17:26:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:26:05 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:26:04 -0800
Date: Mon, 12 Jan 2026 18:26:01 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Mohand Alrasheed <mrasheed@wirefilter.com>
CC: dev <dev@dpdk.org>, viacheslavo <viacheslavo@nvidia.com>, bingz
 <bingz@nvidia.com>, orika <orika@nvidia.com>, suanmingm
 <suanmingm@nvidia.com>, matan <matan@nvidia.com>, jackmin
 <jackmin@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix offset handling in
 mlx5_aso_cnt_sq_enqueue_burst
Message-ID: <wzzxujbhbn5dges7ukhceeiihnl6j5ztroncfdikj74v6lmxoc@hjvhdu6mak2h>
References: <205110942.16694617.1767623073046.JavaMail.zimbra@wirefilter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <205110942.16694617.1767623073046.JavaMail.zimbra@wirefilter.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e302e37-aae2-4614-ad4e-08de51ffbab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rg4Lw+GVJSReiM6jHWwUFvqKJ9LlKGRYlcqN8wSeUB36LUJqliGtVQVpdpbT?=
 =?us-ascii?Q?WZJQbWseUyHSsFN5Ff0LWQdNGDwlSbLjU4fUkVlhIuqChDjDlCAi2kCvTQZd?=
 =?us-ascii?Q?d/4Xf5RP3jQZYOTpN80GfFBl8+7OLuNdPjEP4v59wzpHkhyGMRqdZLKiTeqy?=
 =?us-ascii?Q?I2d8v0O91oMO84KHVvrlHtF5BAXFc+mARa2N3xE/Yhr63Ej9LNHDAALrZc43?=
 =?us-ascii?Q?y+nAcQl1UKji/viMNoU3QwnRMRQT1axhrLJiTL3vx/ghPp4KtwrxwXkWNB2N?=
 =?us-ascii?Q?/f+Z7ATxiJW5wrkwhZ7lMOLhM2G3zb5JMpGKfiF7dSfRcabM8cUJXMcBfpk9?=
 =?us-ascii?Q?aA49FkuBv6zzsrO4Qc5C8n0Cte3P4i058T/P3jKr2TU3SiEZYUdK742sgrWW?=
 =?us-ascii?Q?5jXO7EjJ9EyBv/qLgJEgNdULi69GiZb0tcat0a7VqbmgbzZ8x1EBuLXm4/Iu?=
 =?us-ascii?Q?cP+Km0D9pB1Bs+LEW6RxXUIKULeRUlkaUmvWeBa52mQALJAyG2nqOoZJ4mNY?=
 =?us-ascii?Q?VHC7OJM3UmzwTJ/RAcgz8uCmSLa5ttMPkMudhXIKDTzNZMbkjKfUSZ1Wwsoi?=
 =?us-ascii?Q?D0QmU3zkf8/1mvN2l6CepkTrrw6FPMntGCZ6VgcE5OOGUGnERc5u2NOb8/QX?=
 =?us-ascii?Q?4+TZ3d679Fk8ZJ4Ljd7creDgH/6DgfYLAGRyqUqSMFF5dfaKVWkQxFRtcx3t?=
 =?us-ascii?Q?Z7Cxwfe2scrG3GRlr66RgVeO2pka3Q5Ikt03npDWReZjEjGp+EaihaDW1qGB?=
 =?us-ascii?Q?Iiylfb1E1YFBT34uk9O6xjIdjI5vo8yzzQaXjgYNI2j2xZLD7lMT27kvdnRE?=
 =?us-ascii?Q?qZXkLv1+BFJyE/1aF9iHzREGhdUxMvJChc8u8lUYc4HTMU0B776BY1kqjAif?=
 =?us-ascii?Q?4olnrMX3tgc0uMNddXmh/5/FOQ/vQO1Mncy/2mveKlHrAC1zXPQFAykacNa0?=
 =?us-ascii?Q?exM9HtAq5v6qYpoeanWb5RCnX5paUZA8aBAWCR1APiC3Her6hZDnRROPRBdS?=
 =?us-ascii?Q?ucG2I9eJtvmGm2Bf+uG6S2h3OIdnSCKYDwFvYRnb1Vr1kWOIt3+keSVv+WHy?=
 =?us-ascii?Q?cemdb9ju2SgHhVSch2is8uJvkj6yKYonpiMmB1F4u2sZOkoSTJZ5MEIJs9D5?=
 =?us-ascii?Q?cMFzjsj+Ffh3SqVfUdDLGlt4RW96qU+t62OIhPojTnQUbVQO3fBuSRqYLthl?=
 =?us-ascii?Q?bK0yzGju0ZdmgICcAkNEDYBJXGngrI6ZEMxleq0xXQp8KrDsqCVnBXOXTVhw?=
 =?us-ascii?Q?sytF+NZY2RG/+SlE5shKNfFe9vqF/R6C0GrFBLnn0ijgbo/Jq4w2Ry26w+Uf?=
 =?us-ascii?Q?fQoYf2ctbaVgmdhrLRg/nSZW4CaKgW4Pzj18/yHf3q/e/XKGmSPnaWA/0zx1?=
 =?us-ascii?Q?6FGjSTmY7ckW/LPin/cBP7uwblRTVXj1oh980RCojpK+hJix+Bcw3J98YMgE?=
 =?us-ascii?Q?1F4DFLDm8byuJkfTDpOb1HAgJOJ5pJPQ+C3u+BYIPzbjzY8OYkIx4R/d4Tk2?=
 =?us-ascii?Q?Dj61nb8dn6Gun9w80/kYL5Cp6iziWawOEq3Mdvdnwt967xzyZErK3+mjaZBj?=
 =?us-ascii?Q?h70/H+4oPSjcWm8r2DA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 17:26:32.3073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e302e37-aae2-4614-ad4e-08de51ffbab9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

Hi,

On Mon, Jan 05, 2026 at 05:24:33PM +0300, Mohand Alrasheed wrote:
> 
> From 9ca4302dd93461a7b01ad05af82ee2bcadf47675 Mon Sep 17 00:00:00 2001
> From: Mohand Alrasheed <mrasheed@wirefilter.com>
> Date: Mon, 5 Jan 2026 15:44:25 +0300
> Subject: [PATCH] net/mlx5: fix offset handling in
>  mlx5_aso_cnt_sq_enqueue_burst
> 
> mlx5_aso_cnt_sq_enqueue_burst() selects the ASO counter block using
> dcs_id_base/4 and ignores the batch offset. This causes every batch to
> target the first counter block, leading to counter aliasing (e.g. 2^16
> matches 0).
> 
> This patch selects the counter block using the offset-adjusted index.
> 
> Reproducible example: https://github.com/Hawzen/rte-flow-async-profiling/blob/5e654e3a8a0414a5fa8ed43274195f180760f0b5/examples/flow_filtering/reproduce.md

Thank you very much for your contribution and reporting this issue.

There is in fact another issue with flow counter query logic
in mlx5_aso_cnt_query_one_dcs() function.
This function did not take into account a case when
mlx5_aso_cnt_sq_enqueue_burst() would query fewer counters than requested,
which could happen when available space in the queue is smaller lower than "n".

We have upstreamed a patch which addresses both of these issues: https://patches.dpdk.org/project/dpdk/patch/20260112172324.1523241-1-dsosnowski@nvidia.com/

Would you be able to test this patch locally on your side?

> 
> Fixes: 4d368e1da3a453cbcac620e8844c0300b2f45cfa
> Cc: jackmin@nvidia.com
> Cc: stable@dpdk.org
> ---
>  drivers/net/mlx5/mlx5_flow_aso.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/mlx5/mlx5_flow_aso.c b/drivers/net/mlx5/mlx5_flow_aso.c
> index feca8c3e89..a232289024 100644
> --- a/drivers/net/mlx5/mlx5_flow_aso.c
> +++ b/drivers/net/mlx5/mlx5_flow_aso.c
> @@ -1877,6 +1877,7 @@ mlx5_aso_cnt_sq_enqueue_burst(struct mlx5_hws_cnt_pool *cpool,
>  	sq->elts[0].burst_size = max;
>  	ctrl_gen_id = dcs_id_base;
>  	ctrl_gen_id /= 4;
> +	ctrl_gen_id += offset / 4;
>  	do {
>  		ccntid = upper_offset - max * 4;
>  		wqe = &sq->sq_obj.aso_wqes[sq->head & mask];
> --
> 2.39.5
> 
> 

Best regards,
Dariusz Sosnowski
