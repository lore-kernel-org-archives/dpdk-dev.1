Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFE9CD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 12:46:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE9A84025F;
	Mon,  1 Jun 2026 14:46:33 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id B14D74025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 14:46:32 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CFDF77A03AB;
 Mon,  1 Jun 2026 08:46:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 01 Jun 2026 08:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780317991;
 x=1780404391; bh=36V/h47i2uCq/g4x8uRaOgHjn3DVSvHMQSitC6bE+D4=; b=
 JvIiUrUbZ+09faa2BulaCrVKPL2UaplX+1v9gxIQHUJMzcv49WBgu1pwI1SnzvpH
 zX4Vri1DFI+94F1JMXExIVSPrmJ19kja25L5Ka7xAtio/X1KlFIW8roXCd5Y0o5M
 ZMEXFmXE8I9fjpJFgxJDcKCI2CEDDqwMoIOdTbtS8cqPCQ/06aZ+OgglKYgoQNKj
 Zlk557foKkTl2say5fg9HV8BbEuARR58ebsiqziMFC6t4b0YwHJ0gKyMWHJKFii3
 uf4MQ7h7Zr05B5VxKwQJRajPbfV+L0Jek6FI+HX+GsJ1vdAIIYbwVe2T21qBMkXF
 WjsQ2kLm1YOQbD+jXAC01w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780317991; x=
 1780404391; bh=36V/h47i2uCq/g4x8uRaOgHjn3DVSvHMQSitC6bE+D4=; b=M
 FovZeh3q5hXmPA50IW5qC/910ji+aE1cnua9liK604gxuiQ4Hbc9iZbpyPwXpHO/
 WOUVAvgAVASfftBEp4fisgpE1sVMD32noXgB2xU/+WYbPbjOyYn2CPqZK6493Ai/
 +HyPpoClNRK8iTnUD0L0Uh1YfxPjXyy16T34RvPJKqUsDZCsBHzKF1+vLAUBo5Vs
 QQFrUWR3fHjYsc3si7vvRHHlXg2ieo1zxNKmRnJlb1R1ORqc4wKwd7AakQRWp3ou
 syoJIKLjPuS4N1zyO1EQ6nNxYmHjF/P059q1/F9rKSCYXy18QctHsONS0HPhCqcb
 JgZ7+VVByYP5R6daIIiqQ==
X-ME-Sender: <xms:J38daix543aMouapYzwAhAjmT1e7KCPobpJ6chDXPtelLHY7JLYObA>
 <xme:J38daikL4HcVNuO_EZRNrNWuAQ4VzR__erl9TpDBSzsd07pA2s4G-GgYfjHRyPX20
 DC8DZBmuz9LQCqOCwJ0gujAWdT_tH5k7ZabCIFF15kX1b2jTOPiPg>
X-ME-Received: <xmr:J38dajdJzAfVWLO_RtAclJ2VLycHfW2DQg7lEudnfcmXjjbgITJuouCn2amAHjHV_Wt6OnY5YZ7HzyIRdkPf4xIgsQ>
X-ME-Proxy-Cause: dmFkZTFbtroOaI5j3wkOQ75ie4k+pjxGNjqXQxsY6D9bDdQ1vaGWTEzJReMk72YFkS/OGK
 w2j0R+UwG85v7n6Qz4oI14VyVO7gkYWK3kH8nekT1f2z20Nqc+odfPGa+0/u+3+b30CI5V
 DLXU2Ah/hmhVsDxomm/x+JLvNUX7epS7918maKt5u4HMSoVsJA9WClOqxaAvitsvyCZgt6
 7n+Jh1xtzMEutDnIRyfZxy7bc3GrQKqLYYCqzBBWGcuZN639avLjSjAByon8H474TcMX3z
 fSrLW4WNpse6JwFj3TGWsy4gOAmaB03Lh/GuU1ebCz/16GpASPsvD3Dfn4Y5fNR114V+RE
 YN/ibG6ctCQzyjNWbFceXOU/UyqlRLH0QQmC3gEnG2vVk4Zb1D6ldoxzDQIuyiQ7y0ZkPD
 9HSRkbmvA9/jnZexc3TSMXcyVq0XTefrJ1NXHcb9Intkxth6yGeXtlkaD3phmUyPq22xrH
 vNE4RAzBKM6c1SvSY2a5qfXDxak661Ba5GuWU9oJWftOEFmhnUNZlI0nzrpvgtT3RvJcsP
 KOwBdDyzGkoxMcpT0Hkeu+4ta67ODq2M7gM8qBOJIjIh4BsbHNHKbo9igQn3RuoU41Jr1o
 2R+lQDMFhuTrSmQtOQEvdSt39aSj/G60K6RQvKMeuUQQnopbFJrdaOzFkQUg
X-ME-Proxy: <xmx:J38dagqOSL5umHwZL58cSTSLcKPuBdGJWCeOumgvKD9KK3pcBUT1IA>
 <xmx:J38dap5-NwbYV0VQWqT0dGzlvejXC5gooLs-8n0CyIO7izS3YnulSg>
 <xmx:J38daupg1Se_TgZU9ftySapP-JfVEVO7f8-o-yQoqP_87NjEj6NKnA>
 <xmx:J38dajj7BVnbHYljT4sEd5Vyay04BEbqCV52IRqlPGMTgdEdm4pVig>
 <xmx:J38dauUDH5lBXnqg650_RHViAqfkSjEbUZakx3h1NXe9vAbp4c0SftjC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:46:30 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: luca.boccassi@gmail.com
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] tree-wide: fix 'allow[s] to' grammar
Date: Mon, 01 Jun 2026 14:46:28 +0200
Message-ID: <rw3_27oiSRSGYdw9eSiVGg@monjalon.net>
In-Reply-To: <aejrN1XS0LEH7hdu@bricha3-mobl1.ger.corp.intel.com>
References: <20260422151901.3523790-1-luca.boccassi@gmail.com>
 <aejrN1XS0LEH7hdu@bricha3-mobl1.ger.corp.intel.com>
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

22/04/2026 17:37, Bruce Richardson:
> On Wed, Apr 22, 2026 at 04:18:53PM +0100, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> > 
> > Lintian flags 'allow[s] to' as grammatically incorrect, as it
> > requires an object before the next verb.
> > 
> > Fix docs, comments and son on by either switching to gerundinve or
> > adding 'one' as the object.
> > 
> > I: dpdk-doc: typo-in-manual-page "allow to" "allow one to" [usr/share/man/man3/rte_graph_model_mcore_dispatch.h.3.gz:32]
> > I: dpdk-doc: typo-in-manual-page "allow to" "allow one to" [usr/share/man/man3/rte_mbuf_dyn.h.3.gz:167]
> > I: dpdk-doc: typo-in-manual-page "allow to" "allow one to" [usr/share/man/man3/rte_mbuf_history.h.3.gz:71]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_bpf_ethdev.h.3.gz:41]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_ethdev.h.3.gz:3423]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_ethdev.h.3.gz:5197]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_ethdev.h.3.gz:5224]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_crypto_adapter_runtime_params.3.gz:32]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_dma_adapter_runtime_params.3.gz:32]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_eth_rx_adapter_runtime_params.3.gz:32]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_eth_tx_adapter_runtime_params.3.gz:35]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_flow.h.3.gz:2669]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_graph.h.3.gz:222]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_mempool_objhdr.3.gz:33]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_mldev.h.3.gz:807]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_eth_api.h.3.gz:44]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_ip4_api.h.3.gz:73]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_ip6_api.h.3.gz:50]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_pkt_cls_api.h.3.gz:18]
> > I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_udp4_input_api.h.3.gz:42]
> > 
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



