Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A5606A31F
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hnZP7Bas
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A1AC40288;
	Fri, 30 Oct 2026 17:30:59 +0100 (CET)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 36C7240285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 17:30:58 +0100 (CET)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-990835cec4bso638431241.1
 for <dev@dpdk.org>; Fri, 30 Oct 2026 09:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793377857; cv=none;
 d=google.com; s=arc-20260327;
 b=L5AFKdC9vMK0PUUvXppoL71Uv/ZR6Q+HGBV33ZKRZ+kfOS+7qyRieklPaLPxEkWx5e
 48bDbzctRiRnoUO0VBaLLdKdIHn1CV3tqgI1QvkRxSmwb9KDqTyH/T+2bEo/hR3lHz7I
 8ighI4d2p86VFo7uElEOcjP2iJU4ryL6l3pux68Ak5zntu4ar8pXK2XVfBSNlb3klhgL
 Prz9kNJLJ/i6GNKkN1zN55hLWhlnDhwSgJKobSWoPcN6vehF5LOBxEz6TMyDbcDAPQqp
 h1lB0VQ6InwwIlRycB5Fs6pC7AcBJD/Wvoi9+EVgF5lZBaBPmCDZnS3vASGdgNRihWV2
 Sl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jKdRg3HlEXEP/oCtUKkymjHlm2oP40wJndeclANxtvY=;
 fh=b3D9sFwRmXoX2gcCqVb9wOeVa1PHmwwBkbD+Y0jF334=;
 b=RadVcsYei7btvTHGVh9CDHyo2b64ds5Awp7H5EQa+8PtKGwn2WvbiG58LJlrlRvahA
 vaAu/u4BsVe+gNg6ds7Mq+WL9C/HRltJ7r5PGE79p4dAwYnX8HRyZrrvlQ/mg04L7pYd
 ga/1YLKAXLpwjcPb4YPT4o8QuWnEfcBw25IuydTrpBBi2Gk65H+Cxdd0gDwW85UY1K+u
 C8KmzNZ1UxM9e5U0vXQbrrr+L77ddI4yJ/D1WhH6ekSv4gTGXInwxOGR3h3DvqMT4TUq
 8tTWIEplK4l3j9iD1+9FYehgTKj4bncAnP77OEfQ+vWiV/fYqVzZQa3iLKwthLXuylEe
 4zlw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793377857;
 x=1793982657; darn=dpdk.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jKdRg3HlEXEP/oCtUKkymjHlm2oP40wJndeclANxtvY=;
 b=hnZP7BasQsmC0AxSsJBB9/gnjVlUSLPH8mtQZ7ydwUDpLF6M7PB5g7lOtJ/s5BAfgm
 rVWuDvhMoro4ar5Jl5EHUrPqhY2lrr7RftqApLo+RZ97vZ+/wGSImRLvwFzksOwoAg9i
 8OZw2U+2VRgzaxnSE4T34wfwuFY6ehv4YhiLSP2nzuzgVX8vCf3Bbyr0DkJsx0qsdBXU
 YD26mihzP0xvLrPhuKRnHwfSq6/TOJcCshrqBgeX0LKT9gdV3lQ/BVIHkCpG/aYwsg6Z
 5VFOVFCLL6qHRGcL9CWvNewBDaH+0Hz0+eT45jLd7fNK6T8GCZ8fKkT4nMUtdg3T1VOv
 cL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793377857; x=1793982657;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jKdRg3HlEXEP/oCtUKkymjHlm2oP40wJndeclANxtvY=;
 b=X3uh/R6T77ge7T2eY/JdO3MF4SIlnsYbBOHgMieAEPTIqNR3X+clw0f+tkgYervbBn
 8tStAsgJnDSly3U36wNLZOhGvzZbE4iq2bvOlrzCaj94xr8KckRRWwPIF36/PuxDc8KS
 bgUd7TehjF9BZ8ZrKkjYmIig2g4G73YnXo/wOSjMqvf4DpRPnl7pptxyf+0FtH6RcZQA
 8Qflk+9NyrS6HQ+fzjxggM9Di9ug/AJecYUZjtze3Jp50ADhYKQx9KsmqUnw48/XNQom
 7d+Y9UNDgX38BWVLvyEOvFw7Ze5UrdXE2VL/+R/06VIH1p53etyYJeIwykaIrVRsOl30
 OByA==
X-Gm-Message-State: AFq9FYIYu1GaJwjzSC1Xv5JGuViigrYk/imvVV/WFBOJ/HJ4z/flDkuB
 OCoJhNfyNjKyhftdGBUJp09n4G5wjjy4eoBUnWyswIefWR/Ey3E+4N/PBd3qst06GpaLJhVu1W6
 e6u8MwpEdjaoI5H9Ui53D9Nrh7P58hWGZg2m8lNJeFg==
X-Gm-Gg: AYBFou3qyaGxsUbOeYDwWw1QH4KpbMrRKQR0iH6su7ocOCzFkv35fuAWfJak6KCaD8F
 UeVJdL1w3FsWHQIe7XDpMSOB8FBz3JaFq6tt5aatuycK03RCRsuK8rlm487igK4sKXO5n7Bhcrq
 WN1ckklvIiNksgXXwZ43Z34k9uNNkLsXaOwfR9mjO6M6e7NO9c/K1aibsVm3gDmP83SFztFLn4n
 LGfxM0dx7YFrw/7+sX2SBmj4QTMEkOQImNMIbwagIUjrc410M/+KBHiwOD7HHBVJhCaTMRtJ5gA
 bVftlZrYEP3Vksl4lWsiOywRn2EwLstunJQXDZKSJah3JLzP2sRTr7c2qevV4zv275uVtEAQhu8
 cabomMnXucEKGy6i9D2euCEq6ZgnmbpO9qeZqZOZUR1ATQGs7SimLZhz4rsuafUL87s/al5w=
X-Received: by 2002:a05:6102:c01:b0:7c3:c0b9:8d50 with SMTP id
 ada2fe7eead31-7d072c89051mr1343274137.21.1793377856925; Fri, 30 Oct 2026
 09:30:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030051726.898902-1-nkishor@marvell.com>
In-Reply-To: <20261030051726.898902-1-nkishor@marvell.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 30 Oct 2026 09:30:48 -0700
X-Gm-Features: AclHuK_GdCONONivH-8-_9HMaNfQ3AAQNxCBN5BKfkgpMEu_KG94cFDH3clJd7U
Message-ID: <CAOaVG17Zkb+0Tn7VxF8SuGpoULYU_W64vC=KnLM7YCXGGq3+Pg@mail.gmail.com>
Subject: Re: [PATCH] mempool/cnxk: fix halo enable devarg parsing
To: Nawal Kishor <nkishor@marvell.com>
Cc: dev <dev@dpdk.org>, Ashwin Sekhar T K <asekhar@marvell.com>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Content-Type: multipart/alternative; boundary="0000000000001c40d1065f115246"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000001c40d1065f115246
Content-Type: text/plain; charset="UTF-8"

one more reason to have common code for boolean flags. there is a bigish
series to do that

On Thu, Oct 29, 2026, 22:17 Nawal Kishor <nkishor@marvell.com> wrote:

> parse_halo_ena_handler() kept the parsed value in a uint8_t and stored
> it through a uint8_t pointer, while the caller passes a uint32_t. The
> narrowing happened before the 0/1 check, so 256 was accepted as 0 and
> 257 as 1. The one-byte store also updated only the first byte of that
> uint32_t, which is correct only on a little-endian host when the local
> is already zero.
>
> Parse and store a uint32_t so the check sees the full value and the
> caller's object is written completely.
>
> Fixes: 45abbfc836b1 ("mempool/cnxk: support HALO in mempool")
>
> Signed-off-by: Nawal Kishor <nkishor@marvell.com>
> ---
>  drivers/mempool/cnxk/cnxk_mempool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mempool/cnxk/cnxk_mempool.c
> b/drivers/mempool/cnxk/cnxk_mempool.c
> index 6939fccff4..f1cdf9cbb5 100644
> --- a/drivers/mempool/cnxk/cnxk_mempool.c
> +++ b/drivers/mempool/cnxk/cnxk_mempool.c
> @@ -51,13 +51,13 @@ static int
>  parse_halo_ena_handler(const char *key, const char *value, void
> *extra_args)
>  {
>         RTE_SET_USED(key);
> -       uint8_t val;
> +       uint32_t val;
>
>         val = atoi(value);
>         if (val != 0 && val != 1)
>                 return -EINVAL;
>
> -       *(uint8_t *)extra_args = val;
> +       *(uint32_t *)extra_args = val;
>         return 0;
>  }
>
> --
> 2.48.1
>
>

--0000000000001c40d1065f115246
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">one more reason to have common code for boolean flags. th=
ere is a bigish series to do that</div><br><div class=3D"gmail_quote gmail_=
quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 29, 2026=
, 22:17 Nawal Kishor &lt;<a href=3D"mailto:nkishor@marvell.com">nkishor@mar=
vell.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">parse_halo_ena_handler() kept the parsed value in a uint8_t and sto=
red<br>
it through a uint8_t pointer, while the caller passes a uint32_t. The<br>
narrowing happened before the 0/1 check, so 256 was accepted as 0 and<br>
257 as 1. The one-byte store also updated only the first byte of that<br>
uint32_t, which is correct only on a little-endian host when the local<br>
is already zero.<br>
<br>
Parse and store a uint32_t so the check sees the full value and the<br>
caller&#39;s object is written completely.<br>
<br>
Fixes: 45abbfc836b1 (&quot;mempool/cnxk: support HALO in mempool&quot;)<br>
<br>
Signed-off-by: Nawal Kishor &lt;<a href=3D"mailto:nkishor@marvell.com" targ=
et=3D"_blank" rel=3D"noreferrer">nkishor@marvell.com</a>&gt;<br>
---<br>
=C2=A0drivers/mempool/cnxk/cnxk_mempool.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/mempool/cnxk/cnxk_mempool.c b/drivers/mempool/cnxk/cnx=
k_mempool.c<br>
index 6939fccff4..f1cdf9cbb5 100644<br>
--- a/drivers/mempool/cnxk/cnxk_mempool.c<br>
+++ b/drivers/mempool/cnxk/cnxk_mempool.c<br>
@@ -51,13 +51,13 @@ static int<br>
=C2=A0parse_halo_ena_handler(const char *key, const char *value, void *extr=
a_args)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_SET_USED(key);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t val;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t val;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D atoi(value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val !=3D 0 &amp;&amp; val !=3D 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint8_t *)extra_args =3D val;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint32_t *)extra_args =3D val;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div>

--0000000000001c40d1065f115246--
