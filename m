Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C242C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 21:44:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5091E40267;
	Fri, 27 Jun 2025 23:44:32 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 1168E400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 23:44:31 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 92D40EC01A5;
 Fri, 27 Jun 2025 17:44:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 27 Jun 2025 17:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751060670;
 x=1751147070; bh=YOjY256uRAdOjivdSel7OKdvwShHfrj5z01YWlJf3Go=; b=
 uu3JzFsSex0H0hgSQO4T+SNAjC6HQmVzWnI2EZbD//v+eGkbkGECVyBhHF82GEbg
 +SLlMzK+YkqQRKZRtFNDnaL0WIWiFIEX+k5dGAx2ROCKrBz4x/ElZfQ9pHf3W8DH
 XTrE1wtyMEcxAPpjIJ6tLtwKHD6Qs4L64oaBG70a98fuiSSiQIacCG2hxEo5Tq82
 B3dVLDLLfAFZgky/6GhHRrMPP2bVnc6VokpUjiWDG8dfWRlaYXLSUk4yoE2mkS4F
 ykFUQK8O5ntaIV1oj9CXseftLFGxiNWBJ97+72RkxiL61oBhVTwbH+D5E4lSQ+1D
 hzwCKBdOqanT0YqAVw7piA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751060670; x=
 1751147070; bh=YOjY256uRAdOjivdSel7OKdvwShHfrj5z01YWlJf3Go=; b=d
 LJIRs2344YD6RI2OJr1MsAR9E4/5fK9Nm0fVsEum62G0W9ucYUxvFaZv20tOqnIX
 e6u6z9EgIUaOYGIb/JqyZZ+AKT7bhpcPfqEbzz43lFfmiYNfukHYQrQHIIIv2iy7
 q8q4urnMynA6s70tc1B79bLIBk1zMaTCtJiSXERbbkqdVMB6/ds/kwYmNT5Yu9gm
 qJvDRrtp4Ydj27sGHKfNRfCWowda148nZLpM1hSmvvPf1w0P9QV+rnEDs5lQobsB
 osyOL+BzOg/CEoZ1Dezs/7OVRDDQ74RViGawKK/E4rnecDZOW9wUiVUqc8uQ/P8F
 ItynTHJSe7jRYCMJHWMUw==
X-ME-Sender: <xms:vhBfaJp0gLfzl9OZvyxYCAVeHorK6OxxD6kotSvj-U_tMvWZ3A7dEg>
 <xme:vhBfaLodYtzOV9asNHWAHGZuceqiPc0vDTRWUk9TUn5CJ2cTnTjxXn_6MKs4U3YN9
 x0EeQGZEnwpLDEZoQ>
X-ME-Received: <xmr:vhBfaGMcVKdjcgods5LWgqcG7s9HzU5vGQtj-Di57_r5QjZ9aZjatUreiXUzBeOKbkLApSwesXPCOmFFUqA2NklOzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddvleev
 jeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehpsghhrghgrghvrghtuhhlrgesmhgrrhhvvg
 hllhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehj
 vghrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopegurghvihgurdhmrghrtg
 hhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhgvrhhinhhjrggtohgskhes
 ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:vhBfaE50eBpeq9ZAKhoRNV8s9BrT8-vN2Km4k2Cqe1ARydnw97p1lw>
 <xmx:vhBfaI5d85V5wtrCiXeghphtEv7nH6-TwdrxgXf0rDc12cN7xjKZGw>
 <xmx:vhBfaMgFe2JpHz1moVB1iKEtLCsRDMCXVAZKmtr_QjahvvZDGPJt2A>
 <xmx:vhBfaK63kKzJAgX--1RWr0wCm_epPzsBCpWKwMj3getcrIzGoSPLOA>
 <xmx:vhBfaALuPA0F9jVXWqxtDHv0qKM1Eo_l17Z8ZHJOvKKrPaQmGj04MZMg>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 17:44:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 Jerin Jacob <jerinjacobk@gmail.com>
Subject: Re: [PATCH] test/event: fix event vector adapter timeouts
Date: Fri, 27 Jun 2025 23:44:28 +0200
Message-ID: <28522273.p16igRAIYV@thomas>
In-Reply-To: <CALBAE1NOg-1QSdSJ+s2SBHYBn06QAqUe4CrugnzLeHmDdvr1oA@mail.gmail.com>
References: <20250612001338.71098-1-pbhagavatula@marvell.com>
 <PH0PR18MB40860834C1DE674B225A0AB7DE7DA@PH0PR18MB4086.namprd18.prod.outlook.com>
 <CALBAE1NOg-1QSdSJ+s2SBHYBn06QAqUe4CrugnzLeHmDdvr1oA@mail.gmail.com>
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

27/06/2025 09:53, Jerin Jacob:
> On Thu, Jun 19, 2025 at 6:52=E2=80=AFPM Pavan Nikhilesh Bhagavatula
> <pbhagavatula@marvell.com> wrote:
> >
> > >Sent: Thursday, June 12, 2025 05:43
> > >To: Jerin Jacob; thomas@monjalon.net; david.marchand@redhat.com; Pavan=
 Nikhilesh Bhagavatula
> > >Cc: dev@dpdk.org
> > >Subject: [PATCH] test/event: fix event vector adapter timeouts
> > >
> > >From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> > >
> > >Update event vector adapter test to depend on service
> > >core cycles instead of system cycles when waiting for
> > >events.
> > >Reorder event_type check to make sure event received
> > >is a vector before dereferencing vector structure.
> > >
> > >Bugzilla ID: 1720
> > >Fixes: de09387f1313 ("eventdev/vector: add default software vector ada=
pter")
>=20
> Acked-by: Jerin Jacob <jerinj@marvell.com>

Applied, thanks.


