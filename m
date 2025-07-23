Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776CFC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 12:19:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71F6740A89;
	Wed, 23 Jul 2025 14:19:42 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 8CFA040264
 for <dev@dpdk.org>; Wed, 23 Jul 2025 14:19:41 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-6fada2dd785so67692996d6.2
 for <dev@dpdk.org>; Wed, 23 Jul 2025 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753273181;
 x=1753877981; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FxZF51/YpELT6mthkP9CoKvjjb7MOGZvZSCMnzgee2Q=;
 b=t/iEZLNGOizI4MPF4Ij904SNybMSsXlJkfG8mTVuQzESwH54pY9pJEYz14390yKlZU
 e+xFZofXmIgXgrbZp3FeD5n3mIamAoU5vq8G5YbE4BrwUpEQ+oWsW5UJHKc/X4D6TE9J
 fdzRjLx7FJYa1rgcnBGKnKqTYqeDY+VWzGqketCdgLl7iY9dHPJRRrDNppNIUr/xBrBZ
 oFaLx+66vYe6fs8e3OmmMnAlcb+tTfiiXqYDu321YwOhaTbN0hYTGJtwuaUgut4/cLXF
 hPFlbT7eVZ0NpPCnNiZC7htPmxhtIXYg+HdVhzZLvYjUX7M4ZyICCCmRUPCnSCPY8rV8
 zvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753273181; x=1753877981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FxZF51/YpELT6mthkP9CoKvjjb7MOGZvZSCMnzgee2Q=;
 b=flkG3kJ+N8GBFxKRw8H6tB6yEHU34xWRU5AG7ysFScv614S0+TY68w3XOpbKs1lDdu
 hw0Tl+Wn7PVJ/oRaTR9GUVjD10ElQSDnT5gK90XRENi8ND42wJls2vwjfMoyLnlc9gO5
 iDqlihFsNQB+qS5vQbMpJuH/uneX6Q5PlH0xcB0QE4/PkKLc9PS1p9nPeRxo7O/DOUdq
 7LnoWhxu89ZC/E7fMkbqpgzRCMPFbYRvjuw1JDCaqA4PCZWOHlIL9Ri8GOkYEBEG8Cxd
 A1l+0trRyI4v9N+zOv0L7LR2mJ3SkCynWv85kseOAQajEVbw5/hxKi5PKEIyfVhHcOiD
 C/kg==
X-Gm-Message-State: AOJu0YyIDDm13ebrczYjIoDyzeJbtZP7oiVGB5KEXF11IfnNopUVGBli
 0gFURiR/oBEfCF3iBoK35alYxar99iJKaCHJAx09uR1mnLX3ezRjsxpwAaPd4cQSOpB3Qw+I6y4
 oO/5qPJy+nEDtyFJ+ndbY5LQ7mskS1bIFJdA8IBcBhQ==
X-Gm-Gg: ASbGncsFLUzp/HcJjBoIMP3XGSLkvJ/w7xw+a4+p/uecL3EIrXNuiXLndzkPmgp1/hH
 zhd3cOlwoGHCWcKLZn2UzNFbF1BZURlwgR7iuZj0VFgqzMO2vACMUUdj6yBAEDPnDtzexzDGumw
 HwHT6ep1Dc8HLiUZvSn5r5RiUyRXTh9e/zS4ug3zwI6NTtAo8fJCCuYOdhbrohN+0XYvJs6FxxM
 tl1bTIHyQ==
X-Google-Smtp-Source: AGHT+IG7jz+WHqCBaeslFVuO7QRYbQVoJ3TbDh9tlufyxxCVV6tqcFEmYkefrqwZE6xmd+OYNXPZQrtCIZ3FciaRLdI=
X-Received: by 2002:a05:6214:500d:b0:6fb:4e82:6e8 with SMTP id
 6a1803df08f44-7070051b347mr33495346d6.14.1753273180788; Wed, 23 Jul 2025
 05:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
In-Reply-To: <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 23 Jul 2025 17:19:29 +0500
X-Gm-Features: Ac12FXzbnDQF2DmtYc27CMpOl1KWs-KBadPL5cCY-goWoOKmcswNHB5xV79TKFg
Message-ID: <CA++2-x7U1D8pB1dzuyoeQ4WQKcCpv32HVji23Ev=cdM=G9MROA@mail.gmail.com>
Subject: Re: [PATCH v2] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com, 
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000022b5d2063a97b91f"
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

--00000000000022b5d2063a97b91f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Secondary application not only breaking on device closing,
it's also getting segfault when we do "show device info all" from secondary
after primary closes:

testpmd> show device info all

********************* Infos for device 0000:03:00.0 *********************
Bus name: pci
Bus information: vendor_id=3D15b3, device_id=3D101d
Driver name: mlx5_pci
Devargs:
Connect to socket: 0

Segmentation fault (core dumped)

This patch prevents these crashes and it seems that these fixes should
be in PMD along with the ethdev layer. Some more checks will be added
in the next version to prevent "show device info all" crash.



On Wed, Jul 23, 2025 at 9:50=E2=80=AFAM Khadem Ullah <14pwcse1224@uetpeshaw=
ar.edu.pk>
wrote:

> In secondary processes, directly accessing 'dev->data->dev_private' can
> cause a segmentation fault if the primary process has exited or if the
> shared memory is no longer accessible.
>
> This patch adds a safety check using rte_mem_virt2phy(), with an
> unlikely() branch hint to minimize performance impact in the fast path.
> This ensures 'dev_private' is still valid before accessing it.
>
> Fixes: bdad90d12ec8 ("ethdev: change device info get callback to return
> int")
> Cc: stable@dpdk.org
>
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>  lib/ethdev/rte_ethdev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index dd7c00bc94..ef5dc55f2e 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct
> rte_eth_dev_info *dev_info)
>
>         if (dev->dev_ops->dev_infos_get =3D=3D NULL)
>                 return -ENOTSUP;
> +       if (rte_eal_process_type() =3D=3D RTE_PROC_SECONDARY &&
> +               unlikely(rte_mem_virt2phy(dev->data->dev_private) =3D=3D
> RTE_BAD_PHYS_ADDR)) {
> +                       RTE_ETHDEV_LOG_LINE(ERR,
> +                       "Secondary: dev_private not accessible (primary
> exited?)");
> +                       rte_errno =3D ENODEV;
> +                       return -rte_errno;
> +       }
>         diag =3D dev->dev_ops->dev_infos_get(dev, dev_info);
>         if (diag !=3D 0) {
>                 /* Cleanup already filled in device information */
> --
> 2.43.0
>
>

--=20
Engr. Khadem Ullah,
Software Engineer,
Dreambig Semiconductor Inc
https://dreambigsemi.com/

--00000000000022b5d2063a97b91f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre class=3D"gmail-content">Secondary application not onl=
y breaking on device closing,<br>it&#39;s also getting segfault when we do =
&quot;show device info all&quot; from secondary<br>after primary closes:<br=
><br>testpmd&gt; show device info all<br><br>********************* Infos fo=
r device 0000:03:00.0 *********************<br>Bus name: pci<br>Bus informa=
tion: vendor_id=3D15b3, device_id=3D101d<br>Driver name: mlx5_pci<br>Devarg=
s:<br>Connect to socket: 0<br><br>Segmentation fault (core dumped)<br><br>T=
his patch prevents these crashes and it seems that these fixes should be in=
 PMD along with the ethdev layer. Some more checks will be added in the nex=
t version to prevent &quot;show device info all&quot; crash.</pre><br></div=
><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Wed, Jul 23, 2025 at 9:50=E2=80=AFAM Khadem Ullah &lt;<=
a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk">14pwcse1224@uetpeshawar.ed=
u.pk</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">In secondary processes, directly accessing &#39;dev-&gt;data-&gt;dev_pr=
ivate&#39; can<br>
cause a segmentation fault if the primary process has exited or if the<br>
shared memory is no longer accessible.<br>
<br>
This patch adds a safety check using rte_mem_virt2phy(), with an<br>
unlikely() branch hint to minimize performance impact in the fast path.<br>
This ensures &#39;dev_private&#39; is still valid before accessing it.<br>
<br>
Fixes: bdad90d12ec8 (&quot;ethdev: change device info get callback to retur=
n int&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpeshawar.e=
du.pk" target=3D"_blank">14pwcse1224@uetpeshawar.edu.pk</a>&gt;<br>
---<br>
=C2=A0lib/ethdev/rte_ethdev.c | 7 +++++++<br>
=C2=A01 file changed, 7 insertions(+)<br>
<br>
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c<br>
index dd7c00bc94..ef5dc55f2e 100644<br>
--- a/lib/ethdev/rte_ethdev.c<br>
+++ b/lib/ethdev/rte_ethdev.c<br>
@@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_et=
h_dev_info *dev_info)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev-&gt;dev_ops-&gt;dev_infos_get =3D=3D NU=
LL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOTSUP;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_eal_process_type() =3D=3D RTE_PROC_SECO=
NDARY &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unlikely(rte_mem_vi=
rt2phy(dev-&gt;data-&gt;dev_private) =3D=3D RTE_BAD_PHYS_ADDR)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RTE_ETHDEV_LOG_LINE(ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Secondary: dev_private not accessible (primary exited?)&quo=
t;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_errno =3D ENODEV;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -rte_errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 diag =3D dev-&gt;dev_ops-&gt;dev_infos_get(dev,=
 dev_info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (diag !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Cleanup already =
filled in device information */<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div style=3D"font-family:Calibri,Aria=
l,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><span style=3D"colo=
r:rgb(12,100,192)">Engr. Khadem Ullah, </span><br></div><div style=3D"font-=
family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">=
<span style=3D"color:rgb(12,100,192)">Software Engineer, </span><br></div><=
span style=3D"color:rgb(12,100,192)">Dreambig Semiconductor Inc <br></span>=
</div><div dir=3D"ltr"><span style=3D"color:rgb(12,100,192)"><a href=3D"htt=
ps://dreambigsemi.com/" target=3D"_blank">https://dreambigsemi.com/</a><br>=
</span></div></div></div></div>

--00000000000022b5d2063a97b91f--
