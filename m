Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AAFD0D171
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 22:06:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADA824028B;
	Wed,  7 Jan 2026 23:06:40 +0100 (CET)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by mails.dpdk.org (Postfix) with ESMTP id 511274021E
 for <dev@dpdk.org>; Wed,  7 Jan 2026 23:06:39 +0100 (CET)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-55b09d690dcso922205e0c.1
 for <dev@dpdk.org>; Wed, 07 Jan 2026 14:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767823598; x=1768428398; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8QcyIitTfAZVzUmtQJqQZwcNWef1VYLoKGuUz3DQ/c=;
 b=RJ/et1ICTB1idQlC6SAvocNaHomzg4QcVj/Cn9PdlCj5ysVDaXnkn2sdhyp+ZPbW1J
 HBCkhigBFV3IzPR/GrKccvpg3gDpfV3VW0v+uZKpVtYR9SFz6hKb47H7FWQrSzQxh3MU
 572tuy257fWyPc4JDCuMahVsJs3JPppR+hJRnGZTHgIET6vBlSf5WYG72iv6MtVZy8yn
 sPvodCduHL23Niyg92nnZJUzKbhcpe66ua8TYltXWqhvpQRIC/ssq/vjzpWcqjUjuZ9p
 lZQkiX4+ulWn3c49X9+YyQi5V8Qef41lAzSejariVoJUH5zAc1rMviIZa6Eo9RiYKexb
 NzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767823598; x=1768428398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t8QcyIitTfAZVzUmtQJqQZwcNWef1VYLoKGuUz3DQ/c=;
 b=oaMAMQg79Zrtfa74vVgcnVuvuyGhB6mvi2uZQJswIyIUmg+tVE+ow4eMyG5RX3D54C
 ic8FY3d95CceiCsZU1QOtYq0zFuvUJntRNIL7Paz43kmvFz4vbk4CFrYpT670xNtj/eg
 5eq79ocR1SD9xITvi1zJE1Khn7XcDwwk8STaV1JmP40FuuXQh5McUJBbSrhlQIYm4dUr
 94sSMIUGhsxKefFFR4tPAXeWW1cl4GMCr/EeV+gB8UIZMY6ylAc4qADuIKsaR406mBT+
 5RGe7JhMDi6d7lNl4g+tfPyR2TlZsA0/+2+PEjSGPm0iUHvNu1T4ho/H9Rdai+TKiJdI
 cnyA==
X-Gm-Message-State: AOJu0YzzPazcZGw9Z5dPmHCAEEtGCFihoO+T/nASX1IHRNZLwNNRl3SP
 Rz6xRndIhd3eGI/0I4WXbBU2D3+YHRtQ/88Kv8fgiAGH55anBGsb5qD79Mo0wfaX5WHi8aQJajI
 f5AX/kCUMoOsE283IY2DTKSyURtJQxT/0DE5+
X-Gm-Gg: AY/fxX6A4T+TqYCwFzTNKxTvkkaz4ZxyNU/DnaeJF14njzzPG8wxwK1sLBApxk09MUL
 48GqLCq5Xoxx56xlX2K0z58boY3ejsOx9Kdudoe/r2ZRNuem6ujYwaSrLgAMk97An6tsxFUGX4j
 eZUX9z8FgDHy3iRE2PcomoT0hH7w1TZ38gG8h7qj2rz60a8pKrnrPdifHyqX1ZpEjfXqZAJTACw
 eH9oQIxvvbwl4pD+IhkwkXWaTZBFfwpuLGGIj4wXXvDXcVJ4KI8fB/nFHReux9gX3iTDPG4OWJy
 0/TZ4tDwDXqyfKXgezzvWOQScRQ=
X-Google-Smtp-Source: AGHT+IET4+oPZndLYDC3cxFW3WNNaUy/eahFrtOW3zxhl8qnOMJOHuRE0mpLlNgfVfHr5zsR2kZ6MMfcU8iLN9VMspw=
X-Received: by 2002:a05:6102:1608:b0:5e4:956c:e7ce with SMTP id
 ada2fe7eead31-5ecb1e8dbb4mr1501307137.1.1767823598235; Wed, 07 Jan 2026
 14:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20260107170415.80275-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65630@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65630@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 7 Jan 2026 17:06:26 -0500
X-Gm-Features: AQt7F2q4vFrJ29Wo77URqE-JR-KHvOCdzIA_yETBQxQWk_k6rl5pU_T6Os50FGE
Message-ID: <CAFn2buBEwDXGpo4rVbDhtj9X3nqc25xRM5ZfUwU6NER4+SF6oQ@mail.gmail.com>
Subject: Re: [PATCH v3] net: optimize raw checksum computation
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
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

On Wed, Jan 7, 2026 at 12:56=E2=80=AFPM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com> wrote:
>
> > From: scott.k.mitch1@gmail.com [mailto:scott.k.mitch1@gmail.com]
> > Sent: Wednesday, 7 January 2026 18.04
> >
> > From: Scott Mitchell <scott.k.mitch1@gmail.com>
> >
> > Optimize __rte_raw_cksum() by processing data in larger unrolled loops
> > instead of iterating word-by-word. The new implementation processes
> > 64-byte blocks (32 x uint16_t) in the hot path, followed by smaller
> > 32/16/8/4/2-byte chunks.
>
> Playing around with Godbolt:
> https://godbolt.org/z/oYdP9xxfG
>
> With the original code (built with -msse4.2), the compiler vectorizes the=
 loop to process 16-byte chunks (instead of the 2-byte chunks the source co=
de indicates).
> When built with -mavx512f, it processes 32-byte chunks.
>
> IMHO, the compiled output of the new code is too big; using more than 12 =
kB instructions consumes too much L1 Instruction Cache.
> I suppose the compiler both vectorizes and loop unrolls.

Good observation, and godbolt is very handy! Agreed this patch isn't
desirable on x86-64 with gcc 15.2. I am using clang 18.1.8 (Redhat)
and the original version doesn't vectorize while my patch does
vectorize and icache isn't as bloated as gcc (explains the perf
difference).

I'm exploring an approach that will vectorize on both gcc and clang
and will submit an update soon.

>
> >
> > Uses uint32_t accumulator with explicit casts to prevent signed integer
> > overflow and leverages unaligned_uint16_t for safe unaligned access on
> > all platforms. Adds __rte_no_ubsan_alignment attribute to suppress
> > false
> > positive alignment warnings from UndefinedBehaviorSanitizer.
> >
> > Performance results from cksum_perf_autotest (TSC cycles/byte):
> >   Block size    Before    After    Improvement
> >          100  0.40-0.64  0.13-0.14    ~3-4x
> >         1500  0.49-0.51  0.10-0.11    ~4-5x
> >         9000  0.48-0.51  0.11-0.12    ~4x
>
> On which machine do you achieve these perf numbers?
>
> Can a measurable performance increase be achieved using significantly sma=
ller compiled code than this patch?
>
> >
> > Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> > ---
> > Changes in v3:
> > - Added __rte_no_ubsan_alignment macro to suppress false-positive UBSAN
> >   alignment warnings when using unaligned_uint16_t
> > - Fixed false-positive GCC maybe-uninitialized warning in rte_ip6.h
> > exposed
> >   by optimization (can be split to separate patch once verified on CI)
> >
> > Changes in v2:
> > - Fixed UndefinedBehaviorSanitizer errors by adding uint32_t casts to
> > prevent
> >   signed integer overflow in addition chains
> > - Restored uint32_t sum accumulator instead of uint64_t
> > - Added 64k length to test_cksum_perf.c
> >
>
>
> > diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
> > index a8e8927952..d6e313dea5 100644
> > --- a/lib/net/rte_cksum.h
> > +++ b/lib/net/rte_cksum.h
> > @@ -39,24 +39,64 @@ extern "C" {
> >   * @return
> >   *   sum +=3D Sum of all words in the buffer.
> >   */
> > +__rte_no_ubsan_alignment
> >  static inline uint32_t
> >  __rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
> >  {
> > -     const void *end;
> > +     /* Process in 64 byte blocks (32 x uint16_t). */
> > +     /* Always process as uint16_t chunks to preserve overflow/carry.
> > */
> > +     const void *end =3D RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, 64));
> > +     while (buf !=3D end) {
> > +             const unaligned_uint16_t *p16 =3D (const unaligned_uint16=
_t
> > *)buf;
> > +             sum +=3D (uint32_t)p16[0] + p16[1] + p16[2] + p16[3] +
> > +                      p16[4] + p16[5] + p16[6] + p16[7] +
> > +                      p16[8] + p16[9] + p16[10] + p16[11] +
> > +                      p16[12] + p16[13] + p16[14] + p16[15] +
> > +                      p16[16] + p16[17] + p16[18] + p16[19] +
> > +                      p16[20] + p16[21] + p16[22] + p16[23] +
> > +                      p16[24] + p16[25] + p16[26] + p16[27] +
> > +                      p16[28] + p16[29] + p16[30] + p16[31];
> > +             buf =3D RTE_PTR_ADD(buf, 64);
> > +     }
> >
> > -     for (end =3D RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len,
> > sizeof(uint16_t)));
> > -          buf !=3D end; buf =3D RTE_PTR_ADD(buf, sizeof(uint16_t))) {
> > -             uint16_t v;
> > +     if (len & 32) {
> > +             const unaligned_uint16_t *p16 =3D (const unaligned_uint16=
_t
> > *)buf;
> > +             sum +=3D (uint32_t)p16[0] + p16[1] + p16[2] + p16[3] +
> > +                      p16[4] + p16[5] + p16[6] + p16[7] +
> > +                      p16[8] + p16[9] + p16[10] + p16[11] +
> > +                      p16[12] + p16[13] + p16[14] + p16[15];
> > +             buf =3D RTE_PTR_ADD(buf, 32);
> > +     }
> >
> > -             memcpy(&v, buf, sizeof(uint16_t));
> > -             sum +=3D v;
> > +     if (len & 16) {
> > +             const unaligned_uint16_t *p16 =3D (const unaligned_uint16=
_t
> > *)buf;
> > +             sum +=3D (uint32_t)p16[0] + p16[1] + p16[2] + p16[3] +
> > +                      p16[4] + p16[5] + p16[6] + p16[7];
> > +             buf =3D RTE_PTR_ADD(buf, 16);
> >       }
> >
> > -     /* if length is odd, keeping it byte order independent */
> > -     if (unlikely(len % 2)) {
> > -             uint16_t left =3D 0;
> > +     if (len & 8) {
> > +             const unaligned_uint16_t *p16 =3D (const unaligned_uint16=
_t
> > *)buf;
> > +             sum +=3D (uint32_t)p16[0] + p16[1] + p16[2] + p16[3];
> > +             buf =3D RTE_PTR_ADD(buf, 8);
> > +     }
> >
> > -             memcpy(&left, end, 1);
> > +     if (len & 4) {
> > +             const unaligned_uint16_t *p16 =3D (const unaligned_uint16=
_t
> > *)buf;
> > +             sum +=3D (uint32_t)p16[0] + p16[1];
> > +             buf =3D RTE_PTR_ADD(buf, 4);
> > +     }
> > +
> > +     if (len & 2) {
> > +             const unaligned_uint16_t *p16 =3D (const unaligned_uint16=
_t
> > *)buf;
> > +             sum +=3D *p16;
> > +             buf =3D RTE_PTR_ADD(buf, 2);
> > +     }
> > +
> > +     /* If length is odd use memcpy for byte order independence */
> > +     if (len & 1) {
> > +             uint16_t left =3D 0;
> > +             memcpy(&left, buf, 1);
> >               sum +=3D left;
> >       }
> >
> > diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
> > index d1abf1f5d5..af65a39815 100644
> > --- a/lib/net/rte_ip6.h
> > +++ b/lib/net/rte_ip6.h
> > @@ -564,7 +564,7 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr
> > *ipv6_hdr, uint64_t ol_flags)
> >       struct {
> >               rte_be32_t len;   /* L4 length. */
> >               rte_be32_t proto; /* L4 protocol - top 3 bytes must be ze=
ro
> > */
> > -     } psd_hdr;
> > +     } psd_hdr =3D {0}; /* Empty initializer avoids false-positive
> > maybe-uninitialized warning */
> >
> >       psd_hdr.proto =3D (uint32_t)(ipv6_hdr->proto << 24);
> >       if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
>
> Maybe ipv6 can be fixed like this instead:
> -       if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> -               psd_hdr.len =3D 0;
> -       else
> -               psd_hdr.len =3D ipv6_hdr->payload_len;
> +       psd_hdr.len =3D (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_T=
X_UDP_SEG)) ?
> +                       0 : psd_hdr.len =3D ipv6_hdr->payload_len;
>
> > --
> > 2.39.5 (Apple Git-154)
>
