Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5C5CCD183
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 18:39:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B82F8402AE;
	Mon, 13 Oct 2025 20:39:22 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id F1E40402A0
 for <dev@dpdk.org>; Mon, 13 Oct 2025 20:39:21 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 062971D00101;
 Mon, 13 Oct 2025 14:39:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 13 Oct 2025 14:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760380760;
 x=1760467160; bh=kauKSc1pItDECUOnUaWfej42cfYXpVRCfznMb/KVFMM=; b=
 Rbipq+QE50ggLJyqoRWdxtk3zHQc6mPPsuOlO5MMCE80Ypj7yjyWPfITirhCE9N+
 yKiZl8/hT4d/MtVg/eqZ3wmK9k0Xcj8AOjOKza5nhp21LRAloK1Yvg1tA1tZzcJB
 7jr9tix+bJnIe8OUxxDSKlxE1Vbf8vfEGGLQJMNOvutqTZBpS+phO9Lls/VpajTu
 32OWQdzPqNrZIbFFojYRx7gDPql2MxtyCu8f+vc5O1mw090z9uiFRnBwguAQlrLK
 KnYgQcjCgNWByJpms14c8C7jxvbKLHR2zNzaXs2fcEumvVSVloeKiFAl4nu6oXkV
 9Yx8DLcmmL17lHum4dH6IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760380760; x=
 1760467160; bh=kauKSc1pItDECUOnUaWfej42cfYXpVRCfznMb/KVFMM=; b=Y
 0LxqtYhbQafXdOnlf1eJeqmZeZS60rGXa0flwZtJ6OKPCm63TKhqJXONHOjWP76M
 DbHkWW2gPfm5Wr5nMJ8YkohaVu5pwFkxxbggYYb8KjlFw8O1DP/MpOWHyj/Hcu1z
 5dF6jyXkpVBA9MeX3mzUvzZ5zr0zGvBESYPEoGJjSpGAZgLxiqqkjk4uysbT1Le7
 wQLSwowQc3o+glPN7RoLsLpsmLRi6OJKhx4DanUUofnc9HJoof7PAaMLBGwAT953
 ry9jke8rgomOUseUUTEaQDPq7OoG/L2yfy5PW/bfM001xPH1q7jJ648t/yBJh97O
 xb2W9IssY6fGEgqvRG8bg==
X-ME-Sender: <xms:WEftaOI__m-k3QFDbFjy7-2f0euMOM3k1pchtMorF0orRWJf4fPCNw>
 <xme:WEftaPGY-gAhsrgvFBMjPn7TqeHK-hcWyqsl8BIaW9Eud2Dk3qx0lfDb0JaK6UTjy
 hIxtw_Dgju1Y80k4ewAbXFlAfA-9Hbb8uHCacGr-7Li3pjS1IFd5Q>
X-ME-Received: <xmr:WEftaKTsgOIWltT0H8qXD0BCIkV6n8bV-vher8wOeoR2ddc8EokmuI5p4rOR5ZRAyuvQTaMQwK3tO4uohJh9jjrpYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekfeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WEftaDdbIZzrHZbwhs49POpPcukafhLsCB0j2VqKxsaU0tkeZUE3Rg>
 <xmx:WEftaBqbnoPBZlIYX2ODFuKMpAjhDwtL6teyHZRMBMsEeb5ffeJKkA>
 <xmx:WEftaM_VxvU2PfbewppGY0yYLtJSgRQ1zQmAhUt7bJ2ZuF0msbHVPg>
 <xmx:WEftaFfSCk1uBYWI4hSa7jvelhigdUod84taRqNDpo84RdnecGB1LQ>
 <xmx:WEftaD0p-xUg94rb4ZNtbsGCix6_sjb39e6k5K7D5Os1VR9XsnJQFtXE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 14:39:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Shani Peretz <shperetz@nvidia.com>, viacheslavo@nvidia.com, 
 bruce.richardson@intel.com, stephen@networkplumber.org
Subject: Re: [PATCH v3 2/5] mbuf: record mbuf operations history
Date: Mon, 13 Oct 2025 20:39:18 +0200
Message-ID: <40546840.10thIPus4b@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6548D@smartserver.smartshare.dk>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-3-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F6548D@smartserver.smartshare.dk>
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

02/10/2025 09:37, Morten Br=C3=B8rup:
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump_mempool, 25.11)
> > +void rte_mbuf_history_dump_mempool(FILE *f, struct rte_mempool *mp)
> > +{
> > +#if !RTE_MBUF_HISTORY_DEBUG
> > +      RTE_SET_USED(f);
> > +      RTE_SET_USED(mp);
> > +      MBUF_LOG(INFO, "mbuf history recorder is not enabled");
> > +#else
> > +      if (f =3D=3D NULL) {
> > +              MBUF_LOG(ERR, "Invalid mbuf dump file.");
> > +              return;
> > +      }
> > +      if (mp =3D=3D NULL) {
> > +              fprintf(f, "ERROR: Invalid mempool pointer\n");
>=20
> Should be MBUF_LOG(ERR, ...), not fprintf().
>=20
> > +              return;
> > +      }
> > +      if (rte_mbuf_history_field_offset < 0) {
> > +              fprintf(f, "WARNING: mbuf history not initialized. Call
> > rte_mbuf_history_init() first.\n");
>=20
> Should be MBUF_LOG(ERR, ...), not fprintf().
>=20
> > +              return;
> > +      }
>=20
> Since the type of objects held in a mempool is not identifiable as mbufs,=
 you should check that (mp->elt_size >=3D sizeof(struct rte_mbuf)). Imagine=
 some non-mbuf mempool holding 64 byte sized objects, and rte_mbuf_history_=
field_offset being in the second cache line.
>=20
> You might want to log an error if called directly, and silently skip of c=
alled from rte_mbuf_history_dump_all(), so suggest adding a wrapper when ca=
lling this function through rte_mempool_walk().

Yes good idea.

> > +      mbuf_history_get_stats(mp, f);
> > +#endif
> > +}
> [...]
>=20
> > +/**
> > + * Mark an mbuf with a history event.
> > + *
> > + * @param m
> > + *   Pointer to the mbuf.
> > + * @param op
> > + *   The operation to record.
> > + */
> > +static inline void rte_mbuf_history_mark(struct rte_mbuf *m, uint32_t
> > op)
> > +{
> > +#if !RTE_MBUF_HISTORY_DEBUG
> > +      RTE_SET_USED(m);
> > +      RTE_SET_USED(op);
> > +#else
> > +      RTE_ASSERT(rte_mbuf_history_field_offset >=3D 0);
> > +      RTE_ASSERT(op < RTE_MBUF_HISTORY_OP_MAX);
> > +      if (unlikely (m =3D=3D NULL))
> > +              return;
> > +
> > +      rte_mbuf_history_t *history_field =3D RTE_MBUF_DYNFIELD(m,
> > +                      rte_mbuf_history_field_offset, rte_mbuf_history_=
t *);
> > +      uint64_t history =3D rte_atomic_load_explicit(history_field,
> > rte_memory_order_acquire);
> > +      history =3D (history << RTE_MBUF_HISTORY_BITS) | op;
> > +      rte_atomic_store_explicit(history_field, history,
> > rte_memory_order_release);
>=20
> This is not thread safe.
> Some other thread can race to update history_field after this thread load=
s it, so when this tread stores the updated history, the other thread's his=
tory update is overwritten and lost.

You're right.
I suppose this change was to align with the atomic read operation
done in the "get" function.

> To make it thread safe, you must use a CAS operation and start over if it=
 failed.

By "failed", you mean if the previous value returned by the CAS operation
is different of what we used earlier to build our new value?

I suggest this:

    rte_mbuf_history_t *history_field =3D RTE_MBUF_DYNFIELD(m,
            rte_mbuf_history_field_offset, rte_mbuf_history_t *);
    uint64_t old_history =3D rte_atomic_load_explicit(history_field,
            rte_memory_order_acquire);
    uint64_t new_history;
    do {
        new_history =3D (old_history << RTE_MBUF_HISTORY_BITS) | op;
    } while (!rte_atomic_compare_exchange_weak_explicit(history_field,
            &old_history, new_history,
            rte_memory_order_release, rte_memory_order_relaxed));



