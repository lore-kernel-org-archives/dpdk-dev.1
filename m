Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767AAC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:22:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CDA5402E0;
	Wed,  1 Jul 2026 10:22:16 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id DAB8040278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 10:22:15 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gqtJm2mwtzHnGjg;
 Wed,  1 Jul 2026 16:21:28 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 3B68A4058D;
 Wed,  1 Jul 2026 16:22:14 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 1 Jul 2026 09:22:13 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 1 Jul 2026 09:22:13 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v2 8/8] doc: add release note about ip_frag changes
Thread-Topic: [PATCH v2 8/8] doc: add release note about ip_frag changes
Thread-Index: AQHdCKZ9eNxHI/x6WkyztoP/EaJUf7ZYUbDA
Date: Wed, 1 Jul 2026 08:22:13 +0000
Message-ID: <a4b12d72a06b447f83eda11742d0d801@huawei.com>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260630153723.525167-1-stephen@networkplumber.org>
 <20260630153723.525167-9-stephen@networkplumber.org>
In-Reply-To: <20260630153723.525167-9-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.146.116]
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



> The changes to ip_frag might impact some conformance or
> performance tests.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_07.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/doc/guides/rel_notes/release_26_07.rst
> b/doc/guides/rel_notes/release_26_07.rst
> index 4ca0a9ac77..a419803401 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -241,6 +241,12 @@ API Changes
>    - ``rte_pmd_mlx5_enable_steering``
>    - ``rte_pmd_mlx5_disable_steering``
>=20
> +* **ip_frag: hardened IP reassembly against malformed fragments.**
> +
> +  Duplicate, overlapping, oversized, and (for IPv6) per-fragment-header
> +  fragments are now rejected rather than mis-reassembled. This changes w=
hich
> +  fragment streams reassemble and may affect throughput.

That doesn't look entirely correct:
Current implementation doesn't allow both duplicate or overlapping fragment=
s either,
though it postpones it's detection till reassembly stage.
Might be something like that:
**ip_frag: hardened IP reassembly against malformed fragments.**

* Tolerate packets with duplicate fragments,
* Determine duplicate overlapping and oversized fragments at arrival. That =
change
   can cause multiple extra scans over already received fragments and might=
 affect
   overall system throughput. =20
?
=20

> +
>=20
>  ABI Changes
>  -----------
> --
> 2.53.0

