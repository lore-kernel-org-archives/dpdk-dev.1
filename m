Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D5CC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 16:44:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1253D42788;
	Wed, 19 Feb 2025 17:44:20 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id F2D4C4270A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 17:44:17 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Yyhtz1NzHztQbR;
 Thu, 20 Feb 2025 00:39:39 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
 by mail.maildlp.com (Postfix) with ESMTPS id D1926140257;
 Thu, 20 Feb 2025 00:44:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemk500008.china.huawei.com (7.202.194.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 00:44:14 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 19 Feb 2025 17:44:12 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: huangdengdui <huangdengdui@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "wathsala.vithanage@arm.com" <wathsala.vithanage@arm.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, "lihuisong (C)"
 <lihuisong@huawei.com>, Fengchengwen <fengchengwen@huawei.com>, haijie
 <haijie1@huawei.com>, liuyonglong <liuyonglong@huawei.com>
Subject: RE: [PATCH] examples/l3fwd: add option to set refetch offset
Thread-Topic: [PATCH] examples/l3fwd: add option to set refetch offset
Thread-Index: AQHbY0M+J3rwtDemskeud65RtItxhbNPEU3g
Date: Wed, 19 Feb 2025 16:44:12 +0000
Message-ID: <e514a9af829447c2965b3e2d5b2672fb@huawei.com>
References: <20241225075302.353013-1-huangdengdui@huawei.com>
 <20250110093715.4044681-1-huangdengdui@huawei.com>
In-Reply-To: <20250110093715.4044681-1-huangdengdui@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
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


> Subject: [PATCH] examples/l3fwd: add option to set refetch offset

I suppose it should be 'prefetch'.
=20
> The prefetch window depending on the HW platform. It is difficult to
> measure the prefetch window of a HW platform. Therefore, the prefetch
> offset option is added to change the prefetch window. User can adjust
> the refetch offset to achieve the best prefetch effect.
>=20
> In addition, this option is used only in the main loop.

I run few tests for fib,lpm,acl modes on my Intel ICX box.
Didn't notice any performance drop with that patch.

>=20
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
>  examples/l3fwd/l3fwd.h               |  6 ++-
>  examples/l3fwd/l3fwd_acl_scalar.h    |  6 +--
>  examples/l3fwd/l3fwd_em.h            | 18 ++++-----
>  examples/l3fwd/l3fwd_em_hlm.h        |  9 +++--
>  examples/l3fwd/l3fwd_em_sequential.h | 60 ++++++++++++++++------------
>  examples/l3fwd/l3fwd_fib.c           | 21 +++++-----
>  examples/l3fwd/l3fwd_lpm.h           |  6 +--
>  examples/l3fwd/l3fwd_lpm_neon.h      | 45 ++++-----------------
>  examples/l3fwd/main.c                | 14 +++++++
>  9 files changed, 91 insertions(+), 94 deletions(-)
>=20
> diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
> index 0cce3406ee..2272fb2870 100644
> --- a/examples/l3fwd/l3fwd.h
> +++ b/examples/l3fwd/l3fwd.h
> @@ -39,8 +39,7 @@
>=20
>  #define NB_SOCKETS        8
>=20
> -/* Configure how many packets ahead to prefetch, when reading packets */
> -#define PREFETCH_OFFSET	  3
> +#define DEFAULT_PREFECH_OFFSET 4
>=20
>  /* Used to mark destination port as 'invalid'. */
>  #define	BAD_PORT ((uint16_t)-1)
> @@ -119,6 +118,9 @@ extern uint32_t max_pkt_len;
>  extern uint32_t nb_pkt_per_burst;
>  extern uint32_t mb_mempool_cache_size;
>=20
> +/* Prefetch offset of packets processed by the main loop. */
> +extern uint16_t prefetch_offset;
> +
>  /* Send burst of packets on an output interface */
>  static inline int
>  send_burst(struct lcore_conf *qconf, uint16_t n, uint16_t port)
> diff --git a/examples/l3fwd/l3fwd_acl_scalar.h b/examples/l3fwd/l3fwd_acl=
_scalar.h
> index cb22bb49aa..d00730ff25 100644
> --- a/examples/l3fwd/l3fwd_acl_scalar.h
> +++ b/examples/l3fwd/l3fwd_acl_scalar.h
> @@ -72,14 +72,14 @@ l3fwd_acl_prepare_acl_parameter(struct rte_mbuf **pkt=
s_in, struct acl_search_t *
>  	acl->num_ipv6 =3D 0;
>=20
>  	/* Prefetch first packets */
> -	for (i =3D 0; i < PREFETCH_OFFSET && i < nb_rx; i++) {
> +	for (i =3D 0; i < prefetch_offset && i < nb_rx; i++) {
>  		rte_prefetch0(rte_pktmbuf_mtod(
>  				pkts_in[i], void *));
>  	}
>=20
> -	for (i =3D 0; i < (nb_rx - PREFETCH_OFFSET); i++) {
> +	for (i =3D 0; i < (nb_rx - prefetch_offset); i++) {
>  		rte_prefetch0(rte_pktmbuf_mtod(pkts_in[
> -				i + PREFETCH_OFFSET], void *));
> +				i + prefetch_offset], void *));
>  		l3fwd_acl_prepare_one_packet(pkts_in, acl, i);
>  	}
>=20
> diff --git a/examples/l3fwd/l3fwd_em.h b/examples/l3fwd/l3fwd_em.h
> index 1fee2e2e6c..3ef32c9053 100644
> --- a/examples/l3fwd/l3fwd_em.h
> +++ b/examples/l3fwd/l3fwd_em.h
> @@ -132,16 +132,16 @@ l3fwd_em_no_opt_send_packets(int nb_rx, struct rte_=
mbuf **pkts_burst,
>  	int32_t j;
>=20
>  	/* Prefetch first packets */
> -	for (j =3D 0; j < PREFETCH_OFFSET && j < nb_rx; j++)
> +	for (j =3D 0; j < prefetch_offset && j < nb_rx; j++)
>  		rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[j], void *));
>=20
>  	/*
>  	 * Prefetch and forward already prefetched
>  	 * packets.
>  	 */
> -	for (j =3D 0; j < (nb_rx - PREFETCH_OFFSET); j++) {
> +	for (j =3D 0; j < (nb_rx - prefetch_offset); j++) {
>  		rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[
> -				j + PREFETCH_OFFSET], void *));
> +				j + prefetch_offset], void *));
>  		l3fwd_em_simple_forward(pkts_burst[j], portid, qconf);
>  	}
>=20
> @@ -161,16 +161,16 @@ l3fwd_em_no_opt_process_events(int nb_rx, struct rt=
e_event **events,
>  	int32_t j;
>=20
>  	/* Prefetch first packets */
> -	for (j =3D 0; j < PREFETCH_OFFSET && j < nb_rx; j++)
> +	for (j =3D 0; j < prefetch_offset && j < nb_rx; j++)
>  		rte_prefetch0(rte_pktmbuf_mtod(events[j]->mbuf, void *));
>=20
>  	/*
>  	 * Prefetch and forward already prefetched
>  	 * packets.
>  	 */
> -	for (j =3D 0; j < (nb_rx - PREFETCH_OFFSET); j++) {
> +	for (j =3D 0; j < (nb_rx - prefetch_offset); j++) {
>  		rte_prefetch0(rte_pktmbuf_mtod(events[
> -				j + PREFETCH_OFFSET]->mbuf, void *));
> +				j + prefetch_offset]->mbuf, void *));
>  		l3fwd_em_simple_process(events[j]->mbuf, qconf);
>  	}
>=20
> @@ -188,15 +188,15 @@ l3fwd_em_no_opt_process_event_vector(struct rte_eve=
nt_vector *vec,
>  	int32_t i;
>=20
>  	/* Prefetch first packets */
> -	for (i =3D 0; i < PREFETCH_OFFSET && i < vec->nb_elem; i++)
> +	for (i =3D 0; i < prefetch_offset && i < vec->nb_elem; i++)
>  		rte_prefetch0(rte_pktmbuf_mtod(mbufs[i], void *));
>=20
>  	/*
>  	 * Prefetch and forward already prefetched packets.
>  	 */
> -	for (i =3D 0; i < (vec->nb_elem - PREFETCH_OFFSET); i++) {
> +	for (i =3D 0; i < (vec->nb_elem - prefetch_offset); i++) {
>  		rte_prefetch0(
> -			rte_pktmbuf_mtod(mbufs[i + PREFETCH_OFFSET], void *));
> +			rte_pktmbuf_mtod(mbufs[i + prefetch_offset], void *));
>  		dst_ports[i] =3D l3fwd_em_simple_process(mbufs[i], qconf);
>  	}
>=20
> diff --git a/examples/l3fwd/l3fwd_em_hlm.h b/examples/l3fwd/l3fwd_em_hlm.=
h
> index c1d819997a..764527962b 100644
> --- a/examples/l3fwd/l3fwd_em_hlm.h
> +++ b/examples/l3fwd/l3fwd_em_hlm.h
> @@ -190,7 +190,7 @@ l3fwd_em_process_packets(int nb_rx, struct rte_mbuf *=
*pkts_burst,
>  	 */
>  	int32_t n =3D RTE_ALIGN_FLOOR(nb_rx, EM_HASH_LOOKUP_COUNT);
>=20
> -	for (j =3D 0; j < EM_HASH_LOOKUP_COUNT && j < nb_rx; j++) {
> +	for (j =3D 0; j < prefetch_offset && j < nb_rx; j++) {
>  		rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[j],
>  					       struct rte_ether_hdr *) + 1);
>  	}
> @@ -207,7 +207,7 @@ l3fwd_em_process_packets(int nb_rx, struct rte_mbuf *=
*pkts_burst,
>  		l3_type =3D pkt_type & RTE_PTYPE_L3_MASK;
>  		tcp_or_udp =3D pkt_type & (RTE_PTYPE_L4_TCP | RTE_PTYPE_L4_UDP);
>=20
> -		for (i =3D 0, pos =3D j + EM_HASH_LOOKUP_COUNT;
> +		for (i =3D 0, pos =3D j + prefetch_offset;
>  		     i < EM_HASH_LOOKUP_COUNT && pos < nb_rx; i++, pos++) {
>  			rte_prefetch0(rte_pktmbuf_mtod(
>  					pkts_burst[pos],
> @@ -277,6 +277,9 @@ l3fwd_em_process_events(int nb_rx, struct rte_event *=
*ev,
>  	for (j =3D 0; j < nb_rx; j++)
>  		pkts_burst[j] =3D ev[j]->mbuf;
>=20
> +	for (i =3D 0; i < prefetch_offset && i < nb_rx; i++)
> +		rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[i], struct rte_ether_hdr *) =
+ 1);
> +

If there are no prefetches right now, probably no need to add new.
Or if you feel strongly about it - make it as a new patch.

>  	for (j =3D 0; j < n; j +=3D EM_HASH_LOOKUP_COUNT) {
>=20
>  		uint32_t pkt_type =3D RTE_PTYPE_L3_MASK |
> @@ -289,7 +292,7 @@ l3fwd_em_process_events(int nb_rx, struct rte_event *=
*ev,
>  		l3_type =3D pkt_type & RTE_PTYPE_L3_MASK;
>  		tcp_or_udp =3D pkt_type & (RTE_PTYPE_L4_TCP | RTE_PTYPE_L4_UDP);
>=20
> -		for (i =3D 0, pos =3D j + EM_HASH_LOOKUP_COUNT;
> +		for (i =3D 0, pos =3D j + prefetch_offset;
>  		     i < EM_HASH_LOOKUP_COUNT && pos < nb_rx; i++, pos++) {
>  			rte_prefetch0(rte_pktmbuf_mtod(
>  					pkts_burst[pos],
> diff --git a/examples/l3fwd/l3fwd_em_sequential.h b/examples/l3fwd/l3fwd_=
em_sequential.h
> index 3a40b2e434..f2c6ceb7c0 100644
> --- a/examples/l3fwd/l3fwd_em_sequential.h
> +++ b/examples/l3fwd/l3fwd_em_sequential.h
> @@ -81,20 +81,19 @@ l3fwd_em_send_packets(int nb_rx, struct rte_mbuf **pk=
ts_burst,
>  	int32_t i, j;
>  	uint16_t dst_port[SENDM_PORT_OVERHEAD(MAX_PKT_BURST)];
>=20
> -	if (nb_rx > 0) {
> -		rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[0],
> +	for (i =3D 0; i < prefetch_offset && i < nb_rx; i++)
> +		rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[i],
>  					       struct rte_ether_hdr *) + 1);
> -	}
>=20
> -	for (i =3D 1, j =3D 0; j < nb_rx; i++, j++) {
> -		if (i < nb_rx) {
> -			rte_prefetch0(rte_pktmbuf_mtod(
> -					pkts_burst[i],
> -					struct rte_ether_hdr *) + 1);
> -		}
> +	for (j =3D 0; j < nb_rx - prefetch_offset; j++) {
> +		rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[j + prefetch_offset],
> +					       struct rte_ether_hdr *) + 1);
>  		dst_port[j] =3D em_get_dst_port(qconf, pkts_burst[j], portid);
>  	}
>=20
> +	for (; j < nb_rx; j++)
> +		dst_port[j] =3D em_get_dst_port(qconf, pkts_burst[j], portid);
> +
>  	send_packets_multi(qconf, pkts_burst, dst_port, nb_rx);
>  }
>=20
> @@ -106,20 +105,26 @@ static inline void
>  l3fwd_em_process_events(int nb_rx, struct rte_event **events,
>  		     struct lcore_conf *qconf)
>  {
> +	struct rte_mbuf *mbuf;
> +	uint16_t port;
>  	int32_t i, j;
>=20
> -	rte_prefetch0(rte_pktmbuf_mtod(events[0]->mbuf,
> -		      struct rte_ether_hdr *) + 1);
> +	for (i =3D 0; i < prefetch_offset && i < nb_rx; i++)
> +		rte_prefetch0(rte_pktmbuf_mtod(events[i]->mbuf, struct rte_ether_hdr *=
) + 1);
>=20
> -	for (i =3D 1, j =3D 0; j < nb_rx; i++, j++) {
> -		struct rte_mbuf *mbuf =3D events[j]->mbuf;
> -		uint16_t port;
> +	for (j =3D 0; j < nb_rx - prefetch_offset; j++) {
> +		rte_prefetch0(rte_pktmbuf_mtod(events[j + prefetch_offset]->mbuf,
> +					       struct rte_ether_hdr *) + 1);
> +		mbuf =3D events[j]->mbuf;
> +		port =3D mbuf->port;
> +		mbuf->port =3D em_get_dst_port(qconf, mbuf, mbuf->port);
> +		process_packet(mbuf, &mbuf->port);
> +		if (mbuf->port =3D=3D BAD_PORT)
> +			mbuf->port =3D port;
> +	}
>=20
> -		if (i < nb_rx) {
> -			rte_prefetch0(rte_pktmbuf_mtod(
> -					events[i]->mbuf,
> -					struct rte_ether_hdr *) + 1);
> -		}
> +	for (; j < nb_rx; j++) {
> +		mbuf =3D events[j]->mbuf;
>  		port =3D mbuf->port;
>  		mbuf->port =3D em_get_dst_port(qconf, mbuf, mbuf->port);
>  		process_packet(mbuf, &mbuf->port);
> @@ -136,17 +141,22 @@ l3fwd_em_process_event_vector(struct rte_event_vect=
or *vec,
>  	struct rte_mbuf **mbufs =3D vec->mbufs;
>  	int32_t i, j;
>=20
> -	rte_prefetch0(rte_pktmbuf_mtod(mbufs[0], struct rte_ether_hdr *) + 1);
> +	for (i =3D 0; i < prefetch_offset && i < vec->nb_elem; i++)
> +		rte_prefetch0(rte_pktmbuf_mtod(mbufs[i], struct rte_ether_hdr *) + 1);
>=20
> -	for (i =3D 0, j =3D 1; i < vec->nb_elem; i++, j++) {
> -		if (j < vec->nb_elem)
> -			rte_prefetch0(rte_pktmbuf_mtod(mbufs[j],
> -						       struct rte_ether_hdr *) +
> -				      1);
> +	for (i =3D 0; i < vec->nb_elem - prefetch_offset; i++) {
> +		rte_prefetch0(rte_pktmbuf_mtod(mbufs[i + prefetch_offset],
> +					       struct rte_ether_hdr *) + 1);
>  		dst_ports[i] =3D em_get_dst_port(qconf, mbufs[i],
>  					       attr_valid ? vec->port :
>  							    mbufs[i]->port);
>  	}
> +
> +	for (; i < vec->nb_elem; i++)
> +		dst_ports[i] =3D em_get_dst_port(qconf, mbufs[i],
> +					       attr_valid ? vec->port :
> +							    mbufs[i]->port);
> +
>  	j =3D RTE_ALIGN_FLOOR(vec->nb_elem, FWDSTEP);
>=20
>  	for (i =3D 0; i !=3D j; i +=3D FWDSTEP)
> diff --git a/examples/l3fwd/l3fwd_fib.c b/examples/l3fwd/l3fwd_fib.c
> index 82f1739df7..25192611c5 100644
> --- a/examples/l3fwd/l3fwd_fib.c
> +++ b/examples/l3fwd/l3fwd_fib.c
> @@ -24,9 +24,6 @@
>  #include "l3fwd_event.h"
>  #include "l3fwd_route.h"
>=20
> -/* Configure how many packets ahead to prefetch for fib. */
> -#define FIB_PREFETCH_OFFSET 4
> -
>  /* A non-existent portid is needed to denote a default hop for fib. */
>  #define FIB_DEFAULT_HOP 999
>=20
> @@ -130,14 +127,14 @@ fib_send_packets(int nb_rx, struct rte_mbuf **pkts_=
burst,
>  	int32_t i;
>=20
>  	/* Prefetch first packets. */
> -	for (i =3D 0; i < FIB_PREFETCH_OFFSET && i < nb_rx; i++)
> +	for (i =3D 0; i < prefetch_offset && i < nb_rx; i++)
>  		rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[i], void *));
>=20
>  	/* Parse packet info and prefetch. */
> -	for (i =3D 0; i < (nb_rx - FIB_PREFETCH_OFFSET); i++) {
> +	for (i =3D 0; i < (nb_rx - prefetch_offset); i++) {
>  		/* Prefetch packet. */
>  		rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[
> -				i + FIB_PREFETCH_OFFSET], void *));
> +				i + prefetch_offset], void *));
>  		fib_parse_packet(pkts_burst[i],
>  				&ipv4_arr[ipv4_cnt], &ipv4_cnt,
>  				&ipv6_arr[ipv6_cnt], &ipv6_cnt,
> @@ -302,11 +299,11 @@ fib_event_loop(struct l3fwd_event_resources *evt_rs=
rc,
>  		ipv6_arr_assem =3D 0;
>=20
>  		/* Prefetch first packets. */
> -		for (i =3D 0; i < FIB_PREFETCH_OFFSET && i < nb_deq; i++)
> +		for (i =3D 0; i < prefetch_offset && i < nb_deq; i++)
>  			rte_prefetch0(rte_pktmbuf_mtod(events[i].mbuf, void *));
>=20
>  		/* Parse packet info and prefetch. */
> -		for (i =3D 0; i < (nb_deq - FIB_PREFETCH_OFFSET); i++) {
> +		for (i =3D 0; i < (nb_deq - prefetch_offset); i++) {
>  			if (flags & L3FWD_EVENT_TX_ENQ) {
>  				events[i].queue_id =3D tx_q_id;
>  				events[i].op =3D RTE_EVENT_OP_FORWARD;
> @@ -318,7 +315,7 @@ fib_event_loop(struct l3fwd_event_resources *evt_rsrc=
,
>=20
>  			/* Prefetch packet. */
>  			rte_prefetch0(rte_pktmbuf_mtod(events[
> -					i + FIB_PREFETCH_OFFSET].mbuf,
> +					i + prefetch_offset].mbuf,
>  					void *));
>=20
>  			fib_parse_packet(events[i].mbuf,
> @@ -455,12 +452,12 @@ fib_process_event_vector(struct rte_event_vector *v=
ec, uint8_t *type_arr,
>  	ipv6_arr_assem =3D 0;
>=20
>  	/* Prefetch first packets. */
> -	for (i =3D 0; i < FIB_PREFETCH_OFFSET && i < vec->nb_elem; i++)
> +	for (i =3D 0; i < prefetch_offset && i < vec->nb_elem; i++)
>  		rte_prefetch0(rte_pktmbuf_mtod(mbufs[i], void *));
>=20
>  	/* Parse packet info and prefetch. */
> -	for (i =3D 0; i < (vec->nb_elem - FIB_PREFETCH_OFFSET); i++) {
> -		rte_prefetch0(rte_pktmbuf_mtod(mbufs[i + FIB_PREFETCH_OFFSET],
> +	for (i =3D 0; i < (vec->nb_elem - prefetch_offset); i++) {
> +		rte_prefetch0(rte_pktmbuf_mtod(mbufs[i + prefetch_offset],
>  					       void *));
>  		fib_parse_packet(mbufs[i], &ipv4_arr[ipv4_cnt], &ipv4_cnt,
>  				 &ipv6_arr[ipv6_cnt], &ipv6_cnt, &type_arr[i]);
> diff --git a/examples/l3fwd/l3fwd_lpm.h b/examples/l3fwd/l3fwd_lpm.h
> index 4ee61e8d88..d81aa2efaf 100644
> --- a/examples/l3fwd/l3fwd_lpm.h
> +++ b/examples/l3fwd/l3fwd_lpm.h
> @@ -82,13 +82,13 @@ l3fwd_lpm_no_opt_send_packets(int nb_rx, struct rte_m=
buf **pkts_burst,
>  	int32_t j;
>=20
>  	/* Prefetch first packets */
> -	for (j =3D 0; j < PREFETCH_OFFSET && j < nb_rx; j++)
> +	for (j =3D 0; j < prefetch_offset && j < nb_rx; j++)
>  		rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[j], void *));
>=20
>  	/* Prefetch and forward already prefetched packets. */
> -	for (j =3D 0; j < (nb_rx - PREFETCH_OFFSET); j++) {
> +	for (j =3D 0; j < (nb_rx - prefetch_offset); j++) {
>  		rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[
> -				j + PREFETCH_OFFSET], void *));
> +				j + prefetch_offset], void *));
>  		l3fwd_lpm_simple_forward(pkts_burst[j], portid, qconf);
>  	}
>=20
> diff --git a/examples/l3fwd/l3fwd_lpm_neon.h b/examples/l3fwd/l3fwd_lpm_n=
eon.h
> index 3c1f827424..5570a11687 100644
> --- a/examples/l3fwd/l3fwd_lpm_neon.h
> +++ b/examples/l3fwd/l3fwd_lpm_neon.h
> @@ -85,23 +85,20 @@ l3fwd_lpm_process_packets(int nb_rx, struct rte_mbuf =
**pkts_burst,
>  			  uint16_t portid, uint16_t *dst_port,
>  			  struct lcore_conf *qconf, const uint8_t do_step3)
>  {
> -	int32_t i =3D 0, j =3D 0;
> +	int32_t i =3D 0, j =3D 0, pos =3D 0;
>  	int32x4_t dip;
>  	uint32_t ipv4_flag;
>  	const int32_t k =3D RTE_ALIGN_FLOOR(nb_rx, FWDSTEP);
>  	const int32_t m =3D nb_rx % FWDSTEP;
>=20
>  	if (k) {
> -		for (i =3D 0; i < FWDSTEP; i++) {
> -			rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[i],
> -							void *));
> -		}
> -		for (j =3D 0; j !=3D k - FWDSTEP; j +=3D FWDSTEP) {
> -			for (i =3D 0; i < FWDSTEP; i++) {
> -				rte_prefetch0(rte_pktmbuf_mtod(
> -						pkts_burst[j + i + FWDSTEP],
> -						void *));
> -			}
> +		for (i =3D 0; i < prefetch_offset && i < k; i++)
> +			rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[i], void *));
> +
> +		for (j =3D 0; j !=3D k; j +=3D FWDSTEP) {
> +			for (i =3D 0, pos =3D j + prefetch_offset;
> +			     i < FWDSTEP && pos < k; i++, pos++)
> +				rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[pos], void *));
>=20
>  			processx4_step1(&pkts_burst[j], &dip, &ipv4_flag);
>  			processx4_step2(qconf, dip, ipv4_flag, portid,
> @@ -109,35 +106,9 @@ l3fwd_lpm_process_packets(int nb_rx, struct rte_mbuf=
 **pkts_burst,
>  			if (do_step3)
>  				processx4_step3(&pkts_burst[j], &dst_port[j]);
>  		}
> -
> -		processx4_step1(&pkts_burst[j], &dip, &ipv4_flag);
> -		processx4_step2(qconf, dip, ipv4_flag, portid, &pkts_burst[j],
> -				&dst_port[j]);
> -		if (do_step3)
> -			processx4_step3(&pkts_burst[j], &dst_port[j]);
> -
> -		j +=3D FWDSTEP;
>  	}
>=20
>  	if (m) {
> -		/* Prefetch last up to 3 packets one by one */
> -		switch (m) {
> -		case 3:
> -			rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[j],
> -							void *));
> -			j++;
> -			/* fallthrough */
> -		case 2:
> -			rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[j],
> -							void *));
> -			j++;
> -			/* fallthrough */
> -		case 1:
> -			rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[j],
> -							void *));
> -			j++;
> -		}
> -		j -=3D m;
>  		/* Classify last up to 3 packets one by one */
>  		switch (m) {
>  		case 3:
> diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
> index 994b7dd8e5..0920c0b2f6 100644
> --- a/examples/l3fwd/main.c
> +++ b/examples/l3fwd/main.c
> @@ -59,6 +59,7 @@ uint16_t nb_rxd =3D RX_DESC_DEFAULT;
>  uint16_t nb_txd =3D TX_DESC_DEFAULT;
>  uint32_t nb_pkt_per_burst =3D DEFAULT_PKT_BURST;
>  uint32_t mb_mempool_cache_size =3D MEMPOOL_CACHE_SIZE;
> +uint16_t prefetch_offset =3D DEFAULT_PREFECH_OFFSET;
>=20
>  /**< Ports set in promiscuous mode off by default. */
>  static int promiscuous_on;
> @@ -769,6 +770,7 @@ static const char short_options[] =3D
>  #define CMD_LINE_OPT_ALG "alg"
>  #define CMD_LINE_OPT_PKT_BURST "burst"
>  #define CMD_LINE_OPT_MB_CACHE_SIZE "mbcache"
> +#define CMD_PREFETCH_OFFSET "prefetch-offset"
>=20
>  enum {
>  	/* long options mapped to a short option */
> @@ -800,6 +802,7 @@ enum {
>  	CMD_LINE_OPT_VECTOR_TMO_NS_NUM,
>  	CMD_LINE_OPT_PKT_BURST_NUM,
>  	CMD_LINE_OPT_MB_CACHE_SIZE_NUM,
> +	CMD_PREFETCH_OFFSET_NUM,
>  };
>=20
>  static const struct option lgopts[] =3D {
> @@ -828,6 +831,7 @@ static const struct option lgopts[] =3D {
>  	{CMD_LINE_OPT_ALG,   1, 0, CMD_LINE_OPT_ALG_NUM},
>  	{CMD_LINE_OPT_PKT_BURST,   1, 0, CMD_LINE_OPT_PKT_BURST_NUM},
>  	{CMD_LINE_OPT_MB_CACHE_SIZE,   1, 0, CMD_LINE_OPT_MB_CACHE_SIZE_NUM},
> +	{CMD_PREFETCH_OFFSET,   1, 0, CMD_PREFETCH_OFFSET_NUM},
>  	{NULL, 0, 0, 0}
>  };
>=20
> @@ -1017,6 +1021,9 @@ parse_args(int argc, char **argv)
>  		case CMD_LINE_OPT_ALG_NUM:
>  			l3fwd_set_alg(optarg);
>  			break;
> +		case CMD_PREFETCH_OFFSET_NUM:
> +			prefetch_offset =3D strtol(optarg, NULL, 10);

Hmm... might be something like parse_max_pkt_len() is doing, to be more rob=
ust?
In fact, probably can re-use the same function, might be just name it in a =
more generic way.
=20

> +			break;
>  		default:
>  			print_usage(prgname);
>  			return -1;
> @@ -1054,6 +1061,13 @@ parse_args(int argc, char **argv)
>  	}
>  #endif
>=20
> +	if (prefetch_offset > nb_pkt_per_burst) {
> +		fprintf(stderr, "Prefetch offset (%u) cannot be greater than burst siz=
e (%u). "
> +			"Using burst size %u.\n",
> +			prefetch_offset, nb_pkt_per_burst, nb_pkt_per_burst);
> +		prefetch_offset =3D nb_pkt_per_burst;

Might be just print err message and terminate gracefully?=20

> +	}
> +
>  	/*
>  	 * Nothing is selected, pick longest-prefix match
>  	 * as default match.
> --
> 2.33.0

