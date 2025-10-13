Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33703CCD183
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 21:08:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B21C402A0;
	Mon, 13 Oct 2025 23:08:04 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 2294E40288
 for <dev@dpdk.org>; Mon, 13 Oct 2025 23:08:02 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3ADF67A039E;
 Mon, 13 Oct 2025 17:08:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 17:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760389681;
 x=1760476081; bh=VfB2emOgmBsUxlLtrCZrUrNEhWP9ldMNZaz/v4czHKw=; b=
 X1oiJbddotx4K/gwpTob9iaoZmla8gZm+9f6K/Dnuo/14z+N8CJpqmc1DN4vLJbv
 s7Idg+PnTVJg4cQrymCblGgT67pblv9QUiSUaUb9FzH6lqwDqGJS/71U3n2D1dNh
 KFftS2hdRZ9Y3XrPr8qliGe1YdL00cxK9TtxTb/dCJnuLaUKIbCKpFvR9pho86Ch
 qKj2r7w48hJjEmsoN37/BOvz36bAdM9FLf3eejSWhvt05db0UvFa5YcOMBQ1m1d+
 wQ1JBVDNgky/RjvnZZa90loJUWXEtJdsSLkU8OO0zORqYLVNR/7dNi1YkgB+AtwD
 2br1AL1xKtmsrFh9LvH9KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760389681; x=
 1760476081; bh=VfB2emOgmBsUxlLtrCZrUrNEhWP9ldMNZaz/v4czHKw=; b=h
 oUM8o80R+cLeC0veyKuh5Hex4N1qzKqeXEVB/T4Tx3OO2trusX49eS8NPqGP8T/w
 d4Wa8F3KWXIGHGhKomasRJWa0skjFxN0n7lXM7ZDAoVjhf8SAF3tkM/KdqJPdkjf
 bTqga1cWEPvpJtvF+OA1s1keGQ5viUySe1A36O8P1+SMzWWbiR2M8Kta6PO+qsxY
 K7O0vr3CGs9wv50NR9eJONOw9ovEA7XCsyMQ2CA3nzdbJAv+qqEXg8VIFQbU/cbh
 P9wrNzl/J8D3zagraEkJm/9cCYxhgv8iU6EjZ85EehpDddaY7/Mni4dNEifKwEvv
 g365tdoMRxDYwoUGA1kFQ==
X-ME-Sender: <xms:MGrtaGJ4La-q20RTisgzKzPOgovUrNpck3vPupmnudj1CgVjoDffcg>
 <xme:MGrtaHGn2Gp79ReeYHPp3tzCEhQ-_54MnQT6uDP5vqnMHvIaJCRoa5EfEnjKKr8m5
 oa2j_CDHXMzq4Eem5Fo2UbkDTDmyUdo60TgPgR8WfINTKpuSPsplw>
X-ME-Received: <xmr:MGrtaCQZFNXO7gzNxZBM_liaFAAmij-_33Re9N9pXjSKEGl5fXb26KxqrTaKVG11F83E7YD4S1FVwb7CQVgUxrEdmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekieelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpefgfeeftdevffffueeiueelhedutefgfefgfeelteehkefgiedvieeu
 geevfeffueenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghl
 ohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
 htthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthho
 peguvghvseguphgukhdrohhrghdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguih
 grrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguihgrrdgtohhm
 pdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpd
 hrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:MGrtaLdNxiSyS_iz6XDkdxT5kkzjiN6yJu4-944txE84F1ndPuSoUA>
 <xmx:MGrtaJrbuHE4z2l-UkDN9hxESNqzcJqk5sf3oEwn7mH3KM6BK8JSqQ>
 <xmx:MGrtaE9M52LcxUPYRyKDFr-8Dwxsug4wyMlriF8gU-AdrIGN_LL4EA>
 <xmx:MGrtaNdGVCww2yi8_3EinZimoo9PT38v2HKpm9saY5XNT-GnsQQkwQ>
 <xmx:MWrtaL09cx9-bEtWd2Q2BZEfW_p3n_-YVf_uiNWDjTY8OW2u5mK5pjbZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 17:07:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Shani Peretz <shperetz@nvidia.com>, viacheslavo@nvidia.com, 
 bruce.richardson@intel.com, stephen@networkplumber.org
Subject: Re: [PATCH v3 2/5] mbuf: record mbuf operations history
Date: Mon, 13 Oct 2025 23:07:57 +0200
Message-ID: <17796909.geO5KgaWL5@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654C1@smartserver.smartshare.dk>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <40546840.10thIPus4b@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35F654C1@smartserver.smartshare.dk>
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

13/10/2025 22:08, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Monday, 13 October 2025 20.39
> >=20
> > 02/10/2025 09:37, Morten Br=C3=B8rup:
> > > > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump_mempool,
> > 25.11)
> > > > +void rte_mbuf_history_dump_mempool(FILE *f, struct rte_mempool
> > *mp)
> > > > +{
> > > > +#if !RTE_MBUF_HISTORY_DEBUG
> > > > +      RTE_SET_USED(f);
> > > > +      RTE_SET_USED(mp);
> > > > +      MBUF_LOG(INFO, "mbuf history recorder is not enabled");
> > > > +#else
> > > > +      if (f =3D=3D NULL) {
> > > > +              MBUF_LOG(ERR, "Invalid mbuf dump file.");
> > > > +              return;
> > > > +      }
> > > > +      if (mp =3D=3D NULL) {
> > > > +              fprintf(f, "ERROR: Invalid mempool pointer\n");
> > >
> > > Should be MBUF_LOG(ERR, ...), not fprintf().
> > >
> > > > +              return;
> > > > +      }
> > > > +      if (rte_mbuf_history_field_offset < 0) {
> > > > +              fprintf(f, "WARNING: mbuf history not initialized.
> > Call
> > > > rte_mbuf_history_init() first.\n");
> > >
> > > Should be MBUF_LOG(ERR, ...), not fprintf().
> > >
> > > > +              return;
> > > > +      }
> > >
> > > Since the type of objects held in a mempool is not identifiable as
> > mbufs, you should check that (mp->elt_size >=3D sizeof(struct rte_mbuf)=
).
> > Imagine some non-mbuf mempool holding 64 byte sized objects, and
> > rte_mbuf_history_field_offset being in the second cache line.
>=20
> <feature creep>
> You can check more properties of the mempool to identify mbuf mempools, s=
eeking inspiration from the RTE_ASSERT()'s in rte_pktmbuf_pool_init():
> https://elixir.bootlin.com/dpdk/v25.07/source/lib/mbuf/rte_mbuf.c#L35
> </feature creep>

I'm not sure what we can use to identify mbuf pools.
Anyway I suggest doing such optimization later.

> > > You might want to log an error if called directly, and silently skip
> > of called from rte_mbuf_history_dump_all(), so suggest adding a wrapper
> > when calling this function through rte_mempool_walk().
> >=20
> > Yes good idea.
> >=20
> > > > +      mbuf_history_get_stats(mp, f);
> > > > +#endif
> > > > +}
> > > [...]
> > >
> > > > +/**
> > > > + * Mark an mbuf with a history event.
> > > > + *
> > > > + * @param m
> > > > + *   Pointer to the mbuf.
> > > > + * @param op
> > > > + *   The operation to record.
> > > > + */
> > > > +static inline void rte_mbuf_history_mark(struct rte_mbuf *m,
> > uint32_t
> > > > op)
> > > > +{
> > > > +#if !RTE_MBUF_HISTORY_DEBUG
> > > > +      RTE_SET_USED(m);
> > > > +      RTE_SET_USED(op);
> > > > +#else
> > > > +      RTE_ASSERT(rte_mbuf_history_field_offset >=3D 0);
> > > > +      RTE_ASSERT(op < RTE_MBUF_HISTORY_OP_MAX);
> > > > +      if (unlikely (m =3D=3D NULL))
> > > > +              return;
> > > > +
> > > > +      rte_mbuf_history_t *history_field =3D RTE_MBUF_DYNFIELD(m,
> > > > +                      rte_mbuf_history_field_offset,
> > rte_mbuf_history_t *);
> > > > +      uint64_t history =3D rte_atomic_load_explicit(history_field,
> > > > rte_memory_order_acquire);
> > > > +      history =3D (history << RTE_MBUF_HISTORY_BITS) | op;
> > > > +      rte_atomic_store_explicit(history_field, history,
> > > > rte_memory_order_release);
> > >
> > > This is not thread safe.
> > > Some other thread can race to update history_field after this thread
> > loads it, so when this tread stores the updated history, the other
> > thread's history update is overwritten and lost.
> >=20
> > You're right.
> > I suppose this change was to align with the atomic read operation
> > done in the "get" function.
> >=20
> > > To make it thread safe, you must use a CAS operation and start over
> > if it failed.
> >=20
> > By "failed", you mean if the previous value returned by the CAS
> > operation
> > is different of what we used earlier to build our new value?
> >=20
> > I suggest this:
> >=20
> >     rte_mbuf_history_t *history_field =3D RTE_MBUF_DYNFIELD(m,
> >             rte_mbuf_history_field_offset, rte_mbuf_history_t *);
> >     uint64_t old_history =3D rte_atomic_load_explicit(history_field,
> >             rte_memory_order_acquire);
> >     uint64_t new_history;
> >     do {
> >         new_history =3D (old_history << RTE_MBUF_HISTORY_BITS) | op;
> >     } while (!rte_atomic_compare_exchange_weak_explicit(history_field,
> >             &old_history, new_history,
> >             rte_memory_order_release, rte_memory_order_relaxed));
>=20
> Yes, that was the thread safety concept I was looking for.
>=20
> Small bugfix: rte_memory_order_relaxed should be rte_memory_order_acquire=
 (when the CAS comparison fails), like when first loading old_history with =
rte_atomic_load_explicit().

OK thanks.

> Also, consider adding unlikely: "do {...} while (unlikely(!CAS(...)));".

unlikely because it happens only for cloned mbufs?


