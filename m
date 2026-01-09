Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936F1D26D7D
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 17:50:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CE4D4028E;
	Fri,  9 Jan 2026 18:50:58 +0100 (CET)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54]) by mails.dpdk.org (Postfix) with ESMTP id 96757400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 18:50:57 +0100 (CET)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-5efa4229bd2so339737137.0
 for <dev@dpdk.org>; Fri, 09 Jan 2026 09:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767981057; x=1768585857; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuAAycXxYTBsD73w5X/eW8uSpGGJAr7+ohmxDeBV5kU=;
 b=h/MTAL4nZ5B4Cw0ESNSVYRtCbnTbKq3D9rBx+P4sMHnn2XCBP8LsiJxbwBK4xapjkC
 jVqKh+jFIVI1eVbZUI8hQYOHGmb5N7TuWFAOkWXFbcabloe2u94cSolHKSjyatgR3Rkd
 9O155Pjf32pmqyhWCA/mMNoKBrRhf/Z3Wyqiqvwveonj5sL5PoVwO5MtrAMQNiiZ2mIR
 SmyV2zJPcb3NqhVxsuJ3xPpZBjpEpAiX7H9i0T7iTXXqaXtyqWqXCNwnH07+Bvnj4bsr
 qN+awlRmjE0/TP2xHxZlpsNdw+YgRAH+7giSXaKqy+28RmXoIM3xc6PrREfsGrOmZyWm
 ttDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767981057; x=1768585857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iuAAycXxYTBsD73w5X/eW8uSpGGJAr7+ohmxDeBV5kU=;
 b=ZSWFfg7XXxWWQljMWzpwO2cslcf8KacefWxEmBLjj3yyXaJwtKmwAmrk9SuU31ypuJ
 /th4FW+OVM+7kBiKrFJv8zUaJKzeSXlf8NrqCy4QNlI1uVZ+xElnLPeO9qlNVRouYryY
 vEg95IgDNMZR3fFas6oOcUMMDN3db3VWjrvufISsKuIx8MfnN4v0nus5OJejMowR9Xjd
 rL2j8D1h2GA4zCw0wGC1pj4CE2cO5ZCaNDeq72ATw2jxPpO0KavUPsstCXMJguRLFZ/r
 w5c2EnLAE+j9Kx/Gw8ODJc5sQmOXi0+WOVcAaLg8xcSszz2VVgIAsPUbQIFOw0U2jKwk
 /pig==
X-Gm-Message-State: AOJu0YyXRbCvSfRMO7Kdhbx3dVCDwCR52CKVDDubWJg6+NBpJzQmdlVY
 oU9FGxBpUtn1W29Jlgxf6+8rV+ABUmqLC4pFXQu6rYL8+g4Mu+N7adTJrizzOmxuIvUysQP2z1u
 ziRCVQTzow9cmx/yf2AOySycyUtF73c4=
X-Gm-Gg: AY/fxX4tw5PwkwRe2VZAv08LpZJDQkc5G5+3yJvCUy4vDrq951EuRqE1dhUs/k2YSiY
 4nWPVOTqEoQx4nvYZBLiuVRZaZ2r3Ng1MxdjVVEEUQLxgfKA4wf8i+BoEfjvD0ZB5pKEvAqmeHQ
 qQ4h6q9fm0AVeTPQrOKHVA5s3ea7ilVdODXtKNwXvsLTdByxsnrwy2DhhAP1QEajqOZlaMGIfLq
 lT5MlZwEbRE4QPVg5d8rsQ/TzbGw21zGGlby3A6dNqZwUWHiJ45Th1w0m6otWRSFWADY3ECyRsn
 bV7pouK+qu5VI3tSm5OjIvPK1lSvjhFyoiUTPw==
X-Google-Smtp-Source: AGHT+IHR1agCkXv19cBsKFzdY4vT9plCmSXNzxo3i5wbnJUgKM/q7D6EEYgkoMrmynrDcpBfRxk3zIJFmlLNeRBd0qE=
X-Received: by 2002:a05:6102:3e82:b0:5db:d60a:6b1a with SMTP id
 ada2fe7eead31-5ecb69624bemr5106717137.30.1767981056744; Fri, 09 Jan 2026
 09:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20260108214713.52987-1-scott.k.mitch1@gmail.com>
 <20260108213916.618cb75a@phoenix.local>
In-Reply-To: <20260108213916.618cb75a@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 9 Jan 2026 12:50:46 -0500
X-Gm-Features: AZwV_QhjQLluoSVrrRyQElMpeDq691PybK6rTwfLpktmWZbfMV-rKQ_yV3uA3L8
Message-ID: <CAFn2buA5NzmzA0+t1_5auigvQTyT7Ne6RMVaPVU=sdC03nd2Lg@mail.gmail.com>
Subject: Re: [PATCH v9] net: optimize raw checksum computation
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, mb@smartsharesystems.com
Content-Type: text/plain; charset="UTF-8"
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

Manual unroll makes sense! Are you OK if we land minimal changes for
__rte_raw_cksum optimization and consider manual unrolling of
ipv4/ipv6 headers as a follow up? Morten requested I break the
patch up and minimize changes (I'm working on this now). If these
were the only cases causing pain for my patch it makes more sense
to do the unroll first, but there are other cases to consider:

- mlx5_flow_dv.c usage of __rte_raw_cksum could arguably
be unrolled too, but consider a trade-off of spreading around
manual unroll code. one option is for rte_cksum.h to have
specialized unrolled length functions to keep the code consolidated
(but then additional API surface).
- hinic_pmd_tx.c - should call rte_ipv6_phdr_cksum and
rte_ipv4_phdr_cksum instead of duplicating logic.


On Fri, Jan 9, 2026 at 12:39=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu,  8 Jan 2026 16:47:13 -0500
> scott.k.mitch1@gmail.com wrote:
>
> > diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
> > index d1abf1f5d5..8a7e5e4b8a 100644
> > --- a/lib/net/rte_ip6.h
> > +++ b/lib/net/rte_ip6.h
> > @@  -560,19 +560,18 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *i=
pv6_hdr, uint64_t ol_flags)
> >  static inline uint16_t
> >  rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_f=
lags)
> >  {
> > -     uint32_t sum;
> >       struct {
> >               rte_be32_t len;   /* L4 length. */
> >               rte_be32_t proto; /* L4 protocol - top 3 bytes must be ze=
ro */
> > -     } psd_hdr;
> > -
> > -     psd_hdr.proto =3D (uint32_t)(ipv6_hdr->proto << 24);
> > -     if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> > -             psd_hdr.len =3D 0;
> > -     else
> > -             psd_hdr.len =3D ipv6_hdr->payload_len;
> > +     } psd_hdr =3D {
> > +             .len =3D (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_=
TX_UDP_SEG))
> > +                     ? (rte_be32_t)0
> > +                     : ipv6_hdr->payload_len,
> > +             .proto =3D (uint32_t)(ipv6_hdr->proto << 24)
> > +     };
> > +     RTE_SUPPRESS_UNINITIALIZED_WARNING(psd_hdr);
> >
> > -     sum =3D __rte_raw_cksum(&ipv6_hdr->src_addr,
> > +     uint32_t sum =3D __rte_raw_cksum(&ipv6_hdr->src_addr,
> >               sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr),
> >               0);
> >       sum =3D __rte_raw_cksum(&psd_hdr, sizeof(psd_hdr), sum);
> > --
>
> Seems like this could be unrolled as well.
>
> static inline uint16_t
> rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_flag=
s)
> {
>         union {
>                 struct {
>                         struct rte_ipv6_addr src_addr;  /* 16 bytes */
>                         struct rte_ipv6_addr dst_addr;  /* 16 bytes */
>                         rte_be32_t len;                 /* 4 bytes  */
>                         rte_be32_t proto;               /* 4 bytes  */
>                 } psd;
>                 uint16_t u16[20];
>         } hdr =3D {
>                 .psd =3D {
>                         .src_addr =3D ipv6_hdr->src_addr,
>                         .dst_addr =3D ipv6_hdr->dst_addr,
>                         .proto =3D (uint32_t)(ipv6_hdr->proto << 24),
>                 }
>         };
>         uint32_t sum;
>
>         if (!(ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))=
)
>                 hdr.psd.len =3D ipv6_hdr->payload_len;
>
>         /* Unrolled sum of 20 uint16_t words:
>          * [0-7]:   src_addr
>          * [8-15]:  dst_addr
>          * [16-17]: len
>          * [18-19]: proto (3 zero bytes + next header)
>          */
>         sum =3D hdr.u16[0]  + hdr.u16[1]  + hdr.u16[2]  + hdr.u16[3]  +
>               hdr.u16[4]  + hdr.u16[5]  + hdr.u16[6]  + hdr.u16[7]  +
>               hdr.u16[8]  + hdr.u16[9]  + hdr.u16[10] + hdr.u16[11] +
>               hdr.u16[12] + hdr.u16[13] + hdr.u16[14] + hdr.u16[15] +
>               hdr.u16[16] + hdr.u16[17] + hdr.u16[18] + hdr.u16[19];
>
>         sum =3D (sum & 0xffff) + (sum >> 16);
>         sum =3D (sum & 0xffff) + (sum >> 16);
>         return (uint16_t)sum;
> }
