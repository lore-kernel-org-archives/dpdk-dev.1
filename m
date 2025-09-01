Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D0CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 08:51:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCBDB402A3;
	Mon,  1 Sep 2025 10:51:20 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 5B9D94028B
 for <dev@dpdk.org>; Mon,  1 Sep 2025 10:51:19 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 40DA61D001E3;
 Mon,  1 Sep 2025 04:51:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 01 Sep 2025 04:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1756716678;
 x=1756803078; bh=V52Z/l++k1uvJl9xquymtRNfuU7VBGHiA5/Zmz8YPp0=; b=
 SU88ck1QPLuzxq0RegbH9DWwU+rR5mSgrCryAMIBtnEDbxGP/UUFXEiM48T4j613
 aaHjbpHejU51zVWEPZmVxdmZajQFuDZky298WhCeTT6ihobbNZ/TWT1ZvwNyyA9p
 J4H6PSjzTmxwim2En6HZC3IJ00CPwL8FV52SeXgueAd4mCkBkZswRx7wOTPe7ZDV
 vYjT5QvKs73HJqkoWYHMxYP9Zyaq9kQJMaHlRCgaRLUK5ZRNw+aVCKsajD7Pwqd8
 iFWobpVFJKt55pYFAErzYu2ZK3m926qgoK3Stz4WyNUD/2YPxeHqbNhKfb3C0LpW
 IsWDwMfNt/DXL6mc+pPL4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756716678; x=
 1756803078; bh=V52Z/l++k1uvJl9xquymtRNfuU7VBGHiA5/Zmz8YPp0=; b=k
 uu0Uz9pMdrj2vBjdvw0WcSg1riIEcdJtkur3eJ33zjTX2QK19qYOBo6ILIYSbNeI
 INSVF3oBOpXunueAtnK2s5YDyDP0xr+dlbwxkcBjUgN+J+pKodaJCAehc+9GCmtP
 VaH5AsGOWYhcNn2TMM6Uhr+GD7qlC8X1PZr30XPc7DCdjQcZnA4AGI/+2qgoTwpf
 1S1McofYjpRFRg6BaDAikJnKi/LCr3k/wo54V41T8S+Vd8clQXVx/Vz1ko9oaJzo
 kdN5+VLogY5vAW0n6h/g0u24ld+4webxTxr+Vl8s0GH+VFGV+rxW8OpQc1NP1Cxn
 1n4hrudM1B2EP0yxovgyQ==
X-ME-Sender: <xms:hF61aPnABl9WU9Je1mH93GAxG-blm8NCWz0uQNfrhr5XNtdvFQYkTA>
 <xme:hF61aAwoBbENAFG1C1eZJt9WvsEOGrlS0DoavClOMP_JoP6NdQkbaIqROLdkXyu7g
 -of1o_RwuPEoHawEw>
X-ME-Received: <xmr:hF61aH8WrktSFa9duDQ8JAF-_zPciJ5mNc1P4pBLJ4ZDq5T4AzF8BUXodzQwVWJqC7yk5jrmCEEKTK5YxqUciMmilg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledujeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehvlhgrughimhhirhdrmhgvughvvggukh
 hinhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgt
 phhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtph
 htthhopegrnhgrthholhihrdgsuhhrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthht
 oheprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:hF61aMIILcmcPPQmc4XbKEOGvC6G_EsoIiQrkX9n4PpwQIUvqqh3_A>
 <xmx:hF61aFd20FDoHea5e4uHUBaN5CUJP4MzBIQGfv8aumvWaoys_8YH4A>
 <xmx:hF61aD9cvqOjqramiQ8-iILfsAk4d9L2vI2847OgsU0O_y1o5cxXkg>
 <xmx:hF61aKr_MfoBEURcj0Qgmg3HTjcXvpf5OhHOpDE0F33yB3xqtIQW2A>
 <xmx:hl61aAe3xbbmR1hgQfy9fUQdpocoYD0Xdi1ZxhK6_-_LwHQASlX1H76S>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Sep 2025 04:51:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org
Subject: Re: [RFC PATCH 0/6] ethdev: refactor and extend DCB configuration API
Date: Mon, 01 Sep 2025 10:51:13 +0200
Message-ID: <3386423.G96rZvMJ2N@thomas>
In-Reply-To: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
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

30/08/2025 19:17, Vladimir Medvedkin:
> Vladimir Medvedkin (6):
>   ethdev: extend and refactor DCB configuration
>   ethdev: remove nb_tcs from rte_eth_dcb_conf structure
>   ethdev: decouple VMDq and DCB cofiguration
>   ethdev: extend VMDq/DCB configuration with queue mapping
>   ethdev: remove dcb_capability_en from rte_eth_conf
>   ethdev: move mq_mode to [r,t]x_adv_conf

These API changes have not been announce in a previous release?

I like cleanups, but I am skepical about the timing and impact on users.


