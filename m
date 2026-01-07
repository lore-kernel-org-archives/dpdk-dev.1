Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98298D0D178
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 22:28:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A4CB4028B;
	Wed,  7 Jan 2026 23:28:56 +0100 (CET)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45]) by mails.dpdk.org (Postfix) with ESMTP id 06BA44021E
 for <dev@dpdk.org>; Wed,  7 Jan 2026 23:28:53 +0100 (CET)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-5eae7bb8018so987679137.2
 for <dev@dpdk.org>; Wed, 07 Jan 2026 14:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767824933; x=1768429733; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OaO7dPM4TgRD+g+kXwBNx8ciDHMI62RnjG4qycqV394=;
 b=PcMnVj9jL0GRiNCIXEDYWwaVbxWXl7e7xniA5LRmcrZjDb54VLCbXzWjRKZmCGuxqG
 YBx3xSPAq8v/nTR5TS1piG8GB3q6i9Zy89d3TrI3xlXfDx5WTncN0OlH7guDJGMGtKEB
 OOLQZoCkgbL1jiGaruKHYl95PAig6YX+UGzaFywfLDsJXXnsDC7bf4zfWsx35mftN+Bp
 rpt/KqSGbL4jgeeoFJKDO3vARlJeLaEQ/drgoKBXokio4L7DIdV1IEVHozqHpoDrAMFG
 xj4PJFsjo5zNdrsd3kl5uQZBAxKRHjybOZTdY9cZs4PHTzDeEnVrmkhjalAZ86BvRrwr
 vojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767824933; x=1768429733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OaO7dPM4TgRD+g+kXwBNx8ciDHMI62RnjG4qycqV394=;
 b=s9rZpA9ia1HSpJ2u51WXzHk8l7vQyuA3YiIVlWMU2txSC2wLSYtV7AWfQurEiW9aq5
 IVW1icipQ0qfqPtyWnEPb1EdwKGU3YUcmnbsCyybuysyeabaCS7nRR2JRcpOaW3gcbYE
 DJQ2z3IzqE1ceDDRq01P+Ox4Dyl75+DSMa1ot16/MzSfDeE8BXcXKTzGXJro6j88Fncp
 RbjCrNHBb6zVgwhaFYhZMmCqSvPqUBw8g1BJvk29ugZvdbuAnS2CC0jjg2BzTw3hMllb
 TSbAGHqgHC4cWSd+qOjtl1Rthq8vwcxkWo95umqCWbUhsrD80Kq8usWXBDrqGE7sGxVV
 D69Q==
X-Gm-Message-State: AOJu0YwVtjHs9Ox56Q+THGafJR2R3z9IFIbe+L5xG4sAUPtQ0qDpBEk1
 K1W7xBB3QK6Zh8siX0/9+rCQjAouMSdtJ7p0mU6aTTDnlKCVxILZXYQjWUPVlrDMDEaFAdyhM0k
 461jO8ESL0yRA927EWpshKynYm+W1P10=
X-Gm-Gg: AY/fxX7WVRUEVQwkAgEGPF+nPYo6uu+T50V94keRU44Earfkl6PDRmUIyuQCqp0NRIF
 DEnS5tyX9Nqs+vkVkSFbIBGmcYiHYNDfUh4zR+QZreKFjBBEHCYI9M1Fmt64DMVmr0ijtyxYefZ
 khiHIuqeDa8UIfv8/QB4+z9Sh5CqmpBjSoQmYLvoq86K4GW5s3mUMewPpzA61Vrq/HDNUW9K4yp
 Y97gOHjUBfESLz15/MZcT7TAuDGAhHJbT+R++E7FHY6c8LCCvR6SVO83wc1eBqromrl1eXXZTbd
 J9tkKF1zl2NJ8LRn3eiVYMHFARs=
X-Google-Smtp-Source: AGHT+IEBDfsZPikIymsexjSFN8s9kkvqk8O5vJMw3SQkOpwq52isNwBhUStBGxKJdvihXU+jGAWH6v8pz//lGfyZUu8=
X-Received: by 2002:a05:6102:560b:b0:5db:3b75:a2aa with SMTP id
 ada2fe7eead31-5ecb688e212mr1607133137.18.1767824933245; Wed, 07 Jan 2026
 14:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20260107170415.80275-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65630@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65630@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 7 Jan 2026 17:28:41 -0500
X-Gm-Features: AQt7F2qNvAbNtJNe0P5AAxogWopwmicCQjUAfUkU6kxRbAdX-opT224KRTPBK9k
Message-ID: <CAFn2buCtACWQZd_EY2Y_k0KS6OQN-8BQmSghtH1CMC7afONs+w@mail.gmail.com>
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

(sorry missed this in my last response). I tried this and a few other
options (compound literal with each field explicitly initialized,
zero/empty initializer) the only code solution that removed the
warning was an explicit memset(0), but this also modified the
assembly. Safest option is to use memset (with some runtime cost) and
a fallback is to add the zero initializer "just in case the
compiler/target-architecture requires it" and add `#pragma GCC
diagnostic ignored "-Wmaybe-uninitialized"` for now to suppress
warning. I'll push the second option in my next patch and we can
discuss/adjust accordingly.

> > --
> > 2.39.5 (Apple Git-154)
>
