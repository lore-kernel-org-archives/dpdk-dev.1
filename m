Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107D5CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 15:35:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22316406B6;
	Wed, 12 Nov 2025 16:35:34 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D6744402AF
 for <dev@dpdk.org>; Wed, 12 Nov 2025 16:35:32 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d66sY4dn9zJ46mV;
 Wed, 12 Nov 2025 23:34:57 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id 5462514038F;
 Wed, 12 Nov 2025 23:35:30 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 12 Nov 2025 15:35:29 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 12 Nov 2025 15:35:29 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 2/3] bpf: disallow empty program
Thread-Topic: [PATCH 2/3] bpf: disallow empty program
Thread-Index: AQHcUlcXkz3QHxSeZECN/8tViGS8YLTvLaWQ
Date: Wed, 12 Nov 2025 15:35:29 +0000
Message-ID: <7431f0d4eb3e460eb89e75e3da3d9fa3@huawei.com>
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251110153046.63518-3-marat.khalili@huawei.com>
In-Reply-To: <20251110153046.63518-3-marat.khalili@huawei.com>
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



> Add tests for some simple cases:
> * Program with no instructions;
> * Program with only EXIT instruction but no return value set;
> * Program with return value set but no EXIT instruction;
> * Minimal valid program with return value set and an EXIT instruction.
>=20
> Fix found bugs:
> * a program with no instructions was accepted;
> * a program with no EXIT instruction read outside the buffer.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  app/test/meson.build       |   1 +
>  app/test/test_bpf_simple.c | 131 +++++++++++++++++++++++++++++++++++++
>  lib/bpf/bpf_load.c         |   2 +-
>  lib/bpf/bpf_validate.c     |  20 ++++--
>  4 files changed, 149 insertions(+), 5 deletions(-)
>  create mode 100644 app/test/test_bpf_simple.c
>=20
> diff --git a/app/test/meson.build b/app/test/meson.build
> index 8df8d3edd1..9d48431ba0 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -35,6 +35,7 @@ source_file_deps =3D {
>      'test_bitset.c': [],
>      'test_bitratestats.c': ['metrics', 'bitratestats', 'ethdev'] +
> sample_packet_forward_deps,
>      'test_bpf.c': ['bpf', 'net'],
> +    'test_bpf_simple.c': ['bpf'],
>      'test_byteorder.c': [],
>      'test_cfgfile.c': ['cfgfile'],
>      'test_cksum.c': ['net'],
> diff --git a/app/test/test_bpf_simple.c b/app/test/test_bpf_simple.c
> new file mode 100644
> index 0000000000..576a6ed029
> --- /dev/null
> +++ b/app/test/test_bpf_simple.c
> @@ -0,0 +1,131 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Huawei Technologies Co., Ltd
> + */
> +
> +#include "test.h"
> +
> +#include <rte_bpf.h>
> +#include <rte_errno.h>
> +
> +/* Tests of most simple BPF programs (no instructions, one instruction e=
tc.) */
> +
> +/*
> + * Try to load a simple bpf program from the instructions array.
> + *
> + * When `expected_errno` is zero, expect it to load successfully.
> + * When `expected_errno` is non-zero, expect it to fail with this `rte_e=
rrno`.
> + *
> + * @param nb_ins
> + *   Number of instructions in the `ins` array.
> + * @param ins
> + *   BPF instructions array.
> + * @param expected_errno
> + *   Expected result.
> + * @return
> + *   TEST_SUCCESS on success, error code on failure.
> + */
> +static int
> +simple_bpf_load_test(uint32_t nb_ins, const struct ebpf_insn *ins,
> +	int expected_errno)
> +{
> +	const struct rte_bpf_prm prm =3D {
> +		.ins =3D ins,
> +		.nb_ins =3D nb_ins,
> +		.prog_arg =3D {
> +			.type =3D RTE_BPF_ARG_RAW,
> +			.size =3D sizeof(uint64_t),
> +		},
> +	};
> +
> +	struct rte_bpf *const bpf =3D rte_bpf_load(&prm);
> +	const int actual_errno =3D rte_errno;
> +	rte_bpf_destroy(bpf);
> +
> +	if (expected_errno !=3D 0) {
> +		RTE_TEST_ASSERT_EQUAL(bpf, NULL,
> +			"expect rte_bpf_load() =3D=3D NULL");
> +		RTE_TEST_ASSERT_EQUAL(actual_errno, expected_errno,
> +			"expect rte_errno =3D=3D %d, found %d",
> +			expected_errno, actual_errno);
> +	} else
> +		RTE_TEST_ASSERT_NOT_EQUAL(bpf, NULL,
> +			"expect rte_bpf_load() !=3D NULL");
> +
> +	return TEST_SUCCESS;
> +}
> +
> +/*
> + * Try and load completely empty BPF program.
> + * Should fail because there is no EXIT (and also return value is undefi=
ned).
> + */
> +static int
> +test_simple_no_instructions(void)
> +{
> +	static const struct ebpf_insn ins[] =3D {};
> +	return simple_bpf_load_test(RTE_DIM(ins), ins, EINVAL);
> +}
> +
> +REGISTER_FAST_TEST(bpf_simple_no_instructions_autotest, true, true,
> +	test_simple_no_instructions);
> +
> +/*
> + * Try and load a BPF program comprising single EXIT instruction.
> + * Should fail because the return value is undefined.
> + */
> +static int
> +test_simple_exit_only(void)
> +{
> +	static const struct ebpf_insn ins[] =3D {
> +		{
> +			.code =3D (BPF_JMP | EBPF_EXIT),
> +		},
> +	};
> +	return simple_bpf_load_test(RTE_DIM(ins), ins, EINVAL);
> +}
> +
> +REGISTER_FAST_TEST(bpf_simple_exit_only_autotest, true, true,
> +	test_simple_exit_only);
> +
> +/*
> + * Try and load a BPF program with no EXIT instruction.
> + * Should fail because of this.
> + */
> +static int
> +test_simple_no_exit(void)
> +{
> +	static const struct ebpf_insn ins[] =3D {
> +		{
> +			/* Set return value to the program argument. */
> +			.code =3D (EBPF_ALU64 | EBPF_MOV | BPF_X),
> +			.src_reg =3D EBPF_REG_1,
> +			.dst_reg =3D EBPF_REG_0,
> +		},
> +	};
> +	return simple_bpf_load_test(RTE_DIM(ins), ins, EINVAL);
> +}
> +
> +REGISTER_FAST_TEST(bpf_simple_no_exit_autotest, true, true,
> +	test_simple_no_exit);
> +
> +/*
> + * Try and load smallest possible valid BPF program.
> + */
> +static int
> +test_simple_minimal_working(void)
> +{
> +	static const struct ebpf_insn ins[] =3D {
> +		{
> +			/* Set return value to the program argument. */
> +			.code =3D (EBPF_ALU64 | EBPF_MOV | BPF_X),
> +			.src_reg =3D EBPF_REG_1,
> +			.dst_reg =3D EBPF_REG_0,
> +		},
> +		{
> +			.code =3D (BPF_JMP | EBPF_EXIT),
> +		},
> +	};
> +	return simple_bpf_load_test(RTE_DIM(ins), ins, 0);
> +}
> +
> +REGISTER_FAST_TEST(bpf_simple_minimal_working_autotest, true, true,
> +	test_simple_minimal_working);
> diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
> index 556e613762..6983c026af 100644
> --- a/lib/bpf/bpf_load.c
> +++ b/lib/bpf/bpf_load.c
> @@ -88,7 +88,7 @@ rte_bpf_load(const struct rte_bpf_prm *prm)
>  	int32_t rc;
>  	uint32_t i;
>=20
> -	if (prm =3D=3D NULL || prm->ins =3D=3D NULL ||
> +	if (prm =3D=3D NULL || prm->ins =3D=3D NULL || prm->nb_ins =3D=3D 0 ||
>  			(prm->nb_xsym !=3D 0 && prm->xsym =3D=3D NULL)) {
>  		rte_errno =3D EINVAL;
>  		return NULL;
> diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
> index 4f47d6dc7b..23444b3eaa 100644
> --- a/lib/bpf/bpf_validate.c
> +++ b/lib/bpf/bpf_validate.c
> @@ -1827,7 +1827,7 @@ add_edge(struct bpf_verifier *bvf, struct inst_node
> *node, uint32_t nidx)
>  {
>  	uint32_t ne;
>=20
> -	if (nidx > bvf->prm->nb_ins) {
> +	if (nidx >=3D bvf->prm->nb_ins) {
>  		RTE_BPF_LOG_LINE(ERR,
>  			"%s: program boundary violation at pc: %u, next pc: %u",
>  			__func__, get_node_idx(bvf, node), nidx);
> @@ -1886,14 +1886,20 @@ get_prev_node(struct bpf_verifier *bvf, struct
> inst_node *node)
>   * Control Flow Graph (CFG).
>   * Information collected at this path would be used later
>   * to determine is there any loops, and/or unreachable instructions.
> + * PREREQUISITE: there is at least one node.
>   */
>  static void
>  dfs(struct bpf_verifier *bvf)
>  {
>  	struct inst_node *next, *node;
>=20
> -	node =3D bvf->in;
> -	while (node !=3D NULL) {
> +	RTE_ASSERT(bvf->nb_nodes !=3D 0);
> +	/*
> +	 * Since there is at least one node, node with index 0 always exists;
> +	 * it is our program entry point.
> +	 */
> +	node =3D &bvf->in[0];
> +	do {
>=20
>  		if (node->colour =3D=3D WHITE)
>  			set_node_colour(bvf, node, GREY);
> @@ -1923,7 +1929,7 @@ dfs(struct bpf_verifier *bvf)
>  			}
>  		} else
>  			node =3D NULL;
> -	}
> +	} while (node !=3D NULL);
>  }
>=20
>  /*
> @@ -2062,6 +2068,12 @@ validate(struct bpf_verifier *bvf)
>  	if (rc !=3D 0)
>  		return rc;
>=20
> +	if (bvf->nb_nodes =3D=3D 0) {
> +		RTE_BPF_LOG_LINE(ERR, "%s(%p) the program is empty",
> +			__func__, bvf);
> +		return -EINVAL;
> +	}
> +
>  	dfs(bvf);
>=20
>  	RTE_LOG(DEBUG, BPF, "%s(%p) stats:\n"
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.43.0

