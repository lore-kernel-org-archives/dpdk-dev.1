Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0C6FA374B
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Jan 2026 14:47:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4FBD40267;
	Fri,  2 Jan 2026 15:47:35 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 5104940262;
 Fri,  2 Jan 2026 15:47:34 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djRND0G33zJ46B9;
 Fri,  2 Jan 2026 22:46:36 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id A3C4D40086;
 Fri,  2 Jan 2026 22:47:31 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 15:47:31 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 2 Jan 2026 15:47:31 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: RE: [PATCH v10 6/9] test: fix impossible format-truncation in cfgfiles
Thread-Topic: [PATCH v10 6/9] test: fix impossible format-truncation in
 cfgfiles
Thread-Index: AQHceQ665+M3XfMXskucI0GyW4F4MLU++yxg
Date: Fri, 2 Jan 2026 14:47:31 +0000
Message-ID: <b63b746b077640deaf9ca3d7cebe4f87@huawei.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
 <20251229220053.21981-7-stephen@networkplumber.org>
In-Reply-To: <20251229220053.21981-7-stephen@networkplumber.org>
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
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Anat=
oly Burakov
> <anatoly.burakov@intel.com>; Cristian Dumitrescu <cristian.dumitrescu@int=
el.com>; Bruce Richardson
> <bruce.richardson@intel.com>
> Subject: [PATCH v10 6/9] test: fix impossible format-truncation in cfgfil=
es
>=20
> Although, it is not possible on Linux (which always uses /tmp)
> the compiler complains about possible snprintf() truncation.
>=20
> Use existing code to make empty tmp file which puts the
> OS specific code in one spot and avoids any races if
> two tests are run at once.
>=20
> Fixes: be22019a58c4 ("test: restore cfgfile tests")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  app/test/test_cfgfile.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/app/test/test_cfgfile.c b/app/test/test_cfgfile.c
> index b189d9d7a5..eabf155404 100644
> --- a/app/test/test_cfgfile.c
> +++ b/app/test/test_cfgfile.c
> @@ -178,12 +178,8 @@ test_cfgfile_realloc_sections(void)
>  	ret =3D remove(filename);
>  	TEST_ASSERT_SUCCESS(ret, "Failed to remove file");
>=20
> -	char tmp[PATH_MAX] =3D "/tmp/";
> -#ifdef RTE_EXEC_ENV_WINDOWS
> -	ret =3D GetTempPathA(sizeof(tmp), tmp);
> -	TEST_ASSERT(ret > 0, "Failed to get tmp directory");
> -#endif
> -	snprintf(filename, sizeof(filename), "%s%s", tmp, "cfg_save.ini");
> +	ret =3D make_tmp_file(filename, "save", "");
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to make empty tmp filename for save")=
;
>=20
>  	ret =3D rte_cfgfile_save(cfgfile, filename);
>  	TEST_ASSERT_SUCCESS(ret, "Failed to save to %s", filename);
> --
> 2.51.0
>=20

Acked-by: Marat Khalili <marat.khalili@huawei.com>
