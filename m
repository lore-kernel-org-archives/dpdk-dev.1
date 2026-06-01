Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1EECD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 12:59:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A562D4025A;
	Mon,  1 Jun 2026 14:59:44 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id C6C754025F;
 Mon,  1 Jun 2026 14:59:43 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id D22841D00356;
 Mon,  1 Jun 2026 08:59:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 08:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780318782;
 x=1780405182; bh=6+RS0k52cbZg8QhhQeyc5yeZ+foNFa8pyF1p9gqzgdg=; b=
 o8RJ8OUlTe6iS8njvgy/frbrY3hHKcrioN482Y+2xX2bHY+dE0X0I+wLE3VflKWP
 2AAKaVEAMYTImXF7ajcKpIJTTlRlm+ZD/xYCRLcY1APIot8Bn2Xzc21H6wYKjzEI
 CB9gITYuVvXyo6/vOojU0HAJfoNbbClku+If7l8PjIFyGMuO//ORZs+7TNc/ZLZJ
 cxfDskPcm/sT8J/sqS24jZcOoUVAjlz5M+xJIr5uvcy+olZA8l6ctDfz9aNE4wl2
 gjE4ud0Yui9XmvbQ/DBJSaJobC7BpGIvX/oLM/oE5t5yz04XSd+dg/HKHfgf/4qZ
 k7g7RoF8pRKjDlvopOLXTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780318782; x=
 1780405182; bh=6+RS0k52cbZg8QhhQeyc5yeZ+foNFa8pyF1p9gqzgdg=; b=A
 Su32KUNvXWIfhslU9ri1rIvF1yCN23oFipfrlZoO8EvuIH/he3Vj6hi6zina/eX8
 wD7R4pIfdOfnriXL3gREn7RCJ0m8h2vEWtCQ+GsxmiroHt2pFn35w/Q5CADq/5vq
 0d3f+VOaCsuvWHa4Gs3Ua4m5pwi2byBsohsbmqEKlSjWcTUAp2xJkh9d4CG5SmO9
 hEcDZkugpsf0ziXhyGeWAO+OLM8j4gm2KbICF91EVPzf1UCdzBBwfTAu9Jomelxj
 2kKl37MxBa0OElFEMMqneo3CKaEyrwrJMyE3FdWu97qN66PeieOTywyHJ3fgH4AG
 niwicxEI8MemYhWG/w4SQ==
X-ME-Sender: <xms:PYIdajNHCt70KuEJdLjFH_gMcvUvW1ZFmO1qU6FMW_sO98Lkce_oVw>
 <xme:PYIdaoCCqfUdqSvT3jcwSErxZqWhPu1HIPxeimOMGXSAqESIP9LPiIf-6eCK4Mwjj
 IH9E2FqMMxxBRNMNN5H_wXrC1OGtQfK24cKx_rVrz_RoxO6UQHS>
X-ME-Received: <xmr:PYIdaiLsRaZKtlW6rk9kKxkVaaWILnfmjQEtkYv8N_RJ_HAV498MWI7TQUAByRRh9PcKxWyPXojay6e9dYSZREhpLw>
X-ME-Proxy-Cause: dmFkZTF7ebAyw5jYiKD/pdUBcXQqfMPUxun+TXoeArtdb7KUWQfdxFdKLo5v3JoNp9MPAd
 Q2cEOQh4qSrmsgQDnn3isg3P6PDRxXk7M4pBo8EHGlV7s3C1Mo1M7Wt2lPT05poBBaICfX
 CV6izqwgIYt77a67U7bQFcRkzgqsT5QYna8MYVSluwcaLumpW2xZaRnR9lBy5596bMokqB
 45AWfzipe8gnVDnv62tJZD38GlTUYtlO+rgv3fFr3jCpBxIEGA62dIAufL95O6Wd6jeS3Q
 o5xHDALAWHvbgnyx3r4hAdtgS8+qHR83tihIaUYRkAppTwOubrXZDNDoh5jLSSFlOqoyC+
 nA3cGpzWkwluozH7rxb6uEgge9HGxBKqORXhwEkvIZSkwesKBMr1jtNJNGPfyyy2xmVd4C
 gKcYZjFjbEnrZGM4HodSBiKrPAzVYm15t1Wx+Pwz+yI/ao7UpMtV6Ic22zuAXG0nkexMgJ
 b2vHJ5bVLWb+iygDcktY8keSAoN/XbVNfoRzjxOmIiIkeL7A3lV5O/dEB5r8u9nSL+1o40
 u5OEG8Cg7JZtnra0Zv/88tQHrHDOksUf2oFVrGr5EvdEG0bJrlIM97QV13yVqR1cgWKgni
 NshQGUFVX71rks4raCQXoLTFBv2M/o6JFcXiwcFwU0FOBj9k7EhFDg7filTQ
X-ME-Proxy: <xmx:PYIdapMRrVcYMcRbal0VWEqOTyxCpocK4rKSuAHv3THcUf0ycA5aHw>
 <xmx:PYIdao5LixO9nHN4NpnihjS8Anfrc065ebldZwftxl0-GUpvjsOwCA>
 <xmx:PYIdaj7dAbjHXCt7qLPOnGRCjcbhmegSZnRPrdjYf8hSZHl6oF-Ttw>
 <xmx:PYIdauF19-bwUHMcokIIvfME-ZIs2epR-j0uH6WO7vJICJAwQsPUTQ>
 <xmx:PoIdanzobfDMv3JlUsrOdDCUDWCH7XubbeYimGrS9HZ6N8P20UZfx2FT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:59:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jie Hai <haijie1@huawei.com>
Subject: Re: [PATCH] net: fix GTP Tunnel parse out-of-bounds read
Date: Mon, 01 Jun 2026 14:59:38 +0200
Message-ID: <-yUhN_HpTAq8QmssYJx54A@monjalon.net>
In-Reply-To: <20260409161556.141251-1-stephen@networkplumber.org>
References: <20260409161556.141251-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Any comment about this fix?


09/04/2026 18:15, Stephen Hemminger:
> If packet is fragmented across multiple mbufs or the packet
> has only GTP header the code would reference outside
> the incoming mbuf.
> 
> Send GTP packet:
> - Valid GTP header (8 bytes)
> - msg_type = 0xff
> - e=1, s=1, pn=1 (sets gtp_len = 12)
> - Total packet size = 10 bytes
> 
> Read at gh + 12 accesses 2 bytes beyond packet end.
> 
> The fix is to use rte_pktmbuf_read in a manner similar
> to the read of the GTP header.
> 
> Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/net/rte_net.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index 458b4814a9..da4018437b 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -219,8 +219,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>  	case RTE_GTPU_UDP_PORT: {
>  		const struct rte_gtp_hdr *gh;
>  		struct rte_gtp_hdr gh_copy;
> -		uint8_t gtp_len;
> -		uint8_t ip_ver;
> +		uint32_t gtp_len;
>  		gh = rte_pktmbuf_read(m, *off, sizeof(*gh), &gh_copy);
>  		if (unlikely(gh == NULL))
>  			return 0;
> @@ -231,9 +230,16 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>  		 * Check message type. If message type is 0xff, it is
>  		 * a GTP data packet. If not, it is a GTP control packet
>  		 */
> +		*off += gtp_len;
>  		if (gh->msg_type == 0xff) {
> -			ip_ver = *(const uint8_t *)((const char *)gh + gtp_len);
> -			ip_ver = (ip_ver) & 0xf0;
> +			const uint8_t *l3_hdr;
> +			uint8_t l3_copy, ip_ver;
> +
> +			l3_hdr = rte_pktmbuf_read(m, *off, sizeof(*l3_hdr), &l3_copy);
> +			if (unlikely(l3_hdr == NULL))
> +				return 0;
> +
> +			ip_ver = *l3_hdr & 0xf0;
>  			if (ip_ver == RTE_GTP_TYPE_IPV4)
>  				*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
>  			else if (ip_ver == RTE_GTP_TYPE_IPV6)
> @@ -243,7 +249,6 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>  		} else {
>  			*proto = 0;
>  		}
> -		*off += gtp_len;
>  		hdr_lens->inner_l2_len = gtp_len + sizeof(struct rte_udp_hdr);
>  		hdr_lens->tunnel_len = gtp_len;
>  		if (port_no == RTE_GTPC_UDP_PORT)
> 





