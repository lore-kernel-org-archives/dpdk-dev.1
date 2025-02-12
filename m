Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC58C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 14:34:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB10F4113C;
	Wed, 12 Feb 2025 15:34:44 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id D8EC64111B
 for <dev@dpdk.org>; Wed, 12 Feb 2025 15:34:42 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21f49bd087cso94551405ad.0
 for <dev@dpdk.org>; Wed, 12 Feb 2025 06:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1739370882; x=1739975682; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gzl+L6XBVkxxkvcvLvt1vbL9BAgKodPAudFzvHvYAFg=;
 b=Ltrzi4Pp8iK/R6CAGZeK1f/pQ6Szp/xFBgjfo+crcfMr1jeE1NBIGzi4tjp0EqzvZ1
 1Uh7bxVFIP6c7QbbxG9cenQe7LXFM2i0yfVvkNJPb3P6BmjIw5SR+zw91i0u4+/CP4gm
 db13N83SsWtve4MwcswYm8NFaTdcFO7G60m+0EcWOR7zwh6Me9DZomK8BVDFLYDcahxo
 sAus9qpsM9NWsOxQZkM7AzGRL6ToY4j43u1jVdpwD+BWPKgtA1eVp4H6yM+rF464vlsy
 TUclwucdFFr0WRY6zNnC1vFoY4N44oIfukm53b/3aus+pfl3vcx5QD49oWBq/XxBKK8A
 Y1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739370882; x=1739975682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gzl+L6XBVkxxkvcvLvt1vbL9BAgKodPAudFzvHvYAFg=;
 b=L+EgPJ4NkPDfzQ2fL4yafkbqhZzzthAjtCtJLhBMqnOLcZgFG5TQ1aBRHwVSnJPUAN
 M6UTzeN1Wb4FVCVtdo6mwNV0gwGNcVbRxTJkAERySiFuPPvr//cJZKRXp8KzZ7DUTCV5
 YViwFClBe3GFBOsSbQQ+1/zggJBudDEuuRG+uKvFkN3Fh2p8E3dy4Udd7xGXjbfbpN7D
 o7wExdMaJGn6Q6DCmYhY0Ao1PPyx5d7mZzWO62LMmDjdqvijv5XgbUUiVpTM+DR5MAy9
 OCuz/0gXCc8ES+/xtaszFRqdK2fQscAAhBrlU/pyFBjFt+mpLyZPpa4DtjMbnppqZM/h
 3F8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTh/gXQlz0LUm8lgUGrl9LYqN8G59wOvZpCbtaJZh6VLCAV8ds59ZTUgxb7nOcMkmEDyY=@dpdk.org
X-Gm-Message-State: AOJu0YxF41euE47G7+wHwFxnZAuIoJ8Fdze7baUKgb+L0u52YexVne1f
 30pks6t79PbePsSJ4KR+8o/U8+jN8xuHZCZmLlqPzX9GeVPDamSKs+vRIqGelmGMd3m9CK5HmUZ
 8mDdTsrcISDqACLAVhvIac1nIwZ8tY4Jy5fEwkA==
X-Gm-Gg: ASbGncv455PmUg8pSmwtAX1JW4S8yusgxie5/Vggp8a3XITzsvMmNLyWNoW0YTNOi7L
 11gZzBHzB5okq+nCXVmNMYuxNzv9e5N9xIIR48cEMnnufAx7NPsnFKwNWaJthXFlsR21gl0U=
X-Google-Smtp-Source: AGHT+IGY0wYqvaZSTpBo4zD7C/d5dMeYwZDVpYjlLME3tvK+Mvk6W18XdWS0BCDGArou7rp3SE6gbiEhD9j8xUT/eL0=
X-Received: by 2002:a17:902:db04:b0:216:7ee9:220b with SMTP id
 d9443c01a7336-220bbb06dabmr52962195ad.22.1739370880934; Wed, 12 Feb 2025
 06:34:40 -0800 (PST)
MIME-Version: 1.0
References: <CANDF9xANRqeTnkvAk61y=2TCd2fsWDQQ4YoTFdpL-RW8ksDDGQ@mail.gmail.com>
 <MN0PR12MB6053E6AC8E0FAA9373205EACCD012@MN0PR12MB6053.namprd12.prod.outlook.com>
 <MN6PR12MB8567C39321AD9C6B21B4AB49DF022@MN6PR12MB8567.namprd12.prod.outlook.com>
In-Reply-To: <MN6PR12MB8567C39321AD9C6B21B4AB49DF022@MN6PR12MB8567.namprd12.prod.outlook.com>
From: Edwin Brossette <edwin.brossette@6wind.com>
Date: Wed, 12 Feb 2025 15:34:29 +0100
X-Gm-Features: AWEUYZnR6_ZCSUcOO2vUmQ0dvd6eK4KwxHdULVyXFxeLH2pkffyTcCnOetKBFwE
Message-ID: <CANDF9xDbByceRnf=VCZQ12kJq+jh5_3_mV-=f4tP5HZ-Zej7nw@mail.gmail.com>
Subject: Re: net/mlx5: wrong Rx/Tx descriptor limits when DevX is off
To: Slava Ovsiienko <viacheslavo@nvidia.com>
Cc: Asaf Penso <asafp@nvidia.com>, "igootorov@gmail.com" <igootorov@gmail.com>,
 Laurent Hardy <laurent.hardy@6wind.com>, Olivier Matz <olivier.matz@6wind.com>,
 Didier Pallard <didier.pallard@6wind.com>, Jean-Mickael Guerin <jmg@6wind.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000007dc1f0062df2d756"
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

--0000000000007dc1f0062df2d756
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Sorry for bothering you again.
May I inquire if this issue is still being worked on ?
If so, when can I expect to see a fix ?

Best regards,
Edwin Brossette

On Mon, Dec 23, 2024 at 2:09=E2=80=AFPM Slava Ovsiienko <viacheslavo@nvidia=
.com>
wrote:

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

--0000000000007dc1f0062df2d756
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>Sorry for bothering y=
ou again.</div><div>May I inquire if this issue is still being worked on ? =
<br></div><div>If so, when can I expect to see a fix ?<br></div><div><br></=
div><div>Best regards,</div><div>Edwin Brossette<br></div></div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Mon, Dec 23, 2024 at 2:09=E2=80=AFPM Slava Ovsiienko &lt;<a href=3D=
"mailto:viacheslavo@nvidia.com">viacheslavo@nvidia.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"msg-405=
6859570401573096">





<div style=3D"overflow-wrap: break-word;" lang=3D"EN-US">
<div class=3D"m_-4056859570401573096WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Confirm, it=E2=80=99s=
 a bug, IIUC was introduced by reporting function update.<br>
AFAIK, we do not test with non-DevX environment anymore, so missed this.<u>=
</u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Fix should be provide=
d.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">With best regards,<u>=
</u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Slava<u></u><u></u></=
span></p>
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
t=3D"_blank">didier.pallard@6wind.com</a>&gt;; Jean-Mickael Guerin &lt;<a h=
ref=3D"mailto:jmg@6wind.com" target=3D"_blank">jmg@6wind.com</a>&gt;; Edwin=
 Brossette &lt;<a href=3D"mailto:edwin.brossette@6wind.com" target=3D"_blan=
k">edwin.brossette@6wind.com</a>&gt;; <a href=3D"mailto:dev@dpdk.org" targe=
t=3D"_blank">dev@dpdk.org</a><br>
<b>Subject:</b> RE: net/mlx5: wrong Rx/Tx descriptor limits when DevX is of=
f<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Hello Igor and Slava,=
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Can you please check =
out this issue?<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Regards,<u></u><u></u=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Asaf Penso<u></u><u><=
/u></span></p>
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
<b>Subject:</b> net/mlx5: wrong Rx/Tx descriptor limits when DevX is off<u>=
</u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
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
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">I deduced that following the above patch, the correc=
t value for maximum Rx and Tx descriptors will only be set if DevX is enabl=
ed (see the if condition on cdev-&gt;config.devx). If it is disabled, then =
maximum Rx and Tx descriptors will be
 1, which will make the ports fail to start. Perhaps we should keep the pre=
vious default value (65535) if config.devx =3D=3D 0 (DevX off)? This could =
be done like this, for example:<br>
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
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><u></u>=C2=A0<u></u></p=
>
</div>
</div>
</div>
</div>
</div>
</div>
</div>

</div></blockquote></div>

--0000000000007dc1f0062df2d756--
