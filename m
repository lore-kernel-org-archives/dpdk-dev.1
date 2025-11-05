Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A9DCCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 10:13:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4133B4065E;
	Wed,  5 Nov 2025 11:13:54 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 3DBD4400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 11:13:52 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id DACA61400200;
 Wed,  5 Nov 2025 05:13:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 05 Nov 2025 05:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762337631;
 x=1762424031; bh=tDutuyjcFOz57u2t0VzChS5uBJ7JelP/LiD1787Ytpw=; b=
 tyyA0hvsgetfo3IhgAmoGXvApRPVKPANOZu+1agCfmvfx2GtjjIwyU+I6VBV1eWv
 cfjzBxlQNaSaB/5zeHErdEnGCkb0P+ktEtoNzNkD7INCs71Y9uqLpAMSxD0XxUo2
 Q+6SoW5IBBuAOH0ldeUVdjWR2G+lXy+FodzSBtihe08A5mT/N81REeiCkM+g6ZIY
 meDxWg5cA2mTqx4gWsAbAmsSxHs1KQhv14NA2OZNUsiYqAGNeDho6UqsI/pxkcfS
 q9oMVkXaQzU+OMgB94oiCbVgfKzES0kUQW4b8J1R7T/hoO+gsv4pWguhirFmSYT+
 bTz9/Ba2B2l6y3rgN7OGfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762337631; x=
 1762424031; bh=tDutuyjcFOz57u2t0VzChS5uBJ7JelP/LiD1787Ytpw=; b=T
 b4aZB0/zdydVcPLmnXskm/KjCPMN68fJQ6rm02buU8OEC3z31xnAWe910ZkQDyUX
 T6TR4cxjAFwAibXKc+0DwnHWlhBkUbJRXLZADhQdNhJ2VD6a8HDqGe/ZNuRyj2bx
 r0z9/OkbXmYl0gIc7H8cMg7eu80h/bgYxz2mYp6NbQayrkzCdWz6YIDCauyCONz1
 ezru9nnsdPiXkjK3pBp8ygadeDLGmqAK2g+9ly/vEslbL3as6FQP2yFTNl5Vu7AU
 o68Pf5gMKOxGDhj6oOVtHeLFMvNZ2zfDVGq99htfKXjTgQAAinWjeao6lAiw6v1p
 eMcnjSicLml6OBbzkteHA==
X-ME-Sender: <xms:XyMLaVkd30tOVfYAtuiXAh2uoEYlxmvy8LnGCtJoBuJ474IlBsg6yw>
 <xme:XyMLaVJgAZyLwFcAyTiAo0VNnAKX9s2nsmAK18V3p9X-83C7cyncfkgKefUTBjm7l
 U22_Q5rPQEMw6KiUGPANIWJ7LzinAnnMRBFtFbZh70xWuuHQNGyBA>
X-ME-Received: <xmr:XyMLaaxhTGy_9bl_P2ox_ZjNkQCNC7-ZC8L6VmbgM6tePdWuX6divJtrXTx9-H2vOk-ufc73ToYZq2HywB_APo09bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeefieefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegshhgrghihrggurgdrmhhouggrlhhise
 grmhgurdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 rhgrghhhrghvvghnughrrgdrnhhinhhgohhjihesrghmugdrtghomh
X-ME-Proxy: <xmx:XyMLadsVqKBPmwwZdlXKuvv9tBVSTvawaH-GnOcYVp1_cCyKovWbbA>
 <xmx:XyMLaZsYlq_zdDLEhAUhWav-nPXDOTg82Bf9QYgeozcXsJDahiGKCA>
 <xmx:XyMLaaM_sp4wCMvD_peKVT2IwTf3y0eh0t09OI_AIgY02aTZvx7vcA>
 <xmx:XyMLaf0FtyXBa4HIN5YSFjgSMmYW9PBW-F0DYGbQFQl9QrWqDzJcsw>
 <xmx:XyMLaR2k0vqKWH3ZT_dSII7WvooXRwALffmW4YNlgR1QfUYU2CDv0lkm>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 05:13:50 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bhagyada Modali <bhagyada.modali@amd.com>
Cc: dev@dpdk.org, raghavendra.ningoji@amd.com
Subject: Re: [PATCH] ntb/ae4dma: added Amd userspace DMA and NTB drivers
Date: Wed, 05 Nov 2025 11:13:49 +0100
Message-ID: <3713570.9VTjjQsp5K@thomas>
In-Reply-To: <20250705141001.34223-1-bhagyada.modali@amd.com>
References: <20250705141001.34223-1-bhagyada.modali@amd.com>
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

05/07/2025 16:10, Bhagyada Modali:
> Added a user-space driver with support for the
> 	AMD EPYC 4th Generation DMA (AE4DMA) offload engine.
> 	AMD Non Transparent Bridge driver.
> 
>       - Implementation of new user-space driver supporting
>         NTB and DMA memory copy offload on AMD EYPC 9004 & 8004
> 	systems (Genoa and Siena processors).
>       - Updated the NTB_FWD application to support AMD NTB driver.
> 
> Signed-off-by: Bhagyada Modali <bhagyada.modali@amd.com>

It looks to be a draft.
There are so many problems in this patch that I was expecting a follow-up,
but looks like no.

Please check the contributors guide for the tools you should run
before submitting.
Then make sure your patch pass the CI in patchwork.

Thank you


