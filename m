Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81CDC7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:06:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC3940287;
	Thu, 26 Jun 2025 16:06:01 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id D53C740156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:06:00 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so992609b3a.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750946760;
 x=1751551560; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+POI6ZAdtTP4H/VSbv52T5upuiQJ9yHXrp1XoTqgXg=;
 b=k3qcQNHlK3RnNCNZ2w50ey6fby8+A1jhFI9ismg14hqui//TCIHEeSCfLOJMbHJivH
 ihWE10AZge/vMV5Eg18GNiTYY+8/Ra8DbCQrgG9Xk9gUZqCcvR4f25iw3AXWsrbjqyzt
 P569Siy9SWDrwga9rCAKyczB2/JPXK2uMNNWwGEcwpO3tkgbg3qUXoPzeLI0QkjuLKAz
 dXtELtHaueJqOFLsWujZdNbMcxbTRzyaBAX5fepN6FUIKhYX+gbl77vyU++aAAZHYr1o
 8xJLgStaCl0rOI+GpZoulMX3LV2v3y1hmLt5poiOxUNaO8DGGEgRtIOiB4Hqdq0Rw+K9
 bvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750946760; x=1751551560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+POI6ZAdtTP4H/VSbv52T5upuiQJ9yHXrp1XoTqgXg=;
 b=rWQpkXuXGvUaEn4MQ0bW/JUw8lO7AHPMxYlXxOeYhUlREVZml4srkxAjqJ7LRxrzyD
 kGy5cMW1bAIAkgCXFatY7mIwXTNDshnULX9Bn2/EUAtpLfsCwDCdDXN2ZZB4icfg8jor
 PvYHbgyQcQ1Ay6TqseBbSpVtmgS7S4WzOBeETj+qvT0tSfvSk1L3sJjmgvWcUVCwZzCC
 4oYP46nqLjG/mRrO7vSK6zEK5QV5pJgBvuomSy7LgFkSSanrpzecGLXV+ddOdu2xGyLI
 GikT/Cm6fvcc2yIh5MzvFZOH4GWMQVYB79sguX1oue8YDvJ4S3Ujx12ORCnG6ljFp/N9
 btkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOBAVIDSR3Wdp3B09QFMEgouRZWpEWqhBTRb3nTJtmVVF0ge3Hzy8P+NlxEbdVawk6/ls=@dpdk.org
X-Gm-Message-State: AOJu0YzZK6MTgImzcwhZZSyD2TwKZ1LpnpREzmMGm9PsejqK+BtSP+x5
 dQaVCW1dAxjkOcQQvcCVjXookcHMP1X/zLtVrrcUp041LP3cUlxR3rDCvu+74FHMfnI=
X-Gm-Gg: ASbGncuheyT99Jl1TfHkfJRtna75bsQ50I5J5+OvWJLFxHs3DKLxLkMgzNIaz1pZRET
 IzFOzRfE4GU0ZLvY81bV0KEVnB0PujC+9FbPoqXAHueUVjsIpSx8FdTy/8708NRZUebduLPwUFX
 IcCM0OUUdZCYPfSxhFZisDi5ia2jo3tgBr5qD4La3cGkP29l/FQpFWQuL0rGVe1weOOa7GxcuxM
 OtJsdC8C3o56E5niW98P62Q9RT1yEzBPtBlTr602sHntuuCCkO0jlQQXDRCRTflRFSFcgVM9Bnc
 76Jy3y6jteFmduY+0XgjZX1zx4TpfeWNr9L1i1VLCSDGGDP0dr07WWhI3AcAzrNs7xDJRhgrSKy
 0T+wSWEvpJpHvIR0YAgEDdGW+AhTdpdSyVdoQT1jg6xLr2nLk3Q==
X-Google-Smtp-Source: AGHT+IFEKZtABVAUxb68xvD6ZbcDPnHtyJQnKmnELUYz3EUjrjE1zNmKjt1FaFYaxbZeX/dff6ivTA==
X-Received: by 2002:a05:6a00:2411:b0:736:5969:2b6f with SMTP id
 d2e1a72fcca58-74ae3ec00dfmr4829628b3a.6.1750946759803; 
 Thu, 26 Jun 2025 07:05:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e435c5sm7284090b3a.67.2025.06.26.07.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 07:05:59 -0700 (PDT)
Date: Thu, 26 Jun 2025 07:05:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Tetsuya Mukawa <mtetsuyah@gmail.com>, dev@dpdk.org
Subject: Re: [PATCH] net/null: Add fast mbuf release TX offload
Message-ID: <20250626070557.33058157@hermes.local>
In-Reply-To: <20250624181416.167181-1-mb@smartsharesystems.com>
References: <20250624181416.167181-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 24 Jun 2025 18:14:16 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Added fast mbuf release, re-using the existing mbuf pool pointer
> in the queue structure.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Makes sense.

> ---
>  drivers/net/null/rte_eth_null.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_n=
ull.c
> index 8a9b74a03b..12c0d8d1ff 100644
> --- a/drivers/net/null/rte_eth_null.c
> +++ b/drivers/net/null/rte_eth_null.c
> @@ -34,6 +34,17 @@ struct pmd_internals;
>  struct null_queue {
>  	struct pmd_internals *internals;
> =20
> +	/**
> +	 * For RX queue:
> +	 *  Mempool to allocate mbufs from.
> +	 *
> +	 * For TX queue:
> +	 *  Mempool to free mbufs to, if fast release of mbufs is enabled.
> +	 *  UINTPTR_MAX if the mempool for fast release of mbufs has not yet be=
en detected.
> +	 *  NULL if fast release of mbufs is not enabled.
> +	 *
> +	 *  @see RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
> +	 */
>  	struct rte_mempool *mb_pool;

Do all drivers to it this way?
Is it documented in ethdev?

>  	void *dummy_packet;
> =20
> @@ -151,7 +162,16 @@ eth_null_tx(void *q, struct rte_mbuf **bufs, uint16_=
t nb_bufs)
>  	for (i =3D 0; i < nb_bufs; i++)
>  		bytes +=3D rte_pktmbuf_pkt_len(bufs[i]);
> =20
> -	rte_pktmbuf_free_bulk(bufs, nb_bufs);
> +	if (h->mb_pool !=3D NULL) { /* RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE */
> +		if (unlikely(h->mb_pool =3D=3D (void *)UINTPTR_MAX)) {
> +			if (unlikely(nb_bufs =3D=3D 0))
> +				return 0; /* Do not dereference uninitialized bufs[0]. */
> +			h->mb_pool =3D bufs[0]->pool;
> +		}
> +		rte_mbuf_raw_free_bulk(h->mb_pool, bufs, nb_bufs);
> +	} else {
> +		rte_pktmbuf_free_bulk(bufs, nb_bufs);
> +	}
>  	rte_atomic_fetch_add_explicit(&h->tx_pkts, nb_bufs, rte_memory_order_re=
laxed);
>  	rte_atomic_fetch_add_explicit(&h->tx_bytes, bytes, rte_memory_order_rel=
axed);
> =20
> @@ -259,7 +279,7 @@ static int
>  eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
>  		uint16_t nb_tx_desc __rte_unused,
>  		unsigned int socket_id __rte_unused,
> -		const struct rte_eth_txconf *tx_conf __rte_unused)
> +		const struct rte_eth_txconf *tx_conf)
>  {
>  	struct rte_mbuf *dummy_packet;
>  	struct pmd_internals *internals;
> @@ -284,6 +304,9 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t =
tx_queue_id,
> =20
>  	internals->tx_null_queues[tx_queue_id].internals =3D internals;
>  	internals->tx_null_queues[tx_queue_id].dummy_packet =3D dummy_packet;
> +	internals->tx_null_queues[tx_queue_id].mb_pool =3D
> +			tx_conf->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
> +			(void *)UINTPTR_MAX : NULL;
> =20
>  	return 0;
>  }
> @@ -309,7 +332,8 @@ eth_dev_info(struct rte_eth_dev *dev,
>  	dev_info->max_rx_queues =3D RTE_DIM(internals->rx_null_queues);
>  	dev_info->max_tx_queues =3D RTE_DIM(internals->tx_null_queues);
>  	dev_info->min_rx_bufsize =3D 0;
> -	dev_info->tx_offload_capa =3D RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_T=
X_OFFLOAD_MT_LOCKFREE;
> +	dev_info->tx_offload_capa =3D RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
> +			RTE_ETH_TX_OFFLOAD_MT_LOCKFREE | RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
> =20
>  	dev_info->reta_size =3D internals->reta_size;
>  	dev_info->flow_type_rss_offloads =3D internals->flow_type_rss_offloads;

