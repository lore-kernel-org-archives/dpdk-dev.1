Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FDB109C022
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 14:28:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8982240E6E;
	Wed, 25 Mar 2026 15:28:49 +0100 (CET)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 3095B4028E;
 Wed, 25 Mar 2026 15:28:48 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 336D17A01F3;
 Wed, 25 Mar 2026 10:28:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 25 Mar 2026 10:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774448926;
 x=1774535326; bh=Shr+hWZlwQ3SfSUUYE2cRhfaKvy8ismBMHv6cmu1vi8=; b=
 bvRTx5UWa3owWUn6/zbw3K6+0jYXz7TT2kvb6lsbir2L/xOJMNK5zS/v0fBi2nE1
 gIfUH5tFwFXwZ8MpxPceTnCrFN4s7zdTjYbFm2u7c/DKWPMIZQ2ZADsZ6ImKvs/0
 NW2tH4W5aiFIDC/CngxuE+FmDpm2qM5VEC2e/3HzA1rXIEKIgBuXlx0xrpWJLmXp
 l4kHQkhbmsRFrkpz0snx9nsjPEv/7p9GnfShW99EGDso9BQfk3fwO6H5K0yhH9dj
 TErnPmh+VGLao4PEqODRcfp4JRmaIzdRXywbDhGk6ecWxwby32HPG3iiGgMihWrQ
 +Hbw4y+KbfMAltotydanEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774448926; x=
 1774535326; bh=Shr+hWZlwQ3SfSUUYE2cRhfaKvy8ismBMHv6cmu1vi8=; b=N
 s5ZcGu+tw9lYPDyPcHoFu5FR6oY6UdGFE1jsD0iJp/Pp/Dy6kuwDxKnNws8AoFGf
 QIE2Wb8LyK+x0c1QVfsfR/bUTqhaJauj4TshY6+pg3hVXiyui8XcQOmaTA7UsMOu
 4JQcQ+op7nPkj5jcuo5csY2JVJp7nZfGud1yBa1v3BHNTWO5j/P0l5tJuLKc+fCC
 Tu8Rx8zQ5BU/ldPDmA7olV1pjLUGNe8u4HA6ZzGsITTCESbCLW59jFLgqRdRDOJK
 ARTopse3dwV8suSGfRtLbQav3EMeLjmX8Ij3tibjue8WEfL9GoYhz789eVLK0c0Y
 6QkftAlodBVI+B/RyYwAg==
X-ME-Sender: <xms:HvHDaf0PovxvBIudXUB5SvYt6QHp2kSkJaVsAl6kE0CVD8dn8_LgJw>
 <xme:HvHDaZhqMJ2iPghJRLY8_S_unTxgKxWYLnnc_Xle_7DBPWMec6iRym9H-C87WkZEr
 1v8aO2z0D5qZU2ydlSc53XmkaCsJgQb6XXpdliOFpmEUNV0Qjso>
X-ME-Received: <xmr:HvHDaTYGbQkpt6v0yO-hx_o_Jj6HJ-t5SgFMoFfYTF1qYLaQqeSOQ5GRFsl6F0I_Dcbv1McaoVDE3nN1H-dsUs32QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegjedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtrggs
 lhgvseguphgukhdrohhrghdprhgtphhtthhopeifrghthhhsrghlrgdrvhhithhhrghnrg
 hgvgesrghrmhdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhes
 ihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:HvHDaZQP9Z8GArIKBSwvu7n9_VXCTzqtx5vHTMU4pPSak9snrzSUUQ>
 <xmx:HvHDaeQs2Z4j4blREs2eQPI6rTU5SEuT_yP-yditaAuNuQdUSuubQg>
 <xmx:HvHDaVQfnmDLgcLM3CtiiXyrxIV56STfezoUkDcwLjf7yXFLWRM9_A>
 <xmx:HvHDab6L_iHUlWfSW6bXY46fKwmk7DKkAcBCmP9C7EoL1k3tlnHZFA>
 <xmx:HvHDaZeXLoYfkCoykMhcCms0or3gCHT6Zbur5jz1YtOmcX0YumNU1THe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 10:28:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] config/arm: drop crypto extension from armv8.4-a build
Date: Wed, 25 Mar 2026 15:28:44 +0100
Message-ID: <50118217.fMDQidcC6G@thomas>
In-Reply-To: <20260324142546.321236-1-shperetz@nvidia.com>
References: <20260324142546.321236-1-shperetz@nvidia.com>
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

24/03/2026 15:25, Shani Peretz:
> Remove the crypto march extension added by commit 6e6cc1dc3548
> ("config/arm: support crypto with Cortex-A78AE"). The extension
> was added under the incorrect assumption that missing crypto ISA
> caused an infinite loop, the actual cause was a GCC scheduling
> issue with -mcpu=cortex-a78ae. This was avoided by switching to
> -march=armv8.4-a in the same commit.
> 
> The extension is unnecessary and causes build failures on
> toolchains without AES support. The -march=armv8.4-a build
> without -mcpu is intentionally kept to avoid the scheduling issue.
> 
> Fixes: 6e6cc1dc3548 ("config/arm: support crypto with Cortex-A78AE")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Applied, thanks.



