Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E09CC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:42:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6647040279;
	Wed,  1 Jul 2026 18:42:25 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D39E840278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 18:42:23 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gr5Pn534czJ46Ck;
 Thu,  2 Jul 2026 00:41:33 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 2D65540572;
 Thu,  2 Jul 2026 00:42:22 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 1 Jul 2026 17:42:21 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 1 Jul 2026 17:42:21 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v3 8/8] doc: add release note about ip_frag changes
Thread-Topic: [PATCH v3 8/8] doc: add release note about ip_frag changes
Thread-Index: AQHdCXXSvaz3PhWCnk29g9mJjIvoobZY3gyQ
Date: Wed, 1 Jul 2026 16:42:21 +0000
Message-ID: <61a1b5ab6e0845079a3f42aaf185c7c0@huawei.com>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260701162127.207318-1-stephen@networkplumber.org>
 <20260701162127.207318-9-stephen@networkplumber.org>
In-Reply-To: <20260701162127.207318-9-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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



> These changes maybe surprising and need some documentation.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_07.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/doc/guides/rel_notes/release_26_07.rst
> b/doc/guides/rel_notes/release_26_07.rst
> index 4ca0a9ac77..4918cb59ed 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -241,6 +241,16 @@ API Changes
>    - ``rte_pmd_mlx5_enable_steering``
>    - ``rte_pmd_mlx5_disable_steering``
>=20
> +* **ip_frag: changed handling of malformed fragments.**
> +
> +  - Duplicate fragments are tolerated instead of failing reassembly.
> +  - Overlapping fragments are rejected on arrival rather than during rea=
ssembly.
> +  - Oversized fragments (reassembled length over 65535) are rejected.
> +  - For IPv6, fragments with per-fragment extension headers are rejected=
.
> +
> +  Overlap and oversize are now detected on arrival, which adds a scan of=
 the
> +  already received fragments per fragment and may affect throughput.
> +
>=20
>  ABI Changes
>  -----------
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

