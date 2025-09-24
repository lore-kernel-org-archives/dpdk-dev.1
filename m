Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9436ACAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 07:37:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E5FD40289;
	Wed, 24 Sep 2025 09:37:21 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7850B4027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:37:20 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1CB0D205C8;
 Wed, 24 Sep 2025 09:37:20 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH 3/6] ethdev: remove queue stats from ethdev stats
 structure
Date: Wed, 24 Sep 2025 09:37:18 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65463@smartserver.smartshare.dk>
In-Reply-To: <20250923141207.10403-4-bruce.richardson@intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 3/6] ethdev: remove queue stats from ethdev stats
 structure
Thread-Index: AdwslBz5Ft02jIHlTtmrNjNKOw5s4gAkSLgA
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20250923141207.10403-4-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: "Thomas Monjalon" <thomas@monjalon.net>,
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Tuesday, 23 September 2025 16.12
>=20
> The queue stats part of the rte_eth_stats structure has been =
deprecated
> for many years now, since 2020 [1]. Therefore we look to remove these
> fields from the stats structure.
>=20
> Unfortunately, the flag introduced by the deprecation,
> "RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS", means that for drivers using it =
we
> still have to return queue stats from the driver stats_get function.
> This means that we need a new parameter for those stats as part of the
> stats_get interface. The autofill flag is set for 35 drivers, which
> means that if we didn't do so, users of those 35 drivers would lose =
all
> ability to get per-queue stats.
>=20
> [1] Commit a72cb3e7656a ("doc: announce queue stats moving to xstats")
> 	https://github.com/DPDK/dpdk/commit/a72cb3e
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Thank you for finally attacking this, Bruce.

A few documentation comments and a bugfix inline below.

> ---
>  config/rte_config.h               |  1 -
>  lib/ethdev/ethdev_driver.h        | 23 ++++++++++++++++++-
>  lib/ethdev/ethdev_private.c       | 26 ++++++++++++++++++++++
>  lib/ethdev/ethdev_private.h       |  2 ++
>  lib/ethdev/rte_ethdev.c           | 37 =
+++++++++----------------------
>  lib/ethdev/rte_ethdev.h           | 11 ---------
>  lib/ethdev/rte_ethdev_telemetry.c | 20 +----------------
>  7 files changed, 61 insertions(+), 59 deletions(-)
>=20
> diff --git a/config/rte_config.h b/config/rte_config.h
> index 05344e2619..94f9a6427e 100644
> --- a/config/rte_config.h
> +++ b/config/rte_config.h
> @@ -67,7 +67,6 @@
>=20
>  /* ether defines */
>  #define RTE_MAX_QUEUES_PER_PORT 1024
> -#define RTE_ETHDEV_QUEUE_STAT_CNTRS 16 /* max 256 */
>  #define RTE_ETHDEV_RXTX_CALLBACKS 1
>  #define RTE_MAX_MULTI_HOST_CTRLS 4
>=20
> diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
> index 71085bddff..d6f6d974cb 100644
> --- a/lib/ethdev/ethdev_driver.h
> +++ b/lib/ethdev/ethdev_driver.h
> @@ -24,6 +24,27 @@
>  extern "C" {
>  #endif
>=20
> +#define RTE_ETHDEV_QUEUE_STAT_CNTRS 16 /* max 256 */
> +
> +/**
> + * @internal
> + * structure used to pass queue stats back to ethdev for drivers =
which
> rely
> + * on ethdev to add the queue stats automatically to xstats.
> + */
> +struct eth_queue_stats {
> +	/* Queue stats are limited to max 256 queues */
> +	/** Total number of queue Rx packets. */
> +	uint64_t q_ipackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> +	/** Total number of queue Tx packets. */
> +	uint64_t q_opackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> +	/** Total number of successfully received queue bytes. */
> +	uint64_t q_ibytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> +	/** Total number of successfully transmitted queue bytes. */
> +	uint64_t q_obytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> +	/** Total number of queue packets received that are dropped. */
> +	uint64_t q_errors[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> +};
> +
>  /**
>   * @internal
>   * Structure used to hold information about the callbacks to be =
called
> for a
> @@ -428,7 +449,7 @@ typedef int
> (*eth_speed_lanes_get_capability_t)(struct rte_eth_dev *dev,
>=20
>  /** @internal Get global I/O statistics of an Ethernet device. */
>  typedef int (*eth_stats_get_t)(struct rte_eth_dev *dev,
> -				struct rte_eth_stats *igb_stats);
> +				struct rte_eth_stats *stats, struct
> eth_queue_stats *qstats);

Please document that qstats is allowed to be NULL.

>=20
>  /**
>   * @internal
> diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
> index 285d377d91..499e3f56b2 100644
> --- a/lib/ethdev/ethdev_private.c
> +++ b/lib/ethdev/ethdev_private.c
> @@ -477,3 +477,29 @@ eth_dev_tx_queue_config(struct rte_eth_dev *dev,
> uint16_t nb_queues)
>  	dev->data->nb_tx_queues =3D nb_queues;
>  	return 0;
>  }
> +
> +int
> +eth_stats_qstats_get(uint16_t port_id, struct rte_eth_stats *stats,
> struct eth_queue_stats *qstats)

Please document that qstats is allowed to be NULL.

> +{
> +	struct rte_eth_dev *dev;
> +	int ret;
> +
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +	dev =3D &rte_eth_devices[port_id];
> +
> +	if (stats =3D=3D NULL) {
> +		RTE_ETHDEV_LOG_LINE(ERR, "Cannot get ethdev port %u stats
> to NULL",
> +			port_id);
> +		return -EINVAL;
> +	}
> +
> +	memset(stats, 0, sizeof(*stats));
> +	memset(qstats, 0, sizeof(*qstats));

Don't clear qstats if NULL.

> +
> +	if (dev->dev_ops->stats_get =3D=3D NULL)
> +		return -ENOTSUP;
> +	stats->rx_nombuf =3D dev->data->rx_mbuf_alloc_failed;
> +	ret =3D eth_err(port_id, dev->dev_ops->stats_get(dev, stats,
> qstats));
> +
> +	return ret;
> +}
> diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
> index b07b1b4c42..735d9e60b6 100644
> --- a/lib/ethdev/ethdev_private.h
> +++ b/lib/ethdev/ethdev_private.h
> @@ -79,4 +79,6 @@ void eth_dev_txq_release(struct rte_eth_dev *dev,
> uint16_t qid);
>  int eth_dev_rx_queue_config(struct rte_eth_dev *dev, uint16_t
> nb_queues);
>  int eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t
> nb_queues);
>=20
> +int eth_stats_qstats_get(uint16_t port_id, struct rte_eth_stats
> *stats, struct eth_queue_stats *qstats);

Please document that qstats is allowed to be NULL.

> +
>  #endif /* _ETH_PRIVATE_H_ */
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index f22139cb38..aa2d5703bd 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -73,16 +73,16 @@ static const struct rte_eth_xstats_name_off
> eth_dev_stats_strings[] =3D {
>  #define RTE_NB_STATS RTE_DIM(eth_dev_stats_strings)
>=20
>  static const struct rte_eth_xstats_name_off
> eth_dev_rxq_stats_strings[] =3D {
> -	{"packets", offsetof(struct rte_eth_stats, q_ipackets)},
> -	{"bytes", offsetof(struct rte_eth_stats, q_ibytes)},
> -	{"errors", offsetof(struct rte_eth_stats, q_errors)},
> +	{"packets", offsetof(struct eth_queue_stats, q_ipackets)},
> +	{"bytes", offsetof(struct eth_queue_stats, q_ibytes)},
> +	{"errors", offsetof(struct eth_queue_stats, q_errors)},
>  };
>=20
>  #define RTE_NB_RXQ_STATS RTE_DIM(eth_dev_rxq_stats_strings)
>=20
>  static const struct rte_eth_xstats_name_off
> eth_dev_txq_stats_strings[] =3D {
> -	{"packets", offsetof(struct rte_eth_stats, q_opackets)},
> -	{"bytes", offsetof(struct rte_eth_stats, q_obytes)},
> +	{"packets", offsetof(struct eth_queue_stats, q_opackets)},
> +	{"bytes", offsetof(struct eth_queue_stats, q_obytes)},
>  };
>  #define RTE_NB_TXQ_STATS RTE_DIM(eth_dev_txq_stats_strings)
>=20
> @@ -3346,27 +3346,9 @@ RTE_EXPORT_SYMBOL(rte_eth_stats_get)
>  int
>  rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
>  {
> -	struct rte_eth_dev *dev;
> -	int ret;
> -
> -	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> -	dev =3D &rte_eth_devices[port_id];
> -
> -	if (stats =3D=3D NULL) {
> -		RTE_ETHDEV_LOG_LINE(ERR, "Cannot get ethdev port %u stats
> to NULL",
> -			port_id);
> -		return -EINVAL;
> -	}
> -
> -	memset(stats, 0, sizeof(*stats));
> -
> -	if (dev->dev_ops->stats_get =3D=3D NULL)
> -		return -ENOTSUP;
> -	stats->rx_nombuf =3D dev->data->rx_mbuf_alloc_failed;
> -	ret =3D eth_err(port_id, dev->dev_ops->stats_get(dev, stats));
> +	int ret =3D eth_stats_qstats_get(port_id, stats, NULL);
>=20
>  	rte_eth_trace_stats_get(port_id, stats, ret);
> -
>  	return ret;
>  }
>=20
> @@ -3709,12 +3691,13 @@ eth_basic_stats_get(uint16_t port_id, struct
> rte_eth_xstat *xstats)
>  {
>  	struct rte_eth_dev *dev;
>  	struct rte_eth_stats eth_stats;
> +	struct eth_queue_stats queue_stats;
>  	unsigned int count =3D 0, i, q;
>  	uint64_t val, *stats_ptr;
>  	uint16_t nb_rxqs, nb_txqs;
>  	int ret;
>=20
> -	ret =3D rte_eth_stats_get(port_id, &eth_stats);
> +	ret =3D eth_stats_qstats_get(port_id, &eth_stats, &queue_stats);
>  	if (ret < 0)
>  		return ret;
>=20
> @@ -3737,7 +3720,7 @@ eth_basic_stats_get(uint16_t port_id, struct
> rte_eth_xstat *xstats)
>  	/* per-rxq stats */
>  	for (q =3D 0; q < nb_rxqs; q++) {
>  		for (i =3D 0; i < RTE_NB_RXQ_STATS; i++) {
> -			stats_ptr =3D RTE_PTR_ADD(&eth_stats,
> +			stats_ptr =3D RTE_PTR_ADD(&queue_stats,
>  					eth_dev_rxq_stats_strings[i].offset +
>  					q * sizeof(uint64_t));
>  			val =3D *stats_ptr;
> @@ -3748,7 +3731,7 @@ eth_basic_stats_get(uint16_t port_id, struct
> rte_eth_xstat *xstats)
>  	/* per-txq stats */
>  	for (q =3D 0; q < nb_txqs; q++) {
>  		for (i =3D 0; i < RTE_NB_TXQ_STATS; i++) {
> -			stats_ptr =3D RTE_PTR_ADD(&eth_stats,
> +			stats_ptr =3D RTE_PTR_ADD(&queue_stats,
>  					eth_dev_txq_stats_strings[i].offset +
>  					q * sizeof(uint64_t));
>  			val =3D *stats_ptr;
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index d23c143eed..4cfc940000 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -272,17 +272,6 @@ struct rte_eth_stats {
>  	uint64_t ierrors;   /**< Total number of erroneous received
> packets. */
>  	uint64_t oerrors;   /**< Total number of failed transmitted
> packets. */
>  	uint64_t rx_nombuf; /**< Total number of Rx mbuf allocation
> failures. */
> -	/* Queue stats are limited to max 256 queues */
> -	/** Total number of queue Rx packets. */
> -	uint64_t q_ipackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	/** Total number of queue Tx packets. */
> -	uint64_t q_opackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	/** Total number of successfully received queue bytes. */
> -	uint64_t q_ibytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	/** Total number of successfully transmitted queue bytes. */
> -	uint64_t q_obytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
> -	/** Total number of queue packets received that are dropped. */
> -	uint64_t q_errors[RTE_ETHDEV_QUEUE_STAT_CNTRS];
>  };
>=20
>  /**@{@name Link speed capabilities
> diff --git a/lib/ethdev/rte_ethdev_telemetry.c
> b/lib/ethdev/rte_ethdev_telemetry.c
> index 5e6c4172d3..519ad34be7 100644
> --- a/lib/ethdev/rte_ethdev_telemetry.c
> +++ b/lib/ethdev/rte_ethdev_telemetry.c
> @@ -10,6 +10,7 @@
>=20
>  #include "rte_ethdev.h"
>  #include "ethdev_driver.h"
> +#include "ethdev_private.h"
>  #include "sff_telemetry.h"
>  #include "rte_tm.h"
>=20
> @@ -60,20 +61,6 @@ eth_dev_handle_port_list(const char *cmd
> __rte_unused,
>  	return 0;
>  }
>=20
> -static void
> -eth_dev_add_port_queue_stats(struct rte_tel_data *d, uint64_t
> *q_stats,
> -		const char *stat_name)
> -{
> -	int q;
> -	struct rte_tel_data *q_data =3D rte_tel_data_alloc();
> -	if (q_data =3D=3D NULL)
> -		return;
> -	rte_tel_data_start_array(q_data, RTE_TEL_UINT_VAL);
> -	for (q =3D 0; q < RTE_ETHDEV_QUEUE_STAT_CNTRS; q++)
> -		rte_tel_data_add_array_uint(q_data, q_stats[q]);
> -	rte_tel_data_add_dict_container(d, stat_name, q_data, 0);
> -}
> -
>  static int
>  eth_dev_parse_hide_zero(const char *key, const char *value, void
> *extra_args)
>  {
> @@ -121,11 +108,6 @@ eth_dev_handle_port_stats(const char *cmd
> __rte_unused,
>  	ADD_DICT_STAT(stats, ierrors);
>  	ADD_DICT_STAT(stats, oerrors);
>  	ADD_DICT_STAT(stats, rx_nombuf);
> -	eth_dev_add_port_queue_stats(d, stats.q_ipackets, "q_ipackets");
> -	eth_dev_add_port_queue_stats(d, stats.q_opackets, "q_opackets");
> -	eth_dev_add_port_queue_stats(d, stats.q_ibytes, "q_ibytes");
> -	eth_dev_add_port_queue_stats(d, stats.q_obytes, "q_obytes");
> -	eth_dev_add_port_queue_stats(d, stats.q_errors, "q_errors");
>=20
>  	return 0;
>  }
> --
> 2.48.1

