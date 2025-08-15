Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0068ACA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 13:50:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FB67402D9;
	Fri, 15 Aug 2025 15:50:13 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id E18774026C
 for <dev@dpdk.org>; Fri, 15 Aug 2025 15:50:11 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c3Nfg4fBjz2CgDH;
 Fri, 15 Aug 2025 21:45:47 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 3EA0C1400D4;
 Fri, 15 Aug 2025 21:50:08 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 21:50:08 +0800
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 21:50:06 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 15 Aug 2025 15:50:04 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 Chas Williams <3chas3@gmail.com>, "humin (Q)" <humin29@huawei.com>, "Yipeng
 Wang" <yipeng1.wang@intel.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v2 4/6] test: replace unnecessary comma operators
Thread-Topic: [PATCH v2 4/6] test: replace unnecessary comma operators
Thread-Index: AQHcDWKeY5ZI3N4z2Ea0R2hRk4Us0bRjvB9Q
Date: Fri, 15 Aug 2025 13:50:04 +0000
Message-ID: <be9570cba3fa402bbda0cd3fe1287ca4@huawei.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <20250814212901.88863-5-stephen@networkplumber.org>
In-Reply-To: <20250814212901.88863-5-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.146.251]
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


> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_compressdev.c          | 4 ++--
>  app/test/test_link_bonding_rssconf.c | 2 +-
>  app/test/test_thash.c                | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/app/test/test_compressdev.c b/app/test/test_compressdev.c
> index c217ad6cda..dcea8e2f30 100644
> --- a/app/test/test_compressdev.c
> +++ b/app/test/test_compressdev.c
> @@ -273,7 +273,7 @@ testsuite_setup(void)
>=20
>  	/* Initializes default values for compress/decompress xforms */
>  	ts_params->def_comp_xform->type =3D RTE_COMP_COMPRESS;
> -	ts_params->def_comp_xform->compress.algo =3D RTE_COMP_ALGO_DEFLATE,
> +	ts_params->def_comp_xform->compress.algo =3D RTE_COMP_ALGO_DEFLATE;
>  	ts_params->def_comp_xform->compress.deflate.huffman =3D
>  						RTE_COMP_HUFFMAN_DEFAULT;
>  	ts_params->def_comp_xform->compress.level =3D RTE_COMP_LEVEL_PMD_DEFAUL=
T;
> @@ -281,7 +281,7 @@ testsuite_setup(void)
>  	ts_params->def_comp_xform->compress.window_size =3D DEFAULT_WINDOW_SIZE=
;
>=20
>  	ts_params->def_decomp_xform->type =3D RTE_COMP_DECOMPRESS;
> -	ts_params->def_decomp_xform->decompress.algo =3D RTE_COMP_ALGO_DEFLATE,
> +	ts_params->def_decomp_xform->decompress.algo =3D RTE_COMP_ALGO_DEFLATE;
>  	ts_params->def_decomp_xform->decompress.chksum =3D RTE_COMP_CHECKSUM_NO=
NE;
>  	ts_params->def_decomp_xform->decompress.window_size =3D DEFAULT_WINDOW_=
SIZE;
>=20
> diff --git a/app/test/test_link_bonding_rssconf.c b/app/test/test_link_bo=
nding_rssconf.c
> index 2cb689b1de..693b0ccd12 100644
> --- a/app/test/test_link_bonding_rssconf.c
> +++ b/app/test/test_link_bonding_rssconf.c
> @@ -384,7 +384,7 @@ test_propagate(void)
>  		}
>=20
>  		memset(bond_rss_key, i, sizeof(bond_rss_key));
> -		bond_rss_conf.rss_hf =3D default_rss_hf,
> +		bond_rss_conf.rss_hf =3D default_rss_hf;
>  		bond_rss_conf.rss_key =3D bond_rss_key;
>  		bond_rss_conf.rss_key_len =3D 40;
>=20
> diff --git a/app/test/test_thash.c b/app/test/test_thash.c
> index 33b0c6adac..398db71839 100644
> --- a/app/test/test_thash.c
> +++ b/app/test/test_thash.c
> @@ -910,7 +910,7 @@ test_adjust_tuple_mult_reta(void)
>  {
>  	uint32_t i, j, np, nt;
>=20
> -	nt =3D 0, np =3D 0;
> +	nt =3D 0; np =3D 0;
>  	for (i =3D 0; i < CHAR_BIT; i++) {
>  		for (j =3D 6; j <=3D RTE_THASH_RETA_SZ_MAX - i; j++) {
>  			np +=3D (test_adjust_tuple_mb(j, i) =3D=3D 0);
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20

> 2.47.2

