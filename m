Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC445CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 10:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99998402A2;
	Tue, 23 Jun 2026 12:16:33 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id DB95D40269
 for <dev@dpdk.org>; Tue, 23 Jun 2026 12:16:31 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gl1DX1RDCzJ46dc;
 Tue, 23 Jun 2026 18:15:56 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id 01EE34058E;
 Tue, 23 Jun 2026 18:16:31 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 12:16:30 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 23 Jun 2026 12:16:30 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v3 2/6] test/bpf: add JSET test with small immediate
Thread-Topic: [PATCH v3 2/6] test/bpf: add JSET test with small immediate
Thread-Index: AQHdAZqYGXtT2GgNwUKEgHEgX/9h77ZL7kjQ
Date: Tue, 23 Jun 2026 10:16:30 +0000
Message-ID: <2281f8753a6c440fb471a68f350ae848@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260621162524.82690-1-stephen@networkplumber.org>
 <20260621162524.82690-3-stephen@networkplumber.org>
In-Reply-To: <20260621162524.82690-3-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

This instruction has an interesting behavior for negative values of immedia=
te,
to be thorough I would test them as well. Fixed x86 should pass but who kno=
ws.

I would also welcome a test reproducing the problem with shifts.

For the narrow scope of this test,

Acked-by: Marat Khalili <marat.khalili@huawei.com>

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Sunday 21 June 2026 17:24
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH v3 2/6] test/bpf: add JSET test with small immediate
>=20
> The existing jump test only used a 32-bit JSET mask,
> so the broken imm8 encoding of TEST in the x86 JIT was never exercised.
> Add a case with a byte-sized mask;
> run_test() runs it through the interpreter and the JIT.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_bpf.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index dd24722450..e70dea736f 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -3158,7 +3158,89 @@ static const struct ebpf_insn test_ld_mbuf3_prog[]=
 =3D {
>  };
>=20
>  /* all bpf test cases */
> +/*
> + * JSET with a byte-sized mask: exercises the imm8 path of the TEST
> + * encoding in the x86 JIT (a 32-bit mask takes a different path).
> + */
> +static const struct ebpf_insn test_jset1_prog[] =3D {
> +	{
> +		.code =3D (BPF_ALU | EBPF_MOV | BPF_K),
> +		.dst_reg =3D EBPF_REG_0,
> +		.imm =3D 0,
> +	},
> +	{
> +		.code =3D (BPF_LDX | BPF_MEM | BPF_B),
> +		.dst_reg =3D EBPF_REG_2,
> +		.src_reg =3D EBPF_REG_1,
> +		.off =3D offsetof(struct dummy_offset, u8),
> +	},
> +	/* bit 0 is set in the input: branch is taken */
> +	{
> +		.code =3D (BPF_JMP | BPF_JSET | BPF_K),
> +		.dst_reg =3D EBPF_REG_2,
> +		.imm =3D 0x1,
> +		.off =3D 1,
> +	},
> +	{
> +		.code =3D (BPF_JMP | BPF_JA),
> +		.off =3D 1,
> +	},
> +	{
> +		.code =3D (EBPF_ALU64 | BPF_OR | BPF_K),
> +		.dst_reg =3D EBPF_REG_0,
> +		.imm =3D 0x1,
> +	},
> +	/* bit 1 is clear in the input: branch is not taken */
> +	{
> +		.code =3D (BPF_JMP | BPF_JSET | BPF_K),
> +		.dst_reg =3D EBPF_REG_2,
> +		.imm =3D 0x2,
> +		.off =3D 1,
> +	},
> +	{
> +		.code =3D (BPF_JMP | BPF_JA),
> +		.off =3D 1,
> +	},
> +	{
> +		.code =3D (EBPF_ALU64 | BPF_OR | BPF_K),
> +		.dst_reg =3D EBPF_REG_0,
> +		.imm =3D 0x2,
> +	},
> +	{
> +		.code =3D (BPF_JMP | EBPF_EXIT),
> +	},
> +};
> +
> +static void
> +test_jset1_prepare(void *arg)
> +{
> +	struct dummy_offset *df =3D arg;
> +
> +	memset(df, 0, sizeof(*df));
> +	df->u8 =3D 0x1;	/* bit 0 set, bit 1 clear */
> +}
> +
> +static int
> +test_jset1_check(uint64_t rc, const void *arg)
> +{
> +	return cmp_res(__func__, 0x1, rc, arg, arg, 0);
> +}
> +
>  static const struct bpf_test tests[] =3D {
> +	{
> +		.name =3D "test_jset1",
> +		.arg_sz =3D sizeof(struct dummy_offset),
> +		.prm =3D {
> +			.ins =3D test_jset1_prog,
> +			.nb_ins =3D RTE_DIM(test_jset1_prog),
> +			.prog_arg =3D {
> +				.type =3D RTE_BPF_ARG_PTR,
> +				.size =3D sizeof(struct dummy_offset),
> +			},
> +		},
> +		.prepare =3D test_jset1_prepare,
> +		.check_result =3D test_jset1_check,
> +	},
>  	{
>  		.name =3D "test_store1",
>  		.arg_sz =3D sizeof(struct dummy_offset),
> --
> 2.53.0

