Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA32E95389
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 11:40:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBA51402EE;
	Wed,  4 Feb 2026 12:40:11 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 17AEF402DE
 for <dev@dpdk.org>; Wed,  4 Feb 2026 12:40:10 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 7538DEC0583;
 Wed,  4 Feb 2026 06:40:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 04 Feb 2026 06:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770205209;
 x=1770291609; bh=Yue2bo4AVO/hGjo+WAFuZZJoxBa5AP4u+7LqyUi3K4s=; b=
 W5EYY74xlpXKlHKemHGaQK4K0JB6LxKMkgyna3f5XEBsnYeKxiwCa5KwKDANEZc4
 eK8dX7bWh6F3IVnxsqA2H6NPUtAmrxRWLLIqhsSwUKPAPJB/11S4YxPZUmQXULIU
 t2KlztKNafeBBFzaZg7qPOuT9xFhARkfryX6BnKxqEcw/xmkDqo2/hvOJZphwBeU
 ltI44ifSzSIn05ve8Q431xkCFbM5GxFuL6W+ycp3TpAfkYfQzHNSbENbGx3jV9Sm
 PunPT4e1f0eaIT/73BRS6+OQxNit/TiXEgIdCduHGe8IAzOyS+Lz1vRmB+KTlhoU
 T2nke2e+92lsMG+rStI6yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770205209; x=
 1770291609; bh=Yue2bo4AVO/hGjo+WAFuZZJoxBa5AP4u+7LqyUi3K4s=; b=G
 3EGZkyoFHgdRlOBWelak3KT31bzgVyldcvRGtWCt+yM3vpj5bAx1GUYp/TUNBerd
 eDSn1fodG3tJvqXMxC866K0QE8B4Mm/mhsCkCEgE1//7yCA2K2SWsPNzx2gWMNzL
 3t+4ok8aqM89zxtPP5j4gFA5KPleRM6kRmD+ol65U13c26fwRnjhbks0Su+FpFQF
 ONrJ+qUQ4sI0bqRFfqElc38IzGfsklpL+QJnhOhIpfDBuM+U5tlL06CTtWnusBdZ
 EHwnLGFIOlc58oJ9yUzJrA8ryTCdlsm9v5q25gim56zttQpKgvwYdzV4awT76x4O
 fWfaAyhHfm7oLGcWFBP8w==
X-ME-Sender: <xms:GDCDaS_SYE9Ua1LZgoB2tNvc2F5aKFvCBTUS1uAFlIs8j25gAgkDFA>
 <xme:GDCDafCkDhD-9_Rj81D5aXzgdFgbFZMD3silRGMcpI2NybqNGOm3cZ3vr7H7hLEJg
 tNVHlAJUaMRjYo6CAusdVhwE90p233519JjuebiXx5YyXuzrqcQ2w>
X-ME-Received: <xmr:GDCDaazjqjqy1oS9c5E77o1qFWkYJdv_vPncfq2xzJQnNhky-5AaEdfUG-BCJmUjohETFLH2M6sivPeDi9dKksi6Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvfeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrrghtrdhkhhgrlhhilhhisehhuh
 grfigvihdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:GDCDacQXc2Yswht3LXVJcd2TEpgXpE0uD3FuMgHmxk5MmZoxktK7gA>
 <xmx:GDCDaZ8sVBvYfiJvgKO10WLnpqRoZm5c7YBLcyPv4uaU7KkAhGuG2A>
 <xmx:GDCDaboiXG_XEIfkN_SpzPVli31LfMnhrXl4_6oLCsITh8Ph4sGmDQ>
 <xmx:GDCDaelirGqBwJ2etu_ZlNY1tbAZzFRYPxcOhuGKKJwtLOe891aWKg>
 <xmx:GTCDaRMRbtB0UE0DsiHvMzV101sNB2hxvfSP7aspEGfbPxJ63cJt8sSh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 06:40:08 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/2] bpf: add xchg and fix rte_bpf_dump
Date: Wed, 04 Feb 2026 12:40:06 +0100
Message-ID: <9574512.NyiUUSuA9g@thomas>
In-Reply-To: <20251218170914.7737-1-marat.khalili@huawei.com>
References: <20251217172037.59170-1-marat.khalili@huawei.com>
 <20251218170914.7737-1-marat.khalili@huawei.com>
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

18/12/2025 18:09, Marat Khalili:
> Two patches that are not exectly functionally related, but one depends
> on the other code-wise.
> 
> Atomic exchange is particularly useful since it can be used not just for
> exchange per se, but also as atomic store.
> 
> Incidentally it was discovered that rte_bpf_dump does not support not
> just atomics but also some other instructions.
> 
> v2: Fix CI failure: do not assume in tests that all platforms have JIT.
> 
> Marat Khalili (2):
>   bpf: add atomic xchg support
>   bpf: dump additional instructions

Applied with REGISTER_FAST_TEST updated to the new standard values.


