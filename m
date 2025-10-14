Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C33CCD18D
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:03:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBEE5402D3;
	Tue, 14 Oct 2025 14:03:54 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 187BF402AE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:03:53 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 3184E1D0018E;
 Tue, 14 Oct 2025 08:03:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 08:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760443432;
 x=1760529832; bh=AASZwc9vrDkdbVXX00DShYMPOPV68VwcZmgfmwfgwoA=; b=
 RDogaAE0YoZHDDdC/zU0p0ro/M7MYUljzP/aqTzKBiEK0BmHbJvwkMAYJCaTdOLM
 xw7q8rIxgFyqA6EmGVHvMsx1hGNRz94u9gkadPFRvC/Lv/DjEffSe4vfaXOb7DDl
 qEJ8Epvsfbwnf8yOpHmpT5sv/UF3oZBYBDmnJfoH22WdTOTiW5Qj2q0NPtELJZX3
 gI3ViqBIUwXqnaRpGYfmBxzat3dPMTwIREzIPajsPSVIfA1v55OHQuUTFcKGonjI
 Q0n1uEjg9m0mNM+7OUbH5skZ+sPalx2L6C9SwFwwpEFvkwSlLMV3rzHDHXKEo6tg
 AUnOIqmJo1RvbT2xJFtl7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760443432; x=
 1760529832; bh=AASZwc9vrDkdbVXX00DShYMPOPV68VwcZmgfmwfgwoA=; b=M
 aO6QdRbQIP1hykqgw2xUnVau6kt1dckpjrxaTPke6toN1p+EZWKWxtkEnmpzI38X
 a6DsTOD8A0V7WWqyiUa0JAI9WpCN2YDbJ6kBBIf3WbvhqcgXSFfaQv6j0ZaKIeXW
 hyWaT19ZuuIcypB3jSqdUJmf79TF8gayXe4jrXiTUorv3+t48A+OivuEXO9S4Pek
 gwFG7KWnqyyb5mA68xH+7vPW9N1rNf+5ZMgwNbB4HsTQKi9EW9wa6isdBCjmyF+N
 4/Z/fR1JbyvPDTxvFsbeMj5IkbF/SkXIWQ5eFe45tjfft5yx9zA6QdMR6OzzljnZ
 a3h7ovZpkcCTIVglL5mdQ==
X-ME-Sender: <xms:JjzuaNsFzbpg6IjF1a6qwUTv0bXdl5l0-6mk9bQPehfIr5ZLpZXyhA>
 <xme:JjzuaPaZbhB4DjVDERN81h46qwFaSuta9pEXjB7DVFlTwl3pUBjzssCTUjhXzVj1S
 knbxRdAZu2kvzbdMZxmRZEY2-netyIEGOjCcJdRE4DcLzLmZxU0Zw>
X-ME-Received: <xmr:JjzuaMXZa_b7YSUTTueblssJITaM3YGWtDjNe_i3hnaTdHUk9ut1CcdNZqkgwmm-wH5uoLQ9Pe0aDK0znpq35wWyHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtgeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvsh
 hlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghr
 ughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifoh
 hrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:JjzuaET4n2DKiSW-uj4bTF4ayASOuUy5zQ9MfLKFmsrBoboDdmSZ7A>
 <xmx:JjzuaKMnnfz1tvpAolbeaSa9polCGCVYnpnYVHb3UB2pNQf9AEzIPw>
 <xmx:JjzuaCTCt4iEI_B7sXV0XXYB2DWdhNefyXICumSHM3SCl1xZ501Mzg>
 <xmx:JjzuaIjQT-YPPQUnJKqAsLySF2uSWERclGopGeJe--8BxKhvI8k-vg>
 <xmx:KDzuaK5uSHndTXqozsLhPIFbAT_D81d2Kg8Lsu6nG9_oWG-CwA-dpsRj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 08:03:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, shperetz@nvidia.com, viacheslavo@nvidia.com,
 bruce.richardson@intel.com, stephen@networkplumber.org
Subject: Re: [PATCH v5 3/7] mbuf: record mbuf operations history
Date: Tue, 14 Oct 2025 14:03:43 +0200
Message-ID: <2949753.n0HT0TaD9V@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654C7@smartserver.smartshare.dk>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014070517.922137-4-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F654C7@smartserver.smartshare.dk>
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

14/10/2025 11:59, Morten Br=C3=B8rup:
> From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > --- /dev/null
> > +++ b/lib/mbuf/mbuf_history.c
> > @@ -0,0 +1,227 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright(c) 2024 NVIDIA Corporation & Affiliates
>=20
> Suggest: 2024 -> 2025
> Also in other files.

No, it is the year of initial write.
It has been used internally before pushing upstream.


[...]
> > +#define HISTORY_LAST_MASK (RTE_BIT64(RTE_MBUF_HISTORY_BITS) - 1)
>=20
> Various places in the code has something like:
> +	last_op =3D history & HISTORY_LAST_MASK;
> +	RTE_ASSERT(last_op < RTE_MBUF_HISTORY_OP_MAX);

There is only one.
Other asserts are validating function parameters to be of the right size.

> Suggest replacing those by adding a static_assert here instead:
> static_assert(RTE_MBUF_HISTORY_OP_MAX =3D=3D HISTORY_LAST_MASK + 1, "Op s=
ize mismatch")

It is just checking RTE_MBUF_HISTORY_BITS and RTE_MBUF_HISTORY_OP_MAX are i=
n sync.
Honestly I don't see a real benefit, but I will add
RTE_BUILD_BUG_ON(RTE_MBUF_HISTORY_OP_MAX > HISTORY_LAST_MASK + 1);


[...]
> > +static void
> > +mbuf_history_count_stats_and_print(struct rte_mempool *mp
> > __rte_unused,
> > +		void *opaque, void *obj, unsigned obj_idx __rte_unused)
>=20
> Fix:
> unsigned -> unsigned int

It is the definition:
typedef void (rte_mempool_obj_cb_t)(struct rte_mempool *mp,
        void *opaque, void *obj, unsigned obj_idx);

>=20
> > +{
> > +	struct count_and_print_ctx *ctx =3D (struct count_and_print_ctx
> > *)opaque;
> > +	struct rte_mbuf *m =3D (struct rte_mbuf *)obj;
> > +	uint64_t history, last_op;
>=20
> Suggest using the enum type for operation variables:
> uint64_t history;
> enum rte_mbuf_history_op last_op;
>=20
> Also elsewhere in the code.

Yes it would be better to use the right type.


[...]
> > @@ -667,6 +672,7 @@ rte_mbuf_raw_free(struct rte_mbuf *m)
> >  {
> >  	__rte_mbuf_raw_sanity_check(m);
> >  	rte_mempool_put(m->pool, m);
> > +	rte_mbuf_history_mark(m, RTE_MBUF_HISTORY_OP_LIB_FREE);
>=20
> Fix: For improved race protection, mark the mbuf before actually freeing =
it, like this:
>  	__rte_mbuf_raw_sanity_check(m);
> +	rte_mbuf_history_mark(m, RTE_MBUF_HISTORY_OP_LIB_FREE);
>  	rte_mempool_put(m->pool, m);

The race is about a debugging mark.
The benefit of marking after is that the last mark is the upper level,
so we can easily distinguish between a free initiated by the app or the PMD.


[...]
> > @@ -701,6 +707,7 @@ rte_mbuf_raw_free_bulk(struct rte_mempool *mp,
> > struct rte_mbuf **mbufs, unsigned
> >  		RTE_ASSERT(m !=3D NULL);
> >  		RTE_ASSERT(m->pool =3D=3D mp);
> >  		__rte_mbuf_raw_sanity_check(m);
> > +		rte_mbuf_history_mark(mbufs[idx],
> > RTE_MBUF_HISTORY_OP_LIB_FREE);
> >  	}
>=20
> Fix: The loop is normally omitted, so use rte_mbuf_history_mark_bulk() he=
re instead of rte_mbuf_history_mark() inside the loop.
> It also makes the code easier to read.

OK


[...]
> > +enum rte_mbuf_history_op {
> > +	RTE_MBUF_HISTORY_OP_NEVER     =3D  0, /**< Initial state - never
> > allocated */
> > +	RTE_MBUF_HISTORY_OP_LIB_FREE  =3D  1, /**< Freed back to pool */
> > +	RTE_MBUF_HISTORY_OP_PMD_FREE  =3D  2, /**< Freed by PMD */
> > +	RTE_MBUF_HISTORY_OP_APP_FREE  =3D  3, /**< Freed by application */
> > +	RTE_MBUF_HISTORY_OP_LIB_ALLOC =3D  4, /**< Allocation in mbuf
> > library */
> > +	RTE_MBUF_HISTORY_OP_PMD_ALLOC =3D  5, /**< Allocated by PMD for Rx
> > */
> > +	RTE_MBUF_HISTORY_OP_APP_ALLOC =3D  6, /**< Allocated by application
> > */
> > +	RTE_MBUF_HISTORY_OP_RX        =3D  7, /**< Received */
> > +	RTE_MBUF_HISTORY_OP_TX        =3D  8, /**< Sent */
> > +	RTE_MBUF_HISTORY_OP_PREP_TX   =3D  9, /**< Being prepared before Tx
> > */
> > +	RTE_MBUF_HISTORY_OP_BUSY_TX   =3D 10, /**< Returned due to Tx busy
> > */
>=20
> Suggest:
> RTE_MBUF_HISTORY_OP_PREP_TX -> RTE_MBUF_HISTORY_OP_TX_PREP
> RTE_MBUF_HISTORY_OP_BUSY_TX -> RTE_MBUF_HISTORY_OP_TX_BUSY

OK

> > +	RTE_MBUF_HISTORY_OP_ENQUEUE   =3D 11, /**< Enqueued for processing
> > */
> > +	RTE_MBUF_HISTORY_OP_DEQUEUE   =3D 12, /**< Dequeued for processing
> > */
> > +	/*                              13,      reserved for future */
> > +	RTE_MBUF_HISTORY_OP_USR2      =3D 14, /**< Application-defined
> > event 2 */
> > +	RTE_MBUF_HISTORY_OP_USR1      =3D 15, /**< Application-defined
> > event 1 */
> > +	RTE_MBUF_HISTORY_OP_MAX       =3D 16, /**< Maximum number of
> > operation types */
> > +};
>=20
> Suggest adding:
> static_assert(RTE_MBUF_HISTORY_OP_MAX =3D=3D 1 << RTE_MBUF_HISTORY_BITS, =
"Enum vs bitsize mismatch");

Done with RTE_BUILD_BUG_ON(RTE_MBUF_HISTORY_OP_MAX > HISTORY_LAST_MASK + 1);
in next version.

No need to test equality.
Being more tolerant allows playing with tuning easily.


[...]
> > +/**
> > + * Mark an mbuf with a history event.
> > + *
> > + * @warning
> > + * @b EXPERIMENTAL: this API may change without prior notice.
> > + *
> > + * @param m
> > + *   Pointer to the mbuf.
> > + * @param op
> > + *   The operation to record.
> > + */
> > +static inline void rte_mbuf_history_mark(struct rte_mbuf *m, uint32_t
> > op)
>=20
> Fix:
> uint32_t op -> enum rte_mbuf_history_op op

Yes


[...]
> > +/**
> > + * Mark multiple mbufs with a history event.
> > + *
> > + * @warning
> > + * @b EXPERIMENTAL: this API may change without prior notice.
> > + *
> > + * @param mbufs
> > + *   Array of mbuf pointers.
> > + * @param n
> > + *   Number of mbufs to mark.
> > + * @param op
> > + *   The operation to record.
> > + */
> > +static inline void rte_mbuf_history_mark_bulk(struct rte_mbuf * const
> > *mbufs,
> > +		uint32_t n, uint32_t op)
>=20
> Fix:
> uint32_t n -> unsigned int count (for consistency)
> uint32_t op -> enum rte_mbuf_history_op op

Yes


[...]
> With fixes (suggestions optional),
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Thanks for the very detailed review.


