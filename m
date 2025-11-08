Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B884FCCFA18
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 15:35:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C02A402D6;
	Sat,  8 Nov 2025 16:35:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9379140281
 for <dev@dpdk.org>; Sat,  8 Nov 2025 16:35:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762616123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLm9yj/3avHTdgbJkewvPjtCUs+5Lb1DvGYPODmPmqs=;
 b=gCI4wxhTaRZfBa5BynSnFQhQl8FPChcEIoC6IyNFafdoC8xiTb8AP5o8IEyrbCJWMrsp8e
 t8jUUqL0GTrz6Pr/bWFZqPb+Py375ZfCpEHXnTia+dMFA3eZGt/UdGdwOeGz0Tn4ZDe9SJ
 dYW0SVvVm4JCPLVPN3q89KwH1UC4grc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-ngeeYUc2OaKRziVz0fYQsw-1; Sat, 08 Nov 2025 10:35:21 -0500
X-MC-Unique: ngeeYUc2OaKRziVz0fYQsw-1
X-Mimecast-MFC-AGG-ID: ngeeYUc2OaKRziVz0fYQsw_1762616120
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-378dd2050b9so18199921fa.2
 for <dev@dpdk.org>; Sat, 08 Nov 2025 07:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762616120; x=1763220920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLm9yj/3avHTdgbJkewvPjtCUs+5Lb1DvGYPODmPmqs=;
 b=p3ie0uIVeQL7gri2pI9GNvBRRvsCJVqQoP1wzh46ARZI4rBynuUwpxpae0Mmj3K5fu
 wtqJhXXFTbFLL0I8qu8tHJGQGTK22N2XiY1CQRt0RLtX1rf0hxP9uSQANJxDAd6Oo/RA
 /eH/bXWiNZHJPp4SyseKG/QO6GSyEVYNT1/Ebv6+A42+KcmvSFIT5cE8QklJzuUyVE4m
 Gxe6uzD/aRVSfYwWfRihou/c7U+prIW/okCy8MGEJXn/6Ld8EsUO63ZgflV1kiAEAqUZ
 no8ryPu4uoPVt10OUlEdf7CWaRuiX/dVnDFFRtQk0ftY658cGcUKNzxsasIrBcqtZM6u
 SEoA==
X-Gm-Message-State: AOJu0YyvQBVRxQhuDp+/6bGG6ybUUUS/7p+qrc4tsgVVy9nZGvM4jtok
 GG9HZkYx8ip/rAISFpJq3y+sjSECRLvTDT9/w0ebEqTCOkYWzcYIRWqpOT2ZffL0hg2HpHM4gdM
 A4jwTZWG6ksoy7ey796w3NHlcBDmxK9SKQjuRP/J4rCZfma0v1CydDcJedGktPHTwd1/lXZ8QCJ
 mL3QSdoreqn42jdfpDDS4=
X-Gm-Gg: ASbGncvkf93xO+iFK91dwESrrsFh9qcGu6vtEDRmw/2pMQkjewBEnmcUO7LZGivfB3t
 BNsywJjadTIq6M5Je1F99ZQq7f0V0PqiOo+t+Mh7J/GFvRhx0LdX7urTj8gu8cL8ck6omECh778
 0R1e1PozmYBITuOYNB8jq/bExlK8SFkgUns/tVx6XuQi2O2orNcDDl809lbg==
X-Received: by 2002:a05:6512:128a:b0:594:49ed:3cf1 with SMTP id
 2adb3069b0e04-5945f15da00mr732008e87.10.1762616120103; 
 Sat, 08 Nov 2025 07:35:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFklu01q8slJbjdDpzA6IvVGb0nzB2CixBH7FVROnenDG6oUsLyWW1KslT4Y3aFGsd23lIKIyHnMpzB0NaYvyM=
X-Received: by 2002:a05:6512:128a:b0:594:49ed:3cf1 with SMTP id
 2adb3069b0e04-5945f15da00mr731998e87.10.1762616119692; Sat, 08 Nov 2025
 07:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
 <CAJFAV8y4KCDG94OswHaYuk-0PaxdHKzO1_yG+rVVYTcBCJb1JQ@mail.gmail.com>
In-Reply-To: <CAJFAV8y4KCDG94OswHaYuk-0PaxdHKzO1_yG+rVVYTcBCJb1JQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 8 Nov 2025 16:35:08 +0100
X-Gm-Features: AWmQ_bmGdIPY3Igxe0wIqBKGGGwQY4X884_Ro31b0YDryF9FMuwJDccShZnJSdM
Message-ID: <CAJFAV8wbS=+YVF_s9Y0H2fOTCtS8Ce1xa-3UR=fhQMoF5p=U4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] net/dpaa2: fix duplicate calling of dpaa2 dev close
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, sachin.saxena@nxp.com, 
 stable@dpdk.org, maxime@leroys.fr
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hin0khmxfrcbaxlKIuNb_TZrCBjp54WjLOdrXlM4v-U_1762616120
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 7 Nov 2025 at 09:32, David Marchand <david.marchand@redhat.com> wrote:
> > diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> > index 7da32ce856..f3db7982a4 100644
> > --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> > +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> > @@ -3347,14 +3347,17 @@ static int
> >  rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
> >  {
> >         struct rte_eth_dev *eth_dev;
> > -       int ret;
> > +       int ret = 0;
> >
> >         eth_dev = dpaa2_dev->eth_dev;
>
> Having a back reference of the "class" object in a "device" object
> seems wrong to me (and there is a dev_priv->eth_dev too...).
> It breaks the separation that was introduced with rte_device years ago.

I went and had a try:
https://patchwork.dpdk.org/project/dpdk/list/?series=36627

No promise it works, but it is cleaner this way.


-- 
David Marchand

