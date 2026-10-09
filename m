Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A882CA5FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 03:41:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62B864027A;
	Fri,  9 Oct 2026 05:41:28 +0200 (CEST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) by mails.dpdk.org (Postfix) with ESMTP id 1E0C54026D
 for <dev@dpdk.org>; Fri,  9 Oct 2026 05:41:27 +0200 (CEST)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c31745ad205so222027766b.0
 for <dev@dpdk.org>; Thu, 08 Oct 2026 20:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791517286; cv=none;
 d=google.com; s=arc-20260327;
 b=dbDso4HloO61ECteYtnqRobvFh/TqC0+xQ0Eb8kZPasye8YIewj7sI6b9EvIANkjDr
 +QKW7t6MnsKEff+cfR+JTmtElEoPBscEuIJ/Jd5CEz1mkXGk6kv4zKSAL3dgB3/Qkm7/
 5XWQfqGTxpWQLxnwuyO7RZ4c9MnsFuS8aYXHGZttWmh2J3bre4u8YWB4mQzN2xUVYpvo
 xyAOGrwl736XQe7ylzMuvq1MmlsOYqmeXFhKjH+anh+oOq6VNvrwaZBU498b5o6um7+X
 3NWvLBkvFTr3nnPOo9r37UHY1Rnaz0r9ZEk7f02BBoR26dy7B29MxMdefhXB0guZedgY
 zXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2cDXIro0aSujmgBjyzrczp3eEjbcrR83Vv7ekA+VTgo=;
 fh=JGfbzSQ1QRL8hLS1XbYAnHnBpNc/yOVmYGHN8+4G1vU=;
 b=YAH7ULKTOdsPYcCUyXOIjFuVYMCoZYKNCXnZjzMr72trxXkBMjlEeXytKOIIN6Ty1O
 lhHRsIVwONBVbrW8noI8CYc4PBum1YtngCZlHO5zreDtbeX0d1CCrqLEDBwIXX1iTlDb
 5mMaBCh8/griVPMnAXLDEwkKOzv9u0XUSgeV3K+p7xWyksS7wEH2Z95nyqHAPwA4ZroS
 +Z28CVzfwUfDIoTiF9c5Vp21PQWhjCSYFS0cifN3fH2V3r7tC887YdpjZNmRgsySqyLP
 cdaG/nvzLM5xGq2vr6I1hNIHqhh7Q890wGTnveLgdX7emgbIcZnv/lkJLWjYDw/sxhYB
 SVFA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791517286; x=1792122086; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2cDXIro0aSujmgBjyzrczp3eEjbcrR83Vv7ekA+VTgo=;
 b=Fs3MxjVtXCr2MOKKlNoxv96DdIQvMidwip0zg3IaCIaUzzq3sOa02xKG6DfDU1nrYL
 VsfWAT1CBtzqvPZsVLKHrOy8DA0HK+l+BnQ9nQ/YQkpgdIq2u5gQk9nw2gdWcuvaUOpq
 Sg/br8+CZnj37Tpvz8KF3yz83eR67hDd4UjeRArzTqMBVoLiOipDN0iGVokw6AZMxJ6a
 yj4zvB0H5VMbCjjSt3XpqoUp8wgHknMPYfMG0A12brMPpsoo4nKDmH+VmK3U1GyEm1Ps
 R3/+EmSOJZgr+QLrO+qvG5vYsHN0ihL1M0Z3UA+6BquD5QGF3h87SbfS581H0+iwNsp8
 Wwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791517286; x=1792122086;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2cDXIro0aSujmgBjyzrczp3eEjbcrR83Vv7ekA+VTgo=;
 b=iq9xYnwONqRhYxb8jTTSlBhfJspipErvLmvoIfKx3RoHtA64sqKA9dG/6AqPIfMFTu
 pZSVW3+ttKZklw8yI3URkvUjxnmFNakm40yUxGWT0fMU5Y+UjQxHfxyzs9pCe41Q8RpQ
 mylkagsvGVN2AbJcEnXTjELoeb1NU+r2buf1mT3BzSP4NNcaGEncJp7AmZd+GHnvG1h9
 kzYQySgJflb4Zmjy4crEFRDA+62w9lPp1tg/FOJA64IOrW38pBbNwzk1pQSG9SpsLUzP
 QT6H0yM7RkXUrl9NXX+3W4dgFjcNXolW3nXLU4q1MwSPq9zO8CBwFF5BmeNB3S/cVSBg
 ertg==
X-Gm-Message-State: AFuF++lLZwhDj8mNauGTvkZAuETZ/nDYZcl6cERdex+6qFft4cmjThrK
 9XmjarHSYe66sDcFUf4LsNiMz+Bd5uEVh/88VSGyNdg89pStPpdY93kBOEG7PzDnoIhlihiNCwa
 ray1FgTk7TdhraMzXkeNocK1Ucv0Htfg=
X-Gm-Gg: AYBFou2BKsA4xFf3gWl3QG8qYD+fJW1L50JhPWRS6KylghOI7mz3yBFGpnxZvNFUMcj
 sDL+6gjelgZLW4hnpU3Ay1jqPNFXnatpDduukzixT+ymqY4qBRoGF1NfdF+TbpeeyGnluSPZUqL
 rwdLcd1sZZf9+IImw+uUQMNexIgJST5+IJfZSLCE6YnZxRdBjbKTRqcM4XtURpANn8dRzfhpsrr
 rECkeLP5aLF7FwQGf21hee2WU08S+HTBt/LU96YoxH/SYkLgw7Kynp7ildZYUNiSMMbKZRnnY+Y
 376gInE+YB7ioiZf7ue57YAktOaF9LSuYPBEDriF8M7EEogxhGwnFQCW
X-Received: by 2002:a17:907:3f12:b0:c2d:cc6b:27bd with SMTP id
 a640c23a62f3a-c31aa0096d6mr61968466b.23.1791517286191; Thu, 08 Oct 2026
 20:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20261006151833.347561-1-16567adigashreesh@gmail.com>
 <2b8df94c-8ca3-4022-b9c4-d95970581b80@arm.com>
In-Reply-To: <2b8df94c-8ca3-4022-b9c4-d95970581b80@arm.com>
From: Shreesh Adiga <16567adigashreesh@gmail.com>
Date: Fri, 9 Oct 2026 09:11:13 +0530
X-Gm-Features: AclHuK_yWdl7nNr2UZiqw23x5QFvgEe7QtYwbw1kR3OUEJBQD2dQWs4micq0_Zs
Message-ID: <CA+-x59a25E_v6DvFF6HZ--sF3UrfcQ6p8gz29Y63tVjXF9aa8w@mail.gmail.com>
Subject: Re: [PATCH] net/crc: make NEON CRC folding logic similar to x86 SSE
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000073d540065d601f57"
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

--00000000000073d540065d601f57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wathsala,

I tested this on QEMU for correctness. I don't have access to any ARM
environment for precise benchmarking.
The only device I have is an Android phone where I can't compile DPDK
either.
I can isolate this code and use libbenchmark via Termux if that is
needed, but I don't expect to see large measurable benefits.

This patch is based on my previous work on FFmpeg's av_crc optimization for
aarch64 which you can
refer here: https://code.ffmpeg.org/FFmpeg/FFmpeg/pulls/21651

Thanks,
Shreesh

On Fri, Oct 9, 2026 at 8:54=E2=80=AFAM Wathsala Vithanage <
wathsala.vithanage@arm.com> wrote:

> Hi Shreesh,
>
> Looks correct. Can you share before and after performance data in the
> commit message covering short inputs below 16 bytes, lengths exercising
> the different nonzero remainders modulo 16, and larger buffers to show
> the effect on the folding loop?
>
> Thanks
>
> --wathsala
>
> On 10/6/26 10:18, Shreesh Adiga wrote:
> > This patch includes the following minor changes:
> > 1) Use TBL based shift left for variable len shift instead of using
> >     vshift_bytes_left which adds a switch case for 16 len cases.
> > 2) Align the fold constants to use PMULL and PMULL2 instructions
> >     instead of using cross lane operands which requires additional shif=
t.
> > 3) Remove unnecessary static arrays used in crc32_reduce_64_to_32 by
> >     adapting x86 SSE logic.
> > 4) Use x86 SSE logic for processing partial bytes sequence to avoid
> >     using multiple variable len shifts which inserts switch case.
> >
> > Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> > ---
> >   lib/net/net_crc_neon.c | 71 +++++++++++++++++++++++++++--------------=
-
> >   1 file changed, 46 insertions(+), 25 deletions(-)
> >
> > diff --git a/lib/net/net_crc_neon.c b/lib/net/net_crc_neon.c
> > index d924aed25d..3833fcba6e 100644
> > --- a/lib/net/net_crc_neon.c
> > +++ b/lib/net/net_crc_neon.c
> > @@ -24,6 +24,31 @@ struct crc_pmull_ctx {
> >   alignas(16) struct crc_pmull_ctx crc32_eth_pmull;
> >   alignas(16) struct crc_pmull_ctx crc16_ccitt_pmull;
> >
> > +static const alignas(16) uint8_t crc_neon_shift_tab[32] =3D {
> > +     0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
> > +     0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
> > +     0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> > +     0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
> > +};
> > +
> > +/**
> > + * Shifts left 128 bit register by specified number of bytes
> > + *
> > + * @param reg
> > + *   128 bit value
> > + * @param num
> > + *   number of bytes to shift left reg by (0-16)
> > + *
> > + * @return
> > + *   reg << (num * 8)
> > + */
> > +static inline uint64x2_t
> > +neon_shift_left(uint64x2_t reg, const unsigned int num)
> > +{
> > +     uint8x16_t tbl =3D vld1q_u8(crc_neon_shift_tab + 16 - num);
> > +     return vreinterpretq_u64_u8(vqtbl1q_u8(vreinterpretq_u8_u64(reg),
> tbl));
> > +}
> > +
> >   /**
> >    * @brief Performs one folding round
> >    *
> > @@ -46,12 +71,12 @@ crcr32_folding_round(uint64x2_t data_block,
> uint64x2_t precomp,
> >       uint64x2_t fold)
> >   {
> >       uint64x2_t tmp0 =3D vreinterpretq_u64_p128(vmull_p64(
> > -                     vgetq_lane_p64(vreinterpretq_p64_u64(fold), 1),
> > +                     vgetq_lane_p64(vreinterpretq_p64_u64(fold), 0),
> >                       vgetq_lane_p64(vreinterpretq_p64_u64(precomp),
> 0)));
> >
> > -     uint64x2_t tmp1 =3D vreinterpretq_u64_p128(vmull_p64(
> > -                     vgetq_lane_p64(vreinterpretq_p64_u64(fold), 0),
> > -                     vgetq_lane_p64(vreinterpretq_p64_u64(precomp),
> 1)));
> > +     uint64x2_t tmp1 =3D vreinterpretq_u64_p128(vmull_high_p64(
> > +                     vreinterpretq_p64_u64(fold),
> > +                     vreinterpretq_p64_u64(precomp)));
> >
> >       return veorq_u64(tmp1, veorq_u64(data_block, tmp0));
> >   }
> > @@ -98,26 +123,19 @@ static inline uint32_t
> >   crcr32_reduce_64_to_32(uint64x2_t data64,
> >       uint64x2_t precomp)
> >   {
> > -     static alignas(16) uint32_t mask1[4] =3D {
> > -             0xffffffff, 0xffffffff, 0x00000000, 0x00000000
> > -     };
> > -     static alignas(16) uint32_t mask2[4] =3D {
> > -             0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
> > -     };
> >       uint64x2_t tmp0, tmp1, tmp2;
> >
> > -     tmp0 =3D vandq_u64(data64, vld1q_u64((uint64_t *)mask2));
> > +     tmp0 =3D vreinterpretq_u64_u32(
> > +             vsetq_lane_u32(0, vreinterpretq_u32_u64(data64), 0));
> >
> >       tmp1 =3D vreinterpretq_u64_p128(vmull_p64(
> >               vgetq_lane_p64(vreinterpretq_p64_u64(tmp0), 0),
> >               vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 0)));
> >       tmp1 =3D veorq_u64(tmp1, tmp0);
> > -     tmp1 =3D vandq_u64(tmp1, vld1q_u64((uint64_t *)mask1));
> >
> >       tmp2 =3D vreinterpretq_u64_p128(vmull_p64(
> >               vgetq_lane_p64(vreinterpretq_p64_u64(tmp1), 0),
> >               vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 1)));
> > -     tmp2 =3D veorq_u64(tmp2, tmp1);
> >       tmp2 =3D veorq_u64(tmp2, tmp0);
> >
> >       return vgetq_lane_u32(vreinterpretq_u32_u64(tmp2), 2);
> > @@ -177,10 +195,10 @@ crc32_eth_calc_pmull(
> >               fold =3D vld1q_u64((uint64_t *)buffer);
> >               fold =3D veorq_u64(fold, temp);
> >               if (unlikely(data_len < 4)) {
> > -                     fold =3D vshift_bytes_left(fold, 8 - data_len);
> > +                     fold =3D neon_shift_left(fold, 8 - data_len);
> >                       goto barret_reduction;
> >               }
> > -             fold =3D vshift_bytes_left(fold, 16 - data_len);
> > +             fold =3D neon_shift_left(fold, 16 - data_len);
> >               goto reduction_128_64;
> >       }
> >
> > @@ -201,14 +219,17 @@ crc32_eth_calc_pmull(
> >
> >       /** Partial bytes - process last <16 bytes */
> >       if (likely(n < data_len)) {
> > -             uint64x2_t last16, a, b, mask;
> > +             uint8x16_t last16, t1, t2;
> > +             uint64x2_t a, b;
> >               uint32_t rem =3D data_len & 15;
> >
> > -             last16 =3D vld1q_u64((const uint64_t *)&data[data_len - 1=
6]);
> > -             a =3D vshift_bytes_left(fold, 16 - rem);
> > -             b =3D vshift_bytes_right(fold, rem);
> > -             mask =3D vshift_bytes_left(vdupq_n_u64(-1), 16 - rem);
> > -             b =3D vorrq_u64(b, vandq_u64(mask, last16));
> > +             last16 =3D vld1q_u8((const uint8_t *)&data[data_len - 16]=
);
> > +             t1 =3D vld1q_u8(crc_neon_shift_tab + rem);
> > +             a  =3D
> vreinterpretq_u64_u8(vqtbl1q_u8(vreinterpretq_u8_u64(fold), t1));
> > +             t2 =3D vmvnq_u8(t1);
> > +             t2 =3D vqtbl1q_u8(vreinterpretq_u8_u64(fold), t2);
> > +             t1 =3D vcgezq_s8(vreinterpretq_s8_u8(t1));
> > +             b  =3D vreinterpretq_u64_u8(vbslq_u8(t1, last16, t2));
> >
> >               /* k =3D rk3 & rk4 */
> >               fold =3D crcr32_folding_round(b, k, a);
> > @@ -230,14 +251,14 @@ void
> >   rte_net_crc_neon_init(void)
> >   {
> >       /* Initialize CRC16 data */
> > -     uint64_t ccitt_k1_k2[2] =3D {0x14ff2LLU, 0x19a3cLLU};
> > -     uint64_t ccitt_k3_k4[2] =3D {0x189aeLLU, 0x8e10LLU};
> > +     uint64_t ccitt_k1_k2[2] =3D {0x19a3cLLU, 0x14ff2LLU};
> > +     uint64_t ccitt_k3_k4[2] =3D {0x8e10LLU, 0x189aeLLU};
> >       uint64_t ccitt_k5_k6[2] =3D {0x189aeLLU, 0x114aaLLU};
> >       uint64_t ccitt_k7_k8[2] =3D {0x11c581910LLU, 0x10811LLU};
> >
> >       /* Initialize CRC32 data */
> > -     uint64_t eth_k1_k2[2] =3D {0x1c6e41596LLU, 0x154442bd4LLU};
> > -     uint64_t eth_k3_k4[2] =3D {0xccaa009eLLU, 0x1751997d0LLU};
> > +     uint64_t eth_k1_k2[2] =3D {0x154442bd4LLU, 0x1c6e41596LLU};
> > +     uint64_t eth_k3_k4[2] =3D {0x1751997d0LLU, 0xccaa009eLLU};
> >       uint64_t eth_k5_k6[2] =3D {0xccaa009eLLU, 0x163cd6124LLU};
> >       uint64_t eth_k7_k8[2] =3D {0x1f7011640LLU, 0x1db710641LLU};
> >
>

--00000000000073d540065d601f57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Wathsala,</div><div><br></div><div>I tested this o=
n QEMU for correctness. I don&#39;t have access to any ARM environment for =
precise benchmarking.</div><div>The only device I have is an Android phone =
where I can&#39;t compile DPDK either.</div><div>I can isolate this code an=
d use libbenchmark=C2=A0via Termux if that is needed,=C2=A0but I don&#39;t =
expect=C2=A0to see large measurable=C2=A0benefits.</div><div><br></div><div=
>This patch is based on my previous work on FFmpeg&#39;s av_crc optimizatio=
n for aarch64 which you can</div><div>refer here:=C2=A0<a href=3D"https://c=
ode.ffmpeg.org/FFmpeg/FFmpeg/pulls/21651">https://code.ffmpeg.org/FFmpeg/FF=
mpeg/pulls/21651</a></div><div><br></div><div>Thanks,</div><div>Shreesh</di=
v></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Oct 9, 2026 at 8:54=E2=80=AFAM Wathsala Vit=
hanage &lt;<a href=3D"mailto:wathsala.vithanage@arm.com">wathsala.vithanage=
@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Hi Shreesh,<br>
<br>
Looks correct. Can you share before and after performance data in the<br>
commit message covering short inputs below 16 bytes, lengths exercising<br>
the different nonzero remainders modulo 16, and larger buffers to show<br>
the effect on the folding loop?<br>
<br>
Thanks<br>
<br>
--wathsala<br>
<br>
On 10/6/26 10:18, Shreesh Adiga wrote:<br>
&gt; This patch includes the following minor changes:<br>
&gt; 1) Use TBL based shift left for variable len shift instead of using<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0vshift_bytes_left which adds a switch case for 16 l=
en cases.<br>
&gt; 2) Align the fold constants to use PMULL and PMULL2 instructions<br>
&gt;=C2=A0 =C2=A0 =C2=A0instead of using cross lane operands which requires=
 additional shift.<br>
&gt; 3) Remove unnecessary static arrays used in crc32_reduce_64_to_32 by<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0adapting x86 SSE logic.<br>
&gt; 4) Use x86 SSE logic for processing partial bytes sequence to avoid<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0using multiple variable len shifts which inserts sw=
itch case.<br>
&gt;<br>
&gt; Signed-off-by: Shreesh Adiga &lt;<a href=3D"mailto:16567adigashreesh@g=
mail.com" target=3D"_blank">16567adigashreesh@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/net/net_crc_neon.c | 71 +++++++++++++++++++++++++++---=
------------<br>
&gt;=C2=A0 =C2=A01 file changed, 46 insertions(+), 25 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/net/net_crc_neon.c b/lib/net/net_crc_neon.c<br>
&gt; index d924aed25d..3833fcba6e 100644<br>
&gt; --- a/lib/net/net_crc_neon.c<br>
&gt; +++ b/lib/net/net_crc_neon.c<br>
&gt; @@ -24,6 +24,31 @@ struct crc_pmull_ctx {<br>
&gt;=C2=A0 =C2=A0alignas(16) struct crc_pmull_ctx crc32_eth_pmull;<br>
&gt;=C2=A0 =C2=A0alignas(16) struct crc_pmull_ctx crc16_ccitt_pmull;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static const alignas(16) uint8_t crc_neon_shift_tab[32] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A00xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f<br=
>
&gt; +};<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Shifts left 128 bit register by specified number of bytes<br>
&gt; + *<br>
&gt; + * @param reg<br>
&gt; + *=C2=A0 =C2=A0128 bit value<br>
&gt; + * @param num<br>
&gt; + *=C2=A0 =C2=A0number of bytes to shift left reg by (0-16)<br>
&gt; + *<br>
&gt; + * @return<br>
&gt; + *=C2=A0 =C2=A0reg &lt;&lt; (num * 8)<br>
&gt; + */<br>
&gt; +static inline uint64x2_t<br>
&gt; +neon_shift_left(uint64x2_t reg, const unsigned int num)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint8x16_t tbl =3D vld1q_u8(crc_neon_shift_tab + =
16 - num);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return vreinterpretq_u64_u8(vqtbl1q_u8(vreinterpr=
etq_u8_u64(reg), tbl));<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * @brief Performs one folding round<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt; @@ -46,12 +71,12 @@ crcr32_folding_round(uint64x2_t data_block, uint64=
x2_t precomp,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64x2_t fold)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64x2_t tmp0 =3D vreinterpretq_u64_p128(v=
mull_p64(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vgetq_lane_p64(vreinterpretq_p64_u64(fold), 1),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vgetq_lane_p64(vreinterpretq_p64_u64(fold), 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 0)));<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint64x2_t tmp1 =3D vreinterpretq_u64_p128(vmull_=
p64(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vgetq_lane_p64(vreinterpretq_p64_u64(fold), 0),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 1)));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint64x2_t tmp1 =3D vreinterpretq_u64_p128(vmull_=
high_p64(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vreinterpretq_p64_u64(fold),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vreinterpretq_p64_u64(precomp)));<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return veorq_u64(tmp1, veorq_u64(data_block,=
 tmp0));<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; @@ -98,26 +123,19 @@ static inline uint32_t<br>
&gt;=C2=A0 =C2=A0crcr32_reduce_64_to_32(uint64x2_t data64,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64x2_t precomp)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0static alignas(16) uint32_t mask1[4] =3D {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xffffffff, 0xfffffff=
f, 0x00000000, 0x00000000<br>
&gt; -=C2=A0 =C2=A0 =C2=A0};<br>
&gt; -=C2=A0 =C2=A0 =C2=A0static alignas(16) uint32_t mask2[4] =3D {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00000000, 0xfffffff=
f, 0xffffffff, 0xffffffff<br>
&gt; -=C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64x2_t tmp0, tmp1, tmp2;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tmp0 =3D vandq_u64(data64, vld1q_u64((uint64_t *)=
mask2));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp0 =3D vreinterpretq_u64_u32(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsetq_lane_u32(0, vre=
interpretq_u32_u64(data64), 0));<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp1 =3D vreinterpretq_u64_p128(vmull_p64(<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgetq_lane_p64(v=
reinterpretq_p64_u64(tmp0), 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgetq_lane_p64(v=
reinterpretq_p64_u64(precomp), 0)));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp1 =3D veorq_u64(tmp1, tmp0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tmp1 =3D vandq_u64(tmp1, vld1q_u64((uint64_t *)ma=
sk1));<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp2 =3D vreinterpretq_u64_p128(vmull_p64(<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgetq_lane_p64(v=
reinterpretq_p64_u64(tmp1), 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgetq_lane_p64(v=
reinterpretq_p64_u64(precomp), 1)));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tmp2 =3D veorq_u64(tmp2, tmp1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp2 =3D veorq_u64(tmp2, tmp0);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return vgetq_lane_u32(vreinterpretq_u32_u64(=
tmp2), 2);<br>
&gt; @@ -177,10 +195,10 @@ crc32_eth_calc_pmull(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold =3D vld1q_u=
64((uint64_t *)buffer);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold =3D veorq_u=
64(fold, temp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(dat=
a_len &lt; 4)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0fold =3D vshift_bytes_left(fold, 8 - data_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0fold =3D neon_shift_left(fold, 8 - data_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto barret_reduction;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold =3D vshift_bytes=
_left(fold, 16 - data_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold =3D neon_shift_l=
eft(fold, 16 - data_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto reduction_1=
28_64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -201,14 +219,17 @@ crc32_eth_calc_pmull(<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Partial bytes - process last &lt;16 byte=
s */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (likely(n &lt; data_len)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64x2_t last16, a,=
 b, mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8x16_t last16, t1=
, t2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64x2_t a, b;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t rem =3D=
 data_len &amp; 15;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0last16 =3D vld1q_u64(=
(const uint64_t *)&amp;data[data_len - 16]);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a =3D vshift_bytes_le=
ft(fold, 16 - rem);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b =3D vshift_bytes_ri=
ght(fold, rem);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mask =3D vshift_bytes=
_left(vdupq_n_u64(-1), 16 - rem);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b =3D vorrq_u64(b, va=
ndq_u64(mask, last16));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0last16 =3D vld1q_u8((=
const uint8_t *)&amp;data[data_len - 16]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t1 =3D vld1q_u8(crc_n=
eon_shift_tab + rem);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a=C2=A0 =3D vreinterp=
retq_u64_u8(vqtbl1q_u8(vreinterpretq_u8_u64(fold), t1));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t2 =3D vmvnq_u8(t1);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t2 =3D vqtbl1q_u8(vre=
interpretq_u8_u64(fold), t2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t1 =3D vcgezq_s8(vrei=
nterpretq_s8_u8(t1));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=C2=A0 =3D vreinterp=
retq_u64_u8(vbslq_u8(t1, last16, t2));<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* k =3D rk3 &am=
p; rk4 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fold =3D crcr32_=
folding_round(b, k, a);<br>
&gt; @@ -230,14 +251,14 @@ void<br>
&gt;=C2=A0 =C2=A0rte_net_crc_neon_init(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Initialize CRC16 data */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint64_t ccitt_k1_k2[2] =3D {0x14ff2LLU, 0x19a3cL=
LU};<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint64_t ccitt_k3_k4[2] =3D {0x189aeLLU, 0x8e10LL=
U};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t ccitt_k1_k2[2] =3D {0x19a3cLLU, 0x14ff2L=
LU};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t ccitt_k3_k4[2] =3D {0x8e10LLU, 0x189aeLL=
U};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t ccitt_k5_k6[2] =3D {0x189aeLLU, 0x1=
14aaLLU};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t ccitt_k7_k8[2] =3D {0x11c581910LLU,=
 0x10811LLU};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Initialize CRC32 data */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint64_t eth_k1_k2[2] =3D {0x1c6e41596LLU, 0x1544=
42bd4LLU};<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint64_t eth_k3_k4[2] =3D {0xccaa009eLLU, 0x17519=
97d0LLU};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t eth_k1_k2[2] =3D {0x154442bd4LLU, 0x1c6e=
41596LLU};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint64_t eth_k3_k4[2] =3D {0x1751997d0LLU, 0xccaa=
009eLLU};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t eth_k5_k6[2] =3D {0xccaa009eLLU, 0x=
163cd6124LLU};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t eth_k7_k8[2] =3D {0x1f7011640LLU, 0=
x1db710641LLU};<br>
&gt;=C2=A0 =C2=A0<br>
</blockquote></div>

--00000000000073d540065d601f57--
