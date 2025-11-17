Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50996CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 09:28:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 785E14065B;
	Mon, 17 Nov 2025 10:28:56 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 007A940650
 for <dev@dpdk.org>; Mon, 17 Nov 2025 10:28:54 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8b2f2c5ec36so56444885a.1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 01:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763371734; x=1763976534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uH46JrIvFylEhlnK8/1/VkHb4YaYeJh/nlLOhHDFSng=;
 b=CkmzIrt1H0xAheGzotOD6HKGP8b8TxhYtSWBi5CN4FShYl3r6OT4ubNJPJPojtcdtw
 atlAFsR4aGgZ+8qxvpG5iIpCIkzzggeXuYO/y9NKydydvDVQ6Fy9IRNXaMHdfuVzDFDe
 rc9w97of3xgGOz8wJEza7AnRZn+0pZbPSekEGyMXbltX+vpaqbPMeo6b8mWP1nybWEar
 nG2UnLHw+Kf82UJ6EPcP0TCA/+yPjHYW9b+5XZZxpeeNv13j+laJY/HJQyCOIiUqUiyH
 /FaQD9yqIgiyphJWvL28TcozhDxY5YaF6uqpULCbhxemmAyiBF/fI+bV0ja7r7MQpbhO
 5XXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFBCWehOssoFo7az6+DhzQIQQ0RfYEPSLtSFP3Yn3xf2Oj+nFKFwyPqIvsY/rgSIwWxdE=@dpdk.org
X-Gm-Message-State: AOJu0YxojOWZ4Hf+6GoHKeZjXz6NM3Yj8XdWxURM7rRNH2XJQ5uS2yv6
 Mw4oQ7siM6KQPHDCKhciJXy06M5pSDTWJwoU0qolnNTNgKw7x7S0aSj1V2xy4F7gbuP3+WmpTB/
 LvQFAfWhOyon2EosXpuq0jsSEf0jmKOM=
X-Gm-Gg: ASbGnct6aliT3S1+r/4YtAsWmli8ou20L5DYgK/T4GFbgEX6Rt+iEn/eD8RJBtR+xJT
 tFjVJkDYWecvXutQ+btGTM1a149DQQfoto1B0UkBQAcJSnCOCDXQbVusU7ENaqA98zrmb9ysieA
 y4/AOdWg6V0+5c7WR2Mm2rCe/xG8KkVe0qHuy66cn+Hs5I29s6C/XVvGjET8piQhULU97tPwv/e
 QQiddNHmr9UltTiN/l10JfMUIOG1sWRn4PhvImZgVAY1Co9RNjpMgOjaoc=
X-Google-Smtp-Source: AGHT+IGzcFxqxTLR9ACl9GJH9ZiL/oXaG2zTacv3u7J6rMXrWOhCmZf+v9b6cRTvc2O4CWI6OQPe/B+MASixncouofI=
X-Received: by 2002:a05:620a:40d1:b0:8b1:f2cd:76ad with SMTP id
 af79cd13be357-8b2c31e50ccmr1291712385a.89.1763371734297; Mon, 17 Nov 2025
 01:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251112091049.2669481-1-david.marchand@redhat.com>
 <20251112091049.2669481-2-david.marchand@redhat.com>
 <CAHHRULXYKbmYT7tY4Qino9dhZccZwBoQYJusjDNJkOi6e62NHw@mail.gmail.com>
 <CAJFAV8yqgU43xHTn_-Wo0FeSjbBHoPHP7yCbz=ju63np9PxO6A@mail.gmail.com>
In-Reply-To: <CAJFAV8yqgU43xHTn_-Wo0FeSjbBHoPHP7yCbz=ju63np9PxO6A@mail.gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 17 Nov 2025 10:28:43 +0100
X-Gm-Features: AWmQ_bkJyLbWxch4eB-7PSuQ-BQP4GiNdEWBlJ--ZaAwyx9LMdkb9a_cKOO0OVA
Message-ID: <CAHHRULUDZG-244Dy4afLM-k_jz130SVTb79jebDd=zzAOVTv_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] crypto/dpaa2_sec: remove crypto device in bus
 device
To: David Marchand <david.marchand@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 hemant.agrawal@nxp.com, 
 Sachin Saxena <sachin.saxena@nxp.com>, Gagandeep Singh <g.singh@nxp.com>, 
 Thomas Monjalon <thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi David,

Le lun. 17 nov. 2025 =C3=A0 09:59, David Marchand
<david.marchand@redhat.com> a =C3=A9crit :
>
> Hello,
>
> On Mon, 17 Nov 2025 at 09:36, Maxime Leroy <maxime@leroys.fr> wrote:
> > > @@ -4526,10 +4524,14 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_dr=
iver *dpaa2_drv __rte_unused,
> > >  static int
> > >  cryptodev_dpaa2_sec_remove(struct rte_dpaa2_device *dpaa2_dev)
> > >  {
> > > +       char cryptodev_name[RTE_CRYPTODEV_NAME_MAX_LEN];
> > >         struct rte_cryptodev *cryptodev;
> > >         int ret;
> > >
> > > -       cryptodev =3D dpaa2_dev->cryptodev;
> > > +       snprintf(cryptodev_name, sizeof(cryptodev_name), "dpsec-%d",
> > > +                       dpaa2_dev->object_id);
> > > +
> > > +       cryptodev =3D rte_cryptodev_pmd_get_named_dev(cryptodev_name)=
;
> > >         if (cryptodev =3D=3D NULL)
> > >                 return -ENODEV;
> > >
> > > --
> > > 2.51.0
> > >
> > Should we add a function to generate the cryptodev name instead of
> > duplicating the code, similar to how it=E2=80=99s done for PCI devices =
(i.e.,
> > rte_pci_device_name)?
>
> I am not sure I get the parallel..
> rte_pci_device_name is a bus level name, I don't see how we could
> define a fslmc bus level helper that would help here.
> Ah, you mean adding a helper internal to this cryptodev driver?
>
Yes. It's a minor improvement.

Else everything seems good on this serie.

Regards,

Maxime Leroy
