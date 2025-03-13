Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C85CC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 14:35:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45EFA40FDE;
	Thu, 13 Mar 2025 15:35:24 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 8577540150
 for <dev@dpdk.org>; Thu, 13 Mar 2025 15:35:23 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 232181140223;
 Thu, 13 Mar 2025 10:35:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Thu, 13 Mar 2025 10:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741876523;
 x=1741962923; bh=Gbxz8s3Tqdc0E0m3HaZBhYGGYdQ3hxsRB6OuyufzWIU=; b=
 oRAI+Za38Tt+KCz/XM7KFHd8zL5IjIxJpX7wdjrwgsOsXSIxZSHJecFku0JoN3nL
 ej1E2Jh4QLtYZnKiYNkjp5tofR/rk6DTMZrniEgwK1nz9gIhyjVachuZNGtEGIXF
 rW2xC/piAURIaKb4pjHriq1kqwhaDkbn2RKTCuIMWH4uqIZIiZV37mrzVjOlRBI7
 DlaYboChbqb8GgIeRJ33S0aeyX8ctSpALLEbcm6dhueqwMfXJBRiyrzxhrIOpPGJ
 O4F8iKOXhIE38ssIg4/u+aEQLRandld+OXUD6PKA0Ct+8vaFKx3XB6Y/+JBJKyiE
 iMtD3f6VeYXQLt8Vr5tvbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741876523; x=
 1741962923; bh=Gbxz8s3Tqdc0E0m3HaZBhYGGYdQ3hxsRB6OuyufzWIU=; b=k
 9TMHaogVsDQxkpGYCmKKuS8NvhyOPP4LXKIoYcJbuqwjWgecDVYDISA1J0ux3GRg
 fd57t/JSPUQ+GzVr5UjN+PerKrjSn8gCmZa0Sofjg8BjjL+wRhE07neLBgpG9o6a
 NQB2h4p7I0nLdXsV4vyVkvoXZV0EfL2/hVXgw1hIyoWL9VmGlzqbCWxKpkq639UU
 c7AosPEJzQSxztC0qvCVlzwE48b/cuuCmFQYlKkD3clbcW7ii0m0exZ6Dgz6TRJR
 F9Pn+v7uYUkjy7Y7Nuy0Ek8y7taUaCjkTeY55MNXzc6ojuqrl4Ee6odFQnHuKFP8
 Lw48WLN3OXVYJiL00udjw==
X-ME-Sender: <xms:Ku3SZ9P88LugM3ruTM3x_HzVF1Joy6PJnnJZ4Xzl231aXxjJvC_vnw>
 <xme:Ku3SZ_9TO93v51FjTJKL68FdFs8NYVnpzJwPgAsF9s9jEiuBLpZxgCg0AZ4UtD9GC
 TbENSmAopYyLExQFQ>
X-ME-Received: <xmr:Ku3SZ8Q1LgjtsBjmb9vbLOHKrmSBP8IFTCnC8PX0iFs_hQk0EBcti2jJQGKQWfOj_xSs64PqPQI707EEx-nK2Me5NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekvddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdej
 vedtheevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmsg
 esshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopegsrhhutggv
 rdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehsthgvphhhvg
 hnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopehrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhsoh
 hfthdrtghomh
X-ME-Proxy: <xmx:Ku3SZ5tojs3TpSN_85s_BnNLtGHPovbWTowaTwbOvbkd_x_OxL61TA>
 <xmx:Ku3SZ1eQxYz7DIgga7vEdly0gL9hfuBoMx8iiIWn5e6M7PK9owG8_Q>
 <xmx:Ku3SZ10753Ip-7BHHe4MJqkzzGiyY5Q_VM8BGtNmQyLZOQAFZRcDdw>
 <xmx:Ku3SZx9mI34HKjVnjm9abPP7a1GUflUWgpIIYMkPsLJg5BDzjL77Tg>
 <xmx:K-3SZ-Fmv9DUWmcjlfyEfGjuaBH_Ko2CMzFH4hs_oNh0RAxeNLTzcMLT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 10:35:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
Date: Thu, 13 Mar 2025 15:35:20 +0100
Message-ID: <3711940.zToM8qfIzz@thomas>
In-Reply-To: <Z9Kdpwgbs9a5sE8n@bricha3-mobl1.ger.corp.intel.com>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FAF6@smartserver.smartshare.dk>
 <Z9Kdpwgbs9a5sE8n@bricha3-mobl1.ger.corp.intel.com>
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

13/03/2025 09:56, Bruce Richardson:
> On Thu, Mar 13, 2025 at 09:00:09AM +0100, Morten Br=C3=B8rup wrote:
> > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > Sent: Thursday, 13 March 2025 00.02
> > >=20
> > > On Wed, 19 Feb 2025 15:55:17 +0100
> > > Thomas Monjalon <thomas@monjalon.net> wrote:
> > >=20
> > > > 14/02/2025 18:20, Stephen Hemminger:
> > > > > The Linux version of sys/queue.h is frozen at an older version
> > > > > and is missing the _SAFE macro variants. Several drivers started
> > > > > introducing the own workarounds for this. Should be handled in EA=
L.
> > > > >
> > > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > >
> > > > We may want to unify with lib/eal/windows/include/sys/queue.h
> > > >
> > > >
> > >=20
> > > Not sure, we have several options here:
> > >   1. Keep using Linux sys/queue.h and add enhancements in rte_queue.h
> > >   2. Make rte_queue.h a copy of FreeBSD version of queue.h (that is
> > > what Windows did)
> > >   3. Use the bsd version of queue.h.
> > >      On Debian/Ubuntu this in libbsd-dev package and referred to as
> > > bsd/sys/queue.h
> > >=20
> > > I chose #1 as simplest. But all of these could work. #3 means DPDK has
> > > least new
> > > code, but adds another dependency to the build.
> >=20
> > +1 to #2:
> > If Linux sys/queue.h is frozen, and is a subset of FreeBSD queue.h, #2 =
would consolidate all the queue macros in one file.
> > That seems easier to navigate (for a developer/reviewer looking at the =
macro definitions/implementations) than including sys/queue.h, queue.h or l=
ib/eal/windows/include/sys/queue.h depending on O/S, and then defining the =
missing macros in rte_queue.h.
> > A comment at the top of the rte_queue.h file could mention that it is a=
 copy of the FreeBSD queue.h file.
> >=20
> > -1 to #3; it adds an unnecessary dependency.
> >=20
> > >=20
> > > No matter what, should add to checkpatch to block any new files that
> > > include sys/queue.h
> > > directly.
> >=20
> > +1 to this.
> >=20
>=20
> I agree with Morten, #2 looks the best option to me too.

It means we want to remove lib/eal/windows/include/sys/queue.h, right?



