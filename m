Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DD4D2502E
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 00:13:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34E644028F;
	Mon, 12 Jan 2026 01:13:03 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 664944013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 01:13:02 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 86827206E5;
 Mon, 12 Jan 2026 01:13:01 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v13] net: optimize __rte_raw_cksum and add tests
Date: Mon, 12 Jan 2026 01:12:58 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6564E@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260111202709.9006-1-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v13] net: optimize __rte_raw_cksum and add tests
Thread-Index: AdyDOK2xAys7/P7YSc6o0To7+VMdcwAHwX5w
References: <20260111202709.9006-1-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>
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

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>=20
> __rte_raw_cksum uses a loop with memcpy on each iteration.
> GCC 15+ is able to vectorize the loop but Clang 18.1 is not.
>=20
> Replace memcpy with direct pointer access using a packed struct with
> __rte_may_alias attribute (same pattern as rte_memcpy.h). This enables
> both GCC and Clang to vectorize with SSE/AVX/AVX-512 while avoiding
> GCC strict-aliasing bugs without pragma workarounds.
>=20
> This patch adds comprehensive fuzz testing and updates the performance
> test to measure the optimization impact.
>=20
> Performance results from cksum_perf_autotest on Intel Xeon
> (Cascade Lake, AVX-512) built with Clang 18.1 (TSC cycles/byte):
>=20
>   Block size    Before    After    Improvement
>          100      0.40     0.24        ~40%
>         1500      0.50     0.06        ~8x
>         9000      0.49     0.06        ~8x
>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---
>  app/test/meson.build       |   1 +
>  app/test/test_cksum_fuzz.c | 240 =
+++++++++++++++++++++++++++++++++++++
>  app/test/test_cksum_perf.c |   2 +-
>  lib/net/rte_cksum.h        |  22 ++--
>  4 files changed, 255 insertions(+), 10 deletions(-)
>  create mode 100644 app/test/test_cksum_fuzz.c
>=20
> diff --git a/app/test/meson.build b/app/test/meson.build
> index efec42a6bf..c92325ad58 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -38,6 +38,7 @@ source_file_deps =3D {
>      'test_byteorder.c': [],
>      'test_cfgfile.c': ['cfgfile'],
>      'test_cksum.c': ['net'],
> +    'test_cksum_fuzz.c': ['net'],
>      'test_cksum_perf.c': ['net'],
>      'test_cmdline.c': [],
>      'test_cmdline_cirbuf.c': [],
> diff --git a/app/test/test_cksum_fuzz.c b/app/test/test_cksum_fuzz.c
> new file mode 100644
> index 0000000000..839861f57d
> --- /dev/null
> +++ b/app/test/test_cksum_fuzz.c
> @@ -0,0 +1,240 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Apple Inc.
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include <rte_common.h>
> +#include <rte_cycles.h>
> +#include <rte_hexdump.h>
> +#include <rte_cksum.h>
> +#include <rte_malloc.h>
> +#include <rte_random.h>
> +
> +#include "test.h"
> +
> +/*
> + * Fuzz test for __rte_raw_cksum optimization.
> + * Compares the optimized implementation against the original
> reference
> + * implementation across random data of various lengths.
> + */
> +
> +#define DEFAULT_ITERATIONS 1000
> +#define MAX_TEST_LEN 65536  /* 64K to match GRO frame sizes */
> +
> +/*
> + * Original (reference) implementation of __rte_raw_cksum from DPDK
> v23.11.
> + * This is retained here for comparison testing against the optimized
> version.
> + */
> +static inline uint32_t
> +__rte_raw_cksum_reference(const void *buf, size_t len, uint32_t sum)
> +{
> +	const void *end;
> +
> +	for (end =3D RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len,
> sizeof(uint16_t)));
> +	     buf !=3D end; buf =3D RTE_PTR_ADD(buf, sizeof(uint16_t))) {
> +		uint16_t v;
> +
> +		memcpy(&v, buf, sizeof(uint16_t));
> +		sum +=3D v;
> +	}
> +
> +	/* if length is odd, keeping it byte order independent */
> +	if (unlikely(len % 2)) {
> +		uint16_t left =3D 0;
> +
> +		memcpy(&left, end, 1);
> +		sum +=3D left;
> +	}
> +
> +	return sum;
> +}
> +
> +static void
> +init_random_buffer(uint8_t *buf, size_t len)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < len; i++)
> +		buf[i] =3D (uint8_t)rte_rand();
> +}
> +
> +static inline uint32_t
> +get_initial_sum(bool random_initial_sum)
> +{
> +	return random_initial_sum ? (rte_rand() & 0xFFFFFFFF) : 0;
> +}
> +
> +/*
> + * Test a single buffer length with specific alignment and initial =
sum
> + */
> +static int
> +test_cksum_fuzz_length_aligned(size_t len, bool aligned, uint32_t
> initial_sum)
> +{
> +	uint8_t *data;
> +	uint8_t *buf;
> +	size_t alloc_size;
> +	uint32_t sum_ref, sum_opt;
> +
> +	if (len =3D=3D 0 && !aligned) {
> +		/* Skip unaligned test for zero length - nothing to test */
> +		return TEST_SUCCESS;
> +	}
> +
> +	/* Allocate exact size for aligned, +1 for unaligned offset */
> +	alloc_size =3D aligned ? len : len + 1;
> +	if (alloc_size =3D=3D 0)
> +		alloc_size =3D 1;  /* rte_malloc doesn't like 0 */
> +
> +	data =3D rte_malloc(NULL, alloc_size, 64);
> +	if (data =3D=3D NULL) {
> +		printf("Failed to allocate %zu bytes\n", alloc_size);
> +		return TEST_FAILED;
> +	}
> +
> +	buf =3D aligned ? data : (data + 1);
> +
> +	init_random_buffer(buf, len);
> +
> +	sum_ref =3D __rte_raw_cksum_reference(buf, len, initial_sum);
> +	sum_opt =3D __rte_raw_cksum(buf, len, initial_sum);
> +
> +	if (sum_ref !=3D sum_opt) {
> +		printf("MISMATCH at len=3D%zu aligned=3D'%s' initial_sum=3D0x%08x
> ref=3D0x%08x opt=3D0x%08x\n",
> +		       len, aligned ? "aligned" : "unaligned",
> +		       initial_sum, sum_ref, sum_opt);
> +		rte_hexdump(stdout, "failing buffer", buf, len);
> +		rte_free(data);
> +		return TEST_FAILED;
> +	}
> +
> +	rte_free(data);
> +	return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test a length with both alignments
> + */
> +static int
> +test_cksum_fuzz_length(size_t len, uint32_t initial_sum)
> +{
> +	int rc;
> +
> +	/* Test aligned */
> +	rc =3D test_cksum_fuzz_length_aligned(len, true, initial_sum);
> +	if (rc !=3D TEST_SUCCESS)
> +		return rc;
> +
> +	/* Test unaligned */
> +	rc =3D test_cksum_fuzz_length_aligned(len, false, initial_sum);
> +
> +	return rc;
> +}
> +
> +/*
> + * Test specific edge case lengths
> + */
> +static int
> +test_cksum_fuzz_edge_cases(void)
> +{
> +	/* Edge case lengths that might trigger bugs */
> +	static const size_t edge_lengths[] =3D {
> +		0, 1, 2, 3, 4, 5, 6, 7, 8,
> +		15, 16, 17,
> +		31, 32, 33,
> +		63, 64, 65,
> +		127, 128, 129,
> +		255, 256, 257,
> +		511, 512, 513,
> +		1023, 1024, 1025,
> +		1500, 1501,  /* MTU boundaries */
> +		2047, 2048, 2049,
> +		4095, 4096, 4097,
> +		8191, 8192, 8193,
> +		16383, 16384, 16385,
> +		32767, 32768, 32769,
> +		65534, 65535, 65536  /* 64K GRO boundaries */
> +	};
> +	unsigned int i;
> +	int rc;
> +
> +	printf("Testing edge case lengths...\n");
> +
> +	for (i =3D 0; i < RTE_DIM(edge_lengths); i++) {
> +		/* Test with zero initial sum */
> +		rc =3D test_cksum_fuzz_length(edge_lengths[i], 0);
> +		if (rc !=3D TEST_SUCCESS)
> +			return rc;
> +
> +		/* Test with random initial sum */
> +		rc =3D test_cksum_fuzz_length(edge_lengths[i],
> get_initial_sum(true));
> +		if (rc !=3D TEST_SUCCESS)
> +			return rc;
> +	}
> +
> +	return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test random lengths with optional random initial sums
> + */
> +static int
> +test_cksum_fuzz_random(unsigned int iterations, bool
> random_initial_sum)
> +{
> +	unsigned int i;
> +	int rc;
> +
> +	printf("Testing random lengths (0-%d)%s...\n", MAX_TEST_LEN,
> +	       random_initial_sum ? " with random initial sums" : "");
> +
> +	for (i =3D 0; i < iterations; i++) {
> +		size_t len =3D rte_rand() % (MAX_TEST_LEN + 1);
> +
> +		rc =3D test_cksum_fuzz_length(len,
> get_initial_sum(random_initial_sum));
> +		if (rc !=3D TEST_SUCCESS) {
> +			printf("Failed at len=3D%zu\n", len);
> +			return rc;
> +		}
> +	}
> +
> +	return TEST_SUCCESS;
> +}
> +
> +static int
> +test_cksum_fuzz(void)
> +{
> +	int rc;
> +	unsigned int iterations =3D DEFAULT_ITERATIONS;
> +	printf("### __rte_raw_cksum optimization fuzz test ###\n");
> +	printf("Iterations per test: %u\n\n", iterations);
> +
> +	/* Test edge cases */
> +	rc =3D test_cksum_fuzz_edge_cases();
> +	if (rc !=3D TEST_SUCCESS) {
> +		printf("Edge case test FAILED\n");
> +		return rc;
> +	}
> +	printf("Edge case test PASSED\n\n");
> +
> +	/* Test random lengths with zero initial sum */
> +	rc =3D test_cksum_fuzz_random(iterations, false);
> +	if (rc !=3D TEST_SUCCESS) {
> +		printf("Random length test FAILED\n");
> +		return rc;
> +	}
> +	printf("Random length test PASSED\n\n");
> +
> +	/* Test random lengths with random initial sums */
> +	rc =3D test_cksum_fuzz_random(iterations, true);
> +	if (rc !=3D TEST_SUCCESS) {
> +		printf("Random initial sum test FAILED\n");
> +		return rc;
> +	}
> +	printf("Random initial sum test PASSED\n\n");
> +
> +	printf("All fuzz tests PASSED!\n");
> +	return TEST_SUCCESS;
> +}
> +
> +REGISTER_FAST_TEST(cksum_fuzz_autotest, true, true, test_cksum_fuzz);
> diff --git a/app/test/test_cksum_perf.c b/app/test/test_cksum_perf.c
> index 0b919cd59f..6b1d4589e0 100644
> --- a/app/test/test_cksum_perf.c
> +++ b/app/test/test_cksum_perf.c
> @@ -15,7 +15,7 @@
>  #define NUM_BLOCKS 10
>  #define ITERATIONS 1000000
>=20
> -static const size_t data_sizes[] =3D { 20, 21, 100, 101, 1500, 1501 =
};
> +static const size_t data_sizes[] =3D { 20, 21, 100, 101, 1500, 1501,
> 9000, 9001, 65536, 65537 };
>=20
>  static __rte_noinline uint16_t
>  do_rte_raw_cksum(const void *buf, size_t len)
> diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
> index a8e8927952..30eff6cbaa 100644
> --- a/lib/net/rte_cksum.h
> +++ b/lib/net/rte_cksum.h
> @@ -42,15 +42,19 @@ extern "C" {
>  static inline uint32_t
>  __rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
>  {
> -	const void *end;
> -
> -	for (end =3D RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len,
> sizeof(uint16_t)));
> -	     buf !=3D end; buf =3D RTE_PTR_ADD(buf, sizeof(uint16_t))) {
> -		uint16_t v;
> -
> -		memcpy(&v, buf, sizeof(uint16_t));
> -		sum +=3D v;
> -	}
> +	/**
> +	 * unaligned_uint16_t triggers GCC bug where buf memory may not
> be
> +	 * initialized. rte_uint16_alias avoids strict aliasing bugs.
> +	 */
> +	struct __rte_packed_begin rte_uint16_alias {
> +		uint16_t val;
> +	} __rte_packed_end __rte_may_alias;
> +
> +	/* Process uint16 chunks to preserve overflow/carry math.
> GCC/Clang vectorize the loop. */
> +	const uint16_t *buf16 =3D (const uint16_t *)buf;
> +	const uint16_t *end =3D buf16 + (len / sizeof(uint16_t));
> +	for (; buf16 !=3D end; buf16++)
> +		sum +=3D ((const struct rte_uint16_alias *)buf16)->val;
>=20
>  	/* if length is odd, keeping it byte order independent */
>  	if (unlikely(len % 2)) {
> --
> 2.39.5 (Apple Git-154)

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

