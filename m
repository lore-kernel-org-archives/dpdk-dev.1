Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB035C5DF97
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 03:03:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFD374027C;
	Mon, 24 Aug 2026 05:03:02 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 3978340270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 05:03:01 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=LPZQgAsAhEFgd2outnTglMDHRL4TittP/G3+k54jsfI=;
 b=vUoFBpQUunlcYsfbRpLfBZG6AbzUynE46OBv64WNLGLXnrZnq4OpSNDRedYIKGAPbtxSlzaFN
 r5/CfbgOHKAcOCDrtC1rrBhSAejXU92poczCbsmnGGsESHcGVH2DUYPKTOjRRAAAb8rMqN7eIgO
 95ttXTIpOd/18zwXzphRick=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hSwRZ5N8hzpSvB;
 Mon, 24 Aug 2026 10:51:54 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 1DC7D40579;
 Mon, 24 Aug 2026 11:02:59 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 11:02:58 +0800
Message-ID: <7cd8fd36-c409-47ce-9f34-90164e0ecf98@huawei.com>
Date: Mon, 24 Aug 2026 11:02:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/68] ethdev: replace use of rte_memcpy
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ori Kam <orika@nvidia.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-17-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260821192646.146382-17-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

On 8/22/2026 3:24 AM, Stephen Hemminger wrote:
> The management of flows is better done using memcpy() or
> structure assignment where compiler can do more bounds checks.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ethdev/rte_ethdev.c |   3 +-
>  lib/ethdev/rte_flow.c   | 104 ++++++++++++++++++----------------------
>  2 files changed, 47 insertions(+), 60 deletions(-)
> 

...

>  	if (src->pattern_ro) {
> @@ -1138,9 +1128,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
>  		break;
>  	case RTE_FLOW_CONV_OP_ATTR:
>  		attr = src;
> -		if (size > sizeof(*attr))
> -			size = sizeof(*attr);
> -		rte_memcpy(dst, attr, size);
> +		memcpy(dst, attr, RTE_MIN(size, sizeof(*attr)));

The size will be used later: rte_flow_trace_conv(op, dst, size, src, ret);
In the new impl, the size was not updated, I think it should use the original
size other than modified in the trace.

>  		ret = sizeof(*attr);
>  		break;
>  	case RTE_FLOW_CONV_OP_ITEM:

...

>  

