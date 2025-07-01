Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9EEC83033
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 08:36:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43D6240269;
	Tue,  1 Jul 2025 10:36:25 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 25CBB400D7;
 Tue,  1 Jul 2025 10:36:23 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWbs76fdwz6L4y6;
 Tue,  1 Jul 2025 16:33:31 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id C8A3614011A;
 Tue,  1 Jul 2025 16:36:21 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Jul 2025 10:36:21 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 1 Jul 2025 10:36:21 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Yipeng Wang <yipeng1.wang@intel.com>, 
 Sameh Gobriel <sameh.gobriel@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, John McNamara <john.mcnamara@intel.com>
Subject: RE: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
Thread-Topic: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
Thread-Index: AQHb5EY+uzNGJsGlUUGvOTO5dcxbU7Qc/Vpg
Date: Tue, 1 Jul 2025 08:36:21 +0000
Message-ID: <70c7ba78c4324495bfd317e38e926958@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-9-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-9-david.marchand@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
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



> Caught by UBSan:
>=20
> ../lib/hash/rte_thash.c:421:8: runtime error: load of misaligned address
> 	0x0001816c2da3 for type 'uint32_t' (aka 'unsigned int'),
> 	which requires 4 byte alignment
>=20
> Fixes: 28ebff11c2dc ("hash: add predictable RSS")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/hash/rte_thash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
> index 6c662bf14f..6d4dbea6d7 100644
> --- a/lib/hash/rte_thash.c
> +++ b/lib/hash/rte_thash.c
> @@ -415,10 +415,10 @@ generate_subkey(struct rte_thash_ctx *ctx, struct t=
hash_lfsr *lfsr,
>  static inline uint32_t
>  get_subvalue(struct rte_thash_ctx *ctx, uint32_t offset)
>  {
> -	uint32_t *tmp, val;
> +	uint32_t tmp, val;
>=20
> -	tmp =3D (uint32_t *)(&ctx->hash_key[offset >> 3]);
> -	val =3D rte_be_to_cpu_32(*tmp);
> +	memcpy(&tmp, &ctx->hash_key[offset >> 3], sizeof(tmp));
> +	val =3D rte_be_to_cpu_32(tmp);

Just wonder do you guys consider it as a real one?
AFAIK, all architectures that we care about do support unaligned load for 3=
2-bit integers.

>  	val >>=3D (TOEPLITZ_HASH_LEN - ((offset & (CHAR_BIT - 1)) +
>  		ctx->reta_sz_log));
>=20
> --
> 2.49.0
>=20

