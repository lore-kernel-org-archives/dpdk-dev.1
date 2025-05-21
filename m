Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDE6C54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 11:43:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D5E1427BF;
	Wed, 21 May 2025 13:43:03 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id CD327427BC
 for <dev@dpdk.org>; Wed, 21 May 2025 13:43:02 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2Tv63xSXz6DB54;
 Wed, 21 May 2025 19:38:10 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id E5B3B1400F4;
 Wed, 21 May 2025 19:43:01 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 13:43:01 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 21 May 2025 13:43:01 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: "Rui Ferreira (A)" <rui.ferreira1@h-partners.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] eal/linux: unregister alarm callback before free ptr
Thread-Topic: [PATCH] eal/linux: unregister alarm callback before free ptr
Thread-Index: AQHbyZkX8uuilrj/CUSHVCEWtWVby7Pc9vTQ
Date: Wed, 21 May 2025 11:43:01 +0000
Message-ID: <462157df1f3742f7abd20ee27067c53b@huawei.com>
References: <20250520160150.50401-1-rui.ferreira1@h-partners.com>
In-Reply-To: <20250520160150.50401-1-rui.ferreira1@h-partners.com>
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



> Subject: [PATCH] eal/linux: unregister alarm callback before free ptr
>=20
> This was flagged by Address sanitizer as a use after free. The
> intr_handle ptr is shared between the main thread and the interrupt
> thread, and the interrupt thread can dereference the ptr after free
> is called when the main thread cleans up (from the alarm callback).
>=20
> The interrupt thread never terminates (eal_intr_thread_main) so
> use rte_intr_callback_unregister_sync during cleanup to
> ensure the callback is removed before freeing the ptr.
>=20
> To be more defensive clear out the pointer and registration
> variable if we can unregister.
>=20
> Bugzilla ID: 1683
>=20
> Signed-off-by: Rui Ferreira <rui.ferreira1@h-partners.com>
> ---
>  .mailmap                  | 1 +
>  lib/eal/linux/eal_alarm.c | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index d8439b79ce..907c5ea967 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1332,6 +1332,7 @@ Rosen Xu <rosen.xu@altera.com> <rosen.xu@intel.com>
>  Roy Franz <roy.franz@cavium.com>
>  Roy Pledge <roy.pledge@nxp.com>
>  Roy Shterman <roy.shterman@vastdata.com>
> +Rui Ferreira <rui.ferreira1@h-partners.com>
>  Ruifeng Wang <ruifeng.wang@arm.com>
>  Rushil Gupta <rushilg@google.com>
>  Ryan E Hall <ryan.e.hall@intel.com>
> diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
> index b216a007a3..eb6a21d4f0 100644
> --- a/lib/eal/linux/eal_alarm.c
> +++ b/lib/eal/linux/eal_alarm.c
> @@ -57,7 +57,14 @@ static void eal_alarm_callback(void *arg);
>  void
>  rte_eal_alarm_cleanup(void)
>  {
> -	rte_intr_instance_free(intr_handle);
> +	/* unregister callback using intr_handle in interrupt thread */
> +	int ret =3D rte_intr_callback_unregister_sync(intr_handle,
> +						eal_alarm_callback, (void *)-1);
> +	if (ret >=3D 0) {
> +		rte_intr_instance_free(intr_handle);
> +		intr_handle =3D NULL;
> +		handler_registered =3D 0;
> +	}
>  }
>=20
>  int
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

As a nit: as it is a bug-fix, probably start with 'fix ..' in the subject.
Also "Fixes:" and probably " Cc: stable@dpdk.org" needs to be added.

> 2.35.3

