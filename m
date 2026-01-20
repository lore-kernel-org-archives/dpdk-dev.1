Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6707D2ED0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 12:08:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4A7040268;
	Tue, 20 Jan 2026 13:08:12 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 690894013F;
 Tue, 20 Jan 2026 13:08:10 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwR0c0HZRzJ4673;
 Tue, 20 Jan 2026 20:07:44 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 7824D4056A;
 Tue, 20 Jan 2026 20:08:08 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 13:08:08 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 20 Jan 2026 13:08:08 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2 3/6] test: fix error handling in ELF load tests
Thread-Topic: [PATCH v2 3/6] test: fix error handling in ELF load tests
Thread-Index: AQHcibBNkHx0zcmyFUOjsYGcT/6XBrVa91qw
Date: Tue, 20 Jan 2026 12:08:08 +0000
Message-ID: <e01dd24362724225916416482410fff8@huawei.com>
References: <0260118201223.323024-1-stephen@networkplumber.org>
 <20260120015759.301155-1-stephen@networkplumber.org>
 <20260120015759.301155-4-stephen@networkplumber.org>
In-Reply-To: <20260120015759.301155-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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
> Sent: Tuesday 20 January 2026 01:55
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org
> Subject: [PATCH v2 3/6] test: fix error handling in ELF load tests
>=20
> Address related issues found during review
> - Add missing TEST_ASSERT for mempool creation in test_bpf_elf_tx_load
> - Initialize port variable in test_bpf_elf_rx_load to avoid undefined
>   behavior in cleanup path if null_vdev_setup fails early
>=20
> Fixes: cf1e03f881af ("test/bpf: add ELF loading")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_bpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index a7d56f8d86..0e969f9f13 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -3580,6 +3580,7 @@ test_bpf_elf_tx_load(void)
>  	mb_pool =3D rte_pktmbuf_pool_create("bpf_tx_test_pool", BPF_TEST_POOLSI=
ZE,
>  					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
>  					  SOCKET_ID_ANY);
> +	TEST_ASSERT(mb_pool !=3D NULL, "failed to create mempool");
>=20
>  	ret =3D null_vdev_setup(null_dev, &port, mb_pool);
>  	if (ret !=3D 0)
> @@ -3664,7 +3665,7 @@ test_bpf_elf_rx_load(void)
>  	static const char null_dev[] =3D "net_null_bpf0";
>  	struct rte_mempool *pool =3D NULL;
>  	char *tmpfile =3D NULL;
> -	uint16_t port;
> +	uint16_t port =3D UINT16_MAX;
>  	int ret;
>=20
>  	printf("%s start\n", __func__);
> --
> 2.51.0
>=20

Acked-by: Marat Khalili <marat.khalili@huawei.com>
