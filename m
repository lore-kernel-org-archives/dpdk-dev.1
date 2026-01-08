Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440F3D1D495
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 21:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78244402DE;
	Thu,  8 Jan 2026 22:37:22 +0100 (CET)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48]) by mails.dpdk.org (Postfix) with ESMTP id D516C4028C
 for <dev@dpdk.org>; Thu,  8 Jan 2026 22:37:20 +0100 (CET)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-93f69720a7cso2362967241.1
 for <dev@dpdk.org>; Thu, 08 Jan 2026 13:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767908240; x=1768513040; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4jeOnWqCrJe4rhFti29Q5VjSXDKoJSNWbsLhkRg91pQ=;
 b=a0vnsLTKa42HpHgTOD+R9NsVkaOfJ68qjnrqpDoCRPn3fngfcliBv3yCjKDfy0Qg5F
 ovXBAIQrB+AWvXJYP1LOmN/0RDtlciuIXZrekztv4mtGo6xWmKL1TsKaq2k/4C7TWd/b
 34SnMise2JPvtBzly6rh0DL3y4x6Q+wPWTSPuq7Iw1uMTLS6CrOKsBU003/he5e012P9
 ECfrvGci813G/iT7ZaqplxW5vSjTLSxglj4zAAB3NyTU/tkVhTuIticfgzJGLBjDuAMa
 RaME0oOj4nF2G38D3AraeLGiVft0Gt+sjPkXzDYz969kSFcaqhVjGkq7xEJirbm4MtXh
 WqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767908240; x=1768513040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4jeOnWqCrJe4rhFti29Q5VjSXDKoJSNWbsLhkRg91pQ=;
 b=wXSCLPv7NY6LtEyRL5RNyaWeZ7kpdLI/ewxxICPYQ/1GgM8MGZbUvxw4hAC14WdU5j
 IQCec9IIWQUrZOUdnMAWeBZ18qbwh1L/gjt69FkmNbHjLk7ghNZ2cDo0RHxFeMsPMONb
 UHxu1aAxqLKOrHzuLvpCAgMbFOlH1WDpmII2szNRThD6kfDqF7Z0KcrlY0NodJ/r0uUm
 Yq3eMCDf/TPM1zrKbx9CQkbNlIDjxncrhXGBVX2A4Zdy+rXmbXJVx2hPnq5iw6S5dVDN
 8jyIBGD6tgCPatqsZsH/YzcwLCTSTiJFEQLKlRI1XOaE3u9kdulCyHYtpSSMY+81VXkO
 fOYg==
X-Gm-Message-State: AOJu0Yws2ZRzGz1IpxvZeB6d7dTIhrG/2IXwll0wrKpjHfb9A9EIn14i
 4//XjMMFMKh1LFTw952LnarO5sxPlp0n1OGzAFf/nxoVUKGpczJRaHyqi44A0jAArPrS+cm44hG
 9RNgQZyIspnxakQkJBRiCz+EiW574DzJccA==
X-Gm-Gg: AY/fxX5ESQRG9Yhyw56Up03mzatbSRTNmRDrRHBcIoZXXwy6EBQSQd44b9MScRvLu+1
 d1YB5zQJ/W9eQ8N30LEeTkKzCB93RCbE4A4KHJq6X/EfFFy4OPo/cHk8T/b+xVnVcAjHBzRB4hu
 nNWFYVdA7FgVUTtTKwaYNd6TGVp2wrc812Xz09Nm03bNgN1c4dRcocufYDeWWNrnHNhW3pyXddW
 U8P1GuANIRsVMCvp1fKYiNBOQJK8Zlyv0VoasvpDS9/9xOY1IdkJ3VpF6E6rZy1hQoOQUEknYp6
 PY37vbjc+2jHyfh1X6OlnLrTeMY=
X-Google-Smtp-Source: AGHT+IFru/uftbV9cH7YmH0wc3W4sk0hW4aAMDfhYqfX54mjdIX7hRqN4Kz1TiJHzUwmUGVYHCQNbNHybuAUIiOOqlA=
X-Received: by 2002:a05:6102:3ecf:b0:5db:ca9e:b57d with SMTP id
 ada2fe7eead31-5ecb5ebc01amr3522824137.19.1767908239887; Thu, 08 Jan 2026
 13:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20260108212646.38872-1-scott.k.mitch1@gmail.com>
In-Reply-To: <20260108212646.38872-1-scott.k.mitch1@gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 8 Jan 2026 16:37:08 -0500
X-Gm-Features: AZwV_Qj9jrVZbLFwoPnPPhje_juyPdEWwVCOOs4zMIIHpWOHRT4Nxp8JOwcrb2U
Message-ID: <CAFn2buCQnubKVRaythDfLU3wOjW26Yb-Q2pgD3k-418DWRvWEA@mail.gmail.com>
Subject: Re: [PATCH v8] net: optimize raw checksum computation
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Patch file metadata format has extra delineator which makes diff in patches=
.dpdk
incorrect. I will resubmit v9. I apologize for the iterative approach.

On Thu, Jan 8, 2026 at 4:26=E2=80=AFPM <scott.k.mitch1@gmail.com> wrote:
>
> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>
> __rte_raw_cksum uses a loop with memcpy on each iteration.
> GCC 15+ is able to vectorize the loop but Clang 18.1 is not.
> Replacing the memcpy with unaligned_uint16_t pointer access enables
> both GCC and Clang to vectorize with SSE/AVX/AVX-512.
>
> Performance results from cksum_perf_autotest on Intel Xeon
> (Cascade Lake, AVX-512) built with Clang 18.1 (TSC cycles/byte):
>
>   Block size    Before    After    Improvement
>          100      0.40     0.24        ~40%
>         1500      0.50     0.06        ~8x
>         9000      0.49     0.06        ~8x
>
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---
> Changes in v8:
> - __rte_raw_cksum: use native pointer arithmetic instead of RTE_PTR_ADD
>   to avoid incorrect results with -O3 for UDP checksums. Also improves
>   performance due to less assembly generated with Clang.
> - Added __rte_no_ubsan_alignment attribute to suppress false UBSAN warnin=
gs
> - Added RTE_SUPPRESS_UNINITIALIZED_WARNING macro for GCC workaround
> - Fixed C++ compilation errors in rte_ip4.h and rte_ip6.h
> - Formatted complex ternary expressions for readability
>
> Changes in v7:
> - Replaced pointer arithmetic with RTE_PTR_ADD/RTE_ALIGN_FLOOR for DPDK c=
onsistency
>   (BROKEN - Clang alias analysis bug causes incorrect UDP checksums)
>
> Changes in v6:
> - Fixed GCC -Wmaybe-uninitialized false positive in mlx5 driver
>
> Changes in v5:
> - Replaced memcpy loop with direct pointer access to enable vectorization
> - Fixed GCC -Wmaybe-uninitialized false-positive warnings in rte_ipv4_phd=
r_cksum
>   and rte_ipv6_phdr_cksum using compiler barriers (no assembly impact)
> - Refactored hinic driver's local phdr_cksum implementations to call comm=
on
>   functions, eliminating duplication
> - Simplified phdr_cksum struct initialization with designated initializer=
s
>
> Changes in v4:
> - Replaced manual 64-byte loop unrolling with simple pointer iteration
> - Removed __rte_no_ubsan_alignment macro (no longer needed)
> - Removed rte_ip6.h false-positive warning fix (unable to repro locally)
> - Updated performance numbers: AVX-512 vectorization on Clang achieves ~8=
x
>   improvement for large packets vs scalar implementation
>
> Changes in v3:
> - Added __rte_no_ubsan_alignment macro to suppress false-positive UBSAN
>   alignment warnings when using unaligned_uint16_t
> - Fixed false-positive GCC maybe-uninitialized warning in rte_ip6.h expos=
ed
>   by optimization (can be split to separate patch once verified on CI)
>
> Changes in v2:
> - Fixed UndefinedBehaviorSanitizer errors by adding uint32_t casts to pre=
vent
>   signed integer overflow in addition chains
> - Restored uint32_t sum accumulator instead of uint64_t
> - Added 64k length to test_cksum_perf.c
>
> ---
>  app/test/meson.build             |   1 +
>  app/test/test_cksum_fuzz.c       | 240 +++++++++++++++++++++++++++++++
>  app/test/test_cksum_perf.c       |   2 +-
>  drivers/net/hinic/hinic_pmd_tx.c |  38 +----
>  drivers/net/mlx5/mlx5_flow_dv.c  |   2 +
>  lib/eal/include/rte_common.h     |  22 +++
>  lib/net/rte_cksum.h              |  18 +--
>  lib/net/rte_ip4.h                |  26 ++--
>  lib/net/rte_ip6.h                |  17 ++-
>  9 files changed, 294 insertions(+), 72 deletions(-)
>  create mode 100644 app/test/test_cksum_fuzz.c
>
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
> + * Compares the optimized implementation against the original reference
> + * implementation across random data of various lengths.
> + */
> +
> +#define DEFAULT_ITERATIONS 1000
> +#define MAX_TEST_LEN 65536  /* 64K to match GRO frame sizes */
> +
> +/*
> + * Original (reference) implementation of __rte_raw_cksum from DPDK v23.=
11.
> + * This is retained here for comparison testing against the optimized ve=
rsion.
> + */
> +static inline uint32_t
> +__rte_raw_cksum_reference(const void *buf, size_t len, uint32_t sum)
> +{
> +       const void *end;
> +
> +       for (end =3D RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, sizeof(uint16_=
t)));
> +            buf !=3D end; buf =3D RTE_PTR_ADD(buf, sizeof(uint16_t))) {
> +               uint16_t v;
> +
> +               memcpy(&v, buf, sizeof(uint16_t));
> +               sum +=3D v;
> +       }
> +
> +       /* if length is odd, keeping it byte order independent */
> +       if (unlikely(len % 2)) {
> +               uint16_t left =3D 0;
> +
> +               memcpy(&left, end, 1);
> +               sum +=3D left;
> +       }
> +
> +       return sum;
> +}
> +
> +static void
> +init_random_buffer(uint8_t *buf, size_t len)
> +{
> +       size_t i;
> +
> +       for (i =3D 0; i < len; i++)
> +               buf[i] =3D (uint8_t)rte_rand();
> +}
> +
> +static inline uint32_t
> +get_initial_sum(bool random_initial_sum)
> +{
> +       return random_initial_sum ? (rte_rand() & 0xFFFFFFFF) : 0;
> +}
> +
> +/*
> + * Test a single buffer length with specific alignment and initial sum
> + */
> +static int
> +test_cksum_fuzz_length_aligned(size_t len, bool aligned, uint32_t initia=
l_sum)
> +{
> +       uint8_t *data;
> +       uint8_t *buf;
> +       size_t alloc_size;
> +       uint32_t sum_ref, sum_opt;
> +
> +       if (len =3D=3D 0 && !aligned) {
> +               /* Skip unaligned test for zero length - nothing to test =
*/
> +               return TEST_SUCCESS;
> +       }
> +
> +       /* Allocate exact size for aligned, +1 for unaligned offset */
> +       alloc_size =3D aligned ? len : len + 1;
> +       if (alloc_size =3D=3D 0)
> +               alloc_size =3D 1;  /* rte_malloc doesn't like 0 */
> +
> +       data =3D rte_malloc(NULL, alloc_size, 64);
> +       if (data =3D=3D NULL) {
> +               printf("Failed to allocate %zu bytes\n", alloc_size);
> +               return TEST_FAILED;
> +       }
> +
> +       buf =3D aligned ? data : (data + 1);
> +
> +       init_random_buffer(buf, len);
> +
> +       sum_ref =3D __rte_raw_cksum_reference(buf, len, initial_sum);
> +       sum_opt =3D __rte_raw_cksum(buf, len, initial_sum);
> +
> +       if (sum_ref !=3D sum_opt) {
> +               printf("MISMATCH at len=3D%zu aligned=3D'%s' initial_sum=
=3D0x%08x ref=3D0x%08x opt=3D0x%08x\n",
> +                      len, aligned ? "aligned" : "unaligned",
> +                      initial_sum, sum_ref, sum_opt);
> +               rte_hexdump(stdout, "failing buffer", buf, len);
> +               rte_free(data);
> +               return TEST_FAILED;
> +       }
> +
> +       rte_free(data);
> +       return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test a length with both alignments
> + */
> +static int
> +test_cksum_fuzz_length(size_t len, uint32_t initial_sum)
> +{
> +       int rc;
> +
> +       /* Test aligned */
> +       rc =3D test_cksum_fuzz_length_aligned(len, true, initial_sum);
> +       if (rc !=3D TEST_SUCCESS)
> +               return rc;
> +
> +       /* Test unaligned */
> +       rc =3D test_cksum_fuzz_length_aligned(len, false, initial_sum);
> +
> +       return rc;
> +}
> +
> +/*
> + * Test specific edge case lengths
> + */
> +static int
> +test_cksum_fuzz_edge_cases(void)
> +{
> +       /* Edge case lengths that might trigger bugs */
> +       static const size_t edge_lengths[] =3D {
> +               0, 1, 2, 3, 4, 5, 6, 7, 8,
> +               15, 16, 17,
> +               31, 32, 33,
> +               63, 64, 65,
> +               127, 128, 129,
> +               255, 256, 257,
> +               511, 512, 513,
> +               1023, 1024, 1025,
> +               1500, 1501,  /* MTU boundaries */
> +               2047, 2048, 2049,
> +               4095, 4096, 4097,
> +               8191, 8192, 8193,
> +               16383, 16384, 16385,
> +               32767, 32768, 32769,
> +               65534, 65535, 65536  /* 64K GRO boundaries */
> +       };
> +       unsigned int i;
> +       int rc;
> +
> +       printf("Testing edge case lengths...\n");
> +
> +       for (i =3D 0; i < RTE_DIM(edge_lengths); i++) {
> +               /* Test with zero initial sum */
> +               rc =3D test_cksum_fuzz_length(edge_lengths[i], 0);
> +               if (rc !=3D TEST_SUCCESS)
> +                       return rc;
> +
> +               /* Test with random initial sum */
> +               rc =3D test_cksum_fuzz_length(edge_lengths[i], get_initia=
l_sum(true));
> +               if (rc !=3D TEST_SUCCESS)
> +                       return rc;
> +       }
> +
> +       return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test random lengths with optional random initial sums
> + */
> +static int
> +test_cksum_fuzz_random(unsigned int iterations, bool random_initial_sum)
> +{
> +       unsigned int i;
> +       int rc;
> +
> +       printf("Testing random lengths (0-%d)%s...\n", MAX_TEST_LEN,
> +              random_initial_sum ? " with random initial sums" : "");
> +
> +       for (i =3D 0; i < iterations; i++) {
> +               size_t len =3D rte_rand() % (MAX_TEST_LEN + 1);
> +
> +               rc =3D test_cksum_fuzz_length(len, get_initial_sum(random=
_initial_sum));
> +               if (rc !=3D TEST_SUCCESS) {
> +                       printf("Failed at len=3D%zu\n", len);
> +                       return rc;
> +               }
> +       }
> +
> +       return TEST_SUCCESS;
> +}
> +
> +static int
> +test_cksum_fuzz(void)
> +{
> +       int rc;
> +       unsigned int iterations =3D DEFAULT_ITERATIONS;
> +       printf("### __rte_raw_cksum optimization fuzz test ###\n");
> +       printf("Iterations per test: %u\n\n", iterations);
> +
> +       /* Test edge cases */
> +       rc =3D test_cksum_fuzz_edge_cases();
> +       if (rc !=3D TEST_SUCCESS) {
> +               printf("Edge case test FAILED\n");
> +               return rc;
> +       }
> +       printf("Edge case test PASSED\n\n");
> +
> +       /* Test random lengths with zero initial sum */
> +       rc =3D test_cksum_fuzz_random(iterations, false);
> +       if (rc !=3D TEST_SUCCESS) {
> +               printf("Random length test FAILED\n");
> +               return rc;
> +       }
> +       printf("Random length test PASSED\n\n");
> +
> +       /* Test random lengths with random initial sums */
> +       rc =3D test_cksum_fuzz_random(iterations, true);
> +       if (rc !=3D TEST_SUCCESS) {
> +               printf("Random initial sum test FAILED\n");
> +               return rc;
> +       }
> +       printf("Random initial sum test PASSED\n\n");
> +
> +       printf("All fuzz tests PASSED!\n");
> +       return TEST_SUCCESS;
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
>
> -static const size_t data_sizes[] =3D { 20, 21, 100, 101, 1500, 1501 };
> +static const size_t data_sizes[] =3D { 20, 21, 100, 101, 1500, 1501, 900=
0, 9001, 65536, 65537 };
>
>  static __rte_noinline uint16_t
>  do_rte_raw_cksum(const void *buf, size_t len)
> diff --git a/drivers/net/hinic/hinic_pmd_tx.c b/drivers/net/hinic/hinic_p=
md_tx.c
> index 22fb0bffaf..6b36ad84fd 100644
> --- a/drivers/net/hinic/hinic_pmd_tx.c
> +++ b/drivers/net/hinic/hinic_pmd_tx.c
> @@ -706,47 +706,13 @@ hinic_get_sq_wqe(struct hinic_txq *txq, int wqebb_c=
nt,
>  static inline uint16_t
>  hinic_ipv4_phdr_cksum(const struct rte_ipv4_hdr *ipv4_hdr, uint64_t ol_f=
lags)
>  {
> -       struct ipv4_psd_header {
> -               uint32_t src_addr; /* IP address of source host. */
> -               uint32_t dst_addr; /* IP address of destination host. */
> -               uint8_t  zero;     /* zero. */
> -               uint8_t  proto;    /* L4 protocol type. */
> -               uint16_t len;      /* L4 length. */
> -       } psd_hdr;
> -
> -       psd_hdr.src_addr =3D ipv4_hdr->src_addr;
> -       psd_hdr.dst_addr =3D ipv4_hdr->dst_addr;
> -       psd_hdr.zero =3D 0;
> -       psd_hdr.proto =3D ipv4_hdr->next_proto_id;
> -       if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
> -               psd_hdr.len =3D 0;
> -       } else {
> -               psd_hdr.len =3D
> -               rte_cpu_to_be_16(rte_be_to_cpu_16(ipv4_hdr->total_length)=
 -
> -                                rte_ipv4_hdr_len(ipv4_hdr));
> -       }
> -       return rte_raw_cksum(&psd_hdr, sizeof(psd_hdr));
> +       return rte_ipv4_phdr_cksum(ipv4_hdr, ol_flags & RTE_MBUF_F_TX_TCP=
_SEG);
>  }
>
>  static inline uint16_t
>  hinic_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_f=
lags)
>  {
> -       uint32_t sum;
> -       struct {
> -               uint32_t len;   /* L4 length. */
> -               uint32_t proto; /* L4 protocol - top 3 bytes must be zero=
 */
> -       } psd_hdr;
> -
> -       psd_hdr.proto =3D (ipv6_hdr->proto << 24);
> -       if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
> -               psd_hdr.len =3D 0;
> -       else
> -               psd_hdr.len =3D ipv6_hdr->payload_len;
> -
> -       sum =3D __rte_raw_cksum(&ipv6_hdr->src_addr,
> -               sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr), =
0);
> -       sum =3D __rte_raw_cksum(&psd_hdr, sizeof(psd_hdr), sum);
> -       return __rte_raw_cksum_reduce(sum);
> +       return rte_ipv6_phdr_cksum(ipv6_hdr, ol_flags & RTE_MBUF_F_TX_TCP=
_SEG);
>  }
>
>  static inline void hinic_get_outer_cs_pld_offset(struct rte_mbuf *m,
> diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow=
_dv.c
> index 47f6d28410..4f77a1e4f1 100644
> --- a/drivers/net/mlx5/mlx5_flow_dv.c
> +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> @@ -4445,6 +4445,8 @@ __flow_encap_decap_resource_register(struct rte_eth=
_dev *dev,
>                         .reserve =3D 0,
>                 }
>         };
> +       RTE_SUPPRESS_UNINITIALIZED_WARNING(encap_decap_key);
> +
>         struct mlx5_flow_cb_ctx ctx =3D {
>                 .error =3D error,
>                 .data =3D resource,
> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> index 9e7d84f929..044275c2bd 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -546,6 +546,28 @@ static void __attribute__((destructor(RTE_PRIO(prio)=
), used)) func(void)
>  #define __rte_no_asan
>  #endif
>
> +/**
> + * Disable UndefinedBehaviorSanitizer alignment check on some code
> + */
> +#if defined(RTE_CC_CLANG) || defined(RTE_CC_GCC)
> +#define __rte_no_ubsan_alignment __attribute__((no_sanitize("alignment")=
))
> +#else
> +#define __rte_no_ubsan_alignment
> +#endif
> +
> +/**
> + * Suppress GCC -Wmaybe-uninitialized false positive on struct initializ=
ation.
> + * This tells the compiler that the variable's memory has been touched,
> + * preventing the false positive without affecting other optimizations.
> + */
> +#ifdef RTE_CC_GCC
> +#define RTE_SUPPRESS_UNINITIALIZED_WARNING(var) do {   \
> +       asm volatile("" : "+m" (var));                  \
> +} while (0)
> +#else
> +#define RTE_SUPPRESS_UNINITIALIZED_WARNING(var)
> +#endif
> +
>  /*********** Macros for pointer arithmetic ********/
>
>  /**
> diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
> index a8e8927952..364f519455 100644
> --- a/lib/net/rte_cksum.h
> +++ b/lib/net/rte_cksum.h
> @@ -39,23 +39,19 @@ extern "C" {
>   * @return
>   *   sum +=3D Sum of all words in the buffer.
>   */
> +__rte_no_ubsan_alignment
>  static inline uint32_t
>  __rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
>  {
> -       const void *end;
> -
> -       for (end =3D RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, sizeof(uint16_=
t)));
> -            buf !=3D end; buf =3D RTE_PTR_ADD(buf, sizeof(uint16_t))) {
> -               uint16_t v;
> -
> -               memcpy(&v, buf, sizeof(uint16_t));
> -               sum +=3D v;
> -       }
> +       /* Process uint16 chunks to preserve overflow/carry math. GCC/Cla=
ng vectorize the loop. */
> +       const unaligned_uint16_t *buf16 =3D (const unaligned_uint16_t *)b=
uf;
> +       const unaligned_uint16_t *end =3D buf16 + (len / sizeof(uint16_t)=
);
> +       for (; buf16 !=3D end; buf16++)
> +               sum +=3D *buf16;
>
>         /* if length is odd, keeping it byte order independent */
> -       if (unlikely(len % 2)) {
> +       if (len & 1) {
>                 uint16_t left =3D 0;
> -
>                 memcpy(&left, end, 1);
>                 sum +=3D left;
>         }
> diff --git a/lib/net/rte_ip4.h b/lib/net/rte_ip4.h
> index 822a660cfb..63852717c9 100644
> --- a/lib/net/rte_ip4.h
> +++ b/lib/net/rte_ip4.h
> @@ -223,21 +223,17 @@ rte_ipv4_phdr_cksum(const struct rte_ipv4_hdr *ipv4=
_hdr, uint64_t ol_flags)
>                 uint8_t  zero;     /* zero. */
>                 uint8_t  proto;    /* L4 protocol type. */
>                 uint16_t len;      /* L4 length. */
> -       } psd_hdr;
> -
> -       uint32_t l3_len;
> -
> -       psd_hdr.src_addr =3D ipv4_hdr->src_addr;
> -       psd_hdr.dst_addr =3D ipv4_hdr->dst_addr;
> -       psd_hdr.zero =3D 0;
> -       psd_hdr.proto =3D ipv4_hdr->next_proto_id;
> -       if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
> -               psd_hdr.len =3D 0;
> -       } else {
> -               l3_len =3D rte_be_to_cpu_16(ipv4_hdr->total_length);
> -               psd_hdr.len =3D rte_cpu_to_be_16((uint16_t)(l3_len -
> -                       rte_ipv4_hdr_len(ipv4_hdr)));
> -       }
> +       } psd_hdr =3D {
> +               .src_addr =3D ipv4_hdr->src_addr,
> +               .dst_addr =3D ipv4_hdr->dst_addr,
> +               .proto =3D ipv4_hdr->next_proto_id,
> +               .len =3D (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_=
TX_UDP_SEG))
> +                       ? (uint16_t)0
> +                       : rte_cpu_to_be_16((uint16_t)(rte_be_to_cpu_16(ip=
v4_hdr->total_length) -
> +                                       rte_ipv4_hdr_len(ipv4_hdr)))
> +       };
> +       RTE_SUPPRESS_UNINITIALIZED_WARNING(psd_hdr);
> +
>         return rte_raw_cksum(&psd_hdr, sizeof(psd_hdr));
>  }
>
> diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
> index d1abf1f5d5..8a7e5e4b8a 100644
> --- a/lib/net/rte_ip6.h
> +++ b/lib/net/rte_ip6.h
> @@  -560,19 +560,18 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv=
6_hdr, uint64_t ol_flags)
>  static inline uint16_t
>  rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t ol_fla=
gs)
>  {
> -       uint32_t sum;
>         struct {
>                 rte_be32_t len;   /* L4 length. */
>                 rte_be32_t proto; /* L4 protocol - top 3 bytes must be ze=
ro */
> -       } psd_hdr;
> -
> -       psd_hdr.proto =3D (uint32_t)(ipv6_hdr->proto << 24);
> -       if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> -               psd_hdr.len =3D 0;
> -       else
> -               psd_hdr.len =3D ipv6_hdr->payload_len;
> +       } psd_hdr =3D {
> +               .len =3D (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_=
TX_UDP_SEG))
> +                       ? (rte_be32_t)0
> +                       : ipv6_hdr->payload_len,
> +               .proto =3D (uint32_t)(ipv6_hdr->proto << 24)
> +       };
> +       RTE_SUPPRESS_UNINITIALIZED_WARNING(psd_hdr);
>
> -       sum =3D __rte_raw_cksum(&ipv6_hdr->src_addr,
> +       uint32_t sum =3D __rte_raw_cksum(&ipv6_hdr->src_addr,
>                 sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr),
>                 0);
>         sum =3D __rte_raw_cksum(&psd_hdr, sizeof(psd_hdr), sum);
> --
> 2.39.5 (Apple Git-154)
>
