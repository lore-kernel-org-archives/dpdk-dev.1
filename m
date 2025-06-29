Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B28C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 12:11:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 927FF4026F;
	Sun, 29 Jun 2025 14:11:04 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id D3C454014F
 for <dev@dpdk.org>; Sun, 29 Jun 2025 14:11:00 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id DD10D1D001AC;
 Sun, 29 Jun 2025 08:10:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Sun, 29 Jun 2025 08:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751199059;
 x=1751285459; bh=kreKRl7ijC/pJJ2nARJFor/HPCuxcp4Qpi2KU0KXazk=; b=
 fCJkMXA2JmulPk9vjk/3vyN6NnVB4Ry/GnjLo2cJhdgRDfPVNq2X30Mb9M8jWUzc
 EgrMmHYaWLctpKYmt3tgqzxeJ9JrNhKJbsG2jszXeLrDcS5PRqnKe20SMwEGXw0L
 ZEYq2TMRbs/P9iAPtBO5hooEpR6FR9IO/mo5ly5cgFzSTYIWmiIxKvXiFrHUTyZ2
 WkDCQdPbT9IMM/7CWCQ79qsCgCrwsyj2AreSPH4INzs3xvYbW/ols086yOzRV00n
 qS2k8zjHojElfdgLFkcXD+YKgFuxmEkwYh/cW01+aSaHA7+xwoTsO1ZNSVUbkTGg
 k6IgRgRwBmFAjytqG1HqVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751199059; x=
 1751285459; bh=kreKRl7ijC/pJJ2nARJFor/HPCuxcp4Qpi2KU0KXazk=; b=D
 SXA6gIcszwcniYvIOw1noPXIOEKCJss9NmzjUqJTD7/SRs3qhPiXMykSN9Q7GFaH
 45gnTPQa/GrypZbtVaXz1VrQ1V3eb5v/1t530Isjbde1k1wlQEUo+vUNj659QFkR
 MIH89b0tREngxcvLreKhlkiiQtIc+/OXuaYbs6vqhV6tD6m03sS66OerZ8Ysr7E4
 suSYeQubf18mvaJVgPpYNhMmrt5qy7/KzqbxDINh4g/MSIMW5t96dhTWHzY0dnj4
 wKJ/CqWOM7B5xAFlNTAg64xbi/gNcFckoOn9y+PpMi0eHSFYuiai5J23w/hnpfSG
 WlHNBMUVFqu5VHtOtrwpA==
X-ME-Sender: <xms:Ui1haBoxE9PCl8TeFi6FTswLlmzSFpBjJV6H6zrjNWEduDFKNvEkZA>
 <xme:Ui1haDpgNzXvyZv2UZzZwy9qUOn39DYrDrJebElIfme3512NdiBnXBqQRrZUHsavx
 Bz668ffZYOO33EBmA>
X-ME-Received: <xmr:Ui1haONs4GEbEgLGRZEJ_lie-ypZpeM11esrCa7ajYu__g5jOGGSC4Zh101AhxMJlAJPnj_xjDY1Dmgblec5uQ1UiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekjeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpefgfeeftdevffffueeiueelhedutefgfefgfeelteehkefgiedvieeugeev
 feffueenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhn
 rdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopehs
 thgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehroh
 hrvghtiihlrgeslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopegr
 nhgrthholhihrdgsuhhrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthhtohepsghruh
 gtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrgihi
 mhgvrdgtohhquhgvlhhinhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhvghnsg
 hogiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepthguuhhsiiihnhhskhhisehmrghr
 vhgvlhhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:Ui1haM66ic6E6WpGkFulnrCQ2lsPV9Xf45VHJYs8WNJlcU0Up6hb8w>
 <xmx:Ui1haA5ipcTGmpZXpYq_vHeSAJtrusbRxEdmU60qZTlXkubpGN78hw>
 <xmx:Ui1haEjwUVpDuTnxpk--8OVmuuG7qZWEaNmpoR5p1lHF3RRs2ahOyg>
 <xmx:Ui1haC6QwXcjwzdipsQApSYE0J2vbuUpW2nXRXGW4mkRp7SmaEfp0g>
 <xmx:Uy1haCmneeaHhHOyLByjKDkcQSoJuir_a3JDjB3TgmP572E34RYrR2tz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jun 2025 08:10:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 dev@dpdk.org
Subject: Re: [PATCH v3 2/3] eal: handle sysconf(_SC_PAGESIZE) negative return
 value
Date: Sun, 29 Jun 2025 14:10:55 +0200
Message-ID: <4900019.7x91mkYCy2@thomas>
In-Reply-To: <20250628154927.6161b011@hermes.local>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD5B@smartserver.smartshare.dk>
 <20250628154927.6161b011@hermes.local>
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

29/06/2025 00:49, Stephen Hemminger:
> On Sat, 28 Jun 2025 18:45:44 +0200
> Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
>=20
> > > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > > Sent: Friday, 27 June 2025 20.30
> > >=20
> > > 27/06/2025 19:49, Morten Br=C3=B8rup: =20
> > > > > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > > > > Sent: Friday, 27 June 2025 19.35
> > > > >
> > > > > 27/06/2025 18:38, Morten Br=C3=B8rup: =20
> > > > > > > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > > > > > > Sent: Friday, 27 June 2025 17.58
> > > > > > >
> > > > > > > 24/06/2025 10:03, Morten Br=C3=B8rup: =20
> > > > > > > > +		if ((ssize_t)page_size < 0)
> > > > > > > > +			rte_panic("sysconf(_SC_PAGESIZE) failed: %s",
> > > > > > > > +					errno =3D=3D 0 ? "Indeterminate" : =20
> > > > > > > strerror(errno));
> > > > > > >
> > > > > > > We don't want more rte_panic().
> > > > > > > You could log the problem and return 0 here.
> > > > > > > It will be a problem later, but it may allow the application =
to =20
> > > > > cleanup =20
> > > > > > > instead of abrupting crashing. =20
> > > > > >
> > > > > > Disagree.
> > > > > > That would be likely to cause crash with division by zero later.
> > > > > > Better to fail early. =20
> > > > >
> > > > > Which division by zero? =20
> > > >
> > > > Functions dividing by page size. E.g.:
> > > > =20
> > > https://elixir.bootlin.com/dpdk/v25.03/source/lib/eal/common/eal_comm=
on_
> > > memory.c#L313 =20
> > > > =20
> > > > >
> > > > > I don't think a library should take this decision on behalf of th=
e =20
> > > app. =20
> > > >
> > > > I expect lots of things to break if sysconf(_SC_PAGESIZE) fails, so=
 =20
> > > the purpose of this patch is to centralize error handling here, and o=
nly
> > > continue/return with non-failing values. =20
> > > >
> > > > Otherwise, everywhere using rte_mem_page_size() or =20
> > > sysconf(_SC_PAGESIZE) should implement error handling (or ignore
> > > errors). =20
> > > > That's a lot of places, so I'm not going to provide a patch doing =
=20
> > > that.
> > >=20
> > > I understand.
> > >=20
> > > The problem is that we don't have an exception mechanism in this
> > > language. =20
> >=20
> > Yep.
> > And everyone assumes sysconf(_SC_PAGESIZE) never fails, which is probab=
ly correct, so nobody implemented error handling for it. Not even in rte_me=
m_page_size().
> > Coverity detected the missing error handling, and warns: "Although rte_=
mem_page_size() is declared to return unsigned int, it may actually return =
a negative value." This defect applies to all functions calling rte_mem_pag=
e_size().
> > This patch adds error handling to ensure that rte_mem_page_size() only =
returns non-negative values, or doesn=E2=80=99t return at all - i.e. fails =
with rte_panic() - so Coverity is satisfied with callers not implementing e=
rror handling for it.
> >=20
> > It would be borderline waste of time fixing all the callers, so I fixed=
 the root cause to satisfy Coverity.
> >=20
> > From an higher level perspective:
> > This is a low level EAL function to determine the page size. I would co=
nsider it reasonable for such a low level EAL function to never fail.
> > If some O/S decides to not have a "system page size", and fail with "In=
determinate", e.g. to support multiple page sizes, we would need to handle =
that somehow. But let's ignore that until it actually happens, if ever.
> >=20
> > If you are skeptical about this patch 2/3 in the series, we can escalat=
e the discussion to the tech board. If you really hate this patch 2/3, I wi=
ll honor a NAK from you. The patch is not important for me; I'm just trying=
 to clean up.
> >=20
>=20
> In such cases, I look at glibc source and see if handles it or not.
> Looks like only used a couple of places there, the result of sysconf(_SC_=
PAGE_SIZE) is checked
> in one of the tests; but is not checked in the loading of locale's.  It e=
xpects a valid power of 2
> value there.
>=20
> Ok to just die if value isn't valid.

Yes I'm convinced too.


