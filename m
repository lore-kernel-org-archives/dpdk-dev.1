Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9798DC19776
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 20:13:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2EE94029F;
	Wed, 26 Feb 2025 21:13:05 +0100 (CET)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
 [209.85.166.179])
 by mails.dpdk.org (Postfix) with ESMTP id 03BEA4029F
 for <dev@dpdk.org>; Wed, 26 Feb 2025 21:13:05 +0100 (CET)
Received: by mail-il1-f179.google.com with SMTP id
 e9e14a558f8ab-3cf8e017abcso966335ab.1
 for <dev@dpdk.org>; Wed, 26 Feb 2025 12:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740600784; x=1741205584; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ws+8PV/NOMOIjDbQwBA6QjuisGMCANFWr87lo8Mpkk4=;
 b=CraJRl5Tfxwek5kMygQH8uM8rNW6wgqgWxTOwYMFz3FBwoUIi0F2YY+nzWcwNhfxyf
 qK2qqq383aNFZzyJolieEqQsrl+R/Xh0+jQ2vKrU5RBI5OnmrqyK9L+p5iVKg5dGJ4T3
 I/LMXF+Ni+BpNjrJtT4zFYQg+VxCRLjc30fDNNWqy5EbY9hY347mXUUofVc6a+a8wV/G
 bUmnK6hHPHwjxv1teYaZI4uFS+3qI4xsH1sD0+QIm5Flf39r7jWWwaQwS6Qa/jjIxrJL
 rlIUGB8UQoKHH36pQGSK83ru9r7PFxPrWfGXKjqX14d8PCYzpyVMLB/mIoGHA8UiVxot
 XYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740600784; x=1741205584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ws+8PV/NOMOIjDbQwBA6QjuisGMCANFWr87lo8Mpkk4=;
 b=BlZVFLMFxGS2pjvwA2n2Qw2IrFgcWRRytO4m4J93TMK/254+ckUvw5jNxFimPn3SHG
 S7QHW/U8rEPtNwxvH+PXf7428krsOtpDpdo7hhtnIqmrxvL5ad9v9eOB9mey808M5rsl
 4yBY+y7sG4BcqufSPg+oYUk3TLz/lCTtWaBqS0tEDtxqjVFr2uyvbwnklBtQUVjEY+2k
 9A/BYbnvUbf9+jR1ihdTLgHYs48MHB09l3VVDzzBpZbIhV7FK+KqIlhNrw8SzlvrWhtm
 E7r1NgAnmoEgq4c2va3sO5kAj/PKAnA5Lm4iascvSOVBvB7D4rMhltE3ZPqNhFxYEEUb
 /E9w==
X-Gm-Message-State: AOJu0YzSPTSe//DbZ5j6FPTuB1jpZVpRgd7s1Fii3dLE7SAwGCChJ/GT
 RwDDudkc2IsRH7qHjVSXrG0n2dOIU0w+wVY6mCXXrmSTPgMvh8jTquTVewaHh0H92Yd4o5e1VT1
 fTVEZG1GfEgtOKtquhclcvXsQBVHPUBdMq4RoXw==
X-Gm-Gg: ASbGnct8/Ru0CZO0F7luBgXNG+Qy8ak14km3ndTSuJf/aEpKFbsrjnL9Z1k2Cyik6Eo
 zD2IKwD71MQLuzTrfmjTCmrIW1yM+dRCP+ievtnBjgFWstLz+AdEz5m/j6wFJeu+1COXKP/wDM6
 vJNpSPBdA0P5r7TKVs/apaQ4XWYWc0k/UjP8uv6Yk=
X-Google-Smtp-Source: AGHT+IGo3QrjiuLr/CcQ2zHvKzt0cl4IZfDEPDDN44HOEeG9OYWqI9NKj2rTygKglQP5qgHRtcR36msbtf+bQRkLHTI=
X-Received: by 2002:a05:6e02:1608:b0:3d0:47cf:869c with SMTP id
 e9e14a558f8ab-3d30488b517mr87403805ab.19.1740600784221; Wed, 26 Feb 2025
 12:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250131231018.2163893-3-ariel.otilibili@6wind.com>
 <20250224112534.684c19c6@hermes.local>
In-Reply-To: <20250224112534.684c19c6@hermes.local>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Wed, 26 Feb 2025 21:12:51 +0100
X-Gm-Features: AQ5f1JoF9B3JyrQnJ0O9SoqsW0UEGJWyTEYoxUrH_h-yhwj5iYv-0hCbtAl5I6M
Message-ID: <CAF1zDgbFLbAmzP6Rm-MO925aQ0Jc4Ri7gY-rK=tVEWXw9gfaWw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Content-Type: multipart/alternative; boundary="0000000000007097f9062f113380"
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

--0000000000007097f9062f113380
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On Mon, Feb 24, 2025 at 8:25=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

>
> Please avoid doing assignment in a conditional statement, can be error
> prone.
> Surprised checkpatch doesn't complain about it.
>

Thanks for the feedback. checkpatch did catch them.

Here is the new series,
https://inbox.dpdk.org/dev/20250226200841.2342632-3-ariel.otilibili@6wind.c=
om/

Regards,
Ariel

>
> Better as:
>                         desc =3D reserve_and_fill(txq, mbuf, umem);
>                         if (!desc) {
>                                 kick_tx(txq, cq);
>                                 desc =3D reserve_and_fill(txq, mbuf, umem=
);
>                                 if (!desc)
>                                         goto out;
>

--0000000000007097f9062f113380
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Stephen,<br></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Mon, Feb 24, 2025 at 8:25=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mai=
lto:stephen@networkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Please avoid doing assignment in a conditional statement, can be error pron=
e.<br>
Surprised checkpatch doesn&#39;t complain about it.<br></blockquote><div><b=
r></div><div>Thanks for the feedback. checkpatch did catch them.</div><div>=
<br></div><div>Here is the new series,=C2=A0<a href=3D"https://inbox.dpdk.o=
rg/dev/20250226200841.2342632-3-ariel.otilibili@6wind.com/">https://inbox.d=
pdk.org/dev/20250226200841.2342632-3-ariel.otilibili@6wind.com/</a></div><d=
iv><br></div><div>Regards,</div><div>Ariel<br> </div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
Better as:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 desc =3D reserve_and_fill(txq, mbuf, umem);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!desc) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kick_tx(txq, cq);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc =3D reserve_and_fill(txq, mbuf,=
 umem);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!desc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out=
;<br>
</blockquote></div></div>

--0000000000007097f9062f113380--
