Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027A9D4A61C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 09:33:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F8A2415D7;
	Fri, 16 Jan 2026 10:32:59 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3196D4060F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 10:32:58 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 57E232061A;
 Fri, 16 Jan 2026 10:32:56 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Date: Fri, 16 Jan 2026 10:32:52 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65669@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260116064646.224254-2-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Thread-Index: AdyGs+6FdjAi9xRrQVeyji/NArAOJQAFUmbA
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
 <20260116064646.224254-2-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Honnappa Nagarahalli" <honnappa.nagarahalli@arm.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Friday, 16 January 2026 07.46
>=20
> When building with LTO (Link Time Optimization), GCC performs
> aggressive cross-compilation-unit inlining. This causes the compiler
> to analyze all code paths in __rte_ring_do_dequeue_elems(), including
> the 16-byte element path (__rte_ring_dequeue_elems_128), even when
> the runtime element size is only 4 bytes.
>=20
> The static analyzer sees that the 16-byte path would copy
> 32 elements * 16 bytes =3D 512 bytes into a 128-byte buffer
> (uint32_t[32]),
> triggering -Wstringop-overflow warnings.
>=20
> The existing #pragma GCC diagnostic suppression in rte_ring_elem_pvt.h
> doesn't help because with LTO the warning context shifts to the test
> file where the inlined code is instantiated.
>=20
> Fix by sizing all buffers passed to soring acquire/dequeue functions
> for the worst-case element size (16 bytes =3D 4 * sizeof(uint32_t)).
> This satisfies the static analyzer without changing runtime behavior.

Using wildly oversized buffers doesn't seem like a recommendable =
solution.
If the ring library is ever updated to support cache size elements (64 =
byte), the buffers would have to be oversize by factor 16.

Maybe adding __rte_assume(sor->esize =3D=3D sizeof(uint32_t)); =
immediately before calling each of the affected soring functions would =
fix the problem instead?

It's only a test application, so oversized buffers as a workaround is =
acceptable.

But if it serves as guidance for real applications, a better =
solution/workaround would be preferable.

>=20
> Bugzilla ID: 1458
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_soring.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/app/test/test_soring.c b/app/test/test_soring.c
> index 3c1944424e..96be3935d4 100644
> --- a/app/test/test_soring.c
> +++ b/app/test/test_soring.c
> @@ -31,6 +31,19 @@
>=20
>  #define MAX_ACQUIRED 20
>=20
> +/*
> + * Buffer scaling factor for static analyzer appeasement.
> + *
> + * With LTO, GCC analyzes all code paths in
> __rte_ring_do_dequeue_elems(),
> + * including the 16-byte element path, even when runtime esize is
> smaller.
> + * Buffers passed to soring acquire/dequeue must be sized for the
> worst-case
> + * element size (16 bytes) to avoid -Wstringop-overflow warnings.
> + *
> + * Scale factor of 4 converts uint32_t count to 16-byte element
> capacity:
> + * N elements * 4 * sizeof(uint32_t) =3D N * 16 bytes
> + */
> +#define SORING_TEST_BUFSIZE(n) ((n) * 4)
> +
>  #define SORING_TEST_ASSERT(val, expected) do { \
>  	RTE_TEST_ASSERT(expected =3D=3D val, \
>  			"%s: expected %u got %u\n", #val, expected, val); \
> @@ -58,7 +71,8 @@ move_forward_stage(struct rte_soring *sor,
>  {
>  	uint32_t acquired;
>  	uint32_t ftoken;
> -	uint32_t *acquired_objs[MAX_ACQUIRED];
> +	/* Sized for 16-byte elements to satisfy LTO static analysis */
> +	uint32_t *acquired_objs[SORING_TEST_BUFSIZE(MAX_ACQUIRED)];
>=20
>  	acquired =3D rte_soring_acquire_bulk(sor, acquired_objs, stage,
>  			num_packets, &ftoken, NULL);
> @@ -149,12 +163,13 @@ test_soring_stages(void)
>  {
>  	struct rte_soring *sor =3D NULL;
>  	struct rte_soring_param prm;
> -	uint32_t objs[32];
> -	uint32_t rcs[32];
> -	uint32_t acquired_objs[32];
> -	uint32_t acquired_rcs[32];
> -	uint32_t dequeued_rcs[32];
> -	uint32_t dequeued_objs[32];
> +	/* Buffers sized for 16-byte elements to satisfy LTO static
> analysis */
> +	uint32_t objs[SORING_TEST_BUFSIZE(32)];
> +	uint32_t rcs[SORING_TEST_BUFSIZE(32)];
> +	uint32_t acquired_objs[SORING_TEST_BUFSIZE(32)];
> +	uint32_t acquired_rcs[SORING_TEST_BUFSIZE(32)];
> +	uint32_t dequeued_rcs[SORING_TEST_BUFSIZE(32)];
> +	uint32_t dequeued_objs[SORING_TEST_BUFSIZE(32)];
>  	size_t ssz;
>  	uint32_t stage, enqueued, dequeued, acquired;
>  	uint32_t i, ftoken;
> --
> 2.51.0

