Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4563DC531C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 08:12:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46EF44028A;
	Thu, 23 Jul 2026 10:12:54 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 43B154027C;
 Thu, 23 Jul 2026 10:12:52 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oY+dOkOLJGDqb5OFqb6OcJJ+d0sBeVWw61hfYnD83cI=;
 b=TWdsVuX7WaW0rXXB3x/L+MNJefLEEvg8VVlTa4IyxcLcogMnBIXqk5UNkSI1VDyjlmfDHz6rX
 m5NNFVHF5zMDj5b+qyh87qn22zInHoug2512U2kf3TAXGqxN8ns91+4szsbRJ0WQ95/2MnO+vc/
 2mluuBlfSrUi8vptSpdMm8o=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h5P464PMWzHnH3M;
 Thu, 23 Jul 2026 16:12:22 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id 760B44058D;
 Thu, 23 Jul 2026 16:12:50 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Jul 2026 10:12:50 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 23 Jul 2026 10:12:50 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v7 10/10] bpf: fix uninitialized warning
Thread-Topic: [PATCH v7 10/10] bpf: fix uninitialized warning
Thread-Index: AQHdGgivLAw28xUq80Gw/e6G0cjev7Z6wYug
Date: Thu, 23 Jul 2026 08:12:50 +0000
Message-ID: <4df640855cca497699a244638a6a6ff9@huawei.com>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260722183351.633025-1-stephen@networkplumber.org>
 <20260722183351.633025-11-stephen@networkplumber.org>
In-Reply-To: <20260722183351.633025-11-stephen@networkplumber.org>
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
> Sent: Wednesday 22 July 2026 17:05
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Kons=
tantin Ananyev
> <konstantin.ananyev@huawei.com>; Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH v7 10/10] bpf: fix uninitialized warning
>=20
> Coverity complains uninitialized use of structure.
>=20
> Coverity issue: 504611
> Fixes: 17509d474226 ("bpf/validate: fix BPF_ADD of pointer to a scalar")
> Cc: stable@dpdk.org
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

Acked-by: Marat Khalili <marat.khalili@huawei.com>
