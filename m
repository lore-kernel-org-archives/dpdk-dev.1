Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9152CD6E7D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 15:11:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C827840A79;
	Thu, 13 Nov 2025 16:11:25 +0100 (CET)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2F35E40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 16:11:24 +0100 (CET)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8b272a4ca78so132278085a.1
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763046683; x=1763651483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8lB8u5Rfjm8UML7hLRplCn8AdXPEPUoOIzGUfpHmucc=;
 b=LRdVx04O3HVcgz4b9lx39bNHhL1W4qhPAnzKyy6aY8vCowPh95OQKS+XxI9ceC2+3F
 j2ItRmpi5vmPiEhR5QuYS+eLtD/BU+f1cX0AHNGsG3rtDSYu9oceOETbxd5cHR5vu6AH
 RH5fpoh0NknV10hVkrWLllNqTpLxHorAXtIgiS3KhB85arcpXtdL/suYc5rPfwxAsCOL
 5lOftnGED5itMXBuwH2K+yog2hMOcguIHrC59QS9BSWc9N7Tk09l6Beu+CmdUyc9Smip
 GvRu7YRGCUp/2KI/o0stlm0qtAtkns/c47VIac2LKD5YZxDMXvB9orDyuNIoA8oVrmSI
 L0bA==
X-Gm-Message-State: AOJu0YyQt/DHRju0uKdv2wlRkv3auSYTN7fdJuzS6QuCZAQMoL5PybNe
 UQi7ZaeYtFRf9ftHhEw0f1F65rSACBvu4Liu+IQmlqP4NgGlfUH0G4e/Ut5MQ3d6xUikcjzqRo+
 cVkpzYshs3QXVv07GH4TlLrvjAS8C8Mw=
X-Gm-Gg: ASbGncubwKP64XFEF5U9EDltLVOKrhu15evMlmR3ks6EaCg4hkuObSj2SuLzn3Mqu4V
 gWcAyQHKqM2HgjYUDkRgHLMs0vG1NAWTA/BxKJ5iFkGXxHPhNxFZ0xs/dqfuo044yAX1eJSA0RF
 fFa/BTs8XF+/yCW3O3iOt+kEPR7154By7L4/oYVP96YAxOpLDhAZOVRiFc2OlLtyEEwAkYb0jME
 ZSfFNsFlAXh7TdKv8q9ZxZSXomjh6dzMq9E4JNw3P0WR3dycLaqJf7tMg==
X-Google-Smtp-Source: AGHT+IGgaDMUQj8XYvsSJrHFGTLEcJ4dlwpfWFl7hWGdS+MUjC8B46hGEieGwGh6Y/jua7RPOyuE8lgs0Nhj8B+BMPA=
X-Received: by 2002:a05:620a:29d2:b0:8a1:b435:984a with SMTP id
 af79cd13be357-8b29b7df70emr791753385a.69.1763046683471; Thu, 13 Nov 2025
 07:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20251113095917.1973514-1-hemant.agrawal@nxp.com>
 <20251113114355.2027438-1-hemant.agrawal@nxp.com>
In-Reply-To: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Thu, 13 Nov 2025 16:11:12 +0100
X-Gm-Features: AWmQ_bnMvF-AoQpVUmTr3zWhDDagw6CEeLsJlB0sp710vs3htsvhQE2I9pmfRz8
Message-ID: <CAHHRULUuCi6cm=9QEW_m=ZMKJQ2bGPGH50f3YzjeL2p3KQ1Thw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] net/dpaa2: fix duplicate calling of dpaa2 dev close
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com, 
 sachin.saxena@nxp.com, stable@dpdk.org
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

Hi Hemant,

Le jeu. 13 nov. 2025 =C3=A0 12:44, Hemant Agrawal <hemant.agrawal@nxp.com> =
a =C3=A9crit :
>
> When rte_eth_dev_close() is called, it performs the following actions:
>
> Calls dev->dev_ops->dev_close(), which in this case is dpaa2_dev_close().
> Then calls rte_eth_dev_release_port(), which releases all device data
> and sets dev->data to NULL.
>
> Later, when rte_dev_remove() is called, the FSLMC bus invokes
> dev->remove() =E2=80=94 that is, rte_dpaa2_remove().
> However, rte_dpaa2_remove() calls dpaa2_dev_close() again. Since dev->dat=
a
> was already set to NULL by the previous call, this second invocation
> causes a crash.
>
> Fixes: 5964d36a2904 ("net/dpaa2: release port upon close")
> Cc: sachin.saxena@nxp.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---
>  drivers/net/dpaa2/dpaa2_ethdev.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_e=
thdev.c
> index 7da32ce856..fc63cf4f09 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -3347,14 +3347,19 @@ static int
>  rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
>  {
>         struct rte_eth_dev *eth_dev;
> -       int ret;
> +       int ret =3D 0;
> +
> +       eth_dev =3D rte_eth_dev_allocated(dpaa2_dev->device.name);
> +       if (eth_dev) {
> +               dpaa2_dev_close(eth_dev);
> +               ret =3D rte_eth_dev_release_port(eth_dev);
> +       }

dpaa2_dev_close() returns a status code, but it isn=E2=80=99t being checked=
 here.

For comparison, in rte_eth_dev_pci_generic_remove(), if dev_uninit
(i.e. the device close callback) fails, rte_eth_dev_release_port() is
not called.
How should the dpaa2 driver handle this kind of error case?

By the way, if it makes sense for you, feel free to add a Tested-by
tag from me, since I=E2=80=99ve validated the series on my side with Grout.

Regards,

Maxime Leroy
