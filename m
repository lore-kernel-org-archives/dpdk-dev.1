Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DEFFA3741
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Jan 2026 14:33:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A758E40267;
	Fri,  2 Jan 2026 15:33:06 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 5DC5140262;
 Fri,  2 Jan 2026 15:33:05 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djR3W57DCzHnGfP;
 Fri,  2 Jan 2026 22:32:07 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 8B1404056F;
 Fri,  2 Jan 2026 22:33:04 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 2 Jan 2026 15:33:04 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 2 Jan 2026 15:33:04 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
Subject: RE: [PATCH v10 5/9] test: fix format overflow warning in ACL test
Thread-Topic: [PATCH v10 5/9] test: fix format overflow warning in ACL test
Thread-Index: AQHceQ63RbMYqUoa4kyYsdyYmPvrW7U+9scw
Date: Fri, 2 Jan 2026 14:33:04 +0000
Message-ID: <c43f8553dfbe4c3f93be3cc45981e766@huawei.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
 <20251229220053.21981-6-stephen@networkplumber.org>
In-Reply-To: <20251229220053.21981-6-stephen@networkplumber.org>
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
el.com>; Pablo de Lara
> <pablo.de.lara.guarch@intel.com>
> Subject: [PATCH v10 5/9] test: fix format overflow warning in ACL test
>=20
> This test has an array of input lines, but the two dimensional
> array confuses compiler length checks. Convert to an array
> of pointers to fixed strings which avoids the problem.
> Make both variables static since not shared with other code.
>=20
> Fixes: 5205954791cb ("app/test: packet framework unit tests")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  app/test/test_table_acl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/app/test/test_table_acl.c b/app/test/test_table_acl.c
> index dff9bddfb9..94edf37234 100644
> --- a/app/test/test_table_acl.c
> +++ b/app/test/test_table_acl.c
> @@ -317,7 +317,7 @@ parse_cb_ipv4_rule_del(char *str, struct rte_table_ac=
l_rule_delete_params *v)
>   * separated by ' : ', just ':'. It's a lot more readable and
>   * cleaner, IMO.
>   */
> -char lines[][128] =3D {
> +static const char * const lines[] =3D {
>  	"@0.0.0.0/0 0.0.0.0/0 0:65535 0:65535 2/0xff", /* Protocol check */
>  	"@192.168.3.1/32 0.0.0.0/0 0:65535 0:65535 0/0", /* Src IP checl */
>  	"@0.0.0.0/0 10.4.4.1/32 0:65535 0:65535 0/0", /* dst IP check */
> @@ -325,7 +325,7 @@ char lines[][128] =3D {
>  	"@0.0.0.0/0 0.0.0.0/0 0:65535 206:206 0/0", /* dst port check */
>  };
>=20
> -char line[128];
> +static char line[128];
>=20
>=20
>  static int
> --
> 2.51.0

I feel like both could also be made local to setup_acl_pipeline.

With or without this optimization,

Acked-by: Marat Khalili <marat.khalili@huawei.com>
