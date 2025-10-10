Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2074BCCA476
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 14:32:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9EC94021E;
	Fri, 10 Oct 2025 16:32:09 +0200 (CEST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id C15314003C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 16:32:08 +0200 (CEST)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b3d5088259eso305479566b.1
 for <dev@dpdk.org>; Fri, 10 Oct 2025 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760106728; x=1760711528; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TRxCZGcCcgqFQnT+u43nZuD3+Nh48IXCNP40ttOeV/w=;
 b=mlK6JjeyjeI06+jXR5KoZlSPOA+FTJp+vhuR3OJtdODv35cODSt9TK16qz//RC+2B0
 Swb8Ynzk/I0l9Ouu2s5CCcXMfFTrYIPr0mOL9esjPdaAxg5giVNwRAjiSYK9+F1NcKOF
 GyrrGclb02M23W/tPPFGThZBdZR2U/TZBfPWWCCJ9+r2iJsFSRWMM/oP0Jrx2JoHqRi7
 BTh829AX7ehx3Nt5Bsg8RijJW2ZmAtVFBdpZzCwVpekOd1aLh7ZovYfc6aN5lyhZdCdd
 Hsta/93roRawE/5cfPM/qOtW+wIU/0sGR235P/endAVz7/q+yh1xsxIeiEWMP05CDszM
 07Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760106728; x=1760711528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRxCZGcCcgqFQnT+u43nZuD3+Nh48IXCNP40ttOeV/w=;
 b=XJeTyoY4V+WuMeMyBumL8AzxgeBuZc8bmOOo3+WiSsP7jyvATe2DRp9mcTHf9WsAEk
 y0LnBUTpHETID2rOYV243OHtTAWweuZuNUS82jefU+naLDczfIAAv3owiH/6SFO3iAQX
 fxQzo5+xwR1oipGDkMZMoA1rbuxKEOU+oA8w/q+n+FB1kzSIPMUIR4mBLhEkddgUtYZp
 7wF/pBT94Jtobd0uj6+SKuhfxpN+qbIUMiASEoI/hqizvSB195yU9xmiqVxx6a3d/kr2
 2P0xdDJQZkWkTXp/ZlL2mX8I4RmCM7ayjNKGHQf1W7T8rPsGpfd76WM1MK/5Ny1Fp6GP
 liCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKMWGEA/f+AWuYKKDMerYMr+rw8qIfkBR+BvvjkwXqxFsvDiYu1gO+WGeK5pWWyqYvG3I=@dpdk.org
X-Gm-Message-State: AOJu0YzFti3vz/vUSdDBc+GX6VRDwUaPTOGFJH2DBK1+VVI/Xw9uFxI/
 +5deAfB9cra3t6VEFkAUfUAEMATKvtY02++NWJsQcPfpEdf7bYY7FwbGIZYd7zYVBKTdpydDnTg
 G4syFn4cWGDj+ZnT8SEpowLaXtaeEwuZLadYu
X-Gm-Gg: ASbGncutoSZzNENg/DDxDYALGggD7WWETwn72yLLUhgA7hJWugeJ+jv0dH25C6mInhv
 VaPgK3sk5ftEg1vPsHbGWIH6VsL/rrrMp0htHArF/x+0cS2gb41oyOZzt2WC67kcdZBBLT+jPTn
 46hQN5b+1CYvOJ4NoODWq2XhZdsDtpSpOBGOW9JZZvf2dtNyvnZWF7N6oyrJuOoC6ARUKmZUm1x
 yQfXE5zEpmD/uXMcE77iZIFa8CMx5jxQjYQ
X-Google-Smtp-Source: AGHT+IEQG7qzCe9yZfgCZbpTgZtYSB1kbBlT1fJLXcLNQg6d/RGu3r6u9JyZUFG1iDg/sQNwuT6UZvixsTokUBNWJ0g=
X-Received: by 2002:a17:906:6a2a:b0:b42:7c2:1f9f with SMTP id
 a640c23a62f3a-b50acc1aa50mr1326987966b.62.1760106728014; Fri, 10 Oct 2025
 07:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250716103439.831760-1-16567adigashreesh@gmail.com>
 <aOflvyl1Ow9N7Mve@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aOflvyl1Ow9N7Mve@bricha3-mobl1.ger.corp.intel.com>
From: Shreesh Adiga <16567adigashreesh@gmail.com>
Date: Fri, 10 Oct 2025 20:01:56 +0530
X-Gm-Features: AS18NWD9vHIvp1GPKtQ-96fMebEm_wiUXDYj3FohrSTkKytosk48jxiqELU4jVo
Message-ID: <CA+-x59YPCR_xGNoiJNy0AvFuZUrtjMeUhxD0GoGhAg-KJEm7MA@mail.gmail.com>
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, 
 Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000004a4fc50640cec844"
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

--0000000000004a4fc50640cec844
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 10:11=E2=80=AFPM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

> On Wed, Jul 16, 2025 at 04:04:39PM +0530, Shreesh Adiga wrote:
> > Replace the clearing of lower 32 bits of XMM register with blend of
> > zero register.
> > Replace the clearing of upper 64 bits of XMM register with
> _mm_move_epi64.
> > Clang is able to optimize away the AND + memory operand with the
> > above sequence, however GCC is still emitting the code for AND with
> > memory operands which is being explicitly eliminated here.
> >
> > Additionally replace the 48 byte crc_xmm_shift_tab with the contents of
> > shf_table which is 32 bytes, achieving the same functionality.
> >
> > Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> > ---
> >  lib/net/net_crc_sse.c | 30 +++++++-----------------------
> >  1 file changed, 7 insertions(+), 23 deletions(-)
> >
>
> See inline below. Changes to the reduce_64_to_32 look ok, I don't know
> enough to understand fully the other changes you made. Maybe split the
> patch into two patches for review and merge separately?
>
> /Bruce
>
> > diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
> > index 112dc94ac1..eec854e587 100644
> > --- a/lib/net/net_crc_sse.c
> > +++ b/lib/net/net_crc_sse.c
> > @@ -96,20 +96,13 @@ crcr32_reduce_128_to_64(__m128i data128, __m128i
> precomp)
> >  static __rte_always_inline uint32_t
> >  crcr32_reduce_64_to_32(__m128i data64, __m128i precomp)
> >  {
> > -     static const alignas(16) uint32_t mask1[4] =3D {
> > -             0xffffffff, 0xffffffff, 0x00000000, 0x00000000
> > -     };
> > -
> > -     static const alignas(16) uint32_t mask2[4] =3D {
> > -             0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
> > -     };
> >       __m128i tmp0, tmp1, tmp2;
> >
> > -     tmp0 =3D _mm_and_si128(data64, _mm_load_si128((const __m128i
> *)mask2));
> > +     tmp0 =3D _mm_blend_epi16(_mm_setzero_si128(), data64, 252);
>
> Minor nit: 252 would be better in hex to make it clearer that it's the
> lower two bits are unset. Even better, how about switching the operands s=
o
> that the constant is just "3", which is clearer again.
>
Okay I will update it with your suggestion in the next patch.


> >
> >       tmp1 =3D _mm_clmulepi64_si128(tmp0, precomp, 0x00);
> >       tmp1 =3D _mm_xor_si128(tmp1, tmp0);
> > -     tmp1 =3D _mm_and_si128(tmp1, _mm_load_si128((const __m128i *)mask=
1));
> > +     tmp1 =3D _mm_move_epi64(tmp1);
> >
>
> This change LGTM.
>
> >       tmp2 =3D _mm_clmulepi64_si128(tmp1, precomp, 0x10);
> >       tmp2 =3D _mm_xor_si128(tmp2, tmp1);
> > @@ -118,13 +111,11 @@ crcr32_reduce_64_to_32(__m128i data64, __m128i
> precomp)
> >       return _mm_extract_epi32(tmp2, 2);
> >  }
> >
> > -static const alignas(16) uint8_t crc_xmm_shift_tab[48] =3D {
> > -     0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> > -     0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> > +static const alignas(16) uint8_t crc_xmm_shift_tab[32] =3D {
> > +     0x00, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
> > +     0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
> >       0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> > -     0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> > -     0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> > -     0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
> > +     0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
> >  };
> >
>
> Can you perhaps explain how changing this table doesn't break existing us=
es
> of the table as it now is in the code? Specifically, does xmm_shift_left
> function not now have different behaviour?
>
Sure, crc_xmm_shift_tab is only used inside xmm_shift_left which is only
used when
the total data_len is < 16. We call xmm_shift_left(fold, 8 - data_len) when
len <=3D 4 and
xmm_shift_left(fold, 16 - data_len) when 5 <=3D len <=3D 15. This results i=
n
accessing
crc_xmm_shift_tab between 1 and 31, i.e. element 0 is never accessed.

Now if we take a specific case of xmm_shift_left(fold, 10), then previously
the shuffle register
would get loaded with (crc_xmm_shift_tab + 16 - 10) which would be
crc_xmm_shift_tab + 6:
{0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x01,
0x02, 0x03, 0x04, 0x05} which
when used with PSHUFB would result in first 10 bytes of reg being 0 and the
lower 6
elements moving left: {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, d1, d2, d3, d4, d5,
d6}. The 0 get inserted
because PSHUFB with index > 0x7f (MSB set) results in 0.

Now since we have replaced the contents of crc_xmm_shift_tab
with shf_table, we will load:
{0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x00, 0x01,
0x02, 0x03, 0x04, 0x05}
into the index register. Since the first 10 elements have MSB set, PSHUFB
will again result in the
same vector above with first 10 elements being zeroes and the 6 moving left
as intended.
Since xmm_shift_left is called with num between 11 and 1, we don't
access crc_xmm_shift_tab[0]
and the remaining elements 0x8{i} behave identically to 0xff when used with
PSHUFB. Thus
the xmm_shift_left behavior for currently used num values inside this file
has identical behavior.


>
> >  /**
> > @@ -216,19 +207,12 @@ crc32_eth_calc_pclmulqdq(
> >                       0x80808080, 0x80808080, 0x80808080, 0x80808080
> >               };
> >
> > -             const alignas(16) uint8_t shf_table[32] =3D {
> > -                     0x00, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
> > -                     0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
> > -                     0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> > -                     0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
> > -             };
> > -
> >               __m128i last16, a, b;
> >
> >               last16 =3D _mm_loadu_si128((const __m128i *)&data[data_le=
n -
> 16]);
> >
> >               temp =3D _mm_loadu_si128((const __m128i *)
> > -                     &shf_table[data_len & 15]);
> > +                     &crc_xmm_shift_tab[data_len & 15]);
> >               a =3D _mm_shuffle_epi8(fold, temp);
> >
> >               temp =3D _mm_xor_si128(temp,
> > --
> > 2.49.1
> >
>

--0000000000004a4fc50640cec844
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 9, =
2025 at 10:11=E2=80=AFPM Bruce Richardson &lt;<a href=3D"mailto:bruce.richa=
rdson@intel.com">bruce.richardson@intel.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On Wed, Jul 16, 2025 at 04:04:39=
PM +0530, Shreesh Adiga wrote:<br>
&gt; Replace the clearing of lower 32 bits of XMM register with blend of<br=
>
&gt; zero register.<br>
&gt; Replace the clearing of upper 64 bits of XMM register with _mm_move_ep=
i64.<br>
&gt; Clang is able to optimize away the AND + memory operand with the<br>
&gt; above sequence, however GCC is still emitting the code for AND with<br=
>
&gt; memory operands which is being explicitly eliminated here.<br>
&gt; <br>
&gt; Additionally replace the 48 byte crc_xmm_shift_tab with the contents o=
f<br>
&gt; shf_table which is 32 bytes, achieving the same functionality.<br>
&gt; <br>
&gt; Signed-off-by: Shreesh Adiga &lt;<a href=3D"mailto:16567adigashreesh@g=
mail.com" target=3D"_blank">16567adigashreesh@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/net/net_crc_sse.c | 30 +++++++-----------------------<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 23 deletions(-)<br>
&gt; <br>
<br>
See inline below. Changes to the reduce_64_to_32 look ok, I don&#39;t know<=
br>
enough to understand fully the other changes you made. Maybe split the<br>
patch into two patches for review and merge separately?<br>
<br>
/Bruce<br>
<br>
&gt; diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c<br>
&gt; index 112dc94ac1..eec854e587 100644<br>
&gt; --- a/lib/net/net_crc_sse.c<br>
&gt; +++ b/lib/net/net_crc_sse.c<br>
&gt; @@ -96,20 +96,13 @@ crcr32_reduce_128_to_64(__m128i data128, __m128i p=
recomp)<br>
&gt;=C2=A0 static __rte_always_inline uint32_t<br>
&gt;=C2=A0 crcr32_reduce_64_to_32(__m128i data64, __m128i precomp)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0static const alignas(16) uint32_t mask1[4] =3D {<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xffffffff, 0xfffffff=
f, 0x00000000, 0x00000000<br>
&gt; -=C2=A0 =C2=A0 =C2=A0};<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0static const alignas(16) uint32_t mask2[4] =3D {<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00000000, 0xfffffff=
f, 0xffffffff, 0xffffffff<br>
&gt; -=C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__m128i tmp0, tmp1, tmp2;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0tmp0 =3D _mm_and_si128(data64, _mm_load_si128((co=
nst __m128i *)mask2));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp0 =3D _mm_blend_epi16(_mm_setzero_si128(), dat=
a64, 252);<br>
<br>
Minor nit: 252 would be better in hex to make it clearer that it&#39;s the<=
br>
lower two bits are unset. Even better, how about switching the operands so<=
br>
that the constant is just &quot;3&quot;, which is clearer again.<br></block=
quote><div>Okay I will update it with your suggestion in the next patch.=C2=
=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp1 =3D _mm_clmulepi64_si128(tmp0, precomp,=
 0x00);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp1 =3D _mm_xor_si128(tmp1, tmp0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tmp1 =3D _mm_and_si128(tmp1, _mm_load_si128((cons=
t __m128i *)mask1));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp1 =3D _mm_move_epi64(tmp1);<br>
&gt;=C2=A0 <br>
<br>
This change LGTM.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp2 =3D _mm_clmulepi64_si128(tmp1, precomp,=
 0x10);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp2 =3D _mm_xor_si128(tmp2, tmp1);<br>
&gt; @@ -118,13 +111,11 @@ crcr32_reduce_64_to_32(__m128i data64, __m128i p=
recomp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return _mm_extract_epi32(tmp2, 2);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static const alignas(16) uint8_t crc_xmm_shift_tab[48] =3D {<br>
&gt; -=C2=A0 =C2=A0 =C2=A00xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A00xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<b=
r>
&gt; +static const alignas(16) uint8_t crc_xmm_shift_tab[32] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A00x00, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A00x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A00x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x=
07,<br>
&gt; -=C2=A0 =C2=A0 =C2=A00x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A00xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A00xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A00x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f<br=
>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
<br>
Can you perhaps explain how changing this table doesn&#39;t break existing =
uses<br>
of the table as it now is in the code? Specifically, does xmm_shift_left<br=
>
function not now have different behaviour?<br></blockquote><div>Sure,=C2=A0=
crc_xmm_shift_tab is only used inside=C2=A0xmm_shift_left which is only use=
d when</div><div>the total data_len is &lt; 16. We call=C2=A0xmm_shift_left=
(fold, 8 - data_len) when len &lt;=3D 4 and</div><div>xmm_shift_left(fold, =
16 - data_len) when 5 &lt;=3D len &lt;=3D 15. This results in accessing</di=
v><div>crc_xmm_shift_tab between 1 and 31, i.e. element 0 is never accessed=
.</div><div><br></div><div>Now if we take a specific case of xmm_shift_left=
(fold, 10), then previously the shuffle register</div><div>would get loaded=
 with=C2=A0(crc_xmm_shift_tab + 16 - 10) which would be crc_xmm_shift_tab=
=C2=A0+ 6:</div><div>{0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=
 0xff, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05} which</div><div>when used with P=
SHUFB would result in first 10 bytes of reg being 0 and the lower 6</div><d=
iv>elements moving left: {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, d1, d2, d3, d4, d5,=
 d6}. The 0 get inserted</div><div>because PSHUFB with index &gt; 0x7f (MSB=
 set) results in 0.</div><div><br></div><div>Now since we have replaced the=
 contents of=C2=A0crc_xmm_shift_tab with=C2=A0shf_table, we will load:</div=
><div>{0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x00, 0x=
01, 0x02, 0x03, 0x04, 0x05}</div><div>into the index register. Since the fi=
rst 10 elements have MSB set, PSHUFB will again result in the=C2=A0</div><d=
iv>same vector above=C2=A0with first 10 elements being zeroes and the 6 mov=
ing left as intended.</div><div>Since=C2=A0xmm_shift_left is called with nu=
m between 11 and 1, we don&#39;t access=C2=A0crc_xmm_shift_tab[0]</div><div=
>and the remaining elements 0x8{i} behave identically to 0xff when used wit=
h PSHUFB. Thus</div><div>the=C2=A0xmm_shift_left behavior for currently use=
d num values inside this file has identical behavior.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 /**<br>
&gt; @@ -216,19 +207,12 @@ crc32_eth_calc_pclmulqdq(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x80808080, 0x80808080, 0x80808080, 0x80808080<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const alignas(16) uin=
t8_t shf_table[32] =3D {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x00, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__m128i last16, =
a, b;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0last16 =3D _mm_l=
oadu_si128((const __m128i *)&amp;data[data_len - 16]);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D _mm_loa=
du_si128((const __m128i *)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;shf_table[data_len &amp; 15]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;crc_xmm_shift_tab[data_len &amp; 15]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a =3D _mm_shuffl=
e_epi8(fold, temp);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D _mm_xor=
_si128(temp,<br>
&gt; -- <br>
&gt; 2.49.1<br>
&gt; <br>
</blockquote></div></div>

--0000000000004a4fc50640cec844--
