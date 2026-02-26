Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12F0FD8FCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:22:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02F0A4065B;
	Thu, 26 Feb 2026 17:22:25 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id EF0FB40611;
 Thu, 26 Feb 2026 17:22:23 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMGts65GpzJ46F5;
 Fri, 27 Feb 2026 00:21:57 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id F08414056E;
 Fri, 27 Feb 2026 00:22:22 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Feb 2026 17:22:22 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 26 Feb 2026 17:22:22 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Radu Nicolau <radu.nicolau@intel.com>
CC: "stable@dpdk.org" <stable@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, Yipeng Wang <yipeng1.wang@intel.com>, "Sameh
 Gobriel" <sameh.gobriel@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, Yerden Zhumabekov <e_zhumabekov@sts.kz>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] hash: fix pointer alignment
Thread-Topic: [PATCH] hash: fix pointer alignment
Thread-Index: AQHcpytdzBNaIIJvLkyRWe9oM3I5BLWVJqiA
Date: Thu, 26 Feb 2026 16:22:22 +0000
Message-ID: <cc3138af2b6d4f4ebb806db04affd487@huawei.com>
References: <20260226142206.860737-1-radu.nicolau@intel.com>
In-Reply-To: <20260226142206.860737-1-radu.nicolau@intel.com>
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

> diff --git a/lib/hash/rte_hash_crc.h b/lib/hash/rte_hash_crc.h
> index fa07c97685..66f11fafcd 100644
> --- a/lib/hash/rte_hash_crc.h
> +++ b/lib/hash/rte_hash_crc.h
> @@ -127,6 +127,24 @@ rte_hash_crc(const void *data, uint32_t data_len, ui=
nt32_t init_val)
>  	unsigned i;
>  	uintptr_t pd =3D (uintptr_t) data;
>=20
> +	/* align input to 8 byte boundary if needed */
> +	if ((pd & 0x7) && data_len >=3D 8) {

Perhaps the case data_len < 8 should also be included, with each of the if'=
s below checking and correcting data_len individually?

> +		uintptr_t unaligned_bytes =3D 8 - (pd & 0x7);
> +		data_len -=3D unaligned_bytes;
> +		if (unaligned_bytes & 0x4) {
> +			init_val =3D rte_hash_crc_4byte(*(const uint32_t *)pd, init_val);
> +			pd +=3D 4;
> +		}
> +		if (unaligned_bytes & 0x2) {
> +			init_val =3D rte_hash_crc_2byte(*(const uint16_t *)pd, init_val);
> +			pd +=3D 2;
> +		}
> +		if (unaligned_bytes & 0x1) {
> +			init_val =3D rte_hash_crc_1byte(*(const uint8_t *)pd, init_val);
> +			pd +=3D 1;
> +		}

Shouldn't the order be the opposite?

> +	}
> +
>  	for (i =3D 0; i < data_len / 8; i++) {
>  		init_val =3D rte_hash_crc_8byte(*(const uint64_t *)pd, init_val);
>  		pd +=3D 8;
> --
> 2.52.0

