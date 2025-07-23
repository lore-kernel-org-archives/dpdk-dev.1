Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3139FC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC52D40DD1;
	Wed, 23 Jul 2025 15:26:39 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 344E840DCE
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:26:38 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4abd3627e7eso50732711cf.0
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753277197;
 x=1753881997; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0v8URUyvkobFqxxEJs0fTIJGVMqF1LM8Wzv1TSuE3yA=;
 b=UYb0dV1VRtULflVzW7g1tBXz934gs+TxOZg1An73HrY958dbacQZT/m9DbyhmSEqSB
 SGkeVA8B56G9WGx/MJ83H0n6ddSpM4uWgyhO8tzI9ds8YMV3CVR6ru9/33qyrSwRBVcS
 I+xZXBA63moIlpnrpM0wfHTAZZQXEAxESryyzx10nXxd5h7ijGwx5tk2Aj5+9MNLlxhz
 twdqD2/ztY8DHwSNqtWJL9pJL43mlE+2VKWvMyWpT4LEeC1asOyFQPX4QWR8rTu0HOv8
 s2VkTxc3cYDE/q0PPeJXn/NpFjojKDk2TZQ+zdWKmIaIxbEJjU5c6u/jbeue+JHl8ITz
 jQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753277197; x=1753881997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0v8URUyvkobFqxxEJs0fTIJGVMqF1LM8Wzv1TSuE3yA=;
 b=TrmIti8xE3pWAoC9H5IBE7BeTIyulIN6sRZNFkleH7JqrEM/DTTsBU2cp4uhU63tJy
 +S2bTs1HcZKDchKyh/bz1UlrXt7NE9F9DNL/yz3fhmh+zbVGgJXZvaqcvowlINdDaCGA
 IU+BVT1rMuddkI4jB+Oi6qFIVPc2UwzvnaO+8BjnYjvk8QrQ6vRYZFLwzAK/YLhNf+J+
 oIQgYBVD2woYvn2NYF9Seq/zdr20MKWdtdLVHReDNX6aASfzlCv3ct9DDDh9j3fesOTP
 Gy4bDfbmJ5MhmzYhi3nWkYrQQ7S5Z0hjEOJM3evS584rIZiT1fqHSdQAkHjaAUBkE++A
 fU0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYCu+Oxg8Jf19nQw2se0nxzNg56z0NHF0T1S5RE61FfRXg5zYHc59CFiLIpRcoxmeZyww=@dpdk.org
X-Gm-Message-State: AOJu0YzvfpGX/3peMYuNQh7S+XgVychAsbsLEt+kqr9PYbJQMXso+liW
 bfRzBhYOmfmWgS44yd72cY+zJayF1h5XyUv3h9mEZqx4yuX2sc1OIA7KCAaeSQUy30Z6HcprrAp
 QsuE+HXn0ju6842exbo5UFWNEFCFRGRQOR0DrmXmIyg==
X-Gm-Gg: ASbGncspMpks91eartBKcwZC9r7l2bjoAup3lHP64KoKejylWqDJ3EOEyqtn7BJxcPf
 lNynLDxL3LB1mGa4tOwJ5vp7OsDeUiS6JWgj+9qgK9MVmjOksFGYWbGBaQ47WNtmA7goz8gns8r
 aJY6+yrg2AFYiIiAoy64JlyUhww4PILD7UHCLfZz+2/Co0Ig8eYSAFR7MTDQc8lIKMnTiPjvW4T
 VqoFhTLZSPdAnUO56UArYEFzQwvaHoDd3L1lW3ABg==
X-Google-Smtp-Source: AGHT+IHpqxnzo3EHHixemO/eksvYm7Xb4nq41KHo9qsMoVzBKEv+gdoV7fygpuQDPCBaQfKBnuU2SQQHSLHVehLb7q4=
X-Received: by 2002:a05:6214:dc6:b0:707:c5a:e577 with SMTP id
 6a1803df08f44-7070c5aeddcmr436706d6.39.1753277197283; Wed, 23 Jul 2025
 06:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
 <CA++2-x7U1D8pB1dzuyoeQ4WQKcCpv32HVji23Ev=cdM=G9MROA@mail.gmail.com>
 <CA++2-x4qtuSz1HCA5BF6gybpaUhAivmeCCj3B_eURZJL5pLh-Q@mail.gmail.com>
 <dbf3b51a-7bd8-2f48-a038-5e7b92994e07@arknetworks.am>
In-Reply-To: <dbf3b51a-7bd8-2f48-a038-5e7b92994e07@arknetworks.am>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 23 Jul 2025 18:26:24 +0500
X-Gm-Features: Ac12FXyf4aX5VJJOtbypXdhrgDY2obtOhSXNrXU46I2qE9PuIkpIpdQdc8T6yw0
Message-ID: <CA++2-x5vbQKk4PJRL8D5QD3iNM5jBh7fwd=qk+2gRvwsd59_3A@mail.gmail.com>
Subject: Re: [PATCH v2] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000008989f8063a98a8d9"
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

--0000000000008989f8063a98a8d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, no.
Can, I ?

On Wed, Jul 23, 2025, 18:24 Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Hi Khadem,
>
> On Wed, 23 Jul 2025, Khadem Ullah wrote:
>
> > Please check v3 of this patch.
>
> Checked. In the meantime, you're not overlooking to mark previous version=
s
> [1]
> with status 'SUPERSEDED' in DPDK Patchwork, are you?
>
> [1]
> https://patches.dpdk.org/project/dpdk/patch/20250723045022.1580829-1-14pw=
cse1224@uetpeshawar.edu.pk/
>
> >
> > On Wed, Jul 23, 2025 at 5:19=E2=80=AFPM Khadem Ullah <
> 14pwcse1224@uetpeshawar.edu.pk> wrote:
> >
> > Secondary application not only breaking on device closing,
> > it's also getting segfault when we do "show device info all" from
> secondary
> > after primary closes:
> > testpmd> show device info all
> > ********************* Infos for device 0000:03:00.0 *******************=
**
> > Bus name: pci
> > Bus information: vendor_id=3D15b3, device_id=3D101d
> > Driver name: mlx5_pci
> > Devargs:
> > Connect to socket: 0
> > Segmentation fault (core dumped)
> > This patch prevents these crashes and it seems that these fixes should
> be in PMD along with the ethdev layer. Some more checks will be added in
> the next version to prevent "show device i
> > nfo all" crash.
> >
> >
> > On Wed, Jul 23, 2025 at 9:50=E2=80=AFAM Khadem Ullah <
> 14pwcse1224@uetpeshawar.edu.pk> wrote:
> >       In secondary processes, directly accessing
> 'dev->data->dev_private' can
> >       cause a segmentation fault if the primary process has exited or i=
f
> the
> >       shared memory is no longer accessible.
> >
> >       This patch adds a safety check using rte_mem_virt2phy(), with an
> >       unlikely() branch hint to minimize performance impact in the fast
> path.
> >       This ensures 'dev_private' is still valid before accessing it.
> >
> >       Fixes: bdad90d12ec8 ("ethdev: change device info get callback to
> return int")
> >       Cc: stable@dpdk.org
> >
> >       Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> >       ---
> >        lib/ethdev/rte_ethdev.c | 7 +++++++
> >        1 file changed, 7 insertions(+)
> >
> >       diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> >       index dd7c00bc94..ef5dc55f2e 100644
> >       --- a/lib/ethdev/rte_ethdev.c
> >       +++ b/lib/ethdev/rte_ethdev.c
> >       @@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id,
> struct rte_eth_dev_info *dev_info)
> >
> >               if (dev->dev_ops->dev_infos_get =3D=3D NULL)
> >                       return -ENOTSUP;
> >       +       if (rte_eal_process_type() =3D=3D RTE_PROC_SECONDARY &&
> >       +               unlikely(rte_mem_virt2phy(dev->data->dev_private)
> =3D=3D RTE_BAD_PHYS_ADDR)) {
> >       +                       RTE_ETHDEV_LOG_LINE(ERR,
> >       +                       "Secondary: dev_private not accessible
> (primary exited?)");
> >       +                       rte_errno =3D ENODEV;
> >       +                       return -rte_errno;
> >       +       }
> >               diag =3D dev->dev_ops->dev_infos_get(dev, dev_info);
> >               if (diag !=3D 0) {
> >                       /* Cleanup already filled in device information *=
/
> >       --
> >       2.43.0
> >
> >
> >
> > --
> > Engr. Khadem Ullah,
> > Software Engineer,
> > Dreambig Semiconductor Inc
> > https://dreambigsemi.com/
> >
> >
> >
> > --
> > Engr. Khadem Ullah,
> > Software Engineer,
> > Dreambig Semiconductor Inc
> > https://dreambigsemi.com/
> >
> >

--0000000000008989f8063a98a8d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks, no.=C2=A0<div dir=3D"auto">Can, I ?=C2=A0</div></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Wed, Jul 23, 2025, 18:24 Ivan Malov &lt;<a href=3D"m=
ailto:ivan.malov@arknetworks.am">ivan.malov@arknetworks.am</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">Hi Khadem,<br>
<br>
On Wed, 23 Jul 2025, Khadem Ullah wrote:<br>
<br>
&gt; Please check v3 of this patch.<br>
<br>
Checked. In the meantime, you&#39;re not overlooking to mark previous versi=
ons [1]<br>
with status &#39;SUPERSEDED&#39; in DPDK Patchwork, are you?<br>
<br>
[1] <a href=3D"https://patches.dpdk.org/project/dpdk/patch/20250723045022.1=
580829-1-14pwcse1224@uetpeshawar.edu.pk/" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://patches.dpdk.org/project/dpdk/patch/20250723045022.1=
580829-1-14pwcse1224@uetpeshawar.edu.pk/</a><br>
<br>
&gt; <br>
&gt; On Wed, Jul 23, 2025 at 5:19=E2=80=AFPM Khadem Ullah &lt;<a href=3D"ma=
ilto:14pwcse1224@uetpeshawar.edu.pk" target=3D"_blank" rel=3D"noreferrer">1=
4pwcse1224@uetpeshawar.edu.pk</a>&gt; wrote:<br>
&gt; <br>
&gt; Secondary application not only breaking on device closing,<br>
&gt; it&#39;s also getting segfault when we do &quot;show device info all&q=
uot; from secondary<br>
&gt; after primary closes:<br>
&gt; testpmd&gt; show device info all<br>
&gt; ********************* Infos for device 0000:03:00.0 ******************=
***<br>
&gt; Bus name: pci<br>
&gt; Bus information: vendor_id=3D15b3, device_id=3D101d<br>
&gt; Driver name: mlx5_pci<br>
&gt; Devargs:<br>
&gt; Connect to socket: 0<br>
&gt; Segmentation fault (core dumped)<br>
&gt; This patch prevents these crashes and it seems that these fixes should=
 be in PMD along with the ethdev layer. Some more checks will be added in t=
he next version to prevent &quot;show device i<br>
&gt; nfo all&quot; crash.<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Jul 23, 2025 at 9:50=E2=80=AFAM Khadem Ullah &lt;<a href=3D"ma=
ilto:14pwcse1224@uetpeshawar.edu.pk" target=3D"_blank" rel=3D"noreferrer">1=
4pwcse1224@uetpeshawar.edu.pk</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0In secondary processes, directly accessing &=
#39;dev-&gt;data-&gt;dev_private&#39; can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cause a segmentation fault if the primary pr=
ocess has exited or if the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0shared memory is no longer accessible.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0This patch adds a safety check using rte_mem=
_virt2phy(), with an<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unlikely() branch hint to minimize performan=
ce impact in the fast path.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0This ensures &#39;dev_private&#39; is still =
valid before accessing it.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Fixes: bdad90d12ec8 (&quot;ethdev: change de=
vice info get callback to return int&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Cc: <a href=3D"mailto:stable@dpdk.org" targe=
t=3D"_blank" rel=3D"noreferrer">stable@dpdk.org</a><br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Khadem Ullah &lt;<a href=3D"m=
ailto:14pwcse1224@uetpeshawar.edu.pk" target=3D"_blank" rel=3D"noreferrer">=
14pwcse1224@uetpeshawar.edu.pk</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0lib/ethdev/rte_ethdev.c | 7 +++++++<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 7 insertions(+)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0diff --git a/lib/ethdev/rte_ethdev.c b/lib/e=
thdev/rte_ethdev.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0index dd7c00bc94..ef5dc55f2e 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--- a/lib/ethdev/rte_ethdev.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+++ b/lib/ethdev/rte_ethdev.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(=
uint16_t port_id, struct rte_eth_dev_info *dev_info)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev-&gt;dev_=
ops-&gt;dev_infos_get =3D=3D NULL)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return -ENOTSUP;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_eal_proc=
ess_type() =3D=3D RTE_PROC_SECONDARY &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0unlikely(rte_mem_virt2phy(dev-&gt;data-&gt;dev_private) =3D=3D=
 RTE_BAD_PHYS_ADDR)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE(ERR,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Secondary: dev_private not a=
ccessible (primary exited?)&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_errno =3D ENODEV;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -rte_errno;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 diag =3D dev-&gt=
;dev_ops-&gt;dev_infos_get(dev, dev_info);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (diag !=3D 0)=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* Cleanup already filled in device information */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A02.43.0<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; --<br>
&gt; Engr. Khadem Ullah,<br>
&gt; Software Engineer,<br>
&gt; Dreambig Semiconductor Inc<br>
&gt; <a href=3D"https://dreambigsemi.com/" rel=3D"noreferrer noreferrer" ta=
rget=3D"_blank">https://dreambigsemi.com/</a><br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; --<br>
&gt; Engr. Khadem Ullah,<br>
&gt; Software Engineer,<br>
&gt; Dreambig Semiconductor Inc<br>
&gt; <a href=3D"https://dreambigsemi.com/" rel=3D"noreferrer noreferrer" ta=
rget=3D"_blank">https://dreambigsemi.com/</a><br>
&gt; <br>
&gt;</blockquote></div>

--0000000000008989f8063a98a8d9--
