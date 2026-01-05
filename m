Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECCBC79F9F
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 14:49:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D13E4026F;
	Mon,  5 Jan 2026 15:49:46 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1255440267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 15:49:44 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlHJN0PBRzHnH2m;
 Mon,  5 Jan 2026 22:49:40 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 738DD40570;
 Mon,  5 Jan 2026 22:49:42 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 5 Jan 2026 15:49:42 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 5 Jan 2026 15:49:42 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] test: add a test for null PMD
Thread-Topic: [PATCH] test: add a test for null PMD
Thread-Index: AQHcfckf3H51cQvjmkW1RP74leDirrVDav9w
Date: Mon, 5 Jan 2026 14:49:41 +0000
Message-ID: <7957b0215b1d41cbbc7fc5e52919f0da@huawei.com>
References: <20260104222523.329760-1-stephen@networkplumber.org>
In-Reply-To: <20260104222523.329760-1-stephen@networkplumber.org>
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

Thank you for doing this. Having tests for things like this is important bo=
th=20
to make sure they work and as a form of documentation.

In my humble opinion we should not approach this mechanically though, which=
 is=20
what AI tools tend to do. It is usually said that tests should test desired=
=20
behavior, not specific implementation. Particularly in settings some of the=
=20
values might not matter, or the whole range might be acceptable, in other c=
ases=20
current implementation might be questionable and by writing a test we just=
=20
legitimize it.

Please more see comments inline.

> diff --git a/app/test/test_pmd_null.c b/app/test/test_pmd_null.c
> new file mode 100644
> index 0000000000..ebc2447c6d
> --- /dev/null
> +++ b/app/test/test_pmd_null.c
> @@ -0,0 +1,827 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Stephen Hemminger
> + */
> +
> +#include <inttypes.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include <rte_bus_vdev.h>
> +#include <rte_cycles.h>
> +#include <rte_ethdev.h>
> +#include <rte_ether.h>
> +#include <rte_lcore.h>
> +#include <rte_mbuf.h>
> +#include <rte_mempool.h>

I do not think it is a problem, but just curious: how does test_pmd_ring.c=
=20
manage to use much fewer includes?

> +
> +#include "test.h"
> +
> +#define NUM_MBUFS 256
> +#define MBUF_CACHE_SIZE 32
> +#define BURST_SIZE 32
> +#define RING_SIZE 512
> +
> +/* Test device names */
> +#define NULL_DEV_NAME "net_null_test"
> +
> +static struct rte_mempool *mp;
> +static uint16_t port_id =3D RTE_MAX_ETHPORTS;
> +static bool port_created;
> +static bool port_started;

// snip setup and teardown functions, could find nothing to nitpick there

> +/*
> + * Test: Basic RX - should return empty packets
> + */
> +static int
> +test_null_rx_basic(void)
> +{
> +	struct rte_mbuf *bufs[BURST_SIZE];
> +	uint16_t nb_rx;
> +	unsigned int i;
> +
> +	/* RX should return requested number of empty packets */
> +	nb_rx =3D rte_eth_rx_burst(port_id, 0, bufs, BURST_SIZE);
> +	TEST_ASSERT(nb_rx =3D=3D BURST_SIZE,
> +		    "Expected %u packets, got %u", BURST_SIZE, nb_rx);
> +
> +	/* Verify packets have expected properties */
> +	for (i =3D 0; i < nb_rx; i++) {
> +		TEST_ASSERT(bufs[i] !=3D NULL, "Received NULL mbuf");
> +		TEST_ASSERT(bufs[i]->port =3D=3D port_id,
> +			    "Unexpected port id in mbuf: %u", bufs[i]->port);
> +		/* Default packet size is 64 bytes */

Default packet size repeats a few times in this file, can we have a global
constant for it?

> +		TEST_ASSERT(bufs[i]->pkt_len =3D=3D 64,
> +			    "Unexpected pkt_len: %u", bufs[i]->pkt_len);
> +		TEST_ASSERT(bufs[i]->data_len =3D=3D 64,
> +			    "Unexpected data_len: %u", bufs[i]->data_len);
> +	}
> +
> +	/* Free received mbufs */
> +	for (i =3D 0; i < nb_rx; i++)
> +		rte_pktmbuf_free(bufs[i]);
> +
> +	return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test: Basic TX - should free all packets
> + */
> +static int
> +test_null_tx_basic(void)
> +{
> +	struct rte_mbuf *bufs[BURST_SIZE];
> +	uint16_t nb_tx;
> +	unsigned int i;
> +	unsigned int pool_count_before, pool_count_after;
> +
> +	/* Allocate mbufs for TX */
> +	for (i =3D 0; i < BURST_SIZE; i++) {
> +		bufs[i] =3D rte_pktmbuf_alloc(mp);
> +		TEST_ASSERT(bufs[i] !=3D NULL, "Failed to allocate mbuf");
> +		bufs[i]->data_len =3D 64;
> +		bufs[i]->pkt_len =3D 64;

It would help to test sending packets of various sizes, especially spanning=
=20
multiple buffers or allocating them at the edge of buffer. May even uncover=
=20
some bugs in the copy mode implementation ;)

> +	}
> +
> +	pool_count_before =3D rte_mempool_avail_count(mp);
> +
> +	/* TX should accept and free all packets */
> +	nb_tx =3D rte_eth_tx_burst(port_id, 0, bufs, BURST_SIZE);
> +	TEST_ASSERT(nb_tx =3D=3D BURST_SIZE,
> +		    "Expected to TX %u packets, but sent %u", BURST_SIZE, nb_tx);
> +
> +	/* Give some time for async operations (if any) */
> +	rte_delay_us_block(100);
> +
> +	pool_count_after =3D rte_mempool_avail_count(mp);
> +
> +	/* Verify mbufs were freed - pool should have same count */
> +	TEST_ASSERT(pool_count_after >=3D pool_count_before,
> +		    "Mbufs not freed: before=3D%u, after=3D%u",
> +		    pool_count_before, pool_count_after);
> +
> +	return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test: Statistics verification
> + */
> +static int
> +test_null_stats(void)
> +{
> +	struct rte_eth_stats stats;
> +	struct rte_mbuf *rx_bufs[BURST_SIZE];
> +	struct rte_mbuf *tx_bufs[BURST_SIZE];
> +	uint16_t nb_rx, nb_tx;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Reset stats */
> +	ret =3D rte_eth_stats_reset(port_id);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to reset stats");
> +
> +	/* Get initial stats */
> +	ret =3D rte_eth_stats_get(port_id, &stats);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to get stats");
> +	TEST_ASSERT(stats.ipackets =3D=3D 0, "Initial ipackets not zero");
> +	TEST_ASSERT(stats.opackets =3D=3D 0, "Initial opackets not zero");
> +
> +	/* Perform RX */
> +	nb_rx =3D rte_eth_rx_burst(port_id, 0, rx_bufs, BURST_SIZE);
> +	TEST_ASSERT(nb_rx =3D=3D BURST_SIZE, "RX burst failed");
> +
> +	/* Allocate and perform TX */
> +	for (i =3D 0; i < BURST_SIZE; i++) {
> +		tx_bufs[i] =3D rte_pktmbuf_alloc(mp);
> +		TEST_ASSERT(tx_bufs[i] !=3D NULL, "Failed to allocate mbuf");
> +		tx_bufs[i]->data_len =3D 64;
> +		tx_bufs[i]->pkt_len =3D 64;

Here and elsewhere, it would be interesting to test something non-default.

> +	}
> +	nb_tx =3D rte_eth_tx_burst(port_id, 0, tx_bufs, BURST_SIZE);
> +	TEST_ASSERT(nb_tx =3D=3D BURST_SIZE, "TX burst failed");
> +
> +	/* Get updated stats */
> +	ret =3D rte_eth_stats_get(port_id, &stats);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to get stats after RX/TX");
> +
> +	/* Verify stats */
> +	TEST_ASSERT(stats.ipackets =3D=3D BURST_SIZE,
> +		    "Expected ipackets=3D%u, got %"PRIu64,
> +		    BURST_SIZE, stats.ipackets);
> +	TEST_ASSERT(stats.opackets =3D=3D BURST_SIZE,
> +		    "Expected opackets=3D%u, got %"PRIu64,
> +		    BURST_SIZE, stats.opackets);
> +	/* Default packet size is 64 bytes */
> +	TEST_ASSERT(stats.ibytes =3D=3D BURST_SIZE * 64,
> +		    "Expected ibytes=3D%u, got %"PRIu64,
> +		    BURST_SIZE * 64, stats.ibytes);
> +	TEST_ASSERT(stats.obytes =3D=3D BURST_SIZE * 64,
> +		    "Expected obytes=3D%u, got %"PRIu64,
> +		    BURST_SIZE * 64, stats.obytes);
> +
> +	/* Free RX mbufs */
> +	for (i =3D 0; i < nb_rx; i++)
> +		rte_pktmbuf_free(rx_bufs[i]);
> +
> +	return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test: Custom packet size
> + */
> +static int
> +test_null_custom_size(void)
> +{
> +	struct rte_mbuf *bufs[BURST_SIZE];
> +	uint16_t custom_port;
> +	uint16_t nb_rx;
> +	unsigned int i;
> +	const unsigned int custom_size =3D 256;

What about bigger values, something exceeding RTE_MBUF_DEFAULT_BUF_SIZE? Wi=
ll=20
it be able to honour them or at least fail gracefully?

> +	int ret;
> +
> +	/* Create null device with custom size */
> +	ret =3D create_null_port("net_null_size_test", "size=3D256", &custom_po=
rt);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to create null port with custom size"=
);
> +
> +	ret =3D configure_null_port(custom_port);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to configure null port");
> +
> +	/* RX should return packets with custom size */
> +	nb_rx =3D rte_eth_rx_burst(custom_port, 0, bufs, BURST_SIZE);
> +	TEST_ASSERT(nb_rx =3D=3D BURST_SIZE, "RX burst failed");
> +
> +	/* Verify custom packet size */
> +	for (i =3D 0; i < nb_rx; i++) {
> +		TEST_ASSERT(bufs[i]->pkt_len =3D=3D custom_size,
> +			    "Expected pkt_len=3D%u, got %u",
> +			    custom_size, bufs[i]->pkt_len);
> +		TEST_ASSERT(bufs[i]->data_len =3D=3D custom_size,
> +			    "Expected data_len=3D%u, got %u",
> +			    custom_size, bufs[i]->data_len);
> +		rte_pktmbuf_free(bufs[i]);
> +	}
> +
> +	/* Cleanup custom port */
> +	rte_eth_dev_stop(custom_port);
> +	rte_eth_dev_close(custom_port);
> +	rte_vdev_uninit("net_null_size_test");
> +
> +	return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test: Copy mode
> + */
> +static int
> +test_null_copy_mode(void)
> +{
> +	struct rte_mbuf *rx_bufs[BURST_SIZE];
> +	uint16_t copy_port;
> +	uint16_t nb_rx;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Create null device with copy enabled */
> +	ret =3D create_null_port("net_null_copy_test", "copy=3D1", &copy_port);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to create null port with copy mode");
> +
> +	ret =3D configure_null_port(copy_port);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to configure null port");
> +
> +	/* RX in copy mode should work */
> +	nb_rx =3D rte_eth_rx_burst(copy_port, 0, rx_bufs, BURST_SIZE);
> +	TEST_ASSERT(nb_rx =3D=3D BURST_SIZE, "RX burst in copy mode failed");
> +
> +	/* Free RX mbufs */
> +	for (i =3D 0; i < nb_rx; i++)
> +		rte_pktmbuf_free(rx_bufs[i]);
> +
> +	/* Cleanup */
> +	rte_eth_dev_stop(copy_port);
> +	rte_eth_dev_close(copy_port);
> +	rte_vdev_uninit("net_null_copy_test");
> +
> +	return TEST_SUCCESS;
> +}

As far as I understand, copy mode should not be different for the end user=
=20
(apart from performance and bugs). The test for it is not as comprehensive =
as=20
for the default mode. Can we save some LOCs and improve coverage by just=20
running full tests twice, with a boolean parameter for the copy mode?

> +
> +/*
> + * Test: No-RX mode
> + */
> +static int
> +test_null_no_rx_mode(void)
> +{
> +	struct rte_mbuf *rx_bufs[BURST_SIZE];
> +	struct rte_mbuf *tx_bufs[BURST_SIZE];
> +	uint16_t norx_port;
> +	uint16_t nb_rx, nb_tx;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Create null device with no-rx enabled */
> +	ret =3D create_null_port("net_null_norx_test", "no-rx=3D1", &norx_port)=
;
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to create null port with no-rx mode")=
;
> +
> +	ret =3D configure_null_port(norx_port);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to configure null port");
> +
> +	/* RX in no-rx mode should return 0 packets */
> +	nb_rx =3D rte_eth_rx_burst(norx_port, 0, rx_bufs, BURST_SIZE);
> +	TEST_ASSERT(nb_rx =3D=3D 0,
> +		    "Expected 0 packets in no-rx mode, got %u", nb_rx);
> +
> +	/* TX in no-rx mode should still work (frees packets) */
> +	for (i =3D 0; i < BURST_SIZE; i++) {
> +		tx_bufs[i] =3D rte_pktmbuf_alloc(mp);
> +		TEST_ASSERT(tx_bufs[i] !=3D NULL, "Failed to allocate mbuf");
> +		tx_bufs[i]->data_len =3D 64;
> +		tx_bufs[i]->pkt_len =3D 64;
> +	}
> +
> +	nb_tx =3D rte_eth_tx_burst(norx_port, 0, tx_bufs, BURST_SIZE);
> +	TEST_ASSERT(nb_tx =3D=3D BURST_SIZE, "TX burst in no-rx mode failed");
> +
> +	/* Cleanup */
> +	rte_eth_dev_stop(norx_port);
> +	rte_eth_dev_close(norx_port);
> +	rte_vdev_uninit("net_null_norx_test");
> +
> +	return TEST_SUCCESS;

Probably fine, but could also make it a mode for the rest of the tests to=20
verify also statistics etc.

> +}
> +
> +/*
> + * Test: Link status
> + */
> +static int
> +test_null_link_status(void)
> +{
> +	struct rte_eth_link link;
> +	int ret;
> +
> +	ret =3D rte_eth_link_get_nowait(port_id, &link);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to get link status");
> +
> +	/* After start, link should be UP */
> +	TEST_ASSERT(link.link_status =3D=3D RTE_ETH_LINK_UP,
> +		    "Expected link UP after start");
> +	TEST_ASSERT(link.link_speed =3D=3D RTE_ETH_SPEED_NUM_10G,
> +		    "Expected 10G link speed");

I am not sure it is important to test that the link speed is exactly 10G. W=
ill=20
it be a bug if it becomes 25G tomorrow? Probably any valid value would do.

> +	TEST_ASSERT(link.link_duplex =3D=3D RTE_ETH_LINK_FULL_DUPLEX,
> +		    "Expected full duplex");
> +
> +	/* Stop the device */
> +	ret =3D rte_eth_dev_stop(port_id);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to stop device");
> +
> +	ret =3D rte_eth_link_get_nowait(port_id, &link);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to get link status after stop");
> +
> +	/* After stop, link should be DOWN */
> +	TEST_ASSERT(link.link_status =3D=3D RTE_ETH_LINK_DOWN,
> +		    "Expected link DOWN after stop");
> +
> +	/* Restart for subsequent tests */
> +	ret =3D rte_eth_dev_start(port_id);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to restart device");
> +
> +	return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test: Device info
> + */
> +static int
> +test_null_dev_info(void)
> +{
> +	struct rte_eth_dev_info dev_info;
> +	int ret;
> +
> +	ret =3D rte_eth_dev_info_get(port_id, &dev_info);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to get device info");
> +
> +	/* Verify expected device info values */
> +	TEST_ASSERT(dev_info.max_mac_addrs =3D=3D 1,
> +		    "Expected max_mac_addrs=3D1, got %u", dev_info.max_mac_addrs);
> +	TEST_ASSERT(dev_info.max_rx_pktlen =3D=3D (uint32_t)-1,
> +		    "Unexpected max_rx_pktlen");

Why is (uint32_t)-1 is a valid packet length for this device? Can at actual=
ly=20
accept them?

> +	TEST_ASSERT(dev_info.min_rx_bufsize =3D=3D 0,
> +		    "Expected min_rx_bufsize=3D0, got %u", dev_info.min_rx_bufsize);
> +
> +	/* Check TX offload capabilities */
> +	TEST_ASSERT(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MULTI_SEGS,
> +		    "Expected MULTI_SEGS TX offload capability");

It sure sets these values, but are they correct values, and would anything =
else=20
be incorrect?

> +	TEST_ASSERT(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE,
> +		    "Expected MT_LOCKFREE TX offload capability");
> +
> +	/* Check RSS capabilities */
> +	TEST_ASSERT(dev_info.reta_size > 0, "Expected non-zero reta_size");
> +	TEST_ASSERT(dev_info.hash_key_size =3D=3D 40,
> +		    "Expected hash_key_size=3D40, got %u", dev_info.hash_key_size);
> +	TEST_ASSERT(dev_info.flow_type_rss_offloads !=3D 0,
> +		    "Expected RSS offloads to be set");
> +
> +	return TEST_SUCCESS;
> +}

// snip test_null_multiple_bursts, looks fine

> +/*
> + * Test: RSS configuration
> + * Note: RSS requires multi-queue configuration
> + */
> +static int
> +test_null_rss_config(void)
> +{
> +	struct rte_eth_dev_info dev_info;
> +	struct rte_eth_rss_conf rss_conf;
> +	struct rte_eth_conf port_conf =3D {0};
> +	uint8_t rss_key[40];
> +	uint16_t rss_port;
> +	const uint16_t num_queues =3D 2;
> +	uint16_t q;
> +	int ret;
> +
> +	/* Create a new null device for RSS testing with multiple queues */
> +	ret =3D create_null_port("net_null_rss_test", NULL, &rss_port);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to create null port for RSS test");
> +
> +	ret =3D rte_eth_dev_info_get(rss_port, &dev_info);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to get device info");
> +
> +	/* Configure with RSS enabled and multiple queues */
> +	port_conf.rxmode.mq_mode =3D RTE_ETH_MQ_RX_RSS;
> +	port_conf.rx_adv_conf.rss_conf.rss_hf =3D dev_info.flow_type_rss_offloa=
ds;
> +
> +	ret =3D rte_eth_dev_configure(rss_port, num_queues, num_queues, &port_c=
onf);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to configure RSS port");
> +
> +	for (q =3D 0; q < num_queues; q++) {
> +		ret =3D rte_eth_rx_queue_setup(rss_port, q, RING_SIZE,
> +					     rte_eth_dev_socket_id(rss_port),
> +					     NULL, mp);
> +		TEST_ASSERT(ret =3D=3D 0, "Failed to setup RX queue %u", q);
> +
> +		ret =3D rte_eth_tx_queue_setup(rss_port, q, RING_SIZE,
> +					     rte_eth_dev_socket_id(rss_port),
> +					     NULL);
> +		TEST_ASSERT(ret =3D=3D 0, "Failed to setup TX queue %u", q);
> +	}
> +
> +	ret =3D rte_eth_dev_start(rss_port);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to start RSS port");
> +
> +	/* Get current RSS config */
> +	memset(&rss_conf, 0, sizeof(rss_conf));
> +	rss_conf.rss_key =3D rss_key;
> +	rss_conf.rss_key_len =3D sizeof(rss_key);
> +
> +	ret =3D rte_eth_dev_rss_hash_conf_get(rss_port, &rss_conf);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to get RSS hash config");
> +
> +	/* Update RSS config with new key */
> +	memset(rss_key, 0x55, sizeof(rss_key));
> +	rss_conf.rss_key =3D rss_key;
> +	rss_conf.rss_key_len =3D sizeof(rss_key);
> +	rss_conf.rss_hf =3D dev_info.flow_type_rss_offloads;
> +
> +	ret =3D rte_eth_dev_rss_hash_update(rss_port, &rss_conf);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to update RSS hash config");
> +
> +	/* Verify the update */
> +	memset(rss_key, 0, sizeof(rss_key));
> +	rss_conf.rss_key =3D rss_key;
> +
> +	ret =3D rte_eth_dev_rss_hash_conf_get(rss_port, &rss_conf);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to get RSS hash config after update")=
;
> +
> +	/* Verify key was updated */
> +	for (unsigned int i =3D 0; i < sizeof(rss_key); i++) {
> +		TEST_ASSERT(rss_key[i] =3D=3D 0x55,
> +			    "RSS key not updated at byte %u", i);
> +	}
> +

Can we receive and send something from/to these queues and verify resulting=
=20
statistics? Statistics is one of the most important use cases for the null=
=20
device, and it does benefit from multi-queue.

> +	/* Cleanup */
> +	rte_eth_dev_stop(rss_port);
> +	rte_eth_dev_close(rss_port);
> +	rte_vdev_uninit("net_null_rss_test");
> +
> +	return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test: RETA (Redirection Table) configuration
> + * Note: RETA requires multi-queue RSS configuration
> + */
> +static int
> +test_null_reta_config(void)
> +{

Not sure who actually handles reta for the null device, additional tests=20
actually using it may or may not be necessary depending on the answer.

// snip the rest of the function

> +}

// snip test_null_stats_reset, looks fine.

> +/*
> + * Test: MAC address operations
> + */
> +static int
> +test_null_mac_addr(void)
> +{
> +	struct rte_ether_addr mac_addr;
> +	struct rte_ether_addr new_mac =3D {
> +		.addr_bytes =3D {0x00, 0x11, 0x22, 0x33, 0x44, 0x55}
> +	};
> +	int ret;
> +
> +	/* Get current MAC address */
> +	ret =3D rte_eth_macaddr_get(port_id, &mac_addr);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to get MAC address");
> +
> +	/* Set new MAC address */
> +	ret =3D rte_eth_dev_default_mac_addr_set(port_id, &new_mac);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to set MAC address");

Should we now check that it was actually set?

> +
> +	return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test: Promiscuous and allmulticast modes
> + */
> +static int
> +test_null_promisc_allmulti(void)
> +{
> +	int ret;
> +
> +	/* Test promiscuous mode - null PMD starts with promiscuous enabled */
> +	ret =3D rte_eth_promiscuous_get(port_id);
> +	TEST_ASSERT(ret =3D=3D 1, "Expected promiscuous mode enabled");
> +
> +	/* Test allmulticast mode - null PMD starts with allmulti enabled */
> +	ret =3D rte_eth_allmulticast_get(port_id);
> +	TEST_ASSERT(ret =3D=3D 1, "Expected allmulticast mode enabled");

Similar concerns as with other settings, are these specific values importan=
t?

> +
> +	return TEST_SUCCESS;
> +}
> +
> +static struct unit_test_suite null_pmd_test_suite =3D {
> +	.suite_name =3D "Null PMD Unit Test Suite",
> +	.setup =3D test_null_setup,
> +	.teardown =3D test_null_teardown,
> +	.unit_test_cases =3D {
> +		TEST_CASE(test_null_rx_basic),
> +		TEST_CASE(test_null_tx_basic),
> +		TEST_CASE(test_null_stats),
> +		TEST_CASE(test_null_custom_size),
> +		TEST_CASE(test_null_copy_mode),
> +		TEST_CASE(test_null_no_rx_mode),
> +		TEST_CASE(test_null_link_status),
> +		TEST_CASE(test_null_dev_info),
> +		TEST_CASE(test_null_multiple_bursts),
> +		TEST_CASE(test_null_rss_config),
> +		TEST_CASE(test_null_reta_config),
> +		TEST_CASE(test_null_stats_reset),
> +		TEST_CASE(test_null_mac_addr),
> +		TEST_CASE(test_null_promisc_allmulti),

test_pmd_ring.c is also doing some command-line testing, although it requir=
es=20
some cooperation from the test framework. Are we not going to cover this pa=
rt=20
for now?

> +
> +		TEST_CASES_END() /**< NULL terminate unit test array */
> +	}
> +};
> +
> +static int
> +test_pmd_null(void)
> +{
> +	return unit_test_suite_runner(&null_pmd_test_suite);
> +}
> +
> +REGISTER_FAST_TEST(null_pmd_autotest, true, true, test_pmd_null);
> --
> 2.51.0

