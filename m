Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6912FD3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 14:16:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26C7740297;
	Sun, 28 Dec 2025 15:16:46 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 6887740267;
 Sun, 28 Dec 2025 15:16:42 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dfLx52db4zJ46BK;
 Sun, 28 Dec 2025 22:15:53 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (unknown [7.214.147.1])
 by mail.maildlp.com (Postfix) with ESMTPS id B928140539;
 Sun, 28 Dec 2025 22:16:40 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500004.china.huawei.com (7.214.147.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 28 Dec 2025 14:16:40 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Sun, 28 Dec 2025 14:16:40 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Ferruh Yigit <ferruh.yigit@amd.com>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] bpf: fix x86 call stack alignment, add tests
Thread-Topic: [PATCH] bpf: fix x86 call stack alignment, add tests
Thread-Index: AQHccRUO8Gs82ixPwEuPs7xezzYfmrU3JedA
Date: Sun, 28 Dec 2025 14:16:39 +0000
Message-ID: <e77be2e63adb4e76af4d2dc66cc4d64c@huawei.com>
References: <20251219182624.19557-1-marat.khalili@huawei.com>
In-Reply-To: <20251219182624.19557-1-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.12]
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


> Correctly align stack pointer on x86 JIT if external calls are present.
>=20
> Add tests for external calls from BPF program demonstrating the problem:
> * direct verification of a local variable alignment;
> * operations with 128-bit integers;
> * aligned and unaligned SSE2 instructions;
> * memcpy and rte_memcpy (may use vector instructions in their code).
>=20
> (Such variety is needed because not all of these tests are available or
> reproduce the problem on all targets even when the problem exists.)

Probably worth to mention in the commit header, that by default
x86_64 ABI expects sp to be 16B aligned on function entry.

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

>=20
> Fixes: cc752e43e079 ("bpf: add JIT compilation for x86_64 ISA")
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  app/test/test_bpf.c   | 386 ++++++++++++++++++++++++++++++++++++++++++
>  lib/bpf/bpf_jit_x86.c |  15 +-
>  2 files changed, 400 insertions(+), 1 deletion(-)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index b7c94ba1c7..e3f6b21a8b 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -3280,6 +3280,392 @@ test_bpf(void)
>=20
>  REGISTER_FAST_TEST(bpf_autotest, true, true, test_bpf);
>=20
> +/* Tests of BPF JIT stack alignment when calling external functions (xfu=
ncs). */
> +
> +/* Function called from the BPF program in a test. */
> +typedef uint64_t (*text_xfunc_t)(uint64_t argument);
> +
> +/* Call function from BPF program, verify that it incremented its argume=
nt. */
> +static int
> +call_from_bpf_test(text_xfunc_t xfunc)
> +{
> +	static const struct ebpf_insn ins[] =3D {
> +		{
> +			.code =3D (BPF_JMP | EBPF_CALL),
> +			.imm =3D 0,  /* xsym #0 */
> +		},
> +		{
> +			.code =3D (BPF_JMP | EBPF_EXIT),
> +		},
> +	};
> +	const struct rte_bpf_xsym xsym[] =3D {
> +		{
> +			.name =3D "xfunc",
> +			.type =3D RTE_BPF_XTYPE_FUNC,
> +			.func =3D {
> +				.val =3D (void *)xfunc,
> +				.nb_args =3D 1,
> +				.args =3D {
> +					{
> +						.type =3D RTE_BPF_ARG_RAW,
> +						.size =3D sizeof(uint64_t),
> +					},
> +				},
> +				.ret =3D {
> +					.type =3D RTE_BPF_ARG_RAW,
> +					.size =3D sizeof(uint64_t),
> +				},
> +			},
> +		},
> +	};
> +	const struct rte_bpf_prm prm =3D {
> +		.ins =3D ins,
> +		.nb_ins =3D RTE_DIM(ins),
> +		.xsym =3D xsym,
> +		.nb_xsym =3D RTE_DIM(xsym),
> +		.prog_arg =3D {
> +			.type =3D RTE_BPF_ARG_RAW,
> +			.size =3D sizeof(uint64_t),
> +		},
> +	};
> +
> +	struct rte_bpf_jit jit;
> +
> +	struct rte_bpf *const bpf =3D rte_bpf_load(&prm);
> +	RTE_TEST_ASSERT_NOT_EQUAL(bpf, NULL,
> +		"expect rte_bpf_load() !=3D NULL");
> +
> +	RTE_TEST_ASSERT_SUCCESS(rte_bpf_get_jit(bpf, &jit),
> +		"expect rte_bpf_get_jit() to succeed");
> +
> +	const text_xfunc_t jit_function =3D (void *)jit.func;
> +	if (jit_function =3D=3D NULL) {
> +		rte_bpf_destroy(bpf);
> +		return TEST_SKIPPED;
> +	}
> +
> +	const uint64_t argument =3D 42;
> +	const uint64_t result =3D jit_function(argument);
> +	rte_bpf_destroy(bpf);
> +
> +	RTE_TEST_ASSERT_EQUAL(result, argument + 1,
> +		"expect result =3D=3D %ju, found %ju",
> +		(uintmax_t)(argument + 1), (uintmax_t)result);
> +
> +	return TEST_SUCCESS;
> +}
> +
> +/*
> + * Test alignment of a local variable.
> + *
> + * NOTE: May produce false negatives with sanitizers if they replace the=
 stack.
> + */
> +
> +/* Copy of the pointer to max_align stack variable, volatile to thwart o=
ptimization.
> */
> +static volatile uintptr_t stack_alignment_test_pointer;
> +
> +static uint64_t
> +stack_alignment_xfunc(uint64_t argument)
> +{
> +	max_align_t max_align;
> +	stack_alignment_test_pointer =3D (uintptr_t)&max_align;
> +	return argument + 1;
> +}
> +
> +static int
> +test_stack_alignment(void)
> +{
> +	const int test_rc =3D call_from_bpf_test(stack_alignment_xfunc);
> +	if (test_rc =3D=3D TEST_SKIPPED)
> +		return TEST_SKIPPED;
> +
> +	RTE_TEST_ASSERT_SUCCESS(test_rc,
> +		"expect call_from_bpf_test(stack_alignment_xfunc) to succeed");
> +
> +	const uintptr_t test_offset =3D stack_alignment_test_pointer;
> +	RTE_TEST_ASSERT_NOT_EQUAL(test_offset, 0, "expect test_pointer !=3D 0")=
;
> +
> +	const size_t test_alignment =3D test_offset % alignof(max_align_t);
> +	RTE_TEST_ASSERT_EQUAL(test_alignment, 0,
> +		"expect test_alignment =3D=3D 0, found %zu", test_alignment);
> +
> +	return TEST_SUCCESS;
> +}
> +
> +REGISTER_FAST_TEST(bpf_stack_alignment_autotest, true, true,
> test_stack_alignment);
> +
> +/*
> + * Test copying `__uint128_t`.
> + *
> + * This operation is used by some variations of `rte_memcpy`;
> + * it can also be produced by vectorizer in the compiler.
> + */
> +
> +#if defined(__SIZEOF_INT128__)
> +
> +static uint64_t
> +stack_copy_uint128_xfunc(uint64_t argument)
> +{
> +	/* Pass addresses through volatiles to prevent compiler from optimizing=
 it all
> out. */
> +	char alignas(16) src_buffer[16];
> +	char alignas(16) dst_buffer[16];
> +	void *const src =3D (char *volatile)src_buffer;
> +	void *const dst =3D (char *volatile)dst_buffer;
> +	const size_t size =3D 16;
> +
> +	memset(src, 0x2a, size);
> +	memset(dst, 0x55, size);
> +	const int initial_memcmp_rc =3D memcmp(dst, src, size);
> +
> +	const __uint128_t *const src128 =3D (const __uint128_t *)src;
> +	__uint128_t *const dst128 =3D (__uint128_t *)dst;
> +	*dst128 =3D *src128;
> +	const int memcmp_rc =3D memcmp(dst, src, size);
> +
> +	return argument + 1 + !initial_memcmp_rc + memcmp_rc;
> +}
> +
> +static int
> +test_stack_copy_uint128(void)
> +{
> +	const int test_rc =3D call_from_bpf_test(stack_copy_uint128_xfunc);
> +	if (test_rc =3D=3D TEST_SKIPPED)
> +		return TEST_SKIPPED;
> +
> +	RTE_TEST_ASSERT_SUCCESS(test_rc,
> +		"expect call_from_bpf_test(stack_copy_uint128_xfunc) to
> succeed");
> +
> +	return TEST_SUCCESS;
> +}
> +
> +#else
> +
> +static int
> +test_stack_copy_uint128(void)
> +{
> +	return TEST_SKIPPED;
> +}
> +
> +#endif
> +
> +REGISTER_FAST_TEST(bpf_stack_copy_uint128_autotest, true, true,
> test_stack_copy_uint128);
> +
> +/*
> + * Test SSE2 load and store intrinsics.
> + *
> + * These intrinsics are used by e.g. lib/hash.
> + *
> + * Test both aligned and unaligned versions. Unaligned intrinsics may st=
ill fail
> + * when the stack is misaligned, since they only treat memory address as
> + * unaligned, not stack.
> + */
> +
> +#if defined(__SSE2__)
> +
> +static uint64_t
> +stack_sse2_aligned_xfunc(uint64_t argument)
> +{
> +	/* Pass addresses through volatiles to prevent compiler from optimizing=
 it all
> out. */
> +	char alignas(16) src_buffer[16];
> +	char alignas(16) dst_buffer[16];
> +	void *const src =3D (char *volatile)src_buffer;
> +	void *const dst =3D (char *volatile)dst_buffer;
> +	const size_t size =3D 16;
> +
> +	memset(src, 0x2a, size);
> +	memset(dst, 0x55, size);
> +	const int initial_memcmp_rc =3D memcmp(dst, src, size);
> +
> +	const __m128i tmp =3D _mm_load_si128((const __m128i *)src);
> +	_mm_store_si128((__m128i *)dst, tmp);
> +	const int memcmp_rc =3D memcmp(dst, src, size);
> +
> +	return argument + 1 + !initial_memcmp_rc + memcmp_rc;
> +}
> +
> +static uint64_t
> +stack_sse2_unaligned_xfunc(uint64_t argument)
> +{
> +	/* Pass addresses through volatiles to prevent compiler from optimizing=
 it all
> out. */
> +	char alignas(16) src_buffer[17];
> +	char alignas(16) dst_buffer[17];
> +	void *const src =3D (char *volatile)src_buffer + 1;
> +	void *const dst =3D (char *volatile)dst_buffer + 1;
> +	const size_t size =3D 16;
> +
> +	memset(src, 0x2a, size);
> +	memset(dst, 0x55, size);
> +	const int initial_memcmp_rc =3D memcmp(dst, src, size);
> +
> +	const __m128i tmp =3D _mm_loadu_si128((const __m128i *)src);
> +	_mm_storeu_si128((__m128i *)dst, tmp);
> +	const int memcmp_rc =3D memcmp(dst, src, size);
> +
> +	return argument + 1 + !initial_memcmp_rc + memcmp_rc;
> +}
> +
> +static int
> +test_stack_sse2(void)
> +{
> +	int test_rc;
> +
> +	test_rc =3D call_from_bpf_test(stack_sse2_aligned_xfunc);
> +	if (test_rc =3D=3D TEST_SKIPPED)
> +		return test_rc;
> +	RTE_TEST_ASSERT_SUCCESS(test_rc,
> +		"expect call_from_bpf_test(stack_sse2_aligned_xfunc) to
> succeed");
> +
> +	test_rc =3D call_from_bpf_test(stack_sse2_unaligned_xfunc);
> +	if (test_rc =3D=3D TEST_SKIPPED)
> +		return test_rc;
> +	RTE_TEST_ASSERT_SUCCESS(test_rc,
> +		"expect call_from_bpf_test(stack_sse2_unaligned_xfunc) to
> succeed");
> +
> +	return TEST_SUCCESS;
> +}
> +
> +#else
> +
> +static int
> +test_stack_sse2(void)
> +{
> +	return TEST_SKIPPED;
> +}
> +
> +#endif
> +
> +REGISTER_FAST_TEST(bpf_stack_sse2_autotest, true, true, test_stack_sse2)=
;
> +
> +/*
> + * Run memcpy and rte_memcpy with various data sizes and offsets (unalig=
ned and
> aligned).
> + *
> + * May produce false negatives even if BPF breaks stack alignment since
> + * compilers may realign the stack in the beginning of the function to u=
se
> + * vector instructions with width larger than the default stack alignmen=
t.
> + * However, represents very important use case that was broken in practi=
ce.
> + *
> + * For the reason specified above test 16-byte fixed-width memcpy explic=
itly.
> + */
> +
> +static void *volatile stack_memcpy_dst;
> +static const void *volatile stack_memcpy_src;
> +static size_t volatile stack_memcpy_size;
> +
> +static uint64_t
> +stack_memcpy16_xfunc(uint64_t argument)
> +{
> +	RTE_ASSERT(stack_memcpy_size =3D=3D 16);
> +	memcpy(stack_memcpy_dst, stack_memcpy_src, 16);
> +	return argument + 1;
> +}
> +
> +static uint64_t
> +stack_rte_memcpy16_xfunc(uint64_t argument)
> +{
> +	RTE_ASSERT(stack_memcpy_size =3D=3D 16);
> +	rte_memcpy(stack_memcpy_dst, stack_memcpy_src, 16);
> +	return argument + 1;
> +}
> +
> +static uint64_t
> +stack_memcpy_xfunc(uint64_t argument)
> +{
> +	memcpy(stack_memcpy_dst, stack_memcpy_src, stack_memcpy_size);
> +	return argument + 1;
> +}
> +
> +static uint64_t
> +stack_rte_memcpy_xfunc(uint64_t argument)
> +{
> +	rte_memcpy(stack_memcpy_dst, stack_memcpy_src, stack_memcpy_size);
> +	return argument + 1;
> +}
> +
> +static int
> +stack_memcpy_subtest(text_xfunc_t xfunc, size_t size, size_t src_offset,=
 size_t
> dst_offset)
> +{
> +	stack_memcpy_size =3D size;
> +
> +	char *const src_buffer =3D malloc(size + src_offset);
> +	memset(src_buffer + src_offset, 0x2a, size);
> +	stack_memcpy_src =3D src_buffer + src_offset;
> +
> +	char *const dst_buffer =3D malloc(size + dst_offset);
> +	memset(dst_buffer + dst_offset, 0x55, size);
> +	stack_memcpy_dst =3D dst_buffer + dst_offset;
> +
> +	const int initial_memcmp_rc =3D memcmp(stack_memcpy_dst,
> stack_memcpy_src, size);
> +	const int test_rc =3D call_from_bpf_test(xfunc);
> +	const int memcmp_rc =3D memcmp(stack_memcpy_dst, stack_memcpy_src,
> size);
> +
> +	free(dst_buffer);
> +	free(src_buffer);
> +
> +	if (test_rc =3D=3D TEST_SKIPPED)
> +		return TEST_SKIPPED;
> +
> +	RTE_TEST_ASSERT_FAIL(initial_memcmp_rc, "expect memcmp() to fail
> initially");
> +	RTE_TEST_ASSERT_SUCCESS(test_rc, "expect call_from_bpf_test(xfunc) to
> succeed");
> +	RTE_TEST_ASSERT_SUCCESS(memcmp_rc, "expect memcmp() to succeed");
> +
> +	return TEST_SUCCESS;
> +}
> +
> +static int
> +test_stack_memcpy(void)
> +{
> +	for (int offsets =3D 0; offsets < 4; ++offsets) {
> +		const bool src_offset =3D offsets & 1;
> +		const bool dst_offset =3D offsets & 2;
> +		int test_rc;
> +
> +		test_rc =3D stack_memcpy_subtest(stack_memcpy16_xfunc,
> +			16, src_offset, dst_offset);
> +		if (test_rc =3D=3D TEST_SKIPPED)
> +			return test_rc;
> +		RTE_TEST_ASSERT_SUCCESS(test_rc,
> +			"expect stack_memcpy_subtest(stack_memcpy16_xfunc, "
> +				"16, %i, %i) to succeed",
> +			src_offset, dst_offset);
> +
> +		test_rc =3D stack_memcpy_subtest(stack_rte_memcpy16_xfunc,
> +			16, src_offset, dst_offset);
> +		if (test_rc =3D=3D TEST_SKIPPED)
> +			return test_rc;
> +		RTE_TEST_ASSERT_SUCCESS(test_rc,
> +			"expect
> stack_memcpy_subtest(stack_rte_memcpy16_xfunc, "
> +				"16, %i, %i) to succeed",
> +			src_offset, dst_offset);
> +
> +		for (size_t size =3D 1; size <=3D 1024; size <<=3D 1) {
> +			const bool src_offset =3D offsets & 1;
> +			const bool dst_offset =3D offsets & 2;
> +			int test_rc;
> +
> +			test_rc =3D stack_memcpy_subtest(stack_memcpy_xfunc,
> +				size, src_offset, dst_offset);
> +			if (test_rc =3D=3D TEST_SKIPPED)
> +				return test_rc;
> +			RTE_TEST_ASSERT_SUCCESS(test_rc,
> +				"expect
> stack_memcpy_subtest(stack_memcpy_xfunc, "
> +					"%zu, %i, %i) to succeed",
> +				size, src_offset, dst_offset);
> +
> +			test_rc =3D stack_memcpy_subtest(stack_rte_memcpy_xfunc,
> +				size, src_offset, dst_offset);
> +			if (test_rc =3D=3D TEST_SKIPPED)
> +				return test_rc;
> +			RTE_TEST_ASSERT_SUCCESS(test_rc,
> +				"expect
> stack_memcpy_subtest(stack_rte_memcpy_xfunc, "
> +					"%zu, %i, %i) to succeed",
> +				size, src_offset, dst_offset);
> +		}
> +	}
> +	return TEST_SUCCESS;
> +}
> +
> +REGISTER_FAST_TEST(bpf_stack_memcpy_autotest, true, true,
> test_stack_memcpy);
> +
>  #ifdef TEST_BPF_ELF_LOAD
>=20
>  /*
> diff --git a/lib/bpf/bpf_jit_x86.c b/lib/bpf/bpf_jit_x86.c
> index 4d74e418f8..09865acabb 100644
> --- a/lib/bpf/bpf_jit_x86.c
> +++ b/lib/bpf/bpf_jit_x86.c
> @@ -93,6 +93,8 @@ enum {
>  /*
>   * callee saved registers list.
>   * keep RBP as the last one.
> + * RBP is marked as used every time we have external calls
> + * since we need it to save RSP before stack realignment.
>   */
>  static const uint32_t save_regs[] =3D {RBX, R12, R13, R14, R15, RBP};
>=20
> @@ -685,6 +687,8 @@ emit_call(struct bpf_jit_state *st, uintptr_t trg)
>  	const uint8_t ops =3D 0xFF;
>  	const uint8_t mods =3D 2;
>=20
> +	/* Mark RBP as used to trigger stack realignment in prolog. */
> +	USED(st->reguse, RBP);
>  	emit_ld_imm64(st, RAX, trg, trg >> 32);
>  	emit_bytes(st, &ops, sizeof(ops));
>  	emit_modregrm(st, MOD_DIRECT, mods, RAX);
> @@ -1204,7 +1208,6 @@ emit_prolog(struct bpf_jit_state *st, int32_t stack=
_size)
>  	if (spil =3D=3D 0)
>  		return;
>=20
> -
>  	emit_alu_imm(st, EBPF_ALU64 | BPF_SUB | BPF_K, RSP,
>  		spil * sizeof(uint64_t));
>=20
> @@ -1220,6 +1223,16 @@ emit_prolog(struct bpf_jit_state *st, int32_t stac=
k_size)
>  	if (INUSE(st->reguse, RBP) !=3D 0) {
>  		emit_mov_reg(st, EBPF_ALU64 | EBPF_MOV | BPF_X, RSP, RBP);
>  		emit_alu_imm(st, EBPF_ALU64 | BPF_SUB | BPF_K, RSP, stack_size);
> +
> +		/*
> +		 * Align stack pointer appropriately for function calls.
> +		 * We do not have direct access to function stack alignment
> +		 * value (like gcc internal macro INCOMING_STACK_BOUNDARY),
> +		 * but hopefully `alignof(max_align_t)` will always be greater.
> +		 * Original stack pointer will be restored from rbp.
> +		 */
> +		emit_alu_imm(st, EBPF_ALU64 | BPF_AND | BPF_K, RSP,
> +			-(uint32_t)alignof(max_align_t));
>  	}
>  }
>=20
> --
> 2.43.0

