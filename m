Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D9DCD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFA4E40289;
	Tue, 16 Jun 2026 14:48:32 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id DC6B54026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:48:30 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-517760dc3c2so29540771cf.3
 for <dev@dpdk.org>; Tue, 16 Jun 2026 05:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781614110; cv=none;
 d=google.com; s=arc-20240605;
 b=NecIaFL/6jWGtgDCtyz5xxVamxhXv/xVbM8yenfQGdFB7tISLRJnuIKQLxbqvGX96p
 SjKch12l70TDS06QHWdbOkSeAigKOyoY5FApM2fj4XkP7IJUwy8917ueQ/HVTnZpDeNG
 JyAbk2l5/KKwWQ7/T43eZz1oBXIgDbZZ6vFRCOaPNOznefhTS7nD0ZPFDODVctCP3Ogk
 WYo7Tc2eAy/XX0wzWrZtd6W2l3bDoWvlvMAwzX/Xamqkg6msYUo3SQyD9rqCMLB7IfdA
 mgLKNdEhVL4ucr1ln+uxJep6x43fBgq+fsfir1qoFZztabPBKapiRQX4eeM5R7EAQ8TA
 kw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xo9B2zq4rGYcnm+39yqKdPD2maqALDisS96fz0g8Ymc=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=hqohg3VGg1/R4F81HeumqKUo8I3yCo0mbdO/UjKzE4rQWmt5+zB/tk9xloQxWsLBv0
 HsjlFPrGOeg7nJRkg2ROA07XHyE7i507MXkDKZx1etBbAfzJOdUtAXrmaNrrFAQdh5r4
 AAh90s50k8z5x1P1CV1Mrwxot2Tb67Ap5kwaF1zqk13MiaMEAzVg+E0w0+weVDgmxBS4
 lHDqKpeSBml5oyTKU6lVeZ8ai9xCOx/hwwBPKpb28N4+4eqMplJTSPElxY9H4+v64Ul3
 ISMjWJhU72h2ZvAKoMnKSbAPVOF4XmBeXGezU6mftOFsS9knwrb5dMyNfKHmvjgtMrM5
 UcjQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781614110; x=1782218910; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xo9B2zq4rGYcnm+39yqKdPD2maqALDisS96fz0g8Ymc=;
 b=WUEJMnkBqjNkuQ0EQoQ9KZAVn/4gVVW2fXLpaftDXnYpZuX28HgIisK3ULnNzyuWPU
 RDXt1/PFjiQ4p40Qu51InFA4meQiNTMWz4KYlGu1JtRTrhQbmIcL8/bwX9JpHkDotqWh
 csSSWnDXqt3jPpjYDY6O/vCX6cOfGazV5vjqi2BshWfOI4JxMM4G6BCwY10QnqV4x3LB
 V3QTE9815C104wxDs2tOG5LGT6/BlY3SEkicLSHqPFTbHFkGrmZuMxmAFUA3zE/i9g40
 KIy391wVYnmDgQeIICC2whBQnFeBpTQfran5KuFLdrtX23xS8KF7DgOHVZb79adOcDTv
 7MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781614110; x=1782218910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xo9B2zq4rGYcnm+39yqKdPD2maqALDisS96fz0g8Ymc=;
 b=GGXJs+7R6phoLGTMs/bto6E0pGcxPeVTW+qvBm8SzZF479HpHOW2SawB3oqXqX6Esz
 vJ6JC9osys8m6PaMrj6ucK4PsmiQWuAN/dHj220ceWUxeBRzaUsZs+Up5eouVB0TDiNs
 yYmo5StizUIpll/d5UgG6uYwW/iGcPW2633MwReW16xD1oQRq3vKC0coRQkF6gmkBRqf
 pMQSpeSSbofFHCgRtlA/iyIZoa7Fx4PGZy08jZrmVSVTYflGyIiz277Uw16hGdF635xM
 Jbo2azMAgg6vZ2/Rx1uNfUPmTrUp+TbRuBDjgsclo3w75ta0cF5YnUhlxTg0y1U//f0G
 aGbQ==
X-Gm-Message-State: AOJu0YylJbM2e8KNR/PjMcx0rG7KxEGvHvRhWsdaf0MNZJNH/hj+/Uf2
 bOvWrGuH1lv1DA1aHkn6j0PmfxeNnWeTCzQKh5GDTMNqZyTG//GMgEoThDOo6li868aaw+nDDot
 M2LhXLCGqWqUgHrha7Sq1VRtVHr0zRDzvZun1
X-Gm-Gg: Acq92OGo2xNtO4KwUcqFXzr0WrX0y+0tseLLaYZGrl4uz1nutxatuL58A7Bvr65eTZr
 SAN/wMUssTkT6BwUC6Wu/Iutf/Q3cdjVh7qZL+RXtvmHaj4rQ0SJfwBOeDxuzcnBFNcbd6JdK32
 QuMllfhzrqAQW5uFHp8ZdBu5ko4DhwO7Z81Lsu2s6Vlz2UppshSuviBP9OeV5FL8jfGNQUQwqJg
 9E5fhx1OIY+yoQaV8VoX2TMtMVqe5wAdR36184PUElOdRAMbVraM8JHZVXoP4eD0/U4czKuEe/d
 AZdnMZ4nnHw0CjEbkHCT
X-Received: by 2002:ac8:7f4e:0:b0:517:960d:1cbc with SMTP id
 d75a77b69052e-51991af4508mr45589741cf.45.1781614109896; Tue, 16 Jun 2026
 05:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250803090837.15589edd@hermes.local>
 <20250804035430.4058391-1-spiderdetective.ss@gmail.com>
 <20260608100202.0deac83d@phoenix.local>
In-Reply-To: <20260608100202.0deac83d@phoenix.local>
From: su sai <spiderdetective.ss@gmail.com>
Date: Tue, 16 Jun 2026 20:48:17 +0800
X-Gm-Features: AVVi8CfoGob-5obSZvjbntkH3fjRx5EQjt5CFqJz-mfdw0mVE-99RLVdvt1tarU
Message-ID: <CAFQeoKjJmFMFq7dL_s7rN0vyC-M+Sk1QgNtvVtP1SniqOap8vw@mail.gmail.com>
Subject: Re: [v3] net/cksum: compute raw cksum for several segments
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000025b25106545e5c65"
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

--00000000000025b25106545e5c65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen, I've revised the patch per your feedback and sent out v4:
net/cksum: compute raw cksum for several segments. Your review is
appreciated.

On Tue, Jun 9, 2026 at 1:02=E2=80=AFAM Stephen Hemminger <stephen@networkpl=
umber.org>
wrote:

> On Mon,  4 Aug 2025 11:54:30 +0800
> Su Sai <spiderdetective.ss@gmail.com> wrote:
>
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
> > ---
> >  .mailmap              |   1 +
> >  app/test/test_cksum.c | 106 ++++++++++++++++++++++++++++++++++++++++++
> >  lib/net/rte_cksum.h   |  27 +++++++++--
> >  3 files changed, 130 insertions(+), 4 deletions(-)
> >
> > diff --git a/.mailmap b/.mailmap
> > index 34a99f93a1..1da1d9f8e1 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -1552,6 +1552,7 @@ Sunil Kumar Kori <skori@marvell.com> <
> sunil.kori@nxp.com>
> >  Sunil Pai G <sunil.pai.g@intel.com>
> >  Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
> >  Sun Jiajia <sunx.jiajia@intel.com>
> > +Su Sai <spiderdetective.ss@gmail.com> <susai.ss@bytedance.com>
> >  Sunyang Wu <sunyang.wu@jaguarmicro.com>
> >  Surabhi Boob <surabhi.boob@intel.com>
> >  Suyang Ju <sju@paloaltonetworks.com>
> > diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
> > index f2ab5af5a7..fb2e3cf9e6 100644
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
> > @@ -223,6 +259,70 @@ test_l4_cksum(struct rte_mempool *pktmbuf_pool,
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
> > +             rte_memcpy(data, pktdata + off, segs[i]);
>
> Tests (except rte_memcpy test) should not use rte_memcpy, instead use
> regular memcpy which has better coverage from analyzers.
>
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
> > +     for (i =3D 0; i < segs_len; i++)
> > +             rte_pktmbuf_free(m[i]);
>
> Can avoid the loop here and elsewhere by using rte_pktmbuf_free_bulk()
>
> > +     return 0;
> > +
> > +fail:
> > +     for (i =3D 0; i < segs_len; i++) {
> > +             if (m[i])
> > +                     rte_pktmbuf_free(m[i]);
> > +     }
>
> Freebulk will work here
>
> > +     return -1;
> > +}
> > +
> >  static int
> >  test_cksum(void)
> >  {
> > @@ -256,6 +356,12 @@ test_cksum(void)
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
>
>

--00000000000025b25106545e5c65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen, I&#39;ve revised the patch per your feedback a=
nd sent out v4: net/cksum: compute raw cksum for several segments. Your rev=
iew is appreciated.</div><br><div class=3D"gmail_quote gmail_quote_containe=
r"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 9, 2026 at 1:02=E2=80=
=AFAM Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org">s=
tephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On Mon,=C2=A0 4 Aug 2025 11:54:30 +0800<br>
Su Sai &lt;<a href=3D"mailto:spiderdetective.ss@gmail.com" target=3D"_blank=
">spiderdetective.ss@gmail.com</a>&gt; wrote:<br>
<br>
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
&gt; ---<br>
&gt;=C2=A0 .mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A01 +<br>
&gt;=C2=A0 app/test/test_cksum.c | 106 ++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 lib/net/rte_cksum.h=C2=A0 =C2=A0|=C2=A0 27 +++++++++--<br>
&gt;=C2=A0 3 files changed, 130 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/.mailmap b/.mailmap<br>
&gt; index 34a99f93a1..1da1d9f8e1 100644<br>
&gt; --- a/.mailmap<br>
&gt; +++ b/.mailmap<br>
&gt; @@ -1552,6 +1552,7 @@ Sunil Kumar Kori &lt;<a href=3D"mailto:skori@mar=
vell.com" target=3D"_blank">skori@marvell.com</a>&gt; &lt;<a href=3D"mailto=
:sunil.kori@nxp.com" target=3D"_blank">sunil.kori@nxp.com</a>&gt;<br>
&gt;=C2=A0 Sunil Pai G &lt;<a href=3D"mailto:sunil.pai.g@intel.com" target=
=3D"_blank">sunil.pai.g@intel.com</a>&gt;<br>
&gt;=C2=A0 Sunil Uttarwar &lt;<a href=3D"mailto:sunilprakashrao.uttarwar@am=
d.com" target=3D"_blank">sunilprakashrao.uttarwar@amd.com</a>&gt;<br>
&gt;=C2=A0 Sun Jiajia &lt;<a href=3D"mailto:sunx.jiajia@intel.com" target=
=3D"_blank">sunx.jiajia@intel.com</a>&gt;<br>
&gt; +Su Sai &lt;<a href=3D"mailto:spiderdetective.ss@gmail.com" target=3D"=
_blank">spiderdetective.ss@gmail.com</a>&gt; &lt;<a href=3D"mailto:susai.ss=
@bytedance.com" target=3D"_blank">susai.ss@bytedance.com</a>&gt;<br>
&gt;=C2=A0 Sunyang Wu &lt;<a href=3D"mailto:sunyang.wu@jaguarmicro.com" tar=
get=3D"_blank">sunyang.wu@jaguarmicro.com</a>&gt;<br>
&gt;=C2=A0 Surabhi Boob &lt;<a href=3D"mailto:surabhi.boob@intel.com" targe=
t=3D"_blank">surabhi.boob@intel.com</a>&gt;<br>
&gt;=C2=A0 Suyang Ju &lt;<a href=3D"mailto:sju@paloaltonetworks.com" target=
=3D"_blank">sju@paloaltonetworks.com</a>&gt;<br>
&gt; diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c<br>
&gt; index f2ab5af5a7..fb2e3cf9e6 100644<br>
&gt; --- a/app/test/test_cksum.c<br>
&gt; +++ b/app/test/test_cksum.c<br>
&gt; @@ -85,6 +85,42 @@ static const char test_cksum_ipv4_opts_udp[] =3D {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A00x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,<br=
>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
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
&gt; @@ -223,6 +259,70 @@ test_l4_cksum(struct rte_mempool *pktmbuf_pool, c=
onst char *pktdata, size_t len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_memcpy(data, pktd=
ata + off, segs[i]);<br>
<br>
Tests (except rte_memcpy test) should not use rte_memcpy, instead use<br>
regular memcpy which has better coverage from analyzers.<br>
<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; segs_len; i++)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_pktmbuf_free(m[i]=
);<br>
<br>
Can avoid the loop here and elsewhere by using rte_pktmbuf_free_bulk()<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; segs_len; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (m[i])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rte_pktmbuf_free(m[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
Freebulk will work here<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 test_cksum(void)<br>
&gt;=C2=A0 {<br>
&gt; @@ -256,6 +356,12 @@ test_cksum(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sizeof(test_cksum_ipv4_opts_udp)) &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GOTO_FAIL(&quot;=
checksum error on ipv4_opts_udp&quot;);<br>
&gt;=C2=A0 <br>
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
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h<br>
&gt; index a8e8927952..679ba82eb6 100644<br>
&gt; --- a/lib/net/rte_cksum.h<br>
&gt; +++ b/lib/net/rte_cksum.h<br>
&gt; @@ -80,6 +80,25 @@ __rte_raw_cksum_reduce(uint32_t sum)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return (uint16_t)sum;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
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
&gt;=C2=A0 <br>
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
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0*cksum =3D __rte_raw_cksum_reduce(sum);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*cksum =3D __rte_raw_cksum_reduce_u64(sum);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
<br>
</blockquote></div>

--00000000000025b25106545e5c65--
