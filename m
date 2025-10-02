Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1EACAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 07:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3E07406B8;
	Thu,  2 Oct 2025 09:44:45 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 569FF40262
 for <dev@dpdk.org>; Thu,  2 Oct 2025 09:44:44 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2E579206E5;
 Thu,  2 Oct 2025 09:44:44 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 3/5] ethdev: mark mbufs in burst functions
Date: Thu, 2 Oct 2025 09:44:43 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6548E@smartserver.smartshare.dk>
In-Reply-To: <20250930233828.3999565-4-thomas@monjalon.net>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 3/5] ethdev: mark mbufs in burst functions
Thread-Index: AdwyY2V1O5oq8p/rSpqKeRO+o6/9rQBDH7WQ
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-1-thomas@monjalon.net>
 <20250930233828.3999565-4-thomas@monjalon.net>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>, <dev@dpdk.org>,
 "Shani Peretz" <shperetz@nvidia.com>
Cc: <viacheslavo@nvidia.com>, <bruce.richardson@intel.com>,
 <stephen@networkplumber.org>,
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

> From: Thomas Monjalon [mailto:thomas@monjalon.net]
> Sent: Wednesday, 1 October 2025 01.25
>=20
> From: Shani Peretz <shperetz@nvidia.com>
>=20
> Mark the Rx/Tx steps in mbufs for debugging.
> It has no performance impact if mbuf history is disabled (by default).
>=20
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---
>  lib/ethdev/rte_ethdev.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index d23c143eed..8a9683c5e9 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -6336,6 +6336,8 @@ rte_eth_rx_burst(uint16_t port_id, uint16_t
> queue_id,
>=20
>  	nb_rx =3D p->rx_pkt_burst(qd, rx_pkts, nb_pkts);
>=20
> +	rte_mbuf_history_mark_bulk(rx_pkts, nb_rx,
> RTE_MBUF_HISTORY_OP_RX);
> +
>  #ifdef RTE_ETHDEV_RXTX_CALLBACKS
>  	{
>  		void *cb;
> @@ -6688,8 +6690,19 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t
> queue_id,
>  	}
>  #endif
>=20
> +#if RTE_MBUF_HISTORY_DEBUG
> +	uint16_t requested_pkts =3D nb_pkts;
> +	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts,
> RTE_MBUF_HISTORY_OP_TX);
> +#endif

I think the compiler is clever enough to optimize away this if =
rte_mbuf_history_mark_bulk() does nothing. So you can omit the "#if =
RTE_MBUF_HISTORY_DEBUG". Also below.

> +
>  	nb_pkts =3D p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
>=20
> +#if RTE_MBUF_HISTORY_DEBUG
> +	if (requested_pkts > nb_pkts)
> +		rte_mbuf_history_mark_bulk(tx_pkts + nb_pkts,
> +				requested_pkts - nb_pkts,
> RTE_MBUF_HISTORY_OP_BUSY_TX);
> +#endif
> +
>  	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts,
> nb_pkts);
>  	return nb_pkts;
>  }
> @@ -6785,6 +6798,8 @@ rte_eth_tx_prepare(uint16_t port_id, uint16_t
> queue_id,
>  	}
>  #endif
>=20
> +	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts,
> RTE_MBUF_HISTORY_OP_PREP_TX);
> +
>  	return p->tx_pkt_prepare(qd, tx_pkts, nb_pkts);
>  }
>=20
> --
> 2.51.0

