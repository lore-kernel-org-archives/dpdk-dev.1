Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2D7CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 18:09:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82E5D40276;
	Wed, 17 Jun 2026 20:09:15 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 229A540268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 20:09:14 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ggX0v0T8ZzJ469l;
 Thu, 18 Jun 2026 02:08:47 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id 76AA140572;
 Thu, 18 Jun 2026 02:09:12 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 20:09:12 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 17 Jun 2026 20:09:11 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH 2/4] test: bpf check that JIT was generated
Thread-Topic: [PATCH 2/4] test: bpf check that JIT was generated
Thread-Index: AQHc94YUyguH/F5TR0a3ERIDBRBkTbZDGYZg
Date: Wed, 17 Jun 2026 18:09:11 +0000
Message-ID: <a91b7c7dc248440c8bbeea5572925b94@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260608203322.1116296-3-stephen@networkplumber.org>
In-Reply-To: <20260608203322.1116296-3-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.72.97]
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
> Sent: Monday 8 June 2026 21:29
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH 2/4] test: bpf check that JIT was generated
>=20
> Avoid silently ignoring JIT failures. The test cases should
> all succeed JIT compilation; if not it is a bug in the JIT
> implementation and should be reported.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_bpf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index dd24722450..79d547dc82 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -3508,6 +3508,14 @@ run_test(const struct bpf_test *tst)
>  				rv, strerror(rv));
>  		}
>  	}
> +#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)
> +	else {
> +		/* a JIT backend exists for this arch, so it must compile */
> +		printf("%s@%d: %s: no JIT code generated;\n",
> +			__func__, __LINE__, tst->name);
> +		ret =3D -1;
> +	}
> +#endif
>=20
>  	rte_bpf_destroy(bpf);
>  	return ret;
> --
> 2.53.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>
