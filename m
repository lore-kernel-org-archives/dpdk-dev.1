Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7968FEFB6C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 15:55:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B92FF402EE;
	Fri, 27 Feb 2026 16:55:33 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 2BE4C402C5;
 Fri, 27 Feb 2026 16:55:31 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMtFN2z4kzJ46C6;
 Fri, 27 Feb 2026 23:55:04 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 2A4A74056E;
 Fri, 27 Feb 2026 23:55:31 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 27 Feb 2026 16:55:30 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 27 Feb 2026 16:55:30 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, Yipeng Wang <yipeng1.wang@intel.com>, "Sameh
 Gobriel" <sameh.gobriel@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Yerden Zhumabekov <e_zhumabekov@sts.kz>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: RE: [PATCH v3] hash: fix pointer alignment
Thread-Topic: [PATCH v3] hash: fix pointer alignment
Thread-Index: AQHcp/GcuIFYrDx3p0GTPqsMdHbnd7WWr+5g
Date: Fri, 27 Feb 2026 15:55:30 +0000
Message-ID: <ea247161a37544bdab12060c4fe1180c@huawei.com>
References: <20260226142206.860737-1-radu.nicolau@intel.com>
 <20260227140128.1083814-1-radu.nicolau@intel.com>
In-Reply-To: <20260227140128.1083814-1-radu.nicolau@intel.com>
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
> Sent: Friday 27 February 2026 14:00
> To: dev@dpdk.org
> Cc: Marat Khalili <marat.khalili@huawei.com>; Radu Nicolau <radu.nicolau@=
intel.com>; stable@dpdk.org;
> stephen@networkplumber.org; Yipeng Wang <yipeng1.wang@intel.com>; Sameh G=
obriel
> <sameh.gobriel@intel.com>; Bruce Richardson <bruce.richardson@intel.com>;=
 Vladimir Medvedkin
> <vladimir.medvedkin@intel.com>; Yerden Zhumabekov <e_zhumabekov@sts.kz>; =
Pablo de Lara
> <pablo.de.lara.guarch@intel.com>
> Subject: [PATCH v3] hash: fix pointer alignment
>=20
> rte_hash_crc assumes input pointer address is 8 byte aligned
> which may not be always the case.
> This fix aligns the input pointer before proceeding to process it
> in 8 byte chunks.
>=20
> Bugzilla ID: 1892
> Fixes: 504a29af13a7 ("hash: fix strict-aliasing for CRC")
> Cc: stable@dpdk.org
> Cc: stephen@networkplumber.org
>=20
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> ---
> v3: revert alignment code to simple loop, it was getting too complex for =
a corner case
>=20
>=20
>  lib/hash/rte_hash_crc.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/lib/hash/rte_hash_crc.h b/lib/hash/rte_hash_crc.h
> index fa07c97685..f60f4598d8 100644
> --- a/lib/hash/rte_hash_crc.h
> +++ b/lib/hash/rte_hash_crc.h
> @@ -127,6 +127,16 @@ rte_hash_crc(const void *data, uint32_t data_len, ui=
nt32_t init_val)
>  	unsigned i;
>  	uintptr_t pd =3D (uintptr_t) data;
>=20
> +	/* align input to 8 byte boundary if needed */
> +	if (pd & 0x7) {
> +		unsigned int unaligned_bytes =3D RTE_MIN(8 - (pd & 0x7), data_len);
> +		for (i =3D 0; i < unaligned_bytes; i++) {
> +			init_val =3D rte_hash_crc_1byte(*(const uint8_t *)pd, init_val);
> +			pd++;
> +			data_len--;
> +		}
> +	}
> +
>  	for (i =3D 0; i < data_len / 8; i++) {
>  		init_val =3D rte_hash_crc_8byte(*(const uint64_t *)pd, init_val);
>  		pd +=3D 8;
> --
> 2.52.0
>=20

My custom checks now pass even for small inputs.

(I also support the idea to simplify it to a single loop, until we have act=
ual
benchmarks showing that some alternative is better. Same for many possible =
ways
to simplify if and/or for condition.)

Acked-by: Marat Khalili <marat.khalili@huawei.com>
Tested-by: Marat Khalili <marat.khalili@huawei.com>
