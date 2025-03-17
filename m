Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB11C28B30
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 15:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89172402D1;
	Mon, 17 Mar 2025 16:02:35 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 127F9402BB
 for <dev@dpdk.org>; Mon, 17 Mar 2025 16:02:33 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so4455103a91.3
 for <dev@dpdk.org>; Mon, 17 Mar 2025 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1742223752; x=1742828552; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oIumwP5KEyLbFXfLk00wo5ggxt8usFzCzP8se7PO6lE=;
 b=MsCyQRXuqsJcuBsGXiXJRRF52jWIUprkXplSL4oNOEAI6NOVikfl41bdnEaBg8hsez
 XkXBVgje+ZHh6EJJX+Rr5EGm5E2fzrypZT2v8YwbLJdQUCXAwyO+s8zlniBtcnmtTK+Y
 bxgBhOUBc7CiumldWCuZER4sNpeKPSmV46XczKlyTkc5W3+yt7XBQIBTn8TiQeh4psnU
 UYmlGTJgvGWZoW06eC87OItdp4Wl40x0oF4eC3hSnTKbDkmkrvIZSpH1Ltv14Bh6m4XR
 hy4XBlYaHM7JLIAM8X3U3mU9dfqzbR+h7HAOOFc1RU+m26JStXMse0ArEAkUTzqp1j6a
 uXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742223752; x=1742828552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oIumwP5KEyLbFXfLk00wo5ggxt8usFzCzP8se7PO6lE=;
 b=AM8p+dWb9nLs8fXAncS5/CMBoROiYHtsbY7r+oKuCBxJuOA5iFd8Ui1dl/ZpI8G1bN
 plHeRPh7nCJlqT6o1uHAktgqkVCBy9gN36KWQnkVNLEw9JiWuC3XljoDNtj7HXqC3t7M
 IniCIt8xuBHBSFKL8voHh25YShJAn808zaKMMhSCXum7yyA6NCAK472KRMC4y5znMUvS
 iIOk7ur3CRwPgRjv8wIHV6oBlRvtvU931gh1u2PGK3YwI2G/RCmmfccZOn+Ee9ZGLLuk
 DIqnz3e9WRkhLGTRGfPfQCUHPvBKZlMx1FriyLJ13avapQ2SZXUKOzG8Az90PlO6tljx
 AbGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr0M3U8H4LVGU6y5EqlPhbaxvJVGzMKD/WoXPaZ2hzNkvowISChuvIaL6Rlb7gAqdVTQU=@dpdk.org
X-Gm-Message-State: AOJu0Ywsft6+ez22NYQeClkLYptlIYWhn1RhJTdNdnOntGhg8EcLfQ3f
 1HMRy0ZszLnaiCM8DTfQN6ydLRHrnrU2+McUazIl24O8RUfp9l54adjVD6rYPO8O26FYgB1uCl+
 qytJE1maCNtkrobx1c9C3MCR/yKRIOaSslpFb5g==
X-Gm-Gg: ASbGnctYpzXLnMrDzhtS8296/7koDFB8Uz8gl9o+20w53BNKkCH0MR6OM28XbjyQO34
 QramRV8acqE48gaeGJ1oHHBjpooRJKEm2OB8r6QmOEEvecCTOz0KIuyAajK/A9kFFx9aXR3MnGU
 FWOFiH4t8xQMJ5016gS3KE6/rp
X-Google-Smtp-Source: AGHT+IHIaA+5CRqiK9u/p8Ta9ISbsyXKyCE+r1wBn1THwWcFfwHRN8lmXk821UnkWojpIpXtO66xDqKrS4OBi+V+d+0=
X-Received: by 2002:a17:90b:38ce:b0:2ff:6ac2:c5a5 with SMTP id
 98e67ed59e1d1-3019e9b76b2mr29504a91.26.1742223751668; Mon, 17 Mar 2025
 08:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <CANDF9xANRqeTnkvAk61y=2TCd2fsWDQQ4YoTFdpL-RW8ksDDGQ@mail.gmail.com>
 <MN0PR12MB6053E6AC8E0FAA9373205EACCD012@MN0PR12MB6053.namprd12.prod.outlook.com>
 <MN6PR12MB8567C39321AD9C6B21B4AB49DF022@MN6PR12MB8567.namprd12.prod.outlook.com>
 <CANDF9xDbByceRnf=VCZQ12kJq+jh5_3_mV-=f4tP5HZ-Zej7nw@mail.gmail.com>
 <MN6PR12MB856709C6B79CE697745B1FB6DFCB2@MN6PR12MB8567.namprd12.prod.outlook.com>
In-Reply-To: <MN6PR12MB856709C6B79CE697745B1FB6DFCB2@MN6PR12MB8567.namprd12.prod.outlook.com>
From: Edwin Brossette <edwin.brossette@6wind.com>
Date: Mon, 17 Mar 2025 16:02:20 +0100
X-Gm-Features: AQ5f1JrbRwYnP-AUlVKV82zvIlTUzSnHVSNEG_Twwn9ul3oEc37Ga0qXKL3XsPY
Message-ID: <CANDF9xC28Zy_ZfaquWufYfymjtVtFVP-wM21BWZe1t73a=0Jzg@mail.gmail.com>
Subject: Re: net/mlx5: wrong Rx/Tx descriptor limits when DevX is off
To: Slava Ovsiienko <viacheslavo@nvidia.com>
Cc: Asaf Penso <asafp@nvidia.com>, "igootorov@gmail.com" <igootorov@gmail.com>,
 Laurent Hardy <laurent.hardy@6wind.com>, Olivier Matz <olivier.matz@6wind.com>,
 Didier Pallard <didier.pallard@6wind.com>, Jean-Mickael Guerin <jmg@6wind.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000d6850706308b134c"
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

--000000000000d6850706308b134c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for your answer.
The short patch I joined with my first mail was just a rough example to
report what I tested. I believe you know the driver's code better than I
do, so I wouldn't be opposed to see you fix this issue.
Thank you in advance.

Regards,
Edwin Brossette.

On Wed, Mar 5, 2025 at 10:17=E2=80=AFAM Slava Ovsiienko <viacheslavo@nvidia=
.com>
wrote:

> Hi, Edwin
>
>
>
> Thank you for the patch.
>
> You are quite right, =E2=80=9Csh->cdev->config.hca_attr.log_max_wq_sz=E2=
=80=9D is not set
> if DevX is disengaged.
>
> I found some other places where the uninitialized =E2=80=9Clog_max_wq_sz=
=E2=80=9D might be
> used.
> So. I=E2=80=99d rather prefer to configure the =E2=80=9Clog_max_wq_sz=E2=
=80=9D for IBV case as
> well, instead of just fixing mlx5_dev_infos_get().
>
>
> There is the property in  =E2=80=9Cpriv->sh->dev_cap.max_qp_wr=E2=80=9D, =
it reflects the
> max number of descriptors if rdma_core is used.
>
> Would you like to update your patch with this? Or would you prefer me to
> do it ?
>
> With best regards,
> Slava
>
>
>
>
>
> *From:* Edwin Brossette <edwin.brossette@6wind.com>
> *Sent:* Wednesday, February 12, 2025 4:34 PM
> *To:* Slava Ovsiienko <viacheslavo@nvidia.com>
> *Cc:* Asaf Penso <asafp@nvidia.com>; igootorov@gmail.com; Laurent Hardy <
> laurent.hardy@6wind.com>; Olivier Matz <olivier.matz@6wind.com>; Didier
> Pallard <didier.pallard@6wind.com>; Jean-Mickael Guerin <jmg@6wind.com>;
> dev@dpdk.org
> *Subject:* Re: net/mlx5: wrong Rx/Tx descriptor limits when DevX is off
>
>
>
> Hello,
>
>
>
> Sorry for bothering you again.
>
> May I inquire if this issue is still being worked on ?
>
> If so, when can I expect to see a fix ?
>
>
>
> Best regards,
>
> Edwin Brossette
>
>
>
> On Mon, Dec 23, 2024 at 2:09=E2=80=AFPM Slava Ovsiienko <viacheslavo@nvid=
ia.com>
> wrote:
>
> Confirm, it=E2=80=99s a bug, IIUC was introduced by reporting function up=
date.
> AFAIK, we do not test with non-DevX environment anymore, so missed this.
>
> Fix should be provided.
>
>
>
> With best regards,
>
> Slava
>
>
>
> *From:* Asaf Penso <asafp@nvidia.com>
> *Sent:* Sunday, December 22, 2024 9:39 AM
> *To:* igootorov@gmail.com; Slava Ovsiienko <viacheslavo@nvidia.com>
> *Cc:* Laurent Hardy <laurent.hardy@6wind.com>; Olivier Matz <
> olivier.matz@6wind.com>; Didier Pallard <didier.pallard@6wind.com>;
> Jean-Mickael Guerin <jmg@6wind.com>; Edwin Brossette <
> edwin.brossette@6wind.com>; dev@dpdk.org
> *Subject:* RE: net/mlx5: wrong Rx/Tx descriptor limits when DevX is off
>
>
>
> Hello Igor and Slava,
>
> Can you please check out this issue?
>
>
>
> Regards,
>
> Asaf Penso
>
>
>
> *From:* Edwin Brossette <edwin.brossette@6wind.com>
> *Sent:* Friday, 20 December 2024 19:06
> *To:* dev@dpdk.org
> *Cc:* Laurent Hardy <laurent.hardy@6wind.com>; Olivier Matz <
> olivier.matz@6wind.com>; Didier Pallard <didier.pallard@6wind.com>;
> Jean-Mickael Guerin <jmg@6wind.com>
> *Subject:* net/mlx5: wrong Rx/Tx descriptor limits when DevX is off
>
>
>
> Hello,
>
> I have run into a regression following an update to stable dpdk-24.11 wit=
h
> a number of my Mellanox cx4/5/6 nics. This regression occurs with all nic=
s
> in my lab which have DevX disabled: using mstconfig utility, I can see th=
e
> flag UCTX_EN is not set.
>
> Mainly, the issue is that the ports cannot be started, with the following
> error logs in the journal:
>
> Set nb_rxd=3D1 (asked=3D512) for port=3D0
> Set nb_txd=3D1 (asked=3D512) for port=3D0
> starting port 0
> Initializing port 0 [7c:fe:90:65:e6:54]
> port 0: ntfp1 (mlx5_pci)
> nb_rxq=3D2 nb_txq=3D2
> rxq0=3Dc9 rxq1=3Dc25
> txq0=3Dc9 txq1=3Dc25
> port 0: rx_scatter=3D0 tx_scatter=3D0 max_rx_frame=3D1526
> mlx5_net: port 0 number of descriptors requested for Tx queue 0 must be
> higher than MLX5_TX_COMP_THRESH, using 33 instead of 1
> mlx5_net: port 0 increased number of descriptors in Tx queue 0 to the nex=
t
> power of two (64)
> mlx5_net: port 0 number of descriptors requested for Tx queue 1 must be
> higher than MLX5_TX_COMP_THRESH, using 33 instead of 1
> mlx5_net: port 0 increased number of descriptors in Tx queue 1 to the nex=
t
> power of two (64)
> mlx5_net: Port 0 Rx queue 0 CQ creation failure.
> mlx5_net: port 0 Rx queue allocation failed: Cannot allocate memory
> rte_eth_dev_start(port 0) failed, error=3D-12
> Failed to start port 0, set link down
> Failed to start port 0
>
>
> Looking more precisely into the problem, it appears that the number of Rx
> and Tx descriptors configured for my queues is 1. This happens because
> mlx5_dev_infos_get() return a limit of 1 for both Rx and Tx, which is
> unexpected. I identified this patch to be responsible for the regression:
>
> 4c3d7961d9002: net/mlx5: fix reported Rx/Tx descriptor limits
>
> https://git.dpdk.org/dpdk/commit/?id=3D4c3d7961d9002bb715a8ee76bcf464d633=
316d4c
>
> After doing some debugging, I noticed that hca_attr.log_max_wq_sz is neve=
r
> configured. This should be done in mlx5_devx_cmd_query_hca_attr() which i=
s
> called in this bit of code:
>
> https://git.dpdk.org/dpdk/tree/drivers/common/mlx5/mlx5_common.c#n681
>
> /*
> * When CTX is created by Verbs, query HCA attribute is unsupported.
> * When CTX is imported, we cannot know if it is created by DevX or
> * Verbs. So, we use query HCA attribute function to check it.
> */
> if (cdev->config.devx || cdev->config.device_fd !=3D MLX5_ARG_UNSET) {
>
> /* Query HCA attributes. */
> ret =3D mlx5_devx_cmd_query_hca_attr(cdev->ctx, &cdev->config.hca_attr);
> if (ret) {
>
> DRV_LOG(ERR, "Unable to read HCA caps in DevX mode.");
> rte_errno =3D ENOTSUP;
> goto error;
>
> }
> cdev->config.devx =3D 1;
>
> }
> DRV_LOG(DEBUG, "DevX is %ssupported.", cdev->config.devx ? "" : "NOT ");
>
>
>
> I deduced that following the above patch, the correct value for maximum R=
x
> and Tx descriptors will only be set if DevX is enabled (see the if
> condition on cdev->config.devx). If it is disabled, then maximum Rx and T=
x
> descriptors will be 1, which will make the ports fail to start. Perhaps w=
e
> should keep the previous default value (65535) if config.devx =3D=3D 0 (D=
evX
> off)? This could be done like this, for example:
>
> diff --git a/drivers/net/mlx5/mlx5_ethdev.c
> b/drivers/net/mlx5/mlx5_ethdev.c
> index 7708a0b80883..8ba3eb4a32de 100644
> --- a/drivers/net/mlx5/mlx5_ethdev.c
> +++ b/drivers/net/mlx5/mlx5_ethdev.c
> @@ -359,10 +359,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct
> rte_eth_dev_info *info)
>         info->flow_type_rss_offloads =3D ~MLX5_RSS_HF_MASK;
>         mlx5_set_default_params(dev, info);
>         mlx5_set_txlimit_params(dev, info);
> -       info->rx_desc_lim.nb_max =3D
> -               1 << priv->sh->cdev->config.hca_attr.log_max_wq_sz;
> -       info->tx_desc_lim.nb_max =3D
> -               1 << priv->sh->cdev->config.hca_attr.log_max_wq_sz;
> +       if (priv->sh->cdev->config.devx) {
> +               info->rx_desc_lim.nb_max =3D
> +                       1 << priv->sh->cdev->config.hca_attr.log_max_wq_s=
z;
> +               info->tx_desc_lim.nb_max =3D
> +                       1 << priv->sh->cdev->config.hca_attr.log_max_wq_s=
z;
> +       }
>         if (priv->sh->cdev->config.hca_attr.mem_rq_rmp &&
>             priv->obj_ops.rxq_obj_new =3D=3D devx_obj_ops.rxq_obj_new)
>                 info->dev_capa |=3D RTE_ETH_DEV_CAPA_RXQ_SHARE;
>
> Thanks in advance for your help.
>
> Regards,
> Edwin Brossette.
>
>
>
>

--000000000000d6850706308b134c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br><div>Thank you for your answer.</div><div>Th=
e short patch I joined with my first mail was just a rough example to repor=
t what I tested. I believe you know the driver&#39;s code better than I do,=
 so I wouldn&#39;t be opposed to see you fix this issue.</div><div>Thank yo=
u in advance.</div><div><br></div><div>Regards,</div><div>Edwin Brossette.<=
br></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div di=
r=3D"ltr" class=3D"gmail_attr">On Wed, Mar 5, 2025 at 10:17=E2=80=AFAM Slav=
a Ovsiienko &lt;<a href=3D"mailto:viacheslavo@nvidia.com">viacheslavo@nvidi=
a.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div class=3D"msg-3925878757954808893">





<div style=3D"overflow-wrap: break-word;" lang=3D"EN-US">
<div class=3D"m_-3925878757954808893WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Hi, Edwin<u></u><u></=
u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Thank you for the pat=
ch.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">You are quite right, =
=E2=80=9Csh-&gt;</span>cdev-&gt;config.hca_attr.log_max_wq_sz=E2=80=9D is n=
ot set if DevX is disengaged.<u></u><u></u></p>
<p class=3D"MsoNormal">I found some other places where the uninitialized =
=E2=80=9Clog_max_wq_sz=E2=80=9D might be used.<br>
So. I=E2=80=99d rather prefer to configure the =E2=80=9Clog_max_wq_sz=E2=80=
=9D for IBV case as well, instead of just fixing mlx5_dev_infos_get().<u></=
u><u></u></p>
<p class=3D"MsoNormal"><br>
There is the property in =C2=A0=E2=80=9Cpriv-&gt;sh-&gt;dev_cap.max_qp_wr=
=E2=80=9D, it reflects the max number of descriptors if rdma_core is used.<=
u></u><u></u></p>
<p class=3D"MsoNormal">Would you like to update your patch with this? Or wo=
uld you prefer me to do it ?<br>
<br>
<u></u><u></u></p>
<p class=3D"MsoNormal">With best regards,<br>
Slava<u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<u></u><=
/span></p>
<div style=3D"border-color:currentcolor currentcolor currentcolor blue;bord=
er-style:none none none solid;border-width:medium medium medium 1.5pt;paddi=
ng:0cm 0cm 0cm 4pt">
<div>
<div style=3D"border-color:rgb(225,225,225) currentcolor currentcolor;borde=
r-style:solid none none;border-width:1pt medium medium;padding:3pt 0cm 0cm"=
>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;C=
alibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11pt;font=
-family:&quot;Calibri&quot;,sans-serif"> Edwin Brossette &lt;<a href=3D"mai=
lto:edwin.brossette@6wind.com" target=3D"_blank">edwin.brossette@6wind.com<=
/a>&gt;
<br>
<b>Sent:</b> Wednesday, February 12, 2025 4:34 PM<br>
<b>To:</b> Slava Ovsiienko &lt;<a href=3D"mailto:viacheslavo@nvidia.com" ta=
rget=3D"_blank">viacheslavo@nvidia.com</a>&gt;<br>
<b>Cc:</b> Asaf Penso &lt;<a href=3D"mailto:asafp@nvidia.com" target=3D"_bl=
ank">asafp@nvidia.com</a>&gt;; <a href=3D"mailto:igootorov@gmail.com" targe=
t=3D"_blank">igootorov@gmail.com</a>; Laurent Hardy &lt;<a href=3D"mailto:l=
aurent.hardy@6wind.com" target=3D"_blank">laurent.hardy@6wind.com</a>&gt;; =
Olivier Matz &lt;<a href=3D"mailto:olivier.matz@6wind.com" target=3D"_blank=
">olivier.matz@6wind.com</a>&gt;; Didier Pallard &lt;<a href=3D"mailto:didi=
er.pallard@6wind.com" target=3D"_blank">didier.pallard@6wind.com</a>&gt;; J=
ean-Mickael Guerin &lt;<a href=3D"mailto:jmg@6wind.com" target=3D"_blank">j=
mg@6wind.com</a>&gt;; <a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev=
@dpdk.org</a><br>
<b>Subject:</b> Re: net/mlx5: wrong Rx/Tx descriptor limits when DevX is of=
f<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Hello,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Sorry for bothering you again.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">May I inquire if this issue is still being worked on=
 ? <u></u>
<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">If so, when can I expect to see a fix ?<u></u><u></u=
></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Best regards,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Edwin Brossette<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Mon, Dec 23, 2024 at 2:09<span style=3D"font-fami=
ly:&quot;Arial&quot;,sans-serif">=E2=80=AF</span>PM Slava Ovsiienko &lt;<a =
href=3D"mailto:viacheslavo@nvidia.com" target=3D"_blank">viacheslavo@nvidia=
.com</a>&gt; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border-color:currentcolor currentcolor currentcolor rg=
b(204,204,204);border-style:none none none solid;border-width:medium medium=
 medium 1pt;padding:0cm 0cm 0cm 6pt;margin-left:4.8pt;margin-right:0cm">
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Confirm, it=E2=80=99s=
 a bug, IIUC was introduced by reporting function update.<br>
AFAIK, we do not test with non-DevX environment anymore, so missed this.</s=
pan><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Fix should be provide=
d.</span><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">=C2=A0</span><u></u><=
u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">With best regards,</s=
pan><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Slava</span><u></u><u=
></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">=C2=A0</span><u></u><=
u></u></p>
<div style=3D"border-style:none none none solid;border-width:medium medium =
medium 1.5pt;padding:0cm 0cm 0cm 4pt;border-color:currentcolor currentcolor=
 currentcolor blue">
<div>
<div style=3D"border-style:solid none none;border-width:1pt medium medium;p=
adding:3pt 0cm 0cm;border-color:currentcolor">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;C=
alibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11pt;font=
-family:&quot;Calibri&quot;,sans-serif"> Asaf Penso &lt;<a href=3D"mailto:a=
safp@nvidia.com" target=3D"_blank">asafp@nvidia.com</a>&gt;
<br>
<b>Sent:</b> Sunday, December 22, 2024 9:39 AM<br>
<b>To:</b> <a href=3D"mailto:igootorov@gmail.com" target=3D"_blank">igootor=
ov@gmail.com</a>; Slava Ovsiienko &lt;<a href=3D"mailto:viacheslavo@nvidia.=
com" target=3D"_blank">viacheslavo@nvidia.com</a>&gt;<br>
<b>Cc:</b> Laurent Hardy &lt;<a href=3D"mailto:laurent.hardy@6wind.com" tar=
get=3D"_blank">laurent.hardy@6wind.com</a>&gt;; Olivier Matz &lt;<a href=3D=
"mailto:olivier.matz@6wind.com" target=3D"_blank">olivier.matz@6wind.com</a=
>&gt;; Didier Pallard &lt;<a href=3D"mailto:didier.pallard@6wind.com" targe=
t=3D"_blank">didier.pallard@6wind.com</a>&gt;;
 Jean-Mickael Guerin &lt;<a href=3D"mailto:jmg@6wind.com" target=3D"_blank"=
>jmg@6wind.com</a>&gt;; Edwin Brossette &lt;<a href=3D"mailto:edwin.brosset=
te@6wind.com" target=3D"_blank">edwin.brossette@6wind.com</a>&gt;;
<a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</a><br>
<b>Subject:</b> RE: net/mlx5: wrong Rx/Tx descriptor limits when DevX is of=
f</span><u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Hello Igor and Slava,=
</span><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Can you please check =
out this issue?</span><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">=C2=A0</span><u></u><=
u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Regards,</span><u></u=
><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Asaf Penso</span><u><=
/u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">=C2=A0</span><u></u><=
u></u></p>
<div style=3D"border-style:none none none solid;border-width:medium medium =
medium 1.5pt;padding:0cm 0cm 0cm 4pt;border-color:currentcolor currentcolor=
 currentcolor blue">
<div>
<div style=3D"border-style:solid none none;border-width:1pt medium medium;p=
adding:3pt 0cm 0cm;border-color:currentcolor">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;C=
alibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11pt;font=
-family:&quot;Calibri&quot;,sans-serif"> Edwin Brossette &lt;<a href=3D"mai=
lto:edwin.brossette@6wind.com" target=3D"_blank">edwin.brossette@6wind.com<=
/a>&gt;
<br>
<b>Sent:</b> Friday, 20 December 2024 19:06<br>
<b>To:</b> <a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</=
a><br>
<b>Cc:</b> Laurent Hardy &lt;<a href=3D"mailto:laurent.hardy@6wind.com" tar=
get=3D"_blank">laurent.hardy@6wind.com</a>&gt;; Olivier Matz &lt;<a href=3D=
"mailto:olivier.matz@6wind.com" target=3D"_blank">olivier.matz@6wind.com</a=
>&gt;; Didier Pallard &lt;<a href=3D"mailto:didier.pallard@6wind.com" targe=
t=3D"_blank">didier.pallard@6wind.com</a>&gt;;
 Jean-Mickael Guerin &lt;<a href=3D"mailto:jmg@6wind.com" target=3D"_blank"=
>jmg@6wind.com</a>&gt;<br>
<b>Subject:</b> net/mlx5: wrong Rx/Tx descriptor limits when DevX is off</s=
pan><u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt">Hello,<br>
<br>
I have run into a regression following an update to stable dpdk-24.11 with =
a number of my Mellanox cx4/5/6 nics. This regression occurs with all nics =
in my lab which have DevX disabled: using mstconfig utility, I can see the =
flag UCTX_EN is not set.<br>
<br>
Mainly, the issue is that the ports cannot be started, with the following e=
rror logs in the journal:<u></u><u></u></p>
<div style=3D"margin-left:30pt">
<p class=3D"MsoNormal">Set nb_rxd=3D1 (asked=3D512) for port=3D0<br>
Set nb_txd=3D1 (asked=3D512) for port=3D0<br>
starting port 0<br>
Initializing port 0 [7c:fe:90:65:e6:54]<br>
port 0: ntfp1 (mlx5_pci)<br>
nb_rxq=3D2 nb_txq=3D2<br>
rxq0=3Dc9 rxq1=3Dc25<br>
txq0=3Dc9 txq1=3Dc25<br>
port 0: rx_scatter=3D0 tx_scatter=3D0 max_rx_frame=3D1526<br>
mlx5_net: port 0 number of descriptors requested for Tx queue 0 must be hig=
her than MLX5_TX_COMP_THRESH, using 33 instead of 1<br>
mlx5_net: port 0 increased number of descriptors in Tx queue 0 to the next =
power of two (64)<br>
mlx5_net: port 0 number of descriptors requested for Tx queue 1 must be hig=
her than MLX5_TX_COMP_THRESH, using 33 instead of 1<br>
mlx5_net: port 0 increased number of descriptors in Tx queue 1 to the next =
power of two (64)<br>
mlx5_net: Port 0 Rx queue 0 CQ creation failure.<br>
mlx5_net: port 0 Rx queue allocation failed: Cannot allocate memory<br>
rte_eth_dev_start(port 0) failed, error=3D-12<br>
Failed to start port 0, set link down<br>
Failed to start port 0<u></u><u></u></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><br>
Looking more precisely into the problem, it appears that the number of Rx a=
nd Tx descriptors configured for my queues is 1. This happens because mlx5_=
dev_infos_get() return a limit of 1 for both Rx and Tx, which is unexpected=
. I identified this patch to be
 responsible for the regression:<br>
<br>
4c3d7961d9002: net/mlx5: fix reported Rx/Tx descriptor limits<br>
<a href=3D"https://git.dpdk.org/dpdk/commit/?id=3D4c3d7961d9002bb715a8ee76b=
cf464d633316d4c" target=3D"_blank">https://git.dpdk.org/dpdk/commit/?id=3D4=
c3d7961d9002bb715a8ee76bcf464d633316d4c</a><br>
<br>
After doing some debugging, I noticed that hca_attr.log_max_wq_sz is never =
configured. This should be done in mlx5_devx_cmd_query_hca_attr() which is =
called in this bit of code:<br>
<br>
<a href=3D"https://git.dpdk.org/dpdk/tree/drivers/common/mlx5/mlx5_common.c=
#n681" target=3D"_blank">https://git.dpdk.org/dpdk/tree/drivers/common/mlx5=
/mlx5_common.c#n681</a><u></u><u></u></p>
<div style=3D"margin-left:30pt">
<p class=3D"MsoNormal">/*<br>
* When CTX is created by Verbs, query HCA attribute is unsupported.<br>
* When CTX is imported, we cannot know if it is created by DevX or<br>
* Verbs. So, we use query HCA attribute function to check it.<br>
*/<br>
if (cdev-&gt;config.devx || cdev-&gt;config.device_fd !=3D MLX5_ARG_UNSET) =
{<u></u><u></u></p>
</div>
<div style=3D"margin-left:30pt">
<div style=3D"margin-left:30pt">
<p class=3D"MsoNormal">/* Query HCA attributes. */<br>
ret =3D mlx5_devx_cmd_query_hca_attr(cdev-&gt;ctx, &amp;cdev-&gt;config.hca=
_attr);<br>
if (ret) {<u></u><u></u></p>
</div>
</div>
<div style=3D"margin-left:30pt">
<div style=3D"margin-left:30pt">
<div style=3D"margin-left:30pt">
<p class=3D"MsoNormal">DRV_LOG(ERR, &quot;Unable to read HCA caps in DevX m=
ode.&quot;);<br>
rte_errno =3D ENOTSUP;<br>
goto error;<u></u><u></u></p>
</div>
</div>
</div>
<div style=3D"margin-left:30pt">
<div style=3D"margin-left:30pt">
<p class=3D"MsoNormal">}<br>
cdev-&gt;config.devx =3D 1;<u></u><u></u></p>
</div>
</div>
<div style=3D"margin-left:30pt">
<p class=3D"MsoNormal">}<br>
DRV_LOG(DEBUG, &quot;DevX is %ssupported.&quot;, cdev-&gt;config.devx ? &qu=
ot;&quot; : &quot;NOT &quot;);<u></u><u></u></p>
</div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div>
<p class=3D"MsoNormal">I deduced that following the above patch, the correc=
t value for maximum Rx and Tx descriptors will only be set if DevX is enabl=
ed (see the if condition on cdev-&gt;config.devx). If
 it is disabled, then maximum Rx and Tx descriptors will be 1, which will m=
ake the ports fail to start. Perhaps we should keep the previous default va=
lue (65535) if config.devx =3D=3D 0 (DevX off)? This could be done like thi=
s, for example:<br>
<br>
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.=
c<br>
index 7708a0b80883..8ba3eb4a32de 100644<br>
--- a/drivers/net/mlx5/mlx5_ethdev.c<br>
+++ b/drivers/net/mlx5/mlx5_ethdev.c<br>
@@ -359,10 +359,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rt=
e_eth_dev_info *info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;flow_type_rss_offloads =3D ~MLX5_RSS_H=
F_MASK;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mlx5_set_default_params(dev, info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mlx5_set_txlimit_params(dev, info);<br>
- =C2=A0 =C2=A0 =C2=A0 info-&gt;rx_desc_lim.nb_max =3D<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 &lt;&lt; priv-&gt;sh-&=
gt;cdev-&gt;config.hca_attr.log_max_wq_sz;<br>
- =C2=A0 =C2=A0 =C2=A0 info-&gt;tx_desc_lim.nb_max =3D<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 &lt;&lt; priv-&gt;sh-&=
gt;cdev-&gt;config.hca_attr.log_max_wq_sz;<br>
+ =C2=A0 =C2=A0 =C2=A0 if (priv-&gt;sh-&gt;cdev-&gt;config.devx) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;rx_desc_lim.nb_=
max =3D<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1 &lt;&lt; priv-&gt;sh-&gt;cdev-&gt;config.hca_attr.log_max_wq_sz;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;tx_desc_lim.nb_=
max =3D<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1 &lt;&lt; priv-&gt;sh-&gt;cdev-&gt;config.hca_attr.log_max_wq_sz;<br>
+ =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (priv-&gt;sh-&gt;cdev-&gt;config.hca_attr.me=
m_rq_rmp &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priv-&gt;obj_ops.rxq_obj_new =3D=
=3D devx_obj_ops.rxq_obj_new)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;dev_capa |=
=3D RTE_ETH_DEV_CAPA_RXQ_SHARE;<br>
<br>
Thanks in advance for your help.<br>
<br>
Regards,<br>
Edwin Brossette.<u></u><u></u></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt">=C2=A0<u></u><u></u></p=
>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
</div>
</div>
</div>

</div></blockquote></div>

--000000000000d6850706308b134c--
