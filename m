Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8818CC83F27
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 14:32:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1279402F1;
	Wed, 16 Jul 2025 16:32:49 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id A06F14013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 16:32:48 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhz5N3R3mz6L5Fd;
 Wed, 16 Jul 2025 22:31:36 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 942FD1400D3;
 Wed, 16 Jul 2025 22:32:47 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Jul 2025 16:32:47 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 16 Jul 2025 16:32:47 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v4 18/22] net: fix IPv4 macro with highest bit
Thread-Topic: [PATCH v4 18/22] net: fix IPv4 macro with highest bit
Thread-Index: AQHb9lJElJvy0c1XiUWyK6H4hSPAXrQ00Ebw
Date: Wed, 16 Jul 2025 14:32:47 +0000
Message-ID: <3ff15d1ab41e4b809950bd57023acda9@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
 <20250716130212.1736407-19-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-19-david.marchand@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.33.251]
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



> Without an explicit type, all parameters of this macro are considered as
> a signed integer.
>=20
> ../app/test/test_fib.c:270:20: runtime error: left shift of
> 	128 by 24 places cannot be represented in type 'int'
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../app/test/test_fib.c:270:20 in
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/net/rte_ip4.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/net/rte_ip4.h b/lib/net/rte_ip4.h
> index d4b38c513c..822a660cfb 100644
> --- a/lib/net/rte_ip4.h
> +++ b/lib/net/rte_ip4.h
> @@ -65,10 +65,8 @@ struct __rte_aligned(2) __rte_packed_begin rte_ipv4_hd=
r {
>  } __rte_packed_end;
>=20
>  /** Create IPv4 address */
> -#define RTE_IPV4(a, b, c, d) ((uint32_t)(((a) & 0xff) << 24) | \
> -					   (((b) & 0xff) << 16) | \
> -					   (((c) & 0xff) << 8)  | \
> -					   ((d) & 0xff))
> +#define RTE_IPV4(a, b, c, d) (((uint32_t)((a) & 0xff) << 24) | ((uint32_=
t)((b) & 0xff) << 16) | \
> +	((uint32_t)((c) & 0xff) << 8) | ((uint32_t)((d) & 0xff)))
>=20
>  /** Maximal IPv4 packet length (including a header) */
>  #define RTE_IPV4_MAX_PKT_LEN        65535
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20

> 2.50.0

