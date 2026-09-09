Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2DAC79FB6
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:56:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0369040E27;
	Wed,  9 Sep 2026 12:56:43 +0200 (CEST)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43]) by mails.dpdk.org (Postfix) with ESMTP id 23F88402AD
 for <dev@dpdk.org>; Wed,  9 Sep 2026 12:56:42 +0200 (CEST)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-66f883abfdcso5314023d50.0
 for <dev@dpdk.org>; Wed, 09 Sep 2026 03:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788951401; cv=none;
 d=google.com; s=arc-20260327;
 b=bamqIGnpUgUqGd0bKbJPDWNadsMYUgaoE1D/wrYaZw/6KekQIA9SxSOnZecF2ePO32
 fG0Najktxqyn6C1DH8gSi4dv3sChXH8r3AMOOFtN8os3QlGRbCogSdGjWjlrrcdiGXcP
 3ZoysuDDSvTTklAltNmROFbybXV6N0f46YYuO6Z5xn3Se4MYfHCLy7bF2+vc0D8WVb84
 9RC7F+DIREJQC38ygP84AZ/VRa3FslhOhiZxe6s+JakfnemLxGvzu1vG2W1m6j+WmfEU
 cW2OS0vnlOhr2MsjayvItUOF1tCSViOsax+rThoBmrSKlEOL5pQhMXcffdUONWvx3/K6
 ruVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ldbHIsUjmPSEGRK4SpKtHWc88uQpYppKJVzLGqCBElE=;
 fh=zNphAuCom6MxCckqDX4te/Ve18PlZzkCipEnMIbKzh4=;
 b=HOf+aCmPJQgNesRYYRPdxuOyUes63T/BC3/jRAWCwxAf8EM0cEE4XcAN4MaBwaUEaG
 o5C2hmK76KBFOSU99MNemHTA2HOXR6Ixo3zy2BUy4b7Xh9HcMut8HKaHF/Jpo1Tf9Hoh
 H31mf83taTChOm5hTckEdX+wNGtmTnXICxaXve3rhHH+wSPQr+0s9QY2eA19lbatObLH
 Ly7LJqrSEAYod6xMvYJ1qXzMEwKWLx++uFqUH/YQqPN7wE76dTxCxsvC6BH5MN7TEcDF
 F8sb/4zGDPyB2dO1q+faqOrla+ejSaZLTC9AkENcz5ma/7PrWTM3hEDpcgxcW0M1V6DU
 xC+w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788951401; x=1789556201; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ldbHIsUjmPSEGRK4SpKtHWc88uQpYppKJVzLGqCBElE=;
 b=nTkItsc20tOv+AqqUAqvia2wCzb+6iMFjbWPQzHX/NdBracgCLRI70Fk9j9Dxr/8lU
 xPp2dHyBDUKiWMcPohxzTyHRPT4ePwGc+l3GQAk250R7ciCej96OkL0BmKTV5NTvTPF3
 JcZWmge77C4XJZlSJwE5Jm5QZJAsqOTy1L36UmF+HxfRZCUgwtvNyXfFZ78xowjR0Usc
 fmKS0YHCAlnw3SwckfdBuZAaDEOHwCSoeK1Sbk06Je95ZNuXG7JXgTGu2lJDBpqGQ0ff
 fAY84wYLNQ9H4DHN8//06lLFm3Hyy4Ne4XQwzTOkgFm0Vmq1PZ1uEvnKwUkl5HCHh5GE
 SIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788951401; x=1789556201;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ldbHIsUjmPSEGRK4SpKtHWc88uQpYppKJVzLGqCBElE=;
 b=oHGqGX7Jmq+JliemcfK5P9enjlwbdBsQQ9ro0St2jTgHsBEfaV3ADKt7cIPBAyBvj1
 GaAgMN9xChPKzSexc8KFDZhZjVmLERl1dBqq+WN82zjOwFmDLWX3gUOEi5P1paRbkFHf
 CKNEZS5Gr9mLSU2kSbNVwy6m7XBZXSlrLvib0A32XCnHq4a98b/KyG5bK26NABn5kwch
 AA4chSxrpkDymrDiYPGaAkLE70YbYaC4M2SY9MX0jtWb9ual3tkgmyRz+HJfjNjqUtjc
 NG/HM3kAkqY1CNQt/QzivDnlMGXdygGU6uIUgU5ns2IOcPP/bYUnjLrECV6+y7nFYosM
 iEQw==
X-Gm-Message-State: AFuF++l0lJd5RU7+ifmIeEa4OqkUFZoLeWJeiWVka1JhXb+9eJWKZ4FZ
 EoimKqdcuMhJHPYSewPZR55Lvb7rs79nVYtEHYWYUEBZ5wJRAsN3r/E1CYgy/dBYvnGoXXK9F7F
 TLXEiZBy1hdpbaz/5BzEeg582yPAO8I7PcXBV
X-Gm-Gg: AYBFou2zQN2IvoiOoBtyCl+sVw98YwBVYJhFZVZPdgNZKHXXET4JqFsSyJNThEIt3EW
 qGDXoNjgeluz4WXoyxFGJjJTSlHIAmJhHZsY2e2N8wRaajOkT6YYrwxFMe3YRty/Z/uhGOH3b3O
 MkIwnlmpF9ZdDMAvYiZgsvHDoQRuniaGMcvcvgeLnMrOJgWUcXjPKykNaE22awAcsK3+tBwOGnu
 gWZgcFQNPukWEK9Q6mTga5OyBm3vwnSyZDteM2TSAwHf9M8K/ORsGbYOHrX4bOVuborNub2hNnC
 zr6nXRjplPMuLDJpAG0DAdG3t/PlYRXm98rtDwrojThKm6yQHP/xADo4
X-Received: by 2002:a05:690e:4811:b0:66f:c1bc:4014 with SMTP id
 956f58d0204a3-66fc1bc43c2mr5941733d50.65.1788951396467; Wed, 09 Sep 2026
 03:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260904092157.51040-1-amiyaranjan.mohakud@gmail.com>
In-Reply-To: <20260904092157.51040-1-amiyaranjan.mohakud@gmail.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Wed, 9 Sep 2026 16:26:24 +0530
X-Gm-Features: AcwNN1Uu3LyjxmO6a60dqbOLyLe5LiCDZzDOoRpPe6_OxMtehoCN0FuRBqlvO2M
Message-ID: <CAL+mCpNCdJDJN77BFwFP4bK887xsRDtid7HxSZ=3yapW5mvNsQ@mail.gmail.com>
Subject: Re: [PATCH] common/cnxk: fix duplicate mbox alloc in NPA aura pool
 init
To: dev@dpdk.org
Cc: asekhar@marvell.com, stable@dpdk.org, hkalra@marvell.com, 
 skoteshwar@marvell.com, skori@marvell.com, ndabilpuram@marvell.com, 
 kirankumark@marvell.com
Content-Type: multipart/alternative; boundary="00000000000081cb6c065b0ab45c"
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

--00000000000081cb6c065b0ab45c
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

Thanks
Amiya


On Fri, 4 Sept 2026 at 14:52, Amiya Ranjan Mohakud <
amiyaranjan.mohakud@gmail.com> wrote:

> npa_aura_pool_init() allocates the pool init mbox message twice on
> non-CN20K platforms. The if/else block at line 106-111 allocates via
> the model-specific branch, but the original unconditional allocation
> at line 112 was not removed when the CN20K branch was added. This
> overwrites pool_init_req, and the orphaned first message is sent to
> the AF with uninitialized aura_id, ctype, and op fields, which can
> trigger any undesired behavior on CN10K.
>
> Remove the duplicate allocation.
>
> Fixes: 143a419edf35 ("common/cnxk: use new NPA aq enq mbox for CN20K")
> Cc: asekhar@marvell.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
> ---
>  drivers/common/cnxk/roc_npa.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
> index 4a3e96a97a..87f7637e9f 100644
> --- a/drivers/common/cnxk/roc_npa.c
> +++ b/drivers/common/cnxk/roc_npa.c
> @@ -110,7 +110,6 @@ npa_aura_pool_init(struct mbox *m_box, uint32_t
> aura_id, struct npa_aura_s *aura
>         } else {
>                 pool_init_req = mbox_alloc_msg_npa_aq_enq(mbox);
>         }
> -       pool_init_req = mbox_alloc_msg_npa_aq_enq(mbox);
>         if (pool_init_req == NULL)
>                 goto exit;
>         pool_init_req->aura_id = aura_id;
> --
> 2.39.5 (Apple Git-154)
>
>

--00000000000081cb6c065b0ab45c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Recheck-request: iol-intel-Performance</div><div><br>=
</div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gma=
il_signature"><div dir=3D"ltr"><div><span style=3D"font-family:verdana,sans=
-serif">Thanks</span></div><div><span style=3D"font-family:verdana,sans-ser=
if">Amiya</span><br></div></div></div></div><br></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fr=
i, 4 Sept 2026 at 14:52, Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyara=
njan.mohakud@gmail.com">amiyaranjan.mohakud@gmail.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">npa_aura_pool_init() a=
llocates the pool init mbox message twice on<br>
non-CN20K platforms. The if/else block at line 106-111 allocates via<br>
the model-specific branch, but the original unconditional allocation<br>
at line 112 was not removed when the CN20K branch was added. This<br>
overwrites pool_init_req, and the orphaned first message is sent to<br>
the AF with uninitialized aura_id, ctype, and op fields, which can<br>
trigger any undesired behavior on CN10K.<br>
<br>
Remove the duplicate allocation.<br>
<br>
Fixes: 143a419edf35 (&quot;common/cnxk: use new NPA aq enq mbox for CN20K&q=
uot;)<br>
Cc: <a href=3D"mailto:asekhar@marvell.com" target=3D"_blank">asekhar@marvel=
l.com</a><br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyaranjan.mohak=
ud@gmail.com" target=3D"_blank">amiyaranjan.mohakud@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/common/cnxk/roc_npa.c | 1 -<br>
=C2=A01 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c<=
br>
index 4a3e96a97a..87f7637e9f 100644<br>
--- a/drivers/common/cnxk/roc_npa.c<br>
+++ b/drivers/common/cnxk/roc_npa.c<br>
@@ -110,7 +110,6 @@ npa_aura_pool_init(struct mbox *m_box, uint32_t aura_id=
, struct npa_aura_s *aura<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pool_init_req =3D m=
box_alloc_msg_npa_aq_enq(mbox);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pool_init_req =3D mbox_alloc_msg_npa_aq_enq(mbo=
x);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pool_init_req =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pool_init_req-&gt;aura_id =3D aura_id;<br>
-- <br>
2.39.5 (Apple Git-154)<br>
<br>
</blockquote></div>

--00000000000081cb6c065b0ab45c--
