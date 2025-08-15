Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3DCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 15:36:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 585174026A;
	Fri, 15 Aug 2025 17:36:26 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 27AC8400EF
 for <dev@dpdk.org>; Fri, 15 Aug 2025 17:36:24 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b47173a7e52so1327752a12.1
 for <dev@dpdk.org>; Fri, 15 Aug 2025 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755272183; x=1755876983; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mz1Z7tRqGYAD8CcvzgrVIPmwBpY3GrotpxwsVJQHN0s=;
 b=EosVb0KqpPgKf8OqyB77qRZS/LE9BqV5TAqQVAXsA1aOQygTiNjXy4yu43qiVLdlHy
 tvnRCGueNYhrUEy/todFXwAPdvJR85q9H86vAZZQuJ6RGI+UmQNpPefm12DH/l/o8i/I
 Lz+wnhqECpIHJ+wgCtaqdtG64pnB3bG7a6ERc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755272183; x=1755876983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mz1Z7tRqGYAD8CcvzgrVIPmwBpY3GrotpxwsVJQHN0s=;
 b=BsH0QzkuCaFo63WpaXbgGRuz0oUAETxPH0+tE5y+wOtmaG6zx3PJkqWMHGN5jOl5Oz
 217bfeFvxeiL81NbSuerjpx4TTjD86p7Uz9ya4avqvN6RIaUXXKqVY2C5KLHkV6KqdcG
 pvZhqCSKO6qTV2QSpWck5uybxB+tuUqDLWSJQ6EC8ieZCRiGQ0JA4cHIp2EZ/+RwLtAG
 mfkDGpCtO+r4QVGtJoScVRTCNs5AOguuLy0t3cQbJiYSCF/qfF3GcKf6o7pJZ0mfCwqF
 xG1kO6BZJi08wj2SfTWdKJ6K2CWLpeVTQdvSqaVrRkeOVfO1ZHK1zcgwXvd5IIlyWGXS
 d9Nw==
X-Gm-Message-State: AOJu0YyyOYmig4vpNrFkRpdrprA6357fkJJNAL/ctPsaMDJ/cLAzBv/N
 g4h+zWHGGwKi6EIpnhY7TuLHGF/5umh9MVBGqBR7jp6AMRbVHFSWJIZ0lCcQhxUPOH2GPEyFTym
 XuRCJGtB/WLqJTDdbv3+LDVCMhw+2ZNvp0RvnC4cNbl+3RbttStzgzHg=
X-Gm-Gg: ASbGnctKEc5vYCTqZ2QpiGhgy+w2hsDVsRr3Cz0cWcwAo0wfC+CpqE0JTtRNQcsIROk
 Anbl6sP+IftbAaJ25D1AhuPXsaq/pbWI51C9bU7cTxkBepEm8CVtC+62S3vSCa5AYv3o59W3W+z
 d5Wy0BMPqNsUOWjUtuSQX382cempKZuHLANjUZXSSgFfLaGe93lSWXrzbH1Fe+uaa/ggenynkMg
 Aq3XavNizGFl1RBr/DMg4aOGTqaVwomDOC2dfkbvY+Ud5nG1fg=
X-Google-Smtp-Source: AGHT+IHlEIKB/ly2+aRnsxN0T3j2Q0ARNf9FVMCe8ZR3bJccyo0jEnnCS3GRwt0q/ckG0Xg8eWywX7Kzgjlj+y8EFmM=
X-Received: by 2002:a17:903:40cc:b0:23f:ecc1:ed6f with SMTP id
 d9443c01a7336-2446d720280mr37031135ad.17.1755272182787; Fri, 15 Aug 2025
 08:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
 <20250808165843.39075-10-stephen@networkplumber.org>
In-Reply-To: <20250808165843.39075-10-stephen@networkplumber.org>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 15 Aug 2025 11:29:57 -0400
X-Gm-Features: Ac12FXwzfdDd9pJV7zGZzmQfc3n4s0zBBvnbmhG_2gLa3gLWFZILIN6UsNEYboI
Message-ID: <CAJvnSUAqYff4N5Z7M3GhAXUxRJutN16T-1-PhS7NtphhfHqsKQ@mail.gmail.com>
Subject: Re: [PATCH v11 09/14] ethdev: add port mirroring feature
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000f08896063c692656"
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

--000000000000f08896063c692656
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sending a CI testing retest for this series because of a suspected false
failure on the vlan testsuite.

On Fri, Aug 8, 2025 at 12:59=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> This adds new feature port mirroring to the ethdev layer.
> And standalone tests for those features.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/meson.build             |   1 +
>  app/test/test_ethdev_mirror.c    | 325 ++++++++++++++++++++
>  config/rte_config.h              |   1 +
>  lib/ethdev/ethdev_driver.h       |   6 +
>  lib/ethdev/ethdev_private.c      |  58 +++-
>  lib/ethdev/ethdev_private.h      |   3 +
>  lib/ethdev/ethdev_trace.h        |  17 ++
>  lib/ethdev/ethdev_trace_points.c |   6 +
>  lib/ethdev/meson.build           |   2 +
>  lib/ethdev/rte_ethdev.c          |  17 +-
>  lib/ethdev/rte_ethdev.h          |  23 +-
>  lib/ethdev/rte_ethdev_core.h     |  12 +-
>  lib/ethdev/rte_mirror.c          | 508 +++++++++++++++++++++++++++++++
>  lib/ethdev/rte_mirror.h          | 147 +++++++++
>  14 files changed, 1108 insertions(+), 18 deletions(-)
>  create mode 100644 app/test/test_ethdev_mirror.c
>  create mode 100644 lib/ethdev/rte_mirror.c
>  create mode 100644 lib/ethdev/rte_mirror.h
>
> diff --git a/app/test/meson.build b/app/test/meson.build
> index f3ea3e2b74..87219b869e 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -73,6 +73,7 @@ source_file_deps =3D {
>      'test_errno.c': [],
>      'test_ethdev_api.c': ['ethdev'],
>      'test_ethdev_link.c': ['ethdev'],
> +    'test_ethdev_mirror.c': ['net_ring', 'ethdev', 'bus_vdev'],
>      'test_event_crypto_adapter.c': ['cryptodev', 'eventdev', 'bus_vdev']=
,
>      'test_event_dma_adapter.c': ['dmadev', 'eventdev', 'bus_vdev'],
>      'test_event_eth_rx_adapter.c': ['ethdev', 'eventdev', 'bus_vdev'],
> diff --git a/app/test/test_ethdev_mirror.c b/app/test/test_ethdev_mirror.=
c
> new file mode 100644
> index 0000000000..bbff1ff6a7
> --- /dev/null
> +++ b/app/test/test_ethdev_mirror.c
> @@ -0,0 +1,325 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
> + */
> +#include "test.h"
> +
> +#include <stdio.h>
> +
> +#include <rte_eth_ring.h>
> +#include <rte_ethdev.h>
> +#include <rte_bus_vdev.h>
> +
> +#define SOCKET0 0
> +#define RING_SIZE 256
> +#define BURST_SZ 64
> +#define NB_MBUF 512
> +
> +static struct rte_mempool *mirror_pool;
> +static const uint32_t pkt_len =3D 200;
> +
> +static struct rte_ring *rxtx_ring;
> +static const char ring_dev[] =3D "net_ring0";
> +static uint16_t ring_port;
> +static const char null_dev[] =3D "net_null0";
> +static uint16_t null_port;
> +
> +static int
> +configure_port(uint16_t port, const char *name)
> +{
> +       struct rte_eth_conf eth_conf =3D { 0 };
> +
> +       if (rte_eth_dev_configure(port, 1, 1, &eth_conf) < 0) {
> +               fprintf(stderr, "Configure failed for port %u: %s\n",
> port, name);
> +               return -1;
> +       }
> +
> +       /* only single queue */
> +       if (rte_eth_tx_queue_setup(port, 0, RING_SIZE, SOCKET0, NULL) < 0=
)
> {
> +               fprintf(stderr, "TX queue setup failed port %u: %s\n",
> port, name);
> +               return -1;
> +       }
> +
> +       if (rte_eth_rx_queue_setup(port, 0, RING_SIZE, SOCKET0, NULL,
> mirror_pool) < 0) {
> +               fprintf(stderr, "RX queue setup failed port %u: %s\n",
> port, name);
> +               return -1;
> +       }
> +
> +       if (rte_eth_dev_start(port) < 0) {
> +               fprintf(stderr, "Error starting port %u:%s\n", port, name=
);
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +static void
> +test_cleanup(void)
> +{
> +       rte_ring_free(rxtx_ring);
> +
> +       rte_vdev_uninit("net_ring");
> +       rte_vdev_uninit("net_null");
> +
> +       rte_mempool_free(mirror_pool);
> +}
> +
> +/* Make two virtual devices ring and null */
> +static int
> +test_setup(void)
> +{
> +       char null_name[] =3D "net_null0";
> +       int ret;
> +
> +       /* ring must support multiple enqueue for mirror to work */
> +       rxtx_ring =3D rte_ring_create("R0", RING_SIZE, SOCKET0,
> RING_F_MP_RTS_ENQ | RING_F_SC_DEQ);
> +       if (rxtx_ring =3D=3D NULL) {
> +               fprintf(stderr, "rte_ring_create R0 failed\n");
> +               goto fail;
> +       }
> +       ret =3D rte_eth_from_rings(ring_dev, &rxtx_ring, 1, &rxtx_ring, 1=
,
> SOCKET0);
> +       if (ret < 0) {
> +               fprintf(stderr, "rte_eth_from_rings failed\n");
> +               goto fail;
> +       }
> +       ring_port =3D ret;
> +
> +       /* Make a dummy null device to snoop on */
> +       if (rte_vdev_init(null_dev, NULL) !=3D 0) {
> +               fprintf(stderr, "Failed to create vdev '%s'\n", null_dev)=
;
> +               goto fail;
> +       }
> +       if (rte_eth_dev_get_port_by_name(null_dev, &null_port) !=3D 0) {
> +               fprintf(stderr, "cannot find added vdev %s\n", null_name)=
;
> +               goto fail;
> +       }
> +
> +       mirror_pool =3D rte_pktmbuf_pool_create("mirror_pool", NB_MBUF, 3=
2,
> +                                             0,
> RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
> +       if (mirror_pool =3D=3D NULL) {
> +               fprintf(stderr, "rte_pktmbuf_pool_create failed\n");
> +               goto fail;
> +       }
> +
> +       ret =3D configure_port(ring_port, ring_dev);
> +       if (ret < 0)
> +               goto fail;
> +
> +       ret =3D configure_port(null_port, null_dev);
> +       if (ret < 0)
> +               goto fail;
> +
> +       return 0;
> +fail:
> +       test_cleanup();
> +       return -1;
> +}
> +
> +/* Make sure mirror API checks args */
> +static int32_t
> +ethdev_mirror_api(void)
> +{
> +       struct rte_eth_mirror_conf conf =3D {
> +               .mp =3D mirror_pool,
> +               .flags =3D RTE_ETH_MIRROR_DIRECTION_EGRESS,
> +       };
> +       struct rte_eth_mirror_stats stats;
> +       uint16_t invalid_port =3D RTE_MAX_ETHPORTS;
> +       int ret;
> +
> +       conf.target =3D null_port;
> +       ret =3D rte_eth_add_mirror(invalid_port, &conf);
> +       TEST_ASSERT(ret !=3D 0, "Created mirror from invalid port");
> +
> +       conf.target =3D invalid_port;
> +       ret =3D rte_eth_add_mirror(null_port, &conf);
> +       TEST_ASSERT(ret !=3D 0, "Created mirror to invalid port");
> +
> +       conf.flags =3D 0;
> +       conf.target =3D ring_port;
> +       ret =3D rte_eth_add_mirror(null_port, &conf);
> +       TEST_ASSERT(ret !=3D 0, "Created mirror with invalid flags");
> +
> +       conf.flags =3D RTE_ETH_MIRROR_DIRECTION_INGRESS;
> +       conf.target =3D ring_port;
> +       ret =3D rte_eth_add_mirror(ring_port, &conf);
> +       TEST_ASSERT(ret !=3D 0, "Created mirror to self");
> +
> +       ret =3D rte_eth_mirror_stats_get(invalid_port, null_port, &stats)=
;
> +       TEST_ASSERT(ret !=3D 0, "Able to gets mirror stats from invalid
> port");
> +
> +       ret =3D rte_eth_mirror_stats_get(null_port, invalid_port, &stats)=
;
> +       TEST_ASSERT(ret !=3D 0, "Able to gets mirror stats from invalid
> target");
> +
> +       conf.target =3D null_port;
> +       ret =3D rte_eth_add_mirror(ring_port, &conf);
> +       TEST_ASSERT(ret =3D=3D 0, "Could not create mirror from ring to n=
ull");
> +
> +       ret =3D rte_eth_add_mirror(ring_port, &conf);
> +       TEST_ASSERT(ret !=3D 0, "Able to create duplicate mirror");
> +
> +       ret =3D rte_eth_mirror_stats_get(ring_port, null_port, NULL);
> +       TEST_ASSERT(ret =3D=3D -EINVAL, "Able to get status with NULL");
> +
> +       ret =3D rte_eth_mirror_stats_get(null_port, ring_port, &stats);
> +       TEST_ASSERT(ret !=3D 0, "Able to get stats with swapped ports");
> +
> +       ret =3D rte_eth_mirror_stats_get(ring_port, null_port, &stats);
> +       TEST_ASSERT(ret =3D=3D 0, "Could not get stats");
> +
> +       ret =3D rte_eth_remove_mirror(ring_port, null_port);
> +       TEST_ASSERT(ret =3D=3D 0, "Unable to delete mirror");
> +
> +       ret =3D rte_eth_remove_mirror(ring_port, null_port);
> +       TEST_ASSERT(ret !=3D 0, "Able to delete port without mirror");
> +
> +       return 0;
> +}
> +
> +static int
> +init_mbuf(struct rte_mbuf *m, uint16_t id)
> +{
> +       struct {
> +               struct rte_ether_hdr eth;
> +               struct rte_ipv4_hdr ip;
> +               struct rte_udp_hdr udp;
> +       } hdrs =3D {
> +               .eth =3D {
> +                       .dst_addr.addr_bytes =3D { 0xff, 0xff, 0xff, 0xff=
,
> 0xff, 0xff },
> +                       .ether_type =3D
> rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4),
> +               },
> +               .ip =3D {
> +                       .version_ihl =3D RTE_IPV4_VHL_DEF,
> +                       .time_to_live =3D 1,
> +                       .next_proto_id =3D IPPROTO_UDP,
> +                       .src_addr =3D rte_cpu_to_be_32(RTE_IPV4_LOOPBACK)=
,
> +                       .dst_addr =3D rte_cpu_to_be_32(RTE_IPV4_BROADCAST=
),
> +               },
> +               .udp =3D {
> +                       .dst_port =3D rte_cpu_to_be_16(9), /* Discard por=
t */
> +               },
> +       };
> +
> +       rte_eth_random_addr(hdrs.eth.src_addr.addr_bytes);
> +       uint16_t plen =3D pkt_len - sizeof(struct rte_ether_hdr);
> +
> +       hdrs.ip.packet_id =3D rte_cpu_to_be_16(id);
> +       hdrs.ip.total_length =3D rte_cpu_to_be_16(plen);
> +       hdrs.ip.hdr_checksum =3D rte_ipv4_cksum(&hdrs.ip);
> +
> +       plen -=3D sizeof(struct rte_ipv4_hdr);
> +       hdrs.udp.src_port =3D rte_rand();
> +       hdrs.udp.dgram_len =3D rte_cpu_to_be_16(plen);
> +
> +       void *data =3D rte_pktmbuf_append(m, pkt_len);
> +       TEST_ASSERT(data !=3D NULL, "could not add header");
> +
> +       memcpy(data, &hdrs, sizeof(hdrs));
> +       return 0;
> +}
> +
> +static int
> +init_burst(struct rte_mbuf *pkts[], unsigned int n)
> +{
> +       for (unsigned int i =3D 0; i < n; i++) {
> +               if (init_mbuf(pkts[i], i) < 0)
> +                       return -1;
> +       }
> +       return 0;
> +}
> +
> +static int
> +validate_burst(struct rte_mbuf *pkts[], unsigned int n)
> +{
> +       for (unsigned int i =3D 0; i < n; i++) {
> +               struct rte_mbuf *m =3D pkts[i];
> +
> +               rte_mbuf_sanity_check(m, 1);
> +               TEST_ASSERT(m->pkt_len =3D=3D pkt_len,
> +                           "mirror packet len %u not right len %u",
> +                           m->pkt_len, pkt_len);
> +
> +               const struct rte_ether_hdr *eh
> +                       =3D rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
> +               TEST_ASSERT(rte_is_broadcast_ether_addr(&eh->dst_addr),
> +                           "mirrored packet is not broadcast");
> +
> +       }
> +       return 0;
> +}
> +
> +static int32_t
> +ethdev_mirror_packets(void)
> +{
> +       struct rte_eth_mirror_conf conf =3D {
> +               .mp =3D mirror_pool,
> +               .target =3D ring_port,
> +               .flags =3D RTE_ETH_MIRROR_DIRECTION_EGRESS,
> +       };
> +       struct rte_eth_mirror_stats stats;
> +       struct rte_mbuf *tx_pkts[BURST_SZ], *rx_pkts[BURST_SZ];
> +       uint16_t nb_tx, nb_rx;
> +       int ret;
> +
> +       ret =3D rte_pktmbuf_alloc_bulk(mirror_pool, tx_pkts, BURST_SZ);
> +       TEST_ASSERT(ret =3D=3D 0, "Could not allocate mbufs");
> +
> +       ret =3D init_burst(tx_pkts, BURST_SZ);
> +       TEST_ASSERT(ret =3D=3D 0, "Init mbufs failed");
> +
> +       ret =3D rte_eth_add_mirror(null_port, &conf);
> +       TEST_ASSERT(ret =3D=3D 0, "Could not create mirror from ring to n=
ull");
> +
> +       nb_tx =3D rte_eth_tx_burst(null_port, 0, tx_pkts, BURST_SZ);
> +       TEST_ASSERT(nb_tx =3D=3D BURST_SZ, "Only sent %u burst to null (v=
s
> %u)",
> +                   nb_tx, BURST_SZ);
> +
> +       nb_rx =3D rte_eth_rx_burst(ring_port, 0, rx_pkts, BURST_SZ);
> +       TEST_ASSERT(nb_rx =3D=3D BURST_SZ, "Only received %u of %u packet=
s",
> +                   nb_rx, BURST_SZ);
> +
> +       validate_burst(rx_pkts, nb_rx);
> +       rte_pktmbuf_free_bulk(rx_pkts, nb_rx);
> +
> +       ret =3D rte_eth_mirror_stats_get(null_port, ring_port, &stats);
> +       TEST_ASSERT(ret =3D=3D 0, "Could not get stats: %d", ret);
> +
> +       TEST_ASSERT(stats.packets =3D=3D BURST_SZ, "Stats reports %"PRIu6=
4" of
> %u packets",
> +                   stats.packets, BURST_SZ);
> +       TEST_ASSERT(stats.nombuf =3D=3D 0, "Stats: no mbufs %"PRIu64,
> stats.nombuf);
> +       TEST_ASSERT(stats.full =3D=3D 0, "Stats: transmit was full %"PRIu=
64,
> stats.full);
> +
> +       ret =3D rte_eth_mirror_stats_reset(null_port, ring_port);
> +       TEST_ASSERT(ret =3D=3D 0, "Could not get stats: %d", ret);
> +
> +       ret =3D rte_eth_mirror_stats_get(null_port, ring_port, &stats);
> +       TEST_ASSERT(ret =3D=3D 0, "Could not get stats after reset: %d", =
ret);
> +
> +       TEST_ASSERT(stats.packets =3D=3D 0, "Stats reports %"PRIu64" afte=
r
> reset", stats.packets);
> +
> +       ret =3D rte_eth_remove_mirror(null_port, ring_port);
> +       TEST_ASSERT(ret =3D=3D 0, "Could not remove mirror");
> +
> +       return 0;
> +}
> +
> +static struct unit_test_suite ethdev_mirror_suite =3D {
> +       .suite_name =3D "port mirroring",
> +       .setup =3D test_setup,
> +       .teardown =3D test_cleanup,
> +       .unit_test_cases =3D {
> +               TEST_CASE(ethdev_mirror_api),
> +               TEST_CASE(ethdev_mirror_packets),
> +               TEST_CASES_END()
> +       }
> +};
> +
> +static int
> +test_ethdev_mirror(void)
> +{
> +#ifndef RTE_ETHDEV_MIRROR
> +       return TEST_SKIPPED;
> +#endif
> +       return unit_test_suite_runner(&ethdev_mirror_suite);
> +}
> +
> +REGISTER_FAST_TEST(ethdev_mirror, true, true, test_ethdev_mirror);
> diff --git a/config/rte_config.h b/config/rte_config.h
> index 05344e2619..76eb2aa417 100644
> --- a/config/rte_config.h
> +++ b/config/rte_config.h
> @@ -69,6 +69,7 @@
>  #define RTE_MAX_QUEUES_PER_PORT 1024
>  #define RTE_ETHDEV_QUEUE_STAT_CNTRS 16 /* max 256 */
>  #define RTE_ETHDEV_RXTX_CALLBACKS 1
> +#define RTE_ETHDEV_MIRROR 1
>  #define RTE_MAX_MULTI_HOST_CTRLS 4
>
>  /* cryptodev defines */
> diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
> index 2b4d2ae9c3..e6aad6d30a 100644
> --- a/lib/ethdev/ethdev_driver.h
> +++ b/lib/ethdev/ethdev_driver.h
> @@ -91,6 +91,12 @@ struct __rte_cache_aligned rte_eth_dev {
>          */
>         RTE_ATOMIC(struct rte_eth_rxtx_callback *)
> pre_tx_burst_cbs[RTE_MAX_QUEUES_PER_PORT];
>
> +       /** Receive mirrors */
> +       RTE_ATOMIC(struct rte_eth_mirror *) rx_mirror;
> +
> +       /** Transmit mirrors */
> +       RTE_ATOMIC(struct rte_eth_mirror *) tx_mirror;
> +
>         enum rte_eth_dev_state state; /**< Flag indicating the port state
> */
>         void *security_ctx; /**< Context for security ops */
>  };
> diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
> index 000b8372d8..e702acc874 100644
> --- a/lib/ethdev/ethdev_private.c
> +++ b/lib/ethdev/ethdev_private.c
> @@ -289,6 +289,8 @@ eth_dev_fp_ops_setup(struct rte_eth_fp_ops *fpo,
>         fpo->tx_descriptor_status =3D dev->tx_descriptor_status;
>         fpo->recycle_tx_mbufs_reuse =3D dev->recycle_tx_mbufs_reuse;
>         fpo->recycle_rx_descriptors_refill =3D
> dev->recycle_rx_descriptors_refill;
> +       fpo->rx_mirror =3D (struct rte_eth_mirror * __rte_atomic
> *)(uintptr_t)&dev->rx_mirror;
> +       fpo->tx_mirror =3D (struct rte_eth_mirror * __rte_atomic
> *)(uintptr_t)&dev->tx_mirror;
>
>         fpo->rxq.data =3D dev->data->rx_queues;
>         fpo->rxq.clbk =3D (void * __rte_atomic
> *)(uintptr_t)dev->post_rx_burst_cbs;
> @@ -490,17 +492,53 @@ eth_dev_tx_queue_config(struct rte_eth_dev *dev,
> uint16_t nb_queues)
>  }
>
>  static int
> -ethdev_handle_request(const struct ethdev_mp_request *req)
> +ethdev_handle_request(const struct ethdev_mp_request *req, size_t len)
>  {
> +       len -=3D sizeof(*req);
> +
>         switch (req->operation) {
>         case ETH_REQ_START:
> +               if (len !=3D 0)
> +                       return -EINVAL;
> +
>                 return rte_eth_dev_start(req->port_id);
>
>         case ETH_REQ_STOP:
> +               if (len !=3D 0)
> +                       return -EINVAL;
>                 return rte_eth_dev_stop(req->port_id);
>
> +       case ETH_REQ_RESET:
> +               if (len !=3D 0)
> +                       return -EINVAL;
> +               return rte_eth_dev_reset(req->port_id);
> +
> +       case ETH_REQ_ADD_MIRROR:
> +               if (len !=3D sizeof(struct rte_eth_mirror_conf)) {
> +                       RTE_ETHDEV_LOG_LINE(ERR,
> +                                   "add mirror conf wrong size %zu", len=
);
> +                       return -EINVAL;
> +               }
> +
> +               const struct rte_eth_mirror_conf *conf
> +                       =3D (const struct rte_eth_mirror_conf *) req->con=
fig;
> +
> +               return rte_eth_add_mirror(req->port_id, conf);
> +
> +       case ETH_REQ_REMOVE_MIRROR:
> +               if (len !=3D sizeof(uint16_t)) {
> +                       RTE_ETHDEV_LOG_LINE(ERR,
> +                                   "mirror remove wrong size %zu", len);
> +                       return -EINVAL;
> +               }
> +
> +               uint16_t target =3D *(const uint16_t *) req->config;
> +               return rte_eth_remove_mirror(req->port_id, target);
> +
>         default:
> -               return -EINVAL;
> +               RTE_ETHDEV_LOG_LINE(ERR,
> +                           "Unknown mp request operation %u",
> req->operation);
> +               return -ENOTSUP;
>         }
>  }
>
> @@ -513,23 +551,25 @@ static_assert(sizeof(struct ethdev_mp_response) <=
=3D
> RTE_MP_MAX_PARAM_LEN,
>  int
>  ethdev_server(const struct rte_mp_msg *mp_msg, const void *peer)
>  {
> -       const struct ethdev_mp_request *req
> -               =3D (const struct ethdev_mp_request *)mp_msg->param;
> -
>         struct rte_mp_msg mp_resp =3D {
>                 .name =3D ETHDEV_MP,
>         };
>         struct ethdev_mp_response *resp;
> +       const struct ethdev_mp_request *req;
>
>         resp =3D (struct ethdev_mp_response *)mp_resp.param;
>         mp_resp.len_param =3D sizeof(*resp);
> -       resp->res_op =3D req->operation;
>
>         /* recv client requests */
> -       if (mp_msg->len_param !=3D sizeof(*req))
> +       if (mp_msg->len_param < (int)sizeof(*req)) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "invalid request from secondary"=
);
>                 resp->err_value =3D -EINVAL;
> -       else
> -               resp->err_value =3D ethdev_handle_request(req);
> +       } else {
> +               req =3D (const struct ethdev_mp_request *)mp_msg->param;
> +               resp->res_op =3D req->operation;
> +               resp->err_value =3D ethdev_handle_request(req,
> mp_msg->len_param);
> +
> +       }
>
>         return rte_mp_reply(&mp_resp, peer);
>  }
> diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
> index f58f161871..d2fdc20057 100644
> --- a/lib/ethdev/ethdev_private.h
> +++ b/lib/ethdev/ethdev_private.h
> @@ -85,6 +85,9 @@ int eth_dev_tx_queue_config(struct rte_eth_dev *dev,
> uint16_t nb_queues);
>  enum ethdev_mp_operation {
>         ETH_REQ_START,
>         ETH_REQ_STOP,
> +       ETH_REQ_RESET,
> +       ETH_REQ_ADD_MIRROR,
> +       ETH_REQ_REMOVE_MIRROR,
>  };
>
>  struct ethdev_mp_request {
> diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
> index 482befc209..e137afcbf7 100644
> --- a/lib/ethdev/ethdev_trace.h
> +++ b/lib/ethdev/ethdev_trace.h
> @@ -1035,6 +1035,23 @@ RTE_TRACE_POINT(
>         rte_trace_point_emit_int(ret);
>  )
>
> +RTE_TRACE_POINT(
> +       rte_eth_trace_add_mirror,
> +       RTE_TRACE_POINT_ARGS(uint16_t port_id,
> +                            const struct rte_eth_mirror_conf *conf, int
> ret),
> +       rte_trace_point_emit_u16(port_id);
> +       rte_trace_point_emit_u16(conf->target);
> +       rte_trace_point_emit_int(ret);
> +)
> +
> +RTE_TRACE_POINT(
> +       rte_eth_trace_remove_mirror,
> +       RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t target_id, int
> ret),
> +       rte_trace_point_emit_u16(port_id);
> +       rte_trace_point_emit_u16(target_id);
> +       rte_trace_point_emit_int(ret);
> +)
> +
>  RTE_TRACE_POINT(
>         rte_eth_trace_rx_queue_info_get,
>         RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t queue_id,
> diff --git a/lib/ethdev/ethdev_trace_points.c
> b/lib/ethdev/ethdev_trace_points.c
> index 071c508327..fa1fd21809 100644
> --- a/lib/ethdev/ethdev_trace_points.c
> +++ b/lib/ethdev/ethdev_trace_points.c
> @@ -389,6 +389,12 @@
> RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_rx_callback,
>  RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_tx_callback,
>         lib.ethdev.remove_tx_callback)
>
> +RTE_TRACE_POINT_REGISTER(rte_eth_trace_add_mirror,
> +       lib.ethdev.add_mirror)
> +
> +RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_mirror,
> +       lib.ethdev.remove_mirror)
> +
>  RTE_TRACE_POINT_REGISTER(rte_eth_trace_rx_queue_info_get,
>         lib.ethdev.rx_queue_info_get)
>
> diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
> index 1d68d5348c..eb624bd579 100644
> --- a/lib/ethdev/meson.build
> +++ b/lib/ethdev/meson.build
> @@ -11,6 +11,7 @@ sources =3D files(
>          'rte_ethdev_cman.c',
>          'rte_ethdev_telemetry.c',
>          'rte_flow.c',
> +        'rte_mirror.c',
>          'rte_mtr.c',
>          'rte_tm.c',
>          'sff_telemetry.c',
> @@ -27,6 +28,7 @@ headers =3D files(
>          'rte_dev_info.h',
>          'rte_flow.h',
>          'rte_flow_driver.h',
> +        'rte_mirror.h',
>          'rte_mtr.h',
>          'rte_mtr_driver.h',
>          'rte_tm.h',
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index adeec575be..ac889c220a 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -14,6 +14,8 @@
>  #include <bus_driver.h>
>  #include <eal_export.h>
>  #include <rte_log.h>
> +#include <rte_cycles.h>
> +#include <rte_alarm.h>
>  #include <rte_interrupts.h>
>  #include <rte_kvargs.h>
>  #include <rte_memcpy.h>
> @@ -2041,13 +2043,16 @@ rte_eth_dev_reset(uint16_t port_id)
>         if (dev->dev_ops->dev_reset =3D=3D NULL)
>                 return -ENOTSUP;
>
> -       ret =3D rte_eth_dev_stop(port_id);
> -       if (ret !=3D 0) {
> -               RTE_ETHDEV_LOG_LINE(ERR,
> -                       "Failed to stop device (port %u) before reset: %s
> - ignore",
> -                       port_id, rte_strerror(-ret));
> +       if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> +               ret =3D rte_eth_dev_stop(port_id);
> +               if (ret !=3D 0)
> +                       RTE_ETHDEV_LOG_LINE(ERR,
> +                                   "Failed to stop device (port %u)
> before reset: %s - ignore",
> +                                   port_id, rte_strerror(-ret));
> +               ret =3D eth_err(port_id, dev->dev_ops->dev_reset(dev));
> +       } else {
> +               ret =3D ethdev_request(port_id, ETH_REQ_STOP, NULL, 0);
>         }
> -       ret =3D eth_err(port_id, dev->dev_ops->dev_reset(dev));
>
>         rte_ethdev_trace_reset(port_id, ret);
>
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index f9fb6ae549..84801a1123 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -170,6 +170,7 @@
>
>  #include "rte_ethdev_trace_fp.h"
>  #include "rte_dev_info.h"
> +#include "rte_mirror.h"
>
>  #ifdef __cplusplus
>  extern "C" {
> @@ -1466,7 +1467,6 @@ enum rte_eth_tunnel_type {
>         RTE_ETH_TUNNEL_TYPE_ECPRI,
>         RTE_ETH_TUNNEL_TYPE_MAX,
>  };
> -
>  #ifdef __cplusplus
>  }
>  #endif
> @@ -6334,6 +6334,17 @@ rte_eth_rx_burst(uint16_t port_id, uint16_t
> queue_id,
>
>         nb_rx =3D p->rx_pkt_burst(qd, rx_pkts, nb_pkts);
>
> +#ifdef RTE_ETHDEV_MIRROR
> +       {
> +               struct rte_eth_mirror *mirror
> +                       =3D rte_atomic_load_explicit(p->rx_mirror,
> rte_memory_order_relaxed);
> +
> +               if (unlikely(mirror !=3D NULL))
> +                       rte_eth_mirror_burst(port_id, queue_id,
> RTE_ETH_MIRROR_DIRECTION_INGRESS,
> +                                            rx_pkts, nb_rx, mirror);
> +       }
> +#endif
> +
>  #ifdef RTE_ETHDEV_RXTX_CALLBACKS
>         {
>                 void *cb;
> @@ -6692,6 +6703,16 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t
> queue_id,
>         }
>  #endif
>
> +#ifdef RTE_ETHDEV_MIRROR
> +       {
> +               struct rte_eth_mirror *mirror;
> +
> +               mirror =3D rte_atomic_load_explicit(p->tx_mirror,
> rte_memory_order_relaxed);
> +               if (unlikely(mirror !=3D NULL))
> +                       rte_eth_mirror_burst(port_id, queue_id,
> RTE_ETH_MIRROR_DIRECTION_EGRESS,
> +                                            tx_pkts, nb_pkts, mirror);
> +       }
> +#endif
>         nb_pkts =3D p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
>
>         rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts,
> nb_pkts);
> diff --git a/lib/ethdev/rte_ethdev_core.h b/lib/ethdev/rte_ethdev_core.h
> index e55fb42996..2ca1beb239 100644
> --- a/lib/ethdev/rte_ethdev_core.h
> +++ b/lib/ethdev/rte_ethdev_core.h
> @@ -22,6 +22,12 @@ RTE_TAILQ_HEAD(rte_eth_dev_cb_list,
> rte_eth_dev_callback);
>
>  struct rte_eth_dev;
>
> +struct rte_eth_mirror;
> +
> +void rte_eth_mirror_burst(uint16_t port_id, uint16_t quque_id, uint8_t
> dir,
> +                         struct rte_mbuf **pkts, uint16_t nb_pkts,
> +                         struct rte_eth_mirror *mirror);
> +
>  /**
>   * @internal Retrieve input packets from a receive queue of an Ethernet
> device.
>   */
> @@ -101,7 +107,8 @@ struct __rte_cache_aligned rte_eth_fp_ops {
>         eth_rx_descriptor_status_t rx_descriptor_status;
>         /** Refill Rx descriptors with the recycling mbufs. */
>         eth_recycle_rx_descriptors_refill_t recycle_rx_descriptors_refill=
;
> -       uintptr_t reserved1[2];
> +       uintptr_t reserved1;
> +       RTE_ATOMIC(struct rte_eth_mirror *) *rx_mirror;
>         /**@}*/
>
>         /**@{*/
> @@ -121,7 +128,8 @@ struct __rte_cache_aligned rte_eth_fp_ops {
>         eth_recycle_tx_mbufs_reuse_t recycle_tx_mbufs_reuse;
>         /** Get the number of used Tx descriptors. */
>         eth_tx_queue_count_t tx_queue_count;
> -       uintptr_t reserved2[1];
> +       RTE_ATOMIC(struct rte_eth_mirror *) *tx_mirror;
> +       uintptr_t reserved2;
>         /**@}*/
>
>  };
> diff --git a/lib/ethdev/rte_mirror.c b/lib/ethdev/rte_mirror.c
> new file mode 100644
> index 0000000000..27b613b8ff
> --- /dev/null
> +++ b/lib/ethdev/rte_mirror.c
> @@ -0,0 +1,508 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
> + */
> +
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include <rte_alarm.h>
> +#include <rte_bitops.h>
> +#include <rte_common.h>
> +#include <rte_config.h>
> +#include <rte_cycles.h>
> +#include <rte_eal.h>
> +#include <rte_ether.h>
> +#include <rte_log.h>
> +#include <rte_malloc.h>
> +#include <rte_mbuf.h>
> +#include <rte_spinlock.h>
> +#include <rte_stdatomic.h>
> +#include <eal_export.h>
> +
> +#include "rte_ethdev.h"
> +#include "rte_mirror.h"
> +#include "ethdev_driver.h"
> +#include "ethdev_private.h"
> +#include "ethdev_trace.h"
> +
> +/* Upper bound of packet bursts redirected */
> +#define RTE_MIRROR_BURST_SIZE 64
> +
> +#ifdef RTE_LIB_BPF
> +#include <rte_bpf.h>
> +#endif
> +
> +/**
> + * Structure used to hold information mirror port mirrors for a
> + * queue on Rx and Tx.
> + */
> +struct rte_eth_mirror {
> +       RTE_ATOMIC(struct rte_eth_mirror *) next;
> +       struct rte_mempool *mp;
> +       struct rte_bpf *bpf;
> +       uint32_t snaplen;
> +       uint32_t flags;
> +       uint16_t target;
> +       uint16_t tx_queues;
> +       bool     need_lock;
> +       rte_spinlock_t lock;
> +       struct rte_eth_mirror_stats stats;
> +};
> +
> +/* spinlock for setting up mirror ports */
> +static rte_spinlock_t mirror_port_lock =3D RTE_SPINLOCK_INITIALIZER;
> +
> +/* dynamically assigned offload flag to indicate ingress vs egress */
> +static uint64_t mirror_origin_flag;
> +static int mirror_origin_offset =3D -1;
> +static uint64_t mirror_ingress_flag;
> +static uint64_t mirror_egress_flag;
> +
> +static uint64_t mbuf_timestamp_dynflag;
> +static int mbuf_timestamp_offset =3D -1;
> +
> +/* register dynamic mbuf fields, done on first mirror creation */
> +static int
> +ethdev_dyn_mirror_register(void)
> +{
> +       const struct rte_mbuf_dynfield field_desc =3D {
> +               .name =3D RTE_MBUF_DYNFIELD_MIRROR_ORIGIN,
> +               .size =3D sizeof(rte_mbuf_origin_t),
> +               .align =3D sizeof(rte_mbuf_origin_t),
> +       };
> +       struct rte_mbuf_dynflag flag_desc =3D {
> +               .name =3D RTE_MBUF_DYNFLAG_MIRROR_ORIGIN,
> +       };
> +       int offset;
> +
> +       if (rte_mbuf_dyn_tx_timestamp_register(&mbuf_timestamp_offset,
> +                                              &mbuf_timestamp_dynflag) <
> 0) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "Failed to register timestamp
> flag");
> +               return -1;
> +       }
> +
> +       offset =3D rte_mbuf_dynfield_register(&field_desc);
> +       if (offset < 0) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf origin
> field");
> +               return -1;
> +       }
> +       mirror_origin_offset =3D offset;
> +
> +       offset =3D rte_mbuf_dynflag_register(&flag_desc);
> +       if (offset < 0) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf origin
> flag");
> +               return -1;
> +       }
> +       mirror_origin_flag =3D RTE_BIT64(offset);
> +
> +       strlcpy(flag_desc.name, RTE_MBUF_DYNFLAG_MIRROR_INGRESS, sizeof(
> flag_desc.name));
> +       offset =3D rte_mbuf_dynflag_register(&flag_desc);
> +       if (offset < 0) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf ingress
> flag");
> +               return -1;
> +       }
> +       mirror_ingress_flag =3D RTE_BIT64(offset);
> +
> +       strlcpy(flag_desc.name, RTE_MBUF_DYNFLAG_MIRROR_EGRESS,
> +               sizeof(flag_desc.name));
> +       offset =3D rte_mbuf_dynflag_register(&flag_desc);
> +       if (offset < 0) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf egress
> flag");
> +               return -1;
> +       }
> +       mirror_egress_flag =3D RTE_BIT64(offset);
> +
> +       return 0;
> +}
> +
> +/* Add a new mirror entry to the list. */
> +static int
> +ethdev_insert_mirror(RTE_ATOMIC(struct rte_eth_mirror *) *top,
> +                    const struct rte_eth_mirror_conf *conf,
> +                    const struct rte_eth_dev_info *info)
> +{
> +       struct rte_eth_mirror *mirror;
> +       ssize_t filter_len =3D 0;
> +
> +       /* Don't allow multiple mirrors from same source to target */
> +       while ((mirror =3D *top) !=3D NULL) {
> +               if (mirror->target =3D=3D conf->target) {
> +                       RTE_ETHDEV_LOG_LINE(ERR,
> +                                   "Mirror to port %u already exists",
> conf->target);
> +                       return -EEXIST;
> +               }
> +       }
> +
> +       if (conf->filter) {
> +#ifdef RTE_LIB_BPF
> +               filter_len =3D rte_bpf_buf_size(conf->filter);
> +               if (filter_len < 0) {
> +                       RTE_ETHDEV_LOG_LINE(ERR, "Invalid BPF filter: %s"=
,
> +                                           rte_strerror(rte_errno));
> +                       return -EINVAL;
> +               }
> +#else
> +               RTE_ETHDEV_LOG_LINE(ERR, "BPF filter not supported");
> +               return -ENOTSUP;
> +#endif
> +       }
> +
> +       /*
> +        * Allocate space for both fast path mirror structure
> +        * and filter bpf code (if any).
> +        */
> +       mirror =3D rte_zmalloc(NULL, sizeof(*mirror) + filter_len, 0);
> +       if (mirror =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       mirror->mp =3D conf->mp;
> +       mirror->target =3D conf->target;
> +       mirror->flags =3D conf->flags;
> +       rte_spinlock_init(&mirror->lock);
> +       mirror->need_lock =3D !(info->tx_offload_capa &
> RTE_ETH_TX_OFFLOAD_MT_LOCKFREE);
> +       mirror->tx_queues =3D info->nb_tx_queues;
> +
> +       if (conf->snaplen =3D=3D 0) /* specifying 0 implies the full pack=
et */
> +               mirror->snaplen =3D UINT32_MAX;
> +       else
> +               mirror->snaplen =3D conf->snaplen;
> +
> +#ifdef RTE_LIB_BPF
> +       if (filter_len > 0) {
> +               /* reserved space for BPF is after mirror structure */
> +               void *buf =3D (uint8_t *)mirror + sizeof(*mirror);
> +
> +               /*
> +                * Copy filter internal representation into space
> +                * allocated in huge pages to allow access from any
> process.
> +                */
> +               mirror->bpf =3D rte_bpf_buf_load(conf->filter, buf,
> filter_len);
> +               if (mirror->bpf =3D=3D NULL) {
> +                       RTE_ETHDEV_LOG_LINE(ERR, "Failed to load BPF
> filter: %s",
> +                                           rte_strerror(rte_errno));
> +                       rte_free(mirror);
> +                       return -EINVAL;
> +               }
> +
> +       }
> +#endif
> +
> +       mirror->next =3D *top;
> +
> +       rte_atomic_store_explicit(top, mirror, rte_memory_order_relaxed);
> +       return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_add_mirror, 25.11)
> +int
> +rte_eth_add_mirror(uint16_t port_id, const struct rte_eth_mirror_conf
> *conf)
> +{
> +#ifndef RTE_ETHDEV_MIRROR
> +       return -ENOTSUP;
> +#endif
> +
> +       RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +
> +       struct rte_eth_dev *dev =3D &rte_eth_devices[port_id];
> +       struct rte_eth_dev_info dev_info;
> +
> +       if (conf =3D=3D NULL) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "Missing configuration
> information");
> +               return -EINVAL;
> +       }
> +
> +       if (conf->mp =3D=3D NULL) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "not a valid mempool");
> +               return -EINVAL;
> +       }
> +
> +       if (conf->flags & ~(RTE_ETH_MIRROR_DIRECTION_MASK |
> RTE_ETH_MIRROR_FLAG_MASK)) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "unsupported flags");
> +               return -EINVAL;
> +       }
> +
> +       if ((conf->flags & RTE_ETH_MIRROR_DIRECTION_MASK) =3D=3D 0) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "missing direction ingress or
> egress");
> +               return -EINVAL;
> +       }
> +
> +       /* Checks that target exists */
> +       int ret =3D rte_eth_dev_info_get(conf->target, &dev_info);
> +       if (ret !=3D 0)
> +               return ret;
> +
> +       /* Loopback mirror could create packet storm */
> +       if (conf->target =3D=3D port_id) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "Cannot mirror port to self");
> +               return -EINVAL;
> +       }
> +
> +       if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> +               /* Register dynamic fields once */
> +               if (mirror_origin_offset < 0) {
> +                       ret =3D ethdev_dyn_mirror_register();
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +
> +               rte_spinlock_lock(&mirror_port_lock);
> +               ret =3D 0;
> +
> +               if (conf->flags & RTE_ETH_MIRROR_DIRECTION_INGRESS)
> +                       ret =3D ethdev_insert_mirror(&dev->rx_mirror, con=
f,
> &dev_info);
> +               if (ret =3D=3D 0 && (conf->flags &
> RTE_ETH_MIRROR_DIRECTION_EGRESS))
> +                       ret =3D ethdev_insert_mirror(&dev->tx_mirror, con=
f,
> &dev_info);
> +               rte_spinlock_unlock(&mirror_port_lock);
> +       } else {
> +               /* in secondary, proxy to primary */
> +               ret =3D ethdev_request(port_id, ETH_REQ_ADD_MIRROR, conf,
> sizeof(*conf));
> +               if (ret !=3D 0)
> +                       return ret;
> +       }
> +
> +       rte_eth_trace_add_mirror(port_id, conf, ret);
> +       return ret;
> +}
> +
> +static struct rte_eth_mirror *
> +ethdev_find_mirror(RTE_ATOMIC(struct rte_eth_mirror *) *head, uint16_t
> target_id)
> +{
> +
> +       for (;;) {
> +               struct rte_eth_mirror *mirror
> +                       =3D rte_atomic_load_explicit(head,
> rte_memory_order_relaxed);
> +               if (mirror =3D=3D NULL)
> +                       return NULL;    /* reached end of list */
> +
> +               if (mirror->target =3D=3D target_id)
> +                       return mirror;
> +
> +               head =3D &mirror->next;
> +       }
> +}
> +
> +static bool
> +ethdev_delete_mirror(RTE_ATOMIC(struct rte_eth_mirror *) *top, uint16_t
> target_id)
> +{
> +       struct rte_eth_mirror *mirror;
> +
> +       mirror =3D ethdev_find_mirror(top, target_id);
> +       if (mirror =3D=3D NULL)
> +               return false;
> +
> +       /* unlink from list */
> +       rte_atomic_store_explicit(top, mirror->next,
> rte_memory_order_relaxed);
> +
> +       /*
> +        * Defer freeing the mirror until after one second to allow for
> active threads
> +        * that are using it. Assumes no PMD takes more than one second t=
o
> transmit a burst.
> +        * Alternative would be RCU, but RCU in DPDK is optional and
> requires application changes.
> +        */
> +       rte_eal_alarm_set(US_PER_S, rte_free, mirror);
> +       return true;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_remove_mirror, 25.11)
> +int
> +rte_eth_remove_mirror(uint16_t port_id, uint16_t target_id)
> +{
> +#ifndef RTE_ETHDEV_MIRROR
> +       return -ENOTSUP;
> +#endif
> +       int ret =3D 0;
> +
> +       RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +       RTE_ETH_VALID_PORTID_OR_ERR_RET(target_id, -ENODEV);
> +
> +       struct rte_eth_dev *dev =3D &rte_eth_devices[port_id];
> +
> +       if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> +               bool found;
> +
> +               rte_spinlock_lock(&mirror_port_lock);
> +               found =3D ethdev_delete_mirror(&dev->rx_mirror, target_id=
);
> +               found |=3D ethdev_delete_mirror(&dev->tx_mirror, target_i=
d);
> +               rte_spinlock_unlock(&mirror_port_lock);
> +               if (!found)
> +                       ret =3D -ENOENT; /* no mirror present */
> +       } else {
> +               ret =3D ethdev_request(port_id, ETH_REQ_REMOVE_MIRROR,
> +                                    &target_id, sizeof(target_id));
> +       }
> +
> +       rte_eth_trace_remove_mirror(port_id, target_id, ret);
> +       return ret;
> +}
> +
> +static inline void
> +eth_dev_mirror(uint16_t port_id, uint16_t queue_id, uint8_t direction,
> +              struct rte_mbuf **pkts, uint16_t nb_pkts,
> +              struct rte_eth_mirror *mirror)
> +{
> +       struct rte_mbuf *tosend[RTE_MIRROR_BURST_SIZE];
> +       unsigned int count =3D 0;
> +       unsigned int nsent;
> +
> +#ifdef RTE_LIB_BPF
> +       uint64_t rcs[RTE_MIRROR_BURST_SIZE];
> +       if (mirror->bpf)
> +               rte_bpf_exec_burst(mirror->bpf, (void **)pkts, rcs,
> nb_pkts);
> +#endif
> +
> +       for (unsigned int i =3D 0; i < nb_pkts; i++) {
> +#ifdef RTE_LIB_BPF
> +               /*
> +                * This uses same BPF return value convention as socket
> filter
> +                * and pcap_offline_filter. If program returns zero
> +                * then packet doesn't match the filter (will be ignored)=
.
> +                */
> +               if (mirror->bpf && rcs[i] =3D=3D 0) {
> +                       ++mirror->stats.filtered;
> +                       continue;
> +               }
> +#endif
> +
> +               struct rte_mbuf *m =3D pkts[i];
> +               struct rte_mbuf *mc =3D rte_pktmbuf_copy(m, mirror->mp, 0=
,
> mirror->snaplen);
> +               if (unlikely(mc =3D=3D NULL)) {
> +                       ++mirror->stats.nombuf;
> +                       continue;
> +               }
> +
> +               /* Put info about origin of the packet */
> +               if (mirror->flags & RTE_ETH_MIRROR_ORIGIN_FLAG) {
> +                       struct rte_mbuf_origin *origin
> +                               =3D RTE_MBUF_DYNFIELD(mc,
> mirror_origin_offset, rte_mbuf_origin_t *);
> +                       origin->original_len =3D m->pkt_len;
> +                       origin->port_id =3D port_id;
> +                       origin->queue_id =3D queue_id;
> +                       mc->ol_flags |=3D mirror_origin_flag;
> +               }
> +
> +               /* Insert timestamp into packet */
> +               if (mirror->flags & RTE_ETH_MIRROR_TIMESTAMP_FLAG) {
> +                       *RTE_MBUF_DYNFIELD(m, mbuf_timestamp_offset,
> rte_mbuf_timestamp_t *)
> +                               =3D rte_get_tsc_cycles();
> +                       mc->ol_flags |=3D mbuf_timestamp_dynflag;
> +               }
> +
> +               mc->ol_flags &=3D ~(mirror_ingress_flag |
> mirror_egress_flag);
> +               if (direction & RTE_ETH_MIRROR_DIRECTION_INGRESS)
> +                       mc->ol_flags |=3D mirror_ingress_flag;
> +               else if (direction & RTE_ETH_MIRROR_DIRECTION_EGRESS)
> +                       mc->ol_flags |=3D mirror_egress_flag;
> +
> +               tosend[count++] =3D mc;
> +       }
> +
> +       if (mirror->need_lock) {
> +               uint16_t txq =3D queue_id % mirror->tx_queues;
> +
> +               rte_spinlock_lock(&mirror->lock);
> +               nsent =3D rte_eth_tx_burst(mirror->target, txq, tosend,
> count);
> +               rte_spinlock_unlock(&mirror->lock);
> +       } else {
> +               nsent =3D rte_eth_tx_burst(mirror->target, 0, tosend, cou=
nt);
> +       }
> +
> +       mirror->stats.packets +=3D nsent;
> +
> +       if (unlikely(nsent < count)) {
> +               uint16_t drop =3D count - nsent;
> +
> +               mirror->stats.full +=3D drop;
> +               rte_pktmbuf_free_bulk(pkts + nsent, drop);
> +       }
> +}
> +
> +/* This function is really internal but used from inline */
> +RTE_EXPORT_SYMBOL(rte_eth_mirror_burst)
> +void
> +rte_eth_mirror_burst(uint16_t port_id, uint16_t queue_id, uint8_t
> direction,
> +                    struct rte_mbuf **pkts, uint16_t nb_pkts,
> +                    struct rte_eth_mirror *mirror)
> +{
> +
> +       while (mirror !=3D NULL) {
> +               for (uint16_t i =3D 0; i < nb_pkts; i +=3D
> RTE_MIRROR_BURST_SIZE) {
> +                       uint16_t burst =3D RTE_MIN(nb_pkts - i,
> RTE_MIRROR_BURST_SIZE);
> +
> +                       eth_dev_mirror(port_id, queue_id, direction,
> +                                      pkts + i, burst, mirror);
> +               }
> +
> +               mirror =3D rte_atomic_load_explicit(&mirror->next,
> rte_memory_order_relaxed);
> +       }
> +}
> +
> +static int
> +ethdev_mirror_stats_get(RTE_ATOMIC(struct rte_eth_mirror *) *head,
> uint16_t target_id,
> +                       struct rte_eth_mirror_stats *stats)
> +{
> +       const struct rte_eth_mirror *mirror;
> +
> +       mirror =3D ethdev_find_mirror(head, target_id);
> +       if (mirror =3D=3D NULL)
> +               return -1;
> +
> +       stats->packets +=3D mirror->stats.packets;
> +       stats->nombuf +=3D mirror->stats.nombuf;
> +       stats->full +=3D mirror->stats.full;
> +       return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_mirror_stats_get, 25.11)
> +int
> +rte_eth_mirror_stats_get(uint16_t port_id, uint16_t target_id,
> +                        struct rte_eth_mirror_stats *stats)
> +{
> +       RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +       RTE_ETH_VALID_PORTID_OR_ERR_RET(target_id, -ENODEV);
> +
> +       if (stats =3D=3D NULL) {
> +               RTE_ETHDEV_LOG_LINE(ERR, "Mirror port stats is NULL");
> +               return -EINVAL;
> +       }
> +
> +       memset(stats, 0, sizeof(*stats));
> +
> +       struct rte_eth_dev *dev =3D &rte_eth_devices[port_id];
> +       int rx_ret =3D ethdev_mirror_stats_get(&dev->rx_mirror, target_id=
,
> stats);
> +       int tx_ret =3D ethdev_mirror_stats_get(&dev->tx_mirror, target_id=
,
> stats);
> +
> +       /* if rx or tx mirror is valid return 0 */
> +       return (tx_ret =3D=3D 0 || rx_ret =3D=3D 0) ? 0 : -ENOENT;
> +}
> +
> +static int
> +ethdev_mirror_stats_reset(RTE_ATOMIC(struct rte_eth_mirror *) *head,
> uint16_t target_id)
> +{
> +       struct rte_eth_mirror *mirror;
> +
> +       mirror =3D ethdev_find_mirror(head, target_id);
> +       if (mirror =3D=3D NULL)
> +               return -1;
> +
> +       memset(&mirror->stats, 0, sizeof(struct rte_eth_mirror_stats));
> +       return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_mirror_stats_reset, 25.11)
> +int
> +rte_eth_mirror_stats_reset(uint16_t port_id, uint16_t target_id)
> +{
> +       RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +       RTE_ETH_VALID_PORTID_OR_ERR_RET(target_id, -ENODEV);
> +
> +       struct rte_eth_dev *dev =3D &rte_eth_devices[port_id];
> +       int rx_ret =3D ethdev_mirror_stats_reset(&dev->rx_mirror, target_=
id);
> +       int tx_ret =3D ethdev_mirror_stats_reset(&dev->tx_mirror, target_=
id);
> +
> +       /* if rx or tx mirror is valid return 0 */
> +       return (tx_ret =3D=3D 0 || rx_ret =3D=3D 0) ? 0 : -ENOENT;
> +
> +}
> diff --git a/lib/ethdev/rte_mirror.h b/lib/ethdev/rte_mirror.h
> new file mode 100644
> index 0000000000..593ef477b6
> --- /dev/null
> +++ b/lib/ethdev/rte_mirror.h
> @@ -0,0 +1,147 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
> + */
> +
> +#ifndef RTE_MIRROR_H_
> +#define RTE_MIRROR_H_
> +
> +/**
> + * @file
> + * Ethdev port mirroring
> + *
> + * This interface provides the ability to duplicate packets to another
> port.
> + */
> +
> +#include <stdint.h>
> +
> +#include <rte_compat.h>
> +#include <rte_mbuf.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/* Definitions for ethdev mirror flags */
> +#define RTE_ETH_MIRROR_DIRECTION_INGRESS 1
> +#define RTE_ETH_MIRROR_DIRECTION_EGRESS 2
> +#define RTE_ETH_MIRROR_DIRECTION_MASK (RTE_ETH_MIRROR_DIRECTION_INGRESS =
|
> \
> +                                      RTE_ETH_MIRROR_DIRECTION_EGRESS)
> +
> +#define RTE_ETH_MIRROR_TIMESTAMP_FLAG 4        /**< insert timestamp int=
o
> mirrored packet */
> +#define RTE_ETH_MIRROR_ORIGIN_FLAG    8        /**< insert
> rte_mbuf_origin into mirrored packet */
> +
> +#define RTE_ETH_MIRROR_FLAG_MASK      (RTE_ETH_MIRROR_TIMESTAMP_FLAG | \
> +                                      RTE_ETH_MIRROR_ORIGIN_FLAG)
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this structure may change without prior notice.
> + *
> + * This dynamic field is added to mbuf's when they are copied to
> + * the port mirror.
> + */
> +typedef struct rte_mbuf_origin {
> +       uint32_t original_len;  /**< Packet length before copy */
> +       uint16_t port_id;       /**< Port where packet originated */
> +       uint16_t queue_id;      /**< Queue used for Tx or Rx */
> +} rte_mbuf_origin_t;
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this structure may change without prior notice.
> + *
> + * Structure used to configure ethdev Switched Port Analyzer (MIRROR)
> + */
> +struct rte_bpf_prm;
> +struct rte_eth_mirror_conf {
> +       struct rte_mempool *mp; /**< Memory pool for copies, If NULL then
> cloned. */
> +       struct rte_bpf_prm *filter; /**< Optional packet filter */
> +       uint32_t snaplen;       /**< Upper limit on number of bytes to
> copy */
> +       uint32_t flags;         /**< bitmask of RTE_ETH_MIRROR_XXX_FLAG's
> */
> +       uint16_t target;        /**< Destination port */
> +};
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this structure may change without prior notice.
> + *
> + * Structure returned by rte_mirror_stats.
> + */
> +struct rte_eth_mirror_stats {
> +       uint64_t packets;       /**< Number of mirrored packets. */
> +       uint64_t filtered;      /**< Packets filtered by BPF program */
> +       uint64_t nombuf;        /**< Rx mbuf allocation failures. */
> +       uint64_t full;          /**< Target port transmit full. */
> +};
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior
> notice
> + *
> + * Create a port mirror instance.
> + *
> + * @param port_id
> + *   The port identifier of the source Ethernet device.
> + * @param conf
> + *   Settings for this MIRROR instance.
> + * @return
> + *   Negative errno value on error, 0 on success.
> + */
> +__rte_experimental
> +int
> +rte_eth_add_mirror(uint16_t port_id, const struct rte_eth_mirror_conf
> *conf);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior
> notice
> + *
> + * Break port existing port mirroring.
> + * After this call no more packets will be sent from origin port to the
> target port.
> + *
> + * @param port_id
> + *   The port identifier of the source Ethernet device.
> + * @param target_id
> + *   The identifier of the destination port.
> + * @return
> + *   Negative errno value on error, 0 on success.
> + */
> +__rte_experimental
> +int rte_eth_remove_mirror(uint16_t port_id, uint16_t target_id);
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior
> notice
> + *
> + * Query statistics for a mirror.
> + *
> + * @param port_id
> + *   The port identifier of the source Ethernet device.
> + * @param target_id
> + *   The identifier of the destination port.
> + * @param stats
> + *   A pointer to a structure of type *rte_eth_mirror_stats* to be fille=
d.
> + *
> + * @return
> + *   Negative errno value on error, 0 on success.
> + */
> +__rte_experimental
> +int rte_eth_mirror_stats_get(uint16_t port_id, uint16_t target_id,
> +                            struct rte_eth_mirror_stats *stats);
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior
> notice
> + *
> + * Reset statistics for mirror.
> + *
> + * @param port_id
> + *   The port identifier of the source Ethernet device.
> + * @param target_id
> + *   The identifier of the destination port.
> + */
> +__rte_experimental
> +int rte_eth_mirror_stats_reset(uint16_t port_id, uint16_t target_id);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* RTE_MIRROR_H_ */
> --
> 2.47.2
>
>

--000000000000f08896063c692656
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sending a CI testing retest for this series because of a s=
uspected false failure on the vlan testsuite.</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, =
Aug 8, 2025 at 12:59=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:ste=
phen@networkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">This adds new feature po=
rt mirroring to the ethdev layer.<br>
And standalone tests for those features.<br>
<br>
Signed-off-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumb=
er.org" target=3D"_blank">stephen@networkplumber.org</a>&gt;<br>
---<br>
=C2=A0app/test/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
=C2=A0app/test/test_ethdev_mirror.c=C2=A0 =C2=A0 | 325 ++++++++++++++++++++=
<br>
=C2=A0config/rte_config.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 +<br>
=C2=A0lib/ethdev/ethdev_driver.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 =
+<br>
=C2=A0lib/ethdev/ethdev_private.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 58 +++-<br>
=C2=A0lib/ethdev/ethdev_private.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0lib/ethdev/ethdev_trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 17 ++<br=
>
=C2=A0lib/ethdev/ethdev_trace_points.c |=C2=A0 =C2=A06 +<br>
=C2=A0lib/ethdev/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A02 +<br>
=C2=A0lib/ethdev/rte_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 17 =
+-<br>
=C2=A0lib/ethdev/rte_ethdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 23 =
+-<br>
=C2=A0lib/ethdev/rte_ethdev_core.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +-<br>
=C2=A0lib/ethdev/rte_mirror.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 508 +++++=
++++++++++++++++++++++++++<br>
=C2=A0lib/ethdev/rte_mirror.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 147 +++++=
++++<br>
=C2=A014 files changed, 1108 insertions(+), 18 deletions(-)<br>
=C2=A0create mode 100644 app/test/test_ethdev_mirror.c<br>
=C2=A0create mode 100644 lib/ethdev/rte_mirror.c<br>
=C2=A0create mode 100644 lib/ethdev/rte_mirror.h<br>
<br>
diff --git a/app/test/meson.build b/app/test/meson.build<br>
index f3ea3e2b74..87219b869e 100644<br>
--- a/app/test/meson.build<br>
+++ b/app/test/meson.build<br>
@@ -73,6 +73,7 @@ source_file_deps =3D {<br>
=C2=A0 =C2=A0 =C2=A0&#39;test_errno.c&#39;: [],<br>
=C2=A0 =C2=A0 =C2=A0&#39;test_ethdev_api.c&#39;: [&#39;ethdev&#39;],<br>
=C2=A0 =C2=A0 =C2=A0&#39;test_ethdev_link.c&#39;: [&#39;ethdev&#39;],<br>
+=C2=A0 =C2=A0 &#39;test_ethdev_mirror.c&#39;: [&#39;net_ring&#39;, &#39;et=
hdev&#39;, &#39;bus_vdev&#39;],<br>
=C2=A0 =C2=A0 =C2=A0&#39;test_event_crypto_adapter.c&#39;: [&#39;cryptodev&=
#39;, &#39;eventdev&#39;, &#39;bus_vdev&#39;],<br>
=C2=A0 =C2=A0 =C2=A0&#39;test_event_dma_adapter.c&#39;: [&#39;dmadev&#39;, =
&#39;eventdev&#39;, &#39;bus_vdev&#39;],<br>
=C2=A0 =C2=A0 =C2=A0&#39;test_event_eth_rx_adapter.c&#39;: [&#39;ethdev&#39=
;, &#39;eventdev&#39;, &#39;bus_vdev&#39;],<br>
diff --git a/app/test/test_ethdev_mirror.c b/app/test/test_ethdev_mirror.c<=
br>
new file mode 100644<br>
index 0000000000..bbff1ff6a7<br>
--- /dev/null<br>
+++ b/app/test/test_ethdev_mirror.c<br>
@@ -0,0 +1,325 @@<br>
+/* SPDX-License-Identifier: BSD-3-Clause<br>
+ * Copyright(c) 2025 Stephen Hemminger &lt;<a href=3D"mailto:stephen@netwo=
rkplumber.org" target=3D"_blank">stephen@networkplumber.org</a>&gt;<br>
+ */<br>
+#include &quot;test.h&quot;<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+<br>
+#include &lt;rte_eth_ring.h&gt;<br>
+#include &lt;rte_ethdev.h&gt;<br>
+#include &lt;rte_bus_vdev.h&gt;<br>
+<br>
+#define SOCKET0 0<br>
+#define RING_SIZE 256<br>
+#define BURST_SZ 64<br>
+#define NB_MBUF 512<br>
+<br>
+static struct rte_mempool *mirror_pool;<br>
+static const uint32_t pkt_len =3D 200;<br>
+<br>
+static struct rte_ring *rxtx_ring;<br>
+static const char ring_dev[] =3D &quot;net_ring0&quot;;<br>
+static uint16_t ring_port;<br>
+static const char null_dev[] =3D &quot;net_null0&quot;;<br>
+static uint16_t null_port;<br>
+<br>
+static int<br>
+configure_port(uint16_t port, const char *name)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_conf eth_conf =3D { 0 };<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_eth_dev_configure(port, 1, 1, &amp;eth_=
conf) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Configure failed for port %u: %s\n&quot;, port, name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* only single queue */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_eth_tx_queue_setup(port, 0, RING_SIZE, =
SOCKET0, NULL) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;TX queue setup failed port %u: %s\n&quot;, port, name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_eth_rx_queue_setup(port, 0, RING_SIZE, =
SOCKET0, NULL, mirror_pool) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;RX queue setup failed port %u: %s\n&quot;, port, name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_eth_dev_start(port) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Error starting port %u:%s\n&quot;, port, name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static void<br>
+test_cleanup(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_ring_free(rxtx_ring);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_vdev_uninit(&quot;net_ring&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_vdev_uninit(&quot;net_null&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mempool_free(mirror_pool);<br>
+}<br>
+<br>
+/* Make two virtual devices ring and null */<br>
+static int<br>
+test_setup(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char null_name[] =3D &quot;net_null0&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* ring must support multiple enqueue for mirro=
r to work */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rxtx_ring =3D rte_ring_create(&quot;R0&quot;, R=
ING_SIZE, SOCKET0, RING_F_MP_RTS_ENQ | RING_F_SC_DEQ);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rxtx_ring =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;rte_ring_create R0 failed\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_from_rings(ring_dev, &amp;rxtx_=
ring, 1, &amp;rxtx_ring, 1, SOCKET0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;rte_eth_from_rings failed\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ring_port =3D ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Make a dummy null device to snoop on */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_vdev_init(null_dev, NULL) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Failed to create vdev &#39;%s&#39;\n&quot;, null_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_eth_dev_get_port_by_name(null_dev, &amp=
;null_port) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;cannot find added vdev %s\n&quot;, null_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror_pool =3D rte_pktmbuf_pool_create(&quot;m=
irror_pool&quot;, NB_MBUF, 32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror_pool =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;rte_pktmbuf_pool_create failed\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D configure_port(ring_port, ring_dev);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D configure_port(null_port, null_dev);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+fail:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0test_cleanup();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+}<br>
+<br>
+/* Make sure mirror API checks args */<br>
+static int32_t<br>
+ethdev_mirror_api(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_mirror_conf conf =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mp =3D mirror_pool=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D RTE_ETH_=
MIRROR_DIRECTION_EGRESS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_mirror_stats stats;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t invalid_port =3D RTE_MAX_ETHPORTS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0conf.target =3D null_port;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_add_mirror(invalid_port, &amp;c=
onf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret !=3D 0, &quot;Created mirror fr=
om invalid port&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0conf.target =3D invalid_port;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_add_mirror(null_port, &amp;conf=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret !=3D 0, &quot;Created mirror to=
 invalid port&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0conf.flags =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0conf.target =3D ring_port;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_add_mirror(null_port, &amp;conf=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret !=3D 0, &quot;Created mirror wi=
th invalid flags&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0conf.flags =3D RTE_ETH_MIRROR_DIRECTION_INGRESS=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0conf.target =3D ring_port;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_add_mirror(ring_port, &amp;conf=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret !=3D 0, &quot;Created mirror to=
 self&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_mirror_stats_get(invalid_port, =
null_port, &amp;stats);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret !=3D 0, &quot;Able to gets mirr=
or stats from invalid port&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_mirror_stats_get(null_port, inv=
alid_port, &amp;stats);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret !=3D 0, &quot;Able to gets mirr=
or stats from invalid target&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0conf.target =3D null_port;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_add_mirror(ring_port, &amp;conf=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret =3D=3D 0, &quot;Could not creat=
e mirror from ring to null&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_add_mirror(ring_port, &amp;conf=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret !=3D 0, &quot;Able to create du=
plicate mirror&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_mirror_stats_get(ring_port, nul=
l_port, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret =3D=3D -EINVAL, &quot;Able to g=
et status with NULL&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_mirror_stats_get(null_port, rin=
g_port, &amp;stats);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret !=3D 0, &quot;Able to get stats=
 with swapped ports&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_mirror_stats_get(ring_port, nul=
l_port, &amp;stats);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret =3D=3D 0, &quot;Could not get s=
tats&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_remove_mirror(ring_port, null_p=
ort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret =3D=3D 0, &quot;Unable to delet=
e mirror&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_remove_mirror(ring_port, null_p=
ort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret !=3D 0, &quot;Able to delete po=
rt without mirror&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int<br>
+init_mbuf(struct rte_mbuf *m, uint16_t id)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_ether_hd=
r eth;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_ipv4_hdr=
 ip;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_udp_hdr =
udp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} hdrs =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.eth =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.dst_addr.addr_bytes =3D { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.ether_type =3D rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.ip =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.version_ihl =3D RTE_IPV4_VHL_DEF,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.time_to_live =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.next_proto_id =3D IPPROTO_UDP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.src_addr =3D rte_cpu_to_be_32(RTE_IPV4_LOOPBACK),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.dst_addr =3D rte_cpu_to_be_32(RTE_IPV4_BROADCAST),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.udp =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.dst_port =3D rte_cpu_to_be_16(9), /* Discard port */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eth_random_addr(hdrs.eth.src_addr.addr_byte=
s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t plen =3D pkt_len - sizeof(struct rte_e=
ther_hdr);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0hdrs.ip.packet_id =3D rte_cpu_to_be_16(id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0hdrs.ip.total_length =3D rte_cpu_to_be_16(plen)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0hdrs.ip.hdr_checksum =3D rte_ipv4_cksum(&amp;hd=
rs.ip);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0plen -=3D sizeof(struct rte_ipv4_hdr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0hdrs.udp.src_port =3D rte_rand();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0hdrs.udp.dgram_len =3D rte_cpu_to_be_16(plen);<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void *data =3D rte_pktmbuf_append(m, pkt_len);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(data !=3D NULL, &quot;could not add=
 header&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(data, &amp;hdrs, sizeof(hdrs));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int<br>
+init_burst(struct rte_mbuf *pkts[], unsigned int n)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (unsigned int i =3D 0; i &lt; n; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (init_mbuf(pkts[=
i], i) &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int<br>
+validate_burst(struct rte_mbuf *pkts[], unsigned int n)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (unsigned int i =3D 0; i &lt; n; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *m =
=3D pkts[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mbuf_sanity_che=
ck(m, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(m-&gt;p=
kt_len =3D=3D pkt_len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;mirror packet len %u not right len %u&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0m-&gt;pkt_len, pkt_len);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rte_et=
her_hdr *eh<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D rte_pktmbuf_mtod(m, struct rte_ether_hdr *);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(rte_is_=
broadcast_ether_addr(&amp;eh-&gt;dst_addr),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;mirrored packet is not broadcast&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int32_t<br>
+ethdev_mirror_packets(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_mirror_conf conf =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mp =3D mirror_pool=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.target =3D ring_po=
rt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D RTE_ETH_=
MIRROR_DIRECTION_EGRESS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_mirror_stats stats;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *tx_pkts[BURST_SZ], *rx_pkts[BU=
RST_SZ];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t nb_tx, nb_rx;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pktmbuf_alloc_bulk(mirror_pool, tx_=
pkts, BURST_SZ);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret =3D=3D 0, &quot;Could not alloc=
ate mbufs&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D init_burst(tx_pkts, BURST_SZ);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret =3D=3D 0, &quot;Init mbufs fail=
ed&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_add_mirror(null_port, &amp;conf=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret =3D=3D 0, &quot;Could not creat=
e mirror from ring to null&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0nb_tx =3D rte_eth_tx_burst(null_port, 0, tx_pkt=
s, BURST_SZ);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(nb_tx =3D=3D BURST_SZ, &quot;Only s=
ent %u burst to null (vs %u)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_tx=
, BURST_SZ);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0nb_rx =3D rte_eth_rx_burst(ring_port, 0, rx_pkt=
s, BURST_SZ);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(nb_rx =3D=3D BURST_SZ, &quot;Only r=
eceived %u of %u packets&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_rx=
, BURST_SZ);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0validate_burst(rx_pkts, nb_rx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_pktmbuf_free_bulk(rx_pkts, nb_rx);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_mirror_stats_get(null_port, rin=
g_port, &amp;stats);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret =3D=3D 0, &quot;Could not get s=
tats: %d&quot;, ret);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(stats.packets =3D=3D BURST_SZ, &quo=
t;Stats reports %&quot;PRIu64&quot; of %u packets&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stats=
.packets, BURST_SZ);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(stats.nombuf =3D=3D 0, &quot;Stats:=
 no mbufs %&quot;PRIu64, stats.nombuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(stats.full =3D=3D 0, &quot;Stats: t=
ransmit was full %&quot;PRIu64, stats.full);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_mirror_stats_reset(null_port, r=
ing_port);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret =3D=3D 0, &quot;Could not get s=
tats: %d&quot;, ret);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_mirror_stats_get(null_port, rin=
g_port, &amp;stats);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret =3D=3D 0, &quot;Could not get s=
tats after reset: %d&quot;, ret);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(stats.packets =3D=3D 0, &quot;Stats=
 reports %&quot;PRIu64&quot; after reset&quot;, stats.packets);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_remove_mirror(null_port, ring_p=
ort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_ASSERT(ret =3D=3D 0, &quot;Could not remov=
e mirror&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static struct unit_test_suite ethdev_mirror_suite =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.suite_name =3D &quot;port mirroring&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup =3D test_setup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.teardown =3D test_cleanup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.unit_test_cases =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_CASE(ethdev_mi=
rror_api),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_CASE(ethdev_mi=
rror_packets),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEST_CASES_END()<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+};<br>
+<br>
+static int<br>
+test_ethdev_mirror(void)<br>
+{<br>
+#ifndef RTE_ETHDEV_MIRROR<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return TEST_SKIPPED;<br>
+#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return unit_test_suite_runner(&amp;ethdev_mirro=
r_suite);<br>
+}<br>
+<br>
+REGISTER_FAST_TEST(ethdev_mirror, true, true, test_ethdev_mirror);<br>
diff --git a/config/rte_config.h b/config/rte_config.h<br>
index 05344e2619..76eb2aa417 100644<br>
--- a/config/rte_config.h<br>
+++ b/config/rte_config.h<br>
@@ -69,6 +69,7 @@<br>
=C2=A0#define RTE_MAX_QUEUES_PER_PORT 1024<br>
=C2=A0#define RTE_ETHDEV_QUEUE_STAT_CNTRS 16 /* max 256 */<br>
=C2=A0#define RTE_ETHDEV_RXTX_CALLBACKS 1<br>
+#define RTE_ETHDEV_MIRROR 1<br>
=C2=A0#define RTE_MAX_MULTI_HOST_CTRLS 4<br>
<br>
=C2=A0/* cryptodev defines */<br>
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h<br>
index 2b4d2ae9c3..e6aad6d30a 100644<br>
--- a/lib/ethdev/ethdev_driver.h<br>
+++ b/lib/ethdev/ethdev_driver.h<br>
@@ -91,6 +91,12 @@ struct __rte_cache_aligned rte_eth_dev {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ATOMIC(struct rte_eth_rxtx_callback *) pre_=
tx_burst_cbs[RTE_MAX_QUEUES_PER_PORT];<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Receive mirrors */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ATOMIC(struct rte_eth_mirror *) rx_mirror;<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Transmit mirrors */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ATOMIC(struct rte_eth_mirror *) tx_mirror;<=
br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum rte_eth_dev_state state; /**&lt; Flag indi=
cating the port state */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *security_ctx; /**&lt; Context for securit=
y ops */<br>
=C2=A0};<br>
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c<br>
index 000b8372d8..e702acc874 100644<br>
--- a/lib/ethdev/ethdev_private.c<br>
+++ b/lib/ethdev/ethdev_private.c<br>
@@ -289,6 +289,8 @@ eth_dev_fp_ops_setup(struct rte_eth_fp_ops *fpo,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fpo-&gt;tx_descriptor_status =3D dev-&gt;tx_des=
criptor_status;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fpo-&gt;recycle_tx_mbufs_reuse =3D dev-&gt;recy=
cle_tx_mbufs_reuse;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fpo-&gt;recycle_rx_descriptors_refill =3D dev-&=
gt;recycle_rx_descriptors_refill;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fpo-&gt;rx_mirror =3D (struct rte_eth_mirror * =
__rte_atomic *)(uintptr_t)&amp;dev-&gt;rx_mirror;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fpo-&gt;tx_mirror =3D (struct rte_eth_mirror * =
__rte_atomic *)(uintptr_t)&amp;dev-&gt;tx_mirror;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fpo-&gt;rxq.data =3D dev-&gt;data-&gt;rx_queues=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fpo-&gt;rxq.clbk =3D (void * __rte_atomic *)(ui=
ntptr_t)dev-&gt;post_rx_burst_cbs;<br>
@@ -490,17 +492,53 @@ eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint=
16_t nb_queues)<br>
=C2=A0}<br>
<br>
=C2=A0static int<br>
-ethdev_handle_request(const struct ethdev_mp_request *req)<br>
+ethdev_handle_request(const struct ethdev_mp_request *req, size_t len)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0len -=3D sizeof(*req);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (req-&gt;operation) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ETH_REQ_START:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rte_eth_dev_=
start(req-&gt;port_id);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ETH_REQ_STOP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rte_eth_dev_=
stop(req-&gt;port_id);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case ETH_REQ_RESET:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rte_eth_dev_=
reset(req-&gt;port_id);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case ETH_REQ_ADD_MIRROR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D sizeof=
(struct rte_eth_mirror_conf)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RTE_ETHDEV_LOG_LINE(ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;add mirror conf w=
rong size %zu&quot;, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rte_et=
h_mirror_conf *conf<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D (const struct rte_eth_mirror_conf *) req-&gt;config;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rte_eth_add_=
mirror(req-&gt;port_id, conf);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case ETH_REQ_REMOVE_MIRROR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D sizeof=
(uint16_t)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RTE_ETHDEV_LOG_LINE(ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;mirror remove wro=
ng size %zu&quot;, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t target =3D=
 *(const uint16_t *) req-&gt;config;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rte_eth_remo=
ve_mirror(req-&gt;port_id, target);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;Unknown mp request operation %u&quot;, req-&g=
t;operation);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUP;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
@@ -513,23 +551,25 @@ static_assert(sizeof(struct ethdev_mp_response) &lt;=
=3D RTE_MP_MAX_PARAM_LEN,<br>
=C2=A0int<br>
=C2=A0ethdev_server(const struct rte_mp_msg *mp_msg, const void *peer)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct ethdev_mp_request *req<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (const struct e=
thdev_mp_request *)mp_msg-&gt;param;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mp_msg mp_resp =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D ETHDEV_MP=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ethdev_mp_response *resp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct ethdev_mp_request *req;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 resp =3D (struct ethdev_mp_response *)mp_resp.p=
aram;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mp_resp.len_param =3D sizeof(*resp);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0resp-&gt;res_op =3D req-&gt;operation;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* recv client requests */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mp_msg-&gt;len_param !=3D sizeof(*req))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mp_msg-&gt;len_param &lt; (int)sizeof(*req)=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;invalid request from secondary&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resp-&gt;err_value =
=3D -EINVAL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resp-&gt;err_value =
=3D ethdev_handle_request(req);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req =3D (const stru=
ct ethdev_mp_request *)mp_msg-&gt;param;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resp-&gt;res_op =3D=
 req-&gt;operation;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resp-&gt;err_value =
=3D ethdev_handle_request(req, mp_msg-&gt;len_param);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rte_mp_reply(&amp;mp_resp, peer);<br>
=C2=A0}<br>
diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h<br>
index f58f161871..d2fdc20057 100644<br>
--- a/lib/ethdev/ethdev_private.h<br>
+++ b/lib/ethdev/ethdev_private.h<br>
@@ -85,6 +85,9 @@ int eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint=
16_t nb_queues);<br>
=C2=A0enum ethdev_mp_operation {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ETH_REQ_START,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ETH_REQ_STOP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ETH_REQ_RESET,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ETH_REQ_ADD_MIRROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ETH_REQ_REMOVE_MIRROR,<br>
=C2=A0};<br>
<br>
=C2=A0struct ethdev_mp_request {<br>
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h<br>
index 482befc209..e137afcbf7 100644<br>
--- a/lib/ethdev/ethdev_trace.h<br>
+++ b/lib/ethdev/ethdev_trace.h<br>
@@ -1035,6 +1035,23 @@ RTE_TRACE_POINT(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_trace_point_emit_int(ret);<br>
=C2=A0)<br>
<br>
+RTE_TRACE_POINT(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eth_trace_add_mirror,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_TRACE_POINT_ARGS(uint16_t port_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const struct rte_eth_mirror_conf *conf, int ret),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_trace_point_emit_u16(port_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_trace_point_emit_u16(conf-&gt;target);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_trace_point_emit_int(ret);<br>
+)<br>
+<br>
+RTE_TRACE_POINT(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eth_trace_remove_mirror,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t=
 target_id, int ret),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_trace_point_emit_u16(port_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_trace_point_emit_u16(target_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_trace_point_emit_int(ret);<br>
+)<br>
+<br>
=C2=A0RTE_TRACE_POINT(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_eth_trace_rx_queue_info_get,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t=
 queue_id,<br>
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_poi=
nts.c<br>
index 071c508327..fa1fd21809 100644<br>
--- a/lib/ethdev/ethdev_trace_points.c<br>
+++ b/lib/ethdev/ethdev_trace_points.c<br>
@@ -389,6 +389,12 @@ RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_rx_callb=
ack,<br>
=C2=A0RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_tx_callback,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lib.ethdev.remove_tx_callback)<br>
<br>
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_add_mirror,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0lib.ethdev.add_mirror)<br>
+<br>
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_mirror,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0lib.ethdev.remove_mirror)<br>
+<br>
=C2=A0RTE_TRACE_POINT_REGISTER(rte_eth_trace_rx_queue_info_get,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lib.ethdev.rx_queue_info_get)<br>
<br>
diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build<br>
index 1d68d5348c..eb624bd579 100644<br>
--- a/lib/ethdev/meson.build<br>
+++ b/lib/ethdev/meson.build<br>
@@ -11,6 +11,7 @@ sources =3D files(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_ethdev_cman.c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_ethdev_telemetry.c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_flow.c&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;rte_mirror.c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_mtr.c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_tm.c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sff_telemetry.c&#39;,<br>
@@ -27,6 +28,7 @@ headers =3D files(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_dev_info.h&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_flow.h&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_flow_driver.h&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;rte_mirror.h&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_mtr.h&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_mtr_driver.h&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_tm.h&#39;,<br>
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c<br>
index adeec575be..ac889c220a 100644<br>
--- a/lib/ethdev/rte_ethdev.c<br>
+++ b/lib/ethdev/rte_ethdev.c<br>
@@ -14,6 +14,8 @@<br>
=C2=A0#include &lt;bus_driver.h&gt;<br>
=C2=A0#include &lt;eal_export.h&gt;<br>
=C2=A0#include &lt;rte_log.h&gt;<br>
+#include &lt;rte_cycles.h&gt;<br>
+#include &lt;rte_alarm.h&gt;<br>
=C2=A0#include &lt;rte_interrupts.h&gt;<br>
=C2=A0#include &lt;rte_kvargs.h&gt;<br>
=C2=A0#include &lt;rte_memcpy.h&gt;<br>
@@ -2041,13 +2043,16 @@ rte_eth_dev_reset(uint16_t port_id)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev-&gt;dev_ops-&gt;dev_reset =3D=3D NULL)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOTSUP;<br=
>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_dev_stop(port_id);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Failed to stop device (port %u) before reset: %s - ignore&q=
uot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0port_id, rte_strerror(-ret));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_eal_process_type() =3D=3D RTE_PROC_PRIM=
ARY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_dev=
_stop(port_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RTE_ETHDEV_LOG_LINE(ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Failed to stop de=
vice (port %u) before reset: %s - ignore&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port_id, rte_strerror(-=
ret));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D eth_err(por=
t_id, dev-&gt;dev_ops-&gt;dev_reset(dev));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ethdev_requ=
est(port_id, ETH_REQ_STOP, NULL, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D eth_err(port_id, dev-&gt;dev_ops-&gt;de=
v_reset(dev));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_ethdev_trace_reset(port_id, ret);<br>
<br>
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h<br>
index f9fb6ae549..84801a1123 100644<br>
--- a/lib/ethdev/rte_ethdev.h<br>
+++ b/lib/ethdev/rte_ethdev.h<br>
@@ -170,6 +170,7 @@<br>
<br>
=C2=A0#include &quot;rte_ethdev_trace_fp.h&quot;<br>
=C2=A0#include &quot;rte_dev_info.h&quot;<br>
+#include &quot;rte_mirror.h&quot;<br>
<br>
=C2=A0#ifdef __cplusplus<br>
=C2=A0extern &quot;C&quot; {<br>
@@ -1466,7 +1467,6 @@ enum rte_eth_tunnel_type {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_TUNNEL_TYPE_ECPRI,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_TUNNEL_TYPE_MAX,<br>
=C2=A0};<br>
-<br>
=C2=A0#ifdef __cplusplus<br>
=C2=A0}<br>
=C2=A0#endif<br>
@@ -6334,6 +6334,17 @@ rte_eth_rx_burst(uint16_t port_id, uint16_t queue_id=
,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_rx =3D p-&gt;rx_pkt_burst(qd, rx_pkts, nb_pk=
ts);<br>
<br>
+#ifdef RTE_ETHDEV_MIRROR<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_mirr=
or *mirror<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D rte_atomic_load_explicit(p-&gt;rx_mirror, rte_memory_order_re=
laxed);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(mirror=
 !=3D NULL))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_eth_mirror_burst(port_id, queue_id, RTE_ETH_MIRROR_DIRECTION_=
INGRESS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rx_pkts, nb_rx, mirror);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+#endif<br>
+<br>
=C2=A0#ifdef RTE_ETHDEV_RXTX_CALLBACKS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *cb;<br>
@@ -6692,6 +6703,16 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
<br>
+#ifdef RTE_ETHDEV_MIRROR<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_mirr=
or *mirror;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mirror =3D rte_atom=
ic_load_explicit(p-&gt;tx_mirror, rte_memory_order_relaxed);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(mirror=
 !=3D NULL))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_eth_mirror_burst(port_id, queue_id, RTE_ETH_MIRROR_DIRECTION_=
EGRESS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 tx_pkts, nb_pkts, mirror);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_pkts =3D p-&gt;tx_pkt_burst(qd, tx_pkts, nb_=
pkts);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_ethdev_trace_tx_burst(port_id, queue_id, (v=
oid **)tx_pkts, nb_pkts);<br>
diff --git a/lib/ethdev/rte_ethdev_core.h b/lib/ethdev/rte_ethdev_core.h<br=
>
index e55fb42996..2ca1beb239 100644<br>
--- a/lib/ethdev/rte_ethdev_core.h<br>
+++ b/lib/ethdev/rte_ethdev_core.h<br>
@@ -22,6 +22,12 @@ RTE_TAILQ_HEAD(rte_eth_dev_cb_list, rte_eth_dev_callback=
);<br>
<br>
=C2=A0struct rte_eth_dev;<br>
<br>
+struct rte_eth_mirror;<br>
+<br>
+void rte_eth_mirror_burst(uint16_t port_id, uint16_t quque_id, uint8_t dir=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct rte_mbuf **pkts, uint16_t nb_pkts,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct rte_eth_mirror *mirror);<br>
+<br>
=C2=A0/**<br>
=C2=A0 * @internal Retrieve input packets from a receive queue of an Ethern=
et device.<br>
=C2=A0 */<br>
@@ -101,7 +107,8 @@ struct __rte_cache_aligned rte_eth_fp_ops {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_rx_descriptor_status_t rx_descriptor_status=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** Refill Rx descriptors with the recycling mb=
ufs. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_recycle_rx_descriptors_refill_t recycle_rx_=
descriptors_refill;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t reserved1[2];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t reserved1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ATOMIC(struct rte_eth_mirror *) *rx_mirror;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**@}*/<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**@{*/<br>
@@ -121,7 +128,8 @@ struct __rte_cache_aligned rte_eth_fp_ops {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_recycle_tx_mbufs_reuse_t recycle_tx_mbufs_r=
euse;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** Get the number of used Tx descriptors. */<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth_tx_queue_count_t tx_queue_count;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t reserved2[1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ATOMIC(struct rte_eth_mirror *) *tx_mirror;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t reserved2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**@}*/<br>
<br>
=C2=A0};<br>
diff --git a/lib/ethdev/rte_mirror.c b/lib/ethdev/rte_mirror.c<br>
new file mode 100644<br>
index 0000000000..27b613b8ff<br>
--- /dev/null<br>
+++ b/lib/ethdev/rte_mirror.c<br>
@@ -0,0 +1,508 @@<br>
+/* SPDX-License-Identifier: BSD-3-Clause<br>
+ * Copyright(c) 2025 Stephen Hemminger &lt;<a href=3D"mailto:stephen@netwo=
rkplumber.org" target=3D"_blank">stephen@networkplumber.org</a>&gt;<br>
+ */<br>
+<br>
+#include &lt;errno.h&gt;<br>
+#include &lt;inttypes.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;string.h&gt;<br>
+<br>
+#include &lt;rte_alarm.h&gt;<br>
+#include &lt;rte_bitops.h&gt;<br>
+#include &lt;rte_common.h&gt;<br>
+#include &lt;rte_config.h&gt;<br>
+#include &lt;rte_cycles.h&gt;<br>
+#include &lt;rte_eal.h&gt;<br>
+#include &lt;rte_ether.h&gt;<br>
+#include &lt;rte_log.h&gt;<br>
+#include &lt;rte_malloc.h&gt;<br>
+#include &lt;rte_mbuf.h&gt;<br>
+#include &lt;rte_spinlock.h&gt;<br>
+#include &lt;rte_stdatomic.h&gt;<br>
+#include &lt;eal_export.h&gt;<br>
+<br>
+#include &quot;rte_ethdev.h&quot;<br>
+#include &quot;rte_mirror.h&quot;<br>
+#include &quot;ethdev_driver.h&quot;<br>
+#include &quot;ethdev_private.h&quot;<br>
+#include &quot;ethdev_trace.h&quot;<br>
+<br>
+/* Upper bound of packet bursts redirected */<br>
+#define RTE_MIRROR_BURST_SIZE 64<br>
+<br>
+#ifdef RTE_LIB_BPF<br>
+#include &lt;rte_bpf.h&gt;<br>
+#endif<br>
+<br>
+/**<br>
+ * Structure used to hold information mirror port mirrors for a<br>
+ * queue on Rx and Tx.<br>
+ */<br>
+struct rte_eth_mirror {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ATOMIC(struct rte_eth_mirror *) next;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mempool *mp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_bpf *bpf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t snaplen;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t target;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t tx_queues;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0need_lock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_spinlock_t lock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_mirror_stats stats;<br>
+};<br>
+<br>
+/* spinlock for setting up mirror ports */<br>
+static rte_spinlock_t mirror_port_lock =3D RTE_SPINLOCK_INITIALIZER;<br>
+<br>
+/* dynamically assigned offload flag to indicate ingress vs egress */<br>
+static uint64_t mirror_origin_flag;<br>
+static int mirror_origin_offset =3D -1;<br>
+static uint64_t mirror_ingress_flag;<br>
+static uint64_t mirror_egress_flag;<br>
+<br>
+static uint64_t mbuf_timestamp_dynflag;<br>
+static int mbuf_timestamp_offset =3D -1;<br>
+<br>
+/* register dynamic mbuf fields, done on first mirror creation */<br>
+static int<br>
+ethdev_dyn_mirror_register(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rte_mbuf_dynfield field_desc =3D {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D RTE_MBUF_=
DYNFIELD_MIRROR_ORIGIN,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.size =3D sizeof(rt=
e_mbuf_origin_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.align =3D sizeof(r=
te_mbuf_origin_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf_dynflag flag_desc =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D RTE_MBUF_=
DYNFLAG_MIRROR_ORIGIN,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int offset;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_mbuf_dyn_tx_timestamp_register(&amp;mbu=
f_timestamp_offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &amp;mbuf_timestamp_dynflag) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;Failed to register timestamp flag&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D rte_mbuf_dynfield_register(&amp;fiel=
d_desc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (offset &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;Failed to register mbuf origin field&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror_origin_offset =3D offset;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D rte_mbuf_dynflag_register(&amp;flag_=
desc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (offset &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;Failed to register mbuf origin flag&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror_origin_flag =3D RTE_BIT64(offset);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0strlcpy(<a href=3D"http://flag_desc.name" rel=
=3D"noreferrer" target=3D"_blank">flag_desc.name</a>, RTE_MBUF_DYNFLAG_MIRR=
OR_INGRESS, sizeof(<a href=3D"http://flag_desc.name" rel=3D"noreferrer" tar=
get=3D"_blank">flag_desc.name</a>));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D rte_mbuf_dynflag_register(&amp;flag_=
desc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (offset &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;Failed to register mbuf ingress flag&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror_ingress_flag =3D RTE_BIT64(offset);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0strlcpy(<a href=3D"http://flag_desc.name" rel=
=3D"noreferrer" target=3D"_blank">flag_desc.name</a>, RTE_MBUF_DYNFLAG_MIRR=
OR_EGRESS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(<a href=3D"h=
ttp://flag_desc.name" rel=3D"noreferrer" target=3D"_blank">flag_desc.name</=
a>));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D rte_mbuf_dynflag_register(&amp;flag_=
desc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (offset &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;Failed to register mbuf egress flag&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror_egress_flag =3D RTE_BIT64(offset);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+/* Add a new mirror entry to the list. */<br>
+static int<br>
+ethdev_insert_mirror(RTE_ATOMIC(struct rte_eth_mirror *) *top,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cons=
t struct rte_eth_mirror_conf *conf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cons=
t struct rte_eth_dev_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_mirror *mirror;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t filter_len =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Don&#39;t allow multiple mirrors from same s=
ource to target */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while ((mirror =3D *top) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror-&gt;targ=
et =3D=3D conf-&gt;target) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RTE_ETHDEV_LOG_LINE(ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Mirror to port %u=
 already exists&quot;, conf-&gt;target);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EEXIST;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (conf-&gt;filter) {<br>
+#ifdef RTE_LIB_BPF<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filter_len =3D rte_=
bpf_buf_size(conf-&gt;filter);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (filter_len &lt;=
 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RTE_ETHDEV_LOG_LINE(ERR, &quot;Invalid BPF filter: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0rte_strerror(rte_errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+#else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;BPF filter not supported&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUP;<br=
>
+#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Allocate space for both fast path mirror str=
ucture<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * and filter bpf code (if any).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror =3D rte_zmalloc(NULL, sizeof(*mirror) + =
filter_len, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror =3D=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror-&gt;mp =3D conf-&gt;mp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror-&gt;target =3D conf-&gt;target;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror-&gt;flags =3D conf-&gt;flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_spinlock_init(&amp;mirror-&gt;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror-&gt;need_lock =3D !(info-&gt;tx_offload_=
capa &amp; RTE_ETH_TX_OFFLOAD_MT_LOCKFREE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror-&gt;tx_queues =3D info-&gt;nb_tx_queues;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (conf-&gt;snaplen =3D=3D 0) /* specifying 0 =
implies the full packet */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mirror-&gt;snaplen =
=3D UINT32_MAX;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mirror-&gt;snaplen =
=3D conf-&gt;snaplen;<br>
+<br>
+#ifdef RTE_LIB_BPF<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (filter_len &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* reserved space f=
or BPF is after mirror structure */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buf =3D (uint=
8_t *)mirror + sizeof(*mirror);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Copy filter inte=
rnal representation into space<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * allocated in hug=
e pages to allow access from any process.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mirror-&gt;bpf =3D =
rte_bpf_buf_load(conf-&gt;filter, buf, filter_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror-&gt;bpf =
=3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RTE_ETHDEV_LOG_LINE(ERR, &quot;Failed to load BPF filter: %s&quot=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0rte_strerror(rte_errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_free(mirror);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror-&gt;next =3D *top;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_store_explicit(top, mirror, rte_memo=
ry_order_relaxed);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_add_mirror, 25.11)<br>
+int<br>
+rte_eth_add_mirror(uint16_t port_id, const struct rte_eth_mirror_conf *con=
f)<br>
+{<br>
+#ifndef RTE_ETHDEV_MIRROR<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUP;<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODE=
V);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dev *dev =3D &amp;rte_eth_device=
s[port_id];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dev_info dev_info;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (conf =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;Missing configuration information&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (conf-&gt;mp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;not a valid mempool&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (conf-&gt;flags &amp; ~(RTE_ETH_MIRROR_DIREC=
TION_MASK | RTE_ETH_MIRROR_FLAG_MASK)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;unsupported flags&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((conf-&gt;flags &amp; RTE_ETH_MIRROR_DIRECT=
ION_MASK) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;missing direction ingress or egress&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Checks that target exists */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D rte_eth_dev_info_get(conf-&gt;targe=
t, &amp;dev_info);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Loopback mirror could create packet storm */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (conf-&gt;target =3D=3D port_id) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;Cannot mirror port to self&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_eal_process_type() =3D=3D RTE_PROC_PRIM=
ARY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Register dynamic=
 fields once */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror_origin_o=
ffset &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D ethdev_dyn_mirror_register();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_spinlock_lock(&=
amp;mirror_port_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (conf-&gt;flags =
&amp; RTE_ETH_MIRROR_DIRECTION_INGRESS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D ethdev_insert_mirror(&amp;dev-&gt;rx_mirror, conf, &amp;d=
ev_info);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0 &a=
mp;&amp; (conf-&gt;flags &amp; RTE_ETH_MIRROR_DIRECTION_EGRESS))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D ethdev_insert_mirror(&amp;dev-&gt;tx_mirror, conf, &amp;d=
ev_info);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_spinlock_unlock=
(&amp;mirror_port_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* in secondary, pr=
oxy to primary */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ethdev_requ=
est(port_id, ETH_REQ_ADD_MIRROR, conf, sizeof(*conf));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eth_trace_add_mirror(port_id, conf, ret);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static struct rte_eth_mirror *<br>
+ethdev_find_mirror(RTE_ATOMIC(struct rte_eth_mirror *) *head, uint16_t tar=
get_id)<br>
+{<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (;;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_mirr=
or *mirror<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D rte_atomic_load_explicit(head, rte_memory_order_relaxed);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror =3D=3D N=
ULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return NULL;=C2=A0 =C2=A0 /* reached end of list */<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror-&gt;targ=
et =3D=3D target_id)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return mirror;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0head =3D &amp;mirro=
r-&gt;next;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+static bool<br>
+ethdev_delete_mirror(RTE_ATOMIC(struct rte_eth_mirror *) *top, uint16_t ta=
rget_id)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_mirror *mirror;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror =3D ethdev_find_mirror(top, target_id);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror =3D=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* unlink from list */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_atomic_store_explicit(top, mirror-&gt;next,=
 rte_memory_order_relaxed);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Defer freeing the mirror until after one sec=
ond to allow for active threads<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * that are using it. Assumes no PMD takes more=
 than one second to transmit a burst.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Alternative would be RCU, but RCU in DPDK is=
 optional and requires application changes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_alarm_set(US_PER_S, rte_free, mirror);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
+}<br>
+<br>
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_remove_mirror, 25.11)<br>
+int<br>
+rte_eth_remove_mirror(uint16_t port_id, uint16_t target_id)<br>
+{<br>
+#ifndef RTE_ETHDEV_MIRROR<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUP;<br>
+#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODE=
V);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_VALID_PORTID_OR_ERR_RET(target_id, -ENO=
DEV);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dev *dev =3D &amp;rte_eth_device=
s[port_id];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_eal_process_type() =3D=3D RTE_PROC_PRIM=
ARY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool found;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_spinlock_lock(&=
amp;mirror_port_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found =3D ethdev_de=
lete_mirror(&amp;dev-&gt;rx_mirror, target_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found |=3D ethdev_d=
elete_mirror(&amp;dev-&gt;tx_mirror, target_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_spinlock_unlock=
(&amp;mirror_port_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!found)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D -ENOENT; /* no mirror present */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ethdev_requ=
est(port_id, ETH_REQ_REMOVE_MIRROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;target_id, sizeof=
(target_id));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eth_trace_remove_mirror(port_id, target_id,=
 ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static inline void<br>
+eth_dev_mirror(uint16_t port_id, uint16_t queue_id, uint8_t direction,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mbuf **pkts, u=
int16_t nb_pkts,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_eth_mirror *mi=
rror)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *tosend[RTE_MIRROR_BURST_SIZE];=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int count =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int nsent;<br>
+<br>
+#ifdef RTE_LIB_BPF<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t rcs[RTE_MIRROR_BURST_SIZE];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror-&gt;bpf)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_bpf_exec_burst(=
mirror-&gt;bpf, (void **)pkts, rcs, nb_pkts);<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (unsigned int i =3D 0; i &lt; nb_pkts; i++)=
 {<br>
+#ifdef RTE_LIB_BPF<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * This uses same B=
PF return value convention as socket filter<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and pcap_offline=
_filter. If program returns zero<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * then packet does=
n&#39;t match the filter (will be ignored).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror-&gt;bpf =
&amp;&amp; rcs[i] =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0++mirror-&gt;stats.filtered;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *m =
=3D pkts[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *mc=
 =3D rte_pktmbuf_copy(m, mirror-&gt;mp, 0, mirror-&gt;snaplen);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(mc =3D=
=3D NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0++mirror-&gt;stats.nombuf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Put info about o=
rigin of the packet */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror-&gt;flag=
s &amp; RTE_ETH_MIRROR_ORIGIN_FLAG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct rte_mbuf_origin *origin<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D RTE_MBUF_DYNFIELD(mc, mirror_orig=
in_offset, rte_mbuf_origin_t *);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0origin-&gt;original_len =3D m-&gt;pkt_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0origin-&gt;port_id =3D port_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0origin-&gt;queue_id =3D queue_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mc-&gt;ol_flags |=3D mirror_origin_flag;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Insert timestamp=
 into packet */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror-&gt;flag=
s &amp; RTE_ETH_MIRROR_TIMESTAMP_FLAG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*RTE_MBUF_DYNFIELD(m, mbuf_timestamp_offset, rte_mbuf_timestamp_t=
 *)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D rte_get_tsc_cycles();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mc-&gt;ol_flags |=3D mbuf_timestamp_dynflag;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mc-&gt;ol_flags &am=
p;=3D ~(mirror_ingress_flag | mirror_egress_flag);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (direction &amp;=
 RTE_ETH_MIRROR_DIRECTION_INGRESS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mc-&gt;ol_flags |=3D mirror_ingress_flag;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (direction =
&amp; RTE_ETH_MIRROR_DIRECTION_EGRESS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mc-&gt;ol_flags |=3D mirror_egress_flag;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tosend[count++] =3D=
 mc;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror-&gt;need_lock) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t txq =3D qu=
eue_id % mirror-&gt;tx_queues;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_spinlock_lock(&=
amp;mirror-&gt;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nsent =3D rte_eth_t=
x_burst(mirror-&gt;target, txq, tosend, count);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_spinlock_unlock=
(&amp;mirror-&gt;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nsent =3D rte_eth_t=
x_burst(mirror-&gt;target, 0, tosend, count);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror-&gt;stats.packets +=3D nsent;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(nsent &lt; count)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t drop =3D c=
ount - nsent;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mirror-&gt;stats.fu=
ll +=3D drop;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_pktmbuf_free_bu=
lk(pkts + nsent, drop);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+/* This function is really internal but used from inline */<br>
+RTE_EXPORT_SYMBOL(rte_eth_mirror_burst)<br>
+void<br>
+rte_eth_mirror_burst(uint16_t port_id, uint16_t queue_id, uint8_t directio=
n,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stru=
ct rte_mbuf **pkts, uint16_t nb_pkts,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stru=
ct rte_eth_mirror *mirror)<br>
+{<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (mirror !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (uint16_t i =3D=
 0; i &lt; nb_pkts; i +=3D RTE_MIRROR_BURST_SIZE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint16_t burst =3D RTE_MIN(nb_pkts - i, RTE_MIRROR_BURST_SIZE);<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0eth_dev_mirror(port_id, queue_id, direction,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkts + i, burst=
, mirror);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mirror =3D rte_atom=
ic_load_explicit(&amp;mirror-&gt;next, rte_memory_order_relaxed);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+static int<br>
+ethdev_mirror_stats_get(RTE_ATOMIC(struct rte_eth_mirror *) *head, uint16_=
t target_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct rte_eth_mirror_stats *stats)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rte_eth_mirror *mirror;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror =3D ethdev_find_mirror(head, target_id);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror =3D=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;packets +=3D mirror-&gt;stats.packets=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;nombuf +=3D mirror-&gt;stats.nombuf;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0stats-&gt;full +=3D mirror-&gt;stats.full;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_mirror_stats_get, 25.11)<br>
+int<br>
+rte_eth_mirror_stats_get(uint16_t port_id, uint16_t target_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct rte_eth_mirror_stats *stats)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODE=
V);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_VALID_PORTID_OR_ERR_RET(target_id, -ENO=
DEV);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (stats =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETHDEV_LOG_LINE=
(ERR, &quot;Mirror port stats is NULL&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(stats, 0, sizeof(*stats));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dev *dev =3D &amp;rte_eth_device=
s[port_id];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int rx_ret =3D ethdev_mirror_stats_get(&amp;dev=
-&gt;rx_mirror, target_id, stats);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int tx_ret =3D ethdev_mirror_stats_get(&amp;dev=
-&gt;tx_mirror, target_id, stats);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* if rx or tx mirror is valid return 0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (tx_ret =3D=3D 0 || rx_ret =3D=3D 0) ? 0=
 : -ENOENT;<br>
+}<br>
+<br>
+static int<br>
+ethdev_mirror_stats_reset(RTE_ATOMIC(struct rte_eth_mirror *) *head, uint1=
6_t target_id)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_mirror *mirror;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mirror =3D ethdev_find_mirror(head, target_id);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mirror =3D=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;mirror-&gt;stats, 0, sizeof(struct =
rte_eth_mirror_stats));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_mirror_stats_reset, 25.11)<br>
+int<br>
+rte_eth_mirror_stats_reset(uint16_t port_id, uint16_t target_id)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODE=
V);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ETH_VALID_PORTID_OR_ERR_RET(target_id, -ENO=
DEV);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_dev *dev =3D &amp;rte_eth_device=
s[port_id];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int rx_ret =3D ethdev_mirror_stats_reset(&amp;d=
ev-&gt;rx_mirror, target_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int tx_ret =3D ethdev_mirror_stats_reset(&amp;d=
ev-&gt;tx_mirror, target_id);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* if rx or tx mirror is valid return 0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (tx_ret =3D=3D 0 || rx_ret =3D=3D 0) ? 0=
 : -ENOENT;<br>
+<br>
+}<br>
diff --git a/lib/ethdev/rte_mirror.h b/lib/ethdev/rte_mirror.h<br>
new file mode 100644<br>
index 0000000000..593ef477b6<br>
--- /dev/null<br>
+++ b/lib/ethdev/rte_mirror.h<br>
@@ -0,0 +1,147 @@<br>
+/* SPDX-License-Identifier: BSD-3-Clause<br>
+ * Copyright(c) 2025 Stephen Hemminger &lt;<a href=3D"mailto:stephen@netwo=
rkplumber.org" target=3D"_blank">stephen@networkplumber.org</a>&gt;<br>
+ */<br>
+<br>
+#ifndef RTE_MIRROR_H_<br>
+#define RTE_MIRROR_H_<br>
+<br>
+/**<br>
+ * @file<br>
+ * Ethdev port mirroring<br>
+ *<br>
+ * This interface provides the ability to duplicate packets to another por=
t.<br>
+ */<br>
+<br>
+#include &lt;stdint.h&gt;<br>
+<br>
+#include &lt;rte_compat.h&gt;<br>
+#include &lt;rte_mbuf.h&gt;<br>
+<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot; {<br>
+#endif<br>
+<br>
+/* Definitions for ethdev mirror flags */<br>
+#define RTE_ETH_MIRROR_DIRECTION_INGRESS 1<br>
+#define RTE_ETH_MIRROR_DIRECTION_EGRESS 2<br>
+#define RTE_ETH_MIRROR_DIRECTION_MASK (RTE_ETH_MIRROR_DIRECTION_INGRESS | =
\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_MIRROR_=
DIRECTION_EGRESS)<br>
+<br>
+#define RTE_ETH_MIRROR_TIMESTAMP_FLAG 4=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**&lt;=
 insert timestamp into mirrored packet */<br>
+#define RTE_ETH_MIRROR_ORIGIN_FLAG=C2=A0 =C2=A0 8=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /**&lt; insert rte_mbuf_origin into mirrored packet */<br>
+<br>
+#define RTE_ETH_MIRROR_FLAG_MASK=C2=A0 =C2=A0 =C2=A0 (RTE_ETH_MIRROR_TIMES=
TAMP_FLAG | \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_MIRROR_=
ORIGIN_FLAG)<br>
+/**<br>
+ * @warning<br>
+ * @b EXPERIMENTAL: this structure may change without prior notice.<br>
+ *<br>
+ * This dynamic field is added to mbuf&#39;s when they are copied to<br>
+ * the port mirror.<br>
+ */<br>
+typedef struct rte_mbuf_origin {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t original_len;=C2=A0 /**&lt; Packet len=
gth before copy */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t port_id;=C2=A0 =C2=A0 =C2=A0 =C2=A0/**=
&lt; Port where packet originated */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t queue_id;=C2=A0 =C2=A0 =C2=A0 /**&lt; =
Queue used for Tx or Rx */<br>
+} rte_mbuf_origin_t;<br>
+<br>
+/**<br>
+ * @warning<br>
+ * @b EXPERIMENTAL: this structure may change without prior notice.<br>
+ *<br>
+ * Structure used to configure ethdev Switched Port Analyzer (MIRROR)<br>
+ */<br>
+struct rte_bpf_prm;<br>
+struct rte_eth_mirror_conf {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mempool *mp; /**&lt; Memory pool for=
 copies, If NULL then cloned. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_bpf_prm *filter; /**&lt; Optional pa=
cket filter */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t snaplen;=C2=A0 =C2=A0 =C2=A0 =C2=A0/**=
&lt; Upper limit on number of bytes to copy */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t flags;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/**&lt; bitmask of RTE_ETH_MIRROR_XXX_FLAG&#39;s */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t target;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**=
&lt; Destination port */<br>
+};<br>
+<br>
+/**<br>
+ * @warning<br>
+ * @b EXPERIMENTAL: this structure may change without prior notice.<br>
+ *<br>
+ * Structure returned by rte_mirror_stats.<br>
+ */<br>
+struct rte_eth_mirror_stats {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t packets;=C2=A0 =C2=A0 =C2=A0 =C2=A0/**=
&lt; Number of mirrored packets. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t filtered;=C2=A0 =C2=A0 =C2=A0 /**&lt; =
Packets filtered by BPF program */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t nombuf;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**=
&lt; Rx mbuf allocation failures. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t full;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /**&lt; Target port transmit full. */<br>
+};<br>
+<br>
+/**<br>
+ * @warning<br>
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior noti=
ce<br>
+ *<br>
+ * Create a port mirror instance.<br>
+ *<br>
+ * @param port_id<br>
+ *=C2=A0 =C2=A0The port identifier of the source Ethernet device.<br>
+ * @param conf<br>
+ *=C2=A0 =C2=A0Settings for this MIRROR instance.<br>
+ * @return<br>
+ *=C2=A0 =C2=A0Negative errno value on error, 0 on success.<br>
+ */<br>
+__rte_experimental<br>
+int<br>
+rte_eth_add_mirror(uint16_t port_id, const struct rte_eth_mirror_conf *con=
f);<br>
+<br>
+/**<br>
+ * @warning<br>
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior noti=
ce<br>
+ *<br>
+ * Break port existing port mirroring.<br>
+ * After this call no more packets will be sent from origin port to the ta=
rget port.<br>
+ *<br>
+ * @param port_id<br>
+ *=C2=A0 =C2=A0The port identifier of the source Ethernet device.<br>
+ * @param target_id<br>
+ *=C2=A0 =C2=A0The identifier of the destination port.<br>
+ * @return<br>
+ *=C2=A0 =C2=A0Negative errno value on error, 0 on success.<br>
+ */<br>
+__rte_experimental<br>
+int rte_eth_remove_mirror(uint16_t port_id, uint16_t target_id);<br>
+<br>
+/**<br>
+ * @warning<br>
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior noti=
ce<br>
+ *<br>
+ * Query statistics for a mirror.<br>
+ *<br>
+ * @param port_id<br>
+ *=C2=A0 =C2=A0The port identifier of the source Ethernet device.<br>
+ * @param target_id<br>
+ *=C2=A0 =C2=A0The identifier of the destination port.<br>
+ * @param stats<br>
+ *=C2=A0 =C2=A0A pointer to a structure of type *rte_eth_mirror_stats* to =
be filled.<br>
+ *<br>
+ * @return<br>
+ *=C2=A0 =C2=A0Negative errno value on error, 0 on success.<br>
+ */<br>
+__rte_experimental<br>
+int rte_eth_mirror_stats_get(uint16_t port_id, uint16_t target_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_eth_mirror_stats *stats);<br>
+/**<br>
+ * @warning<br>
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior noti=
ce<br>
+ *<br>
+ * Reset statistics for mirror.<br>
+ *<br>
+ * @param port_id<br>
+ *=C2=A0 =C2=A0The port identifier of the source Ethernet device.<br>
+ * @param target_id<br>
+ *=C2=A0 =C2=A0The identifier of the destination port.<br>
+ */<br>
+__rte_experimental<br>
+int rte_eth_mirror_stats_reset(uint16_t port_id, uint16_t target_id);<br>
+<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
+#endif /* RTE_MIRROR_H_ */<br>
-- <br>
2.47.2<br>
<br>
</blockquote></div>

--000000000000f08896063c692656--
