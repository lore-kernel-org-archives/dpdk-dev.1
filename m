Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1986CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 06:37:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBB0C40287;
	Thu, 18 Jun 2026 08:37:50 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id C92BB4027E
 for <dev@dpdk.org>; Thu, 18 Jun 2026 08:37:48 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-5176096116fso6324541cf.0
 for <dev@dpdk.org>; Wed, 17 Jun 2026 23:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781764668; cv=none;
 d=google.com; s=arc-20240605;
 b=SWpVvtZm3W1LVjjJaGo2SbJgGUWQbSRYtjxiC8qaUH9X3al7ytgfVClB9DG2LoIs03
 sr7JBMWGOYl5tncpHeNR5PVthPVW2+tDxCGLVeuizCQEJiaRHiVhGFh1fudX4umzoc5v
 SJIakIzMUb7aNEg5AWbWxAVTNb4Kcjs0Y3gXeZdLwSa/M8GmMM4fo776XKJyYUgRV+Wp
 Uat9VmjRP0uUpZl9AJ+8cv7k78XNK6a/3em+gar0EeWyfUEvXC36U5HhN3bmzUqvZ7ND
 bzlc7KDz2Q8Qt1skpgAS66Dtl8acYbdGprj2OM2rcOGDIy/WMM1ifFQ/Zs2l/KtSSvVC
 cEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dQmSP2LCGcd6vPsi29vY88j8IcL4sweyS8Mj2T8aSso=;
 fh=40zRqYHkrPeMgnp13vtesG9xeGwMzibPLhC1JuLEPzs=;
 b=cV3F83CUlvceRndeudmJKmuXXyCUqUB6BP/Cm2wtOn+0P/qXDS6BZUd4HYBHt+BAUA
 DJw8R2/RCq9ACXoIuJThw7+yGCuSdrf1pzGBZrtDE7PtXzcidIau2YJnoHTqttrVehAi
 9tmtKGt17Ho6wvFDyFUU2DhTejtEVdAo/ozXqqRaBJH6lb9QYeXbMJa6Xfn+/fwZ1fZN
 KaOprId/kfY5FVRwgYB+3FlorEQ6CJepSdooowKLQzEY+a+HCu+KDpb3F18aHEfnZxlP
 csZl0VWMdhK+aXwGIOcfq3ZUKSyB5+qrKZCsbX9Xlgg9QuY/e/yO8FPZC9wugdX2t0cx
 0e6w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781764668; x=1782369468; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dQmSP2LCGcd6vPsi29vY88j8IcL4sweyS8Mj2T8aSso=;
 b=onke/k0AKLKdfwhvSZRYlXBsJGbgqnqaFSTB30C+Bz7z6h15CA3MdNtQRSu5iTvc5G
 +KUlCNfQ4MMYoTOD1UncoBkkFpknVTXcaVu61tq/+xsekUWkwrsWSWNIYIrKB62lkH/w
 nBeCOSZTO2EKZue0udcrlVsZudJThfGIP8qPh0LUwwaw5TQwK+4OE3mpLPBJa3u36VP0
 N35Q42qw2WFvrmruQVtu7P6z1u6WWWowAMxoG01/iFLfMTwDbxCXRx6i/5zg+QVa7/Nf
 7X+D0M802/rPhUj32wKQxI5i9RCkcbQRezAKRksnOdJMFm4RJTQRZzdC3YGmKkHkIKzW
 DvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781764668; x=1782369468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQmSP2LCGcd6vPsi29vY88j8IcL4sweyS8Mj2T8aSso=;
 b=YP5AkdsitaD+RnzT7Hy9ZDD8pKPkvMTqi9EWW5BFuw5ZN5WuxKv8Cea8Yp+hS2bYPE
 UGxmg1YDQRXGWxMKQSW6fl5N9fjPPz/AOJ/PsHdQS0jEbWgKh2iz3FIJt0Jlawmol5NF
 TlO7/RtV2svSHwDY4g8Eb5mXPBdXutyJtgSL6u/ExMjgE8ZoLJphT4aVFzriAO8qjRFy
 2U1y+sLapaa4qySQs54B1NBlyaGoHyASqqYzcrQqbsJ54MAAXspCtctfdhZlTHxE9UGr
 kBDWJy1VxdPB+mJtMC9X1cZSS+Bmv30YxIw4j3C5rkpAM6q/d4un5I0grCGzp9vW1yeI
 RKaA==
X-Gm-Message-State: AOJu0YzOSZY2CveMDZJugWSTblVdWCTHw6NE0S7JkAsWIggIvIHj1Wic
 kRLx6reAL99a0+l68gJsJutvTF0/mc1/11UBWZ0SskMi/84qUTqO//9ygW2ngfRzCehG3SDraMD
 IoXUMZBygZaPc1puf0Lu2NLuZxaCZZa4=
X-Gm-Gg: Acq92OHS2bEREJlPvHyDBNzlK++kWltSWqSfVqdP3qSoYtutR2DItNLJuWtsAhMixwP
 ldaDcMbSe3lWTz+kX8ry3x3eoYpw1Xjj/kkV7rsADYDCLQjLlMItMoaK8/EDDFoBL/2Jfmgsgw+
 pdB2R121lYnKebsJh8gQaetS5XNlqYcuT3Hh2q3xI4IVEBlbZDkbYdkjzRJMMArlsTtCeVt0gEZ
 NAikUs8OjJ2vaQT/pC/uyYXKCVTjm3UPCyaZR/zxnxvkoR3TLYTwEAmOGDghaBphNT9vx/AQyc=
X-Received: by 2002:ac8:5944:0:b0:516:e085:b76e with SMTP id
 d75a77b69052e-519c695a0ccmr33298871cf.0.1781764666083; Wed, 17 Jun 2026
 23:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260608100202.0deac83d@phoenix.local>
 <20260616123812.21048-1-spiderdetective.ss@gmail.com>
 <1f2b21bd87a24610bc09b3b8da8100b5@huawei.com>
In-Reply-To: <1f2b21bd87a24610bc09b3b8da8100b5@huawei.com>
From: su sai <spiderdetective.ss@gmail.com>
Date: Thu, 18 Jun 2026 14:37:33 +0800
X-Gm-Features: AVVi8CcAu6-z0goXMnx8CEfJNjcp4ZN-jTErncmlShoK-TcF5MHyPG7TpNc9J4Q
Message-ID: <CAFQeoKj3dBf2GawAY+fb88mA9EPdHX6wLnXcEz5VD6ZfZYF+Yg@mail.gmail.com>
Subject: Re: [v4] net/cksum: compute raw cksum for several segments
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Content-Type: multipart/alternative; boundary="000000000000fecc1f0654816998"
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

--000000000000fecc1f0654816998
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Appreciate your review. I've resent the updated patch with your Acked-by
tag included.

On Thu, Jun 18, 2026 at 4:02=E2=80=AFAM Marat Khalili <marat.khalili@huawei=
.com>
wrote:

> > -----Original Message-----
> > From: Su Sai <spiderdetective.ss@gmail.com>
> > Sent: Tuesday 16 June 2026 13:38
> > To: stephen@networkplumber.org
> > Cc: dev@dpdk.org; spiderdetective.ss@gmail.com
> > Subject: [v4] net/cksum: compute raw cksum for several segments
> >
> > The rte_raw_cksum_mbuf function is used to compute
> > the raw checksum of a packet.
> > If the packet payload stored in multi mbuf, the function
> > will goto the hard case. In hard case,
> > the variable 'tmp' is a type of uint32_t,
> > so rte_bswap16 will drop high 16 bit.
> > Meanwhile, the variable 'sum' is a type of uint32_t,
> > so 'sum +=3D tmp' will drop the carry when overflow.
> > Both drop will make cksum incorrect.
> > This commit fixes the above bug.
> >
> > Signed-off-by: Su Sai <spiderdetective.ss@gmail.com>
>
> You can add:
>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
>
> > ---
> >  .mailmap              |   1 +
> >  app/test/test_cksum.c | 102 ++++++++++++++++++++++++++++++++++++++++++
> >  lib/net/rte_cksum.h   |  27 +++++++++--
> >  3 files changed, 126 insertions(+), 4 deletions(-)
> >
> > diff --git a/.mailmap b/.mailmap
> > index 4001e5fb0e..bcf73cb902 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -1630,6 +1630,7 @@ Sylvia Grundw=E7=9C=89rmer <sylvia.grundwuermer@b=
-plus.com
> >
> >  Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> >  Sylwia Wnuczko <sylwia.wnuczko@intel.com>
> >  Szymon Sliwa <szs@semihalf.com>
> > +Su Sai <spiderdetective.ss@gmail.com> <susai.ss@bytedance.com>
> >  Szymon T Cudzilo <szymon.t.cudzilo@intel.com>
> >  Tadhg Kearney <tadhg.kearney@intel.com>
> >  Taekyung Kim <kim.tae.kyung@navercorp.com>
> > diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
> > index ea443382a1..5bd9723fbd 100644
> > --- a/app/test/test_cksum.c
> > +++ b/app/test/test_cksum.c
> > @@ -85,6 +85,42 @@ static const char test_cksum_ipv4_opts_udp[] =3D {
> >       0x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,
> >  };
> >
> > +/*
> > + * generated in scapy with
> > + * Ether()/IP()/TCP(options=3D[NOP,NOP,Timestamps])/os.urandom(113))
> > + */
> > +static const char test_cksum_ipv4_tcp_multi_segs[] =3D {
> > +     0x00, 0x16, 0x3e, 0x0b, 0x6b, 0xd2, 0xee, 0xff,
> > +     0xff, 0xff, 0xff, 0xff, 0x08, 0x00, 0x45, 0x00,
> > +     0x00, 0xa5, 0x46, 0x10, 0x40, 0x00, 0x40, 0x06,
> > +     0x80, 0xb5, 0xc0, 0xa8, 0xf9, 0x1d, 0xc0, 0xa8,
> > +     0xf9, 0x1e, 0xdc, 0xa2, 0x14, 0x51, 0xbb, 0x8f,
> > +     0xa0, 0x00, 0xe4, 0x7c, 0xe4, 0xb8, 0x80, 0x10,
> > +     0x02, 0x00, 0x4b, 0xc1, 0x00, 0x00, 0x01, 0x01,
> > +     0x08, 0x0a, 0x90, 0x60, 0xf4, 0xff, 0x03, 0xc5,
> > +     0xb4, 0x19, 0x77, 0x34, 0xd4, 0xdc, 0x84, 0x86,
> > +     0xff, 0x44, 0x09, 0x63, 0x36, 0x2e, 0x26, 0x9b,
> > +     0x90, 0x70, 0xf2, 0xed, 0xc8, 0x5b, 0x87, 0xaa,
> > +     0xb4, 0x67, 0x6b, 0x32, 0x3d, 0xc4, 0xbf, 0x15,
> > +     0xa9, 0x16, 0x6c, 0x2a, 0x9d, 0xb2, 0xb7, 0x6b,
> > +     0x58, 0x44, 0x58, 0x12, 0x4b, 0x8f, 0xe5, 0x12,
> > +     0x11, 0x90, 0x94, 0x68, 0x37, 0xad, 0x0a, 0x9b,
> > +     0xd6, 0x79, 0xf2, 0xb7, 0x31, 0xcf, 0x44, 0x22,
> > +     0xc8, 0x99, 0x3f, 0xe5, 0xe7, 0xac, 0xc7, 0x0b,
> > +     0x86, 0xdf, 0xda, 0xed, 0x0a, 0x0f, 0x86, 0xd7,
> > +     0x48, 0xe2, 0xf1, 0xc2, 0x43, 0xed, 0x47, 0x3a,
> > +     0xea, 0x25, 0x2d, 0xd6, 0x60, 0x38, 0x30, 0x07,
> > +     0x28, 0xdd, 0x1f, 0x0c, 0xdd, 0x7b, 0x7c, 0xd9,
> > +     0x35, 0x9d, 0x14, 0xaa, 0xc6, 0x35, 0xd1, 0x03,
> > +     0x38, 0xb1, 0xf5,
> > +};
> > +
> > +static const uint8_t test_cksum_ipv4_tcp_multi_segs_len[] =3D {
> > +     66,  /* the first seg contains all headers, including L2 to L4 */
> > +     61,  /* the second seg length is odd, test byte order independent
> */
> > +     52,  /* three segs are sufficient to test the most complex
> scenarios */
> > +};
> > +
> >  /* test l3/l4 checksum api */
> >  static int
> >  test_l4_cksum(struct rte_mempool *pktmbuf_pool, const char *pktdata,
> size_t len)
> > @@ -223,6 +259,66 @@ test_l4_cksum(struct rte_mempool *pktmbuf_pool,
> const char *pktdata, size_t len)
> >       return -1;
> >  }
> >
> > +/* test l4 checksum api for a packet with multiple mbufs */
> > +static int
> > +test_l4_cksum_multi_mbufs(struct rte_mempool *pktmbuf_pool, const char
> *pktdata, size_t len,
> > +                          const uint8_t *segs, size_t segs_len)
> > +{
> > +     struct rte_mbuf *m[NB_MBUF] =3D {0};
> > +     struct rte_mbuf *m_hdr =3D NULL;
> > +     struct rte_net_hdr_lens hdr_lens;
> > +     size_t i, off =3D 0;
> > +     uint32_t packet_type, l3;
> > +     void *l3_hdr;
> > +     char *data;
> > +
> > +     for (i =3D 0; i < segs_len; i++) {
> > +             m[i] =3D rte_pktmbuf_alloc(pktmbuf_pool);
> > +             if (m[i] =3D=3D NULL)
> > +                     GOTO_FAIL("Cannot allocate mbuf");
> > +
> > +             data =3D rte_pktmbuf_append(m[i], segs[i]);
> > +             if (data =3D=3D NULL)
> > +                     GOTO_FAIL("Cannot append data");
> > +
> > +             memcpy(data, pktdata + off, segs[i]);
> > +             off +=3D segs[i];
> > +
> > +             if (m_hdr) {
> > +                     if (rte_pktmbuf_chain(m_hdr, m[i]))
> > +                             GOTO_FAIL("Cannot chain mbuf");
> > +             } else {
> > +                     m_hdr =3D m[i];
> > +             }
> > +     }
> > +
> > +     if (off !=3D len)
> > +             GOTO_FAIL("Invalid segs");
> > +
> > +     packet_type =3D rte_net_get_ptype(m_hdr, &hdr_lens,
> RTE_PTYPE_ALL_MASK);
> > +     l3 =3D packet_type & RTE_PTYPE_L3_MASK;
> > +
> > +     l3_hdr =3D rte_pktmbuf_mtod_offset(m_hdr, void *, hdr_lens.l2_len=
);
> > +     off =3D hdr_lens.l2_len + hdr_lens.l3_len;
> > +
> > +     if (l3 =3D=3D RTE_PTYPE_L3_IPV4 || l3 =3D=3D RTE_PTYPE_L3_IPV4_EX=
T) {
> > +             if (rte_ipv4_udptcp_cksum_mbuf_verify(m_hdr, l3_hdr, off)
> !=3D 0)
> > +                     GOTO_FAIL("Invalid L4 checksum verification for
> multiple mbufs");
> > +     } else if (l3 =3D=3D RTE_PTYPE_L3_IPV6 || l3 =3D=3D RTE_PTYPE_L3_=
IPV6_EXT)
> {
> > +             if (rte_ipv6_udptcp_cksum_mbuf_verify(m_hdr, l3_hdr, off)
> !=3D 0)
> > +                     GOTO_FAIL("Invalid L4 checksum verification for
> multiple mbufs");
> > +     }
> > +
> > +     rte_pktmbuf_free_bulk(m, segs_len);
> > +
> > +     return 0;
> > +
> > +fail:
> > +     rte_pktmbuf_free_bulk(m, segs_len);
> > +
> > +     return -1;
> > +}
> > +
> >  static int
> >  test_cksum(void)
> >  {
> > @@ -256,6 +352,12 @@ test_cksum(void)
> >                         sizeof(test_cksum_ipv4_opts_udp)) < 0)
> >               GOTO_FAIL("checksum error on ipv4_opts_udp");
> >
> > +     if (test_l4_cksum_multi_mbufs(pktmbuf_pool,
> test_cksum_ipv4_tcp_multi_segs,
> > +                       sizeof(test_cksum_ipv4_tcp_multi_segs),
> > +                       test_cksum_ipv4_tcp_multi_segs_len,
> > +                       sizeof(test_cksum_ipv4_tcp_multi_segs_len)) < 0=
)
> > +             GOTO_FAIL("checksum error on multi mbufs check");
> > +
> >       rte_mempool_free(pktmbuf_pool);
> >
> >       return 0;
> > diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
> > index a8e8927952..679ba82eb6 100644
> > --- a/lib/net/rte_cksum.h
> > +++ b/lib/net/rte_cksum.h
> > @@ -80,6 +80,25 @@ __rte_raw_cksum_reduce(uint32_t sum)
> >       return (uint16_t)sum;
> >  }
> >
> > +/**
> > + * @internal Reduce a sum to the non-complemented checksum.
> > + * Helper routine for the rte_raw_cksum_mbuf().
> > + *
> > + * @param sum
> > + *   Value of the sum.
> > + * @return
> > + *   The non-complemented checksum.
> > + */
> > +static inline uint16_t
> > +__rte_raw_cksum_reduce_u64(uint64_t sum)
> > +{
> > +     uint32_t tmp;
> > +
> > +     tmp =3D __rte_raw_cksum_reduce((uint32_t)sum);
> > +     tmp +=3D __rte_raw_cksum_reduce((uint32_t)(sum >> 32));
> > +     return __rte_raw_cksum_reduce(tmp);
> > +}
> > +
> >  /**
> >   * Process the non-complemented checksum of a buffer.
> >   *
> > @@ -119,8 +138,8 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
> uint32_t off, uint32_t len,
> >  {
> >       const struct rte_mbuf *seg;
> >       const char *buf;
> > -     uint32_t sum, tmp;
> > -     uint32_t seglen, done;
> > +     uint32_t seglen, done, tmp;
> > +     uint64_t sum;
> >
> >       /* easy case: all data in the first segment */
> >       if (off + len <=3D rte_pktmbuf_data_len(m)) {
> > @@ -157,7 +176,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
> uint32_t off, uint32_t len,
> >       for (;;) {
> >               tmp =3D __rte_raw_cksum(buf, seglen, 0);
> >               if (done & 1)
> > -                     tmp =3D rte_bswap16((uint16_t)tmp);
> > +                     tmp =3D rte_bswap32(tmp);
> >               sum +=3D tmp;
> >               done +=3D seglen;
> >               if (done =3D=3D len)
> > @@ -169,7 +188,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
> uint32_t off, uint32_t len,
> >                       seglen =3D len - done;
> >       }
> >
> > -     *cksum =3D __rte_raw_cksum_reduce(sum);
> > +     *cksum =3D __rte_raw_cksum_reduce_u64(sum);
> >       return 0;
> >  }
> >
> > --
> > 2.20.1
>
>

--000000000000fecc1f0654816998
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"color:rgb(0,0,0);font-variant-numeric:normal=
;font-variant-east-asian:normal;font-variant-alternates:normal;font-size-ad=
just:none;font-kerning:auto;font-feature-settings:normal;font-stretch:norma=
l;font-size:16px;line-height:24px;font-family:ui-sans-serif,system-ui,sans-=
serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe =
UI Symbol&quot;,&quot;Noto Color Emoji&quot;;padding:0px;margin:0px;backgro=
und:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0)">App=
reciate your review. I&#39;ve resent the updated patch with your Acked-by t=
ag included.</div><div style=3D"color:rgb(0,0,0);font-variant-numeric:norma=
l;font-variant-east-asian:normal;font-variant-alternates:normal;font-size-a=
djust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:norm=
al;font-size:16px;line-height:24px;font-family:ui-sans-serif,system-ui,sans=
-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe=
 UI Symbol&quot;,&quot;Noto Color Emoji&quot;;padding:0px;margin:0px;backgr=
ound:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0)"></=
div>
<h2 style=3D"color:rgb(0,0,0);font-variant-numeric:normal;font-variant-east=
-asian:normal;font-variant-alternates:normal;font-size-adjust:none;font-ker=
ning:auto;font-feature-settings:normal;font-weight:400;font-stretch:normal;=
font-size:16px;line-height:24px;font-family:ui-sans-serif,system-ui,sans-se=
rif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI=
 Symbol&quot;,&quot;Noto Color Emoji&quot;;padding:0px;margin:0px;backgroun=
d:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0)"></h2>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Thu, Jun 18, 2026 at 4:02=E2=80=AFAM Marat Khalili=
 &lt;<a href=3D"mailto:marat.khalili@huawei.com">marat.khalili@huawei.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&g=
t; -----Original Message-----<br>
&gt; From: Su Sai &lt;<a href=3D"mailto:spiderdetective.ss@gmail.com" targe=
t=3D"_blank">spiderdetective.ss@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday 16 June 2026 13:38<br>
&gt; To: <a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank">st=
ephen@networkplumber.org</a><br>
&gt; Cc: <a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</a>=
; <a href=3D"mailto:spiderdetective.ss@gmail.com" target=3D"_blank">spiderd=
etective.ss@gmail.com</a><br>
&gt; Subject: [v4] net/cksum: compute raw cksum for several segments<br>
&gt; <br>
&gt; The rte_raw_cksum_mbuf function is used to compute<br>
&gt; the raw checksum of a packet.<br>
&gt; If the packet payload stored in multi mbuf, the function<br>
&gt; will goto the hard case. In hard case,<br>
&gt; the variable &#39;tmp&#39; is a type of uint32_t,<br>
&gt; so rte_bswap16 will drop high 16 bit.<br>
&gt; Meanwhile, the variable &#39;sum&#39; is a type of uint32_t,<br>
&gt; so &#39;sum +=3D tmp&#39; will drop the carry when overflow.<br>
&gt; Both drop will make cksum incorrect.<br>
&gt; This commit fixes the above bug.<br>
&gt; <br>
&gt; Signed-off-by: Su Sai &lt;<a href=3D"mailto:spiderdetective.ss@gmail.c=
om" target=3D"_blank">spiderdetective.ss@gmail.com</a>&gt;<br>
<br>
You can add:<br>
<br>
Acked-by: Marat Khalili &lt;<a href=3D"mailto:marat.khalili@huawei.com" tar=
get=3D"_blank">marat.khalili@huawei.com</a>&gt;<br>
<br>
&gt; ---<br>
&gt;=C2=A0 .mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A01 +<br>
&gt;=C2=A0 app/test/test_cksum.c | 102 ++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 lib/net/rte_cksum.h=C2=A0 =C2=A0|=C2=A0 27 +++++++++--<br>
&gt;=C2=A0 3 files changed, 126 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/.mailmap b/.mailmap<br>
&gt; index 4001e5fb0e..bcf73cb902 100644<br>
&gt; --- a/.mailmap<br>
&gt; +++ b/.mailmap<br>
&gt; @@ -1630,6 +1630,7 @@ Sylvia Grundw=E7=9C=89rmer &lt;<a href=3D"mailto=
:sylvia.grundwuermer@b-plus.com" target=3D"_blank">sylvia.grundwuermer@b-pl=
us.com</a>&gt;<br>
&gt;=C2=A0 Sylwester Dziedziuch &lt;<a href=3D"mailto:sylwesterx.dziedziuch=
@intel.com" target=3D"_blank">sylwesterx.dziedziuch@intel.com</a>&gt;<br>
&gt;=C2=A0 Sylwia Wnuczko &lt;<a href=3D"mailto:sylwia.wnuczko@intel.com" t=
arget=3D"_blank">sylwia.wnuczko@intel.com</a>&gt;<br>
&gt;=C2=A0 Szymon Sliwa &lt;<a href=3D"mailto:szs@semihalf.com" target=3D"_=
blank">szs@semihalf.com</a>&gt;<br>
&gt; +Su Sai &lt;<a href=3D"mailto:spiderdetective.ss@gmail.com" target=3D"=
_blank">spiderdetective.ss@gmail.com</a>&gt; &lt;<a href=3D"mailto:susai.ss=
@bytedance.com" target=3D"_blank">susai.ss@bytedance.com</a>&gt;<br>
&gt;=C2=A0 Szymon T Cudzilo &lt;<a href=3D"mailto:szymon.t.cudzilo@intel.co=
m" target=3D"_blank">szymon.t.cudzilo@intel.com</a>&gt;<br>
&gt;=C2=A0 Tadhg Kearney &lt;<a href=3D"mailto:tadhg.kearney@intel.com" tar=
get=3D"_blank">tadhg.kearney@intel.com</a>&gt;<br>
&gt;=C2=A0 Taekyung Kim &lt;<a href=3D"mailto:kim.tae.kyung@navercorp.com" =
target=3D"_blank">kim.tae.kyung@navercorp.com</a>&gt;<br>
&gt; diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c<br>
&gt; index ea443382a1..5bd9723fbd 100644<br>
&gt; --- a/app/test/test_cksum.c<br>
&gt; +++ b/app/test/test_cksum.c<br>
&gt; @@ -85,6 +85,42 @@ static const char test_cksum_ipv4_opts_udp[] =3D {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A00x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,<br=
>
&gt;=C2=A0 };<br>
&gt; <br>
&gt; +/*<br>
&gt; + * generated in scapy with<br>
&gt; + * Ether()/IP()/TCP(options=3D[NOP,NOP,Timestamps])/os.urandom(113))<=
br>
&gt; + */<br>
&gt; +static const char test_cksum_ipv4_tcp_multi_segs[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A00x00, 0x16, 0x3e, 0x0b, 0x6b, 0xd2, 0xee, 0xff,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00xff, 0xff, 0xff, 0xff, 0x08, 0x00, 0x45, 0x00,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x00, 0xa5, 0x46, 0x10, 0x40, 0x00, 0x40, 0x06,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x80, 0xb5, 0xc0, 0xa8, 0xf9, 0x1d, 0xc0, 0xa8,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00xf9, 0x1e, 0xdc, 0xa2, 0x14, 0x51, 0xbb, 0x8f,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00xa0, 0x00, 0xe4, 0x7c, 0xe4, 0xb8, 0x80, 0x10,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x02, 0x00, 0x4b, 0xc1, 0x00, 0x00, 0x01, 0x01,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x08, 0x0a, 0x90, 0x60, 0xf4, 0xff, 0x03, 0xc5,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00xb4, 0x19, 0x77, 0x34, 0xd4, 0xdc, 0x84, 0x86,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00xff, 0x44, 0x09, 0x63, 0x36, 0x2e, 0x26, 0x9b,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x90, 0x70, 0xf2, 0xed, 0xc8, 0x5b, 0x87, 0xaa,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00xb4, 0x67, 0x6b, 0x32, 0x3d, 0xc4, 0xbf, 0x15,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00xa9, 0x16, 0x6c, 0x2a, 0x9d, 0xb2, 0xb7, 0x6b,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x58, 0x44, 0x58, 0x12, 0x4b, 0x8f, 0xe5, 0x12,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x11, 0x90, 0x94, 0x68, 0x37, 0xad, 0x0a, 0x9b,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00xd6, 0x79, 0xf2, 0xb7, 0x31, 0xcf, 0x44, 0x22,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00xc8, 0x99, 0x3f, 0xe5, 0xe7, 0xac, 0xc7, 0x0b,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x86, 0xdf, 0xda, 0xed, 0x0a, 0x0f, 0x86, 0xd7,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x48, 0xe2, 0xf1, 0xc2, 0x43, 0xed, 0x47, 0x3a,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00xea, 0x25, 0x2d, 0xd6, 0x60, 0x38, 0x30, 0x07,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x28, 0xdd, 0x1f, 0x0c, 0xdd, 0x7b, 0x7c, 0xd9,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x35, 0x9d, 0x14, 0xaa, 0xc6, 0x35, 0xd1, 0x03,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x38, 0xb1, 0xf5,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const uint8_t test_cksum_ipv4_tcp_multi_segs_len[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A066,=C2=A0 /* the first seg contains all headers, =
including L2 to L4 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A061,=C2=A0 /* the second seg length is odd, test b=
yte order independent */<br>
&gt; +=C2=A0 =C2=A0 =C2=A052,=C2=A0 /* three segs are sufficient to test th=
e most complex scenarios */<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 /* test l3/l4 checksum api */<br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 test_l4_cksum(struct rte_mempool *pktmbuf_pool, const char *pktd=
ata, size_t len)<br>
&gt; @@ -223,6 +259,66 @@ test_l4_cksum(struct rte_mempool *pktmbuf_pool, c=
onst char *pktdata, size_t len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt; +/* test l4 checksum api for a packet with multiple mbufs */<br>
&gt; +static int<br>
&gt; +test_l4_cksum_multi_mbufs(struct rte_mempool *pktmbuf_pool, const cha=
r *pktdata, size_t len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 const uint8_t *segs, size_t segs_len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rte_mbuf *m[NB_MBUF] =3D {0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rte_mbuf *m_hdr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rte_net_hdr_lens hdr_lens;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0size_t i, off =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t packet_type, l3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void *l3_hdr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; segs_len; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0m[i] =3D rte_pktmbuf_=
alloc(pktmbuf_pool);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (m[i] =3D=3D NULL)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0GOTO_FAIL(&quot;Cannot allocate mbuf&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D rte_pktmbuf_=
append(m[i], segs[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data =3D=3D NULL)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0GOTO_FAIL(&quot;Cannot append data&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(data, pktdata =
+ off, segs[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0off +=3D segs[i];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (m_hdr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (rte_pktmbuf_chain(m_hdr, m[i]))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GOTO_FAIL(&quot;Cannot chain mbuf&quot;)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0m_hdr =3D m[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (off !=3D len)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GOTO_FAIL(&quot;Inval=
id segs&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0packet_type =3D rte_net_get_ptype(m_hdr, &amp;hdr=
_lens, RTE_PTYPE_ALL_MASK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0l3 =3D packet_type &amp; RTE_PTYPE_L3_MASK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0l3_hdr =3D rte_pktmbuf_mtod_offset(m_hdr, void *,=
 hdr_lens.l2_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0off =3D hdr_lens.l2_len + hdr_lens.l3_len;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (l3 =3D=3D RTE_PTYPE_L3_IPV4 || l3 =3D=3D RTE_=
PTYPE_L3_IPV4_EXT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_ipv4_udptcp_c=
ksum_mbuf_verify(m_hdr, l3_hdr, off) !=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0GOTO_FAIL(&quot;Invalid L4 checksum verification for multiple mbufs&=
quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else if (l3 =3D=3D RTE_PTYPE_L3_IPV6 || l3 =3D=
=3D RTE_PTYPE_L3_IPV6_EXT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_ipv6_udptcp_c=
ksum_mbuf_verify(m_hdr, l3_hdr, off) !=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0GOTO_FAIL(&quot;Invalid L4 checksum verification for multiple mbufs&=
quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rte_pktmbuf_free_bulk(m, segs_len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rte_pktmbuf_free_bulk(m, segs_len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 test_cksum(void)<br>
&gt;=C2=A0 {<br>
&gt; @@ -256,6 +352,12 @@ test_cksum(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sizeof(test_cksum_ipv4_opts_udp)) &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GOTO_FAIL(&quot;=
checksum error on ipv4_opts_udp&quot;);<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (test_l4_cksum_multi_mbufs(pktmbuf_pool, test_=
cksum_ipv4_tcp_multi_segs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0sizeof(test_cksum_ipv4_tcp_multi_segs),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0test_cksum_ipv4_tcp_multi_segs_len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0sizeof(test_cksum_ipv4_tcp_multi_segs_len)) &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GOTO_FAIL(&quot;check=
sum error on multi mbufs check&quot;);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mempool_free(pktmbuf_pool);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h<br>
&gt; index a8e8927952..679ba82eb6 100644<br>
&gt; --- a/lib/net/rte_cksum.h<br>
&gt; +++ b/lib/net/rte_cksum.h<br>
&gt; @@ -80,6 +80,25 @@ __rte_raw_cksum_reduce(uint32_t sum)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return (uint16_t)sum;<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt; +/**<br>
&gt; + * @internal Reduce a sum to the non-complemented checksum.<br>
&gt; + * Helper routine for the rte_raw_cksum_mbuf().<br>
&gt; + *<br>
&gt; + * @param sum<br>
&gt; + *=C2=A0 =C2=A0Value of the sum.<br>
&gt; + * @return<br>
&gt; + *=C2=A0 =C2=A0The non-complemented checksum.<br>
&gt; + */<br>
&gt; +static inline uint16_t<br>
&gt; +__rte_raw_cksum_reduce_u64(uint64_t sum)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D __rte_raw_cksum_reduce((uint32_t)sum);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp +=3D __rte_raw_cksum_reduce((uint32_t)(sum &g=
t;&gt; 32));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return __rte_raw_cksum_reduce(tmp);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* Process the non-complemented checksum of a buffer.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; @@ -119,8 +138,8 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint3=
2_t off, uint32_t len,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rte_mbuf *seg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *buf;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint32_t sum, tmp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint32_t seglen, done;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t seglen, done, tmp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t sum;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* easy case: all data in the first segment =
*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (off + len &lt;=3D rte_pktmbuf_data_len(m=
)) {<br>
&gt; @@ -157,7 +176,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint3=
2_t off, uint32_t len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (;;) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D __rte_ra=
w_cksum(buf, seglen, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (done &amp; 1=
)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tmp =3D rte_bswap16((uint16_t)tmp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tmp =3D rte_bswap32(tmp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sum +=3D tmp;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done +=3D seglen=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (done =3D=3D =
len)<br>
&gt; @@ -169,7 +188,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint3=
2_t off, uint32_t len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0seglen =3D len - done;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 =C2=A0*cksum =3D __rte_raw_cksum_reduce(sum);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*cksum =3D __rte_raw_cksum_reduce_u64(sum);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt; --<br>
&gt; 2.20.1<br>
<br>
</blockquote></div>

--000000000000fecc1f0654816998--
