Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127EACEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 08:36:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E105402D0;
	Mon, 17 Nov 2025 09:36:12 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id C5E5A4027D
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:36:10 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8b2dcdde698so231388285a.3
 for <dev@dpdk.org>; Mon, 17 Nov 2025 00:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763368570; x=1763973370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rtycn+Rf4ujXCvkHV1It4e6hlyYyXT+8EJHwmaPHK1k=;
 b=psMTfLmxTF+EJMjGkp7h3eF93ul0zmWfJ1Ew2pPlm03OI7pwQQcfaFmZkqWN1HEwZE
 ZLofC7ISz036YZqhHMmHCCBK23CZQPNjZ98SBbtIPT5jFf8H8bad2Wi6M0qcbBo4tOR/
 HaDEUTTIAj6qfnMyL2TqYJoTbPSzTrDeq8LhRKMfsKmgh1nedqGFfP8qho7rrQhgu856
 UsEFUIH+KqIqNKrLp+bUxQF4yj+EzHqZO2F0tLmIMHDnt4bfih2krzoFy5UDO3+wZpCN
 QGlXi195ByAlZV8buQJXe+B2neiUKec+MbxMlcoz3Wd+EH54B+d3O5HyU/BIyCjdStRH
 AJxA==
X-Gm-Message-State: AOJu0YxORbgH5lXVT8y1A1WAURUxUJu4LEwMcEYqaSuxiTQFuoQ4TgVZ
 7cnAovtYzKxlrvCL2+KipvSC56wHH5q8GDnIVoAfgZma5WNrWhJdUaZaBipD9VW4esC60bZkOt0
 vEv2QSe9/MRFveuM1JS+irKfces9tY+xk6RHYP68=
X-Gm-Gg: ASbGncuiW+Bnk3KikFUszDy1QW7dPmrZ3tett7SzU7cP6ra3tjtjD1tL0WcgJC/Mofk
 7xeIWQmG7AEOJSvwUGcfV6Vsw6egsXXxemO7o4SOIwhHW7ic++tvOfuraj2nwhLijFgZ0vG8UZZ
 MvTw/Wi8EJkrhYt2e0DwPIzo+sl883N4nfV6kAjMI/e4FJUPPxdDPtlOjTyCCqbmRCh0rbTEXsR
 yFHfzsNy8OvApT9nzM3vHcF+c3EnSaCmeCeOY0OyPaWfuhEIgmIg2SuuFAbBQ4qO+Jj
X-Google-Smtp-Source: AGHT+IEaQSwyG0HeLwfImUOMerpdemSopl3gOOu81InXglhmmdJXEsBtLPZ4tucb5tQb/dypy18rxAPOKKSld9OPkAk=
X-Received: by 2002:a05:620a:294f:b0:8a2:45ba:1b5e with SMTP id
 af79cd13be357-8b2c3161059mr1452752285a.28.1763368570030; Mon, 17 Nov 2025
 00:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251112091049.2669481-1-david.marchand@redhat.com>
 <20251112091049.2669481-2-david.marchand@redhat.com>
In-Reply-To: <20251112091049.2669481-2-david.marchand@redhat.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 17 Nov 2025 09:35:59 +0100
X-Gm-Features: AWmQ_bnSX62TNT9itYIeibQzl5SQKeNy_dqSst6ZxN88fomA0nGdjTJchCFF3xA
Message-ID: <CAHHRULXYKbmYT7tY4Qino9dhZccZwBoQYJusjDNJkOi6e62NHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] crypto/dpaa2_sec: remove crypto device in bus
 device
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, 
 Sachin Saxena <sachin.saxena@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
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

Le mer. 12 nov. 2025 =C3=A0 10:11, David Marchand
<david.marchand@redhat.com> a =C3=A9crit :
>
> Calling rte_cryptodev_pmd_get_named_dev() is enough to retrieve the
> crypto device object.
>
> This leaves no user of the cryptodev field in the fslmc device object.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/bus/fslmc/bus_fslmc_driver.h        | 1 -
>  drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 8 +++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus=
_fslmc_driver.h
> index b6a6238a01..45c7a519f9 100644
> --- a/drivers/bus/fslmc/bus_fslmc_driver.h
> +++ b/drivers/bus/fslmc/bus_fslmc_driver.h
> @@ -99,7 +99,6 @@ struct rte_dpaa2_device {
>         struct rte_device device;           /**< Inherit core device */
>         union {
>                 struct rte_eth_dev *eth_dev;        /**< ethernet device =
*/
> -               struct rte_cryptodev *cryptodev;    /**< Crypto Device */
>                 struct rte_dma_dev *dmadev;          /**< DMA Device */
>                 struct rte_rawdev *rawdev;          /**< Raw Device */
>         };
> diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto=
/dpaa2_sec/dpaa2_sec_dpseci.c
> index ca10d88da7..698548e6ea 100644
> --- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
> +++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
> @@ -4503,8 +4503,6 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver *=
dpaa2_drv __rte_unused,
>                 return -ENOMEM;
>         }
>
> -       dpaa2_dev->cryptodev =3D cryptodev;
> -
>         if (dpaa2_svr_family =3D=3D SVR_LX2160A)
>                 rta_set_sec_era(RTA_SEC_ERA_10);
>         else
> @@ -4526,10 +4524,14 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver=
 *dpaa2_drv __rte_unused,
>  static int
>  cryptodev_dpaa2_sec_remove(struct rte_dpaa2_device *dpaa2_dev)
>  {
> +       char cryptodev_name[RTE_CRYPTODEV_NAME_MAX_LEN];
>         struct rte_cryptodev *cryptodev;
>         int ret;
>
> -       cryptodev =3D dpaa2_dev->cryptodev;
> +       snprintf(cryptodev_name, sizeof(cryptodev_name), "dpsec-%d",
> +                       dpaa2_dev->object_id);
> +
> +       cryptodev =3D rte_cryptodev_pmd_get_named_dev(cryptodev_name);
>         if (cryptodev =3D=3D NULL)
>                 return -ENODEV;
>
> --
> 2.51.0
>
Should we add a function to generate the cryptodev name instead of
duplicating the code, similar to how it=E2=80=99s done for PCI devices (i.e=
.,
rte_pci_device_name)?

Maxime Leroy
