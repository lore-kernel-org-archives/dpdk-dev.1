Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB8CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 17:30:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ED6440264;
	Fri,  7 Nov 2025 18:30:54 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id DCCE54021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 18:30:52 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d35gQ1NfjzHnH4l;
 Sat,  8 Nov 2025 01:30:42 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id D30BC14038F;
 Sat,  8 Nov 2025 01:30:51 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 18:30:51 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 7 Nov 2025 18:30:51 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v4 4/5] bpf: add test for Rx and Tx filtering
Thread-Topic: [PATCH v4 4/5] bpf: add test for Rx and Tx filtering
Thread-Index: AQHcTaYr8infJ5PzIEaHh6dbuKWKhLTnThww
Date: Fri, 7 Nov 2025 17:30:51 +0000
Message-ID: <9994a210520c4760bddc67df29999068@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
 <20251104160843.304044-5-stephen@networkplumber.org>
In-Reply-To: <20251104160843.304044-5-stephen@networkplumber.org>
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

Thank you for doing this! See comments below.

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday 4 November 2025 16:07
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>
> Subject: [PATCH v4 4/5] bpf: add test for Rx and Tx filtering
>=20
> New test using null device to test filtering with BPF.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/bpf/filter.c    |  53 +++++++
>  app/test/bpf/meson.build |   1 +
>  app/test/test_bpf.c      | 304 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 358 insertions(+)
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

Could this section (and function) be called better, e.g. filter_ip_tcp?

> +uint64_t
> +test_filter(void *pkt)
> +{
> +	uint8_t *data =3D pkt;

Does pkt point to packet data or an mbuf? I would think we need mbuf functi=
ons
here to access data. Not sure why the test is not failing though, maybe I
misunderstand it.

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
> index ec84b85f1c..54b6330678 100644
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
> @@ -3412,6 +3418,288 @@ test_bpf_elf_load(void)
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

Nit: The function type should be on a line by itself preceding the function=
 (also in other places).

// snip packets setup functions

> +static int bpf_tx_test(uint16_t port, const char *tmpfile, struct rte_me=
mpool *pool,
> +		       const char *fname, uint32_t flags)

Nit: not sure `fname` is a good name for ELF section.

> +{
> +	const struct rte_bpf_prm prm =3D {
> +		.prog_arg =3D {
> +			.type =3D RTE_BPF_ARG_PTR,

Should this be RTE_BPF_ARG_PTR_MBUF and include buf_size?

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
> +	ret =3D rte_bpf_eth_tx_elf_load(port, 0, &prm, tmpfile, fname, flags);
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

// snip test_bpf_elf_tx_load

> +static int bpf_rx_test(uint16_t port, const char *tmpfile, struct rte_me=
mpool *pool,
> +		       const char *fname, uint32_t flags, uint16_t expected)

Is rx test significantly different from tx one? Maybe add a comment what ea=
ch test does?

// snip the rest, lgtm
