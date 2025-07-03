Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B79C83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 13:23:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0623540267;
	Thu,  3 Jul 2025 15:23:09 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 9544F40264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 15:23:07 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id D146B1D00187;
 Thu,  3 Jul 2025 09:23:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 03 Jul 2025 09:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751548986;
 x=1751635386; bh=zRepnE04Ip4A2ECMU8BZdiTD+PFvY4l1vGCqW9qOoEk=; b=
 GAhLGQ1j54S9axYm+udyEer8yKRu8lNJCUr2ogLy7yZE8B/nUXh4vz513OIoGNsk
 Ee0omEuHlqhKE+ejAh19g23wNdftC5q4P5dSeTOZogNj1dLXKuXdBza0eIKC7D+9
 RVcwA/O/zWBtR2QnKdbeWmWfQVUrusAnOPSTYmCHhGi6n1q7xp2jgiovYGlhDvIF
 NWV6Pt255esMvyWcThWxK5l5WZSj/p0zAdGPUyMJ5rXQPum6nl7Mo7M50t0a7SDi
 73pa86UHuV5kY226m4mTRSQLC9DIX86kNrgqXPJe7sbkwIasi+jnqxbIv6/yKcQR
 ck4leiQ94f9fOa809YHJng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751548986; x=
 1751635386; bh=zRepnE04Ip4A2ECMU8BZdiTD+PFvY4l1vGCqW9qOoEk=; b=h
 lnJcvAZFe06m4j0zTfkP+dWsA410u7QO9Zz6IbTsbiJuTR6wPpC+uNSNjKyPspSy
 HnvA6Y85ACq+q46EmiCsVv7GLA6yA2wUhh+xkD8LrsLgODssIK6wtCglv71AEF7C
 mX8zed/VmzTr7Maox8Tw/OC6Kfv26zC6LPm6RsmaakqT4TGCrDSeP4+N1F4elPvy
 Tn9n4CNL5ZQXJuPsb1Ryq8aqQ0CLd+R/syfD0KNPc7YnLA+LaVH7htCQC3lR0sx0
 oXsAwZYtDkcX9WR8cpNTPQsSAOw1jnWfaMIOteAje0ITpiRiSy+yLENAQlr+SrKc
 6Hs1lckuynKpQ0Ww30Vgg==
X-ME-Sender: <xms:OYRmaFItrSNmyi-IvP6cRyQHjQbka3wfyqpqiFa2wBtUAruI-PNbQQ>
 <xme:OYRmaBIUAvMYOIjcM9TCvF6eSJoSNK5oEtqmmuBClj_sK9bx0H5aBB_tBYOagVGwI
 qhwkn2VAeZtO5t6CQ>
X-ME-Received: <xmr:OYRmaNsP42liqkSFAAcbko5kYRVtg6FkznrZWKdTE2DsQMYmK37dBdN8yBv6kledGgaHgEfJfBJ2VyMpfBzMrdOcqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdefkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepkhhonhhsthgrnhhtihhnrdhvrdgrnhgrnhihvghvseihrghnuggvgidrrhhupdhrtg
 hpthhtohepvhhiphhinhdrvhgrrhhghhgvshgvsegrmhgurdgtohhmpdhrtghpthhtohep
 rghlrggrughuhhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepudegphiftghsvgduvd
 dvgeesuhgvthhpvghshhgrfigrrhdrvgguuhdrphhk
X-ME-Proxy: <xmx:OYRmaGbus-IzDy37w7RcHyQNzz8ybkybg30BB7C6XaleNdFq7C4nag>
 <xmx:OYRmaMbpF6XWWjDQTD1Onkn_2HVHjjnSaMTR9s6C-fUTDECFLTa7_A>
 <xmx:OYRmaKAJpX7kyr8Z8mh85MDmrUPij_37cuzwyZSxthuVsSiwzesjrw>
 <xmx:OYRmaKZqCEUvPqJ9IQpWF75NGj31EQZ9fix1haDwM2YnFwoAVVdC1w>
 <xmx:OoRmaOwLT30YjQGcKny53tjusdNAox1pzbgEcZRQifbZiiSyCcQCsc_2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 09:23:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>, Alaa Duhaidy <alaaduh@nvidia.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: Re: [PATCH v3] build/x86: fix support for older compilers
Date: Thu, 03 Jul 2025 15:23:02 +0200
Message-ID: <13147413.04QRnsoN9i@thomas>
In-Reply-To: <20250703102123.3708401-2-bruce.richardson@intel.com>
References: <20250702155129.3440210-1-bruce.richardson@intel.com>
 <20250703102123.3708401-2-bruce.richardson@intel.com>
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

03/07/2025 12:21, Bruce Richardson:
> Some older compilers e.g. gcc 8.5, do not support overriding
> -march=native with another architecture, leading to build warnings such
> as reported in Bugzilla (link below). Add a check for that case, and
> explicitly add the avx512 flags if necessary.
> 
> Note: it appears that it is only the "native" flag that isn't
> overridden, which makes the issue hard to reproduce e.g. using
> godbolt.org, or on a modern machine. For example, testing with gcc 8.5
> on a haswell machine, using 'native' vs explicit 'haswell':
> 
> gcc -march=native -march=skylake-avx512 -dM -E - < /dev/null | grep AVX512 | wc -l
> 0
> 
> gcc -march=haswell -march=skylake-avx512 -dM -E - < /dev/null | grep AVX512 | wc -l
> 5
> 
> Bugzilla ID: 1736
> Fixes: e361ae3f59d3 ("build: reduce use of AVX compiler flags")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



