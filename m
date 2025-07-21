Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285EEC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 10:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2A6C4065A;
	Mon, 21 Jul 2025 12:45:52 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id ACAFC4060F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 12:45:51 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 370051400255;
 Mon, 21 Jul 2025 06:45:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Mon, 21 Jul 2025 06:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753094751;
 x=1753181151; bh=Y/sJ/xQXFEPsaG2BSIOkd+gdfeF/64l/GqKmhlg8Lto=; b=
 mp/YJMwyGzfh2/hXjd7//mJXktzXgOhwwfnmS3hDBzPOTVYuLHO0NDoE+tGONB1r
 FotJfWTWIETZUlP5qtqdAOmvGDMvojsbo9bKStasNoQWnTuJwetEPkyp1Qnqcsz1
 eo0dwIN4QgfsmoJrfgVaFgOwmdFvS2kX95UV2kaZpKSakjOk2UQwZ9uCsProD6aD
 XOFtwCJef4tqDCrzIa+DyF1tAwTfUlv+GHEgoqy0ek/48DCo8eaXJAlDEFgnJytT
 CvtKgbAWTRKwhsAQOJAqsRyWPwWHcOdhrcqD0Av5E8461DAlxgnR7nfZrVDAgUdY
 9wNso5CxA0JFB0fjc2OLVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753094751; x=
 1753181151; bh=Y/sJ/xQXFEPsaG2BSIOkd+gdfeF/64l/GqKmhlg8Lto=; b=G
 FjgEl4+yz7pZT6OZTr4siVqG8J34tSWLK9zgfbGyj7avqrx4wPJfxNvd3fNGXmD4
 Kbs9wCjbERwLcmEcCjvR0EgGDrRq/1e+/3XrzPN8UMIPKF/DQeaAr2+3Ig4G7NeF
 vn6Kk/oRSpg14ZXBcs3KlkZ+nToiZ4HDa4iYeYvV789U9LUfg5ugQYEzXEXDESia
 4q9CZsrPtX8ClNo5TD0bLsohpKR8uT4aEoJyf8grNkSBvn1ytsdyLj8pV2XkJRkq
 DMu8EJWd06bwanQgxwQY+iUuhi7AgLl9LzNBtdTjqjDjIRr8zY5SpwmS8MgYEnOp
 FEQW+3qNRFLR1NeiyGSow==
X-ME-Sender: <xms:Xhp-aC8BCnvQsBXp0Wi9tpka_9UVoxz-aDbag2k7qXuqjrpFQSngxQ>
 <xme:Xhp-aAoD4I_SxDV8eRpLI0IoHl_oTSlwzHmsFahdAtkN0NMRquuHcs4HNRwCDZ-il
 rnT91_IcHLYybLWGQ>
X-ME-Received: <xmr:Xhp-aKWIxfUk6eSLjwfvcqQXFiufkOO4tCtZgJ2cKEihFTXANwJFNApm5q01iH6JeV87JOD5qSMp2NdBT3KpTp6dxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejudekkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnheplefgudfhfefgjeefgedvffdtteffueffhefhteduvefgleeukefgkeeg
 tdevueegnecuffhomhgrihhnpehpmhhurdhrvggrugenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhn
 vghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
 htughushiihihnshhkihesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopegurghvihgu
 rdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrh
 hitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughk
 rdhorhhgpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpth
 htohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhm
X-ME-Proxy: <xmx:Xhp-aPDGvnQZFzZrB9BS3VSeWNvWswplMje0HBsA4UUofHs2eovBpw>
 <xmx:Xhp-aO3DI4VWqqtRdqFs6UuxR_4oEIZLQjReg7PakBzrEUh0ctmz0w>
 <xmx:Xhp-aB0pM12rtJwLq6XU_F4t1-bMNgX4u33O2Qka57wdfZeeBNdXSQ>
 <xmx:Xhp-aDCupEH4KLVeHpdtc2EGENdGkGorQiZejjVw3K8osqi46qaTyA>
 <xmx:Xxp-aIiR1BwpPo1zGS6F6aJC4X68V38hMqgWkn0wUo0DUZyBl8HT1HBu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 06:45:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: david.marchand@redhat.com, bruce.richardson@intel.com, dev@dpdk.org,
 jerinj@marvell.com, mb@smartsharesystems.com
Subject: Re: [PATCH v7 7/8] trace: add PMU
Date: Mon, 21 Jul 2025 12:45:48 +0200
Message-ID: <1859501.3VsfAaAtOV@thomas>
In-Reply-To: <20250721102457.2399936-1-tduszynski@marvell.com>
References: <CAJFAV8zDBgpEyg_GL-Pzh-5n5kGjYE6g2JedgZeoTgGiDN97OQ@mail.gmail.com>
 <20250721102457.2399936-1-tduszynski@marvell.com>
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

21/07/2025 12:24, Tomasz Duszynski:
> > On Fri, Jun 27, 2025 at 5:41=E2=80=AFPM Tomasz Duszynski <tduszynski@ma=
rvell.com> wrote:
> > >
> > > In order to profile app, one needs to store significant amount of sam=
ples
> > > somewhere for an analysis later on.
> > > Since trace library supports storing data in a CTF format,
> > > lets take advantage of that and add a dedicated PMU tracepoint.
> > >
> > > Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
[...]
> > > --- a/lib/eal/common/eal_common_trace_points.c
> > > +++ b/lib/eal/common/eal_common_trace_points.c
> > > @@ -119,3 +119,23 @@ RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_enab=
le,
> > >         lib.eal.intr.enable)
> > >  RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_disable,
> > >         lib.eal.intr.disable)
> > > +
> > > +#ifdef RTE_LIB_PMU
> > > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_pmu_trace_read, 25.07)
> > > +RTE_TRACE_POINT_REGISTER(rte_pmu_trace_read,
> > > +       lib.pmu.read)
> > > +#endif
> > > +#ifdef RTE_EXEC_ENV_IS_WINDOWS
> > > +/* gen-version-map.py script generates export symbol maps by scannin=
g source files without
> > > + * evaluating conditional compilation. Hence __rte_pmu_trace_read wi=
ll be included the version map
> > > + * even if library is not compiled.
> > > + *
> > > + * On Windows if msvc linker is used this leads to a hard link error
> > > + * (LNK2001: unresolved external symbol) because msvc requires all s=
ymbols listed in the .def file
> > > + * to be present in the object files.
> > > + *
> > > + * Other linkers, e.g: gnu ld or mingw ld, are more forgiving. They =
silently ignore symbols listed
> > > + * in the map file if those symbols are not present in the binary.
> > > + */
> > > +rte_trace_point_t __rte_pmu_trace_read;
> > > +#endif
> >
> > From a quick look, could you export this symbol from the PMU library it=
self?
>=20
> Got caught up, but here is my take. It would likely make trace a dependen=
cy, but I believe the
> dependency should be reversed. Also from my perspective this suggestion f=
eels more like a
> refactoring.
>=20
> So unless I've misunderstood your point, I'd rater keep the current solut=
ion as is.

I think you got it right: a refactoring looks beneficial.
Please think about it.


