Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65B7CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:39:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F07ED402CC;
	Thu,  4 Jun 2026 17:39:55 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 6C7DD402B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 17:39:54 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWTJ25f03zHnGdN;
 Thu,  4 Jun 2026 23:38:58 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 892FA4058B;
 Thu,  4 Jun 2026 23:39:52 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 16:39:52 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 4 Jun 2026 16:39:52 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: RE: [PATCH 3/5] ring: use C11 for update_tail
Thread-Topic: [PATCH 3/5] ring: use C11 for update_tail
Thread-Index: AQHc8rN+g2eOaMYXukKPxvnnZXFd9LYuiiOQ
Date: Thu, 4 Jun 2026 15:39:52 +0000
Message-ID: <2dab6a8213b04883b9cab8adbdb9414e@huawei.com>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260602171552.686349-4-stephen@networkplumber.org>
In-Reply-To: <20260602171552.686349-4-stephen@networkplumber.org>
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



> The GCC builtin atomic special case is not needed for updating tail.
> The performance is the same with C11 memory model.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ring/rte_ring_c11_pvt.h  | 24 ------------------------
>  lib/ring/rte_ring_elem_pvt.h | 22 ++++++++++++++++++++++
>  lib/ring/rte_ring_gcc_pvt.h  | 25 -------------------------
>  3 files changed, 22 insertions(+), 49 deletions(-)
>=20
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20
> 2.53.0

