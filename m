Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E6AFB5175
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Apr 2026 22:22:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CDF040150;
	Tue,  7 Apr 2026 00:22:30 +0200 (CEST)
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com
 [209.85.128.227])
 by mails.dpdk.org (Postfix) with ESMTP id B5E20400D7
 for <dev@dpdk.org>; Tue,  7 Apr 2026 00:22:29 +0200 (CEST)
Received: by mail-yw1-f227.google.com with SMTP id
 00721157ae682-7986e538decso44612257b3.1
 for <dev@dpdk.org>; Mon, 06 Apr 2026 15:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775514149; x=1776118949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ckvgKG/JKuccRvLLXBZ+ipzLaW1MKu7/DXyJfso+2UU=;
 b=i20+Fd0wI74PrzsAnBZJWAMbCkzriiKl0mMhNez6bC/VWxiZkbpcW1OdpCW8zanug8
 qMvVn51B3FMlGIo8YYSdB00sLx+uJ7CCERgWqmSe1suq7rAA+xS960mW5Jn6u0wqAWH6
 h8CWmMwbWO1ADl5HnaYwaws9VeC1nZzv5Aef6CCG2tVeAPBV2GIdvg33CauE3TsbbVWG
 YF0+qQHmjdwsE44UPoGYIla4WZMQ3Nrv9MCtKX2uE6U9iYRIKBPx51CWtbZCsZn0tyMz
 b/WZJhcl1WU5ZIwqQkzF+Cv3NkWBNNupeglxY/1hX4kbUIXtd82vgIETOOPuqqunY76V
 0wcQ==
X-Gm-Message-State: AOJu0YzxE42VXC/2tN01Usd3IAYXUmUfKMhm8WzplmJjzp2Ynefq7ASo
 1zG4UZAl+KvVSDKxl9TyKAZQw54wqTJg62+oo5YPURO6I66NqQZg/c6vC2nJ/a1tBbXaexhf6U3
 sPOMQozVXrYG6eOUcoGDyVCwNXp/oYvTZCYcB4ItTmWWXlMQfTZXupoljs+e1UyQCrUc1zPh0ir
 dtpS+UGpDDLZUSmDOzjhIeADMlgg+Qm+h3ulD5Yo4a8YH/4BJSSeUIh/uYrRfynn1dg2bBg4Vwc
 mphBA==
X-Gm-Gg: AeBDieur6e6m4P4NLRCB+5Sar1D1RhB3SSFKpW+/5rOyc3Vt8yANBhnH/IxJrvkFAH1
 is8wafgmSXjx48icnhmXKhe1EWCWmbLBPrNeJM9z1tNEc5F7VK3+0un8uPwJtrcoGxYeM0VZUNh
 /9PDoECb+/QnbqKN6A1mt4wG/H4bYB5apCmj/vnAOfg4QVcQ6eCGRcsWfk0kyS2myHyU97WO0F/
 xmnR/TOyvpE1Po+eDF+qJ18l1olwAuWSqpbxM0Y1vixzSlGBj7SRnZtnKM09nhpTrLTBJC1cjGx
 WmNyuBRVLVyLrN4+a9/NSg9+UcnkZjaVbEk2AqCbvjq0S532uPwU2ciKpR3ck/0kpgc/wOuuu4W
 s/VJ3TH7WjFCEww6jaegvwMmM1nxScF+Mx9QnRnrXYwrhXvFNAsYqqxMYqFDlocDNwx60hHP/8C
 FZwSyaLz8USZHcAxWmV5klZQ/SvvwMp8YCJUeBRkZt4PtL4Apsk+y/Ryt3Cg8K+3Kj
X-Received: by 2002:a05:690c:38a:b0:7a4:e4e5:38f2 with SMTP id
 00721157ae682-7a4e4e53fd6mr138217247b3.51.1775514148689; 
 Mon, 06 Apr 2026 15:22:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7a370902c20sm10685047b3.23.2026.04.06.15.22.28
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Apr 2026 15:22:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b8fbe7a6f41so338562966b.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 15:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775514147; cv=none;
 d=google.com; s=arc-20240605;
 b=kLqGMc814SFl/frWD1PkXuJfdkuFU1EJedCspzdVUwxQlPMi8UBzyFHQWTTwWDK1w0
 A+YUcqisueS/a8M5RRb7cXSJvcGbtjyYBSec9kF8gNayAlCagARAkpkpURvm4VNN8AQB
 a4EGHK/5WDkfOFUCP2al0cPeQ/IuolUgK64L6YeeU5Rl5i6C8vzdsUEtUC0GHdLAcLsS
 Taf1JNegEWf+n7Q3+QyeSnIGZZL3RzDGth2zS3CwDOcBy3G2PYvdGN052Ho1ljTkSERv
 AM4bVx74O5lwtg1jwgcM/0oUol5AAonpbYqnvJTN6PsuTNoekxgVKixBNgucmqusVG7C
 bhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ckvgKG/JKuccRvLLXBZ+ipzLaW1MKu7/DXyJfso+2UU=;
 fh=ZF3V6KmjK/IiQh4DIjYj7AD0K/98Km6/2dpmUIapWOg=;
 b=ANSgy5xGKYZHzpehH40CA5cOBuEoICM/FRKaZM3Acud9ujrymRsvHdJPp+0GTWYpxH
 X31rEVI8MrygZSL8lijvsbuNkGfXPsMCmEZYKKTCb9iS9BR/qZEqrXBHzo64cHKDoDb3
 H/eXaFsZQ2/076LFyEywfFcNzuN6lkSA1iM/UaZm653qCWq86vKfQ7As75iJScCFNtFz
 tiB8/7asN10ZhocmvPlHFcmvtuTFs2pkz2MB6ZlmvbAdLNStSonPydRaQTOUeTzMP8ia
 dTaTE2kNMxHzqg38gm1ZbiVvCCDkdOE5doLFPIy6jo4eVhCzkf13bBNCCNtSfa9DVUSb
 djVg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1775514147; x=1776118947; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ckvgKG/JKuccRvLLXBZ+ipzLaW1MKu7/DXyJfso+2UU=;
 b=ewBkPBytRhOStn0CbCQGGxSa1NIq0bZ0FD2SY6hQoZnCG4UgWfYUVSsNEaGErPQyWv
 IpfTf9X9B36wwBPn2tv0nmoRhq83OYdVy0MQq2pVZEMLhLCHA/S8eyayq2d1imWbBv9y
 id3LnvNcAf6VhK76Yt/12mxYfQzOqkNpQg87M=
X-Received: by 2002:a17:907:e107:b0:b93:56a4:d6bc with SMTP id
 a640c23a62f3a-b9c6798d3a2mr454711166b.49.1775514146838; 
 Mon, 06 Apr 2026 15:22:26 -0700 (PDT)
X-Received: by 2002:a17:907:e107:b0:b93:56a4:d6bc with SMTP id
 a640c23a62f3a-b9c6798d3a2mr454709766b.49.1775514146260; Mon, 06 Apr 2026
 15:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260403091836.1073484-3-david.marchand@redhat.com>
In-Reply-To: <20260403091836.1073484-3-david.marchand@redhat.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 6 Apr 2026 18:22:10 -0400
X-Gm-Features: AQROBzB7vS7ufJBwiE0z7ogq8INXVpw1QS0rd_wVkoDOoSa49nPxtfV-zsJezOk
Message-ID: <CA+BST0nbexjrKN7EMd3MerKxbf0syDErkGd+QrKDfEVOWwS=7Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] ethdev: announce VMDq capability
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Rosen Xu <rosen.xu@altera.com>, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Zaiyu Wang <zaiyuwang@trustnetic.com>, Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000000afba8064ed21a52"
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

--0000000000000afba8064ed21a52
Content-Type: multipart/alternative; boundary="000000000000fb706a064ed2199d"

--000000000000fb706a064ed2199d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 5:19=E2=80=AFAM David Marchand <david.marchand@redha=
t.com>
wrote:

> Let's mark VMDq feature availability as a per device capability.
> We can then enforce API calls related to this feature are done on device
> with such capability.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/net/bnxt/bnxt_ethdev.c                |  3 ++-
>  drivers/net/bnxt/bnxt_reps.c                  |  1 +
>  drivers/net/intel/e1000/em_ethdev.c           |  1 +
>  drivers/net/intel/e1000/igb_ethdev.c          |  1 +
>  drivers/net/intel/fm10k/fm10k_ethdev.c        |  1 +
>  drivers/net/intel/i40e/i40e_ethdev.c          |  3 ++-
>  drivers/net/intel/i40e/i40e_vf_representor.c  |  1 +
>  drivers/net/intel/ipn3ke/ipn3ke_representor.c |  3 ++-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  2 ++
>  drivers/net/txgbe/txgbe_ethdev.c              |  1 +
>  drivers/net/txgbe/txgbe_ethdev_vf.c           |  1 +
>  lib/ethdev/rte_ethdev.c                       | 17 +++++++++++++++++
>  lib/ethdev/rte_ethdev.h                       |  2 ++
>  13 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> b/drivers/net/bnxt/bnxt_ethdev.c
> index b677f9491d..0f783b9e98 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -1214,7 +1214,8 @@ static int bnxt_dev_info_get_op(struct rte_eth_dev
> *eth_dev,
>
>         dev_info->speed_capa =3D bnxt_get_speed_capabilities(bp);
>         dev_info->dev_capa =3D RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
> -                            RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
> +                            RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP |
> +                            RTE_ETH_DEV_CAPA_VMDQ;
>
We have not been testing the VMDq feature for sometime, planning to
deprecate this feature. Please remove this change.

>         dev_info->dev_capa &=3D ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
>
>         dev_info->default_rxconf =3D (struct rte_eth_rxconf) {
> diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
> index e26a086f41..5e834830e2 100644
> --- a/drivers/net/bnxt/bnxt_reps.c
> +++ b/drivers/net/bnxt/bnxt_reps.c
> @@ -649,6 +649,7 @@ int bnxt_rep_dev_info_get_op(struct rte_eth_dev
> *eth_dev,
>         dev_info->max_tx_queues =3D max_rx_rings;
>         dev_info->reta_size =3D bnxt_rss_hash_tbl_size(parent_bp);
>         dev_info->hash_key_size =3D 40;
> +       dev_info->dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ;
>         dev_info->dev_capa &=3D ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
>
> We have not been testing the VMDq feature for sometime, planning to
deprecate this feature. Please remove this change.

>         /* MTU specifics */
> diff --git a/drivers/net/intel/e1000/em_ethdev.c
> b/drivers/net/intel/e1000/em_ethdev.c
> index 9e15e882b9..389744ad5e 100644
> --- a/drivers/net/intel/e1000/em_ethdev.c
> +++ b/drivers/net/intel/e1000/em_ethdev.c
> @@ -1175,6 +1175,7 @@ eth_em_infos_get(struct rte_eth_dev *dev, struct
> rte_eth_dev_info *dev_info)
>                         RTE_ETH_LINK_SPEED_100M_HD |
> RTE_ETH_LINK_SPEED_100M |
>                         RTE_ETH_LINK_SPEED_1G;
>
> +       dev_info->dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ;
>         dev_info->dev_capa &=3D ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
>
>         /* Preferred queue parameters */
> diff --git a/drivers/net/intel/e1000/igb_ethdev.c
> b/drivers/net/intel/e1000/igb_ethdev.c
> index ef1599ac38..fe68c18417 100644
> --- a/drivers/net/intel/e1000/igb_ethdev.c
> +++ b/drivers/net/intel/e1000/igb_ethdev.c
> @@ -2324,6 +2324,7 @@ eth_igb_infos_get(struct rte_eth_dev *dev, struct
> rte_eth_dev_info *dev_info)
>         dev_info->tx_queue_offload_capa =3D
> igb_get_tx_queue_offloads_capa(dev);
>         dev_info->tx_offload_capa =3D igb_get_tx_port_offloads_capa(dev) =
|
>                                     dev_info->tx_queue_offload_capa;
> +       dev_info->dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ;
>         dev_info->dev_capa &=3D ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
>
>         switch (hw->mac.type) {
> diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c
> b/drivers/net/intel/fm10k/fm10k_ethdev.c
> index 97f61afec2..037d2206fd 100644
> --- a/drivers/net/intel/fm10k/fm10k_ethdev.c
> +++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
> @@ -1444,6 +1444,7 @@ fm10k_dev_infos_get(struct rte_eth_dev *dev,
>         dev_info->speed_capa =3D RTE_ETH_LINK_SPEED_1G |
> RTE_ETH_LINK_SPEED_2_5G |
>                         RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G |
>                         RTE_ETH_LINK_SPEED_40G | RTE_ETH_LINK_SPEED_100G;
> +       dev_info->dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ;
>
>         return 0;
>  }
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c
> b/drivers/net/intel/i40e/i40e_ethdev.c
> index 100a751225..64c29c6e85 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -3878,7 +3878,8 @@ i40e_dev_info_get(struct rte_eth_dev *dev, struct
> rte_eth_dev_info *dev_info)
>
>         dev_info->dev_capa =3D
>                 RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
> -               RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
> +               RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP |
> +               RTE_ETH_DEV_CAPA_VMDQ;
>         dev_info->dev_capa &=3D ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
>
>         dev_info->hash_key_size =3D (I40E_PFQF_HKEY_MAX_INDEX + 1) *
> diff --git a/drivers/net/intel/i40e/i40e_vf_representor.c
> b/drivers/net/intel/i40e/i40e_vf_representor.c
> index e8f0bb62a0..d31148acb5 100644
> --- a/drivers/net/intel/i40e/i40e_vf_representor.c
> +++ b/drivers/net/intel/i40e/i40e_vf_representor.c
> @@ -33,6 +33,7 @@ i40e_vf_representor_dev_infos_get(struct rte_eth_dev
> *ethdev,
>         /* get dev info for the vdev */
>         dev_info->device =3D ethdev->device;
>
> +       dev_info->dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ;
>         dev_info->dev_capa &=3D ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
>
>         dev_info->max_rx_queues =3D ethdev->data->nb_rx_queues;
> diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c
> b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
> index cd34d08055..d581ee3c37 100644
> --- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c
> +++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
> @@ -95,7 +95,8 @@ ipn3ke_rpst_dev_infos_get(struct rte_eth_dev *ethdev,
>
>         dev_info->dev_capa =3D
>                 RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
> -               RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
> +               RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP |
> +               RTE_ETH_DEV_CAPA_VMDQ;
>         dev_info->dev_capa &=3D ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
>
>         dev_info->switch_info.name =3D ethdev->device->name;
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 57d929cf2c..5d886b3e28 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -3997,6 +3997,7 @@ ixgbe_dev_info_get(struct rte_eth_dev *dev, struct
> rte_eth_dev_info *dev_info)
>         dev_info->max_mtu =3D  dev_info->max_rx_pktlen - IXGBE_ETH_OVERHE=
AD;
>         dev_info->min_mtu =3D RTE_ETHER_MIN_MTU;
>         dev_info->vmdq_queue_num =3D dev_info->max_rx_queues;
> +       dev_info->dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ;
>         dev_info->rx_queue_offload_capa =3D ixgbe_get_rx_queue_offloads(d=
ev);
>         dev_info->rx_offload_capa =3D (ixgbe_get_rx_port_offloads(dev) |
>                                      dev_info->rx_queue_offload_capa);
> @@ -4115,6 +4116,7 @@ ixgbevf_dev_info_get(struct rte_eth_dev *dev,
>                 dev_info->max_vmdq_pools =3D RTE_ETH_16_POOLS;
>         else
>                 dev_info->max_vmdq_pools =3D RTE_ETH_64_POOLS;
> +       dev_info->dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ;
>         dev_info->rx_queue_offload_capa =3D ixgbe_get_rx_queue_offloads(d=
ev);
>         dev_info->rx_offload_capa =3D (ixgbe_get_rx_port_offloads(dev) |
>                                      dev_info->rx_queue_offload_capa);
> diff --git a/drivers/net/txgbe/txgbe_ethdev.c
> b/drivers/net/txgbe/txgbe_ethdev.c
> index 5d360f8305..bd818e8269 100644
> --- a/drivers/net/txgbe/txgbe_ethdev.c
> +++ b/drivers/net/txgbe/txgbe_ethdev.c
> @@ -2836,6 +2836,7 @@ txgbe_dev_info_get(struct rte_eth_dev *dev, struct
> rte_eth_dev_info *dev_info)
>         dev_info->max_vfs =3D pci_dev->max_vfs;
>         dev_info->max_vmdq_pools =3D RTE_ETH_64_POOLS;
>         dev_info->vmdq_queue_num =3D dev_info->max_rx_queues;
> +       dev_info->dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ;
>         dev_info->dev_capa &=3D ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
>         dev_info->rx_queue_offload_capa =3D txgbe_get_rx_queue_offloads(d=
ev);
>         dev_info->rx_offload_capa =3D (txgbe_get_rx_port_offloads(dev) |
> diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c
> b/drivers/net/txgbe/txgbe_ethdev_vf.c
> index 39a5fff65c..934763574c 100644
> --- a/drivers/net/txgbe/txgbe_ethdev_vf.c
> +++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
> @@ -572,6 +572,7 @@ txgbevf_dev_info_get(struct rte_eth_dev *dev,
>         dev_info->max_hash_mac_addrs =3D TXGBE_VMDQ_NUM_UC_MAC;
>         dev_info->max_vfs =3D pci_dev->max_vfs;
>         dev_info->max_vmdq_pools =3D RTE_ETH_64_POOLS;
> +       dev_info->dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ;
>         dev_info->dev_capa &=3D ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
>         dev_info->rx_queue_offload_capa =3D txgbe_get_rx_queue_offloads(d=
ev);
>         dev_info->rx_offload_capa =3D (txgbe_get_rx_port_offloads(dev) |
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index 9577b7d848..7ba539e796 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -158,6 +158,7 @@ static const struct {
>         {RTE_ETH_DEV_CAPA_RXQ_SHARE, "RXQ_SHARE"},
>         {RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP, "FLOW_RULE_KEEP"},
>         {RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP,
> "FLOW_SHARED_OBJECT_KEEP"},
> +       {RTE_ETH_DEV_CAPA_VMDQ, "VMDQ"},
>  };
>
>  enum {
> @@ -1581,6 +1582,22 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t
> nb_rx_q, uint16_t nb_tx_q,
>                 goto rollback;
>         }
>
> +       if (!(dev_info.dev_capa & RTE_ETH_DEV_CAPA_VMDQ)) {
> +               if ((dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG)
> !=3D 0) {
> +                       RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=3D%u doe=
s
> not support VMDq rx mode",
> +                               port_id);
> +                       ret =3D -EINVAL;
> +                       goto rollback;
> +               }
> +               if (dev_conf->txmode.mq_mode =3D=3D RTE_ETH_MQ_TX_VMDQ_DC=
B ||
> +                               dev_conf->txmode.mq_mode =3D=3D
> RTE_ETH_MQ_TX_VMDQ_ONLY) {
> +                       RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=3D%u doe=
s
> not support VMDq tx mode",
> +                               port_id);
> +                       ret =3D -EINVAL;
> +                       goto rollback;
> +               }
> +       }
> +
>         /*
>          * Setup new number of Rx/Tx queues and reconfigure device.
>          */
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index 0d8e2d0236..62c72de0e5 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -1696,6 +1696,8 @@ struct rte_eth_conf {
>  #define RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP         RTE_BIT64(3)
>  /** Device supports keeping shared flow objects across restart. */
>  #define RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP RTE_BIT64(4)
> +/** Device supports VMDq. */
> +#define RTE_ETH_DEV_CAPA_VMDQ RTE_BIT64(5)
>  /**@}*/
>
>  /*
> --
> 2.53.0
>
>

--000000000000fb706a064ed2199d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 3, =
2026 at 5:19=E2=80=AFAM David Marchand &lt;<a href=3D"mailto:david.marchand=
@redhat.com">david.marchand@redhat.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Let&#39;s mark VMDq feature availabil=
ity as a per device capability.<br>
We can then enforce API calls related to this feature are done on device<br=
>
with such capability.<br>
<br>
Signed-off-by: David Marchand &lt;<a href=3D"mailto:david.marchand@redhat.c=
om" target=3D"_blank">david.marchand@redhat.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/bnxt/bnxt_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0drivers/net/bnxt/bnxt_reps.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0drivers/net/intel/e1000/em_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 1 +<br>
=C2=A0drivers/net/intel/e1000/igb_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1 +<br>
=C2=A0drivers/net/intel/fm10k/fm10k_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
=C2=A0drivers/net/intel/i40e/i40e_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 3 ++-<br>
=C2=A0drivers/net/intel/i40e/i40e_vf_representor.c=C2=A0 |=C2=A0 1 +<br>
=C2=A0drivers/net/intel/ipn3ke/ipn3ke_representor.c |=C2=A0 3 ++-<br>
=C2=A0drivers/net/intel/ixgbe/ixgbe_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 ++<br>
=C2=A0drivers/net/txgbe/txgbe_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0drivers/net/txgbe/txgbe_ethdev_vf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 1 +<br>
=C2=A0lib/ethdev/rte_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 17 +++++++++++++++++<br>
=C2=A0lib/ethdev/rte_ethdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A013 files changed, 34 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.=
c<br>
index b677f9491d..0f783b9e98 100644<br>
--- a/drivers/net/bnxt/bnxt_ethdev.c<br>
+++ b/drivers/net/bnxt/bnxt_ethdev.c<br>
@@ -1214,7 +1214,8 @@ static int bnxt_dev_info_get_op(struct rte_eth_dev *e=
th_dev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;speed_capa =3D bnxt_get_speed_capa=
bilities(bp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa =3D RTE_ETH_DEV_CAPA_RUNT=
IME_RX_QUEUE_SETUP |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_DEV_CAPA_VMDQ;<br></blockquote><div>We hav=
e not been testing the VMDq feature for sometime, planning to deprecate thi=
s feature. Please remove this change.=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa &amp;=3D ~RTE_ETH_DEV_CAP=
A_FLOW_RULE_KEEP;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;default_rxconf =3D (struct rte_eth=
_rxconf) {<br>
diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c<br=
>
index e26a086f41..5e834830e2 100644<br>
--- a/drivers/net/bnxt/bnxt_reps.c<br>
+++ b/drivers/net/bnxt/bnxt_reps.c<br>
@@ -649,6 +649,7 @@ int bnxt_rep_dev_info_get_op(struct rte_eth_dev *eth_de=
v,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;max_tx_queues =3D max_rx_rings;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;reta_size =3D bnxt_rss_hash_tbl_si=
ze(parent_bp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;hash_key_size =3D 40;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa &amp;=3D ~RTE_ETH_DEV_CAP=
A_FLOW_RULE_KEEP;<br>
<br></blockquote><div>We have not been testing the VMDq feature for sometim=
e, planning to deprecate this feature. Please remove this change.=C2=A0=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* MTU specifics */<br>
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/=
em_ethdev.c<br>
index 9e15e882b9..389744ad5e 100644<br>
--- a/drivers/net/intel/e1000/em_ethdev.c<br>
+++ b/drivers/net/intel/e1000/em_ethdev.c<br>
@@ -1175,6 +1175,7 @@ eth_em_infos_get(struct rte_eth_dev *dev, struct rte_=
eth_dev_info *dev_info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RTE_ETH_LINK_SPEED_100M_HD | RTE_ETH_LINK_SPEED_100M |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RTE_ETH_LINK_SPEED_1G;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa &amp;=3D ~RTE_ETH_DEV_CAP=
A_FLOW_RULE_KEEP;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Preferred queue parameters */<br>
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000=
/igb_ethdev.c<br>
index ef1599ac38..fe68c18417 100644<br>
--- a/drivers/net/intel/e1000/igb_ethdev.c<br>
+++ b/drivers/net/intel/e1000/igb_ethdev.c<br>
@@ -2324,6 +2324,7 @@ eth_igb_infos_get(struct rte_eth_dev *dev, struct rte=
_eth_dev_info *dev_info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;tx_queue_offload_capa =3D igb_get_=
tx_queue_offloads_capa(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;tx_offload_capa =3D igb_get_tx_por=
t_offloads_capa(dev) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;tx_queue_=
offload_capa;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa &amp;=3D ~RTE_ETH_DEV_CAP=
A_FLOW_RULE_KEEP;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (hw-&gt;mac.type) {<br>
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm1=
0k/fm10k_ethdev.c<br>
index 97f61afec2..037d2206fd 100644<br>
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c<br>
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c<br>
@@ -1444,6 +1444,7 @@ fm10k_dev_infos_get(struct rte_eth_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;speed_capa =3D RTE_ETH_LINK_SPEED_=
1G | RTE_ETH_LINK_SPEED_2_5G |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RTE_ETH_LINK_SPEED_40G | RTE_ETH_LINK_SPEED_100G;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/=
i40e_ethdev.c<br>
index 100a751225..64c29c6e85 100644<br>
--- a/drivers/net/intel/i40e/i40e_ethdev.c<br>
+++ b/drivers/net/intel/i40e/i40e_ethdev.c<br>
@@ -3878,7 +3878,8 @@ i40e_dev_info_get(struct rte_eth_dev *dev, struct rte=
_eth_dev_info *dev_info)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_DEV_CAPA_RU=
NTIME_RX_QUEUE_SETUP |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_DEV_CAPA_RU=
NTIME_TX_QUEUE_SETUP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_DEV_CAPA_RU=
NTIME_TX_QUEUE_SETUP |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_DEV_CAPA_VM=
DQ;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa &amp;=3D ~RTE_ETH_DEV_CAP=
A_FLOW_RULE_KEEP;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;hash_key_size =3D (I40E_PFQF_HKEY_=
MAX_INDEX + 1) *<br>
diff --git a/drivers/net/intel/i40e/i40e_vf_representor.c b/drivers/net/int=
el/i40e/i40e_vf_representor.c<br>
index e8f0bb62a0..d31148acb5 100644<br>
--- a/drivers/net/intel/i40e/i40e_vf_representor.c<br>
+++ b/drivers/net/intel/i40e/i40e_vf_representor.c<br>
@@ -33,6 +33,7 @@ i40e_vf_representor_dev_infos_get(struct rte_eth_dev *eth=
dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* get dev info for the vdev */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;device =3D ethdev-&gt;device;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa &amp;=3D ~RTE_ETH_DEV_CAP=
A_FLOW_RULE_KEEP;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;max_rx_queues =3D ethdev-&gt;data-=
&gt;nb_rx_queues;<br>
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/in=
tel/ipn3ke/ipn3ke_representor.c<br>
index cd34d08055..d581ee3c37 100644<br>
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c<br>
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c<br>
@@ -95,7 +95,8 @@ ipn3ke_rpst_dev_infos_get(struct rte_eth_dev *ethdev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_DEV_CAPA_RU=
NTIME_RX_QUEUE_SETUP |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_DEV_CAPA_RU=
NTIME_TX_QUEUE_SETUP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_DEV_CAPA_RU=
NTIME_TX_QUEUE_SETUP |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_DEV_CAPA_VM=
DQ;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa &amp;=3D ~RTE_ETH_DEV_CAP=
A_FLOW_RULE_KEEP;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;<a href=3D"http://switch_info.name=
" rel=3D"noreferrer" target=3D"_blank">switch_info.name</a> =3D ethdev-&gt;=
device-&gt;name;<br>
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixg=
be/ixgbe_ethdev.c<br>
index 57d929cf2c..5d886b3e28 100644<br>
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c<br>
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c<br>
@@ -3997,6 +3997,7 @@ ixgbe_dev_info_get(struct rte_eth_dev *dev, struct rt=
e_eth_dev_info *dev_info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;max_mtu =3D=C2=A0 dev_info-&gt;max=
_rx_pktlen - IXGBE_ETH_OVERHEAD;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;min_mtu =3D RTE_ETHER_MIN_MTU;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;vmdq_queue_num =3D dev_info-&gt;ma=
x_rx_queues;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;rx_queue_offload_capa =3D ixgbe_ge=
t_rx_queue_offloads(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;rx_offload_capa =3D (ixgbe_get_rx_=
port_offloads(dev) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;rx_=
queue_offload_capa);<br>
@@ -4115,6 +4116,7 @@ ixgbevf_dev_info_get(struct rte_eth_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;max_vm=
dq_pools =3D RTE_ETH_16_POOLS;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;max_vm=
dq_pools =3D RTE_ETH_64_POOLS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;rx_queue_offload_capa =3D ixgbe_ge=
t_rx_queue_offloads(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;rx_offload_capa =3D (ixgbe_get_rx_=
port_offloads(dev) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;rx_=
queue_offload_capa);<br>
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_eth=
dev.c<br>
index 5d360f8305..bd818e8269 100644<br>
--- a/drivers/net/txgbe/txgbe_ethdev.c<br>
+++ b/drivers/net/txgbe/txgbe_ethdev.c<br>
@@ -2836,6 +2836,7 @@ txgbe_dev_info_get(struct rte_eth_dev *dev, struct rt=
e_eth_dev_info *dev_info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;max_vfs =3D pci_dev-&gt;max_vfs;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;max_vmdq_pools =3D RTE_ETH_64_POOL=
S;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;vmdq_queue_num =3D dev_info-&gt;ma=
x_rx_queues;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa &amp;=3D ~RTE_ETH_DEV_CAP=
A_FLOW_RULE_KEEP;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;rx_queue_offload_capa =3D txgbe_ge=
t_rx_queue_offloads(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;rx_offload_capa =3D (txgbe_get_rx_=
port_offloads(dev) |<br>
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_=
ethdev_vf.c<br>
index 39a5fff65c..934763574c 100644<br>
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c<br>
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c<br>
@@ -572,6 +572,7 @@ txgbevf_dev_info_get(struct rte_eth_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;max_hash_mac_addrs =3D TXGBE_VMDQ_=
NUM_UC_MAC;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;max_vfs =3D pci_dev-&gt;max_vfs;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;max_vmdq_pools =3D RTE_ETH_64_POOL=
S;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;dev_capa =3D RTE_ETH_DEV_CAPA_VMDQ=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;dev_capa &amp;=3D ~RTE_ETH_DEV_CAP=
A_FLOW_RULE_KEEP;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;rx_queue_offload_capa =3D txgbe_ge=
t_rx_queue_offloads(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info-&gt;rx_offload_capa =3D (txgbe_get_rx_=
port_offloads(dev) |<br>
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c<br>
index 9577b7d848..7ba539e796 100644<br>
--- a/lib/ethdev/rte_ethdev.c<br>
+++ b/lib/ethdev/rte_ethdev.c<br>
@@ -158,6 +158,7 @@ static const struct {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {RTE_ETH_DEV_CAPA_RXQ_SHARE, &quot;RXQ_SHARE&qu=
ot;},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP, &quot;FLOW_RU=
LE_KEEP&quot;},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP, &quo=
t;FLOW_SHARED_OBJECT_KEEP&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{RTE_ETH_DEV_CAPA_VMDQ, &quot;VMDQ&quot;},<br>
=C2=A0};<br>
<br>
=C2=A0enum {<br>
@@ -1581,6 +1582,22 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_=
rx_q, uint16_t nb_tx_q,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto rollback;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(dev_info.dev_capa &amp; RTE_ETH_DEV_CAPA_=
VMDQ)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((dev_conf-&gt;r=
xmode.mq_mode &amp; RTE_ETH_MQ_RX_VMDQ_FLAG) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RTE_ETHDEV_LOG_LINE(ERR, &quot;Ethdev port_id=3D%u does not suppo=
rt VMDq rx mode&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto rollback;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev_conf-&gt;tx=
mode.mq_mode =3D=3D RTE_ETH_MQ_TX_VMDQ_DCB ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_conf-&gt;txmode.mq_mode =3D=3D RT=
E_ETH_MQ_TX_VMDQ_ONLY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RTE_ETHDEV_LOG_LINE(ERR, &quot;Ethdev port_id=3D%u does not suppo=
rt VMDq tx mode&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto rollback;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Setup new number of Rx/Tx queues and re=
configure device.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h<br>
index 0d8e2d0236..62c72de0e5 100644<br>
--- a/lib/ethdev/rte_ethdev.h<br>
+++ b/lib/ethdev/rte_ethdev.h<br>
@@ -1696,6 +1696,8 @@ struct rte_eth_conf {<br>
=C2=A0#define RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0RTE_BIT64(3)<br>
=C2=A0/** Device supports keeping shared flow objects across restart. */<br=
>
=C2=A0#define RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP RTE_BIT64(4)<br>
+/** Device supports VMDq. */<br>
+#define RTE_ETH_DEV_CAPA_VMDQ RTE_BIT64(5)<br>
=C2=A0/**@}*/<br>
<br>
=C2=A0/*<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div></div>

--000000000000fb706a064ed2199d--

--0000000000000afba8064ed21a52
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGpzCCBI+g
AwIBAgIMTxuM8PbwRQIs9uJeMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTIxOFoXDTI3MDYyMTEzNTIxOFowgekxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKUGFkbWFuYWJoYTEQMA4GA1UEKhMHS2lzaG9yZTEWMBQGA1UEChMNQlJP
QURDT00gSU5DLjEoMCYGA1UEAwwfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTEuMCwG
CSqGSIb3DQEJARYfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALtFWP+ax39qiJZsJuukdoqMyp0GWGaJ6MdaHvAxXWiEY5zmTiVU
QnpmNYp5SO1Cd1cBqDB0dcelQbiQ1qh+lnlUchJLR63y0ysUvUNvqV493q8+pHCm/2jPb0/R9rec
/jxwM9jaPAVkhGBwvudSfOAQlMPORtAHZyLHKFINcsNfLrGP/3lx+zj30v5tmDN7isOLWos7Jm/U
qRdC7UuUiXgX7q8xXd1MQlA95O73IY/Qb/y0ChEjGPb+U1wr+OsAWJ5fcjQXA/ffBb2GmMp9OUOs
wVNq8iHfie9nzNaaRw+yoyn0ovoiq2W3Q6r+U53ha/lz0itqCrJZN+G0MFf+cX8CAwEAAaOCAeMw
ggHfMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggr
BgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1l
Y2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2Ny
NnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGg
MgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5
LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKgYDVR0RBCMwIYEfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNV
HQ4EFgQURIyot+ZP/mdwQsofZexqAvOm5pMwDQYJKoZIhvcNAQELBQADggIBAKc5gYnhyTf+f6cm
kAHy1a4cLIWou43yaS+M/r69Pv44EVYvHxqt0mMvKh3U40Y+pHKph+VCjdoINKCd1SaqAFIqqEO4
XHWrFi3QAI3snUB6spPIoHN/srAcpX9tdrnAlyK593pq+H+mTMoFIGBP/oc8XCtaDgHp37rpuK9Q
qhF9h5cEJWgShmD7/Q02YydW3jsioy8HdTUD9fib1fRwiSc9uGq8JV5NJsYiJsi9FUz7kTUPohO0
h6U9tRUVmAf9gPbU46rin9By5X4Lt1jKge5O0vFEawCTr/pLmDcIf7CqRZfBoNalKOsBDovoeAOf
pXmQzQEMhnaf93MvbFvZaxC9Ir92DR45BH42xZuLKcQVUsqyLKwC6kEZg81AnZsRAUVpMvqiGbVb
hZnabsHragNY7Br3VCA2OaWk9yRRjt1UwzfIEEMNWqZeQzzAqKIR3XdXIrqAUlMQOX42tSV9FaIv
PSmR3uaH2M0/bRtz4TE1qRuTsLlr+XEGMxHssK7u7+WYM7EGF3ueZLcE7WmnwXEFli5Y5QX0SnmT
W8uDQvdvRdxXg4lkBLyifOudYTP3fULjpD6RWQPFlUPlh8F5QQEdKlfKW94rGD+O0u4sWi/msZw0
6VTvZ6C2BbUMJAo7coFff48NkW2xfICC8Kn1eU1eiWCrPSAls8STm9q25wOQMYICVzCCAlMCAQEw
YjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xv
YmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMTxuM8PbwRQIs9uJeMA0GCWCGSAFlAwQCAQUA
oIHHMC8GCSqGSIb3DQEJBDEiBCBwJngx6k8LY1xXvkoB797EUrsGqcp5vXzE5U5VWJo3XTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MDYyMjIyMjdaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBK3eGTXYZu
drPAaF3laqSfaX64A8JZ3etE05b2kdPpoeh9qXruDp1eANoPk0BHSSdV/0WcfOXeiVE5MPwiZRWQ
xen0LoJjoKENKg6X+if1gola2yNZ2LNG+QcPyO6VllzKcfecIGdxBDtw+Ajt9tG2F7JhAxGytd6q
n56L6k45rW+czkEQW8TVexthUWI9/3lc4qU889inkAFON45eS4A4f/y4hO2h5urCdn/8U9copWzn
Io3atb/oG3Zx2EmhYMli/BhVy2BpZRiavztHmaIeHreP7gFofrL9t41PTlnAdWkO6bAPnV1yFN8B
HrEk/U3psOwOAEl6j2p/7gpNv5VM
--0000000000000afba8064ed21a52--
