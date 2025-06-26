Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582D1C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 12:17:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6211402D3;
	Thu, 26 Jun 2025 14:17:12 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 1C7AF402B6;
 Thu, 26 Jun 2025 14:17:11 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A11C6140006E;
 Thu, 26 Jun 2025 08:17:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 26 Jun 2025 08:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1750940230;
 x=1751026630; bh=AudIdya6MBIGgu4OzNx+vRH9B5DX+ouMI7q6TQlLWq4=; b=
 b47Ks/m+kggjOh0eGhrNHGN3jCWKJJxys8ksU8sVd729rRv/GzOh1KjW2z+1XdZP
 fH2rbT2FkZWH36QVjIV4XnquRRd2QDEbqPqrt8vxzFW2JmYB6HDS5ElFCBuDb94W
 h6ns4xGK39LqgpJj20c4KjWNzdh/PrBqZTOfc8sM+FuUhxRyYWIF1+GA3f3aAVRf
 xEA3BDfltgyl8P/mX3EgQRcfBdm+tPco8dTTXapUkQYYAB0QQTRCvXhberq6MU0s
 uwG4fbDguHUAPXiqBP5PzOROH0NdpV5DTyqH/1OnDBT6hq0oEHcKiJ8IGMBON2SD
 cLtIG2H6YGOnXNZIRzdW+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750940230; x=
 1751026630; bh=AudIdya6MBIGgu4OzNx+vRH9B5DX+ouMI7q6TQlLWq4=; b=L
 fWeBEHZD7j3JMyov/9toXxlaCdgRypfd4aUbHtnpg29pnb1ScEprAtSIQ/2I8GXu
 DtUEQvAt1hC7GxBiA4qm3TWp009pu8+I873f0yTOaOS+3mmHwmVWMId5YkpSv3Sz
 x2d6VWLjn+fWr4zMzN0EP+PszoskrolK6PLeyY3TWzVHJ/MjkN8pCVNfdQOrEdwV
 EXxt+vK3nk3MpDV/rzyRTcwmLLrVTnJJwfBuiSN3y2wT5Njx5MwcFRCo/R+FKTLl
 yCtFyLxmia7SlIzRgwmLoU4TKDQi5gBCu2OPxRAAQswUqZSOdZD5E9axRKrfSp6v
 OSaSfh55AaHRVZIiOy0Gg==
X-ME-Sender: <xms:RjpdaJ5vlZR-ko96Bx_QHM5r3C4nOOSIKN8DTJW5fmZzeS_P8hiiXA>
 <xme:RjpdaG6Whrch0dKec8pc3evx6gLW0EvwHRoiA3WNMEgmHJfvraeJ2CUUdS0UQjEQ2
 84HFUWjQELOm6wvFg>
X-ME-Received: <xmr:RjpdaAc5PRgoNPBUxhpDasBO4vypV2YmgiEd7fmHXLt8rjVjAAlNzHFCJczIl5A2KJ5pQ7hdr8ZHuKOEm8AemuJNBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehmkhgrshhhrghnihesnhhvihguihgrrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoheprhgrshhlrghn
 ugesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrgh
 dprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphhtthhopegushho
 shhnohifshhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrg
 hvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepohhrihhkrgesnhhvihguihgrrdgt
 ohhmpdhrtghpthhtohepshhurghnmhhinhhgmhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:RjpdaCL-pDy68ha3qu5Q0Sbvfd4k4dsU7vCp2XLPUcAfeG66V-RfYQ>
 <xmx:RjpdaNKELg4_jkLVRbT6lGCXw1R8GOCC997AnSYUu3vs2ZGA8pwkTA>
 <xmx:RjpdaLzVoePe1Q_AYIV4aqClT79SVCo-hKKkS4eVnBWyTroJ47LYxg>
 <xmx:RjpdaJJ63NWHWt6Rm0BqOHj6rC1t14F3_jexAKQZmeI_Bl208_-yjQ>
 <xmx:RjpdaIKQDWM5xaYN7O0AeC8-FOk7KqrNrmEqHl7cgNW990CkGmSSbNxk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 08:17:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org,
 Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix segfault in counter pool destroy
Date: Thu, 26 Jun 2025 14:17:08 +0200
Message-ID: <3811155.4herOUoSWf@thomas>
In-Reply-To: <20250625093248.167642-1-mkashani@nvidia.com>
References: <20250625093248.167642-1-mkashani@nvidia.com>
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

25/06/2025 11:32, Maayan Kashani:
> When there is not enough memory, counter pool creation fails.
> As a result, the pool is being destroyed.
> Since not all pointers were initialized during creation,
> Need to check for null pointer in destruction.
> 
> Fixes: 13ea6bdcc7ee ("net/mlx5: support counters in cross port shared mode")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> ---
> --- a/drivers/net/mlx5/mlx5_hws_cnt.c
> +++ b/drivers/net/mlx5/mlx5_hws_cnt.c
> @@ -810,7 +810,7 @@ mlx5_hws_cnt_pool_destroy(struct mlx5_dev_ctx_shared *sh,
>  		LIST_REMOVE(cpool, next);
>  	rte_spinlock_unlock(&sh->cpool_lock);
>  	if (cpool->cfg.host_cpool == NULL) {
> -		if (--sh->cnt_svc->refcnt == 0)
> +		if (sh->cnt_svc && --sh->cnt_svc->refcnt == 0)
>  			mlx5_hws_cnt_svc_deinit(sh);

Applied, thanks.


