Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7A5C28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 09:35:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B48F8402CB;
	Sun, 23 Mar 2025 10:35:05 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id BB38E4028F;
 Sun, 23 Mar 2025 10:35:02 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 04C6E11400EF;
 Sun, 23 Mar 2025 05:35:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Sun, 23 Mar 2025 05:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742722501;
 x=1742808901; bh=kZv9uR3rn7oK/TFDlDRXgDgMASRXE/B0nY/evc6eKPg=; b=
 WRs8i63S0uxLMavQj40d9Isc/uAM9VgBZ0exhcaPhFe67aCdt3BXjmmb2j5GBVzw
 HQhGHfgGhwfTmdt5WvY0Ixyexa9eA3eJYcfJVgcdS0hds/BOlno6FLyqMQqRVVcz
 0UtO4IK7zBOSFWIYU50EZ7A+9NeiRZDRKpBXOaYfy9hmvHhNpoPC8L/t2ToV+FCo
 T4u2q4hpDXVrNuwc3m+gvVTIYrTK60xoC/jk7rQQv8oRvS4QhhiZST6F4eXGvMwb
 83zPlr8G1Fqx89VSNz1HIl4rYxQnbOp2co3Nw9nseYLoO4Ybzg8KvgILVVHntFWP
 LsMaX98nqLPYPyQdMjLifg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742722501; x=
 1742808901; bh=kZv9uR3rn7oK/TFDlDRXgDgMASRXE/B0nY/evc6eKPg=; b=W
 w0WA32m/O649evrD/MtAf087c5zrTKDTdKKWznhUkJhI1alT2RZi/odLNZzjrfLG
 5Z2dGlIbPWz68wwDVkbf3O8WpO4yuLDMUbjeAnhwgLLChqUmb2i5j8af2lmQ/hlv
 GoVZ3cRhB38YBjWiR2Nkuhl3nT5xm6nF2przb8+sXWFAbShF2s757zlLA8d2PNuk
 XJLF3M0EpqLkZv/BIqVOvJrPSTvdpVPc/M23SBZeNtoS8yCmYjULP0hyAocKRsS+
 RQPjCp2AEks/SdvpApEM1T/uZj86r18MoAdanJrqt7rdDwswqBtsk8PYluo5n3rv
 Oek+rQPujCF1gFTvQRZGw==
X-ME-Sender: <xms:xdXfZ8lTsl3GO0BoiVHI7vX1_p-EqpELzgr9WXvr9FQL2xqM2D7SLQ>
 <xme:xdXfZ71edu9v1djnZcQH6Tg-hsCCMqlHzsq8A83-on6awXKLFMOWYUPh08_PGLkod
 OXI6J_1mWcknL0ryg>
X-ME-Received: <xmr:xdXfZ6p8IIJ0k9KNR2IjX-gXjn5DPLl16p3dyfssNZY4T71YNLAynVYAd8dPhTnhrk9ExJ79mCE_FgU7R7RB4Yk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheeihedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdej
 vedtheevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrh
 hutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghv
 seguphgukhdrohhrghdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvsehinh
 htvghlrdgtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphht
 thhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:xdXfZ4k8cTVf6MLIn3H_NLNs1rRTS8OfiG6Ao0MZCKLc-4lIeXgKEQ>
 <xmx:xdXfZ62gKVasDIDYiQFlKGbbxKV2qtCYonX3U_VI8xQHKkBBd7JHYA>
 <xmx:xdXfZ_tzd7wSeYcHREdS7PPOHPrMfLCZy-i3FZYfEXhHH2L_4T74dg>
 <xmx:xdXfZ2V1EZnMa6W8hGN5aYVkEVNBzvLfI0r6Tjx5vjFjlNwNgAsFUw>
 <xmx:xdXfZ29Xa2tmQVfm6LGD_KSOKc8YxhWVVHH-QXIxAKYQB_BTYRcrCUhh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 05:35:00 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 stable@dpdk.org, David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v2] eal: fix undetected NUMA nodes
Date: Sun, 23 Mar 2025 10:34:57 +0100
Message-ID: <25090855.EfDdHjke4D@thomas>
In-Reply-To: <CAJFAV8xA-HK63XxSEYNZBTeghOUgtEEKTe=iBE4syCF_vsoKxQ@mail.gmail.com>
References: <20250305134720.907347-1-bruce.richardson@intel.com>
 <20250305162458.1059282-1-bruce.richardson@intel.com>
 <CAJFAV8xA-HK63XxSEYNZBTeghOUgtEEKTe=iBE4syCF_vsoKxQ@mail.gmail.com>
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

19/03/2025 17:31, David Marchand:
> On Wed, Mar 5, 2025 at 5:25=E2=80=AFPM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > In cases where the number of cores on a given socket is greater than
> > RTE_MAX_LCORES, then EAL will be unaware of all the sockets/numa nodes
> > on a system. Fix this limitation by having the EAL probe the NUMA node
> > for cores it isn't going to use, and recording that for completeness.
> >
> > This is necessary as memory is tracked per node, and with the --lcores
> > parameters our app lcores may be on different sockets than the lcore ids
> > may imply. For example, lcore 0 is on socket zero, but if app is run
> > with --lcores=3D0@64, then DPDK lcore 0 may be on socket one, so DPDK
> > needs to be aware of that socket.
> >
> > Fixes: 952b20777255 ("eal: provide API for querying valid socket ids")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> On the principle, the fix lgtm.

It is very late in the release cycle, but we have discussed it
and decided to merge this fix in 25.03.

Applied, thanks.



