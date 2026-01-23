Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF057D7237D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 11:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3246D4026F;
	Fri, 23 Jan 2026 12:50:28 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 329F940269;
 Fri, 23 Jan 2026 12:50:27 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyGSY23ZXzHnGcp;
 Fri, 23 Jan 2026 19:49:49 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id DFEA840571;
 Fri, 23 Jan 2026 19:50:26 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Jan 2026 12:50:26 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 23 Jan 2026 12:50:26 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v3 14/14] test/bpf: pass correct size for Rx/Tx load tests
Thread-Topic: [PATCH v3 14/14] test/bpf: pass correct size for Rx/Tx load tests
Thread-Index: AQHcizmy+PrPRbnfckmPovgxggBe7LVfpDWg
Date: Fri, 23 Jan 2026 11:50:26 +0000
Message-ID: <88a8da148da34f06bfe23469cf8e469e@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
 <20260122005356.1168221-15-stephen@networkplumber.org>
In-Reply-To: <20260122005356.1168221-15-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
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
> Sent: Thursday 22 January 2026 00:51
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Mara=
t Khalili
> <marat.khalili@huawei.com>; Konstantin Ananyev <konstantin.ananyev@huawei=
.com>
> Subject: [PATCH v3 14/14] test/bpf: pass correct size for Rx/Tx load test=
s
>=20
> Use the correct size in bpf_prm to help with validation.
>=20
> Fixes: 81038845c90b ("test/bpf: add Rx and Tx filtering")
> Cc: stable@dpdk.org
>=20
> Suggested-by: Marat Khalili <marat.khalili@huawei.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_bpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 8bf783c00c..bf92bc545c 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -3533,7 +3533,7 @@ static int bpf_tx_test(uint16_t port, const char *t=
mpfile, struct rte_mempool *p
>  	const struct rte_bpf_prm prm =3D {
>  		.prog_arg =3D {
>  			.type =3D RTE_BPF_ARG_PTR,
> -			.size =3D sizeof(struct rte_mbuf),
> +			.size =3D sizeof(struct dummy_net),
>  		},
>  	};
>  	int ret;
> @@ -3632,7 +3632,7 @@ static int bpf_rx_test(uint16_t port, const char *t=
mpfile, struct rte_mempool *p
>  	const struct rte_bpf_prm prm =3D {
>  		.prog_arg =3D {
>  			.type =3D RTE_BPF_ARG_PTR,
> -			.size =3D sizeof(struct rte_mbuf),
> +			.size =3D sizeof(struct dummy_net),
>  		},
>  	};
>  	int ret;
> --
> 2.51.0

Thank you for fixing this. Not sure we actually have VLAN tag there, but it=
 is
less misleading now in any case.

Acked-by: Marat Khalili <marat.khalili@huawei.com>
