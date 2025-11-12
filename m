Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC16CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 15:06:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE8DC402B0;
	Wed, 12 Nov 2025 16:06:33 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 627A3402AF
 for <dev@dpdk.org>; Wed, 12 Nov 2025 16:06:32 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d66D71r8xzJ46g5;
 Wed, 12 Nov 2025 23:05:59 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id DF9D71400D9;
 Wed, 12 Nov 2025 23:06:31 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 12 Nov 2025 15:06:31 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 12 Nov 2025 15:06:31 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Marat Khalili <marat.khalili@huawei.com>
Subject: RE: [PATCH v6 1/2] bpf: add a test for BPF ELF load
Thread-Topic: [PATCH v6 1/2] bpf: add a test for BPF ELF load
Thread-Index: AQHcU16VqbanTCPn3kuHUNS0E2anzLTvJP6Q
Date: Wed, 12 Nov 2025 15:06:31 +0000
Message-ID: <55beaa9ba60c421a9dce6989432439e6@huawei.com>
References: <20251109200854.45942-1-stephen@networkplumber.org>
 <20251111225719.540140-1-stephen@networkplumber.org>
 <20251111225719.540140-2-stephen@networkplumber.org>
In-Reply-To: <20251111225719.540140-2-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.199.148]
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



> Create an ELF file to load using clang.
> Repackage the object into an array using xdd.
> Write a test to see load and run the BPF.
>=20
> If libelf library is not available, then DPDK bpf
> will return -ENOTSUP to the test and the test will be skipped.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  app/test/bpf/load.c      |  51 +++++++++++++
>  app/test/bpf/meson.build |  52 +++++++++++++
>  app/test/meson.build     |   2 +
>  app/test/test_bpf.c      | 159 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 264 insertions(+)
>  create mode 100644 app/test/bpf/load.c
>  create mode 100644 app/test/bpf/meson.build
>=20
> diff --git a/app/test/bpf/load.c b/app/test/bpf/load.c
> new file mode 100644
> index 0000000000..a4d3d61d7a
> --- /dev/null
> +++ b/app/test/bpf/load.c
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + *
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
> +
> +/* External function declaration - provided by test via xsym */
> +extern void dummy_func1(const void *p, uint32_t *v32, uint64_t *v64);
> +
> +/*
> + * Test BPF function that will be loaded from ELF
> + * This function is compiled version of code used in test_call1
> + */
> +__attribute__((section("call1"), used))
> +uint64_t
> +test_call1(struct dummy_vect8 *arg)
> +{
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
> +	v64 +=3D v32;
> +	return v64;
> +}
> diff --git a/app/test/bpf/meson.build b/app/test/bpf/meson.build
> new file mode 100644
> index 0000000000..b4f54aa976
> --- /dev/null
> +++ b/app/test/bpf/meson.build
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright 2025 Stephen Hemminger <stephen@networkplumber.org>
> +
> +bpf_test_hdrs =3D [ ]
> +
> +# use clang to compile to bpf
> +clang_supports_bpf =3D false
> +clang =3D find_program('clang', required: false)
> +if clang.found()
> +    clang_supports_bpf =3D run_command(clang, '-target', 'bpf', '--print=
-supported-
> cpus',
> +                                     check: false).returncode() =3D=3D 0
> +endif
> +
> +if not clang_supports_bpf
> +    message('app/test_bpf: no BPF load tests missing clang BPF support')
> +    subdir_done()
> +
> +endif
> +
> +xxd =3D find_program('xxd', required: false)
> +if not xxd.found()
> +    message('app/test_bpf: missing xxd required to convert object to arr=
ay')
> +    subdir_done()
> +endif
> +
> +# BPF compiler flags
> +bpf_cflags =3D [ '-O2', '-target', 'bpf', '-g', '-c']
> +
> +# Enable test in test_bpf.c
> +cflags +=3D '-DTEST_BPF_ELF_LOAD'
> +
> +# BPF sources to compile
> +bpf_progs =3D {
> +    'load' : 'test_bpf_load',
> +}
> +
> +foreach bpf_src, bpf_hdr : bpf_progs
> +    # Compile BPF C source to object file
> +    bpf_obj =3D custom_target(bpf_src + '_o',
> +        input: bpf_src + '.c',
> +        output: bpf_src + '.o',
> +        command: [ clang, bpf_cflags, '@INPUT@', '-o', '@OUTPUT@'])
> +
> +    # Convert object file to C header using xxd
> +    bpf_test_h =3D custom_target(bpf_src + '_h',
> +        input: bpf_obj,
> +        output: bpf_hdr + '.h',
> +        command: [ xxd, '-i', '@INPUT@', '@OUTPUT@'])
> +
> +    resources +=3D bpf_test_h
> +
> +endforeach
> diff --git a/app/test/meson.build b/app/test/meson.build
> index 8df8d3edd1..efec42a6bf 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -281,6 +281,8 @@ if not is_windows
>              install: false)
>  endif
>=20
> +subdir('bpf')
> +
>  subdir('test_cfgfiles')
>=20
>  resources +=3D test_cfgfile_h
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 90e10d7d2c..c460002358 100644
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
> @@ -14,6 +15,7 @@
>  #include <rte_random.h>
>  #include <rte_byteorder.h>
>  #include <rte_errno.h>
> +
>  #include "test.h"
>=20
>  #if !defined(RTE_LIB_BPF)
> @@ -3278,6 +3280,163 @@ test_bpf(void)
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
> +create_temp_bpf_file(const uint8_t *data, size_t size, const char *name)
> +{
> +	char *tmpfile =3D NULL;
> +	int fd;
> +	ssize_t written;
> +
> +	if (asprintf(&tmpfile, "/tmp/dpdk_bpf_%s_XXXXXX.o", name) < 0) {
> +		printf("%s@%d: asprintf failed: %s\n",
> +		       __func__, __LINE__, strerror(errno));
> +		return NULL;
> +	}
> +
> +	/* Create and open temp file */
> +	fd =3D mkstemps(tmpfile, strlen(".o"));
> +	if (fd < 0) {
> +		printf("%s@%d: mkstemps(%s) failed: %s\n",
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
> +/*
> + * Test loading BPF program from an object file.
> + * This test uses same arguments as previous test_call1 example.
> + */
> +static int
> +test_bpf_elf_load(void)
> +{
> +	static const char test_section[] =3D "call1";
> +	uint8_t tbuf[sizeof(struct dummy_vect8)];
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
> +						.size =3D sizeof(struct
> dummy_offset),
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
> +
> +	struct rte_bpf *bpf =3D rte_bpf_elf_load(&prm, tmpfile, test_section);
> +	unlink(tmpfile);
> +	free(tmpfile);
> +
> +	/* If libelf support is not available */
> +	if (bpf =3D=3D NULL && rte_errno =3D=3D ENOTSUP)
> +		return TEST_SKIPPED;
> +
> +	TEST_ASSERT(bpf !=3D NULL, "failed to load BPF %d:%s", rte_errno,
> strerror(rte_errno));
> +
> +	/* Prepare test data */
> +	struct dummy_vect8 *dv =3D (struct dummy_vect8 *)tbuf;
> +
> +	memset(dv, 0, sizeof(*dv));
> +	dv->in[0].u64 =3D (int32_t)TEST_FILL_1;
> +	dv->in[0].u32 =3D dv->in[0].u64;
> +	dv->in[0].u16 =3D dv->in[0].u64;
> +	dv->in[0].u8 =3D dv->in[0].u64;
> +
> +	/* Execute loaded BPF program */
> +	uint64_t rc =3D rte_bpf_exec(bpf, tbuf);
> +	ret =3D test_call1_check(rc, tbuf);
> +	TEST_ASSERT(ret =3D=3D 0, "test_call1_check failed: %d", ret);
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
> +		rc =3D jit.func(tbuf);
> +		ret =3D test_call1_check(rc, tbuf);
> +		TEST_ASSERT(ret =3D=3D 0, "jit test_call1_check failed: %d", ret);
> +	}
> +
> +	rte_bpf_destroy(bpf);
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

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20

> 2.51.0

