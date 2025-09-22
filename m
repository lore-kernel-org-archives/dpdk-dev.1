Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A706CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 05:19:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80593402EF;
	Mon, 22 Sep 2025 07:19:50 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6DC7F402EF
 for <dev@dpdk.org>; Mon, 22 Sep 2025 07:19:49 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-826311c1774so430881085a.2
 for <dev@dpdk.org>; Sun, 21 Sep 2025 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758518389; x=1759123189; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwwAxNAhkzN/8uhRoprus7SSpAD90beLhcTZ2SCalvU=;
 b=gjRaXW+00jUvHAH353R1Qoa5XiwUFoXzSaEPWhFK9aoehqI3O9SBiwnNqyH0LjFtYr
 gyltG6nB2YrrP/UURRXhGkqC0lCclQV41cBO1i0wwBMjIBBLs3b5GbZ1+C7DU4no4pvc
 5PGDS0btJLjAHLEiWTyVVV7bxVRyzleTgEFobRtb+Mx1Vbvh6fhjyA3Jiv3ZzH/E8RY3
 T7ncckUKWbO+IaYbuBKe0CJoNRJOGJ8UbIxHFZJwTRFGgm5c8UayVuJF0MZLb+cayat+
 aOuOguJKIVT1V7fkfIt6dLCjf8GkBFy//azM+4187tF2SV+oieMTlSxFdj52nkLk9DV0
 XJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758518389; x=1759123189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwwAxNAhkzN/8uhRoprus7SSpAD90beLhcTZ2SCalvU=;
 b=XqXvDUxnsJX2u5vVWqbrNWDNe/dM465sBQ5XaRiteyV8QI3yMf958iyOo9MRW7brG4
 CxuwFJ6ZyAilokT8dqJKfATyhv6QCb1lWbmtFA8HhccACXesghLgaFtXMpZu7hrzYw4G
 EC6IgTLqqRJ9HYNZHM8gTFoH8YbCc/Wo1PxQh8Lrp+zpFBivCsvDRQGa6wd885mXdm9U
 jSoLWZdUxnY071nvpOJ9XjSpdpo9MLONnaMF8pY6Lr+TmMhZ1t7KwlHQWlM+DnWf9TlG
 eluTr8g0sU2VHUkvpGX0HNWGiqyhT29uBBY6qSOWUJUJyt9ir/2sjP4J6RquiAUdcZSt
 9q3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3R/maArcFSUZ/0/AZT9oMefIP9dZ+Ott9QEw7Eklvc7pxjTGWwQawMFI9Y6ukJ6c5Yhc=@dpdk.org
X-Gm-Message-State: AOJu0YyJiUz/c6yLZZJZB3n+4qd4H9XjSx0WJnHonUL5u/U3SNRreIDT
 YaQ/fPJ+9d00JGPrf31CmDmU9s0o3hNdbifd1ydZ/vJd8egX1w9xFUM7AecGkCJvZ6sPMdGS9+V
 5oyJwBbbYKNTJUR7Q6EjOtANMQndHgjQ=
X-Gm-Gg: ASbGnctnfsIrE28TF8KWSImYQhadNpaQELmiuQrI5KOdury02lClFaPsM/LX1hQtxXb
 Uy53VnW5jMgxA2fAUcDLWGBORQBuOcb5Lk82z7X31bHdCb3AJ0jj9fk/H6ZBuwRlAarV7gzEg+x
 s9mYu1zZle/Fq48UPVCWP72hSUacjP3Hwmfp+gvppXiRI7FRhPon/SybBYzCJE3yURn312bUogE
 fIaY5LR1mqM2Q+55m/OoLcza7h3uNn72/LMTEgy5hNlIyL9gb5FNFEUs/kMlFI=
X-Google-Smtp-Source: AGHT+IFIhXDM/39apI3YYPdHf5mnCct/APzV93uBgqZdmmdQOHWu7/gJ68/dZbgRm/1lMok+W7vLLwoysX9Pz5Ro+68=
X-Received: by 2002:a05:622a:1114:b0:4b5:ece8:8707 with SMTP id
 d75a77b69052e-4c06d963123mr117083021cf.15.1758518388631; Sun, 21 Sep 2025
 22:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250714053150.2229683-1-vattunuru@marvell.com>
In-Reply-To: <20250714053150.2229683-1-vattunuru@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 22 Sep 2025 10:49:22 +0530
X-Gm-Features: AS18NWD9LGqz9jiYSnACUmeLPxBMJNwN5e8FbBu4A5TC_-rf4xfS9xIEGqhmwEQ
Message-ID: <CALBAE1MaK7w+dPENyF4Gs0iJaW8PUfbscVsxaOi2VprFa2C4Aw@mail.gmail.com>
Subject: Re: [PATCH v0 1/1] net/octeon_ep: handle interrupt enable failure
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: jerinj@marvell.com, dev@dpdk.org, stable@dpdk.org
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

On Mon, Jul 14, 2025 at 6:08=E2=80=AFPM Vamsi Krishna <vattunuru@marvell.co=
m> wrote:
>
> From: Vamsi Attunuru <vattunuru@marvell.com>
>
> Patch checks the return value of interrupt enable
> and returns gracefully if file handler is not available.
>
> Cc: stable@dpdk.org


Added
 Fixes: 826da0f56d42 ("net/octeon_ep: extend mailbox functionality")


Applied to dpdk-next-net-mrvl/for-main. Thanks


>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  drivers/net/octeon_ep/otx_ep_mbox.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/octeon_ep/otx_ep_mbox.c b/drivers/net/octeon_ep/=
otx_ep_mbox.c
> index 1d7e08d2cc..c83bb81474 100644
> --- a/drivers/net/octeon_ep/otx_ep_mbox.c
> +++ b/drivers/net/octeon_ep/otx_ep_mbox.c
> @@ -355,16 +355,22 @@ otx_ep_mbox_init(struct rte_eth_dev *eth_dev)
>         struct otx_ep_device *otx_ep =3D (struct otx_ep_device *)eth_dev-=
>data->dev_private;
>         struct rte_pci_device *pdev =3D RTE_ETH_DEV_TO_PCI(eth_dev);
>         uint64_t reg_val;
> +       int rc;
>
>         otx_ep_mbox_version_check(otx_ep);
>
>         rte_intr_callback_register(pdev->intr_handle, otx_ep_mbox_intr_ha=
ndler, (void *)eth_dev);
>
> -       if (rte_intr_enable(pdev->intr_handle)) {
> +       rc =3D rte_intr_enable(pdev->intr_handle);
> +
> +       if (!(rc =3D=3D -1 || rc =3D=3D 0)) {
>                 otx_ep_err("rte_intr_enable failed");
>                 return -1;
>         }
>
> +       if (rc =3D=3D -1)
> +               return 0;
> +
>         reg_val =3D otx2_read64(otx_ep->hw_addr + CNXK_EP_R_MBOX_PF_VF_IN=
T(0));
>         if (reg_val =3D=3D UINT64_MAX)
>                 return -ENODEV;
> --
> 2.34.1
>
