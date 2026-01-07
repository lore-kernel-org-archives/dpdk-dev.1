Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4EDCD5854
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 10:58:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0989B402D6;
	Wed,  7 Jan 2026 11:58:56 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8089740267
 for <dev@dpdk.org>; Wed,  7 Jan 2026 11:58:54 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dmQ532ZhgzHnGjn;
 Wed,  7 Jan 2026 18:58:47 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 6307A40539;
 Wed,  7 Jan 2026 18:58:53 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 7 Jan 2026 11:58:53 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 7 Jan 2026 11:58:53 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 08/12] net/pcap: optimize calculation of receive timestamp
Thread-Topic: [PATCH 08/12] net/pcap: optimize calculation of receive timestamp
Thread-Index: AQHcfzsaXY7aycvMxEOA6ACR1nGI6LVGhoAQ
Date: Wed, 7 Jan 2026 10:58:53 +0000
Message-ID: <7a43c70576054749920c16e8c2ae6320@huawei.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260106182823.192350-9-stephen@networkplumber.org>
In-Reply-To: <20260106182823.192350-9-stephen@networkplumber.org>
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday 6 January 2026 18:27
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [PATCH 08/12] net/pcap: optimize calculation of receive timestam=
p
>=20
> Avoid doing slow instructions in receive path when calculating
> timestamp. Give all packets in the same rx burst the same timestamp.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/pcap/pcap_ethdev.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethde=
v.c
> index 175d6998f9..e283fb3787 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -20,6 +20,7 @@
>  #include <bus_vdev_driver.h>
>  #include <rte_os_shim.h>
>  #include <rte_time.h>
> +#include <rte_reciprocal.h>
>=20
>  #include "pcap_osdep.h"
>=20
> @@ -41,7 +42,7 @@
>=20
>  static struct timespec start_time;
>  static uint64_t start_cycles;
> -static uint64_t hz;
> +static struct rte_reciprocal_u64 hz_inv;
>=20
>  static uint64_t timestamp_rx_dynflag;
>  static int timestamp_dynfield_offset =3D -1;
> @@ -362,8 +363,6 @@ eth_null_rx(void *queue __rte_unused,
>  	return 0;
>  }
>=20
> -#define NSEC_PER_SEC	1000000000L
> -
>  /*
>   * This function stores nanoseconds in `tv_usec` field of `struct timeva=
l`,
>   * because `ts` goes directly to nanosecond-precision dump.
> @@ -374,8 +373,10 @@ calculate_timestamp(struct timeval *ts) {
>  	struct timespec cur_time;
>=20
>  	cycles =3D rte_get_timer_cycles() - start_cycles;
> -	cur_time.tv_sec =3D cycles / hz;
> -	cur_time.tv_nsec =3D (cycles % hz) * NSEC_PER_SEC / hz;
> +	cur_time.tv_sec =3D rte_reciprocal_divide_u64(cycles, &hz_inv);
> +	/* compute remainder */
> +	cycles -=3D cur_time.tv_sec * rte_get_timer_hz();

Can be made faster and safer by caching rte_get_timer_hz() result in curren=
t translation unit.

> +	cur_time.tv_nsec =3D rte_reciprocal_divide_u64(cycles * NS_PER_S, &hz_i=
nv);
>=20
>  	ts->tv_sec =3D start_time.tv_sec + cur_time.tv_sec;
>  	ts->tv_usec =3D start_time.tv_nsec + cur_time.tv_nsec;
> @@ -394,6 +395,7 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **buf=
s, uint16_t nb_pkts)
>  	unsigned int i;
>  	struct pmd_process_private *pp;
>  	struct pcap_tx_queue *dumper_q =3D queue;
> +	struct pcap_pkthdr header;
>  	uint16_t num_tx =3D 0;
>  	uint32_t tx_bytes =3D 0;
>  	pcap_dumper_t *dumper;
> @@ -406,13 +408,14 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **b=
ufs, uint16_t nb_pkts)
>  	if (unlikely(dumper =3D=3D NULL || nb_pkts =3D=3D 0))
>  		return 0;
>=20
> -	/* writes the nb_pkts packets to the previously opened pcap file
> -	 * dumper */
> +	/* all packets in burst have same timestamp */
> +	calculate_timestamp(&header.ts);
> +
> +	/* writes the nb_pkts packets to the previously opened pcap file dumper=
 */
>  	for (i =3D 0; i < nb_pkts; i++) {
>  		struct rte_mbuf *mbuf =3D bufs[i];
>  		size_t len =3D rte_pktmbuf_pkt_len(mbuf);
>  		uint8_t temp_data[RTE_ETH_PCAP_SNAPLEN];
> -		struct pcap_pkthdr header;
>=20
>  		if (unlikely(len > mtu))
>  			continue;
> @@ -420,7 +423,6 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **buf=
s, uint16_t nb_pkts)
>  		if ((mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) && rte_vlan_insert(&mbuf))
>  			continue;
>=20
> -		calculate_timestamp(&header.ts);
>  		header.len =3D len;
>  		header.caplen =3D len;
>=20
> @@ -1530,7 +1532,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
>=20
>  	timespec_get(&start_time, TIME_UTC);
>  	start_cycles =3D rte_get_timer_cycles();
> -	hz =3D rte_get_timer_hz();
> +
> +	hz_inv =3D rte_reciprocal_value_u64(rte_get_timer_hz());
>=20
>  	if (rte_eal_process_type() =3D=3D RTE_PROC_SECONDARY) {
>  		eth_dev =3D rte_eth_dev_attach_secondary(name);
> --
> 2.51.0

Apart from one minor optimization suggestion above,

Acked-by: Marat Khalili <marat.khalili@huawei.com>
