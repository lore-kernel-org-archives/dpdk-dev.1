Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F7CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 14:45:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAAB740395;
	Wed,  5 Nov 2025 15:45:22 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 7B0A74021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 15:45:21 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D6055140022F;
 Wed,  5 Nov 2025 09:45:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 05 Nov 2025 09:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762353920;
 x=1762440320; bh=GcJNsoMlyqytUOFE/7ilZFDypN+vfyPOoMn1Ej/I2Oc=; b=
 hbis1GZhjKGSiQ2+jxVDyBVOYsl4P4bDjD/7w8GLNnKCMC5BE0BxrZS9FhWw29P5
 xzXB9RrYo+/chdZlQPyiDI5sU5/ug7ghylshSm14Z9P2I6517GiLq2iwjWk6Kft8
 lJG+Y1Stfx/KrlWFweQ8pZ6zMQJhBA5u9xB+5kx/DqqRHrODdP1OcgbckHcPGZL9
 rG1p8ctWBcfsahSm0OmGgjfPB2nRxnOwYYjhdS4bZZ4iGJRZdFf1NVjENqMqnG5d
 ll5nqRoVdcutDgTBSQPXHlghiEYaw+lHPr02gOy8kIJzM/1yQnct1jjTa3KfV4Is
 i+n+5/0QmIfaJmjfCdsIow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762353920; x=
 1762440320; bh=GcJNsoMlyqytUOFE/7ilZFDypN+vfyPOoMn1Ej/I2Oc=; b=Y
 6/xdMsa0Uh/Hdw3G+J0SpZ1OxvGwZDwUaGGu80Eo/GAYKbU3luykO4PRDDPu0XiM
 7kewByh81CX+fUBwigk/xHXvY9+zSPdhVsGo7RKII5I7SzWjS/873mwWCFtihqvV
 6pwVX1FBHskKdU2hOxzpw502lCmQgHi7wYlpY5mpmBqM0bOzLOufEvRq9IGe1B/L
 wjdhYX3cHebDun+wTeh9NM/5rzSJjurcUm6q6osT46Ux22b3mYYy//OQlin9xuhq
 FPY+BuAaHZkl+LKnOS96LWFR9/wKsVzUrI3GHxj2Yy6fERDqljIwk3k8p5RCl5hQ
 5+NZR73IRRuJeSXnYbKSg==
X-ME-Sender: <xms:AGMLacL5XCmBOjXKoSt8mprVEkPYJoJoVRQa06AiB_huAJ-iNW7BzA>
 <xme:AGMLaQePaj0BAybOcRG6ik8sMd5ThcXsPUMW2zs482WI8yn4NaU8k0m5ZyFlRaCgK
 bgvs6xe7AITMQCx6yEw2SXmHyrHEJf4596WYUoKO5onBqWxb9ltQdA>
X-ME-Received: <xmr:AGMLab3i56piSRkI7d0CbVYwo9310-39EUq4TPUca6GR096abdPYbVFbpN_CohLxBYrp_h0HwM0BG5EL93je3rHetw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegudejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 lhhiuhihohhnghhlohhngheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:AGMLaRhQf7g3Bzyv_lpue9VjYq6s3OQf-buhktRlgyuKQewih_i57w>
 <xmx:AGMLaZSyyMqXKRw_s8g4KQ1knscy4dwD5rphB5v_2i7wdv7DR74uWQ>
 <xmx:AGMLaaiEH4ntAnG9ykErI4nLWLMl8c-ePG1u3v09LmrLZj1dCBcQug>
 <xmx:AGMLaR7n2xghtTZLBXU6I78AZudFKTF7jqyc5gextEekCZ6UlUT9WA>
 <xmx:AGMLaXJm_WGksIr_N5sr0q7vtiAIW11jaAE52H3UEumcyTUeagxLY9Jh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 09:45:19 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org, liuyonglong@huawei.com
Subject: Re: [PATCH v6 0/4] add Hisilicon accelerator DMA driver
Date: Wed, 05 Nov 2025 15:45:17 +0100
Message-ID: <2360683.G7SD5HZVK5@thomas>
In-Reply-To: <20251016025318.14333-1-fengchengwen@huawei.com>
References: <20250827092729.10719-1-fengchengwen@huawei.com>
 <20251016025318.14333-1-fengchengwen@huawei.com>
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

16/10/2025 04:53, Chengwen Feng:
> This patchset adds Hisilicon accelerator DMA driver which based on
> UACCE bus.
> 
> Chengwen Feng (4):
>   dma/hisi_acc: add probe and remove
>   dma/hisi_acc: add control path ops
>   dma/hisi_acc: add data path ops
>   dma/hisi_acc: add doc

Split and squashed the doc commit with minor fixes.
Applied, thanks.



