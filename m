Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF07FEFB49
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 12:37:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CC2B402C5;
	Fri, 27 Feb 2026 13:37:21 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id AC65F4027F;
 Fri, 27 Feb 2026 13:37:20 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMnrh44nczJ46b5;
 Fri, 27 Feb 2026 20:36:52 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 1632E40575;
 Fri, 27 Feb 2026 20:37:19 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 13:37:18 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 27 Feb 2026 13:37:18 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, Yipeng Wang <yipeng1.wang@intel.com>, "Sameh
 Gobriel" <sameh.gobriel@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, Yerden Zhumabekov <e_zhumabekov@sts.kz>
Subject: RE: [PATCH v2] hash: fix pointer alignment
Thread-Topic: [PATCH v2] hash: fix pointer alignment
Thread-Index: AQHcp85Z+QkJ8zaO0UyA4Veo4uknt7WWb+Jg
Date: Fri, 27 Feb 2026 12:37:18 +0000
Message-ID: <3d39b27078014135969fe54ec6b79e97@huawei.com>
References: <20260226142206.860737-1-radu.nicolau@intel.com>
 <20260227094852.960180-1-radu.nicolau@intel.com>
In-Reply-To: <20260227094852.960180-1-radu.nicolau@intel.com>
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
> From: Radu Nicolau <radu.nicolau@intel.com>
> Sent: Friday 27 February 2026 09:48
> To: dev@dpdk.org
> Cc: Marat Khalili <marat.khalili@huawei.com>; Radu Nicolau <radu.nicolau@=
intel.com>; stable@dpdk.org;
> stephen@networkplumber.org; Yipeng Wang <yipeng1.wang@intel.com>; Sameh G=
obriel
> <sameh.gobriel@intel.com>; Bruce Richardson <bruce.richardson@intel.com>;=
 Vladimir Medvedkin
> <vladimir.medvedkin@intel.com>; Pablo de Lara <pablo.de.lara.guarch@intel=
.com>; Yerden Zhumabekov
> <e_zhumabekov@sts.kz>
> Subject: [PATCH v2] hash: fix pointer alignment
>=20
> rte_hash_crc assumes input pointer address is 8 byte aligned
> which may not be always the case.
> This fix aligns the input pointer before proceeding to process it
> in 8 byte chunks.
>=20
> Fixes: 504a29af13a7 ("hash: fix strict-aliasing for CRC")
> Cc: stable@dpdk.org
> Cc: stephen@networkplumber.org
>=20
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> ---
> v2: reverse the order of alignment adjustment calls
>=20
>  lib/hash/rte_hash_crc.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/lib/hash/rte_hash_crc.h b/lib/hash/rte_hash_crc.h
> index fa07c97685..d61420868a 100644
> --- a/lib/hash/rte_hash_crc.h
> +++ b/lib/hash/rte_hash_crc.h
> @@ -127,6 +127,24 @@ rte_hash_crc(const void *data, uint32_t data_len, ui=
nt32_t init_val)
>  	unsigned i;
>  	uintptr_t pd =3D (uintptr_t) data;
>=20
> +	/* align input to 8 byte boundary if needed */
> +	if ((pd & 0x7) && data_len >=3D 8) {
> +		uintptr_t unaligned_bytes =3D 8 - (pd & 0x7);
> +		data_len -=3D unaligned_bytes;
> +		if (unaligned_bytes & 0x1) {
> +			init_val =3D rte_hash_crc_1byte(*(const uint8_t *)pd, init_val);
> +			pd +=3D 1;
> +		}
> +		if (unaligned_bytes & 0x2) {
> +			init_val =3D rte_hash_crc_2byte(*(const uint16_t *)pd, init_val);
> +			pd +=3D 2;
> +		}
> +		if (unaligned_bytes & 0x4) {
> +			init_val =3D rte_hash_crc_4byte(*(const uint32_t *)pd, init_val);
> +			pd +=3D 4;
> +		}
> +	}
> +
>  	for (i =3D 0; i < data_len / 8; i++) {
>  		init_val =3D rte_hash_crc_8byte(*(const uint64_t *)pd, init_val);
>  		pd +=3D 8;
> --
> 2.52.0
>=20

Surprisingly, we do not seem to have any tests calling rte_hash_crc with mi=
saligned data. I tried to tweak existing ones in test_hash.c and test_hash_=
functions.c, and found out that rte_hash_crc still fails (with ubsan) for s=
izes less than 8 in one of the last 3 if's, and also that jhash has the sam=
e problems. Still this commit is a step in the right direction IMO, so:

Acked-by: Marat Khalili <marat.khalili@huawei.com>
