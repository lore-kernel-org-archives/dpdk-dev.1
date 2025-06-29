Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0642C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 20:13:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECB974025D;
	Sun, 29 Jun 2025 22:13:12 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 2780B40151
 for <dev@dpdk.org>; Sun, 29 Jun 2025 22:13:12 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 5EFBD1D000BF;
 Sun, 29 Jun 2025 16:13:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sun, 29 Jun 2025 16:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751227991;
 x=1751314391; bh=TjqhCwMON/brgvP5Yh5eflMEdX4KnX3MAOE8gHAgz5k=; b=
 WsdQ58YGU1Zc8NGucpTLxjyKxQrzFoX++JE7/BbWTB27Uq4FUeH4XUwMDckpzOe6
 qF59M4FjhhB++EsmrdeE7erddKOutofTMYOgAZMgOGWi4++txkVyXhYHfK65FYDg
 M4A7kEvbuHseYD+v6eKeiq9bUw7U1hfFc9UMIXXchKaMVXMXG+cdV7Dbq2nUTgTe
 S/6hV1LzCjUcUokr/mnNQ/FmzD4FHZBiOOyAMFMH1sETd0vEtMPYQp7ElaKhp7/0
 1EHtCrfdhjUJiuKg0qih0UBk+hxk/3FuNRYMC3Ic2679N5WalClCPl66a6Snd2op
 g5ELHSiDC5fmG20apl/VYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751227991; x=
 1751314391; bh=TjqhCwMON/brgvP5Yh5eflMEdX4KnX3MAOE8gHAgz5k=; b=e
 wFOI4nLggOXkbtKIujmvHxYuvW88CT+l+4KbC9Yqp8WkGS2gNqredzGp0LY5Jt0o
 ZwyawjtOAtVU+iOL03pzfZxVPdpa1JxUuUazBPnmtokYHm8+NM3E+hJtNtHKXoSB
 thhnPDmkslvZkwbUXf5AwtlWXUBKHqvDmwOrkBjuN4LQFRPLsg1xbtSNSN7GpHLo
 WE3vBLPd0wNYjHJ7FXXIV9Z0KsLIXcKq3cvGuZi0Hy14xmCUn2lOW0I08+cGLZsB
 GwrCi6eT+kfCIUzf3DTksu85LlKjzJq1RbRb7cfsszoPDzCghpk5vGhesIifc8J4
 Pc3iZ0ys+K1Qut2fW5wOw==
X-ME-Sender: <xms:Vp5haES2aKZwLM8URRUiEz534QpCjEVDDKO32snNzZT_V4t1-gfmHA>
 <xme:Vp5haBzP_DQbxTuh1KMHl-w5G4oe1pHv4RmOW1a386SlRpWEbZsyQZDAxEgqSFDmV
 _rZeTyzqp636KXIQQ>
X-ME-Received: <xmr:Vp5haB2v5952I99Y735nHRApZReKb56ehlxV-CYVSy7a9Q0Q09bvny2gePwnkv5R4NCeY5ZTGQrOBRew7TrCf8Ot2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluh
 hmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvthhlrggsshdrrhhupdhrtghpth
 htohepfigrnhhgrdhjuhhnlhhonhhgudesiihtvgdrtghomhdrtghnpdhrtghpthhtohep
 shhhrghnrdhlihhjihgvseiithgvrdgtohhmrdgtnh
X-ME-Proxy: <xmx:Vp5haIAJmenpgyd0QkPqUnWTY2JASd59D_ra1ahXArwRb9xL8CaFNw>
 <xmx:Vp5haNjP9fKYUukynQYLWdFSUrC_7F3Y924G-AhC3npleEesVIh0AA>
 <xmx:Vp5haEorbLfhB5gDmrqiKPkbtta9EDZAdgKKtOlxThVcR1oRgDmJzQ>
 <xmx:Vp5haAh8yM7rj4EDpZEtMKd9quVrhTy6-YJiR2VGqn5fBuOMI0_cSQ>
 <xmx:V55haAoyrn00SHH6zDOVp3UJHfOVENfnQu_IktwzS492c4eSI-kl6DbP>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jun 2025 16:13:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: Re: [PATCH] more replace memcpy with structure assignment
Date: Sun, 29 Jun 2025 22:13:07 +0200
Message-ID: <4478590.aKNjEaI27c@thomas>
In-Reply-To: <20250612030952.611893-1-stephen@networkplumber.org>
References: <5311136.0WQXIW03uk@thomas>
 <20250612030952.611893-1-stephen@networkplumber.org>
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

12/06/2025 05:08, Stephen Hemminger:
> Prefer using simple structure assignment instead of memcpy.
> Using a structure assignment preserves type information and
> compiler checks types already.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



