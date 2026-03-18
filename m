Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3059B103E160
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 11:59:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1209A402A0;
	Wed, 18 Mar 2026 12:59:25 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 301804026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 12:59:23 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fbS5X5qZ4zJ46dZ;
 Wed, 18 Mar 2026 19:58:24 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id 815DD40572;
 Wed, 18 Mar 2026 19:59:22 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 12:59:22 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 18 Mar 2026 12:59:22 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Christophe Fontaine <cfontain@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
Subject: RE: [PATCH] bpf/arm64: support packet data load instructions
Thread-Topic: [PATCH] bpf/arm64: support packet data load instructions
Thread-Index: AQHctXjoFxWXyTh3g0OC9SlGIQcTMrW0I+zw
Date: Wed, 18 Mar 2026 11:59:22 +0000
Message-ID: <b10d0edcdaac4fd9a4f5a0261205670c@huawei.com>
References: <20260310122045.4057836-1-cfontain@redhat.com>
In-Reply-To: <20260310122045.4057836-1-cfontain@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.74]
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

Hi! Thank you for doing this, please see some comments inline.

> @@ -3491,6 +3531,7 @@ run_test(const struct bpf_test *tst)
>  	if (ret !=3D 0) {
>  		printf("%s@%d: check_result(%s) failed, error: %d(%s);\n",
>  			__func__, __LINE__, tst->name, ret, strerror(ret));
> +		return -1;
>  	}
>=20
>  	/* repeat the same test with jit, when possible */
> @@ -3506,6 +3547,7 @@ run_test(const struct bpf_test *tst)
>  				"error: %d(%s);\n",
>  				__func__, __LINE__, tst->name,
>  				rv, strerror(rv));
> +			return -1;
>  		}
>  	}
>=20

All return values were OR-ed, so adding early return is not strictly necess=
ary.

The real problem is JIT tests being skipped altogether if jit.func =3D=3D N=
ULL, and
it still remains. We need to disallow empty jit.func on platforms with know=
n
working JIT.

(I'd ask for many more tests, but not sure it's fair since they aren't real=
ly
platform-dependent.)

// snip to implementation

> +static void
> +emit_ld_mbuf(struct a64_jit_ctx *ctx, uint32_t op, uint8_t tmp1, uint8_t=
 tmp2,
> +	uint8_t src, uint32_t imm)

Handling immediate as unsigned is questionable, especially in the BPF_IND c=
ase
it may produce incorrect results.

To make things worse, `__rte_pktmbuf_read` is also buggy when passed very l=
arge
lengths (again, technically not ARM eBPF fault).

> +{
> +	uint8_t r0 =3D ebpf_to_a64_reg(ctx, EBPF_REG_0);
> +	uint8_t r6 =3D ebpf_to_a64_reg(ctx, EBPF_REG_6);
> +	uint32_t mode =3D BPF_MODE(op);
> +	uint32_t opsz =3D BPF_SIZE(op);
> +	uint32_t sz =3D bpf_size(opsz);
> +	int16_t jump_to_epilogue;
> +
> +	/* r0 =3D mbuf (R6) */
> +	emit_mov_64(ctx, A64_R(0), r6);
> +
> +	/* r1 =3D off: for ABS use imm, for IND use src + imm */
> +	if (mode =3D=3D BPF_ABS) {
> +		emit_mov_imm(ctx, 1, A64_R(1), imm);
> +	} else {
> +		emit_mov_imm(ctx, 1, tmp2, imm);
> +		emit_add(ctx, 1, tmp2, src);
> +		emit_mov_64(ctx, A64_R(1), tmp2);
> +	}
> +
> +	/* r2 =3D len */
> +	emit_mov_imm(ctx, 1, A64_R(2), sz);
> +
> +	/* r3 =3D buf (SP) */
> +	emit_mov_64(ctx, A64_R(3), A64_SP);
> +
> +	/* call __rte_pktmbuf_read */
> +	emit_call(ctx, tmp1, __rte_pktmbuf_read);
> +	/* check return value of __rte_pktmbuf_read */
> +	emit_cbnz(ctx, 1, A64_R(0), 3);
> +	emit_mov_imm(ctx, 1, r0, 0);
> +	jump_to_epilogue =3D (ctx->program_start + ctx->program_sz) - ctx->idx;
> +	emit_b(ctx, jump_to_epilogue);

Could we call emit_return_zero_if_src_zero here instead?

> +
> +	/* r0 points to the data, load 1/2/4 bytes */
> +	emit_ldr(ctx, opsz, A64_R(0), A64_R(0), A64_ZR);
> +	if (sz !=3D sizeof(uint8_t))
> +		emit_be(ctx, A64_R(0), sz * CHAR_BIT);
> +	emit_mov_64(ctx, r0, A64_R(0));
> +}
> +

I would also pass final verdict on ARM code to ARM folks. To my untrained e=
ye
it looks correct apart from the signed immediate issue. Optimizations are
possible, but since we're only implementing slow path for now maybe not wor=
th
the effort.
