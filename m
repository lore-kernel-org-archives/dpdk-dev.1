Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD5DC8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:18:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C25E40264;
	Mon, 30 Jun 2025 13:18:22 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 827904025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 13:18:20 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bW3VX5V0qz6L5LW;
 Mon, 30 Jun 2025 19:15:32 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id 21051140370;
 Mon, 30 Jun 2025 19:18:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 13:18:19 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 30 Jun 2025 13:18:19 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 1/2] doc/eal: add doc entry for service core list flag
Thread-Topic: [PATCH 1/2] doc/eal: add doc entry for service core list flag
Thread-Index: AQHb5QzKiyl9m0AW5ky03ybYx8C1bbQblyKA
Date: Mon, 30 Jun 2025 11:18:19 +0000
Message-ID: <bb1e7f510b7e4e23a6487b45b233a969@huawei.com>
References: <20250624133409.550372-1-bruce.richardson@intel.com>
 <20250624133409.550372-2-bruce.richardson@intel.com>
In-Reply-To: <20250624133409.550372-2-bruce.richardson@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.148.141]
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



>=20
> In the list of EAL arguments, only the "-s" flag for service cores was
> documented. Add an entry for the "-S" one too, which takes a core list
> instead of a core mask.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/linux_gsg/eal_args.include.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux=
_gsg/eal_args.include.rst
> index 359721eb6a..6ee79877c1 100644
> --- a/doc/guides/linux_gsg/eal_args.include.rst
> +++ b/doc/guides/linux_gsg/eal_args.include.rst
> @@ -79,6 +79,11 @@ Lcore-related options
>=20
>      Hexadecimal bitmask of cores to be used as service cores.
>=20
> +*   ``-S <service core list>``
> +
> +    List of cores to be used as service cores.
> +
> +
>  Device-related options
>  ~~~~~~~~~~~~~~~~~~~~~~
>=20
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20

> 2.48.1

