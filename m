Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B45FCCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 17:33:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87DA140264;
	Fri,  7 Nov 2025 18:33:11 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 719C74021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 18:33:09 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d35k26W02zHnGkY;
 Sat,  8 Nov 2025 01:32:58 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id 904861402F3;
 Sat,  8 Nov 2025 01:33:08 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 18:33:08 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 7 Nov 2025 18:33:08 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v4 3/5] bpf: add a test for BPF ELF load
Thread-Topic: [PATCH v4 3/5] bpf: add a test for BPF ELF load
Thread-Index: AQHcTaV02m9YfHF+c0yX0F26edwMqbTnTMSQ
Date: Fri, 7 Nov 2025 17:33:08 +0000
Message-ID: <2951855794674cada3b9ab9574699917@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
 <20251104160843.304044-4-stephen@networkplumber.org>
In-Reply-To: <20251104160843.304044-4-stephen@networkplumber.org>
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

Thank you for doing this! See comments inline.

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday 4 November 2025 16:07
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>
> Subject: [PATCH v4 3/5] bpf: add a test for BPF ELF load
>=20
> Create an ELF file to load using clang.
> Repackage the object into an array using xdd.
> Write a test to see load and run the BPF.
>=20
> Draft version made with Claude AI, but it didn't work.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/bpf/load.c      |  62 +++++++++++++++++
>  app/test/bpf/meson.build |  52 ++++++++++++++
>  app/test/meson.build     |   2 +
>  app/test/test_bpf.c      | 147 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 263 insertions(+)
>  create mode 100644 app/test/bpf/load.c
>  create mode 100644 app/test/bpf/meson.build
>=20
> diff --git a/app/test/bpf/load.c b/app/test/bpf/load.c
> new file mode 100644
> index 0000000000..9678c110d9
> --- /dev/null
> +++ b/app/test/bpf/load.c
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * BPF program for testing rte_bpf_elf_load
> + */
> +
> +typedef unsigned char uint8_t;
> +typedef unsigned short uint16_t;
> +typedef unsigned int uint32_t;
> +typedef unsigned long uint64_t;
> +
> +/* Match the structures from test_bpf.c */
> +struct dummy_offset {
> +	uint64_t u64;
> +	uint32_t u32;
> +	uint16_t u16;
> +	uint8_t  u8;
> +} __attribute__((packed));
> +
> +struct dummy_vect8 {
> +	struct dummy_offset in[8];
> +	struct dummy_offset out[8];
> +};

Nit: I am sympathetic to re-using types already defined in test_bpf.c, but =
we
don't really need 8 elements, and first two members in dummy_offset are no
longer atomic which may or may not create problems someday. Perhaps it woul=
d be
easier and less confusing to just define another type for this test.

> +
> +/* External function declaration - provided by test via xsym */
> +extern void dummy_func1(const void *p, uint32_t *v32, uint64_t *v64);

Any reason not to make first argument `struct dummy_vect8`? Not that it
mattered for the test, just creates an impression that something is not wor=
king=20
or not trivial here.

> +
> +/*
> + * Test BPF function that will be loaded from ELF
> + * This function:
> + * 1. Reads values from input structure
> + * 2. Performs some computations
> + * 3. Writes results to output structure
> + * 4. Returns sum of values
> + */
> +__attribute__((section("func"), used))

Do we need `used` here and in other section attributes? I do not thing `cla=
ng
-c` will eliminate non-static/inline functions from the object file, or may=
be I
don't understand the purpose (perhaps needs a comment).

> +uint64_t
> +test_func(struct dummy_vect8 *arg)
> +{
> +	uint64_t sum =3D 0;
> +	uint32_t v32;
> +	uint64_t v64;
> +
> +	/* Load input values */
> +	v32 =3D arg->in[0].u32;
> +	v64 =3D arg->in[0].u64;
> +
> +	/* Call external function */
> +	dummy_func1(arg, &v32, &v64);
> +
> +	/* Store results */
> +	arg->out[0].u32 =3D v32;
> +	arg->out[0].u64 =3D v64;
> +
> +	/* Calculate sum */
> +	sum =3D arg->in[0].u64;
> +	sum +=3D arg->in[0].u32;
> +	sum +=3D arg->in[0].u16;
> +	sum +=3D arg->in[0].u8;
> +	sum +=3D v32;
> +	sum +=3D v64;
> +
> +	return sum;
> +}

// snip meson files, lgtm

> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -6,6 +6,7 @@
>  #include <string.h>
>  #include <stdint.h>
>  #include <inttypes.h>
> +#include <unistd.h>
>=20
>  #include <rte_memory.h>
>  #include <rte_debug.h>
> @@ -14,6 +15,8 @@
>  #include <rte_random.h>
>  #include <rte_byteorder.h>
>  #include <rte_errno.h>
> +#include <rte_bpf.h>
> +
>  #include "test.h"
>=20
>  #if !defined(RTE_LIB_BPF)
> @@ -3278,6 +3281,150 @@ test_bpf(void)
>=20
>  REGISTER_FAST_TEST(bpf_autotest, true, true, test_bpf);
>=20
> +#ifdef TEST_BPF_ELF_LOAD
> +
> +/*
> + * Helper function to write BPF object data to temporary file.
> + * Returns temp file path on success, NULL on failure.
> + * Caller must free the returned path and unlink the file.
> + */
> +static char *
> +create_temp_bpf_file(const uint8_t *data, size_t size, const char *suffi=
x)

Nit: last argument is not technically a suffix.

> +{
> +	char *tmpfile =3D NULL;
> +	int fd;
> +	ssize_t written;
> +
> +	if (asprintf(&tmpfile, "/tmp/dpdk_bpf_%s_XXXXXX", suffix) < 0) {

Not sure what the actual standard is, but I found in some previous discussi=
ons
a suggestion to use $TMPDIR and only fall back to /tmp if it is not defined=
.

Also, maybe give it .o suffix and use mkstemps below?=20

> +		printf("%s@%d: asprintf failed: %s\n",
> +		       __func__, __LINE__, strerror(errno));
> +		return NULL;
> +	}
> +
> +	/* Create and open temp file */
> +	fd =3D mkstemp(tmpfile);
> +	if (fd < 0) {
> +		printf("%s@%d: mkstemp(%s) failed: %s\n",
> +		       __func__, __LINE__, tmpfile, strerror(errno));
> +		free(tmpfile);
> +		return NULL;
> +	}
> +
> +	/* Write BPF object data */
> +	written =3D write(fd, data, size);
> +	close(fd);
> +
> +	if (written !=3D (ssize_t)size) {
> +		printf("%s@%d: write failed: %s\n",
> +		       __func__, __LINE__, strerror(errno));
> +		unlink(tmpfile);
> +		free(tmpfile);
> +		return NULL;
> +	}
> +
> +	return tmpfile;
> +}
> +
> +#include "test_bpf_load.h"
> +
> +static int
> +test_bpf_elf_load(void)
> +{
> +	uint8_t tbuf[sizeof(struct dummy_vect8)];

Why do we have to use unit8_t array here instead of just struct dummy_vect8=
?

If we do have to, how is alignment ensured?

> +	const struct rte_bpf_xsym xsym[] =3D {
> +		{
> +			.name =3D RTE_STR(dummy_func1),
> +			.type =3D RTE_BPF_XTYPE_FUNC,
> +			.func =3D {
> +				.val =3D (void *)dummy_func1,
> +				.nb_args =3D 3,
> +				.args =3D {
> +					[0] =3D {
> +						.type =3D RTE_BPF_ARG_PTR,
> +						.size =3D sizeof(struct dummy_offset),
> +					},
> +					[1] =3D {
> +						.type =3D RTE_BPF_ARG_PTR,
> +						.size =3D sizeof(uint32_t),
> +					},
> +					[2] =3D {
> +						.type =3D RTE_BPF_ARG_PTR,
> +						.size =3D sizeof(uint64_t),
> +					},
> +				},
> +			},
> +		},
> +	};
> +	int ret;
> +
> +	/* Create temp file from embedded BPF object */
> +	char *tmpfile =3D create_temp_bpf_file(app_test_bpf_load_o,
> +					     app_test_bpf_load_o_len,
> +					     "load");
> +	if (tmpfile =3D=3D NULL)
> +		return -1;
> +
> +	/* Try to load BPF program from temp file */
> +	const struct rte_bpf_prm prm =3D {
> +		.xsym =3D xsym,
> +		.nb_xsym =3D RTE_DIM(xsym),
> +		.prog_arg =3D {
> +			.type =3D RTE_BPF_ARG_PTR,
> +			.size =3D sizeof(tbuf),
> +		},
> +	};
> +	struct rte_bpf *bpf =3D rte_bpf_elf_load(&prm, tmpfile, "func");
> +	TEST_ASSERT(bpf !=3D NULL, "failed to load BPF from %s %d:%s",
> +		    tmpfile, rte_errno, strerror(rte_errno));
> +
> +	/* Prepare test data */
> +	struct dummy_vect8 *dv =3D (struct dummy_vect8 *)tbuf;
> +	memset(dv, 0, sizeof(*dv));
> +	dv->in[0].u64 =3D (int32_t)TEST_FILL_1;
> +	dv->in[0].u32 =3D dv->in[0].u64;
> +	dv->in[0].u16 =3D dv->in[0].u64;
> +	dv->in[0].u8 =3D dv->in[0].u64;
> +
> +	/* Execute loaded BPF program */
> +	uint64_t sum =3D rte_bpf_exec(bpf, tbuf);
> +	TEST_ASSERT(sum !=3D 0, "BPF execution returned: %" PRIu64, sum);

Could we be more specific with the value we expect?

> +
> +	/* Test JIT if available */
> +	struct rte_bpf_jit jit;
> +	ret =3D rte_bpf_get_jit(bpf, &jit);
> +	TEST_ASSERT(ret =3D=3D 0, "rte_bpf_get_jit failed: %d", ret);
> +
> +	if (jit.func !=3D NULL) {
> +		memset(dv, 0, sizeof(*dv));
> +		dv->in[0].u64 =3D (int32_t)TEST_FILL_1;
> +		dv->in[0].u32 =3D dv->in[0].u64;
> +		dv->in[0].u16 =3D dv->in[0].u64;
> +		dv->in[0].u8 =3D dv->in[0].u64;
> +
> +		uint64_t jsum  =3D jit.func(tbuf);
> +		TEST_ASSERT_EQUAL(sum, jsum, "BPF JIT execution difference");
> +	}
> +
> +	rte_bpf_destroy(bpf);
> +	unlink(tmpfile);
> +	free(tmpfile);

If any of the above asserts fail, leak sanitizer will also be unhappy. Perh=
aps
we could unlink tmpfile just after the rte_bpf_elf_load call, and unload BP=
F
before verifying return values from calls.

> +
> +	printf("%s: ELF load test passed\n", __func__);
> +	return TEST_SUCCESS;
> +}
> +#else
> +
> +static int
> +test_bpf_elf_load(void)
> +{
> +	printf("BPF compile not supported, skipping test\n");
> +	return TEST_SKIPPED;
> +}
> +
> +#endif /* !TEST_BPF_ELF_LOAD */
> +
> +REGISTER_FAST_TEST(bpf_elf_load_autotest, true, true, test_bpf_elf_load)=
;
> +
>  #ifndef RTE_HAS_LIBPCAP
>=20
>  static int
> --
> 2.51.0

