Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE88BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 09:35:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64B514028D;
	Wed, 28 May 2025 11:35:51 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 39FB840279
 for <dev@dpdk.org>; Wed, 28 May 2025 11:35:50 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E55692076F;
 Wed, 28 May 2025 11:35:49 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 2/2] ethdev: remove callback checks from fast path
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 28 May 2025 11:35:48 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC9E@smartserver.smartshare.dk>
In-Reply-To: <20250512150732.65743-2-skori@marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 2/2] ethdev: remove callback checks from fast path
Thread-Index: AdvDT6dtNl1iyDDXR46COnveyler+wMYgcTw
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
 <20250512150732.65743-2-skori@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Sunil Kumar Kori" <skori@marvell.com>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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

> From: Sunil Kumar Kori <skori@marvell.com>
> Sent: Monday, 12 May 2025 17.07
>=20
> rte_eth_fp_ops contains ops for fast path APIs. Each API
> validates availability of callback and then invoke it.
> These checks impact data path performace.

Picking up the discussion from another thread [1]:

> From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> Sent: Wednesday, 28 May 2025 11.14
>=20
> So what we are saving with that patch: one cmp and one un-taken =
branch:
> @@ -6399,8 +6399,6 @@ rte_eth_rx_queue_count(uint16_t port_id, =
uint16_t
> queue_id)
>  		return -EINVAL;
>  #endif
>=20
> -	if (p->rx_queue_count =3D=3D NULL)
> -		return -ENOTSUP;
>  	return p->rx_queue_count(qd);
>  }

These are inline functions, so we also save some code space, instruction =
cache, and possibly an entry in the branch predictor - everywhere these =
functions are instantiated by the compiler.

>=20
> I wonder is how realistic (and measurable) is the gain?

The performance optimization is mainly targeting the mbuf recycle =
operations, i.e. the hot fast path, where every cycle counts.
And while optimizing those, the other ethdev fast path callbacks are =
also optimized.

Yes, although we all agree that there is no downside to this =
optimization, it would be nice to see some performance numbers.

[1]: =
https://inbox.dpdk.org/dev/581e7a5389f842a9824a365a46c470ad@huawei.com/

>=20
> Hence removing these NULL checks instead using dummy
> callbacks.
>=20
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---
>  lib/ethdev/ethdev_driver.c | 55 +++++++++++++++++++++++++++++
>  lib/ethdev/ethdev_driver.h | 71 =
++++++++++++++++++++++++++++++++++++++
>  lib/ethdev/rte_ethdev.h    | 29 ++--------------
>  3 files changed, 129 insertions(+), 26 deletions(-)
>=20
> diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
> index ec0c1e1176..f89562b237 100644
> --- a/lib/ethdev/ethdev_driver.c
> +++ b/lib/ethdev/ethdev_driver.c
> @@ -75,6 +75,20 @@ eth_dev_get(uint16_t port_id)
>  	return eth_dev;
>  }
>=20
> +static void
> +eth_dev_set_dummy_fops(struct rte_eth_dev *eth_dev)
> +{
> +	eth_dev->rx_pkt_burst =3D rte_eth_pkt_burst_dummy;
> +	eth_dev->tx_pkt_burst =3D rte_eth_pkt_burst_dummy;
> +	eth_dev->tx_pkt_prepare =3D rte_eth_tx_pkt_prepare_dummy;
> +	eth_dev->rx_queue_count =3D rte_eth_queue_count_dummy;
> +	eth_dev->tx_queue_count =3D rte_eth_queue_count_dummy;
> +	eth_dev->rx_descriptor_status =3D rte_eth_descriptor_status_dummy;
> +	eth_dev->tx_descriptor_status =3D rte_eth_descriptor_status_dummy;
> +	eth_dev->recycle_tx_mbufs_reuse =3D
> rte_eth_recycle_tx_mbufs_reuse_dummy;
> +	eth_dev->recycle_rx_descriptors_refill =3D
> rte_eth_recycle_rx_descriptors_refill_dummy;
> +}
> +
>  RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_allocate)
>  struct rte_eth_dev *
>  rte_eth_dev_allocate(const char *name)
> @@ -115,6 +129,7 @@ rte_eth_dev_allocate(const char *name)
>  	}
>=20
>  	eth_dev =3D eth_dev_get(port_id);
> +	eth_dev_set_dummy_fops(eth_dev);
>  	eth_dev->flow_fp_ops =3D &rte_flow_fp_default_ops;
>  	strlcpy(eth_dev->data->name, name, sizeof(eth_dev->data->name));
>  	eth_dev->data->port_id =3D port_id;
> @@ -847,6 +862,46 @@ rte_eth_pkt_burst_dummy(void *queue __rte_unused,
>  	return 0;
>  }
>=20
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_tx_pkt_prepare_dummy)
> +uint16_t
> +rte_eth_tx_pkt_prepare_dummy(void *queue __rte_unused,
> +		struct rte_mbuf **pkts __rte_unused,
> +		uint16_t nb_pkts)
> +{
> +	return nb_pkts;
> +}
> +
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_queue_count_dummy)
> +int
> +rte_eth_queue_count_dummy(void *queue __rte_unused)
> +{
> +	return -ENOTSUP;
> +}
> +
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_descriptor_status_dummy)
> +int
> +rte_eth_descriptor_status_dummy(void *queue __rte_unused,
> +		uint16_t offset __rte_unused)
> +{
> +	return -ENOTSUP;
> +}
> +
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_recycle_tx_mbufs_reuse_dummy)
> +uint16_t
> +rte_eth_recycle_tx_mbufs_reuse_dummy(void *queue __rte_unused,
> +		struct rte_eth_recycle_rxq_info *recycle_rxq_info
> __rte_unused)
> +{
> +	return 0;
> +}
> +
> =
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_recycle_rx_descriptors_refill_dummy
> )
> +void
> +rte_eth_recycle_rx_descriptors_refill_dummy(void *queue __rte_unused,
> +		uint16_t nb __rte_unused)
> +{
> +	/* No action. */
> +}
> +
>  RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_representor_id_get)
>  int
>  rte_eth_representor_id_get(uint16_t port_id,
> diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
> index 2b4d2ae9c3..71085bddff 100644
> --- a/lib/ethdev/ethdev_driver.h
> +++ b/lib/ethdev/ethdev_driver.h
> @@ -1874,6 +1874,77 @@ rte_eth_pkt_burst_dummy(void *queue
> __rte_unused,
>  		struct rte_mbuf **pkts __rte_unused,
>  		uint16_t nb_pkts __rte_unused);
>=20
> +/**
> + * @internal
> + * Dummy DPDK callback for Tx packet prepare.
> + *
> + * @param queue
> + *  Pointer to Tx queue
> + * @param pkts
> + *  Packet array
> + * @param nb_pkts
> + *  Number of packets in packet array
> + */
> +__rte_internal
> +uint16_t
> +rte_eth_tx_pkt_prepare_dummy(void *queue __rte_unused,
> +		struct rte_mbuf **pkts __rte_unused,
> +		uint16_t nb_pkts __rte_unused);
> +
> +/**
> + * @internal
> + * Dummy DPDK callback for queue count.
> + *
> + * @param queue
> + *  Pointer to Rx/Tx queue
> + */
> +__rte_internal
> +int
> +rte_eth_queue_count_dummy(void *queue __rte_unused);
> +
> +/**
> + * @internal
> + * Dummy DPDK callback for descriptor status.
> + *
> + * @param queue
> + *  Pointer to Rx/Tx queue
> + * @param offset
> + *  The offset of the descriptor starting from tail (0 is the next
> + *  packet to be received by the driver).
> + */
> +__rte_internal
> +int
> +rte_eth_descriptor_status_dummy(void *queue __rte_unused,
> +		uint16_t offset __rte_unused);
> +
> +/**
> + * @internal
> + * Dummy DPDK callback for recycle Tx mbufs reuse.
> + *
> + * @param queue
> + *  Pointer to Tx queue
> + * @param recycle_rxq_info
> + *  Pointer to recycle Rx queue info
> + */
> +__rte_internal
> +uint16_t
> +rte_eth_recycle_tx_mbufs_reuse_dummy(void *queue __rte_unused,
> +		struct rte_eth_recycle_rxq_info *recycle_rxq_info
> __rte_unused);
> +
> +/**
> + * @internal
> + * Dummy DPDK callback Rx descriptor refill.
> + *
> + * @param queue
> + *  Pointer Rx queue
> + * @param offset
> + *  number of descriptors to refill
> + */
> +__rte_internal
> +void
> +rte_eth_recycle_rx_descriptors_refill_dummy(void *queue __rte_unused,
> +		uint16_t nb __rte_unused);
> +
>  /**
>   * Allocate an unique switch domain identifier.
>   *
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index b3031ab9e6..2034680560 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -6399,8 +6399,6 @@ rte_eth_rx_queue_count(uint16_t port_id, =
uint16_t
> queue_id)
>  		return -EINVAL;
>  #endif
>=20
> -	if (p->rx_queue_count =3D=3D NULL)
> -		return -ENOTSUP;
>  	return p->rx_queue_count(qd);
>  }
>=20
> @@ -6471,8 +6469,6 @@ rte_eth_rx_descriptor_status(uint16_t port_id,
> uint16_t queue_id,
>  	if (qd =3D=3D NULL)
>  		return -ENODEV;
>  #endif
> -	if (p->rx_descriptor_status =3D=3D NULL)
> -		return -ENOTSUP;
>  	return p->rx_descriptor_status(qd, offset);
>  }
>=20
> @@ -6542,8 +6538,6 @@ static inline int
> rte_eth_tx_descriptor_status(uint16_t port_id,
>  	if (qd =3D=3D NULL)
>  		return -ENODEV;
>  #endif
> -	if (p->tx_descriptor_status =3D=3D NULL)
> -		return -ENOTSUP;
>  	return p->tx_descriptor_status(qd, offset);
>  }
>=20
> @@ -6786,9 +6780,6 @@ rte_eth_tx_prepare(uint16_t port_id, uint16_t
> queue_id,
>  	}
>  #endif
>=20
> -	if (!p->tx_pkt_prepare)
> -		return nb_pkts;
> -
>  	return p->tx_pkt_prepare(qd, tx_pkts, nb_pkts);
>  }
>=20
> @@ -6985,8 +6976,6 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id,
> uint16_t rx_queue_id,
>  		return 0;
>  	}
>  #endif
> -	if (p1->recycle_tx_mbufs_reuse =3D=3D NULL)
> -		return 0;
>=20
>  #ifdef RTE_ETHDEV_DEBUG_RX
>  	if (rx_port_id >=3D RTE_MAX_ETHPORTS ||
> @@ -7010,8 +6999,6 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id,
> uint16_t rx_queue_id,
>  		return 0;
>  	}
>  #endif
> -	if (p2->recycle_rx_descriptors_refill =3D=3D NULL)
> -		return 0;
>=20
>  	/* Copy used *rte_mbuf* buffer pointers from Tx mbuf ring
>  	 * into Rx mbuf ring.
> @@ -7107,15 +7094,13 @@ rte_eth_tx_queue_count(uint16_t port_id,
> uint16_t queue_id)
>  #ifdef RTE_ETHDEV_DEBUG_TX
>  	if (port_id >=3D RTE_MAX_ETHPORTS ||
> !rte_eth_dev_is_valid_port(port_id)) {
>  		RTE_ETHDEV_LOG_LINE(ERR, "Invalid port_id=3D%u", port_id);
> -		rc =3D -ENODEV;
> -		goto out;
> +		return -ENODEV;
>  	}
>=20
>  	if (queue_id >=3D RTE_MAX_QUEUES_PER_PORT) {
>  		RTE_ETHDEV_LOG_LINE(ERR, "Invalid queue_id=3D%u for
> port_id=3D%u",
>  				    queue_id, port_id);
> -		rc =3D -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}
>  #endif
>=20
> @@ -7127,18 +7112,10 @@ rte_eth_tx_queue_count(uint16_t port_id,
> uint16_t queue_id)
>  	if (qd =3D=3D NULL) {
>  		RTE_ETHDEV_LOG_LINE(ERR, "Invalid queue_id=3D%u for
> port_id=3D%u",
>  				    queue_id, port_id);
> -		rc =3D -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}
>  #endif
> -	if (fops->tx_queue_count =3D=3D NULL) {
> -		rc =3D -ENOTSUP;
> -		goto out;
> -	}
> -
>  	rc =3D fops->tx_queue_count(qd);
> -
> -out:
>  	rte_eth_trace_tx_queue_count(port_id, queue_id, rc);
>  	return rc;
>  }
> --
> 2.43.0

