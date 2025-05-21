Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0FDC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 09:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B77841611;
	Wed, 21 May 2025 11:34:03 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id 8B4EC40151
 for <dev@dpdk.org>; Wed, 21 May 2025 11:34:02 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4b2R8m6jHRz27gBk;
 Wed, 21 May 2025 17:34:48 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 46A4D140158;
 Wed, 21 May 2025 17:34:00 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 May 2025 17:33:56 +0800
Message-ID: <c6f6d3fb-2ecd-422c-b803-aa0af0b9096b@huawei.com>
Date: Wed, 21 May 2025 17:33:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: fix offset calculation for GENEVE packet
To: <skori@marvell.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
References: <20250519160711.4024414-2-skori@marvell.com>
 <20250521051154.19595-1-skori@marvell.com>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250521051154.19595-1-skori@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

I have also found some bugs about the tunnel packet type parsing API[1], including one of the problems fixed by this patch.

[1] https://patchwork.dpdk.org/project/dpdk/list/?series=35233

On 2025/5/21 13:11, skori@marvell.com wrote:
> From: Sunil Kumar Kori <skori@marvell.com>
> 
> While parsing packet headers, offset must be added to get next
> header but for geneve header parsing offset is overwritten.
> Also inner_l2_len is not set in case of geneve packets.
> 
> Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
> 
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---
>  lib/net/rte_net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index be24690fdf..1264f33d61 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -251,7 +251,8 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>  		if (unlikely(gnh == NULL))
>  			return 0;
>  		geneve_len = sizeof(*gnh) + gnh->opt_len * 4;
> -		*off = geneve_len;
> +		*off += geneve_len;
> +		hdr_lens->inner_l2_len = sizeof(struct rte_udp_hdr) + geneve_len;

The l2_len in mbuf is also calculated from the outer L4 header, so it is calculated in the same way here.
However, this is easy to be misunderstood, can we add a note to inner_l2_len as follows?

struct rte_net_hdr_lens {
	uint8_t l2_len;
	/* Outer_L4_len + ... + inner L2_len for tunneling pkt. */
	uint8_t inner_l2_len;
	uint16_t l3_len;
	uint16_t inner_l3_len;
	uint16_t tunnel_len;
	uint8_t l4_len;
	uint8_t inner_l4_len;
};


>  		*proto = gnh->proto;
>  		if (gnh->proto == 0)
>  			*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
