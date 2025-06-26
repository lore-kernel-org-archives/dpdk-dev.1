Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10A7C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 15:16:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECC6B402DE;
	Thu, 26 Jun 2025 17:16:15 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id C94F940156;
 Thu, 26 Jun 2025 17:16:13 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 751DAEC01D4;
 Thu, 26 Jun 2025 11:16:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 26 Jun 2025 11:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1750950973;
 x=1751037373; bh=D5ec2uLLbisQOlbEb/p3sY1hqIiCL2UeJJAdmTQOjWI=; b=
 iHUHngk8aCo9x2dudec/Btt9ck6IIRfD660iTm8ILiMN/QVTUuPEFelF35JAgR6w
 zBcvmP2otE86tHUteKmYGxNVBMr1CR+uUjLFqSExo0m4wdlB/ZWYP+Zr8gC6fHun
 J5YlRxzqbmAzjZSrRSxHZS9nPqhjHpju1WMU2d6TfupoV/9Ay4oV41NTdyjlP4/O
 jUBeYug/g5FD2s0KoTvetQQPIoY1sN9edmYXeSHVEFj1mJeS1xLJTNN3Bz9nRlKr
 Vp/Kem8DsXx2ql8N27wK5zyifGq4CRuZt0vBk91ht8QEYfPPnJe8kZ0QQPw7+XcW
 f5/+Oz8++gh/YTKCmTv1+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750950973; x=
 1751037373; bh=D5ec2uLLbisQOlbEb/p3sY1hqIiCL2UeJJAdmTQOjWI=; b=C
 Ehcq9dbmXmPZrXBVN3vkYK0EQz+gN23Ft7J3Zk4RDNwGyC46HTnZc6JKHCYdGB+F
 B9o+oexnbpOQiRnUEefPZEYq5KaO99ZjPwRXHy60PXT7+Rs2R14ya4LXvS55W2vs
 +NeM8P8MqD7bisQDXmVvKwiAbqpNsmHfai1r+cikXdinM/O0VdZj4q2RW27GIRYo
 oLlXa4ML1PpeXyURJmehPvNRmX3QDzr5HSU7D810wn0gMYUBcLpOE5Uxppsbpvzo
 iJBvEiwPKDIzkIHbXfS/NJYYGt3lyTuFsDAR+Gh7W72IAfD8yFBng43jcVWJtu/v
 Hc/WFTPvKmDoyZOGI+EuQ==
X-ME-Sender: <xms:PGRdaGKDy8NAvltZPpK7UKLHi_D-YSb7AMbpNvvYZueBHrT4nG4c9g>
 <xme:PGRdaOIY_5fBjay8FuqhxZyOpj6xDbMNHifiy3qxmE8hKpoaNLLd8-FEnqLjDB9Qr
 Vxidpq3GfI4LdeGow>
X-ME-Received: <xmr:PGRdaGv8sMtcPzbYXgMY2S7QgLua3Lv2EvRea1Tr75k2peP0ylboQBlwzHQ0R9G9MeSYkSbnXqP2X_PbqHUoY9g7qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepffdtuefhhedvkeelleevffdvlefhleehvdegtddvvdduueeivedtgfejvddu
 geefnecuffhomhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
 gvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehmsges
 shhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopeguvghvseguph
 gukhdrohhrghdprhgtphhtthhopehtvggthhgsohgrrhguseguphgukhdrohhrghdprhgt
 phhtthhopehtughushiihihnshhkihesmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:PWRdaLYHq34jsHINe_tlHiyJbHVQMHBy86qtxKugsEQx80VHS0gAlA>
 <xmx:PWRdaNaQy8OKjePrAc2yFLW5ipz-nylOuch4bm4o-OU8Ii9x3nnMAQ>
 <xmx:PWRdaHCL-9t6JkQgH4DSXi_TnFXUW0mjhnd--uJwkNtHZOunPVbJfg>
 <xmx:PWRdaDaQPsdSNmX3HjylzwdpYvjprR5BKrAcI-INhMTTIH-RD12oHA>
 <xmx:PWRdaP7zfYw8UHnwhTNskK3mMNBTxaaUmaeZmSwgRVA5XoRPum61PKbU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 11:16:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, dev@dpdk.org, 
 techboard@dpdk.org, Tomasz Duszynski <tduszynski@marvell.com>
Subject: Re: DPDK libs as one big shared object
Date: Thu, 26 Jun 2025 17:16:10 +0200
Message-ID: <6044178.qgXdJBQaxk@thomas>
In-Reply-To: <20250626055319.1ef24c96@hermes.local>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD01@smartserver.smartshare.dk>
 <45747073.doPnVEEUbh@thomas> <20250626055319.1ef24c96@hermes.local>
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

26/06/2025 14:53, Stephen Hemminger:
> On Wed, 18 Jun 2025 12:01:45 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
>=20
> > 18/06/2025 09:39, Morten Br=C3=B8rup:
> > > > Why are we still building one .so file per DPDK library, instead of=
 just
> > > > building one big dpdk.so for all DPDK libraries?
> > > > I think it's legacy from when DPDK libraries were versioned individ=
ually, and
> > > > thus not relevant anymore. =20
> >=20
> > I think it helps with selective packaging.
>=20
> That only impacts disk space. The linker is able to only load what is nee=
ded at
> run time. It was a choice made in the build process. Not sure if was the =
right one
> most other projects don't have so many libraries to worry about.
>=20
> >=20
> >=20
> > > > Wouldn't building one big dpdk.so eliminate the problems with circu=
lar
> > > > dependencies between DPDK libraries?=20
>=20
> Yes is why most of the big Gnome and KDE libs are all one shared object.
> =20
> > >=20
> > > Obviously, the source code should remain organized as individual dire=
ctories per library.
> > > I'm only suggesting linking them all into one object, so any DPDK lib=
 can call any function in any other DPDK lib.
> > >=20
> > > Perhaps only the core libs or always_enable libs should be linked int=
o one object.
> > >=20
> > > Here's an example benefit:
> > > I'm currently trying to convince the PMU lib author to make PMU depen=
d on EAL [1], so missing error handling of sysconf(_SC_PAGESIZE) can be in =
the EAL for all uses, instead of copy-pasting sysconf(_SC_PAGESIZE) error h=
andling to everywhere it is used.
> > > But this is difficult with the dependency chain for the patch adding =
PMU to Trace: Trace depends on PMU, and EAL depends on Trace, therefore EAL=
 depends on PMU.
> > >=20
> > > [1]: https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35E9FD0=
8@smartserver.smartshare.dk/ =20
> >=20
> > I don't see a problem to copy-paste in the few libs not depending on EA=
L.
> >=20
> > The real solution for EAL dependencies is to split it more.
> > The malloc, init & logic part should be in separate libraries,
> > depending on the real low-level EAL.
> >=20
> > Then all libs could depend on the low-level EAL,
> > and avoid copy-pasting.
>=20
> There have always been two overlapping targets.
> Embedded standalone and standalone network appliance , where building mor=
e than is needed is a nuisance.
> And distributions which need to turn on everything

I heard distributions want to be able to not package some parts.


