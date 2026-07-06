Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28263C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:18:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F69440691;
	Mon,  6 Jul 2026 14:18:38 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9936E402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 14:18:37 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gv3Jt3ynjzHnGkb;
 Mon,  6 Jul 2026 20:17:34 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id AA4D340584;
 Mon,  6 Jul 2026 20:18:30 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 6 Jul 2026 14:18:30 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 6 Jul 2026 14:18:30 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH] bpf: fix unitialized warning
Thread-Topic: [PATCH] bpf: fix unitialized warning
Thread-Index: AQHdC2oUvjEu7+lKHk+ausG2Xg6spLZgZYSg
Date: Mon, 6 Jul 2026 12:18:30 +0000
Message-ID: <67f42e00b18c4f2fbcd7fadb91ded146@huawei.com>
References: <20260704040322.157058-1-stephen@networkplumber.org>
In-Reply-To: <20260704040322.157058-1-stephen@networkplumber.org>
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
> Sent: Saturday 4 July 2026 05:03
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH] bpf: fix unitialized warning
>=20
> Coverity complains unitialized use of structure.
>=20
> Coverity ID: 504611
> Fixes: 17509d474226 ("bpf/validate: fix BPF_ADD of pointer to a scalar")
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_validate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
> index f9960088a2..44db85a5a3 100644
> --- a/lib/bpf/bpf_validate.c
> +++ b/lib/bpf/bpf_validate.c
> @@ -659,7 +659,7 @@ eval_apply_mask(struct bpf_reg_val *rv, uint64_t mask=
)
>  static void
>  eval_add(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, uint64_t =
msk)
>  {
> -	struct bpf_reg_val rs_buf;
> +	struct bpf_reg_val rs_buf =3D { 0 };
>  	struct bpf_reg_val rv;
>=20
>  	if (RTE_BPF_ARG_PTR_TYPE(rs->v.type) !=3D 0) {
> --
> 2.53.0

The bug is real. Based on the intended meaning should then be:

	struct bpf_reg_val rs_buf =3D { .v.type =3D RTE_BPF_ARG_RAW };

Setting type to 0 (RTE_BPF_ARG_UNDEF) is too harsh disallowing even reading=
,
while we only want to disallow dereferencing the result.

(Unfortunately, this whole dimension is still a massive TODO, this check is=
 not
even present on other ALU operations, and neither do sanitized tests pass w=
hich
would catch this problem earlier.)
