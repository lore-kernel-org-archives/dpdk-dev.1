Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491D1C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 05:34:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCE014027C;
	Thu,  8 May 2025 07:34:50 +0200 (CEST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by mails.dpdk.org (Postfix) with ESMTP id C4EFB4025A
 for <dev@dpdk.org>; Thu,  8 May 2025 07:34:49 +0200 (CEST)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-5240b014f47so189931e0c.1
 for <dev@dpdk.org>; Wed, 07 May 2025 22:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746682489;
 x=1747287289; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pIpb9m/AWoE/OA1G6FgQ3hv/CYy7FpE1ls/h3rxhDno=;
 b=RdptnEcl30tozACm9grANJjlXjRYfro+ITaH2Qsi9JJY+asR0OxjOppE7asEg863BX
 H23siWUX5LLptPyonpsFhuNy48RggX4pbhsStLRBN7cwwnWxrVDRzUN/ebTBgQu+Uket
 TDCVcL9JFQB2OY+Aj3zUHLSETvObyVmAwpq4T0Y/3PAzBWE4ELF3ZigfmzRsM7t91cOx
 PwbblK82c/eR3w1pAgfYG0tbv9ydjGqy6bTLdbnS46Q5UJAuzJesvpNo2rjgvqGcSkSF
 sLOZTLSXvHC6frhXzFq+/GdOYywuGgoxC7nLdrICjpeuwUdd11g9FQrpLRSAbIebhcyS
 1ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746682489; x=1747287289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pIpb9m/AWoE/OA1G6FgQ3hv/CYy7FpE1ls/h3rxhDno=;
 b=qBmTxAN5JU8k1hNnpW/6rhyZK9bZTeYiSv+xhg6xqaKWMbUQ8AOmzAVs+NYPPPvARH
 +AJ51uqJHg1wlnqnz/qyV3tWqT9y1jTxgpR/UQJgvlCkR3aFL9/9EE5mGgGrSjEUuPze
 3+U4M6K/3dazYNxpn+vsRokcywHr9q/2lT5GGlAgCi3lgFuK1RsTJ8bH5xVVAmkOMmjO
 pMhibnmLeFdO+XKKIP2lnKL0bJKxuwyyhddIzn+zodlULROb2zMKNK2WTjNKGVAz5v03
 aYO6kEMWXQEqRpWx2RdMfEnFT0PXkjP+Tl+OsTARPYLpDR5l0wy1sbDpSxoowE3ZlO/B
 /a5A==
X-Gm-Message-State: AOJu0YyvWwCMTjroNuOP0YNpg5tjclYUaR2Xzw/DlHOuQWCZRLRhb75l
 Tn0FMs1LbvUvPS3VXs0yT1/NrXl9z7Lm5Dkli0by93zroO6r2q3zjhz0PqAOZ5t7VYNgZb5i54Q
 w/kKf/FF5iBDWMPCY/Pexo8NFKXTP4sUW53n38Q==
X-Gm-Gg: ASbGncuiE6pIPK/X6W5F1ShYQS6MMYd/k+EQiq4oFaiYVos8Ar/CHAP+JC5vP7S3r13
 ukzgvZDZLEJ7HZ20bQao5Q4D1kg0D3AEOXkOxulNCGzsmDVXK/yxfFYgzCLq2nKmKJmOctTIw4C
 p+4ptHQYueHprGjvnqytCHMbQ=
X-Google-Smtp-Source: AGHT+IFHl2qT5B325rCz+NxVSYY5xVEGt08fYjh+eUcmtKxdKi5mgio+MAe2WYx6Y2POJvfl9z28DTLZBgubSSix8Fo=
X-Received: by 2002:a05:6122:32d6:b0:525:aeb7:f22e with SMTP id
 71dfb90a1353d-52c37a89dcamr4349189e0c.7.1746682489044; Wed, 07 May 2025
 22:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250508023334.28416-1-sunyang.wu@jaguarmicro.com>
In-Reply-To: <20250508023334.28416-1-sunyang.wu@jaguarmicro.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 8 May 2025 14:34:39 +0900
X-Gm-Features: ATxdqUEz6PL9-3Y2oJmbwC-DN3os7olDhbRZ3gXtB8dRVm3IJURr7oSwEcCQd0I
Message-ID: <CAOaVG15=NiMUfxtkjPSdQWXKhqJ7x+9n-F1K-LdKpHuSUYnoAQ@mail.gmail.com>
Subject: Re: [PATCH] ethdev: optimize how the values of the flag variables are
 assigned
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: dev <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Type: multipart/alternative; boundary="0000000000004b9e4c063499353e"
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

--0000000000004b9e4c063499353e
Content-Type: text/plain; charset="UTF-8"

Why bother? This is not critical path.
Original code looked fine

On Thu, May 8, 2025, 11:34 Sunyang Wu <sunyang.wu@jaguarmicro.com> wrote:

> Set the values of the promiscuous and all_multicast variables
> according to the return value.
>
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> ---
>  lib/ethdev/rte_ethdev.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index d4197322a0..b1f593edc4 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -3044,10 +3044,8 @@ rte_eth_promiscuous_disable(uint16_t port_id)
>         if (dev->dev_ops->promiscuous_disable == NULL)
>                 return -ENOTSUP;
>
> -       dev->data->promiscuous = 0;
>         diag = dev->dev_ops->promiscuous_disable(dev);
> -       if (diag != 0)
> -               dev->data->promiscuous = 1;
> +       dev->data->promiscuous = (diag == 0) ? 0 : 1;
>
>         diag = eth_err(port_id, diag);
>
> @@ -3112,10 +3110,9 @@ rte_eth_allmulticast_disable(uint16_t port_id)
>
>         if (dev->dev_ops->allmulticast_disable == NULL)
>                 return -ENOTSUP;
> -       dev->data->all_multicast = 0;
> +
>         diag = dev->dev_ops->allmulticast_disable(dev);
> -       if (diag != 0)
> -               dev->data->all_multicast = 1;
> +       dev->data->all_multicast = (diag == 0) ? 0 : 1;
>
>         diag = eth_err(port_id, diag);
>
> --
> 2.19.0.rc0.windows.1
>
>

--0000000000004b9e4c063499353e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Why bother? This is not critical path.<div dir=3D"auto">O=
riginal code looked fine=C2=A0</div></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 8, 20=
25, 11:34 Sunyang Wu &lt;<a href=3D"mailto:sunyang.wu@jaguarmicro.com">suny=
ang.wu@jaguarmicro.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Set the values of the promiscuous and all_multicast v=
ariables<br>
according to the return value.<br>
<br>
Signed-off-by: Sunyang Wu &lt;<a href=3D"mailto:sunyang.wu@jaguarmicro.com"=
 target=3D"_blank" rel=3D"noreferrer">sunyang.wu@jaguarmicro.com</a>&gt;<br=
>
---<br>
=C2=A0lib/ethdev/rte_ethdev.c | 9 +++------<br>
=C2=A01 file changed, 3 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c<br>
index d4197322a0..b1f593edc4 100644<br>
--- a/lib/ethdev/rte_ethdev.c<br>
+++ b/lib/ethdev/rte_ethdev.c<br>
@@ -3044,10 +3044,8 @@ rte_eth_promiscuous_disable(uint16_t port_id)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev-&gt;dev_ops-&gt;promiscuous_disable =3D=
=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOTSUP;<br=
>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;data-&gt;promiscuous =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 diag =3D dev-&gt;dev_ops-&gt;promiscuous_disabl=
e(dev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (diag !=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;data-&gt;pr=
omiscuous =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;data-&gt;promiscuous =3D (diag =3D=3D 0=
) ? 0 : 1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 diag =3D eth_err(port_id, diag);<br>
<br>
@@ -3112,10 +3110,9 @@ rte_eth_allmulticast_disable(uint16_t port_id)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev-&gt;dev_ops-&gt;allmulticast_disable =
=3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOTSUP;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;data-&gt;all_multicast =3D 0;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 diag =3D dev-&gt;dev_ops-&gt;allmulticast_disab=
le(dev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (diag !=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;data-&gt;al=
l_multicast =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;data-&gt;all_multicast =3D (diag =3D=3D=
 0) ? 0 : 1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 diag =3D eth_err(port_id, diag);<br>
<br>
-- <br>
2.19.0.rc0.windows.1<br>
<br>
</blockquote></div>

--0000000000004b9e4c063499353e--
