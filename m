Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CA2C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 22:13:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 641D3402F1;
	Wed,  8 Jul 2026 00:13:37 +0200 (CEST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by mails.dpdk.org (Postfix) with ESMTP id 16A4540265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 00:13:36 +0200 (CEST)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3995e22ef81so11451761fa.1
 for <dev@dpdk.org>; Tue, 07 Jul 2026 15:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783462415; cv=none;
 d=google.com; s=arc-20260327;
 b=Bp9z18uZDK3k6vSbvYwd7RKGTS/mCiUxcjpxO2e6js5e3+521PkIwTUheuJ8yJOOAp
 93/zEiDy7Ky5hznf1Xvzn1piMFaqreOF1UR0Vv3CmFj4u7GdLfDSi9uAr62knKnJT3Wl
 Zgxk+Bdw/TX0G58X8WT1Xo5kT0yCCWJjI6Y62MphQSPf8TR433yUn9yz0izZAKEgLJnj
 4Q8z+0pZZgcB5N7kNrVh/epAov8M4dmTJEmPchN95xAHXPZajwYBV1AO55NvJaszM3w4
 JO8Tme3vLQfnGSF9rN+qLja1QXY912GCZU1vv9uVg5A/iKNGUamulIK/NKjgSxc6fjlr
 l4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HzWdtTdfnaimd5mOkx4HgEjoY59ribCndxMcurHlteM=;
 fh=WrAx+kzdc6Vmt8pOkIcJ5u8hMWSsz8YTBzEw6gMG1OE=;
 b=JLgA3/7hxvh4w6Z1o9U8NyK2A3oR7Poqi0XrGwyi5Qk6P6vIF5mJwi2zQocpqOgXkC
 b8CkCfTo/WsvXd7qfbwU5nemFfBMIGu0v3yecvYL/HDMgF3g9BlHf6/QrU2BiLuN/pE9
 HPBaa1sRM9YlKGGFc4HK/V/TZADEAaXFq0H7BB3qiWaCwd/V1axPQOwtV28C5NCs8dwU
 7SMazbqOwALKLEg+a9L5jyLV15ssYNywgI7zGYrVwNoqEUKFFl+RtfwBegZyqs7hVlsL
 nhWv99T0nmiS9RbTuA8LnEY31/VcXAj1yQLLacC05cDYwsuuIlGwKA98sYQssE+LZpEP
 p1/A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783462415; x=1784067215; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HzWdtTdfnaimd5mOkx4HgEjoY59ribCndxMcurHlteM=;
 b=Z5Z6JTFjDeBWX+RSfzP0XBlf7pRNtQ6nQWPt3KEIn/w3uecXAorzs+hTUkflgW8W/o
 A7GdzfyLrvdlifBoofQf1+Lf1R6dIuiq2p/yWOIruX7zLJ8XSxynWSrUHcD46L4253qT
 AINLcZW+RJ/eR2xY1SGXwwwjpgJBfxjeqoWB5pUwJg4u4iiuIHsMhz2Q5aM+DZSUYztb
 05yXX8xDdFGmd9Qq44YL3hY34XmPx6ErKgC690guvfivw/HTdvCqybKQroHl35P869Rs
 HKgSBGMG8afR2QSCdUHXdccjECoLeq35hPj27qrJmJ8bs7sTKI099KHV+FUlQPrezCSp
 4plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783462415; x=1784067215;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HzWdtTdfnaimd5mOkx4HgEjoY59ribCndxMcurHlteM=;
 b=sf1MiteUV42lM4bgEznuLuqzp9yOeUZTTmkXAL9XNnEwoFr+WALnwI5ppjvTiYTKqq
 drDIao9gt82CNBH5WSVb3FUGWPkMqowwu3popdQ5AIabH1OjpvogmPvVlpSOKY8bEU5e
 ajOCBcAwNDV2q0mD6jGW4aqIKk9vAxuy4xaestcKa4utv5HXoDw8syYk2552uV3TmDTU
 MFnSwC1tvok7t+SAqDQmaAWxxyJ2og9jrXfPzZqsnaxMdd0UnyNeiU1Nfek0vE0FlHFQ
 8QRvMuH768TeYrEpywagPpinD/p++1a0NW1s6ogtUIjiQbxdg0SHXuLFSStCXeyAoHdF
 GPOQ==
X-Gm-Message-State: AOJu0YzfG8hGw9HMwOzSUauFAOlOxgRWXg3SJSV/58NxpCXqVE9DsowG
 i9KUxYyLy2JaqR15rQu51e+yJltvxJwGcA61ACF+19jIPUTQjntRTUpLWlmsRZFWqMJn/Qj6Vug
 hIDsBYkp/swaDh491qifowRBGiM0Hn9Sm7C+cxRT4
X-Gm-Gg: AfdE7cle46rTPYdmpGTV5jBuwv03BeLkZTiN9a6Kms9kZBSy2Icv3SYsLfK5kwX7ciA
 23n/sg9xx1MVtMn+l5DlIcl5JPMA+67H+CSDGpzR+AtV//NV73+sQBHj/bTKKshzP7m3oJrWn+P
 m/dV5csADjvbyPfClNqq38zWos4gXylX9jA8Qu7is/e3FN6dHb1bSNA9QEt8yJgW/7zMCqEKNdx
 eiuPYuC4kMNn30O7ABZRL+HGyr1kNmo/iJgBDzQOtYVxm82qL37NJoXEFCGy48Qtu/J+ZVds5KV
 3yDQB/Ola1kiVpmxEm2oYTZLnjM=
X-Received: by 2002:a05:6512:6c9:b0:5ae:9be8:1ad7 with SMTP id
 2adb3069b0e04-5b00ac980e2mr921641e87.18.1783462415050; Tue, 07 Jul 2026
 15:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260707164020.2936476-1-joshwash@google.com>
 <20260707164020.2936476-10-joshwash@google.com>
In-Reply-To: <20260707164020.2936476-10-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 7 Jul 2026 18:13:21 -0400
X-Gm-Features: AVVi8Ce8S8ZY84VZWbaoJbVYDCL1KPVPqFYag9XMbIvt252XLHeY4KIAd9i60m0
Message-ID: <CALuQH+Wrkvfxb3O35du5VrtUz23O0FqXVH_WEVnkzv9AtEgjow@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] net/gve: restrict max ring size in GQ QPL to 2K
To: Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 "Jasper Tran O'Leary" <jtranoleary@google.com>
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

On Tue, Jul 7, 2026 at 12:40=E2=80=AFPM Joshua Washington <joshwash@google.=
com> wrote:
>
> The GQ QPL queue format has a maximum supported ring size of 2k.
> However, it is possible in some cases for the device to pass a larger
> ring size as the max ring size. Restrict the ring size in the driver to
> ensure that rings with invalid queue depths are not created.
>
> Fixes: cde01d164f8f ("net/gve: support modifying ring size in GQ format")
> Cc: stable@dpdk.org
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
> ---
>  drivers/net/gve/base/gve_adminq.c | 12 +++++++++---
>  drivers/net/gve/gve_ethdev.h      |  1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve=
_adminq.c
> index 2b25c7f390..315e2456fd 100644
> --- a/drivers/net/gve/base/gve_adminq.c
> +++ b/drivers/net/gve/base/gve_adminq.c
> @@ -6,6 +6,7 @@
>  #include "../gve_ethdev.h"
>  #include "gve_adminq.h"
>  #include "gve_register.h"
> +#include "rte_common.h"

Looks like I forgot to fix the include formatting here. I will fix in
the next revision.

>
>  #define GVE_MAX_ADMINQ_RELEASE_CHECK   500
>  #define GVE_ADMINQ_SLEEP_LEN           20
> @@ -946,15 +947,20 @@ static void
>  gve_set_max_desc_cnt(struct gve_priv *priv,
>         const struct gve_device_option_modify_ring *modify_ring)
>  {
> +       priv->max_rx_desc_cnt =3D be16_to_cpu(modify_ring->max_ring_size.=
rx);
> +       priv->max_tx_desc_cnt =3D be16_to_cpu(modify_ring->max_ring_size.=
tx);
> +
>         if (priv->queue_format =3D=3D GVE_DQO_RDA_FORMAT) {
>                 PMD_DRV_LOG(DEBUG, "Overriding max ring size from device =
for DQ "
>                             "queue format to 4096.");
>                 priv->max_rx_desc_cnt =3D GVE_MAX_QUEUE_SIZE_DQO;
>                 priv->max_tx_desc_cnt =3D GVE_MAX_QUEUE_SIZE_DQO;
> -               return;
> +       } else if (priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT) {
> +               priv->max_rx_desc_cnt =3D RTE_MIN(priv->max_rx_desc_cnt,
> +                                               GVE_MAX_RING_SIZE_GQ_QPL)=
;
> +               priv->max_tx_desc_cnt =3D RTE_MIN(priv->max_tx_desc_cnt,
> +                                               GVE_MAX_RING_SIZE_GQ_QPL)=
;
>         }
> -       priv->max_rx_desc_cnt =3D be16_to_cpu(modify_ring->max_ring_size.=
rx);
> -       priv->max_tx_desc_cnt =3D be16_to_cpu(modify_ring->max_ring_size.=
tx);
>  }
>
>  static void gve_enable_supported_features(struct gve_priv *priv,
> diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
> index 4a7e5ecdf3..c9a176ff17 100644
> --- a/drivers/net/gve/gve_ethdev.h
> +++ b/drivers/net/gve/gve_ethdev.h
> @@ -21,6 +21,7 @@
>  #define DQO_TX_MULTIPLIER 4
>
>  #define GVE_DEFAULT_MAX_RING_SIZE      1024
> +#define GVE_MAX_RING_SIZE_GQ_QPL       2048
>  #define GVE_DEFAULT_MIN_RX_RING_SIZE   512
>  #define GVE_DEFAULT_MIN_TX_RING_SIZE   256
>
> --
> 2.55.0.rc2.803.g1fd1e6609c-goog
>


--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3
