Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7380CCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 20:45:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 294E142DC7;
	Sun, 19 Oct 2025 22:45:50 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id DF80A40DD2
 for <dev@dpdk.org>; Sun, 19 Oct 2025 22:45:48 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b6a7ed1ff9eso1136760a12.0
 for <dev@dpdk.org>; Sun, 19 Oct 2025 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760906748;
 x=1761511548; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gifjhsN4zCnkJUOEGMF7+rKySSGnBGjwuXis+wLiPgg=;
 b=wA5z1YbHtponQj1+t3wHQZQUwmkj/opjXRC9MoSY02JKXGl0xXwyJKXY4zPiL1nmCm
 M7ZhQrPnaQstEEqF5+JgNIOzT8ND7tdFJ//5mcXorKwygg5y895rIcs9tQqbS4pdE9Ot
 Jo2yIjeyh9foqLuLpSXQ5jK2hmTIgYyDop+UnW8LFXsKeTo2/gbZs8vPKY2DVoyZlfsH
 lrZVoCbcUqJIAK9gyEMD89IcPqlrxLS2BVtQLdbQl+mc/mMdtW2/psh0372B+atIBIOi
 j3RfozZv+4O3cURY6uQVJ4I+pb1r4U5xCTlXXhI8Ezm+F2nhV0y2xDz7qdDX6dvNE8Ut
 n3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760906748; x=1761511548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gifjhsN4zCnkJUOEGMF7+rKySSGnBGjwuXis+wLiPgg=;
 b=c+nyKUE/nT3h1Xx9hj1X8iUjCyniNH8hKKfkE180PVusGW0Mi3HHig4daQNnSsZcxx
 ra1sR0eQzouqfR3UL+vhmuY+JgmI848WkkKK23C8vk3mDSxsDexFR9+WtQSs9gbmDCr1
 LJdHpkkCiy+NzFR8+lzayiz2cnF45fgSpChK+dfQRLrObTBQiJBcx/0+6VEpzjeh/HfN
 Id01p1cheD0J+cJZNDGncj+orVULIaG9HS5zrORGwXFzrua54ld4uhTRf6LQ6McoDqWd
 /cof6AsHj/Vat4N2LepzU1y9kXRFv7fImERoTYT5rrEGu0paEX+SNUh7hJirniBwVJ0i
 s6qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCNS27RcyuNJSaqqoZD8UIk0aCk8EA+bxCv4xtdzBt0yZKeTvyljceTRE7/PIKsaHiedg=@dpdk.org
X-Gm-Message-State: AOJu0Yx8MsqvF1HNFp6OV7EYM4H5L/n++2VP9wkTljpY16uZIn3cvFp0
 V5nwu/J9/Qh1MeJyld2yHi0hteES8bSaC/6qf5VLLfSB5mo/f3Y65+y3GeCYCRVvNSw=
X-Gm-Gg: ASbGncv4XKY5+qdMXB94qpV4T3+tHnWUeBlW20tAdRFKl0ZMnsRzuFUMMzI2y7DEKcA
 wLv0ig4cSU7PgiKT1V5JAMeZs1OijowLUt3nR+Zw1/87kBJSXgT7TxH31t7JKHDHSXJ2wuB830a
 TmAv6rUi3JtAVt4ND3RE9ij8luzzmwoDks7Z63ZOyDWICT1NYkFCcS6uR+/1efV3PiPI+gxDiTC
 KICRZ+e8pKBS/M1yZ+s8FQMg1gWlXzH/D80k3LCAHL57q/YgVvHV7q/Or563Ca7s87Q/H9n8CGq
 x8uygNr82j5txniz9+mVxixoB+a1PDlLK3Tp7WpASzatgzvv5sDq7aNksrSFiJAsHUgw9TsNAh3
 GsquTo5f1NIVGBLN00O1yNeaGf7sZn2shjy2WxPB9fujZJJtRgksZrHp6C+KqN3EK3kDGbLZ6US
 lQpoIjibsvNOJ2frT9zXgag8Qgrzx8nJ1JEbg/esnGBxA+fp0lUw==
X-Google-Smtp-Source: AGHT+IFaPgtpQKRm1DNCISoYLdYZyR9aTSh8T3OS3MLx7ZzG9sPkIFWUkJ7EB0GnjUk3ZPk1AND+4g==
X-Received: by 2002:a17:903:19f0:b0:28e:9a74:7b58 with SMTP id
 d9443c01a7336-290cb94784dmr140014285ad.31.1760906747999; 
 Sun, 19 Oct 2025 13:45:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebcde4sm61380955ad.5.2025.10.19.13.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 13:45:47 -0700 (PDT)
Date: Sun, 19 Oct 2025 13:45:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Message-ID: <20251019134545.203741d9@phoenix.lan>
In-Reply-To: <aOftoMl0edarmSGB@bricha3-mobl1.ger.corp.intel.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
 <20250823063002.24326-4-mb@smartsharesystems.com>
 <aOftoMl0edarmSGB@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 9 Oct 2025 18:15:12 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Sat, Aug 23, 2025 at 06:30:02AM +0000, Morten Br=C3=B8rup wrote:
> > An optimized function for resetting a bulk of newly allocated
> > reinitialized mbufs (a.k.a. raw mbufs) was added.
> >=20
> > Compared to the normal packet mbuf reset function, it takes advantage of
> > the following two details:
> > 1. The 'next' and 'nb_segs' fields are already reset, so resetting them
> > has been omitted.
> > 2. When resetting the mbuf, the 'ol_flags' field must indicate whether =
the
> > mbuf uses an external buffer, and the 'data_off' field must not exceed =
the
> > data room size when resetting the data offset to include the default
> > headroom.
> > Unlike the normal packet mbuf reset function, which reads the mbuf itse=
lf
> > to get the information required for resetting these two fields, this
> > function gets the information from the mempool.
> >=20
> > This makes the function write-only of the mbuf, unlike the normal packet
> > mbuf reset function, which is read-modify-write of the mbuf.
> >=20
> > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > ---
> >  lib/mbuf/rte_mbuf.h | 74 ++++++++++++++++++++++++++++-----------------
> >  1 file changed, 46 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> > index 49c93ab356..6f37a2e91e 100644
> > --- a/lib/mbuf/rte_mbuf.h
> > +++ b/lib/mbuf/rte_mbuf.h
> > @@ -954,6 +954,50 @@ static inline void rte_pktmbuf_reset_headroom(stru=
ct rte_mbuf *m)
> >  					(uint16_t)m->buf_len);
> >  }
> > =20
> > +/**
> > + * Reset the fields of a bulk of packet mbufs to their default values.
> > + *
> > + * The caller must ensure that the mbufs come from the specified mempo=
ol,
> > + * are direct and properly reinitialized (refcnt=3D1, next=3DNULL, nb_=
segs=3D1),
> > + * as done by rte_pktmbuf_prefree_seg().
> > + *
> > + * This function should be used with care, when optimization is requir=
ed.
> > + * For standard needs, prefer rte_pktmbuf_reset().
> > + *
> > + * @param mp
> > + *   The mempool to which the mbuf belongs.
> > + * @param mbufs
> > + *   Array of pointers to packet mbufs.
> > + *   The array must not contain NULL pointers.
> > + * @param count
> > + *   Array size.
> > + */
> > +static inline void
> > +rte_mbuf_raw_reset_bulk(struct rte_mempool *mp, struct rte_mbuf **mbuf=
s, unsigned int count)
> > +{
> > +	uint64_t ol_flags =3D (rte_pktmbuf_priv_flags(mp) & RTE_PKTMBUF_POOL_=
F_PINNED_EXT_BUF) ?
> > +			RTE_MBUF_F_EXTERNAL : 0;
> > +	uint16_t data_off =3D RTE_MIN_T(RTE_PKTMBUF_HEADROOM, rte_pktmbuf_dat=
a_room_size(mp),
> > +			uint16_t);
> > +
> > +	for (unsigned int idx =3D 0; idx < count; idx++) {
> > +		struct rte_mbuf *m =3D mbufs[idx];
> > +
> > +		m->pkt_len =3D 0;
> > +		m->tx_offload =3D 0;
> > +		m->vlan_tci =3D 0;
> > +		m->vlan_tci_outer =3D 0;
> > +		m->port =3D RTE_MBUF_PORT_INVALID; =20
>=20
> Have you considered doing all initialization using 64-bit stores? It's
> generally cheaper to do a single 64-bit store than e.g. set of 16-bit one=
s.
> This also means that we could remove the restriction on having refcnt and
> nb_segs already set. As in PMDs, a single store can init data_off, ref_cn=
t,
> nb_segs and port.
>=20
> Similarly for packet_type and pkt_len, and data_len/vlan_tci and rss fiel=
ds
> etc. For max performance, the whole of the mbuf cleared here can be done =
in
> 40 bytes, or 5 64-bit stores. If we do the stores in order, possibly the
> compiler can even opportunistically coalesce more stores, so we could even
> end up getting 128-bit or larger stores depending on the ISA compiled for.
> [Maybe the compiler will do this even if they are not in order, but I'd
> like to maximize my chances here! :-)]
>=20
> /Bruce

Although it is possible to use less CPU instructions, the performance
limiting factor is which fields are in cache.=20
