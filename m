Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A050CE73176
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 13:51:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B03D5409FA;
	Mon,  2 Feb 2026 14:51:20 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 4A2DD402D8
 for <dev@dpdk.org>; Mon,  2 Feb 2026 14:51:19 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AB42E1400066;
 Mon,  2 Feb 2026 08:51:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Mon, 02 Feb 2026 08:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770040278;
 x=1770126678; bh=lTXZ1JyeEXUeCrd4eQgeoYZAtNYZBCgFxFJyLuAhvDU=; b=
 X59GIN16VT00kW3q8GmBYF84ipjMvF2KTAzzwQUtQ0sB36Syb6A4PHs5/k5dSdml
 6ZtKbHNxSsxuGlPORLauElzjvMzK71RZvjif7117LZ97f+iqtbHKqvWZBHpq6VJR
 sjZLXLOftpsrjsID1y+gRlvmfAwN2oXnnni2H/J3ZuzDSqx4Tgyt/uCiIhoekrhb
 ChtuDd37hmhScgeLmlBzgKBq9UDNp9v+k4ZfQa89rPpekxCltkKn37biBgUol/Y0
 +UnHdf/tANs6S9V0Rv0oP60QZynE7cUn7lvXI1j38VcoLnmyoZmCTRBp8jpgXEml
 STI4va52Mdep2/Sxud35/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770040278; x=
 1770126678; bh=lTXZ1JyeEXUeCrd4eQgeoYZAtNYZBCgFxFJyLuAhvDU=; b=m
 wbNwV+A+KFicia86M1LlL/PdhIFHMug4xEqublQxlai4+80o3TiK4VQolyzHu3s+
 p2LfHlBV2XIFW/BTyi6KTE27hlmxWrv9rsbqEu0JUZHAzeZc3fOvHdCI0vV9mXKH
 g9SlA1dGS6nYL0AU/xehiQliAipDKvOv6K3SANC5qa+iZi1RYW8umkqaGC3uYouX
 BBXVv+ZaaWr1LoP3PYMxG6BjG7pk1FFUiOib8YrEx+EaWYOMeJoZhGe0WEA1FN4z
 99RFUfg6I+9Vg4lAxK+8dcvsVhCAMD/OcWfBT8oL6SuS9wb8yNR33EoPweuwuM8g
 v9d6ky5YxWh8YRIdprtbA==
X-ME-Sender: <xms:1auAaaFbq43OAMDa5sZApo6EEN7vA-8dypSRhvCIEnWZ0L9qZf1Ruw>
 <xme:1auAaWTI5OujD4wQbKbJAFgXwYn4MgdDs02DHf8mSU6AtIoR8n9ir10DZe206Yjvu
 lp8h2igSvhvbMNA-yS0h3FIKwhCTVS2kze2NaTYn9B0I2p1Jnzr3w>
X-ME-Received: <xmr:1auAaTKhq36gqTadXIGzsxBJxVBTkotioASocyQSbjBGVsypyDE8_R6KEz3XaObsS0qlzFAjscIq8SwQMFzKAPNa9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejkedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehivhgrnhdrmhgrlhhovhesrghrkhhnvg
 htfihorhhkshdrrghmpdhrtghpthhtoheprghnughrvgifrdhrhigstghhvghnkhhoseho
 khhtvghtlhgrsghsrdhruhdprhgtphhtthhopegrnhguhidrmhhorhgvthhonhesrghmug
 drtghomhdprhgtphhtthhopehpihgvthgvrhdrjhgrnhhsvghnqdhvrghnqdhvuhhurhgv
 nhesrghmugdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhdrghgrlhgrkhhtih
 honhhovhesrghrkhhnvghtfihorhhkshdrrghmpdhrtghpthhtohepuggvvhesughpughk
 rdhorhhgpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrd
 horhhg
X-ME-Proxy: <xmx:1auAaZaSzBZTK2S2581YE8sIIUNZBu6Bcvb2ofshpGTML6MMu0M8zg>
 <xmx:1auAad8JWaIP5Fo9wSi8oxu0gTWXPrkxxeY8tsxmutkdwpzqXg5ELg>
 <xmx:1auAaSb8Cil1rBc_Zo3dAKC-VlLJRj-BgAH08f9FmlnQMjzeA2dt7g>
 <xmx:1auAaZNU9AbNJQwEAr_vxp2cyI6feIj6RCPkQ2vf89jfkW5O0E5Q9w>
 <xmx:1quAacG6asyigPE9juwZ7C6ZqC_7VJSu0_mRaMeV2_MyAD6Lo1mYk_CB>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 08:51:16 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ivan Malov <ivan.malov@arknetworks.am>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 1/9] doc: remove support for AMD Solarflare SFN7xxx family
 boards
Date: Mon, 02 Feb 2026 14:51:14 +0100
Message-ID: <5939885.GXAFRqVoOG@thomas>
In-Reply-To: <5166877.LvFx2qVVIh@thomas>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
 <20251229213527.37907-2-ivan.malov@arknetworks.am>
 <5166877.LvFx2qVVIh@thomas>
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

01/02/2026 21:17, Thomas Monjalon:
> 29/12/2025 22:35, Ivan Malov:
> > +* **Removed support for AMD Solarflare SFN7xxx family boards.**
> > +
> > +  7000 series adaptors are out of support in terms of hardware.
> 
> Just to be clear, it is only a doc change?
> The code still works for this hardware?

Please, may I have an answer?
I cannot merge into main that you remove something if it's only in doc.
It is blocking, I want a clearer message to merge please.


