Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185A1C8302B
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 15:25:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5259A4068A;
	Mon, 30 Jun 2025 17:25:05 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 4103240685;
 Mon, 30 Jun 2025 17:25:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bW9233Yktz6DKwy;
 Mon, 30 Jun 2025 23:24:43 +0800 (CST)
Received: from frapeml100004.china.huawei.com (unknown [7.182.85.167])
 by mail.maildlp.com (Postfix) with ESMTPS id 4C7631404C5;
 Mon, 30 Jun 2025 23:25:03 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 17:25:03 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Mon, 30 Jun 2025 17:25:03 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: RE: [PATCH v2 06/10] cmdline: fix highest bit port list parsing
Thread-Topic: [PATCH v2 06/10] cmdline: fix highest bit port list parsing
Thread-Index: AQHb5Eb19MxkTvvP7UOaMKFOReL+ULQb3Qgg
Date: Mon, 30 Jun 2025 15:25:02 +0000
Message-ID: <77747107b5ab4f048fd3568899a09052@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-7-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-7-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.64]
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
> From: David Marchand <david.marchand@redhat.com>
> Sent: Monday 23 June 2025 14:53
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Bruce Richardson <bruce.richardson@intel.com>
> Subject: [PATCH v2 06/10] cmdline: fix highest bit port list parsing
>=20
> pl->map is a uint32_t.
>=20
> Caught by UBSan:
>=20
> ../lib/cmdline/cmdline_parse_portlist.c:27:17: runtime error:
> 	left shift of 1 by 31 places cannot be represented in type 'int'
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/cmdline/cmdline_parse_portlist.c:27:17 in
>=20
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> Changes since v1:
> - moved variable increment out of the macro call,
>=20
> ---
>  lib/cmdline/cmdline_parse_portlist.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/cmdline/cmdline_parse_portlist.c
> b/lib/cmdline/cmdline_parse_portlist.c
> index 549f6d9671..3efe4143e3 100644
> --- a/lib/cmdline/cmdline_parse_portlist.c
> +++ b/lib/cmdline/cmdline_parse_portlist.c
> @@ -10,7 +10,9 @@
>  #include <errno.h>
>=20
>  #include <eal_export.h>
> +#include <rte_bitops.h>
>  #include <rte_string_fns.h>
> +
>  #include "cmdline_parse.h"
>  #include "cmdline_parse_portlist.h"
>=20
> @@ -26,7 +28,8 @@ static void
>  parse_set_list(cmdline_portlist_t *pl, size_t low, size_t high)
>  {
>  	do {
> -		pl->map |=3D (1 << low++);
> +		pl->map |=3D RTE_BIT32(low);
> +		low++;
>  	} while (low <=3D high);
>  }

Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
