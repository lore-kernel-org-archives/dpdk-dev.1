Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4161DFA3748
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Jan 2026 14:54:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BF9D40267;
	Fri,  2 Jan 2026 15:54:54 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2149740262
 for <dev@dpdk.org>; Fri,  2 Jan 2026 15:54:53 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djRXh1PkNzJ467Z;
 Fri,  2 Jan 2026 22:53:56 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id CDD1B40565;
 Fri,  2 Jan 2026 22:54:51 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 15:54:51 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 2 Jan 2026 15:54:51 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Reshma Pattan
 <reshma.pattan@intel.com>, Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: RE: [PATCH v10 8/9] test: fix overflow warnings in common code
Thread-Topic: [PATCH v10 8/9] test: fix overflow warnings in common code
Thread-Index: AQHceQ7BwPBvNrGFl0iXCFVMz0X+ZrU+/RnQ
Date: Fri, 2 Jan 2026 14:54:51 +0000
Message-ID: <2b288f5b36c140b781f3578b6984b114@huawei.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
 <20251229220053.21981-9-stephen@networkplumber.org>
In-Reply-To: <20251229220053.21981-9-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday 29 December 2025 21:59
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Anatoly Burakov <anat=
oly.burakov@intel.com>;
> Reshma Pattan <reshma.pattan@intel.com>; Erik Gabriel Carrillo <erik.g.ca=
rrillo@intel.com>
> Subject: [PATCH v10 8/9] test: fix overflow warnings in common code
>=20
> Several tests lookup the current file prefix and
> format up a filename argument. Avoid any possible format
> overflows by allowing for bigger string.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_mp_secondary.c    | 14 ++++----------
>  app/test/test_pdump.c           | 13 ++++---------
>  app/test/test_timer_secondary.c | 12 ++++--------
>  3 files changed, 12 insertions(+), 27 deletions(-)
>=20
> diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
> index f3694530a8..fc295323f2 100644
> --- a/app/test/test_mp_secondary.c
> +++ b/app/test/test_mp_secondary.c
> @@ -67,17 +67,11 @@ run_secondary_instances(void)
>  {
>  	int ret =3D 0;
>  	char coremask[10];
> +	const char *prefix;
>=20
> -#ifdef RTE_EXEC_ENV_LINUX
> -	char tmp[PATH_MAX] =3D {0};
> -	char prefix[PATH_MAX] =3D {0};
> -
> -	get_current_prefix(tmp, sizeof(tmp));
> -
> -	snprintf(prefix, sizeof(prefix), "--file-prefix=3D%s", tmp);
> -#else
> -	const char *prefix =3D "";
> -#endif
> +	prefix =3D file_prefix_arg();
> +	if (prefix =3D=3D NULL)
> +		return -1;
>=20
>  	/* good case, using secondary */
>  	const char *argv1[] =3D {
> diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
> index 9f7769707e..cd044f0f69 100644
> --- a/app/test/test_pdump.c
> +++ b/app/test/test_pdump.c
> @@ -174,16 +174,11 @@ run_pdump_server_tests(void)
>  {
>  	int ret =3D 0;
>  	char coremask[10];
> +	const char *prefix;
>=20
> -#ifdef RTE_EXEC_ENV_LINUX
> -	char tmp[PATH_MAX] =3D { 0 };
> -	char prefix[PATH_MAX] =3D { 0 };
> -
> -	get_current_prefix(tmp, sizeof(tmp));
> -	snprintf(prefix, sizeof(prefix), "--file-prefix=3D%s", tmp);
> -#else
> -	const char *prefix =3D "";
> -#endif
> +	prefix =3D file_prefix_arg();
> +	if (prefix =3D=3D NULL)
> +		return -1;
>=20
>  	/* good case, using secondary */
>  	const char *const argv1[] =3D {
> diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_second=
ary.c
> index 4e220559b4..bd618b3cfc 100644
> --- a/app/test/test_timer_secondary.c
> +++ b/app/test/test_timer_secondary.c
> @@ -51,16 +51,12 @@ static int
>  timer_secondary_spawn_wait(unsigned int lcore)
>  {
>  	char coremask[10];
> -#ifdef RTE_EXEC_ENV_LINUXAPP
> -	char tmp[PATH_MAX] =3D {0};
> -	char prefix[PATH_MAX] =3D {0};
> +	const char *prefix;
>=20
> -	get_current_prefix(tmp, sizeof(tmp));
> +	prefix =3D file_prefix_arg();
> +	if (prefix =3D=3D NULL)
> +		return -1;
>=20
> -	snprintf(prefix, sizeof(prefix), "--file-prefix=3D%s", tmp);
> -#else
> -	const char *prefix =3D "";
> -#endif
>  	char const *argv[] =3D {
>  		prgname,
>  		"-c", coremask,
> --
> 2.51.0
>=20

Acked-by: Marat Khalili <marat.khalili@huawei.com>

(commit message looks slightly out of sync)
