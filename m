Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C81CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 00:16:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1347040281;
	Tue, 18 Nov 2025 01:16:18 +0100 (CET)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 937214027D;
 Tue, 18 Nov 2025 01:16:15 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=wh/1h2RhG6/7Gbfk7qFoFvsMF7KrkYKy3zLBrPL26Ns=;
 b=EoeorKHI4x8TRnBO/mBHhZJ212njAJpZthQt/P7QZpAWw4RmDGQOs79BYeDJkbJ23v0SPx/7D
 zRfoiO6coleKqzqT+1DzzZltgYHHudOmBMH4TidudH/mpGkfLbHN8HSmPv8DTBGbzMzrfqbTX+a
 WzK71+kcdydO4i7OR6sE1Rg=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d9Q903Hd3z12LF5;
 Tue, 18 Nov 2025 08:14:44 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C885D140203;
 Tue, 18 Nov 2025 08:16:12 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 08:16:12 +0800
Message-ID: <2ab451a3-accd-41a7-bde3-60a61cb478c0@huawei.com>
Date: Tue, 18 Nov 2025 08:16:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] app/testpmd: revert L4 protocol retrieval from L3
 header
To: Mingjin Ye <mingjinx.ye@intel.com>, <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
References: <20251105024724.830304-1-mingjinx.ye@intel.com>
 <20251105024724.830304-2-mingjinx.ye@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251105024724.830304-2-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 11/5/2025 10:47 AM, Mingjin Ye wrote:
> This reverts commit 496159613ffc7b6ba592432a1ba4d1a38f6935de.
> 
> When the TX IP checksum offload feature is enabled, it may result in
> internal UDP checksum errors in VXLAN tunnel packets.
> 
> Fixes: 496159613ffc ("app/testpmd: fix L4 protocol retrieval from L3 header")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
>  app/test-pmd/csumonly.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
> index a6e872e5a4..d355dbd8c0 100644
> --- a/app/test-pmd/csumonly.c
> +++ b/app/test-pmd/csumonly.c
> @@ -525,8 +525,20 @@ get_tunnel_ol_flags_by_ptype(uint32_t ptype)
>  	}
>  }
>  
> +static void
> +parse_inner_l4_proto(void *outer_l3_hdr,
> +			struct testpmd_offload_info *info)
> +{
> +	struct rte_ipv4_hdr *ipv4_hdr = outer_l3_hdr;
> +	struct rte_ipv6_hdr *ipv6_hdr = outer_l3_hdr;
> +	if (info->ethertype == _htons(RTE_ETHER_TYPE_IPV4))
> +		info->l4_proto = ipv4_hdr->next_proto_id;
> +	else
> +		info->l4_proto = ipv6_hdr->proto;

this function get L4 proto direct from header which can't handle inner IPv6 with option.

> +}
> +
>  static uint8_t
> -parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool parse_inner)
> +parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype)
>  {
>  	int frag = 0, ret;
>  
> @@ -545,19 +557,16 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool pars
>  		if (unlikely(ip6h == NULL))
>  			return 0;
>  
> -		if (!parse_inner && (ptype & RTE_PTYPE_L3_MASK) != RTE_PTYPE_L3_IPV6_EXT)
> -			return ip6h->proto;
> -
> -		if (parse_inner && (ptype & RTE_PTYPE_INNER_L3_MASK) != RTE_PTYPE_INNER_L3_IPV6_EXT)
> -			return ip6h->proto;
> +		if ((ptype & RTE_PTYPE_INNER_L3_MASK) ==
> +				RTE_PTYPE_INNER_L3_IPV6_EXT) {
> +			ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
> +			if (ret < 0)
> +				return 0;

this logic has problem: parse_l4_proto was used to prase outer L4 if in tunnel case, but it depend on
whether inner is L3_IPV6_EXT.

> +			return ret;
> +		}
>  
> -		off += sizeof(struct rte_ipv6_hdr);
> -		ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
> -		if (ret < 0)
> -			return 0;
> -		return ret;
> +		return ip6h->proto;
>  	}
> -
>  	return 0;
>  }
>  
> @@ -696,7 +705,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
>  		info.l4_len = hdr_lens.l4_len;
>  		info.ethertype = get_ethertype_by_ptype(eth_hdr,
>  					ptype & RTE_PTYPE_L3_MASK);
> -		info.l4_proto = parse_l4_proto(m, info.l2_len, ptype, false);
> +		info.l4_proto = parse_l4_proto(m, info.l2_len, ptype);
>  
>  		l3_hdr = (char *)eth_hdr + info.l2_len;
>  		/* check if it's a supported tunnel */
> @@ -714,11 +723,9 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
>  		}
>  		/* update l3_hdr and outer_l3_hdr if a tunnel was parsed */
>  		if (info.is_tunnel) {
> -			uint16_t l3_off = info.outer_l2_len +  info.outer_l3_len + info.l2_len;
> -
>  			outer_l3_hdr = l3_hdr;
>  			l3_hdr = (char *)l3_hdr + info.outer_l3_len + info.l2_len;
> -			info.l4_proto = parse_l4_proto(m, l3_off, ptype, true);
> +			parse_inner_l4_proto(l3_hdr, &info);
>  		}
>  		/* step 2: depending on user command line configuration,
>  		 * recompute checksum either in software or flag the

