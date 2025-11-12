Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70594CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 08:48:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3732E40650;
	Wed, 12 Nov 2025 09:48:04 +0100 (CET)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 848294014F
 for <dev@dpdk.org>; Wed, 12 Nov 2025 09:44:26 +0100 (CET)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-882475d8851so6445606d6.2
 for <dev@dpdk.org>; Wed, 12 Nov 2025 00:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762937066; x=1763541866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5dldnkavz4MLuXzw/YiSGYtR1q1z1kbqKw5BpN/UKJU=;
 b=rlOCU7CXauDSUa/qZAnJ3+Cp0gb8XhA3fwgawa49JFyNf2CyXouXKCUxBls7WuHJd4
 wvdysO2kbP3JhoShU+Uu6aPbwXuPOuWxqGlfXNKGlTvJpBJjdHp6+jrNG0r0lyc+SlNb
 X8gv2r28Lr05GVblrTRFzbiejq4goodb9VFULR5KjniC5NErY+ozo4Xav+C7UQIGbmDL
 tiNJZ/J7zLv0ZXVVECx032uiCqaeuLDYl1c6ah4ltkeTnwPmXh0OyPC/nvjW6kC8d8qU
 SToTrWFqRiR4+TmOBbRDBwrSpP4ccTwYWywI02caUm+8vDLCWB7mW1VOMvI9Ldtt2O2T
 rXmQ==
X-Gm-Message-State: AOJu0YyVBtovLITcqBSX9NnZyw+K8nLGk8k9o94ZeJt/0Pr9GV6pNbxj
 2gmOePKyX0AxS9/mjFVdFm8MZ0tzSBoHF6JXdHaNrlpMiB1wWblbAIyAERdU2gUvTGJFRs0lOPF
 99Pw0CPfaskeDWsEfV+BC3zdfQbdYVWs=
X-Gm-Gg: ASbGnctq3z/rlB31zUJN3cfj1Jw75TOWXQB9UXqG4IoqElMu1qNhfct7hLw6M8nX+xS
 iRgtndechO6MDppWmmak5+nJXt3GMXuzXacLRh8+gZNuMhPbObPKYDqz5JB6zvEEBRNgXsCv95B
 6Jk2RwX3Qq7UKs29pSnEUR5E6ZikWcPCSnhBfoKPMF+YA/yFFhnv8BE7mjsB2uaEvTHXSlhVImZ
 snmsZq7CjCUOfeycODhLtVOcmWS19imxFEiBUU2n/IacDLrmX+CrHkPoA==
X-Google-Smtp-Source: AGHT+IFfAiXhxAtfa8f5LOJEphdZOJ0Em63A2HcN4LsE5FA+tkcBRBQEGYX5TleFKOkXyu9iSK573T/lFu2+n4R26eA=
X-Received: by 2002:a05:622a:46:b0:4ec:f410:2470 with SMTP id
 d75a77b69052e-4eddbe5e8e8mr27925911cf.71.1762937065724; Wed, 12 Nov 2025
 00:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251108153207.1512863-5-david.marchand@redhat.com>
In-Reply-To: <20251108153207.1512863-5-david.marchand@redhat.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Wed, 12 Nov 2025 09:44:14 +0100
X-Gm-Features: AWmQ_bmE-oSTcoMQ7Su19-16Gpq_yj2m-MOa0bOnd7i5qxdgg-lMAfChY6JnFbU
Message-ID: <CAHHRULVe39Hq3ebQJVMfSfBMppEgZX0gmdzSqGoXNJWK5QtGGg@mail.gmail.com>
Subject: Re: [PATCH 4/5] net/dpaa2: remove ethdev device in bus device
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, 
 Sachin Saxena <sachin.saxena@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 12 Nov 2025 09:48:02 +0100
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

Le sam. 8 nov. 2025 =C3=A0 16:32, David Marchand
<david.marchand@redhat.com> a =C3=A9crit :
>
> Calling rte_eth_dev_allocated() is enough to retrieve the
> ethdev device object.
>
> This leaves no user of the ethdev field in the fslmc device object.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/bus/fslmc/bus_fslmc_driver.h | 1 -
>  drivers/net/dpaa2/dpaa2_ethdev.c     | 6 ++++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus=
_fslmc_driver.h
> index efa88754a7..094f885f59 100644
> --- a/drivers/bus/fslmc/bus_fslmc_driver.h
> +++ b/drivers/bus/fslmc/bus_fslmc_driver.h
> @@ -98,7 +98,6 @@ struct rte_dpaa2_device {
>         TAILQ_ENTRY(rte_dpaa2_device) next; /**< Next probed DPAA2 device=
. */
>         struct rte_device device;           /**< Inherit core device */
>         union {
> -               struct rte_eth_dev *eth_dev;        /**< ethernet device =
*/
>                 struct rte_rawdev *rawdev;          /**< Raw Device */
>         };
>         enum rte_dpaa2_dev_type dev_type;   /**< Device Type */
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_e=
thdev.c
> index 7da32ce856..2a26a02cb4 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -3320,7 +3320,6 @@ rte_dpaa2_probe(struct rte_dpaa2_driver *dpaa2_drv,
>
>         eth_dev->device =3D &dpaa2_dev->device;
>
> -       dpaa2_dev->eth_dev =3D eth_dev;
>         eth_dev->data->rx_mbuf_alloc_failed =3D 0;
>
>         if (dpaa2_drv->drv_flags & RTE_DPAA2_DRV_INTR_LSC)
> @@ -3349,7 +3348,10 @@ rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_de=
v)
>         struct rte_eth_dev *eth_dev;
>         int ret;
>
> -       eth_dev =3D dpaa2_dev->eth_dev;
> +       eth_dev =3D rte_eth_dev_allocated(dpaa2_dev->device.name);
> +       if (!eth_dev)
> +               return 0;
> +
>         dpaa2_dev_close(eth_dev);
>         dpaa2_valid_dev--;
>         if (!dpaa2_valid_dev)


dpaa2_valid_dev is currently incremented in rte_dpaa2_probe. With your
modification, dpaa2_valid_dev will never be decremented in
rte_dpaa2_remove if rte_eth_dev_close has already been called.
As a consequence, dpaa2_tx_sg_pool will never be freed.

I don=E2=80=99t think dpaa2_tx_sg_pool should be freed in rte_dpaa2_remove;=
 it
should be freed in dpaa2_dev_close instead.
For symmetry, dpaa2_tx_sg_pool should also be allocated directly in
dpaa2_dev_init.

Regards,

Maxime Leroy
