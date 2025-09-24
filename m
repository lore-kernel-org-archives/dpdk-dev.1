Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F53CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:22:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBDDB40693;
	Wed, 24 Sep 2025 18:22:54 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 5BFB1402EE
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:22:53 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 77E421D0007C;
 Wed, 24 Sep 2025 12:22:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 24 Sep 2025 12:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758730972;
 x=1758817372; bh=Onlvg80Bk8WlS4Rye6P66qBygtP+6U93eQT4n+VwnKw=; b=
 A77IT3RSNaNjVfkGjwatDQFDhEcxzOlZs3nZLtRrUcnmEQhwCFaQp9Kj7GkueW98
 PABt8i1io51W6yrultcdQJM6iP1pk3WURPSby2Q3y//wVeH7TyfttYAWPP7QmmKI
 GIfPcM6rl5cq3vxzOku+CAjqSAI27EdOP8MTFAJCPh3Ir3nKNKhhAS/JnpAty4/4
 /EhLarZe/15OlVyhg+EYyelYvmODsG4SOcLEAKPH1bZn99prz8WYf1qqP0cyqWZO
 a+eERdOeijpjmcVLXDt01gZwPrUEmcw7mIEvGjKamCggXUm8Dn/tXxdk5FTRjIAs
 LbOBcb+1JpV67pq0Fv/jQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758730972; x=
 1758817372; bh=Onlvg80Bk8WlS4Rye6P66qBygtP+6U93eQT4n+VwnKw=; b=n
 nDRfQ6WbMaCz36NCEuRxn+gRFeMoRX1uCkSgjfNdkkDDshmGPDw1HMCdwUtPq0Du
 DOlmXY5YOrIeQ88g7NtYtng7jqnGJnU/Mmr1mrFBNF7OYATfsCmYUdPMv5ON2RmN
 xIEaE2o4UluqD3ZrUx6rwANhg/+GZEgMnhaIQQBXTNQ0JOm3om8BriA3Y/8LMKT7
 jnGhfr0gJjYHDFQqQ8eQ2voxr5Fqd0pte1RNH1WgmdPo4fzGNSRkAHY8idaySA3k
 B4knN2qXKEIT+43E5PxiSLBFAWD5vwsgQ5ooPZaJSNiWCJ0gQBR3g/mAipuRXX/t
 aM+DJ16lwwf64cV3eUjMA==
X-ME-Sender: <xms:3BrUaIYbQtVnjUS3MDLdWsetAC5tkiQM4U1VLiq9N4-Ka70ilaTkrw>
 <xme:3BrUaPsIE4cLC5s8TXrvpowMSFkTVKXhW30c6aisrf6QmxoX2iYIwM7rj9QUWWt5y
 6JtNv_SHg4gWcNv7YDT5PKiLzEcseUrSBu7ZvM_ApRp2TForEVg>
X-ME-Received: <xmr:3BrUaFtej50pm_Uw2xyb8SQmD3vPxQd8DbEpCHLCbMddeMrp68AXLCWQ5Vrk34Qu620PTW1rySl2lXxVVxE1UZBJsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedtjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:3BrUaEeOSKMgsmjV80NGUG4-KKjMfuam2DSOtyaXIxEHkw2oEh38ug>
 <xmx:3BrUaGZUdaVCOE0UH6Cp53fk3et2qnPpC382K_nrcjLexR3ZoxNv8g>
 <xmx:3BrUaHXcqkbNF4rpgDySNWEVzrBDOAvttA8wJkkmehHnHGaCZfo1KA>
 <xmx:3BrUaIh5czRPLHM25rPiG59P16yDIp4V0JlRwbRT6_g1Y8mBBiJe4g>
 <xmx:3BrUaEA1P_r1GY6An67XjH9b9XaqD4Gqjo1R1_zQ4bIVc5IgJibcBbUS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 12:22:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] hash: fix build error due to missing include
Date: Wed, 24 Sep 2025 18:22:50 +0200
Message-ID: <40844514.J2Yia2DhmK@thomas>
In-Reply-To: <6284832.6fTUFtlzNn@thomas>
References: <20250924154821.927083-1-bruce.richardson@intel.com>
 <6284832.6fTUFtlzNn@thomas>
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

24/09/2025 18:05, Thomas Monjalon:
> 24/09/2025 17:48, Bruce Richardson:
> > The file "rte_thash.c" uses the rte_cpu_get_flag_enabled() API but does
> > not include "rte_cpuflags.h". Add the include to fix build issues this
> > causes:
> >=20
> > ../lib/hash/rte_thash.c: In function =E2=80=98rte_thash_gfni_supported=
=E2=80=99:
> > ../lib/hash/rte_thash.c:79:13: error: implicit declaration of function
> > =E2=80=98rte_cpu_get_flag_enabled=E2=80=99 [-Wimplicit-function-declara=
tion]
> >    79 |         if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_GFNI) &&
> >          |             ^~~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > Fixes: d8f0f514428e ("eal/x86: remove useless include from spinlock hea=
der")
> >=20
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> How is that possible that I don't see this error in my compilations?

That's because we see it only on CPU having GFNI.

Applied, thanks.



