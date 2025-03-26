Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44948C3600E
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 09:20:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82AEA402DF;
	Wed, 26 Mar 2025 10:20:55 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id E2059402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 10:20:53 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZN1QX6Qzhz6L75v;
 Wed, 26 Mar 2025 17:17:24 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 3B7AA14080C;
 Wed, 26 Mar 2025 17:20:53 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Mar 2025 10:20:53 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 26 Mar 2025 10:20:53 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "david.marchand@redhat.com" <david.marchand@redhat.com>
Subject: RE: [PATCH v5 00/11] remove component-specific logic for AVX builds
Thread-Topic: [PATCH v5 00/11] remove component-specific logic for AVX builds
Thread-Index: AQHbnZ97QxYj0AOSU0SHKKtlVg4ylLOFJURw
Date: Wed, 26 Mar 2025 09:20:52 +0000
Message-ID: <915eef2ca6074baebe76f1b3321291c0@huawei.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250325160254.1724560-1-bruce.richardson@intel.com>
In-Reply-To: <20250325160254.1724560-1-bruce.richardson@intel.com>
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



> A number of libs and drivers had special optimized AVX2 and AVX512 code
> paths for performance reasons, and these tended to have copy-pasted
> logic to build those files. Centralise that logic in the main
> drivers/ and lib/ meson.build files to avoid duplication.
>=20
> v5: fix RTE_ARCH_X86 macro, which broke crc library
> v4: rebase on latest main branch
>     minor fixes following feedback
>     limit use of -march=3Dskylake-avx512 to when we don't already have a
>       -march flag supporting AVX512.
> v3: add patch for event/dlb2 AVX512 handling.
>     add common code for libraries as well as drivers.
> v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag
>=20
>=20
> Bruce Richardson (11):
>   drivers: add generalized AVX build handling
>   net/intel: use common AVX build code
>   drivers/net: build use common AVX handling
>   drivers/net: remove AVX2 build-time define
>   event/dlb2: build using common AVX handling
>   lib: add generalized AVX build handling
>   acl: use common AVX build handling
>   fib: use common AVX build handling
>   net: simplify build-time logic for x86
>   net: use common AVX512 build code
>   member: use common AVX512 build support
>=20
>  drivers/event/dlb2/dlb2_sse.c         |  4 ++
>  drivers/event/dlb2/meson.build        | 16 +-------
>  drivers/meson.build                   | 30 ++++++++++++++
>  drivers/net/bnxt/bnxt_ethdev.c        |  2 -
>  drivers/net/bnxt/meson.build          | 10 +----
>  drivers/net/enic/meson.build          | 10 +----
>  drivers/net/intel/i40e/meson.build    | 26 +-----------
>  drivers/net/intel/iavf/meson.build    | 25 +-----------
>  drivers/net/intel/ice/meson.build     | 25 +-----------
>  drivers/net/intel/idpf/meson.build    | 25 +-----------
>  drivers/net/nfp/meson.build           | 10 +----
>  drivers/net/octeon_ep/meson.build     | 13 +-----
>  drivers/net/octeon_ep/otx_ep_ethdev.c |  4 --
>  drivers/net/virtio/meson.build        |  9 +----
>  lib/acl/meson.build                   | 54 ++-----------------------
>  lib/fib/dir24_8.c                     |  6 +--
>  lib/fib/meson.build                   | 18 +--------
>  lib/fib/trie.c                        |  6 +--
>  lib/member/meson.build                | 46 ++++-----------------
>  lib/meson.build                       | 34 +++++++++++++++-
>  lib/net/meson.build                   | 58 +++------------------------
>  lib/net/rte_net_crc.c                 | 16 ++++----
>  22 files changed, 114 insertions(+), 333 deletions(-)
>=20
> --

Series-Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20

> 2.45.2

