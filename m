Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE72E6526B
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 20:18:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A32BD402B2;
	Sun,  1 Feb 2026 21:18:05 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id A0F7640150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 21:18:04 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 765C41D00054;
 Sun,  1 Feb 2026 15:18:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sun, 01 Feb 2026 15:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1769977083;
 x=1770063483; bh=ZzaTnKos5KkslsrYN/avOgUPntjBcaZIQ3dARUhAkG8=; b=
 OhAir8uylhxEhrqrZbIvf1TaTd5D9U7MeHxyz3aOYYT9eVWru9b+xSSqhLALe2Ut
 GxF8YnNlgrgwnJBOfV4ZIad3Wrn9gCEYYZ+eVDveuPu2NcAx0XzwFXeq9Br7BKpF
 R4HfGFzvLp4g5TAiKJNK311nN0Kboscmg7uhn09H1Dagh0R4/hQPKYN3eRnVeKOc
 X+AJgZSzyPxZtn1Ge7M96XvMZXel01v812bXmQLBd5ISbMC5TMlTj5eF2zE33MmE
 1kBiU8ZCVXkn694nJQrdI2jVczHA27+qzxWifUD42E6yu0Qswltr98a9Rb2aKKqD
 2m02rn2GBF4CZ5A0hJH4IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769977083; x=
 1770063483; bh=ZzaTnKos5KkslsrYN/avOgUPntjBcaZIQ3dARUhAkG8=; b=O
 qPYM1M3OzzBIMafUeaL8/K22JP47Ye5ht8ncRWcwaRBU2YoWYIsz6ajBbjCd5XjX
 fRw3yENIyj4XB7CYHV6xDO1ECrfJIl1XNgemTLffmiNKu7g3Sdl1dcopfeELC6hP
 UWQpp1iR2FB67uGMGvNShQ8N0q4V9AzoeyzhMZ2/FbphVGQeW67qjPFW+VOH8BJW
 BGi7viHpsc6KxuM6O7f+OvORCv7370QAUasui8Q1klpMcTcApvzbsB24mdsYxkmO
 O6cwcNaZcvaajB3PkDwBHkhlzB9J+mm6Wy/yOq3/E8loEzBrnGiXD8CL52ks+soa
 KztBK8zADwKSkD7ODsn8w==
X-ME-Sender: <xms:-rR_aWGQaLi3W2yT1ljoMIkAL-kTp_aTFVLviFkf1P-GZjJTadnuPg>
 <xme:-rR_aSS-2DzwZXk5kpglf4jv1QbHTEHRbWrzxLuGO3O_hgklat9iML59D2FscawZd
 VFKuhLEbXlX6JcRqgN_PVroCLBOH6JEiYaBWQBV6X5_tEFgvhGIDg>
X-ME-Received: <xmr:-rR_afLDVTIwBm9UlAO0FOUtlO8FAZEk6KJLAWQ0UyaxQbXjF9QGSkWwoVDO4DbUGQG45PIDt98444pOTlQhzEBrhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeehjeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehivhgrnhdrmhgrlhhovhesrghrkhhnvg
 htfihorhhkshdrrghmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 oheprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtph
 htthhopegrnhguhidrmhhorhgvthhonhesrghmugdrtghomhdprhgtphhtthhopehpihgv
 thgvrhdrjhgrnhhsvghnqdhvrghnqdhvuhhurhgvnhesrghmugdrtghomhdprhgtphhtth
 hopehvihgrtghhvghslhgrvhdrghgrlhgrkhhtihhonhhovhesrghrkhhnvghtfihorhhk
 shdrrghmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrd
 horhhg
X-ME-Proxy: <xmx:-rR_aVbedfqjjqqWPPhjjnoOGOzYM-M5Tg_qVfLcpQuQ3uF20dpB7g>
 <xmx:-rR_aZ_KfAAjUErWHtvhVMz96eDNqFa7dPSuwDgEs3-B89uX_0sYhg>
 <xmx:-rR_aeaNcI6fkPJSBoCPg67qqZqToTwba48vTD6JLhZykttuQ-FP1A>
 <xmx:-rR_aVPjJVE6hMArkAFfiZE4ExDb3Qmlvs718ehUyjoEXihLOwBZfg>
 <xmx:-7R_aYFQeH7F19jjdtc48nUBqCmb8VxY6KtMaHaGdH7kIARbm650dh5x>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Feb 2026 15:18:01 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 1/9] doc: remove support for AMD Solarflare SFN7xxx family
 boards
Date: Sun, 01 Feb 2026 21:17:59 +0100
Message-ID: <5166877.LvFx2qVVIh@thomas>
In-Reply-To: <20251229213527.37907-2-ivan.malov@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
 <20251229213527.37907-2-ivan.malov@arknetworks.am>
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

29/12/2025 22:35, Ivan Malov:
> +* **Removed support for AMD Solarflare SFN7xxx family boards.**
> +
> +  7000 series adaptors are out of support in terms of hardware.

Just to be clear, it is only a doc change?
The code still works for this hardware?


