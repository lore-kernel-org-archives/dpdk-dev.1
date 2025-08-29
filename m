Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC61CA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 12:50:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B31D40263;
	Fri, 29 Aug 2025 14:50:41 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DB60F4025A;
 Fri, 29 Aug 2025 14:50:39 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 161E6211081C; Fri, 29 Aug 2025 05:50:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 161E6211081C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1756471839;
 bh=1vwrt5ifYEgP/FWgCrAOXd63maczdNscawGewH9Gsmw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dWdrYwQ+j5QBOGi5BI3YYojAzytVdFYJCqW9CMnTF60A4LJ6W12uJadzow7MysGZM
 5WkExLTC+1kF2FHvvmTxESiNI+Wzp+BNV1p7u0NAvc0l0kW+WhVjoubqkzXEQFeI9S
 JSbihnlUrbK/hwO3vB2ckSyxV4Wk6Ug/fehfmD48=
Date: Fri, 29 Aug 2025 05:50:39 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org, Raslan Darawsheh <rasland@nvidia.com>, stable@dpdk.org
Subject: Re: [PATCH] net/mlx5: fix matcher flags in counter offset detection
Message-ID: <20250829125039.GA6235@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250820084521.1088620-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820084521.1088620-1-dsosnowski@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Wed, Aug 20, 2025 at 10:45:21AM +0200, Dariusz Sosnowski wrote:
> This patch fixes a bug in
> mlx5_flow_dv_discover_counter_offset_support()
> uncovered by a warning reported by MSVC:
> 
>     ../drivers/net/mlx5/mlx5_flow_dv.c(19636): warning C5287:
>         operands are different enum types 'ibv_flow_attr_type' and
>         'ibv_flow_flags';
>         use an explicit cast to silence this warning
> 
> IBV_FLOW_ATTR_FLAGS_EGRESS was incorrectly passed in to
> type field of mlx5dv_flow_matcher_attr struct,
> instead of flags field.
> As a result counter offset support discovery returned a false positive
> result on application with old rdma-core.
> 
> Bugzilla ID: 1758
> Fixes: 4fd5e1484887 ("net/mlx5: fix counter offset detection")
> Cc: suanmingm@nvidia.com
> Cc: stable@dpdk.org
> 
> Reported-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5_flow_dv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
> index 7b9e5018b8..4a6f9d63fb 100644
> --- a/drivers/net/mlx5/mlx5_flow_dv.c
> +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> @@ -19652,7 +19652,8 @@ mlx5_flow_dv_discover_counter_offset_support(struct rte_eth_dev *dev)
>  		.size = sizeof(value.buf),
>  	};
>  	struct mlx5dv_flow_matcher_attr dv_attr = {
> -		.type = IBV_FLOW_ATTR_NORMAL | IBV_FLOW_ATTR_FLAGS_EGRESS,
> +		.type = IBV_FLOW_ATTR_NORMAL,
> +		.flags = IBV_FLOW_ATTR_FLAGS_EGRESS,
>  		.priority = 0,
>  		.match_criteria_enable = 0,
>  		.match_mask = (void *)&mask,
> --
> 2.39.5
> 

This compiles cleanly with msvc. Thanks for fixing it.

Acked-by: Andre Muezerie <andremue@linux.microsoft.com>
