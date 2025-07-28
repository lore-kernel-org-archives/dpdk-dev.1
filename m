Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F412C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 13:28:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 117DD4029A;
	Mon, 28 Jul 2025 15:28:51 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B45D040297;
 Mon, 28 Jul 2025 15:28:49 +0200 (CEST)
Received: from debian (unknown [78.109.65.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id D4877E0BEC;
 Mon, 28 Jul 2025 17:28:48 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am D4877E0BEC
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753709329;
 bh=V1mvY7K4VOVki9vhALqmbFaAhIwLKEx5OBeaijfrGjg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=RhZcLzSnisEXCNqaxjxh2GHHX8XISjU3PgU0/+x9AfgEbczG/vScMkFlrkRkHcf1C
 NAFtp7KDQwYVzb1aP5kBGL54Suxwu6G6ete3HZSB5xcCre6ZVJuDk6v493Tc+5xurm
 SWT5larUAFT7eb+aqXvtam1qHHb76Yo/JPiDlmL+bn7o0sEmaTUfKa7nLQlD638El6
 eP8p1oPYgqgkRstzi0J/388m9b5cdGJwpK51Rs5zkJvGLK4RSwIo3qMv7x38mCKCtd
 k3QFg73CPNUjjKxPdR36IfOCwrMMEhxBV1PNQWPkZI+fgcJVLFnCjI8JizWkT7klip
 06w2TduP0Hq3A==
Date: Mon, 28 Jul 2025 17:28:47 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
cc: dev@dpdk.org, jasvinder.singh@intel.com, bruce.richardson@intel.com, 
 thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, stable@dpdk.org
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
In-Reply-To: <20250728131222.50441-1-14pwcse1224@uetpeshawar.edu.pk>
Message-ID: <e7c3c2b2-5f7a-eec4-cbd8-cd17ecec4c46@arknetworks.am>
References: <20250728131222.50441-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Mon, 28 Jul 2025, Khadem Ullah wrote:

> Fix incorrect inner_l2_len values for VXLAN, VXLAN-GPE, GTPU, and Geneve.
> These protocols carry full Ethernet frames, so inner_l2_len should be
> set to the size of an Ethernet header (14 bytes), not include tunnel or
> UDP headers.

Does the bug break 'testpmd' (see 'inner_l2_len' over there) or what? How can
this be reproduced?

Also, how well does the patch agree with what is currently said in 'rte_net.h'?

>	/* Outer_L4_len + ... + inner L2_len for tunneling pkt. */
>	uint8_t inner_l2_len;

Is the comment also wrong or do we have a fundamental confusion in DPDK?

I know, for example, that in mbufs, in the case of a tunneled (VXLAN) packet,
fields 'outer_l2_len' and 'outer_l3_len' are Ethernet and IP sizes respectively,
whilst 'l2_len' is a sum of the UDP size, VXLAN size and inner Ethernet header.
But that's in mbuf, which does not have a separate 'tunnel_len' field.

So either there's some confusion, or the patch also needs to fix other places,
such as the header file mentioned ('rte_net.h').

Thank you.


>
> Fixes: 64ed7f854c ('net: add tunnel packet type parsing')
> Cc: stable@dpdk.org
>
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
> lib/net/rte_net.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index 44fb6c0f51..adcddeb670 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -198,7 +198,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
> 	case RTE_VXLAN_DEFAULT_PORT: {
> 		*off += sizeof(struct rte_vxlan_hdr);
> 		hdr_lens->tunnel_len = sizeof(struct rte_vxlan_hdr);
> -		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_HLEN;
> +		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
> 		*proto = RTE_VXLAN_GPE_TYPE_ETH; /* just for eth header parse. */
> 		return RTE_PTYPE_TUNNEL_VXLAN;
> 	}
> @@ -210,7 +210,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
> 			return 0;
> 		*off += sizeof(struct rte_vxlan_gpe_hdr);
> 		hdr_lens->tunnel_len = sizeof(struct rte_vxlan_gpe_hdr);
> -		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_GPE_HLEN;
> +		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
> 		*proto = vgh->proto;
>
> 		return RTE_PTYPE_TUNNEL_VXLAN_GPE;
> @@ -244,7 +244,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
> 			*proto = 0;
> 		}
> 		*off += gtp_len;
> -		hdr_lens->inner_l2_len = gtp_len + sizeof(struct rte_udp_hdr);
> +		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
> 		hdr_lens->tunnel_len = gtp_len;
> 		if (port_no == RTE_GTPC_UDP_PORT)
> 			return RTE_PTYPE_TUNNEL_GTPC;
> @@ -262,7 +262,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
> 		geneve_len = sizeof(*gnh) + gnh->opt_len * 4;
> 		*off += geneve_len;
> 		hdr_lens->tunnel_len = geneve_len;
> -		hdr_lens->inner_l2_len = sizeof(struct rte_udp_hdr) + geneve_len;
> +		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
> 		*proto = gnh->proto;
> 		if (gnh->proto == 0)
> 			*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
> @@ -498,7 +498,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
> 		pkt_type |= RTE_PTYPE_INNER_L2_ETHER;
> 		proto = eh->ether_type;
> 		off += sizeof(*eh);
> -		hdr_lens->inner_l2_len += sizeof(*eh);
> +		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
> 	}
>
> 	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
> @@ -511,7 +511,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
> 		if (unlikely(vh == NULL))
> 			return pkt_type;
> 		off += sizeof(*vh);
> -		hdr_lens->inner_l2_len += sizeof(*vh);
> +		hdr_lens->inner_l2_len += sizeof(struct rte_vlan_hdr);
> 		proto = vh->eth_proto;
> 	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
> 		const struct rte_vlan_hdr *vh;
> @@ -524,7 +524,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
> 		if (unlikely(vh == NULL))
> 			return pkt_type;
> 		off += 2 * sizeof(*vh);
> -		hdr_lens->inner_l2_len += 2 * sizeof(*vh);
> +		hdr_lens->inner_l2_len += 2 * sizeof(struct rte_vlan_hdr);
> 		proto = vh->eth_proto;
> 	}
>
> -- 
> 2.47.3
>
>
