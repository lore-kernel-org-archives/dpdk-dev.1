Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF85D7237B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 11:56:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AD46402EA;
	Fri, 23 Jan 2026 12:56:13 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id ADC3540269;
 Fri, 23 Jan 2026 12:56:11 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyGbK2Gk5zJ468V;
 Fri, 23 Jan 2026 19:55:41 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id A2B2B40585;
 Fri, 23 Jan 2026 19:56:10 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 23 Jan 2026 12:56:10 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 23 Jan 2026 12:56:10 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3 08/14] test/bpf: skip ELF test if null PMD disabled
Thread-Topic: [PATCH v3 08/14] test/bpf: skip ELF test if null PMD disabled
Thread-Index: AQHcizmqchikFzC6hEmiNifNQ+DyALVfpx1g
Date: Fri, 23 Jan 2026 11:56:10 +0000
Message-ID: <c4ea2daeaac6418cb48a4ae28c78e6b9@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
 <20260122005356.1168221-9-stephen@networkplumber.org>
In-Reply-To: <20260122005356.1168221-9-stephen@networkplumber.org>
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
> Sent: Thursday 22 January 2026 00:50
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Kons=
tantin Ananyev
> <konstantin.ananyev@huawei.com>; Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH v3 08/14] test/bpf: skip ELF test if null PMD disabled
>=20
> If null PMD is disabled, the test to load filter can not work
> because it uses that. Change to skip the test if setup fails.
>=20
> Fixes: 81038845c90b ("test/bpf: add Rx and Tx filtering")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_bpf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 0e969f9f13..8bf783c00c 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -3441,7 +3441,11 @@ static int null_vdev_setup(const char *name, uint1=
6_t *port, struct rte_mempool
>=20
>  	/* Make a null device */
>  	ret =3D rte_vdev_init(name, NULL);
> -	TEST_ASSERT(ret =3D=3D 0, "rte_vdev_init(%s) failed: %d", name, ret);
> +	if (ret !=3D 0) {
> +		printf("rte_vdev_init(%s) failed: %d:%s\n",
> +		       name, ret, strerror(-ret));
> +		return -ENOTSUP;
> +	}
>=20
>  	ret =3D rte_eth_dev_get_port_by_name(name, port);
>  	TEST_ASSERT(ret =3D=3D 0, "failed to get port id for %s: %d", name, ret=
);
> --
> 2.51.0

I know there are multiple approaches considered, but this one is ok as well=
.

However, I would only return -ENOTSUP if we _know_ null PMD is disabled, no=
t
if it just failed to initialize.
