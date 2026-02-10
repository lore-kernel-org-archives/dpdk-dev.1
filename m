Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55908EA813F
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:57:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 900C640658;
	Tue, 10 Feb 2026 16:57:43 +0100 (CET)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id B90ED40608
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:57:41 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 826381D0018A;
 Tue, 10 Feb 2026 10:57:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 10 Feb 2026 10:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770739060;
 x=1770825460; bh=EQ8NxreHjDr998ZS0UJAMiqICaOXWybWwhuA+nx4lYI=; b=
 Y+wF4cxDErEbV1PS1zgUdycueqdHAU1fn6qJQig/qbxTq2tRn9DKYKVzt+I5UeVE
 hpqidjzDEOBhd7qvi8JJC8yiaRwQNne3Y6TQOzuFSqPBmCLG/kMLTLTBU4jg2cXe
 QpWuZ1I0Yyv7jBYalcbQ/18VxG5xQ4zY+LucMhAeSmlyBsYE6eE0nslN2qwjJ5eG
 XqxuOMq7PfKO0p90rmk5imGHaPKgkG+TLb+bQm/zkJlb/NgfoD34OnDGlJZWMfQY
 WHcWf/WSisoN0CD/oYSdSIfOMXVcEgj+XlS/GdKlZjdDfUA2dGTp84Qcri/I+SHX
 boGm1gm3vEbvuC6bLUBuUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770739060; x=
 1770825460; bh=EQ8NxreHjDr998ZS0UJAMiqICaOXWybWwhuA+nx4lYI=; b=F
 izqfZ9s4PQsF+9BoLi0Z1jI3Zt8zZ4Iv5Zy91wDctyWZkaz9pY/UOW2D1PF/a95W
 W9gkCB4K5JTMCq3UHSs9aQkoL7ymMungGk9wy3epui4z6eatM+RPta1k55VenTJI
 tKjvVPcxQ7q1XcgJ/SqZ9vcPVWcIGDEKBsjdw+wOYHwxi00hycT5xttjajxO2UDl
 iHBYU9+nNgTA+o2aEBR9iq9Ela5Fod7pBaxTcAI+VgbdC5Q1Cko+n5TXJ3YmNFJa
 zZ+WucRDEnN6U5USzR6Sdct11TgSx2KCImkJMX5KG781lHNhehAx4TP16EpMMORP
 m3YSFcN/SUiTSedhYeL2A==
X-ME-Sender: <xms:c1WLaQBDyimbu2yD6w6ytWG5OJM_E4maqHUPY2y7uLG64G_rZa4Arw>
 <xme:c1WLacI55SIFChBpsApBLXtC5jeH_1HrytcR9hWVl3_TaLjd53FuIMnn3oIXyUrPz
 2RMBxmT23rm9CccKbvzbsZadeCJcWTXdMy-qmahYxyniV6xVobXdzs>
X-ME-Received: <xmr:c1WLaTnbJ_pcQjP9NijAeM6nEigakwLmqYIfTxp4B-ojUTd1GMZbsFKlgEIJ2tCR8ONOgNmVS5-fkykLB34Obqciaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtuddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:c1WLaaGV9wyjdq8JYGsgiCTZoiaSjt3N8PU1p0r1-ZSWsvMUm4CN9g>
 <xmx:c1WLaTHfD20ttcP0W_JC4oi9B7JB1_F531_qkNyjkDhLqz6OfHXu1A>
 <xmx:c1WLaXOJ1VuOUazQL79AKKb74hMB7OclMKJ-w9F9DLqUmuwIWuItEQ>
 <xmx:c1WLaSFZ_m1zsyvn6y9SUzZQy7cEujWJvZ8WACumr8v5Avy_oXDFkg>
 <xmx:dFWLad-vnCxpBTfQZw1ShNasw9pSnd0r1_ldLtQI9UUH5NjIwdZNipkV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 10:57:39 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] mbuf: optimize detach direct buffer
Date: Tue, 10 Feb 2026 16:57:37 +0100
Message-ID: <3780603.PYKUYFuaPT@thomas>
In-Reply-To: <aVuTD6Ex9k9kXxMu@bricha3-mobl1.ger.corp.intel.com>
References: <20260103174054.121246-1-mb@smartsharesystems.com>
 <aVuTD6Ex9k9kXxMu@bricha3-mobl1.ger.corp.intel.com>
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

05/01/2026 11:31, Bruce Richardson:
> On Sat, Jan 03, 2026 at 05:40:54PM +0000, Morten Br=C3=B8rup wrote:
> > When rte_pktmbuf_prefree_seg() resets an mbuf about to be freed, it
> > doesn't write the fields that already have the required values. This
> > saves a memory store operation when all the fields already have the
> > required values.
> >=20
> > This patch adds the same optimization to __rte_pktmbuf_free_direct(),
> > to improve the performance for freeing a direct buffer being detached f=
rom
> > a packet mbuf, i.e. saving a memory store operation when all the fields
> > (of the buffer being freed) already have the required values.
> >=20
> > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > ---
> >  lib/mbuf/rte_mbuf.h | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.


