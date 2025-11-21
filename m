Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2D2CFC50A
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 21:09:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21EAF40280;
	Fri, 21 Nov 2025 22:09:48 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id EEB8940269
 for <dev@dpdk.org>; Fri, 21 Nov 2025 22:09:46 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3410c86070dso1912031a91.1
 for <dev@dpdk.org>; Fri, 21 Nov 2025 13:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763759386; x=1764364186; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vr/B90AtjRVZVq9gSc54Fpf+Ex8NSX+61E3wHKkfU64=;
 b=f5ks01JH8T1S6MUI9fUF10eOUqBIMG7UA6pFS8VNqS+88je0EEgE9ijVO1WqbAE6SR
 E0u0Zg+D48QfTENHYGEhxVqWcz3V6blKQRmBjg3UO/J5zxwwAIGcszG4D3w2ry6GBUMs
 hzG0L+zyEGqC+MCBtu4BvjcA6usBXCh/Z1Rto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763759386; x=1764364186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vr/B90AtjRVZVq9gSc54Fpf+Ex8NSX+61E3wHKkfU64=;
 b=L5d9xrFmyPfAD69WY+2VaS/Hesjg5cXvJ/sBkb7d4Adnc6v/I6X/Sjxfu63sdZpzXl
 i5WNPec4wCJLY0nvVoNNm8gm4jf0fob1nHFrH2YT3CDmKYvLV5R4/WJiN0c07FRCwEip
 k4i7CTLcAmfFda5uBHE5ZyQfnUwpphmdtf+1exJNibvTNFurBohz24FxC1pV3FoB7/bP
 dvcPVNSd4+xlDxFjdyNCsk+Kqu3ZYQT3HpG7sKY7BzPle1Pq0BgOBz01oGix5EH9yMrL
 0wHZBkL/pAmhCqmLzvvpW3xEkac4x18CdtHQTYZJh39hrH5Od3s86jDrpWrNS+yxoEJL
 fmMQ==
X-Gm-Message-State: AOJu0YwVM/FbH57X8c5CrlA/7nvjjIpuW2dLrPIu26j2zAxQQKBfBHDZ
 5xDSD3vcaQeLotMW6PCKwsuTAQ7pNKl0NQeHB2ysAKGMMXPF33Z6K1Y/cNcrrFz6Y8Mz8uVFWQY
 mHgYK71IH87xoAwYnrIXr4oYHueBo4ZCaMcZzYfGXkw==
X-Gm-Gg: ASbGncsk0T6TL7O1xMctK82CN+OVBx7RMzwMI1QWK7CJmUD11PGgPA85YVPtZ5P59n9
 ijUYumfogEpHG6pLm526fgcLziLdL9MoqoJkDwYC9Vo1XovxOIPdXtCU2/is0n7MRuikNWEhLfx
 w4ZoGD6T1vtRWFoSNUUaOws80LKKBUszzAoFS6gFuxl2n046S5yLCNxi+JFmHNEujUhrC+8JOIs
 lEkldvNsGcrVYF0ftIt+BwkartQvZfcyOS0TDlf1VhEM03ciO6+qt08PNXq99X33Wc5rLCZvHnJ
 RG11nUUNNSjtAwjkET9uGmKtQeJi
X-Google-Smtp-Source: AGHT+IEZHdYGDfZiumwEnI57dUPB6Emhr9htOJmfaNjvhTocwBEEXgz7LbikZ8DOwR/NPNb4+P2tLRlEjxc5RvDN2Mg=
X-Received: by 2002:a05:7022:ebc3:b0:11a:4ffb:9825 with SMTP id
 a92af1059eb24-11c9d70abb4mr1451603c88.6.1763759386058; Fri, 21 Nov 2025
 13:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20251121210650.328804-1-abailey@iol.unh.edu>
In-Reply-To: <20251121210650.328804-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 21 Nov 2025 16:08:22 -0500
X-Gm-Features: AWmQ_bksArSdQ-aqBmzmsnP-QTQ_9xwbYobMOWZNXbj9vIivCNtxPHHE0Zsxr9Q
Message-ID: <CAJvnSUA-g8b8yWakMo4-WOwGncsk5FnO-5aw49va-1-VSg=xoA@mail.gmail.com>
Subject: Re: [PATCH v1] dts: automate VFIO-PCI modprobe
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com
Content-Type: multipart/alternative; boundary="000000000000acf2380644213b11"
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

--000000000000acf2380644213b11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think there is a missing check for if ports is None (user is not
providing ports, trying to only run NO_LINKS tests).

On Fri, Nov 21, 2025 at 4:06=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Currently, users must modprobe vfio-pci before running DTS when using a
> non-mellanox NIC. This patch automates the process on test run start up.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/framework/test_run.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index ff0a12c9ce..38f9e6c07d 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -347,6 +347,10 @@ def next(self) -> State | None:
>          test_run.ctx.dpdk.setup()
>          test_run.ctx.topology.setup()
>
> +        if test_run.ctx.sut_node.ports[0].config.os_driver_for_dpdk =3D=
=3D
> "vfio-pci":
> +            test_run.ctx.sut_node.main_session.send_command("modprobe
> vfio")
> +            test_run.ctx.sut_node.main_session.send_command("modprobe
> vfio-pci")
> +
>          if test_run.config.use_virtual_functions:
>              test_run.ctx.topology.instantiate_vf_ports()
>
> --
> 2.50.1
>
>

--000000000000acf2380644213b11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think there is a missing check for if ports is None (use=
r is not providing ports, trying to only run NO_LINKS tests).</div><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Fri, Nov 21, 2025 at 4:06=E2=80=AFPM Andrew Bailey &lt;<a href=
=3D"mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Currently, users must mo=
dprobe vfio-pci before running DTS when using a<br>
non-mellanox NIC. This patch automates the process on test run start up.<br=
>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/test_run.py | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py<br>
index ff0a12c9ce..38f9e6c07d 100644<br>
--- a/dts/framework/test_run.py<br>
+++ b/dts/framework/test_run.py<br>
@@ -347,6 +347,10 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.dpdk.setup()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.topology.setup()<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if test_run.ctx.sut_node.ports[0].config.os_dr=
iver_for_dpdk =3D=3D &quot;vfio-pci&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.sut_node.main_sessi=
on.send_command(&quot;modprobe vfio&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.sut_node.main_sessi=
on.send_command(&quot;modprobe vfio-pci&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test_run.config.use_virtual_functions:=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.topology.insta=
ntiate_vf_ports()<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div>

--000000000000acf2380644213b11--
