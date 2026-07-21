Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D727C4452F
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 13:17:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEB1E4042F;
	Tue, 21 Jul 2026 15:17:15 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 68D48402A7
 for <dev@dpdk.org>; Tue, 21 Jul 2026 15:17:14 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=m38L1KserQRKxm+3PMO2dwhGqymwGd4rglbFS+5NzR4=;
 b=D8dQ3cZabrlqC1P8hcVKV/4TvdvEI5fssoOohlzZgeWNDdpmDp3FpSV7qRy5DMhKInMuGgVWA
 gwgUMr5VC4uaRHteInrtIDlYVxj1qqhjsV2lya0zC0v8jGDYFE/tuXHYR2krQseDKs2LJTb+2W9
 Btws/8oU9/sxOu9/oV2wmmQ=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h4HwH6xhYzJ46bX;
 Tue, 21 Jul 2026 21:16:47 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 3AC5840575;
 Tue, 21 Jul 2026 21:17:08 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jul 2026 15:17:08 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 21 Jul 2026 15:17:08 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Maxime Leroy <maxime@leroys.fr>, "dev@dpdk.org" <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Thomas Monjalon
 <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>
Subject: RE: [PATCH] doc: drop recommendation against bool in structures
Thread-Topic: [PATCH] doc: drop recommendation against bool in structures
Thread-Index: AQHdGD1szi5HSkvZIUS60Ixy8Z3xDbZ39XYw
Date: Tue, 21 Jul 2026 13:17:07 +0000
Message-ID: <f3d6a6d6db914191b3969a338758b878@huawei.com>
References: <20260720114602.787429-1-maxime@leroys.fr>
In-Reply-To: <20260720114602.787429-1-maxime@leroys.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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
> From: Maxime Leroy <maxime.leroys@gmail.com> On Behalf Of Maxime Leroy
> Sent: Monday 20 July 2026 12:46
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Thomas Monjalon <thom=
as@monjalon.net>; David
> Marchand <david.marchand@redhat.com>; Maxime Leroy <maxime@leroys.fr>
> Subject: [PATCH] doc: drop recommendation against bool in structures
>=20
> The coding style advised against bool in structures, citing space and
> type-size concerns inherited from the Linux kernel. That does not match
> DPDK practice: bool is already used in over 1400 structure fields across
> the tree, including core APIs such as rte_flow. Drop the note so the
> style guide reflects actual usage.
>=20
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  doc/guides/contributing/coding_style.rst | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contri=
buting/coding_style.rst
> index 976a1e1de3..11de3bb39a 100644
> --- a/doc/guides/contributing/coding_style.rst
> +++ b/doc/guides/contributing/coding_style.rst
> @@ -313,15 +313,6 @@ Structure Declarations
>  * Use of the structures should be by separate variable declarations and =
those declarations must be
> extern if they are declared in a header file.
>  * Externally visible structure definitions should have the structure nam=
e prefixed by ``rte_`` to
> avoid namespace collisions.
>=20
> -.. note::
> -
> -    Avoid using ``bool`` in structures because it wastes space and
> -    the type size is unclear. A preferred use of
> -    ``bool`` is mainly as a return type from functions that return true/=
false,
> -    and maybe local variable functions.
> -
> -    Ref: `LKML <https://lkml.org/lkml/2017/11/21/384>`_
> -

Acked-by: Marat Khalili <marat.khalili@huawei.com>

>  Queues
>  ~~~~~~
>=20
> --
> 2.43.0

