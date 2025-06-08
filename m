Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C79C5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 17:53:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 820D5402A9;
	Sun,  8 Jun 2025 19:53:06 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id E929940269
 for <dev@dpdk.org>; Sun,  8 Jun 2025 19:53:04 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 46B2B138011B;
 Sun,  8 Jun 2025 13:53:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Sun, 08 Jun 2025 13:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749405184;
 x=1749491584; bh=0biidSVZTkuBdXLZZKKwzEmJ/px6oTKNQwIbikNmfw8=; b=
 VrywIFGjZ7L/2xiqCyGcWTgBOBVloUV1CkYJuv8cY9QFzdAKjN0/BBlhcjEKDuMk
 4LqCJlSi3LwsUrKafELDgQvPWopiRuv/JJppvnbzFCFaar+KmeWpulJVTwZ52s2U
 gULS8/pgdgz5zvfiBbS42xbzC7RGViBUOcBSvCFkV8EXThXpnXOkJZaG99XUV97g
 vcf4jKAzjSrd6gbMvwH6KVucVRoMTlqnKaMbo6SSQXNkiWyFqdTHTRzgwBsAneSQ
 cQk7mqv0ziqSrbtpP9f9IYidmlpj9/sBZPtGS7NVGH9h9Sv+cSL3l1kRqqUfNRcU
 KpKrIwAtsHmoUzQOFvPqjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749405184; x=
 1749491584; bh=0biidSVZTkuBdXLZZKKwzEmJ/px6oTKNQwIbikNmfw8=; b=c
 wHeXC2DGdgpv50ZnNV7QVmK0kWaH0jQIaGDLlknYB0Jm9E/L0ZBLw7yJ0lyDNJiD
 NkxW8Ed+1+AwiCUUCERJyyy+zb78z2zx+0Zf6OCx2cfEWV2LwAy5RX5f+cNgZRXN
 kOiyBL6s9tgRwaxRVTTc0J54nV7iEhHFXeMV8ED15eQjqQAeEEmciBUtoBlaleUe
 aBEXbSzpVHvIuZBGf1fE4ySgKDCyneaHr0yoTl1ua1sH++9DciZ7HnfR1k0xzC8D
 06XHe6Oe3+gLskEBxWGaxHEFaNOlOwh/CLQmqFYAu92DaTiO02Ldpt879suPXrxF
 at3Vz22IF3w/PRgwytp5w==
X-ME-Sender: <xms:_81FaF-n4Zcbp-oNd90g9wFG_yc7MBpnK5bFyaCP5JQ8A2Crwmm87A>
 <xme:_81FaJu5_VxSzWJsnxzlUKB8Jzqy1YWQnsF5kRQBfPJU2EaDM3v6ynGthIJzOMzTM
 tTazVtXHvdqRnhpWw>
X-ME-Received: <xmr:_81FaDChDQljvI_ZaAh7SJA2pJP4OIJAzGbmwTREM50I_q3qPDg8pShmEA4M70K6Fnj_fkvxA6qfPxa_ktimmxflDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekudekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedt
 heevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgessh
 hmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopegsrhhutggvrdhr
 ihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukh
 drohhrghdprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvthhl
 rggsshdrrhhu
X-ME-Proxy: <xmx:_81FaJctwpaMa0Ag2hrKRLd1kdSMfotejbJi0kLzUoadoTx1Xc29Kg>
 <xmx:_81FaKPXGtvl8acBmwzS-paJANHWSqHrVAaGhEacCkAHKoW44rmZ5w>
 <xmx:_81FaLneVA1EmkWal4faKz06T-2TUzLTJw290dpRtXX3m9_Hq6EBsg>
 <xmx:_81FaEucZiCZBUCJzjEcIAppoiXRkckL4xQp-uBxcuA__gxPc8BGWg>
 <xmx:AM5FaDMzFf3Q-LYsYvFtXi1Sv7W4SVOa1OnBpxDH2H8lCREXchRmsVWt>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 13:53:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] mempool: micro optimizations
Date: Sun, 08 Jun 2025 19:53:00 +0200
Message-ID: <3772522.QkHrqEjB74@thomas>
In-Reply-To: <e7ff43da-001a-483a-b62c-e819944864ff@oktetlabs.ru>
References: <20250226155923.128859-1-mb@smartsharesystems.com>
 <Z-WHzgriLwWC_3Mu@bricha3-mobl1.ger.corp.intel.com>
 <e7ff43da-001a-483a-b62c-e819944864ff@oktetlabs.ru>
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

30/03/2025 10:09, Andrew Rybchenko:
> On 3/27/25 20:15, Bruce Richardson wrote:
> > On Wed, Feb 26, 2025 at 03:59:22PM +0000, Morten Br=C3=B8rup wrote:
> >> The comparisons lcore_id < RTE_MAX_LCORE and lcore_id !=3D LCORE_ID_AN=
Y are
> >> equivalent, but the latter compiles to fewer bytes of code space.
> >> Similarly for lcore_id >=3D RTE_MAX_LCORE and lcore_id =3D=3D LCORE_ID=
_ANY.
> >>
> >> The rte_mempool_get_ops() function is also used in the fast path, so
> >> RTE_VERIFY() was replaced by RTE_ASSERT().
> >>
> >> Compilers implicitly consider comparisons of variable =3D=3D 0 likely,=
 so
> >> unlikely() was added to the check for no mempool cache (mp->cache_size=
 =3D=3D
> >> 0) in the rte_mempool_default_cache() function.
> >>
> >> The rte_mempool_do_generic_put() function for adding objects to a memp=
ool
> >> was refactored as follows:
> >> - The comparison for the request itself being too big, which is consid=
ered
> >>    unlikely, was moved down and out of the code path where the cache h=
as
> >>    sufficient room for the added objects, which is considered the most
> >>    likely code path.
> >> - Added __rte_assume() about the cache length, size and threshold, for
> >>    compiler optimization when "n" is compile time constant.
> >> - Added __rte_assume() about "ret" being zero, so other functions using
> >>    the value returned by this function can be potentially optimized by=
 the
> >>    compiler; especially when it merges multiple sequential code paths =
of
> >>    inlined code depending on the return value being either zero or
> >>    negative.
> >> - The refactored source code (with comments) made the separate comment
> >>    describing the cache flush/add algorithm superfluous, so it was rem=
oved.
> >>
> >> A few more likely()/unlikely() were added.
> >=20
> > In general not a big fan of using likely/unlikely, but if they give a p=
erf
> > benefit, we should probably take them.
> >=20
> > Few more comments inline below.
> >=20
> >> A few comments were improved for readability.
> >>
> >> Some assertions, RTE_ASSERT(), were added. Most importantly to assert =
that
> >> the return values of the mempool drivers' enqueue and dequeue operatio=
ns
> >> are API compliant, i.e. 0 (for success) or negative (for failure), and
> >> never positive.
> >>
> >> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> >=20
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

Applied, thanks.


