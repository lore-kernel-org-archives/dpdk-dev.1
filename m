Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0F7CEB2CA
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 10:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D6AC4029D;
	Sat, 15 Nov 2025 11:07:16 +0100 (CET)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id AC4E540288
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:07:14 +0100 (CET)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6406f3dcc66so4848552a12.3
 for <dev@dpdk.org>; Sat, 15 Nov 2025 02:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763201234; x=1763806034; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CkCd0/HWcn/ydlEkkQei6LFCWzLpSInL3iGJvxDgifk=;
 b=Ete0tOJlGIuf9zWiWkZApNV4R/Ausa+0KfxFvotKZnLJQfwMjSs2Wlzj48iKbHi4iL
 mD67jUEllCD+ZlFYl2I5+uNMP66n06ru+eKzeqHN5z8GNNnifpuV8J5LE2TNbhR2zk0P
 eN4trRAanrIiz9VzWzK4aakKaoPxCwbdj8fL347+ENn5Fo7eskikeXz3AyU2Gl9Zzmt+
 GjR31h5bg1uz5GhFYXp8R28W9k0lBQjdENuqkMCXdmrvzkkOQvwQMMRJoW+H1aIgGKe2
 OQSYmZAO22dDI/Cy9tb1Hm1+0gqR/tFpPc8FA95IB0uVguYhG1JSMONvh4ru4Coe6yHo
 5KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763201234; x=1763806034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkCd0/HWcn/ydlEkkQei6LFCWzLpSInL3iGJvxDgifk=;
 b=LgaXBnJy0uYjYn5+AqT5Iu0VBoKuzmAJZtSrNjKKQCenEY/ltXofJuX548/o++i2Qx
 YiXH+pUQYUzoGJjWTES29it3OzuFkxoI1nE0kZ1/0VkJwF36MkfQMXtadQMJrcWLEWV8
 aJA/+NTywPDIchaydRJ3Ui7NUhZXdZLm4j9AHOcwZ8IeTMgTjAgcyq6oBcYNr6qSOD8z
 yO5AgQs30ylDSh4k+3uIOuKbcpIv9Z/FrwmP4EtRvJ72TGG/7w70//D5ww9dJp+bzX7E
 pja6k6/4Q8279l3ahiCPLWA+ThiZJ/X29qKLGnyFPR15cMESg3hd8eR2p8RfNiWeOWqJ
 vaoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqdmf66GsT7CjNN/Wlx4/K61IMiRudhfd7Krq7feuvPfUjmwlf+nm1wXvqeV/3uueo1FY=@dpdk.org
X-Gm-Message-State: AOJu0YypMuW85IeZ3E66uw+uHWT9FBqOVFaUaZcfPJkxxqS0/BgvOYI+
 vjSVIZPbLehTrpR5YpMEJNQ0fS/J9VjbeDUyzo+OfW/gHJafXKWflIDojaDqBSrZ4CQ4Q7BJMxa
 PRFXSmvrtPBIRqTkgragztr5i8MzQWM0=
X-Gm-Gg: ASbGncv4Gck3PG3VsHYE046/2WJV/UFDG293LMLbiT/1x1H9QgSaF/M3T4/4zdH8IHE
 AZVQj1BrVx5aDJ9efMonFNR7XVfctrelocQkWkZk6Axoo4yxt+0K2v1yo+t+UaS6FUuv0BMimxV
 GvOMZ4FKw1OYvL2jOuZ+qBNwCQy1SnRT7OMoWvio8ARb8PUJz879RPM24x9STR2wtiKoJ0fWbxt
 nOcnX4yrl4mR0YQNJQk1rh8F2q0kYQNzC2Itnx+v+wS+qDT1Ve1PkDKxVc8fg==
X-Google-Smtp-Source: AGHT+IGYY9FuG0+hHhXk4f864hV4nCA+TqXtU5H1CwElYYgyJHLwnKDquo8qePNV0HGsxV2UHNM6kBENzj7WLqg6jHw=
X-Received: by 2002:a17:907:3d09:b0:b6d:4f1d:8c9b with SMTP id
 a640c23a62f3a-b73678f3399mr686773366b.28.1763201233925; Sat, 15 Nov 2025
 02:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20251011113202.937991-1-16567adigashreesh@gmail.com>
 <aRdPcuSLTPah6Zry@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aRdPcuSLTPah6Zry@bricha3-mobl1.ger.corp.intel.com>
From: Shreesh Adiga <16567adigashreesh@gmail.com>
Date: Sat, 15 Nov 2025 15:37:02 +0530
X-Gm-Features: AWmQ_bnVRV7AKgS3mSBtZB-SHKe3-kI-KTDyNVqG1vicCHzSvuBapf0lAwKpRD4
Message-ID: <CA+-x59aamcto-nwQooHFGTN_K_ahE+u7eb_aJG2kk6muo+MnGw@mail.gmail.com>
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, 
 Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000373af306439f4767"
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

--000000000000373af306439f4767
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 9:19=E2=80=AFPM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

> On Sat, Oct 11, 2025 at 04:59:34PM +0530, Shreesh Adiga wrote:
> > Replace the clearing of lower 32 bits of XMM register with blend of
> > zero register.
> > Remove the clearing of upper 64 bits of tmp1 as it is redundant.
> > tmp1 after clearing upper bits was being xor with tmp2 before the
> > bits 96:65 from tmp2 were returned. The xor operation of bits 96:65
> > remains unchanged due to tmp1 having bits 96:64 cleared to 0.
> > After removing the xor operation, the clearing of upper 64 bits of tmp1
> > becomes redundant and hence can be removed.
> > Clang is able to optimize away the AND + memory operand with the
> > above sequence, however GCC is still emitting the code for AND with
> > memory operands which is being explicitly eliminated here.
> >
> > Additionally replace the 48 byte crc_xmm_shift_tab with the contents of
> > shf_table which is 32 bytes, achieving the same functionality.
> >
> > Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> > ---
>
> Sorry for delay in getting back to look at the second version of this. Th=
e
> explanation, given in reponse to questions of v1, of the second set of
> changes in this makes sense.
>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
> Ideally, this patch should have been sent in reponse to v1 to keep the
> thread together. Also, I think this would be better split into two patche=
s,
> one for the reduce64_to_32 change and another for the shift table change.
> That way, you could include the fuller explanation of the second change i=
n
> the commit log to make easier review.
>

Sure I will send an updated patch after splitting into two patches.
Since I am not familiar with email based patch submissions, it ended up
being
a new thread, sorry about that. I will try to update this thread with the
new revision soon.


> > Changes since v1:
> > Reversed the operands in the blend operation for readability.
> > Removed tmp1 operations that are not affecting the result and hence
> > avoid clearing the upper 64 bits for tmp1.
> >
> >  lib/net/net_crc_sse.c | 30 ++++++------------------------
> >  1 file changed, 6 insertions(+), 24 deletions(-)
> >
> > diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
> > index 112dc94ac1..e590aeb5ac 100644
> > --- a/lib/net/net_crc_sse.c
> > +++ b/lib/net/net_crc_sse.c
> > @@ -96,35 +96,24 @@ crcr32_reduce_128_to_64(__m128i data128, __m128i
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
> > +     tmp0 =3D _mm_blend_epi16(data64, _mm_setzero_si128(), 0x3);
> >
> >       tmp1 =3D _mm_clmulepi64_si128(tmp0, precomp, 0x00);
> >       tmp1 =3D _mm_xor_si128(tmp1, tmp0);
> > -     tmp1 =3D _mm_and_si128(tmp1, _mm_load_si128((const __m128i *)mask=
1));
> >
> >       tmp2 =3D _mm_clmulepi64_si128(tmp1, precomp, 0x10);
> > -     tmp2 =3D _mm_xor_si128(tmp2, tmp1);
> >       tmp2 =3D _mm_xor_si128(tmp2, tmp0);
> >
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
> >  /**
> > @@ -216,19 +205,12 @@ crc32_eth_calc_pclmulqdq(
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

--000000000000373af306439f4767
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 14,=
 2025 at 9:19=E2=80=AFPM Bruce Richardson &lt;<a href=3D"mailto:bruce.richa=
rdson@intel.com">bruce.richardson@intel.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On Sat, Oct 11, 2025 at 04:59:34=
PM +0530, Shreesh Adiga wrote:<br>
&gt; Replace the clearing of lower 32 bits of XMM register with blend of<br=
>
&gt; zero register.<br>
&gt; Remove the clearing of upper 64 bits of tmp1 as it is redundant.<br>
&gt; tmp1 after clearing upper bits was being xor with tmp2 before the<br>
&gt; bits 96:65 from tmp2 were returned. The xor operation of bits 96:65<br=
>
&gt; remains unchanged due to tmp1 having bits 96:64 cleared to 0.<br>
&gt; After removing the xor operation, the clearing of upper 64 bits of tmp=
1<br>
&gt; becomes redundant and hence can be removed.<br>
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
<br>
Sorry for delay in getting back to look at the second version of this. The<=
br>
explanation, given in reponse to questions of v1, of the second set of<br>
changes in this makes sense.<br>
<br>
Acked-by: Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@intel.com=
" target=3D"_blank">bruce.richardson@intel.com</a>&gt;<br>
<br>
Ideally, this patch should have been sent in reponse to v1 to keep the<br>
thread together. Also, I think this would be better split into two patches,=
<br>
one for the reduce64_to_32 change and another for the shift table change.<b=
r>
That way, you could include the fuller explanation of the second change in<=
br>
the commit log to make easier review.<br></blockquote><div><br></div><div>S=
ure I will send an updated patch after splitting into two patches.=C2=A0</d=
iv><div>Since I am not familiar with email based patch submissions, it ende=
d up being</div><div>a new thread,=C2=A0sorry about that. I will try to upd=
ate this thread with the new revision soon.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
&gt; Changes since v1:<br>
&gt; Reversed the operands in the blend operation for readability.<br>
&gt; Removed tmp1 operations that are not affecting the result and hence<br=
>
&gt; avoid clearing the upper 64 bits for tmp1.<br>
&gt; <br>
&gt;=C2=A0 lib/net/net_crc_sse.c | 30 ++++++------------------------<br>
&gt;=C2=A0 1 file changed, 6 insertions(+), 24 deletions(-)<br>
&gt; <br>
&gt; diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c<br>
&gt; index 112dc94ac1..e590aeb5ac 100644<br>
&gt; --- a/lib/net/net_crc_sse.c<br>
&gt; +++ b/lib/net/net_crc_sse.c<br>
&gt; @@ -96,35 +96,24 @@ crcr32_reduce_128_to_64(__m128i data128, __m128i p=
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
&gt; <br>
&gt; -=C2=A0 =C2=A0 =C2=A0tmp0 =3D _mm_and_si128(data64, _mm_load_si128((co=
nst __m128i *)mask2));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp0 =3D _mm_blend_epi16(data64, _mm_setzero_si12=
8(), 0x3);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp1 =3D _mm_clmulepi64_si128(tmp0, precomp,=
 0x00);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp1 =3D _mm_xor_si128(tmp1, tmp0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tmp1 =3D _mm_and_si128(tmp1, _mm_load_si128((cons=
t __m128i *)mask1));<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp2 =3D _mm_clmulepi64_si128(tmp1, precomp,=
 0x10);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tmp2 =3D _mm_xor_si128(tmp2, tmp1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp2 =3D _mm_xor_si128(tmp2, tmp0);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return _mm_extract_epi32(tmp2, 2);<br>
&gt;=C2=A0 }<br>
&gt; <br>
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
&gt; <br>
&gt;=C2=A0 /**<br>
&gt; @@ -216,19 +205,12 @@ crc32_eth_calc_pclmulqdq(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x80808080, 0x80808080, 0x80808080, 0x80808080<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; <br>
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
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0last16 =3D _mm_l=
oadu_si128((const __m128i *)&amp;data[data_len - 16]);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D _mm_loa=
du_si128((const __m128i *)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;shf_table[data_len &amp; 15]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;crc_xmm_shift_tab[data_len &amp; 15]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a =3D _mm_shuffl=
e_epi8(fold, temp);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D _mm_xor=
_si128(temp,<br>
&gt; --<br>
&gt; 2.49.1<br>
&gt; <br>
</blockquote></div></div>

--000000000000373af306439f4767--
