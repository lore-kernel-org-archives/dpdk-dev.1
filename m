Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11214C44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:55:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2518640270;
	Fri, 17 Jul 2026 11:55:37 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 448FF4014F
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:55:35 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=tmcZuZRwgiopb+6mkFPc2zJ+IVDDVwZbjCVSQDyrxGg=;
 b=0m9JoPVAtHH/RoV6xUu+WerinLKr5TMaog8a7K6f+gLvfysU7klFmuJ9bBu028bWuOdwxjGwa
 gZ5cfimjaV555w7NhYdEnkINjKgUvshbxZqZ5DJ8vZw1q+7no1NO7A1g7tZUvu1pU/+YxAfiqvO
 rR0C5fBtfDtPAqXwO1XMZEY=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h1ldg630KzJ468H;
 Fri, 17 Jul 2026 17:55:19 +0800 (CST)
Received: from dubpeml500003.china.huawei.com (unknown [7.214.146.145])
 by mail.maildlp.com (Postfix) with ESMTPS id 4057D40571;
 Fri, 17 Jul 2026 17:55:33 +0800 (CST)
Received: from dubpemt100001.china.huawei.com (7.214.147.107) by
 dubpeml500003.china.huawei.com (7.214.146.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jul 2026 10:55:32 +0100
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpemt100001.china.huawei.com (7.214.147.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jul 2026 10:55:32 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 17 Jul 2026 10:55:32 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [PATCH 03/10] hash: fix GFNI stubs export
Thread-Topic: [PATCH 03/10] hash: fix GFNI stubs export
Thread-Index: AQHdFc78e/P3Pxy8gEuCCUNnRcfE/bZxeGng
Date: Fri, 17 Jul 2026 09:55:32 +0000
Message-ID: <1f7a7b25ce57450eb0a97cb9f89dde37@huawei.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260717093006.229370-4-david.marchand@redhat.com>
In-Reply-To: <20260717093006.229370-4-david.marchand@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.200.209]
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
> Internal symbols *can not* be called as part of public ABI.
> The GFNI stubs must be exported so that an application may call them
> through the (inlined) GFNI API without requiring ALLOW_INTERNAL_API.
>=20
> Fixes: 944a03a5cfc1 ("hash: fix MSVC link on GFNI stubs")
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/hash/rte_thash_gfni.c | 4 ++--
>  lib/hash/rte_thash_gfni.h | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/hash/rte_thash_gfni.c b/lib/hash/rte_thash_gfni.c
> index 2003c7b3db..ae55f7f711 100644
> --- a/lib/hash/rte_thash_gfni.c
> +++ b/lib/hash/rte_thash_gfni.c
> @@ -13,7 +13,7 @@ RTE_LOG_REGISTER_SUFFIX(hash_gfni_logtype, gfni, INFO);
>  #define HASH_LOG(level, ...) \
>  	RTE_LOG_LINE(level, HASH, "" __VA_ARGS__)
>=20
> -RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_stub)
> +RTE_EXPORT_SYMBOL(rte_thash_gfni_stub)
>  uint32_t
>  rte_thash_gfni_stub(const uint64_t *mtrx __rte_unused,
>  	const uint8_t *key __rte_unused, int len __rte_unused)
> @@ -29,7 +29,7 @@ rte_thash_gfni_stub(const uint64_t *mtrx __rte_unused,
>  	return 0;
>  }
>=20
> -RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_bulk_stub)
> +RTE_EXPORT_SYMBOL(rte_thash_gfni_bulk_stub)
>  void
>  rte_thash_gfni_bulk_stub(const uint64_t *mtrx __rte_unused,
>  	int len __rte_unused, uint8_t *tuple[] __rte_unused,
> diff --git a/lib/hash/rte_thash_gfni.h b/lib/hash/rte_thash_gfni.h
> index e82378933c..8a72fa9ec6 100644
> --- a/lib/hash/rte_thash_gfni.h
> +++ b/lib/hash/rte_thash_gfni.h
> @@ -22,11 +22,9 @@ extern "C" {
>   * @internal
>   * Stubs only used when GFNI is not available.
>   */
> -__rte_internal
>  uint32_t
>  rte_thash_gfni_stub(const uint64_t *mtrx, const uint8_t *key, int len);
>=20
> -__rte_internal
>  void
>  rte_thash_gfni_bulk_stub(const uint64_t *mtrx, int len, uint8_t *tuple[]=
,
>  	uint32_t val[], uint32_t num);
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.54.0

