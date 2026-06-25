Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C096ECDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:38:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 042114067D;
	Thu, 25 Jun 2026 17:38:22 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 52F9440616
 for <dev@dpdk.org>; Thu, 25 Jun 2026 17:38:21 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gmNGx5czWzHnH6Y;
 Thu, 25 Jun 2026 23:37:45 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id 4F6BF40575;
 Thu, 25 Jun 2026 23:38:20 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 25 Jun 2026 17:38:20 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 25 Jun 2026 17:38:20 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v5 5/9] test/bpf: add test for large shift
Thread-Topic: [PATCH v5 5/9] test/bpf: add test for large shift
Thread-Index: AQHdBAMRrh21QC03202Tnmox5dY47bZPaSQA
Date: Thu, 25 Jun 2026 15:38:20 +0000
Message-ID: <89c5c12ee51d49bb961972dc22bc5ea5@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260624175815.673064-1-stephen@networkplumber.org>
 <20260624175815.673064-6-stephen@networkplumber.org>
In-Reply-To: <20260624175815.673064-6-stephen@networkplumber.org>
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday 24 June 2026 18:55
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH v5 5/9] test/bpf: add test for large shift
>=20
> There were multiple bugs with immediate values in shift instructions.
> The code was not masking as required by RFC.
>=20
> Add new tests that cover these instructions.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Marat Khalili <marat.khalili@huawei.com>

> ---
>  app/test/test_bpf.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 232e9e2a98..0e5894a532 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -2005,6 +2005,51 @@ test_div1_check(uint64_t rc, const void *arg)
>  	return cmp_res(__func__, 0, rc, dve.out, dvt->out, sizeof(dve.out));
>  }
>=20
> +/*
> + * Shift counts are masked to the operand width (RFC 9669: 0x3f for 64-b=
it,
> + * 0x1f for 32-bit). Counts >=3D 128 also exercise the x86 imm_size() pa=
th that
> + * used to desync the stream, and the arm64 UBFM/SBFM immediate encoding=
.
> + */
> +static const struct ebpf_insn test_shift_big_imm_prog[] =3D {
> +	{
> +		.code =3D (EBPF_ALU64 | EBPF_MOV | BPF_K),
> +		.dst_reg =3D EBPF_REG_0,
> +		.imm =3D 1
> +	},
> +	{
> +		.code =3D (EBPF_ALU64 | BPF_LSH | BPF_K),
> +		.dst_reg =3D EBPF_REG_0,
> +		.imm =3D 191
> +	},
> +	{
> +		.code =3D (EBPF_ALU64 | EBPF_ARSH | BPF_K),
> +		.dst_reg =3D EBPF_REG_0,
> +		.imm =3D 200
> +	},
> +	{
> +		.code =3D (EBPF_ALU64 | BPF_RSH | BPF_K),
> +		.dst_reg =3D EBPF_REG_0,
> +		.imm =3D 130
> +	},
> +	{
> +		.code =3D (BPF_JMP | EBPF_EXIT)
> +	},
> +};
> +
> +static void
> +test_shift_big_imm_prepare(void *arg)
> +{
> +	memset(arg, 0, sizeof(struct dummy_offset));
> +}
> +
> +static int
> +test_shift_big_imm_check(uint64_t rc, const void *arg)
> +{
> +	uint64_t expect =3D 0x3FE0000000000000ULL;
> +
> +	return cmp_res(__func__, expect, rc, arg, arg, 0);
> +}
> +
>  /* call test-cases */
>  static const struct ebpf_insn test_call1_prog[] =3D {
>=20
> @@ -3409,6 +3454,20 @@ static const struct bpf_test tests[] =3D {
>  		.prepare =3D test_mul1_prepare,
>  		.check_result =3D test_div1_check,
>  	},
> +	{
> +		.name =3D "test_shift_big_imm",
> +		.arg_sz =3D sizeof(struct dummy_offset),
> +		.prm =3D {
> +			.ins =3D test_shift_big_imm_prog,
> +			.nb_ins =3D RTE_DIM(test_shift_big_imm_prog),
> +			.prog_arg =3D {
> +				.type =3D RTE_BPF_ARG_PTR,
> +				.size =3D sizeof(struct dummy_offset),
> +			},
> +		},
> +		.prepare =3D test_shift_big_imm_prepare,
> +		.check_result =3D test_shift_big_imm_check,
> +	},
>  	{
>  		.name =3D "test_call1",
>  		.arg_sz =3D sizeof(struct dummy_offset),
> --
> 2.53.0

