Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB8DE94615
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 21:46:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D8DF402C4;
	Mon,  9 Feb 2026 22:46:08 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id EB32E402C3
 for <dev@dpdk.org>; Mon,  9 Feb 2026 22:46:06 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5ED307A0125;
 Mon,  9 Feb 2026 16:46:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 09 Feb 2026 16:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770673565;
 x=1770759965; bh=SKXdCgy0AudEOWkQkMuYHns1Mm0OcUDC/FHaKvd98yM=; b=
 ZrQKNMdZ0bQwjOgzaA1KFKMjPdX/U/BJfpcZnFTVU12imRypyMydvTFOB+71YArE
 j02Qn64JWd4nHNPFqv8VP+W1rcrMRm2cX0aLG0szd+UQfna0QRST5EsXMKOerwwI
 jUEQYtm5LLiyup4MSucGhoxR0sJj3cH5hVcqd+1pjdiQIjpVPkY6192Ty6ybN5Nr
 DgTQJyLZMOgSXuangLrhcVH6r4NKaqPUl85OWUzZbZWKuFxVU/BDamCvQl7CcSBR
 /05cfoTPMlvNyVkfNpgteMdm/FWFx70Pdv8fqWDXICZzOUuGi1fuznJzvEtV36nO
 sdHa7HexBn0/w4iAl/Menw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770673565; x=
 1770759965; bh=SKXdCgy0AudEOWkQkMuYHns1Mm0OcUDC/FHaKvd98yM=; b=N
 3SwM9yywt6XTuN1R+WPR6X829FOSAOT3EbvKo3gRA6JZGSVUqBLabRzb/Te4kw9O
 8TNLnY3Q2ifJ3qsEbI4nTkpZ5z6IfBiQiKQpDtzijs5ffaWe6BIgi7X+94OjW5zu
 uAYlkz0P+EIaefFHyQb0+o8yAYHahDHSCWizzHZ0ABQDihoJ/xupU/e/IYF1q5hC
 OSWBWKR2aGEAYBKwLoT773aYdqb5EE0GDR8CYF4PLqGSDQ0T9exDNf1zgo+mrCJ5
 LADAnoivCmeP+A2HSvxYgePGAQsH4Ef8StsU65Bj72pvhlasrwBygFzG35lOXXvw
 D8btrkZ3Dhoh0p9tW0HLQ==
X-ME-Sender: <xms:nFWKaXzbqy4Bej224cx7qE-Q6OnDK-VFeu7FBzx3gEI_eOdtNZDu5Q>
 <xme:nFWKabTZZQUoPHHBVvJXf_ny1y9wxKxHJx7pUy0MNzDzNKIGD604LJc_AvkVzBXUs
 SVdPWtyIkaquyXET49S4CvsfJD1qL07Yd-8cNCoWR3NjvWlIV1QsA>
X-ME-Received: <xmr:nFWKaTi6qBqRP2ldorvvx0vnA0jCyGVn902LI5SgqQX1TBPWlmYSWD4oFjfh1gGA0dFaIEjeAMfETKIADYW3OaNqTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejledvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdp
 rhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehvihgrtghhvghslh
 grvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughi
 rgdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtth
 hopegushhoshhnohifshhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhurghn
 mhhinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrthgrnhesnhhvihguih
 grrdgtohhm
X-ME-Proxy: <xmx:nFWKaSl6eV8gs_yrk9VQI6rVvcmj2SU1NnI-fzHNXGSukLTwSeR5gw>
 <xmx:nFWKaWuuY31puyD3HjOEgyTygppjXaeNF5eEhNUhQMwgn4c2CuKQ0g>
 <xmx:nFWKaQYbVpRBJxPo0ujXwEIx4Zjh3s4-F65M4nzrNvRlpNHwWE2tRg>
 <xmx:nFWKaWAV-SM-st5ryjf5K6U84cZnQRo19xcY4TW3C65pX2Jgs9oqpQ>
 <xmx:nVWKaTrE9MkX5_lJfLyQeVO3xoZ3k2gLyQZesvKmwVqSfw6s7-3pFtJe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 16:46:03 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Bing Zhao <bingz@nvidia.com>, dev@dpdk.org,
 Slava Ovsiienko <viacheslavo@nvidia.com>,
 Raslan Darawsheh <rasland@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH 1/2] lib/ethdev: support inline calculating masked item
 value
Date: Mon, 09 Feb 2026 22:46:01 +0100
Message-ID: <6463824.LvFx2qVVIh@thomas>
In-Reply-To: <20260209105802.13946890@phoenix.local>
References: <20251117075407.9632-1-bingz@nvidia.com>
 <IA4PR12MB9763E82954C5054B794769EDD065A@IA4PR12MB9763.namprd12.prod.outlook.com>
 <20260209105802.13946890@phoenix.local>
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

09/02/2026 19:58, Stephen Hemminger:
> On Mon, 9 Feb 2026 14:17:27 +0000
> Bing Zhao <bingz@nvidia.com> wrote:
> 
> > Hi Stephen,
> > 
> > Since there is no UT for the flow API.
> > Such application would require some design discussions,
> > and it is too short for -rc1.
> > Could we focus on the change itself and try to close it? Thanks a lot.
> 
> I have discovered that AI does pretty good job of generating basic tests.
> That is all we need to get some basic CI coverage.

As you know, we don't have a stub implementation working without specific HW.
So far, the decision discussed in the techboard was to implement flow API tests
in DTS and run it in UNH. This work is in progress in the DTS team.

I don't think we should require something else at this point.


