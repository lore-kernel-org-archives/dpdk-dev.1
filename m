Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279A9C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 15:22:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FFCC427E3;
	Thu, 17 Sep 2026 17:22:30 +0200 (CEST)
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com
 [209.85.210.98]) by mails.dpdk.org (Postfix) with ESMTP id A915A427B2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 17:22:28 +0200 (CEST)
Received: by mail-ot1-f98.google.com with SMTP id
 46e09a7af769-804872cd1e0so77559a34.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 08:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789658548; x=1790263348;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8cYSRiFKS0iFP/3YRq2wTUuXaazPuk/erfjNpcyds1M=;
 b=ioXDsogaUMbnMEGzNNlDtG5z7eLThhEBhB6UEQ1Xc80umGaKDX81icZ+fYIm1wKfA2
 eiPpOrSMZ9LW4Owfywkln0R11QTJrVsbKT6wsFuL3VWwxlgGegmM2tq/szBZDzsdQw2C
 HO6dcJ17tLDqw3SlUbDhyRQq7sde00FvcCyvoTWnkFxnsLQ/5/a51LHc7BCtRp3DcNRT
 Klm4aPrEd2ZCuIaC9q9nWGQv8IdjhZ67L9YjCjTftw2DM5OzMSe0Q5j0H834p+YgdmlO
 sHyH+3U7moZtl95HaygOznkUbMTV1dC1rvWhLxlVX4TZ1HNZayS3p4I5Z3TQXsMc8kgV
 mkvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy18hy+sfsmNkSPWQQFE1e+EyiQl5bzzJAr9wtgm1UN2fBlizF+IvO/EVKqQrwSgUxOmJA=@dpdk.org
X-Gm-Message-State: AFuF++n/DrGOT/s30vGZ/c3+jBBj1iUZKZhmKxS6pEgTof7650Msx6ql
 hERZHK4JRHxvMsrVjm8feAx+ttaL5y5K9tCK7VwDNnW14u/eYyFHqh638Y0pSy/iuer/2z1YfyK
 u27AUy0DdpmakNV6jNh964a0DhkKT5/xNCAkd73mxhn/+W9CRJPQPBqONTXlXgB7DAmTlK3yb9t
 OJrE13O5T8osjafgB7clROa+Xlk2Oyezo+lBiHqPhQCiYtKp0qcWZuF3NMrWQmb/jLzTu8gwB+U
 Ut6TA==
X-Gm-Gg: AYBFou2ZfwYJqD/g2NNm0p8pEZCTz3IYDHpDG7aviXMEI6R3/3UCr2n34mngheH83p3
 6iw1fkwgRiw6fTzGDjhMBw9NABgUxJPGwcA00I/YzV32Xx/FnE3sC09saSl57yVhjPhs0HNl1zl
 1p4sq5cYLuIxc7mgkpc+BQVAdOg9+tj0qZA4VhLthnAPepPCPEHp3Pm82uKWAj+z6oHY6DR3h1W
 isN2h6qTntlfbp/ssQuXXWIWv6C3yFpjRzJtju/7iYya43ek3xPmbhaibj8OtxZt1Vaqs5llRTf
 yaIq5XCflBvNmUNkFDv0wefySvDfc7I6W/rUOrXdRlzn03WGhjFtrfZaSoXROxyoS+CwNxcEtgU
 FbxfNSOdvf8eGz3juzCBDJCR6woOVkB1VgBVGipyVwqtbXb3jKuniRf9mwuXvd+iQes6d0CAxgE
 LBBojWU+KgL3azdM7SnHfac2QxArvyeI17/aY/9Npx3oA=
X-Received: by 2002:a05:6830:6d2e:b0:7fa:5c68:d04f with SMTP id
 46e09a7af769-80b2f2851e4mr7423219a34.25.1789658547774; 
 Thu, 17 Sep 2026 08:22:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-80c4629eeeasm1745523a34.3.2026.09.17.08.22.27
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 08:22:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6a9cdcbe249so1236669a12.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789658546; x=1790263346; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8cYSRiFKS0iFP/3YRq2wTUuXaazPuk/erfjNpcyds1M=;
 b=Td3kfhHgjramea4flYyP1ysrjsBKIFknDRTaEb/70xHYQrKC5LjvjT9rQTfuBhWWhb
 nZuqON6eqYo1E6YM7fTffvTCOTKwf4hqd0WPj9y0iKsvIxPlQWccZ0yKytnMj5sQ6hK+
 YQ0lZ32SvatL+21NlVu0Yze82TwPhi28O+kLc=
X-Forwarded-Encrypted: i=1;
 AKwUvBxvZ7c/Qyn0sRUWuh0DrPmNPHmNUjkTDOw6x6N5nuMUX1RAWzzcOT2KS3r+49JSUDsUVKY=@dpdk.org
X-Received: by 2002:a05:6402:46d1:b0:6a9:a362:4646 with SMTP id
 4fb4d7f45d1cf-6aa22252d52mr4781418a12.14.1789658545889; 
 Thu, 17 Sep 2026 08:22:25 -0700 (PDT)
X-Received: by 2002:a05:6402:46d1:b0:6a9:a362:4646 with SMTP id
 4fb4d7f45d1cf-6aa22252d52mr4781391a12.14.1789658545435; Thu, 17 Sep 2026
 08:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260915084738.430772-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20260915084738.430772-1-Evgeny.Sokolov@infotecs.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Thu, 17 Sep 2026 11:22:08 -0400
X-Gm-Features: AcwNN1VJ_JkjcagFO-ZRtVG-8zQ6M9cp0RRWpyohZKnRRD6Kp_zFYXVlZygSsTs
Message-ID: <CA+BST0nrO3a1w5EOL1XU4SMKKOyHJBO+oT7bVE_UTX64sOOWoQ@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: remove redundant NULL checks in RX path
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org, stable@dpdk.org, 
 kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/alternative; boundary="000000000000ded980065baf5921"
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

--000000000000ded980065baf5921
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:47=E2=80=AFAM Evgeny Sokolov <Evgeny.Sokolov@info=
tecs.ru>
wrote:

> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
>
> rxbd and rx_buf are assigned the addresses of array elements, which
> cannot be NULL.
>
> Remove the redundant NULL checks from the jumbo frame receive path.
>
> Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.or=
g)
> with SVACE.
>
> Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> ---
>  drivers/net/bnxt/bnxt_rxr.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
> index 0fab4ddf78..98bdbc136a 100644
> --- a/drivers/net/bnxt/bnxt_rxr.c
> +++ b/drivers/net/bnxt/bnxt_rxr.c
> @@ -74,15 +74,6 @@ static inline int bnxt_alloc_ag_data(struct
> bnxt_rx_queue *rxq,
>
>         rxbd =3D &rxr->ag_desc_ring[prod];
>         rx_buf =3D &rxr->ag_buf_ring[prod];
> -       if (rxbd =3D=3D NULL) {
> -               PMD_DRV_LOG_LINE(ERR, "Jumbo Frame. rxbd is NULL");
> -               return -EINVAL;
> -       }
> -
> -       if (rx_buf =3D=3D NULL) {
> -               PMD_DRV_LOG_LINE(ERR, "Jumbo Frame. rx_buf is NULL");
> -               return -EINVAL;
> -       }
>
>         mbuf =3D __bnxt_alloc_rx_data(rxq->agg_mb_pool);
>         if (!mbuf) {
> --
> 2.30.2
>
> Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

--000000000000ded980065baf5921
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15, 2026=
 at 4:47=E2=80=AFAM Evgeny Sokolov &lt;<a href=3D"mailto:Evgeny.Sokolov@inf=
otecs.ru" target=3D"_blank">Evgeny.Sokolov@infotecs.ru</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">From: Sokolov Evgeny =
&lt;<a href=3D"mailto:Evgeny.Sokolov@infotecs.ru" target=3D"_blank">Evgeny.=
Sokolov@infotecs.ru</a>&gt;<br>
<br>
rxbd and rx_buf are assigned the addresses of array elements, which<br>
cannot be NULL.<br>
<br>
Remove the redundant NULL checks from the jumbo frame receive path.<br>
<br>
Found by InfoTeCS on behalf of Linux Verification Center (<a href=3D"http:/=
/linuxtesting.org" rel=3D"noreferrer" target=3D"_blank">linuxtesting.org</a=
>) with SVACE.<br>
<br>
Signed-off-by: Sokolov Evgeny &lt;<a href=3D"mailto:Evgeny.Sokolov@infotecs=
.ru" target=3D"_blank">Evgeny.Sokolov@infotecs.ru</a>&gt;<br>
---<br>
=C2=A0drivers/net/bnxt/bnxt_rxr.c | 9 ---------<br>
=C2=A01 file changed, 9 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c<br>
index 0fab4ddf78..98bdbc136a 100644<br>
--- a/drivers/net/bnxt/bnxt_rxr.c<br>
+++ b/drivers/net/bnxt/bnxt_rxr.c<br>
@@ -74,15 +74,6 @@ static inline int bnxt_alloc_ag_data(struct bnxt_rx_queu=
e *rxq,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rxbd =3D &amp;rxr-&gt;ag_desc_ring[prod];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_buf =3D &amp;rxr-&gt;ag_buf_ring[prod];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rxbd =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_DRV_LOG_LINE(ER=
R, &quot;Jumbo Frame. rxbd is NULL&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rx_buf =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_DRV_LOG_LINE(ER=
R, &quot;Jumbo Frame. rx_buf is NULL&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mbuf =3D __bnxt_alloc_rx_data(rxq-&gt;agg_mb_po=
ol);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mbuf) {<br>
-- <br>
2.30.2<br>
<br></blockquote><div><span style=3D"font-family:Calibri;font-size:11pt;bac=
kground-color:transparent">Acked-by:=C2=A0=C2=A0Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com" target=3D=
"_blank">kishore.padmanabha@broadcom.com</a>&gt;</span>=C2=A0</div></div></=
div>
</div>

--000000000000ded980065baf5921--
