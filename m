Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E4C87FCC
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 10:21:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF054402E6;
	Thu, 31 Jul 2025 12:21:23 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 3FD024025A;
 Thu, 31 Jul 2025 12:21:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 40D8438
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1753957281;
 bh=Uu1gugnFZZidzrPoYXfXTT2kBZlclzhEA/nhIbHsZGA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ch4Q19W5F48X8ORvsN5QUY3Id6qTZfwL9zw0uDpFh7l0c9fvhgJK+PVuxmr9K2Epa
 M5n56zc/Lnu2/UDXL7uSX/i/7OMJ6bFTUXwQITwRMMvJTt4w87a2/K1KiYpTDGHAGy
 fKml2q80fyeAMb2RB54V6c0sqk0AF9HlmIdh1erE=
Received: from [192.168.1.39] (unknown [188.170.87.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 40D8438;
 Thu, 31 Jul 2025 13:21:21 +0300 (MSK)
Message-ID: <22332c8e-2fde-408e-ab26-5330d4bca544@oktetlabs.ru>
Date: Thu, 31 Jul 2025 13:21:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, dev@dpdk.org,
 jasvinder.singh@intel.com, bruce.richardson@intel.com
Cc: thomas@monjalon.net, stable@dpdk.org
References: <20250728131222.50441-1-14pwcse1224@uetpeshawar.edu.pk>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250728131222.50441-1-14pwcse1224@uetpeshawar.edu.pk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/28/25 16:12, Khadem Ullah wrote:
> Fix incorrect inner_l2_len values for VXLAN, VXLAN-GPE, GTPU, and Geneve.
> These protocols carry full Ethernet frames, so inner_l2_len should be
> set to the size of an Ethernet header (14 bytes), not include tunnel or
> UDP headers.


Please, take a look at the definition of the inner_l2_len in rte_net.h.

NACK

> 
> Fixes: 64ed7f854c ('net: add tunnel packet type parsing')
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>   lib/net/rte_net.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index 44fb6c0f51..adcddeb670 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -198,7 +198,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>   	case RTE_VXLAN_DEFAULT_PORT: {
>   		*off += sizeof(struct rte_vxlan_hdr);
>   		hdr_lens->tunnel_len = sizeof(struct rte_vxlan_hdr);
> -		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_HLEN;
> +		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
>   		*proto = RTE_VXLAN_GPE_TYPE_ETH; /* just for eth header parse. */
>   		return RTE_PTYPE_TUNNEL_VXLAN;
>   	}
> @@ -210,7 +210,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>   			return 0;
>   		*off += sizeof(struct rte_vxlan_gpe_hdr);
>   		hdr_lens->tunnel_len = sizeof(struct rte_vxlan_gpe_hdr);
> -		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_GPE_HLEN;
> +		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
>   		*proto = vgh->proto;
>   
>   		return RTE_PTYPE_TUNNEL_VXLAN_GPE;
> @@ -244,7 +244,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>   			*proto = 0;
>   		}
>   		*off += gtp_len;
> -		hdr_lens->inner_l2_len = gtp_len + sizeof(struct rte_udp_hdr);
> +		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
>   		hdr_lens->tunnel_len = gtp_len;
>   		if (port_no == RTE_GTPC_UDP_PORT)
>   			return RTE_PTYPE_TUNNEL_GTPC;
> @@ -262,7 +262,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>   		geneve_len = sizeof(*gnh) + gnh->opt_len * 4;
>   		*off += geneve_len;
>   		hdr_lens->tunnel_len = geneve_len;
> -		hdr_lens->inner_l2_len = sizeof(struct rte_udp_hdr) + geneve_len;
> +		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
>   		*proto = gnh->proto;
>   		if (gnh->proto == 0)
>   			*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
> @@ -498,7 +498,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
>   		pkt_type |= RTE_PTYPE_INNER_L2_ETHER;
>   		proto = eh->ether_type;
>   		off += sizeof(*eh);
> -		hdr_lens->inner_l2_len += sizeof(*eh);
> +		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
>   	}
>   
>   	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
> @@ -511,7 +511,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
>   		if (unlikely(vh == NULL))
>   			return pkt_type;
>   		off += sizeof(*vh);
> -		hdr_lens->inner_l2_len += sizeof(*vh);
> +		hdr_lens->inner_l2_len += sizeof(struct rte_vlan_hdr);
>   		proto = vh->eth_proto;
>   	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
>   		const struct rte_vlan_hdr *vh;
> @@ -524,7 +524,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
>   		if (unlikely(vh == NULL))
>   			return pkt_type;
>   		off += 2 * sizeof(*vh);
> -		hdr_lens->inner_l2_len += 2 * sizeof(*vh);
> +		hdr_lens->inner_l2_len += 2 * sizeof(struct rte_vlan_hdr);
>   		proto = vh->eth_proto;
>   	}
>   

