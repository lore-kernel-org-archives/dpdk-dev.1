Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C7CD37AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 13:00:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96517402D9;
	Mon, 11 May 2026 15:00:47 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 895D9402D5
 for <dev@dpdk.org>; Mon, 11 May 2026 15:00:45 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id BB79B1D000CB;
 Mon, 11 May 2026 09:00:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Mon, 11 May 2026 09:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1778504444;
 x=1778590844; bh=jOMAER0X6Keyf5QLRQqkjaLXJjSfMgKtKzNAYUhEWKQ=; b=
 Kbui8Paw1e82KhvRbtlavOr10RdciruXrSX+yp+BVlnbeqNbKy4hC50xkjk5MKb9
 Gzw9BIDxOYHRJeIaBEuO2NlMgMjuQq3BxQ9yuEwN5lROZpRR1XqsoVJff3k7L4co
 hn/RiW0+u4Nh0vb4VugDl3OFfxCIC+srbfAOE5dxoBa9a41GlB/gmXAKIwbNdaHZ
 WCWsOcwLuX55gutIVFEOrvVjRGdDdFKiGuSiKLWCbaUFYtdluPf0DhqmGe6wUWX2
 fAKVox+7HiqEz7XZcSN4Lkdx64cU5X/m29AqnElBJNporTpRP36uVa81ERS0Ow9L
 HpJeC2OUgyQe0DNZN6IViQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778504444; x=
 1778590844; bh=jOMAER0X6Keyf5QLRQqkjaLXJjSfMgKtKzNAYUhEWKQ=; b=Y
 njSUY3VZyF5dUjvbaZtsTLo6DJU/HTWVWqlyYj+YOE11R1/FNTRU85IZNeI2Abta
 FeWNrE0JVkgpCxKFNwrMI2TKtZOlq0AC1iz4sP97rUQwcOZgyHeYwYeNOpFX5LSN
 mg/LZQIE4pp9LyFgtIf5Ptuo5zf1f25J3986UtNwzwO7h/2T8B8KUyry8vNZlpAN
 AIkYTJG32RBs6kMJL2QaFQUL0hZwGrhl6H1sEAeAVJnP2Jiwqk879g7FI5aB50Yr
 KBBTJbYAdn9HwWols9yLYsMWhLw1cAlceLzEPMK7PA9fbTgOCSfEq7sogjNPONvS
 SfG4yoJ1SCvb2Q0I1w+rA==
X-ME-Sender: <xms:_NIBajGeDnwEjIEgftiQfJIu-lx1nRebKkeFRat6H4jUUl0WUIKWfw>
 <xme:_NIBaspNMAkidcIKrCyOFE7vnTifE7mlGNxCDPiKvdqt7oW24ZjuDONdO31n22jIP
 XowUt7quMTBBLp2cUXn6ShO4bTp4C4x73WXphD99P8fB3fvTwa8SUc>
X-ME-Received: <xmr:_NIBan6kq0CI9yCoB3VfP3TxotrLocT1FxmmgTdr0da1LYSneurrXO4FOV9mMVVfP-Mo4KPHFo6cyg2G_fjh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekleelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpefftdeuhfehvdekleelveffvdelhfelhedvgedtvddvudeuieevtdfg
 jedvudegfeenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtohepuggv
 vhesughpughkrdhorhhg
X-ME-Proxy: <xmx:_NIBai7dmX8Md9mU0gaUZPEGxJ59iUKnE89FpQ-O0TWwNbtdaoBNvw>
 <xmx:_NIBasF2649vuotiT2Z-fH2qqlgXNMyGZNAjjC66qkubi9iLRCWHKQ>
 <xmx:_NIBajQ_udP7a3vmeBpL7oKdHgiCjkDlf4wvIiXKlHkr1tJ0-eL9_Q>
 <xmx:_NIBatseX9rA5b2aS2amN9ziHbH3BjiaGnTS9VkCC71VM8DHuvQOuw>
 <xmx:_NIBaum9Re87HTjxnXZuUCjwj1UZn94--l8CEfYC032KZZ0jLOOawCZI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 09:00:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: add link to mbuf layout history
Date: Mon, 11 May 2026 15:00:36 +0200
Message-ID: <MytLSAGsRfqGQpE8fyv5ow@monjalon.net>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657D8@smartserver.smartshare.dk>
References: <20260407080544.614206-1-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F657D8@smartserver.smartshare.dk>
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

07/04/2026 10:44, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Tuesday, 7 April 2026 10.06
> >=20
> > In order to illustrate how mbuf is kept small,
> > add a link to a page showing the mbuf layout for each version.
> >=20
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> >  doc/guides/prog_guide/mbuf_lib.rst | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/doc/guides/prog_guide/mbuf_lib.rst
> > b/doc/guides/prog_guide/mbuf_lib.rst
> > index 382bfbdca4..97f8e72356 100644
> > --- a/doc/guides/prog_guide/mbuf_lib.rst
> > +++ b/doc/guides/prog_guide/mbuf_lib.rst
> > @@ -8,11 +8,12 @@ The Packet (MBuf) library provides the ability to
> > allocate and free buffers (mbu
> >  that may be used by the DPDK application to store message buffers.
> >  The message buffers are stored in a mempool, using the
> > :doc:`mempool_lib`.
> >=20
> > -A rte_mbuf struct generally carries network packet buffers, but it can
> > actually
> > -be any data (control data, events, ...).
> > -The rte_mbuf header structure is kept as small as possible and
> > currently uses
> > -just two cache lines, with the most frequently used fields being on
> > the first
> > -of the two cache lines.
> > +A ``struct rte_mbuf`` generally carries network packet buffers,
> > +but it can actually be any data (control data, events, etc).
> > +The ``rte_mbuf`` header structure is
> > +`kept as small as possible
> > <https://doc.dpdk.org/struct/mbuf/history.html>`_
> > +and currently uses just two 64-byte cache lines,
> > +with the most frequently used fields being on the first of the two
> > cache lines.
> >=20
> >  Design of Packet Buffers
> >  ------------------------
> > --
> > 2.53.0
>=20
> Hadn't noticed that illustration before, so good idea linking to it here.
>=20
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied


