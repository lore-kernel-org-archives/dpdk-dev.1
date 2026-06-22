Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68730CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 13:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2468740150;
	Mon, 22 Jun 2026 15:53:45 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 20B8940144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 15:53:43 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-519eedc30a3so32259201cf.1
 for <dev@dpdk.org>; Mon, 22 Jun 2026 06:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782136422; cv=none;
 d=google.com; s=arc-20240605;
 b=iwxfVRZ1JZetpXPIgkF6FUG3c6Ohg7j7f2siInkUXtHVtihk5Z34HU93u0Cnjjg6bi
 RY/vUdsY30GfEPy4USit0RbWZGhcengde98XWIJBE6Fa/OcMFijTY+G+17wBMeKLTo7h
 /BJa6CD2OFL6ucUuFiBpXCSvRa4Bt8fCk7LREnYpbt15mmE863LJcpHuEW9Lg04Pp4K7
 xqZa45WKsGHt6OG2vQFnUKczBu5gf3N1U6FUkdrS1CzRnBumJsrQXMopmCQR0Qq/iSqI
 CbwwpRrTiKubhyrIdbRElFrSFqtGuJ6LDLEV1DfyHD9YsqEdgkYkjEj3wbELDEFW0Jls
 A3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E+jBK+OwI50aTW27exbMvJyI/0XIxEbk8PRKFHoAAlo=;
 fh=KQW3wntIjezcUiuQ0fURL7xPSQyLRCyb8DqDprDKNLA=;
 b=BhMkYsS28v6+XtZEqd73OhLU5Vfj/cPk5PzsxB9kRsI6wN/4wAPWJj/anRIuw98ZyB
 n0d09tNY/U1f7MZZJFtNwztMFFAqbix+43WrBjNKwic5BYonzqFKBuEkYvsndx1sz4US
 6Kit9JPb/bSoohJADB3BOztj0f8+s12GiYHXQUWo1uEW/8hvH/vtrwR3AXwbs2J8Lmza
 0ZAJGbaX74CBZdJq40eGQPVZGdUSYnaMem7H0AySyEmEITNTqzPUPW/TvBuojKKgHIi2
 5WqwLg/xgTpkHhn2YnlnpeMRHHOviUNSqZ3Gt3TKu+CUh7uNia3suc2mPN65y9Lb5jKg
 NyTg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782136422; x=1782741222; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+jBK+OwI50aTW27exbMvJyI/0XIxEbk8PRKFHoAAlo=;
 b=ofDFHG6NQ7LtZK9X061imv17IrDn2vuAQJQZDAKSelnuo86ygFmVEh8Dk7w1j+kfRH
 B9vkR2S/q/GrLGtvFpofwd2G1QYMgfNWMU0YPL+iQhDxjoIGq7a4pVXiFHlJi5KQWVN8
 UAYOYyqkBOKRjbPqW5jmGFXFICA3L0aVAI+CfEemWck+t2/+Us/Tr9l8xsCazAb6fkyl
 H+etfyz3jlNcKCHKJSrTdZy0m9EJw8MU6tdw9/2CyWCgcv/C0oSVmyiPmrg9Wq98A5+X
 pDGWxX3yf/YYv52eRDX1LXj+lE9WdhwiUKg+oVBiP0p5TER2DH/MgDr9wYA6vGF8GV/I
 EeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782136422; x=1782741222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E+jBK+OwI50aTW27exbMvJyI/0XIxEbk8PRKFHoAAlo=;
 b=D8GMAg+MutpBe7I5SePatcEVlOir7pO4IdUK+aKWRyV9EhlGhrGxM9zje/G/AXaY0e
 T4XxegwpVnDdfZeZyvQTlQBTGOW8zBV+IZik0eNVJ1zx/tKPTO3DSVCbeUJYxxveAQJm
 vVS7vLn9z6MU6/nV9VgHI9BBQXSWv0wpSZV0VD1Lw1e2fVmqYIUwnrOd7n/qbGEgM784
 TF+SmomeAy1eNPNb27k64zIXVih9tl6xKp2c1XAWXaKC1lXo5UtuCC1rCvKhEkXIZXUR
 ApIy3OH1HsAyTTvR1JpvC4ZMcWFMzAw51T58IvltWAeavl6bYcjh5LXZ2DykgxNS0yNS
 nzlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RAalIHfOL4aZgCSNGdAr61NH70nnhloDipWFAa4Drsox1P441zgQ4/fMClJLWMuEADqQ=@dpdk.org
X-Gm-Message-State: AOJu0YxoAq67ofEvfof+Icquk4Y22zFX9Ck2Gq6i54VvURz6SXXtYc2D
 2oElUAW3mkkbmjlk3isC4TWP9xG7wHC2gBRWVoSRVSiC8DEqjS77s+9NgEErr7FtIX5t9hSXJRe
 hwJm0MjF/36e60VeLv38wRsJnY7GfzFE=
X-Gm-Gg: AfdE7cl0B+MFzy9EJ7nV00MR/kRoqLMoi/I/z585MQUh661OjjsksT6dyyx/o21EQAy
 txSLmXnAdQ9VRPG0PwU1o8Zr1VbLtJRoWdA1cqRCVrxvZoHBa+HtEwQ7mDopebBfM6AgPSdIoqf
 iDmYKhODMhIQ3WnKa56DHdjzJpCp8HsGlBujhom7hJt/WHKr5b4XkfEuKiQuMWJfeheTqO+UPkR
 Cl9wbplR8Z9XXd0MUcap05jDn83kaUPK0+sdIaUFizNv5pwpUEy/E2KQtk8BMiK5QZg
X-Received: by 2002:a05:622a:1c13:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-519e4c2d754mr218961541cf.36.1782136422073; Mon, 22 Jun 2026
 06:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260416120031.3553798-2-rkudurumalla@marvell.com>
 <20260616043536.4034946-1-rkudurumalla@marvell.com>
 <20260616043536.4034946-2-rkudurumalla@marvell.com>
In-Reply-To: <20260616043536.4034946-2-rkudurumalla@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 22 Jun 2026 19:23:15 +0530
X-Gm-Features: AVVi8CdK8rBB26nIy4aKG7ThwC_ioVgcc2gvQTaRMwASFnoWj9TExhYogqQfOhg
Message-ID: <CALBAE1M3EAS6wB-FXwBfzJ9TZ8DuqYU5h7pMnoRwGPkbHBG96g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net/cnxk: add FEC get set and capability ops
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, dev@dpdk.org, jerinj@marvell.com
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

On Tue, Jun 16, 2026 at 10:05=E2=80=AFAM Rakesh Kudurumalla
<rkudurumalla@marvell.com> wrote:
>
> Add ethdev FEC operations for cnxk NIX driver:
> - fec_get_capability: Report supported FEC modes per speed.
>   If firmware provides supported FEC info, return actual
>   capabilities for current link speed. Otherwise, fall back
>   to a default capability table for common speeds.
> - fec_get: Query current FEC mode from link info
> - fec_set: Configure FEC mode on the link. AUTO mode
>   defaults to Reed-Solomon FEC.
>
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> ---
>  doc/guides/nics/cnxk.rst           | 45 ++++++++++++++
>  doc/guides/nics/features/cnxk.ini  |  1 +
>  drivers/net/cnxk/cnxk_ethdev.c     |  3 +
>  drivers/net/cnxk/cnxk_ethdev.h     |  6 ++
>  drivers/net/cnxk/cnxk_ethdev_ops.c | 94 ++++++++++++++++++++++++++++++
>  5 files changed, 149 insertions(+)
>

> +
> +.. note::
> +
> +   ``rte_eth_fec_get_capability()`` and ``rte_eth_fec_set()`` are suppor=
ted on
> +   PF ports only. SR-IOV virtual function (VF) ports can use
> +   ``rte_eth_fec_get()`` to read the current FEC mode from link status.
> +
> +Example usage:
> +
> +.. code-block:: c
> +
> +   struct rte_eth_fec_capa capa[1];
> +   uint32_t fec_capa;
> +   int num, ret;
> +
> +   num =3D rte_eth_fec_get_capability(port_id, capa, RTE_DIM(capa));
> +   if (num > 0)
> +       printf("FEC capa 0x%x at speed %u\n", capa[0].capa, capa[0].speed=
);
> +
> +   ret =3D rte_eth_fec_get(port_id, &fec_capa);
> +   if (ret =3D=3D 0)
> +       printf("Current FEC capa 0x%x\n", fec_capa);
> +
> +   ret =3D rte_eth_fec_set(port_id, RTE_ETH_FEC_MODE_CAPA_MASK(RS));
> +   if (ret)
> +       printf("FEC set failed: %s\n", rte_strerror(-ret));

Removed this code snippet from cnxk.rst doc and applied the series to
dpdk-next-net-mrvl/for-main. Thanks
