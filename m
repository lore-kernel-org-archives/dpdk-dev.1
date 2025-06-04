Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F73C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 11:39:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4245D402D8;
	Wed,  4 Jun 2025 13:39:25 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 28C574029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 13:39:24 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 4B39811400BD;
 Wed,  4 Jun 2025 07:39:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 04 Jun 2025 07:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749037163;
 x=1749123563; bh=pMoBaag9bWPGhC9++pm1U4wuapL4SAHmj/8W/285AC8=; b=
 b2Q59ZHSy5ng2qfkODl++GPRsXr3Jvk/5wFghE/zDgAGOHq3dUn7Hx+Z+jWWwUrS
 REGkD0A5vHuZqbDVXXkByKrPPTjLrq75Lewk6qMnYWRQNUsPlcBYCZpiUNWW8u5J
 Ll/kyqIDp1uKjVSfR7f3bjAotJNKr9uiXsCo2rw6+6C2Zsv7Yhu1gerGT45reWOK
 hHsPt6Q6wrvwAuedxeZYTG+hKtqjWCh7e9peqkRfRsE8JVgTauxe/2Clu9NXgxI7
 flcdHP5huSvmgBG1NQCynpmkIg/H87aQ09swdOKz+SJkBxecNGZn2zv7/847Cjzr
 vy/DwVk5c+9EpRIBkJvRHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749037163; x=
 1749123563; bh=pMoBaag9bWPGhC9++pm1U4wuapL4SAHmj/8W/285AC8=; b=W
 UU+3zkmIgGDWdHOVMGxbbcurt8EkQ+S4nw/HJMH1OyUokvqf4tAXhTNcYB9hLjUS
 x3kllvbioBfOiMlGZ6CGRfMANM55fExDHnxGnHxCOasvCg9HiV76v0BcdsmHAwQK
 Kdkuf3m3CZbuPzKo5GXETHmSCbSG3/PM1bFyGL2igOB7fglKH8vW7bhFH0zN6KSX
 hPdfEqBcxsN4x2PFqH3Nc9I1pFgu+L9+KUh4FGYLrbVbmFrXERBaWQffAB9BUcL+
 fNZ3DlOyYllNkyIvgBYSqChwf3IDgW1f0pHydf7azWr3GWP/350OL74UMyokv9k/
 M/GISFWH15C/+OHhm7gvA==
X-ME-Sender: <xms:ajBAaDVi7IVsmiUX4nUKoMr6DWpMA8n-REUU3j8EewGeKe_wMp9AZw>
 <xme:ajBAaLmKsyyTHtF4qdYZyZ_MP7eKDopxjHCrMyRKzV_cNQBY-Ejj1uc8ClJAfwUuf
 h1zZv2W96iZj9fZNQ>
X-ME-Received: <xmr:ajBAaPaeAJ-cm91fhUfEk3W-Orz3kM9Ik3rgFJaFOnWFSBFa3o6AHKn7O3UDejHQqJmWOj8gqJ8iS3s57wy8mDkibA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvtdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedt
 heevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvih
 gurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgssehsmhgr
 rhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtoheprghnughrvghmuhgvse
 hlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepuggvvhesughpughk
 rdhorhhgpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrd
 horhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgt
 ohhm
X-ME-Proxy: <xmx:ajBAaOUewGXvRyhBimkooXbTKgcFWU2coOlFEaZqiZGfSDEIXV-YXA>
 <xmx:ajBAaNmp7jsc-HrKH8sEoQlnQzLMt7cgrtPCSiqOcbY3LCnhMPJx3g>
 <xmx:ajBAaLfjKTSQ-zMbByYD9zBTxtTCZHArKM-em372MAslrEFq87nlag>
 <xmx:ajBAaHHwvekzhhYh-fsCHl0s6Ji95zTRtRoJZfCjHsYrUXpfsaJ7Tg>
 <xmx:azBAaGJFSlsT4Jorv0ZF4W_Se02ojgdJYfEiUFi1mxHijGfrcFhz5lWp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 07:39:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v5 0/3] add portable version of __builtin_add_overflow
Date: Wed, 04 Jun 2025 13:39:19 +0200
Message-ID: <3992237.PYKUYFuaPT@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FCC0@smartserver.smartshare.dk>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8wboVDP8fp=CyQwi6nD7bbu11RjBa35un5yr0faAp2i1g@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCC0@smartserver.smartshare.dk>
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

04/06/2025 13:04, Morten Br=C3=B8rup:
> > From: David Marchand [mailto:david.marchand@redhat.com]
> > Sent: Wednesday, 4 June 2025 12.41
> >=20
> > On Wed, Jun 4, 2025 at 12:29=E2=80=AFPM Morten Br=C3=B8rup
> > <mb@smartsharesystems.com> wrote:
> > > > I am not a fan of adding such public API, an internal API would be
> > > > enough.
> > > > Do you plan to add more helpers for math operations?
> > > >
> > > > For the current helper, the only user is a driver (base code).
> > > > Can't we just wrap a __builtin_add_overflow (under #ifdef msvc) in
> > the
> > > > osdep.h header?
> > >
> > > We already have public APIs for bit operations in rte_bitops.h.
> > > This math API follows the same principle; and math operations - just
> > like bit operations - might be useful for DPDK applications, so let's
> > keep it public.
> >=20
> > This comparison is poor.
> >=20
> > There are many users of bitops in dpdk, and *public* headers needed it.
>=20
> I don't think the number of uses of a generic function should determine i=
f it should be public or private.
> The important thing is avoiding copy-pasting.
>=20
> > Here, we have one single function in a driver implementation.
> > And this code is unused (__builtin_add_overflow -> check_add_overflow
> > -> ice_get_pfa_module_tlv -> ice_get_link_default_override ->
> > ice_cfg_phy_fec, with no intree user).
> >=20
>=20
> I'm mainly saying that Andre is doing nothing wrong here;
> it's a matter of setting the bar for making generic functions part of DPD=
K's public API.
>=20
> In this particular case, I don't have a strong opinion on how public the =
new function is.
> Putting it in some generic private header is also perfectly acceptable fo=
r me.
> Just don't put it directly in the driver; that would lead to copy-paste i=
nto other drivers.

We can move it as a public API later if there is a real need.
I don't think it is good to rush on adding new API in general.


> > > The only issue I have with these (incl. the bit operations) are that
> > they are in the EAL library, although they have absolutely nothing to
> > do with hardware or O/S abstraction, so they really should be in a
> > "utils" library.
> > > But that's another story, so let's not burden Andre with that.
> >=20
> > Orthogonal to the question.
>=20
> Partly, yes.

EAL is also good to abstract compiler differences.
I agree such basic stuff should be in EAL
if we would decide to add it.

> But if we had a generic "utils" library, there would be less resistance
> to adding the new function there than there is to adding it to the EAL AP=
I.

It would be the same.
An API is supposed to be maintained forever
and give guidance on what to use.

As a conclusion, I agree with David, it is safe to keep it private
for the unused base function for now.


