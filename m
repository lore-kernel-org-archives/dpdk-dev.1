Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E499D216AE
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 16:31:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B7A24021F;
	Thu,  4 Dec 2025 17:31:53 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 3E45540144;
 Thu,  4 Dec 2025 17:31:52 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id C3155EC0178;
 Thu,  4 Dec 2025 11:31:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 04 Dec 2025 11:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764865911;
 x=1764952311; bh=g6zypYZ3sL2JNnZOliLcgle/iLOXWueexcUlWAmskf0=; b=
 U4AKUQ58IuK4F2PG0aTNilFIKHuS9allouPF8v8fw+LyncrIk591nUFLz64Nyt//
 y4v1wzxVwX/dCIHMGfpBYv+6ALP5yI07uGF9+1WrfWygb7UWeFeS4Z6pXm5oNcC+
 GcwcwPTX7UyayHim8r8O7TBZMxAtfcqEQlN0E2dM9sXiIjuUYPaEWzERPSIIBL9X
 QkW2SaGp/NgcsYMKBB8WJEIIdWLWW/XlYC8JTz3evYbffVH7DBbsjPTEyBetJQFx
 Zp0T6m0y9XQJBrGgumGBcM0938bPbOg7KzNvL0ipNlFYeXcD4531mnY7gOUGvA+8
 yEd1EYuHnlwIeU/tEnwD4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764865911; x=
 1764952311; bh=g6zypYZ3sL2JNnZOliLcgle/iLOXWueexcUlWAmskf0=; b=L
 uyuU4OW70okEWJK4QJDoWJMxhbIROvMI/UeUo7qr1EdsjmPDuv7Z9+Ijmk5aTwP+
 2Uogk/21wxaMRoBdRMPeR9l2W+OcfbR+jHXHu4HMDQNOWDGfdxxx3aCiWGYOfvB4
 nKGDUpWY+elmCm/OMb5rePygDwgA/Tn65e7pbTphyTUrschXIDCmDl/gqD6DU3kv
 umIfeQ8GsKfheqePQL1JcbTub0dxVxqcZtssAjcWSH9/Zlvz2Yr6BPrNaCAVSKtN
 fgbmM/1XVOv5/j2l+8Umy2H1Iss/UW5fhhZtCmdBwhI1hEZbIYi5zsz8bnO7teF+
 BRjwQ+hM8HsWeefJDvJnw==
X-ME-Sender: <xms:d7cxaQZCfTu7iUREO8tyYJy5RaLL2YK8RLBeM71U-Pv9NOzgxLJqnw>
 <xme:d7cxabgBwPn5DkAWd6_WBf9zoqfODa0nDPTFLH1hWEvKozrG-WAFbQ2wQTHSP7Ex8
 o1kGX4UQ6gd6RX6zMd0f7aEAihlBA_7kWUa3zDxO7YeZ7riYgQYcg>
X-ME-Received: <xmr:d7cxaS4Vv2sBnlhxwebhVnKgzAq7jLgipU7VaGMRf3XiGc99P-FL3gz5XLH7QZNMrzL-PlcNHEEkzk-HsTR6m9ORjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeitdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesih
 hnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthh
 grnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:d7cxaS4Z-loADLFZuvKnkwHxEwW3YfrbRZl07gCQqvM8L6k3QvUyRw>
 <xmx:d7cxaWcabveytGVF3pN6N0XdcfLWRUQgdKYwm5YuI4_TTEx3XmU0Tw>
 <xmx:d7cxaeDVrceQ2u3BEfytgUVisQoZQ8M_Y1n8r_Hg7im6CFQkn70y0Q>
 <xmx:d7cxaR-G7EpdQzDpGouzRorvlLl2NUG0fumu0pQKZ2g0upHbOuXfkQ>
 <xmx:d7cxacWhXOnfllyT23mrtvU_k3xpehYMcmKMdV_qqTkmEOSerBUfJKML>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 11:31:50 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, david.marchand@redhat.com
Subject: Re: [PATCH 0/2] Fix errors with updated MSVC in github actions
Date: Thu, 04 Dec 2025 17:31:49 +0100
Message-ID: <5061127.GXAFRqVoOG@thomas>
In-Reply-To: <20251204112904.2869502-1-bruce.richardson@intel.com>
References: <20251204112904.2869502-1-bruce.richardson@intel.com>
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

04/12/2025 12:29, Bruce Richardson:
> The version of MSVC in our github CI has been updated so new warnings
> are appearing about "zero extending 'unsigned long' to 'uint64_t' of
> greater size." These two patches ensure that the build in github is
> clean again.
> 
> Bruce Richardson (2):
>   rcu: fix warning on Windows builds
>   net/ice: disable warning in base code for Windows builds

Applied, thanks.

Note: MSVC is a more accurate cause than Windows.



