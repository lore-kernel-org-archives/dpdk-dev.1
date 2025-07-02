Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9170BC8303F
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 12:17:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D793402E8;
	Wed,  2 Jul 2025 14:17:28 +0200 (CEST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by mails.dpdk.org (Postfix) with ESMTP id 4C60F402A0
 for <dev@dpdk.org>; Wed,  2 Jul 2025 14:17:26 +0200 (CEST)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-408e0986303so2698696b6e.2
 for <dev@dpdk.org>; Wed, 02 Jul 2025 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751458645; x=1752063445; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfSTCKtrpzOgdapUrpQAjUjIurI3DeUbDt7DxRjHVAg=;
 b=fZIJn6L0CcFjx0xtlaw9TYVE7Ik8/P2AMaLAsXnAtIaUDI4n+P2uNrs3lJvRIEEqQf
 xIxXbYwKHRW6zK7sciCpIFSw484FHnb49oi43PWG93yxN6mvjwiDlM2nKk9o68Ndi3jW
 rIuImls2+LpQEzwVqW3W6sxid2+VO+0SBRxo+sdhLw82OakvQjKygkGw/HhHhZWUg4oG
 omewglanqWGN0gU/E1684pW3MUFOnSXQGdp3xNB7hkehq7l+Q5/oi+L+m1iiMsJnbRRN
 Qy45531kiA+a6pLg3nVpQPeBMqKlorCFF5bLkS+Gc3v9gDF1T7IAh+M0HkFrBGqHtU3E
 pzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458645; x=1752063445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfSTCKtrpzOgdapUrpQAjUjIurI3DeUbDt7DxRjHVAg=;
 b=K7giPBKFoAlJxQmAL2G8Ysx5sTbWmF0ushbziyMiIoGqYV5L8iXA1RnCrX6KERDurz
 JvWzYX0W+mb/jN24upHgPxvJgno3lGkv8fLM4wfQs1IqG3DBGGVTs56GZV4W5EB8w0oZ
 67+tv2TQTZG8RyND0GJsMLnj4KoVx91LBeyOuKdcZCzdX5JAnEHcVOWAcCYmv5Vozp78
 H+SxkdJoC69FFdRdULiBGrLBd9FsdMF4n0KPneBqdFy/vAq4P+Lgw1HkU9VQAJIlZVxi
 yptUZo5uxfSK66BPSXm0iONEhV50mKQHbeXSM9D9eGhqt9mZxz30N1GdEqmviNhS+EPB
 An8A==
X-Gm-Message-State: AOJu0YzENlZGLwMjsvSiLZJdq7livuQGtbkdpusL7zM+hVmWRD7fNkux
 h5TbfeIn9/UNVUUZHXJj7kpy9QB8FbClorLjJFqwYU44iidy3FHk9ReEt6bTKqFmxb7nzeLDxh6
 Yxr9He2GQ6oDd+HSaoPSls0JyaY0ffa5XAVmSERE=
X-Gm-Gg: ASbGncu4voBclX0pu6nss4/sexbanzIWPL5pZ7HPgoxCHt/u6hRQMKueMbGwByuxeqG
 ovOFL1DPL8nde7DasI+sfQkFIKOmveU14qyqyVPahGycgtl8RVI8hBS7PWuLp/Yo/shSPlasOVs
 K4uk0uG5ejusFLUUUYxp6Ab2Jm8XXunoZcA+/3yqKM2gSypYD1kWlUww==
X-Google-Smtp-Source: AGHT+IGCKxNp83uocNo1szR1OYdva/xZ3oZuwSGVGReBggxCMq4pLMjIp26tqWLenbYuKcm0kxCHcaKQSWMyQVx67VI=
X-Received: by 2002:a05:6808:1b25:b0:409:f8e:7282 with SMTP id
 5614622812f47-40b887a360amr1835921b6e.5.1751458645128; Wed, 02 Jul 2025
 05:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250619115445.257679-1-hengqi.chen@gmail.com>
In-Reply-To: <20250619115445.257679-1-hengqi.chen@gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 2 Jul 2025 20:17:14 +0800
X-Gm-Features: Ac12FXy6lDRSgBXlefnSWZUe7aYSUwzjnlMGrTZgrCxyN00GMmRmsBzuqyO2Pjc
Message-ID: <CAEyhmHRs6mwW-uc8XzK6HKRNn8ZnyMrpiBsQE7fdSsMuhxqrUA@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: Implement {rxq,txq}_info_get callbacks
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
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

Hi Maxime, Chenbo,

Gentle ping on this. Does this change make sense ?

On Thu, Jun 19, 2025 at 7:55=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> Currently, there are no ways to retrieve the queue size
> set by vhost backend. Implement the {rxq,txq}_info_get
> callbacks so that DPDK applications can use the queue
> size to setup mempool properly.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  drivers/net/virtio/virtio_ethdev.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virt=
io_ethdev.c
> index 2d2635b669..b61d251814 100644
> --- a/drivers/net/virtio/virtio_ethdev.c
> +++ b/drivers/net/virtio/virtio_ethdev.c
> @@ -616,6 +616,28 @@ virtio_dev_priv_dump(struct rte_eth_dev *dev, FILE *=
f)
>         return 0;
>  }
>
> +static void
> +virtio_rxq_info_get(struct rte_eth_dev *dev, uint16_t rx_queue_id,
> +                   struct rte_eth_rxq_info *qinfo)
> +{
> +       uint16_t vq_idx =3D 2 * rx_queue_id + VTNET_SQ_RQ_QUEUE_IDX;
> +       struct virtio_hw *hw =3D dev->data->dev_private;
> +       struct virtqueue *vq =3D hw->vqs[vq_idx];
> +
> +       qinfo->nb_desc =3D vq->vq_nentries;
> +}
> +
> +static void
> +virtio_txq_info_get(struct rte_eth_dev *dev, uint16_t tx_queue_id,
> +                   struct rte_eth_txq_info *qinfo)
> +{
> +       uint16_t vq_idx =3D 2 * tx_queue_id + VTNET_SQ_TQ_QUEUE_IDX;
> +       struct virtio_hw *hw =3D dev->data->dev_private;
> +       struct virtqueue *vq =3D hw->vqs[vq_idx];
> +
> +       qinfo->nb_desc =3D vq->vq_nentries;
> +}
> +
>  /*
>   * dev_ops for virtio, bare necessities for basic operation
>   */
> @@ -630,6 +652,8 @@ static const struct eth_dev_ops virtio_eth_dev_ops =
=3D {
>         .allmulticast_disable    =3D virtio_dev_allmulticast_disable,
>         .mtu_set                 =3D virtio_mtu_set,
>         .dev_infos_get           =3D virtio_dev_info_get,
> +       .rxq_info_get            =3D virtio_rxq_info_get,
> +       .txq_info_get            =3D virtio_txq_info_get,
>         .stats_get               =3D virtio_dev_stats_get,
>         .xstats_get              =3D virtio_dev_xstats_get,
>         .xstats_get_names        =3D virtio_dev_xstats_get_names,
> --
> 2.43.5
>
