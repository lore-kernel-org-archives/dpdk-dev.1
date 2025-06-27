Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E595FC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:16:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B5CA402AE;
	Fri, 27 Jun 2025 17:16:43 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 00965400D5;
 Fri, 27 Jun 2025 17:16:41 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9E99C140014F;
 Fri, 27 Jun 2025 11:16:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 27 Jun 2025 11:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751037401;
 x=1751123801; bh=DTSsBJETpfL9JX/t/yVmyba5A3jKRKCTLA+erOdy8oY=; b=
 PhwkUYkWRuH+yUArA6XvHL9LiKq93TUxxNWyjVAYDVV/lIjNmtcmlpAWKmQSel6X
 Ns3UAlL4sesQ1bEDtZ2ydNl3NzT9o0nkqPKGJYAYybDHgQJgrClRlHRLf88HG1zX
 K9SdzFZ2owVnVZQoC68tFsSvSooR6qxYi2u6aeMlbsdtsLmIeB4VgjsXfAEowQWz
 Sc6GbCJCdaQQqGmo5NncvDTpGlR65+Ya10AapmQc32d+CyWq61iO30Bu8mG1nPI+
 pEpsIl7tTRlTRXR90Doev9/E760sJi3ljD0Gjg9YzlufXtpaLL1VB7JDES8X1IfY
 tbLEZrc/eBIXAUn8PbCDsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751037401; x=
 1751123801; bh=DTSsBJETpfL9JX/t/yVmyba5A3jKRKCTLA+erOdy8oY=; b=Y
 uFNib7XztHFqF5x1NeVe8vBlPaeVpdJKInadjkLkc+HMbB3ZUoJ+8Y41pVYrcfWs
 OhLxFPJSdjCWKDsFsln+n3OHCgF+Z16n1v+IaDWLnbadEVgmDDe7FVV9rlaFuHby
 V3Id9afcvfJ73sUJfxppeoqKgYQ7Q6WDb/eT/9UIHaIFIVMPB+Y0jBDlvcebdmKe
 796ov3hGmEiv5itGJIWvo1BiX+Etf+oqzAlgNZF1R2cGMeeZMQmoQ+Zy5jouZQg2
 N76TdiSK6ZOJvnwyPT3XS7aqL1ND5ha68niVwr1SEGqLTTpaJVQKHn/KzrXK0Q+t
 tpdf7iDXr0aH1RgGWsPKA==
X-ME-Sender: <xms:2bVeaAQKIJQ18qYHC8MCXGPyfsokAh-LSSLZTILhexvZkApf_BsnWw>
 <xme:2bVeaNz3SdY-IX4kB760ME7DCzv8OfZkHovmug28u_SrPKemYwbQsPlamRWDzmdaB
 vy_-WxJT3S_Z_fX_Q>
X-ME-Received: <xmr:2bVeaN2IXvB87gGHmLaL9Pr5s0OhUpX8lkNgX7hApPNk9Oeh8ddtuZP2QaWGvFNe_Il05wfMk_3bQtzH7tdVkISwbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegvughvrghrugdrfhgrghgvrhhhohhlmhesgh
 hmrghilhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhope
 hkohhnshhtrghnthhinhdrvhdrrghnrghnhigvvheshigrnhguvgigrdhruhdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:2bVeaEBA1l0AvHtRZ2n0apToP13uYNpZmpUw_NSxo3N8_Nh3VL321g>
 <xmx:2bVeaJifNmmqevrfi9wmuSi3k2j6yhnka_FW2BZk4RkJJJIiXnC8jQ>
 <xmx:2bVeaAogq1D_N2NantBVfr8oyt2RWzFpRpXnUZhNHP52RUhVsWNOOw>
 <xmx:2bVeaMgxe7_Vd0W_urzy99ahEp6HISXI2xo7tNpHtVBHEXqjKXYA_Q>
 <xmx:2bVeaAh953nI7uOxoKHnpzB8HT1ZFGUj6ZvjFoTbH0z4RN31r564tFbI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 11:16:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Edvard Fagerholm <edvard.fagerholm@gmail.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, stable@dpdk.org
Subject: Re: [PATCH v2] cpp: Fix missing extern "C" closing bracket
Date: Fri, 27 Jun 2025 17:16:38 +0200
Message-ID: <5036333.A7TYtsqqnE@thomas>
In-Reply-To: <20250624195810.2350988-1-edvard.fagerholm@gmail.com>
References: <20250624111253.2074168-1-edvard.fagerholm@gmail.com>
 <20250624195810.2350988-1-edvard.fagerholm@gmail.com>
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

24/06/2025 21:58, Edvard Fagerholm:
> RTE_FORCE_INTRINSICS with a C++ compiler causes rte_atomic.h and
> rte_byteorder.h to emit on x86 an extern "C" without a closing
> brace.
> 
> Signed-off-by: Edvard Fagerholm <edvard.fagerholm@gmail.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Added root cause tracking:
Fixes: 719834a6849e ("use C linkage where appropriate in headers")
Cc: stable@dpdk.org

And changed the #endif comments to show the #ifndef condition is negative
with an exclamation mark:
#endif /* !RTE_FORCE_INTRINSICS */

Applied, thanks and welcome!

PS: I see you used AI to code your DPDK app, that's interesting
and we will probably look to improve such tools in a near future.

PS2: Thanks for the mobile games ;)


