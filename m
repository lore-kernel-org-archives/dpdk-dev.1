Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2FCCDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 07:59:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 571DE40150;
	Wed, 24 Jun 2026 09:59:41 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 97EBE400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 09:59:39 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4glZ895wP6zHnGjR;
 Wed, 24 Jun 2026 15:59:05 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id B7F3E40575;
 Wed, 24 Jun 2026 15:59:37 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 09:59:37 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 24 Jun 2026 09:59:37 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v4 3/7] test/bpf: add test for large shift
Thread-Topic: [PATCH v4 3/7] test/bpf: add test for large shift
Thread-Index: AQHdA2eYIEUgsGEG4kaic4WUD8yF/7ZNVaaQ
Date: Wed, 24 Jun 2026 07:59:37 +0000
Message-ID: <8c882f31aaec46d984fc4c689ad92602@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260623232522.257208-1-stephen@networkplumber.org>
 <20260623232522.257208-4-stephen@networkplumber.org>
In-Reply-To: <20260623232522.257208-4-stephen@networkplumber.org>
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
> Sent: Wednesday 24 June 2026 00:23
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH v4 3/7] test/bpf: add test for large shift
>=20
> The JIT compiler had issues with immediate values on shift instructions
> so add a new test to cover that case.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_bpf.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 232e9e2a98..b54e36910b 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -2005,6 +2005,58 @@ test_div1_check(uint64_t rc, const void *arg)
>  	return cmp_res(__func__, 0, rc, dve.out, dvt->out, sizeof(dve.out));
>  }
>=20
> +/*
> + * Shift by an immediate that doesn't fit in a signed byte: the C1 shift
> + * group takes a fixed 1-byte immediate, but imm_size() returns 4 for
> + * counts >=3D 128, so the x86 JIT emits 3 stray bytes and desyncs the
> + * instruction stream. The shift results are discarded (a count >=3D 64 =
is
> + * UB in the interpreter); the test returns a known constant, which the
> + * corrupted stream fails to produce.
> + */
> +static const struct ebpf_insn test_shift_big_imm_prog[] =3D {
> +	{
> +		.code =3D (BPF_ALU | EBPF_MOV | BPF_K),
> +		.dst_reg =3D EBPF_REG_2,
> +		.imm =3D 0x1,
> +	},
> +	{
> +		.code =3D (EBPF_ALU64 | BPF_LSH | BPF_K),
> +		.dst_reg =3D EBPF_REG_2,
> +		.imm =3D 137,
> +	},
> +	{
> +		.code =3D (EBPF_ALU64 | BPF_RSH | BPF_K),
> +		.dst_reg =3D EBPF_REG_2,
> +		.imm =3D 200,
> +	},
> +	{
> +		.code =3D (EBPF_ALU64 | EBPF_ARSH | BPF_K),
> +		.dst_reg =3D EBPF_REG_2,
> +		.imm =3D 255,
> +	},
> +	/* known result; a desynced stream won't reproduce it */
> +	{
> +		.code =3D (BPF_ALU | EBPF_MOV | BPF_K),
> +		.dst_reg =3D EBPF_REG_0,
> +		.imm =3D 0x55,
> +	},
> +	{
> +		.code =3D (BPF_JMP | EBPF_EXIT),
> +	},
> +};

// snip the rest

Thanks a lot for adding this test. Can we use the shift results though, ins=
tead
of discarding them, maybe as another test case? If the interpreter is unabl=
e to
reproduce them or triggers sanitizer it needs to be fixed as well. (Apologi=
es
for this scope creep but I hope we get to the bottom of it eventually.)
