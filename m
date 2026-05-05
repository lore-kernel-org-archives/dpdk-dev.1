Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC7DFF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 07:01:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AA23402A7;
	Tue,  5 May 2026 09:01:48 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id A0C1040270;
 Tue,  5 May 2026 09:01:46 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D83307A003F;
 Tue,  5 May 2026 03:01:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 05 May 2026 03:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1777964505;
 x=1778050905; bh=oEwEAS0o9x6OU1RBMwZ3x5vCUR4h49JoVTmtke69hiY=; b=
 n/JQIPNnjPizJiWjSoBC86dIzqYP8agHMDGuUcYcCxdvzuoMDdfqERn396BLtaFU
 YESHmIaAecEvluHu4PoRl5DGrF91oBQyO0hgfXX0vz5u4lUvcymIOaYnWIlmKJMC
 HD4uqJP5THqt3H4A95MMEimvpADhjQRoSjSS9oGDB5PMXkxkfrUypn/3HH3bxEg0
 s7B3U48ew1VLBthYn4uFHLP0++GbbqTtetRGjDNSapvKmVfdrbybOpiG/fk7vg9a
 8s1GoGFL7LMK2gnn2+htsIdNTKjfcJe9rcijGOLKiiVA2ezdstTIOlCJlyLS8AJs
 dIx9iMR93hVEouSDUoaKfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777964505; x=
 1778050905; bh=oEwEAS0o9x6OU1RBMwZ3x5vCUR4h49JoVTmtke69hiY=; b=T
 bOEajWct8AEYWBtJLLyjuacbB1Ga3wXiTaiiP5KdtOqPIcAyT3HDLdT/s12MQJ1Y
 3/5UQP05dUTnfR3mkDdCA8sufYQZkdlknkXvLzl13LXWQsehYRcxvZXyXi30wh11
 j3GD+MSFmFlJPbdPByBIKoD8FKMxC5UvjqCUdzJ4u59ZdTD0WRPH3vRf048uQ2JT
 C5E26FY/P2G+ReSdTukR8XZO2t/clhv8V5tMm75lCnsGx21RTdximiY2h/mR9xEY
 oSjScXzPW5GO9kZFEhudUi/Rd3UOK+fsvKTdem7yr9UJvDMBoXPKvtBK8XZ4p3QU
 cd50/BXxZiNVOdZHpOk+A==
X-ME-Sender: <xms:2ZX5aaFTetqOS6q42OgAeALGTSgAPHGYjr_hhWx92oSqjnClLThtbw>
 <xme:2ZX5afosPEFpv251aPJYor9DPFmnwlfJMFY4YluAKb3_ehQnu_KEl5luCZs67QMDt
 YelNS6aVszL2nfuTuNrr81HjgE57jwGjGBVJGBa4BYk_0ztX_0_>
X-ME-Received: <xmr:2ZX5aTR1FPVScIccc-6netkgmCByy1Y87ZltE6oC_NZnIlKKDcKXxfgsQgowfmiqd7sixKC0LjoHRjrULcYi9G8Ysg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddutdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:2ZX5acOWxJAThPrvIRHJ3ofIfCrtRrEcVeYOfuZ2XpUpv0dfhqNpkQ>
 <xmx:2ZX5aWNraY0S01p0CevpttBdxN2ToulNCael1eWww96BrkTWa5L54Q>
 <xmx:2ZX5acsubK7idL8z-XtPn3GGjKG14Vrq9x-MkBWK9DsJAHBRzLn69A>
 <xmx:2ZX5aQXKnw3LHsAq-6F1q_K6Ye2lwPc8I36IhSvZLX4wB4q2HkUReA>
 <xmx:2ZX5aVJPdFGgZ2mf0Gzt_r0_-lS5bA7S7PPdZXavVQfE0s3q7kUNFB1d>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 03:01:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] spinlock: remove volatile qualifier
Date: Tue, 05 May 2026 09:01:43 +0200
Message-ID: <3066926.2VHbPRQshP@thomas>
In-Reply-To: <20260504100239.07d48122@phoenix.local>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260504100239.07d48122@phoenix.local>
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

04/05/2026 19:02, Stephen Hemminger:
> On Mon,  4 May 2026 10:37:14 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
> > index c907d4e45c..19c0e34f0a 100644
> > --- a/lib/eal/include/generic/rte_spinlock.h
> > +++ b/lib/eal/include/generic/rte_spinlock.h
> > @@ -197,8 +197,8 @@ rte_spinlock_trylock_tm(rte_spinlock_t *sl)
> >   */
> >  typedef struct {
> >  	rte_spinlock_t sl; /**< the actual spinlock */
> > -	volatile int user; /**< core id using lock, -1 for unused */
> > -	volatile int count; /**< count of time this lock has been called */
> > +	int user; /**< core id using lock, -1 for unused */
> > +	int count; /**< count of time this lock has been called */
> 
> It might make sense to use unsigned for count, and sized types.
> I.e do you really need 32 bit values?

Such a change would need to be evaluated in a performance benchmark.

> Only in tree use of recursive spinlock in vdev code.
> 
> PS: I wonder if we really need to keep the transactional memory versions of stuff.

I don't know, it's part of the API and has no maintenance cost.


