Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4407FCD6E6D
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:41:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A34D8402CC;
	Thu,  4 Jun 2026 17:41:07 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 26810402B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 17:41:07 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWTLR1J1jzJ469b;
 Thu,  4 Jun 2026 23:41:03 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id E561840570;
 Thu,  4 Jun 2026 23:41:06 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 16:41:06 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 4 Jun 2026 16:41:06 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: RE: [PATCH 5/5] ring: use C11 for single thread move head
Thread-Topic: [PATCH 5/5] ring: use C11 for single thread move head
Thread-Index: AQHc8rN++uapGXizH0aDLlhoF8rujrYui5qw
Date: Thu, 4 Jun 2026 15:41:06 +0000
Message-ID: <9877daf66a9e4baa9a5799b2711f3622@huawei.com>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260602171552.686349-6-stephen@networkplumber.org>
In-Reply-To: <20260602171552.686349-6-stephen@networkplumber.org>
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



> The function to move head for single threaded case can always
> use the C11 code, there is no performance difference from GCC
> intrinsics.
>=20
> This reduces the exception code to just one function.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ring/rte_ring_c11_pvt.h  | 62 ------------------------------
>  lib/ring/rte_ring_elem_pvt.h | 74 +++++++++++++++++++++++++++++++++---
>  lib/ring/rte_ring_gcc_pvt.h  | 59 ----------------------------
>  3 files changed, 68 insertions(+), 127 deletions(-)
>=20

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> --
> 2.53.0

