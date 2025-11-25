Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB30CFD36C
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 00:34:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ACEE40698;
	Tue, 25 Nov 2025 01:34:31 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 90E21402A1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 01:34:29 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 1E4E7EC0807;
 Mon, 24 Nov 2025 19:34:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 24 Nov 2025 19:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764030869;
 x=1764117269; bh=Sy6KrNqAIPtll0wZr8cAg9OYlLxam86cNQLXtJQGESg=; b=
 yacXXC4RczQvVRD3GIrylE8+wnSWmhuGLF1YtMd641bCvrF6Oz+Kf42jgEJZN6OH
 3w+c6Zrv7b/UGDVt3FC6MVNepGDw20j/DPOp0ZJOskBFsgtYRu3hDLa06RPmgIdF
 zKwuf11lujfE8y5dq0Lqv8ssGeJQra0x/k1MCHIlybpCbt9P8nVzSN+965oXsS7p
 QP10yS7F+Jhgn4rwsEqrIlRazyEvbmsjiI0KcVd8iU8PexO7nhUJwJKWcKLOY+Oj
 gjfSY6kgdz7VKUfVIxj0lNQ9R0cMqF/LTatZmSBNm5tgdC6YQq7N6jjYgTvWUkOH
 yBhVSxOZyy3yOq6r5C7sNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764030869; x=
 1764117269; bh=Sy6KrNqAIPtll0wZr8cAg9OYlLxam86cNQLXtJQGESg=; b=1
 4zY0tnLTTWOffM7cjw8aEQRqZhoeqNe5/dXKkkMV/Pp64RM74TsVGUiWJ6fGgxLD
 2IYA3V7cDVFvaiRa/b3bGerEU0KiLODoHBGN34bvaHICwwyvPvtIraRF1xLLekDJ
 KBJo03pLwLKG5N6UCgn7oevPkeRGNlF1KrOieMmfBm7ibqiXoCY3iq0FJSS4Dr3N
 3ex2U54XhLX5bTa2UOw/goGZefb2BF6MJQhUJxcyiJ9SnrjDDzpBSIFJB8Le9cbs
 MCcUMpMLo8qYuSxR2HF12BqfFzaAGhQfWWMIFBm3+XKI1fgQhKBrkD2fOlFCOQ4u
 yRzKzWf16IXcn8CZZbKTg==
X-ME-Sender: <xms:lPkkabMabln-P9ApLidq3LwYo5-7DDv87-BrDTD4Ccr2sJkxGMwmgA>
 <xme:lPkkaSQdjZgoJga9RvD8v25EMNZTJHUsMIKJptmofSL0m4CfmL-AFoTZ21--kleAy
 nrkPiWDSGcjzb3svAm6fmykpx7LsMo1Y74o3NkcoBGR7pRjV254hg>
X-ME-Received: <xmr:lPkkadDJcuB8Ajg8B-nJmaDIpF24HrRRIH_s0hwr5hNdlikhpEy2fyvJAh8_OE38PUu0nmrZJSR-Y2sxiRO_kT7SJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedttdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:lPkkaRhthPYXauSUY1tmOOrjj6LUrI4UdnSieidavx_rYbgbWDkHVA>
 <xmx:lPkkaWP5zoafvFOE2ifzSHVDVDOHa8vS_ItUAUww0EljeFMIapEY0A>
 <xmx:lPkkaS5qTUMogS-K6Hf5L6OdRZ8PyBjJT9I5nsjxM_aytOgP-kAVyQ>
 <xmx:lPkkaU0HiuXicElPKrqSzk0qHcIsxV5r4WvOe5iCfeLDhM9_38PXzA>
 <xmx:lfkkaZUppqb01m8MhycIqPMC2hvMDyDK4hl5bbr2nIC-t1wE-B4B8llS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 19:34:27 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/1] doc: fix note in FreeBSD guide
Date: Tue, 25 Nov 2025 01:34:26 +0100
Message-ID: <4628663.LM0AJKV5NW@thomas>
In-Reply-To: <aQh5TKpgj4IjOsOY@bricha3-mobl1.ger.corp.intel.com>
References: <20251031115342.4064625-1-thomas@monjalon.net>
 <2436889.dTVjPilprF@thomas>
 <aQh5TKpgj4IjOsOY@bricha3-mobl1.ger.corp.intel.com>
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

03/11/2025 10:43, Bruce Richardson:
> On Sat, Nov 01, 2025 at 12:13:31PM +0100, Thomas Monjalon wrote:
> > 31/10/2025 12:53, Thomas Monjalon:
> > > The note about the prefix of the package pyelftools was not showed
> > > in the documentation output because the syntax was missing a colon,
> > > so it was considered as a simple comment in the source file.
> > > 
> > > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > 
> > Fixes: 9e6f75e259a8 ("doc: update build section of FreeBSD guide")
> > Cc: stable@dpdk.org
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied



