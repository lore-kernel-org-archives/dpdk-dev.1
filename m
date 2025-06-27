Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D8C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 09:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 454D44026D;
	Fri, 27 Jun 2025 11:23:49 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id AB6DB4025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 11:23:47 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C478D7A00CE;
 Fri, 27 Jun 2025 05:23:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Fri, 27 Jun 2025 05:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751016226;
 x=1751102626; bh=ac2rSbFhOntvN9vd0k7AzslgVYw3j08EDjyBwODae7g=; b=
 glymN8oPZvNI8IFvMTXxHUM7o+z+43scSHzoZfPiH/Z993uAkgc7hzCGy5JFwHb7
 8jxHLR55nTW4puIUu8WcANo5cuoB/dtTXdcfrdbTi3sKBppFEC4LekbQz5tCc4cV
 qe1zI5hMPERr7kWHmiZcGbDVl+2vb7V2WFV0GXJIwCzpLtcksh98SwnSAZT1VFoz
 tUMKDBBIDTY5FO3HUHNe+djmhVi7/G8br+X3/F3oSl1EtbiRwT+mdOzfqG/FdGQh
 +Em67/e7Zc7cF5jJkDNFLGCJKs0noPhF3bJBKSX7WIvRFQsfc+1/rc9b9dWAv6kk
 RwKGG/IcAl8ftOxMcSQDcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751016226; x=
 1751102626; bh=ac2rSbFhOntvN9vd0k7AzslgVYw3j08EDjyBwODae7g=; b=V
 FNApCia7MDczkQwLvZKWm+fN5No+sZLUGQLovFBrYOWoStQuVJEswsoRpv1yhNA1
 lzXjAYvrVrABYXrfhkNxrsBF+ZDVVOajKiAixCC4hHR8naTc48UlrZ15PaOTvfeC
 OefaVoeZL9CkVcKPAnqbarhqKOxBcSng7UtdPe1zY+XtKxbvcPCsLUxAN9QXrCrt
 7Kw4LLH3FFWcb2zvHurm3C9GyJIIiZnt7vGwmTnKVZG9APw+bPEP5yJknHgXxGYj
 Ta4cFKpvE0ZFhjZfmq04QReSyTYtO9UTyHpluVQ1+JTAjsIRTLyWwKV23DhGATpV
 FCffckSASMbncl16Ab8dw==
X-ME-Sender: <xms:ImNeaIsIey0CHvobgNT_TxZX3_wyuE8EpGVuC-yV04XfMom0pDfErg>
 <xme:ImNeaFehKZlV1BEEWgcD3Ux7RLV_xbAC_dtF7jxBWievkOIsdDpUsGykWSjsz9Zc6
 hDuz758UtqggQrYBA>
X-ME-Received: <xmr:ImNeaDw0QsOfDvKbEdYAVm3gQzcXS4o6oHGVy_cOigb2Quu_gL5_buKRlJwXAF4hFHR_OP37J0XcslrSLSbci2ujTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvieelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehjuhhnfhgvnhhgghesnhhvihguihgrrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepughsohhsnhho
 fihskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhose
 hnvhhiughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdp
 rhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnh
 hmihhnghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopehmrghtrghnsehnvhhiughi
 rgdrtghomh
X-ME-Proxy: <xmx:ImNeaLORURJFB4biefIMaUkk5Bhg-qFIfhsCppPbMXkkOb3rsfVVMg>
 <xmx:ImNeaI-f6dyo50ODpM0IiogzX0rgRXLO6PZp7K_7nGLGACAp2r6CCw>
 <xmx:ImNeaDUGjo9sb2pejAXoEaXNGHhcIwN4oEBmYfiPLmgwtpoF7kjDOg>
 <xmx:ImNeaBfUhdo1rXG8qID5swnFgGFiLEHxGZpg7MxTnJXm86EdeqXVPA>
 <xmx:ImNeaGPk44sNS-ZSuiFULoOF4_C5WhO_iNav72ZGR3m-LtLWA0TzCKVI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 05:23:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Junfeng Guo <junfengg@nvidia.com>
Cc: dev@dpdk.org, dsosnowski@nvidia.com, viacheslavo@nvidia.com,
 bingz@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH 0/2] Support IPIP Tunnel in NT2HWS and HWS
Date: Fri, 27 Jun 2025 11:23:43 +0200
Message-ID: <4041421.NnIJQXNAa5@thomas>
In-Reply-To: <20250620104203.261435-1-junfengg@nvidia.com>
References: <20250620104203.261435-1-junfengg@nvidia.com>
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

20/06/2025 12:42, Junfeng Guo:
> This patchset support IPIP Tunnel in NT2HWS and HWS, including the
> following {IPv4 x IPv6} combinations:
>  - IPv4 over IPv4
>  - IPv4 over IPv6
>  - IPv6 over IPv4
>  - IPv6 over IPv6
> 
> This feature cover both basic IPIP and IPIP over VXLAN Tunnel types.
> 
> Junfeng Guo (2):
>   net/mlx5/hws: recognize IPIP in definer layer
>   net/mlx5: support IPIP flow for all combinations

Applied, thanks.


