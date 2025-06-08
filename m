Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE08EC5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 19:36:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 891DC4026B;
	Sun,  8 Jun 2025 21:36:07 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 9E12F40269
 for <dev@dpdk.org>; Sun,  8 Jun 2025 21:36:06 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id ABFD51140148;
 Sun,  8 Jun 2025 15:36:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 08 Jun 2025 15:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749411365;
 x=1749497765; bh=/zumrYemVmcgN5S+AbCyaZhM31BBbwthIAX3Pojy7R0=; b=
 bl3R1N8AY56mHYHpu2DkP0vSOOuh1hXjRnoRG6/czxrQpvDfHZy59/MSvgzwuCAz
 eYXDjZeDPa/yfS2OpU6DCWLnEOpK6b221KAC5bYisYuxA4P96a5kI/3YBG5opxc0
 xhFqfdESx1FLLwtLhLsMj/nArTEFVevp+3e4NJ+i2ZOKKLjwwl9X6C/mgKPiZNxt
 F+KRMHvS47ILiv1kxz/UBmQ2QaZnqfpvlWAQ5Gt7WnD84jKOv4jcIiMZYXDt4wPG
 jjBcFBOcqvYHFY4Z+a02FBCMFbu/Uw7CU4ym/jiAGKpK8iHaVKFZAq12NEMfB15k
 Ve9RgA6YwyIwt0F7nUdVVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749411365; x=
 1749497765; bh=/zumrYemVmcgN5S+AbCyaZhM31BBbwthIAX3Pojy7R0=; b=E
 vspwlf7ebQ/6RnVt7LBDgwE9s9CEreTTrUMTWTq4SwvmdrrRb8dTiiTUzbzu/W8S
 tay+hgvBcIXwspE/5PWMRXDGCbGmwh3kSSVvw+OUE7Enx4MPMGi2ezLM+Xpa+Kak
 wNYNZ0Cr5PkYfgWgZCmf1ofk2KG3+uPUQmLWTFdJCRDVhgSF88hhjrWVJfJVy2cv
 Fo67BlAN9FXp6Bi29JpRq+Dx2lWNZr8BopmYl+AOWaR6ZEtq7Bpc30wvT+rELkI/
 bmBKtL2lOAWmFw3Olom4fk2zbMp8OstlTSjYqbHNRMtMNU0YTcR3srfHFEyya1Wl
 dsm7KXSHR1YdPxCyP4dhw==
X-ME-Sender: <xms:JOZFaF-OA2nG24qzWDkBWpeXfPBx02sGb7XfQKTQ62rsWPb9aVgoAA>
 <xme:JOZFaJsU99E8WtDPsn9xXesTyVATnHRhQelz7Ekfb5c4_ZzaCrzOrDQvJvmnUTIw3
 6a9lM_O7SjyjCc7Nw>
X-ME-Received: <xmr:JOZFaDBg-8K6S0kADwlAXW_hkySi4U-JeitU8oXFJXZGQaPD8ARM53HET6MWtcStaYvNQOI-jehQcxg4CNQWEUwFew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekvdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedt
 heevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgessh
 hmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopegrnhgurhgvfidr
 rhihsggthhgvnhhkohesohhkthgvthhlrggsshdrrhhupdhrtghpthhtohepsghruhgtvg
 drrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhg
X-ME-Proxy: <xmx:JOZFaJeAlm4kc9OPgXNAd6-M-6MQfQuM5FxYvOqE-L1Iovz_56vTTg>
 <xmx:JOZFaKMuFAcI69Gcydavfz36WmARpQIcqVRdbc3tdzPWS5rkE6Igbw>
 <xmx:JOZFaLnpqP6_UO5S2BqkcrByAUn2Yt5o3t1S05o2zynpjsrkWefr5Q>
 <xmx:JOZFaEtLEYdjHC1WFlfkAI9VOyeX2RL7apV8vbipJ-nBo9iTjRERCw>
 <xmx:JeZFaDPKaRX01Sn51PBkR9hqMbDsuNmclk0l0clhgkYp4VsRiUt3Y-sA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 15:36:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v3 0/4] mempool perf test: test random bulk sizes
Date: Sun, 08 Jun 2025 21:36:02 +0200
Message-ID: <4265968.72vocr9iq0@thomas>
In-Reply-To: <20250401150214.4989-1-mb@smartsharesystems.com>
References: <20250228164858.274204-1-mb@smartsharesystems.com>
 <20250401150214.4989-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

> Morten Br=C3=B8rup (4):
>   mempool perf test: replace bare unsigned with unsigned int
>   mempool perf test: test default mempool with cache
>   mempool perf test: improve output readability
>   mempool perf test: test random bulk sizes

Applied, thanks.



