Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D302ACCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 09:47:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F31B640649;
	Tue, 11 Nov 2025 10:46:59 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D585840613
 for <dev@dpdk.org>; Tue, 11 Nov 2025 10:46:58 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5M9v30bJzJ46jb;
 Tue, 11 Nov 2025 17:46:27 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 1C22514038F;
 Tue, 11 Nov 2025 17:46:58 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 10:46:57 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 11 Nov 2025 10:46:57 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v5 4/5] bpf: add test for Rx and Tx filtering
Thread-Topic: [PATCH v5 4/5] bpf: add test for Rx and Tx filtering
Thread-Index: AQHcUbTYYlsbY2d8hESN8gEKhf0QBrTtOn3Q
Date: Tue, 11 Nov 2025 09:46:57 +0000
Message-ID: <6a01168a950543e588d2a66a5f70023c@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251109200854.45942-1-stephen@networkplumber.org>
 <20251109200854.45942-5-stephen@networkplumber.org>
In-Reply-To: <20251109200854.45942-5-stephen@networkplumber.org>
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
> Sent: Sunday 9 November 2025 20:08
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>
> Subject: [PATCH v5 4/5] bpf: add test for Rx and Tx filtering
>=20
> New test using null device to test filtering with BPF.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Marat Khalili <marat.khalili@huawei.com>

(Turns out there were some issues with the pre-existing code which
I initially blamed on this patch set. Maybe some cleanup is needed.)

> ---
>  app/test/bpf/filter.c    |  53 +++++++
>  app/test/bpf/meson.build |   1 +
>  app/test/test_bpf.c      | 307 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 361 insertions(+)
>  create mode 100644 app/test/bpf/filter.c
>=20
> diff --git a/app/test/bpf/filter.c b/app/test/bpf/filter.c
> new file mode 100644
> index 0000000000..d47233a47a
> --- /dev/null
> +++ b/app/test/bpf/filter.c
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * BPF TX filter program for testing rte_bpf_eth_tx_elf_load
> + */
> +
> +typedef unsigned char uint8_t;
> +typedef unsigned short uint16_t;
> +typedef unsigned int uint32_t;
> +typedef unsigned long uint64_t;
> +
> +/*
> + * Simple TX filter that accepts TCP packets
> + *
> + * BPF TX programs receive pointer to data and should return:
> + *   0 =3D drop packet
> + *   non-zero =3D rx/tx packet
> + *
> + * This filter checks:
> + * 1. Packet is IPv4
> + * 2. Protocol is TCP (IPPROTO_TCP =3D 6)
> + */
> +__attribute__((section("filter"), used))
> +uint64_t
> +test_filter(void *pkt)
> +{
> +	uint8_t *data =3D pkt;
> +
> +	/* Read version and IHL (first byte of IP header) */
> +	uint8_t version_ihl =3D data[14];
> +
> +	/* Check IPv4 version (upper 4 bits should be 4) */
> +	if ((version_ihl >> 4) !=3D 4)
> +		return 0;
> +
> +	/* Protocol field (byte 9 of IP header) must be TCP (6) */
> +	uint8_t proto =3D data[14 + 9];
> +	return (proto =3D=3D 6);
> +}
> +
> +__attribute__((section("drop"), used))
> +uint64_t
> +test_drop(void *pkt)
> +{
> +	(void)pkt;
> +	return 0;
> +}
> +
> +__attribute__((section("allow"), used))
> +uint64_t
> +test_allow(void *pkt)
> +{
> +	(void)pkt;
> +	return 1;
> +}
> diff --git a/app/test/bpf/meson.build b/app/test/bpf/meson.build
> index b4f54aa976..19fec05521 100644
> --- a/app/test/bpf/meson.build
> +++ b/app/test/bpf/meson.build
> @@ -32,6 +32,7 @@ cflags +=3D '-DTEST_BPF_ELF_LOAD'
>  # BPF sources to compile
>  bpf_progs =3D {
>      'load' : 'test_bpf_load',
> +    'filter' : 'test_bpf_filter',
>  }
>=20
>  foreach bpf_src, bpf_hdr : bpf_progs
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index a80f41a543..24d18f9d33 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -16,6 +16,12 @@
>  #include <rte_byteorder.h>
>  #include <rte_errno.h>
>  #include <rte_bpf.h>
> +#include <rte_ethdev.h>
> +#include <rte_bpf_ethdev.h>
> +#include <rte_bus_vdev.h>
> +#include <rte_ether.h>
> +#include <rte_ip.h>
> +#include <rte_tcp.h>
>=20
>  #include "test.h"
>=20
> @@ -3421,6 +3427,291 @@ test_bpf_elf_load(void)
>  	printf("%s: ELF load test passed\n", __func__);
>  	return TEST_SUCCESS;
>  }
> +
> +#include "test_bpf_filter.h"
> +
> +#define BPF_TEST_BURST		128
> +#define BPF_TEST_POOLSIZE	256 /* at least 2x burst */
> +#define BPF_TEST_PKT_LEN	64 /* Ether + IP + TCP */
> +
> +static int null_vdev_setup(const char *name, uint16_t *port, struct rte_=
mempool *pool)
> +{
> +	int ret;
> +
> +	/* Make a null device */
> +	ret =3D rte_vdev_init(name, NULL);
> +	TEST_ASSERT(ret =3D=3D 0, "rte_vdev_init(%s) failed: %d", name, ret);
> +
> +	ret =3D rte_eth_dev_get_port_by_name(name, port);
> +	TEST_ASSERT(ret =3D=3D 0, "failed to get port id for %s: %d", name, ret=
);
> +
> +	struct rte_eth_conf conf =3D { };
> +	ret =3D rte_eth_dev_configure(*port, 1, 1, &conf);
> +	TEST_ASSERT(ret =3D=3D 0, "failed to configure port %u: %d", *port, ret=
);
> +
> +	struct rte_eth_txconf txconf =3D { };
> +	ret =3D rte_eth_tx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY,=
 &txconf);
> +	TEST_ASSERT(ret =3D=3D 0, "failed to setup tx queue port %u: %d", *port=
, ret);
> +
> +	struct rte_eth_rxconf rxconf =3D { };
> +	ret =3D rte_eth_rx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY,
> +				     &rxconf, pool);
> +	TEST_ASSERT(ret =3D=3D 0, "failed to setup rx queue port %u: %d", *port=
, ret);
> +
> +	ret =3D rte_eth_dev_start(*port);
> +	TEST_ASSERT(ret =3D=3D 0, "failed to start port %u: %d", *port, ret);
> +
> +	return 0;
> +}
> +
> +static unsigned int
> +setup_mbufs(struct rte_mbuf *burst[], unsigned int n)
> +{
> +	struct rte_ether_hdr eh =3D {
> +		.ether_type =3D rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4),
> +	};
> +	const struct rte_ipv4_hdr iph =3D {
> +		.version_ihl =3D RTE_IPV4_VHL_DEF,
> +		.total_length =3D rte_cpu_to_be_16(BPF_TEST_PKT_LEN - sizeof(eh)),
> +		.time_to_live =3D IPDEFTTL,
> +		.src_addr =3D rte_cpu_to_be_32(ip_src_addr),
> +		.dst_addr =3D rte_cpu_to_be_32(ip_dst_addr),
> +	};
> +	unsigned int tcp_count =3D 0;
> +
> +	rte_eth_random_addr(eh.dst_addr.addr_bytes);
> +
> +	for (unsigned int i =3D 0; i < n; i++) {
> +		struct rte_mbuf *mb =3D burst[i];
> +
> +		/* Setup Ethernet header */
> +		*rte_pktmbuf_mtod(mb, struct rte_ether_hdr *) =3D eh;
> +
> +		/* Setup IP header */
> +		struct rte_ipv4_hdr *ip
> +			=3D rte_pktmbuf_mtod_offset(mb, struct rte_ipv4_hdr *, sizeof(eh));
> +		*ip =3D iph;
> +
> +		if (rte_rand() & 1) {
> +			struct rte_udp_hdr *udp
> +				=3D rte_pktmbuf_mtod_offset(mb, struct rte_udp_hdr *,
> +							  sizeof(eh) + sizeof(iph));
> +
> +			ip->next_proto_id =3D IPPROTO_UDP;
> +			*udp =3D (struct rte_udp_hdr) {
> +				.src_port =3D rte_cpu_to_be_16(9),	/* discard */
> +				.dst_port =3D rte_cpu_to_be_16(9),	/* discard */
> +				.dgram_len =3D BPF_TEST_PKT_LEN - sizeof(eh) - sizeof(iph),
> +			};
> +
> +		} else {
> +			struct rte_tcp_hdr *tcp
> +				=3D rte_pktmbuf_mtod_offset(mb, struct rte_tcp_hdr *,
> +							  sizeof(eh) + sizeof(iph));
> +
> +			ip->next_proto_id =3D IPPROTO_TCP;
> +			*tcp =3D (struct rte_tcp_hdr) {
> +				.src_port =3D rte_cpu_to_be_16(9),	/* discard */
> +				.dst_port =3D rte_cpu_to_be_16(9),	/* discard */
> +				.tcp_flags =3D RTE_TCP_RST_FLAG,
> +			};
> +			++tcp_count;
> +		}
> +	}
> +
> +	return tcp_count;
> +}
> +
> +static int bpf_tx_test(uint16_t port, const char *tmpfile, struct rte_me=
mpool *pool,
> +		       const char *section, uint32_t flags)
> +{
> +	const struct rte_bpf_prm prm =3D {
> +		.prog_arg =3D {
> +			.type =3D RTE_BPF_ARG_PTR,
> +			.size =3D sizeof(struct rte_mbuf),
> +		},
> +	};
> +	int ret;
> +
> +	struct rte_mbuf *pkts[BPF_TEST_BURST] =3D { };
> +	ret =3D rte_pktmbuf_alloc_bulk(pool, pkts, BPF_TEST_BURST);
> +	TEST_ASSERT(ret =3D=3D 0, "failed to allocate mbufs");
> +
> +	uint16_t expect =3D setup_mbufs(pkts, BPF_TEST_BURST);
> +
> +	/* Try to load BPF TX program from temp file */
> +	ret =3D rte_bpf_eth_tx_elf_load(port, 0, &prm, tmpfile, section, flags)=
;
> +	TEST_ASSERT(ret =3D=3D 0, "failed to load BPF filter from temp file %s:=
 %d",
> +		    tmpfile, ret);
> +
> +	uint16_t sent =3D rte_eth_tx_burst(port, 0, pkts, BPF_TEST_BURST);
> +	TEST_ASSERT_EQUAL(sent, expect, "rte_eth_tx_burst returned: %u expected=
 %u",
> +			  sent, expect);
> +
> +	/* The unsent packets should be dropped */
> +	rte_pktmbuf_free_bulk(pkts + sent, BPF_TEST_BURST - sent);
> +
> +	/* Pool should have same number of packets avail */
> +	unsigned int avail =3D rte_mempool_avail_count(pool);
> +	TEST_ASSERT_EQUAL(avail, BPF_TEST_POOLSIZE,
> +			  "Mempool available %u !=3D %u leaks?", avail, BPF_TEST_POOLSIZE);
> +
> +	rte_bpf_eth_tx_unload(port, 0);
> +	return TEST_SUCCESS;
> +}
> +
> +/* Test loading a transmit filter which only allows IPv4 packets */
> +static int
> +test_bpf_elf_tx_load(void)
> +{
> +	static const char null_dev[] =3D "net_null_bpf0";
> +	char *tmpfile =3D NULL;
> +	struct rte_mempool *mb_pool =3D NULL;
> +	uint16_t port =3D UINT16_MAX;
> +	int ret;
> +
> +	printf("%s start\n", __func__);
> +
> +	/* Make a pool for packets */
> +	mb_pool =3D rte_pktmbuf_pool_create("bpf_tx_test_pool", BPF_TEST_POOLSI=
ZE,
> +					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
> +					  SOCKET_ID_ANY);
> +
> +	ret =3D null_vdev_setup(null_dev, &port, mb_pool);
> +	if (ret !=3D 0)
> +		goto fail;
> +
> +	/* Create temp file from embedded BPF object */
> +	tmpfile =3D create_temp_bpf_file(app_test_bpf_filter_o, app_test_bpf_fi=
lter_o_len, "tx");
> +	if (tmpfile =3D=3D NULL)
> +		goto fail;
> +
> +	/* Do test with VM */
> +	ret =3D bpf_tx_test(port, tmpfile, mb_pool, "filter", 0);
> +	if (ret !=3D 0)
> +		goto fail;
> +
> +	/* Repeat with JIT */
> +	ret =3D bpf_tx_test(port, tmpfile, mb_pool, "filter", RTE_BPF_ETH_F_JIT=
);
> +	if (ret =3D=3D 0)
> +		printf("%s: TX ELF load test passed\n", __func__);
> +
> +fail:
> +	if (tmpfile) {
> +		unlink(tmpfile);
> +		free(tmpfile);
> +	}
> +
> +	if (port !=3D UINT16_MAX)
> +		rte_vdev_uninit(null_dev);
> +
> +	rte_mempool_free(mb_pool);
> +
> +	return ret =3D=3D 0 ? TEST_SUCCESS : TEST_FAILED;
> +}
> +
> +/* Test loading a receive filter */
> +static int bpf_rx_test(uint16_t port, const char *tmpfile, struct rte_me=
mpool *pool,
> +		       const char *section, uint32_t flags, uint16_t expected)
> +{
> +	struct rte_mbuf *pkts[BPF_TEST_BURST];
> +	const struct rte_bpf_prm prm =3D {
> +		.prog_arg =3D {
> +			.type =3D RTE_BPF_ARG_PTR,
> +			.size =3D sizeof(struct rte_mbuf),
> +		},
> +	};
> +	int ret;
> +
> +	/* Load BPF program to drop all packets */
> +	ret =3D rte_bpf_eth_rx_elf_load(port, 0, &prm, tmpfile, section, flags)=
;
> +	TEST_ASSERT(ret =3D=3D 0, "failed to load BPF filter from temp file %s:=
 %d",
> +		    tmpfile, ret);
> +
> +	uint16_t rcvd =3D rte_eth_rx_burst(port, 0, pkts, BPF_TEST_BURST);
> +	TEST_ASSERT_EQUAL(rcvd, expected,
> +			  "rte_eth_rx_burst returned: %u expect: %u", rcvd, expected);
> +
> +	/* Drop the received packets */
> +	rte_pktmbuf_free_bulk(pkts, rcvd);
> +
> +	rte_bpf_eth_rx_unload(port, 0);
> +
> +	/* Pool should now be full */
> +	unsigned int avail =3D rte_mempool_avail_count(pool);
> +	TEST_ASSERT_EQUAL(avail, BPF_TEST_POOLSIZE,
> +			  "Mempool available %u !=3D %u leaks?", avail, BPF_TEST_POOLSIZE);
> +
> +	return TEST_SUCCESS;
> +}
> +
> +/* Test loading a receive filters, first with drop all and then with all=
ow all packets */
> +static int
> +test_bpf_elf_rx_load(void)
> +{
> +	static const char null_dev[] =3D "net_null_bpf0";
> +	struct rte_mempool *pool =3D NULL;
> +	char *tmpfile =3D NULL;
> +	uint16_t port;
> +	int ret;
> +
> +	printf("%s start\n", __func__);
> +
> +	/* Make a pool for packets */
> +	pool =3D rte_pktmbuf_pool_create("bpf_rx_test_pool", 2 * BPF_TEST_BURST=
,
> +					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
> +					  SOCKET_ID_ANY);
> +	TEST_ASSERT(pool !=3D NULL, "failed to create mempool");
> +
> +	ret =3D null_vdev_setup(null_dev, &port, pool);
> +	if (ret !=3D 0)
> +		goto fail;
> +
> +	/* Create temp file from embedded BPF object */
> +	tmpfile =3D create_temp_bpf_file(app_test_bpf_filter_o, app_test_bpf_fi=
lter_o_len, "rx");
> +	if (tmpfile =3D=3D NULL)
> +		goto fail;
> +
> +	/* Do test with VM */
> +	ret =3D bpf_rx_test(port, tmpfile, pool, "drop", 0, 0);
> +	if (ret !=3D 0)
> +		goto fail;
> +
> +	/* Repeat with JIT */
> +	ret =3D bpf_rx_test(port, tmpfile, pool, "drop", RTE_BPF_ETH_F_JIT, 0);
> +	if (ret !=3D 0)
> +		goto fail;
> +
> +	/* Repeat with allow all */
> +	ret =3D bpf_rx_test(port, tmpfile, pool, "allow", 0, BPF_TEST_BURST);
> +	if (ret !=3D 0)
> +		goto fail;
> +
> +	/* Repeat with JIT */
> +	ret =3D bpf_rx_test(port, tmpfile, pool, "allow", RTE_BPF_ETH_F_JIT, BP=
F_TEST_BURST);
> +	if (ret !=3D 0)
> +		goto fail;
> +
> +	printf("%s: RX ELF load test passed\n", __func__);
> +
> +	/* The filter should free the mbufs */
> +	unsigned int avail =3D rte_mempool_avail_count(pool);
> +	TEST_ASSERT_EQUAL(avail, BPF_TEST_POOLSIZE,
> +			  "Mempool available %u !=3D %u leaks?", avail, BPF_TEST_POOLSIZE);
> +
> +fail:
> +	if (tmpfile) {
> +		unlink(tmpfile);
> +		free(tmpfile);
> +	}
> +
> +	if (port !=3D UINT16_MAX)
> +		rte_vdev_uninit(null_dev);
> +
> +	rte_mempool_free(pool);
> +
> +	return ret =3D=3D 0 ? TEST_SUCCESS : TEST_FAILED;
> +}
>  #else
>=20
>  static int
> @@ -3430,9 +3721,25 @@ test_bpf_elf_load(void)
>  	return TEST_SKIPPED;
>  }
>=20
> +static int
> +test_bpf_elf_tx_load(void)
> +{
> +	printf("BPF compile not supported, skipping Tx test\n");
> +	return TEST_SKIPPED;
> +}
> +
> +static int
> +test_bpf_elf_rx_load(void)
> +{
> +	printf("BPF compile not supported, skipping Tx test\n");
> +	return TEST_SKIPPED;
> +}
> +
>  #endif /* !TEST_BPF_ELF_LOAD */
>=20
>  REGISTER_FAST_TEST(bpf_elf_load_autotest, true, true, test_bpf_elf_load)=
;
> +REGISTER_FAST_TEST(bpf_eth_tx_elf_load_autotest, true, true, test_bpf_el=
f_tx_load);
> +REGISTER_FAST_TEST(bpf_eth_rx_elf_load_autotest, true, true, test_bpf_el=
f_rx_load);
>=20
>  #ifndef RTE_HAS_LIBPCAP
>=20
> --
> 2.51.0

