Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7759CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 19:10:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1334B40E2D;
	Wed, 15 Oct 2025 21:10:16 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id A636540273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 21:10:13 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id BE5EB1D0010D;
 Wed, 15 Oct 2025 15:10:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 15:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760555412;
 x=1760641812; bh=TtmeaKf5HQaWMi+BhavHMPIahzK6iM9Lrj00aYWQodY=; b=
 EuIWIW5Hiuop1Sq3nlLTj41HVT8b+eqoDEfLzDHOVXoU1lcbUQg7RWvPFfUafnje
 xKmJ/M5XTsyhxni9c/jhlLECkG6l41jFkJLyUt8KptB/dsUaCRrIFIdqdSukcWPB
 ht61zuB5LKG5Hh9wrvlcdP1Kh4kZog0GY3IJ6/nA3kEuIc82O8oDNCiUS7PFdq3W
 QDBE984zIdzT9FwNeaK7aEV6rdWRSPke7daed9kYK9gMCmHsgM+Jr9oL7Fj88gpZ
 VYZRimwJHzxE46r7tSGSILyjSsV+48Z9I6HTfV4H7DXEnLprgDrvpmFXZdOV/Xah
 nN3YUnrYO3x6nQy8U/s7fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760555412; x=
 1760641812; bh=TtmeaKf5HQaWMi+BhavHMPIahzK6iM9Lrj00aYWQodY=; b=K
 HtTEOY/FmSPB2hweE5KJlG5IWAwHZOtxC8iVVE9tSst9qwnzBQbC2EL+vKKrt9M3
 D+QJTYIqXFJsnXvmz8fPpxMm5JAVcvWEL2erbuPKC6Sz1ntvohvCWxnlsKC+mP4m
 EXZ7YR339qinX/5h/FdN69cikEd81jMvagn3TiUwNCQWV5zg3SvYdykGojjjaLpc
 xeZbhbBLeVNgaTvqMG2z28YfSgmymxQThjlq+plZtxb2VlD2MZTj17Ih2uLRmIWH
 UFVUi9xwxoqAjHsZ0z9RcCtHpGu5qABckRgecDDboFyC3zw0koxOgO+0+qHmVZRm
 CpC1UvrmWux+ZN1aOKBIg==
X-ME-Sender: <xms:k_HvaExFB3HYgLFxYJf2-KJ3lrGM-8soDMhtKwRXAs55IYTUNUoeqQ>
 <xme:k_HvaDPomgHS004PQoCvxLCkPbh1uJ17qTFGnCQsuyw5fxxwmqgoZHS6MIoelDztj
 1_dklXcmYvV73Oa9c4Dufw0JBdQcWboO-4jZGtOFEVZVoQeVVCF9g>
X-ME-Received: <xmr:k_HvaFUmnzIO4P05KM19syRVgsClKPP2UCxGoKuHFxdEPf1doKCmNj3Wldw97itMUHrSCOUL6DIZwsS3cLwioqy3Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegvdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthh
 gvshhlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghh
 rghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrg
 hrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtoheprghmrghnrdguvggvphdrshhinhhg
 hhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:lPHvaH20XZWyNvOgudnOung2CBOwNOOAkUJ6WTrsn7L6_HDLr-Ltgg>
 <xmx:lPHvaDoDjn1jZM9Ugem2pFMG_1NU7-1LAqutFu9EjExuG-IM5pngeg>
 <xmx:lPHvaOXphOBolSkRwm2fp6OnEDEB9ecSV9xG7vrcSFuczx7qk3-VCg>
 <xmx:lPHvaOYojH-LxwTwulI7OLV4ekWd8dki0rrknNNfEXz2cKZe43NUlQ>
 <xmx:lPHvaLrM4voObNcYpcve1hIJyyr7yxBEl11STjTy0pZnBVDUX3nHTicU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 15:10:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, shperetz@nvidia.com, viacheslavo@nvidia.com,
 bruce.richardson@intel.com, mb@smartsharesystems.com,
 Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v6 5/7] app/testpmd: use space separator in dump commands
Date: Wed, 15 Oct 2025 21:10:09 +0200
Message-ID: <8614129.gsGJI6kyIV@thomas>
In-Reply-To: <20251015105207.288a5b94@hermes.local>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-6-thomas@monjalon.net>
 <20251015105207.288a5b94@hermes.local>
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

15/10/2025 19:52, Stephen Hemminger:
> On Tue, 14 Oct 2025 14:33:38 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > @@ -9099,7 +9123,6 @@ dump_struct_sizes(void)
> >  #undef DUMP_SIZE
> >  }
> >  
> > -
> >  /* Dump the socket memory statistics on console */
> >  static void
> >  dump_socket_mem(FILE *f)
> > @@ -9114,7 +9137,6 @@ dump_socket_mem(FILE *f)
> >  	static size_t last_allocs;
> >  	static size_t last_total;
> >  
> > -
> >  	for (i = 0; i < RTE_MAX_NUMA_NODES; i++) {
> >  		if (rte_malloc_get_socket_stats(i, &socket_stats) ||
> >  		    !socket_stats.heap_totalsz_bytes)
> 
> Unrelated whitespace changes in patches are discouraged.

It is quite related given this patch is about dump commands,
including this dump_socket_mem().
But yes, no other lines are changed in this specific function.
Do you really think removing extra blank lines is bad in this case?



