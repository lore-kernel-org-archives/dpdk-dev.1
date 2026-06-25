Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEBFCDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:36:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A41C340616;
	Thu, 25 Jun 2026 17:36:01 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 4B7FA40430;
 Thu, 25 Jun 2026 17:36:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gmND64SybzHnH6k;
 Thu, 25 Jun 2026 23:35:18 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id 278E440584;
 Thu, 25 Jun 2026 23:35:53 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 25 Jun 2026 17:35:52 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 25 Jun 2026 17:35:52 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: RE: [PATCH v5 3/9] bpf: mask shift count in interpreter per RFC 9669
Thread-Topic: [PATCH v5 3/9] bpf: mask shift count in interpreter per RFC 9669
Thread-Index: AQHdBAMR4aKSNUBevkGa3qwABNTDzLZPZweg
Date: Thu, 25 Jun 2026 15:35:52 +0000
Message-ID: <d63c2e36ecde42a5b12e95244bf54f10@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260624175815.673064-1-stephen@networkplumber.org>
 <20260624175815.673064-4-stephen@networkplumber.org>
In-Reply-To: <20260624175815.673064-4-stephen@networkplumber.org>
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
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Kons=
tantin Ananyev
> <konstantin.ananyev@huawei.com>; Marat Khalili <marat.khalili@huawei.com>=
; Ferruh Yigit
> <ferruh.yigit@amd.com>
> Subject: [PATCH v5 3/9] bpf: mask shift count in interpreter per RFC 9669
>=20
> The interpreter shifted by the raw immediate or register value, which
> is undefined behavior in C when the count is >=3D the operand width and
> trips UBSan. RFC 9669 masks shift counts (0x3f for 64-bit, 0x1f for
> 32-bit); mask the count in the LSH/RSH/ARSH cases.
>=20
> Fixes: 94972f35a02e ("bpf: add BPF loading and execution framework")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Marat Khalili <marat.khalili@huawei.com>

> ---
>  lib/bpf/bpf_exec.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>=20
> diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
> index d423ef28f5..bb03c9cc2c 100644
> --- a/lib/bpf/bpf_exec.c
> +++ b/lib/bpf/bpf_exec.c
> @@ -4,6 +4,7 @@
>=20
>  #include <stdio.h>
>  #include <stdint.h>
> +#include <limits.h>
>=20
>  #include <eal_export.h>
>  #include <rte_common.h>
> @@ -43,6 +44,16 @@
>  	((reg)[(ins)->dst_reg] =3D \
>  		(type)(reg)[(ins)->dst_reg] op (type)(ins)->imm)
>=20
> +#define BPF_OP_SHIFT_IMM(reg, ins, op, type)	\
> +	((reg)[(ins)->dst_reg] =3D		\
> +		(type)(reg)[(ins)->dst_reg] op	\
> +		((ins)->imm & (sizeof(type) * CHAR_BIT - 1)))
> +
> +#define BPF_OP_SHIFT_REG(reg, ins, op, type)	\
> +	((reg)[(ins)->dst_reg] =3D		\
> +		(type)(reg)[(ins)->dst_reg] op	\
> +		((reg)[(ins)->src_reg] & (sizeof(type) * CHAR_BIT - 1)))
> +
>  #define BPF_DIV_ZERO_CHECK(bpf, reg, ins, type) do { \
>  	if ((type)(reg)[(ins)->src_reg] =3D=3D 0) { \
>  		RTE_BPF_LOG_LINE(ERR, \
> @@ -183,10 +194,10 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EB=
PF_REG_NUM])
>  			BPF_OP_ALU_IMM(reg, ins, |, uint32_t);
>  			break;
>  		case (BPF_ALU | BPF_LSH | BPF_K):
> -			BPF_OP_ALU_IMM(reg, ins, <<, uint32_t);
> +			BPF_OP_SHIFT_IMM(reg, ins, <<, uint32_t);
>  			break;
>  		case (BPF_ALU | BPF_RSH | BPF_K):
> -			BPF_OP_ALU_IMM(reg, ins, >>, uint32_t);
> +			BPF_OP_SHIFT_IMM(reg, ins, >>, uint32_t);
>  			break;
>  		case (BPF_ALU | BPF_XOR | BPF_K):
>  			BPF_OP_ALU_IMM(reg, ins, ^, uint32_t);
> @@ -217,10 +228,10 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EB=
PF_REG_NUM])
>  			BPF_OP_ALU_REG(reg, ins, |, uint32_t);
>  			break;
>  		case (BPF_ALU | BPF_LSH | BPF_X):
> -			BPF_OP_ALU_REG(reg, ins, <<, uint32_t);
> +			BPF_OP_SHIFT_REG(reg, ins, <<, uint32_t);
>  			break;
>  		case (BPF_ALU | BPF_RSH | BPF_X):
> -			BPF_OP_ALU_REG(reg, ins, >>, uint32_t);
> +			BPF_OP_SHIFT_REG(reg, ins, >>, uint32_t);
>  			break;
>  		case (BPF_ALU | BPF_XOR | BPF_X):
>  			BPF_OP_ALU_REG(reg, ins, ^, uint32_t);
> @@ -262,13 +273,13 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EB=
PF_REG_NUM])
>  			BPF_OP_ALU_IMM(reg, ins, |, uint64_t);
>  			break;
>  		case (EBPF_ALU64 | BPF_LSH | BPF_K):
> -			BPF_OP_ALU_IMM(reg, ins, <<, uint64_t);
> +			BPF_OP_SHIFT_IMM(reg, ins, <<, uint64_t);
>  			break;
>  		case (EBPF_ALU64 | BPF_RSH | BPF_K):
> -			BPF_OP_ALU_IMM(reg, ins, >>, uint64_t);
> +			BPF_OP_SHIFT_IMM(reg, ins, >>, uint64_t);
>  			break;
>  		case (EBPF_ALU64 | EBPF_ARSH | BPF_K):
> -			BPF_OP_ALU_IMM(reg, ins, >>, int64_t);
> +			BPF_OP_SHIFT_IMM(reg, ins, >>, int64_t);
>  			break;
>  		case (EBPF_ALU64 | BPF_XOR | BPF_K):
>  			BPF_OP_ALU_IMM(reg, ins, ^, uint64_t);
> @@ -299,13 +310,13 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EB=
PF_REG_NUM])
>  			BPF_OP_ALU_REG(reg, ins, |, uint64_t);
>  			break;
>  		case (EBPF_ALU64 | BPF_LSH | BPF_X):
> -			BPF_OP_ALU_REG(reg, ins, <<, uint64_t);
> +			BPF_OP_SHIFT_REG(reg, ins, <<, uint64_t);
>  			break;
>  		case (EBPF_ALU64 | BPF_RSH | BPF_X):
> -			BPF_OP_ALU_REG(reg, ins, >>, uint64_t);
> +			BPF_OP_SHIFT_REG(reg, ins, >>, uint64_t);
>  			break;
>  		case (EBPF_ALU64 | EBPF_ARSH | BPF_X):
> -			BPF_OP_ALU_REG(reg, ins, >>, int64_t);
> +			BPF_OP_SHIFT_REG(reg, ins, >>, int64_t);
>  			break;
>  		case (EBPF_ALU64 | BPF_XOR | BPF_X):
>  			BPF_OP_ALU_REG(reg, ins, ^, uint64_t);
> --
> 2.53.0

