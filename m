Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E146CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 20:47:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA09D402E9;
	Thu, 25 Sep 2025 22:47:48 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id B318F4028F;
 Thu, 25 Sep 2025 22:47:46 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9CF377A002F;
 Thu, 25 Sep 2025 16:47:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 16:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758833265;
 x=1758919665; bh=Hf/AbgWutXkEkn8ETF2hPECxWzNb08xEFYKv0IhzPlw=; b=
 i9GjfiYep9npRjTVUkXPaKfEbuGTDREE5205cfZZnKneM+m5QLYepDLtsjvRKCg+
 lYCQF1/hqRuZOX55UKwqsX1rLELzC2iiV/Yf4Pr9bmttteeYWdkI1fC2CrjWUZYn
 ggd8K4AWZwyHxoAlUh5pmLvG5owjYz1/GVfZZMAlrKdhfaSrCP/j1Hie/Vdj5gHx
 r+IKEFQvUSc6Jrk7DEABRkQwrmYGS6eJMQh6DXLpoeKivIdO5pWXp8mpoib7nE+e
 NveU2X/NCF0gm4Eg++aCaLsBN23S1QvSviVm5ZjY7IzyOl+7pY2ZwbEnb5mILxcq
 YFadu/mssKi9wqBKOQ5wcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758833265; x=
 1758919665; bh=Hf/AbgWutXkEkn8ETF2hPECxWzNb08xEFYKv0IhzPlw=; b=i
 uFxi823PC5ivA8dqVJGGlUkiYOh+swz4d2yR4fcIkB+qlfm8ebVSlm15LCh0K6BO
 QbDZdzbM2UgjK8YINy6hvbrS9yJlnAAuKJ5nZQVQ0fTpFo/H5KcJwGOW2YCkRsT+
 4piHyaJaBQ/fKL8Vs6AFLLSuLB92uDqss2Qc1Yvm3GEXBVuERLkGtpE+js401U6A
 kCsjyrtYcDCAABKundlbkztsHEkC8/MhgsNQp90ZNUoM4DIJweui4ZFs7JIygmX9
 fLzQUPest3aX9QevOHhD6+XEdA9W/6Xip3f4MK9i/ApQjGMjGgFCcF5MZpcI57bW
 zeZTQuiHP8N3gkmnmAcng==
X-ME-Sender: <xms:cKrVaGMTxU7bWyrTLA9f6xa3w-9f23AFVsYAqJYb82fmzq1IVIHKNQ>
 <xme:cKrVaA8xUDN0rLBbg0jE6NBaMTrGVQdlqWf3zAzZJ249zPZWdG5EGlNxiXR4QfCtR
 5GopBs1I8-vaiqmtHM31-bn8bBKQz3MtUmrKc5-vdZr-vVZE8JvQg>
X-ME-Received: <xmr:cKrVaPetz6Oc_kiqyNUxaDOEW4iF0o3DVqIYD950F_u1OQB48ieCYIodyyeabKUQy_0QvHQM4uaZLWMhdWTsngrDeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeglecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepledpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrihdrjhhisehinhhtvghlrdgtohhmpd
 hrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtvghphhgvnhes
 nhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitg
 hhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhhiugdrmhgrrhgt
 hhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsghlvgesughpughkrd
 horhhgpdhrtghpthhtohepphgrsghlohdruggvrdhlrghrrgdrghhurghrtghhsehinhht
 vghlrdgtohhmpdhrtghpthhtohepfhgrnhiihhgrnhhgrdhoshhssehgmhgrihhlrdgtoh
 hmpdhrtghpthhtohepghgrkhhhihhlsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:cKrVaHzcIBrwFYcEiZEIu3wG8ZmW_WzAd7UxJ0D4i4gVgHHi9NEnJA>
 <xmx:carVaMIdg_eY2-1Z9alAb7Pa2xt1bvuRrEsi-BwKFSfTeLmG9DFUzw>
 <xmx:carVaBGt9Oc3QGxoAXkTleJh9s6wE3co7wANwkhLvB8oPQ8W_TEnnQ>
 <xmx:carVaA8m12GZR4swqaXsoEkl-nymmbJaAPdLFP9O6qW2IQe0XlXAEw>
 <xmx:carVaLtogZjVzocWKMUztTpCcg7bGZ4iF4LNS6yT48ks49BwpM-vQkl->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 16:47:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kai Ji <kai.ji@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Akhil Goyal <gakhil@marvell.com>
Subject: Re: [EXTERNAL] [dpdk-dev v1] cryptodev: introduce constant-time memory
 comparison
Date: Thu, 25 Sep 2025 22:47:42 +0200
Message-ID: <3819475.yaVYbkx8dN@thomas>
In-Reply-To: <CO6PR18MB4484264974305D4A6B065A76D81FA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250925102223.145471-1-kai.ji@intel.com>
 <CO6PR18MB4484264974305D4A6B065A76D81FA@CO6PR18MB4484.namprd18.prod.outlook.com>
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

25/09/2025 12:33, Akhil Goyal:
> > +/**
> > + * Constant-time memory comparison for cryptographic use.
> > + * Returns 0 if the memory regions are equal, nonzero otherwise.
> > + * Runs in constant time with respect to the length to prevent timing attacks.
> > + *
> > + * @param a
> > + *   Pointer to the first memory region.
> > + * @param b
> > + *   Pointer to the second memory region.
> > + * @param n
> > + *   Number of bytes to compare.
> > + * @return
> > + *   0 if memory regions are equal, nonzero otherwise.
> > + */
> > +#define rte_consttime_memcmp(a, b, n) __extension__ ({ \
> > +	const volatile uint8_t *__pa = (const volatile uint8_t *)(a); \
> > +	const volatile uint8_t *__pb = (const volatile uint8_t *)(b); \
> > +	uint8_t __result = 0; \
> > +	for (size_t __i = 0; __i < (n); __i++) \
> > +		__result |= __pa[__i] ^ __pb[__i]; \
> > +	__result; \
> > +})
> 
> I believe this is not the right place to add this define.
> It should be somewhere in common eal if it is already not there.

Yes indeed.
cryptodev is the API for managing crypto devices.
A new memcmp function would be better hosted in libc,
and in EAL for compatibility with all supported libc.

I mean please add it in EAL, and propose it to glibc as well.




