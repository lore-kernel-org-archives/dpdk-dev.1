Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10E7CD584C
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 10:31:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DEBF40267;
	Wed,  7 Jan 2026 11:31:45 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 08D7F4021E
 for <dev@dpdk.org>; Wed,  7 Jan 2026 11:31:44 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dmPTk0bD7zJ46XM;
 Wed,  7 Jan 2026 18:31:38 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 29F2D4056A;
 Wed,  7 Jan 2026 18:31:41 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 11:31:40 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 7 Jan 2026 11:31:40 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 07/12] net/pcap: avoid use of volatile
Thread-Topic: [PATCH 07/12] net/pcap: avoid use of volatile
Thread-Index: AQHcfzsLUelM4i9Wdk+fSX/5GOB0sLVGcrhA
Date: Wed, 7 Jan 2026 10:31:40 +0000
Message-ID: <234ce78433ba40a4963e06d4ea0d1c3c@huawei.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260106182823.192350-8-stephen@networkplumber.org>
In-Reply-To: <20260106182823.192350-8-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

> Using volatile for statistics generates expensive atomic rmw
> operations when not necessary.

I am not sure it is true, AFAIK volatile only affects the compiler. In this=
=20
case it mostly guards against these variables being completely cached in=20
registers. Your new version is actually more correct, but also potentially=
=20
slower since general fence affects all reads or writes, not just counters i=
n=20
question. I think it is common among drivers to not guarantee visibility of=
=20
the most recent counter values for the sake of performance.

>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/pcap/pcap_ethdev.c | 38 ++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethde=
v.c
> index 1658685a28..175d6998f9 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -47,10 +47,10 @@ static uint64_t timestamp_rx_dynflag;
>  static int timestamp_dynfield_offset =3D -1;
>=20
>  struct queue_stat {
> -	volatile unsigned long pkts;
> -	volatile unsigned long bytes;
> -	volatile unsigned long err_pkts;
> -	volatile unsigned long rx_nombuf;
> +	uint64_t pkts;
> +	uint64_t bytes;
> +	uint64_t err_pkts;
> +	uint64_t rx_nombuf;
>  };
>=20
>  struct queue_missed_stat {
> @@ -267,6 +267,9 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **b=
ufs, uint16_t nb_pkts)
>  	pcap_q->rx_stat.pkts +=3D i;
>  	pcap_q->rx_stat.bytes +=3D rx_bytes;
>=20
> +	/* ensure store operations of statistics are visible */
> +	rte_atomic_thread_fence(rte_memory_order_release);
> +
>  	return i;
>  }
>=20
> @@ -345,6 +348,9 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint=
16_t nb_pkts)
>  	pcap_q->rx_stat.pkts +=3D num_rx;
>  	pcap_q->rx_stat.bytes +=3D rx_bytes;
>=20
> +	/* ensure store operations of statistics are visible */
> +	rte_atomic_thread_fence(rte_memory_order_release);
> +
>  	return num_rx;
>  }
>=20
> @@ -440,6 +446,9 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **buf=
s, uint16_t nb_pkts)
>  	dumper_q->tx_stat.bytes +=3D tx_bytes;
>  	dumper_q->tx_stat.err_pkts +=3D nb_pkts - num_tx;
>=20
> +	/* ensure store operations of statistics are visible */
> +	rte_atomic_thread_fence(rte_memory_order_release);
> +
>  	return nb_pkts;
>  }
>=20
> @@ -464,6 +473,9 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint=
16_t nb_pkts)
>  	tx_queue->tx_stat.pkts +=3D nb_pkts;
>  	tx_queue->tx_stat.bytes +=3D tx_bytes;
>=20
> +	/* ensure store operations of statistics are visible */
> +	rte_atomic_thread_fence(rte_memory_order_release);
> +
>  	return nb_pkts;
>  }
>=20
> @@ -515,6 +527,9 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint=
16_t nb_pkts)
>  	tx_queue->tx_stat.bytes +=3D tx_bytes;
>  	tx_queue->tx_stat.err_pkts +=3D nb_pkts - num_tx;
>=20
> +	/* ensure store operations of statistics are visible */
> +	rte_atomic_thread_fence(rte_memory_order_release);
> +
>  	return nb_pkts;
>  }
>=20
> @@ -821,13 +836,16 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_e=
th_stats *stats,
>  	      struct eth_queue_stats *qstats)
>  {
>  	unsigned int i;
> -	unsigned long rx_packets_total =3D 0, rx_bytes_total =3D 0;
> -	unsigned long rx_missed_total =3D 0;
> -	unsigned long rx_nombuf_total =3D 0, rx_err_total =3D 0;
> -	unsigned long tx_packets_total =3D 0, tx_bytes_total =3D 0;
> -	unsigned long tx_packets_err_total =3D 0;
> +	uint64_t rx_packets_total =3D 0, rx_bytes_total =3D 0;
> +	uint64_t rx_missed_total =3D 0;
> +	uint64_t rx_nombuf_total =3D 0, rx_err_total =3D 0;
> +	uint64_t tx_packets_total =3D 0, tx_bytes_total =3D 0;
> +	uint64_t tx_packets_err_total =3D 0;
>  	const struct pmd_internals *internal =3D dev->data->dev_private;
>=20
> +	/* ensure that current statistics are visible */
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
> +
>  	for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
>  			i < dev->data->nb_rx_queues; i++) {
>  		if (qstats !=3D NULL) {
> @@ -884,6 +902,8 @@ eth_stats_reset(struct rte_eth_dev *dev)
>  		internal->tx_queue[i].tx_stat.err_pkts =3D 0;
>  	}
>=20
> +	/* ensure store operations of statistics are visible */
> +	rte_atomic_thread_fence(rte_memory_order_release);
>  	return 0;
>  }
>=20
> --
> 2.51.0
>=20

