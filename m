Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A098DCA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 09:27:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC16C402A4;
	Sat, 10 Oct 2026 11:27:07 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023097.outbound.protection.outlook.com [52.101.127.97])
 by mails.dpdk.org (Postfix) with ESMTP id 1B45A4026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 11:27:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOzDD2MVEkTdk90Owp0XCaEyEV6ZjrlAfaG+KFkFQhd7+N4Zk1D4w6J/bYc6bkSvBwl9/4+ODAVYGyMfkRWiYf4pp4K+69QmLoerEdNeaPaxCxLv7icLUldRJiPHRH9U7X8LOUZ0ytBWyXxBrJMreiFHzEUofnfiKiqAvgyFU94kuNGNkOtX3LdknlaJiB7WgsWNqh5lWKtXcCkiROdlhJ6FzbT9uU3BHi3yjta9J4p3R0u+WQBbZLoOLjfC4nwXOML381pmQDXX/0ynXrZT64mpaE8xRdY/kwGI1gb6tFAV9QqAi9cDOlUwz9ICJ3yDw9IJcAyw31tjN4yfD/OCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=Xfpn5zeI0MdOk8JvjyF/N08so8xKkMAmhH4FLaZYHaE=;
 b=uk2MzPcG1whDovTOPoNxLWeIimA3hMzUAVsNa4g5Bj7Gt4MeJTMIFFd4OaeNX/8RyB08QWbBLvJJ2G9K7xEubWnr7aUhysaf4row5aM6OsK3U+gp7L+ZoOcwLdfC/yZoQMAB/TQny6n/6qSQOW/PclbyqiSUyRfegusRmhMvkJLPhUR5kEr60qIxmPWfNP1iMvzi8aDimIGA34Mx7J/lLK6zJbc8+Q4JiAGK8F5qSxwLb+e8EvPI8XBu1iHiFQxxxE3kdMHdXd9EP2lgXR0O9d5r8ps0o/D+7yfsVERXhA1LgL99kh/xXifhQbPwip+HXf90dgmSDhXa8O2kIfEOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfpn5zeI0MdOk8JvjyF/N08so8xKkMAmhH4FLaZYHaE=;
 b=NK/sct6ke/OUoq44QBKbaUzYnNGbziAw1woRa0CfRiJpoemnz5Aro0uDyuPW0ggpI5BGcioaMtXgxW5bAoMgJ64NVwUs8VH4cXcNab7CoJ7NHOUUncnhX7bkE/neuDlna267XtFax3npmxOqYLLyGgMDyCjHvr/zqc1bkQlaLRY=
Received: from SI3P153MB1838.APCP153.PROD.OUTLOOK.COM (2603:1096:4:2a1::5) by
 OSQP153MB1208.APCP153.PROD.OUTLOOK.COM (2603:1096:604:373::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.7; Sat, 10 Oct 2026 09:27:01 +0000
Received: from SI3P153MB1838.APCP153.PROD.OUTLOOK.COM
 ([fe80::64f5:60e6:e32f:e91e]) by SI3P153MB1838.APCP153.PROD.OUTLOOK.COM
 ([fe80::64f5:60e6:e32f:e91e%6]) with mapi id 15.21.0546.000; Sat, 10 Oct 2026
 09:27:01 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] [RFC] bus/vmbus: make driver interface internal
Thread-Topic: [EXTERNAL] [RFC] bus/vmbus: make driver interface internal
Thread-Index: AQHdV1jCHMWoHgL6xEy3/jZ4G0gWG7b2g0EQ
Date: Sat, 10 Oct 2026 09:27:01 +0000
Message-ID: <SI3P153MB18382403EF9DC3A4ADB5FB83BB912@SI3P153MB1838.APCP153.PROD.OUTLOOK.COM>
References: <20261008191046.703485-1-stephen@networkplumber.org>
In-Reply-To: <20261008191046.703485-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f906a80e-22d6-4fe5-ac4c-10d729923ca7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-10-10T09:23:13Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI3P153MB1838:EE_|OSQP153MB1208:EE_
x-ms-office365-filtering-correlation-id: 1b5e10dc-a7cc-4d99-7aa1-08df26b0a3ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|42112799006|366016|376014|1800799024|38070700021|261009223027099003|56012099006|11063799006|7146999003|10067099003|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info: uME0rgaBExw49fi0crL6gZgnh1OffyaObQuuwklai9A79we9TGM3BKG9HPiEZNjklWVOC+9fUJo8aCJrfZ2c/hS3svx61nhwae1Q+w76QrVgXrImdO//+eI6dJGpLHHJcoShFyyKz+PLjIHAVuXRQOMU4/2MBj6hA+AWm5e068p4C/LaY1gLrfKuQorvTyYMTgK4sX5J+mdGDa4kF6JkZTrSF1/JP8TuEjss+FE5p8KxkBcojAwy2e6NqTvyVLH/yJaMKF4NkOqMW0CZGr35hcYGZ9kZpSn7kzpnUCLaHb0IJo+0Xy0dmW/6IxvlkunU9Um1QvHamwO6IGqmv1ZrruItXPzdqzhgJji47yJaCphAlrSPvyo/ZkxGv1nqJ+hrOkjLlCLgueDKlViFULqCqt9DUdMQYWVkm9Y5AVnBekZHyB8JxzH/M45pM5yYzLigYTmWQAdhOETtwHiE5qIaoYW9FeauFGGMCtpmVVkOkcc92mo46PQMn9R/6XKfHXQl8eGAqARd3WBT9Ztrrzouhn+Ed5gjgOpIloWfIxK1o6z4lR14SV+ZCEPpvYifeKRBZoszZRXx8eLJOcthKRN+18vYrNdIvLug4OmhpMWx+gj2whtbiYA3borHB0MtCPXjKPfJc2GBCA91Rbb2tR5uzC0D9lzIReG627grxS3kbOE20BNPyJSYm8BYVBmxSa9cIkCH0hYJXDeJD9QpK8NQUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI3P153MB1838.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(42112799006)(366016)(376014)(1800799024)(38070700021)(261009223027099003)(56012099006)(11063799006)(7146999003)(10067099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b+DIOngv6j6jI9L1SnTaiylFKhCMMIhP7hufEFgCuOyqhFS9Z+ScHzGcTLjD?=
 =?us-ascii?Q?gNYZE2GS8tU45RX7Xph/mG5e78J6Oo4rI2NYVtqk03vE7tI7C9Nl1SXhUb46?=
 =?us-ascii?Q?mWNWE4beavms2ts9UP8jR+rcHFjwP1EIbnCe/6RaxWhZChYMlqfOgAoKi8Ub?=
 =?us-ascii?Q?/2zT/zOS5+QRznNOTmiAArZcLqaa3b8fFKUwmJZ0LoKZ5ujKvEd2CRsR3KG1?=
 =?us-ascii?Q?Bz9BsOmfPyDY4Fq0VJfkiLUVPOnawt3BCNWuVhcDsUwv2VMXzhM+JJvk4euU?=
 =?us-ascii?Q?bygZMw3Y1nGI4eJAdA+duamBbHHPguYEqVT0x6P/HEzC8t7Z1Asxg3lhmKlG?=
 =?us-ascii?Q?x3PGkm/w/pRl836v6aHp9ZSleRCYSg64EpnPZYLourOZibargTLmIODvZXlD?=
 =?us-ascii?Q?7N/L8BhQKV6Qpy31/ZmF/buEMQ+n/JFybleIcNoxRNomKEnuRVojFKBe8Id2?=
 =?us-ascii?Q?0PAbcqHfCYA1G2AN4POMrXxvlXauM6lsCENGPfe+Fn+/FZlhp3XN+xGujayd?=
 =?us-ascii?Q?Lb9XHRiEKfZSLtOQ2ft29JqQ0ji5eF8nsFZOYJCi5gpLYQmRjwbX9ck7lrrb?=
 =?us-ascii?Q?b+pCf2cReFHfvmEjp0n2Q95cl0ACkEqhajHDnQa36KdqSyfJup3hq+PuUjNx?=
 =?us-ascii?Q?zl5obP5J/3gx7NArqx8t0X9GFtbm1GcKq53JdrxQHtN/v6nVGuZ9eDwXKRat?=
 =?us-ascii?Q?KBTK0W2NoCbJ7Y2JDQ8mfjysuOJF9fkJWoCbGfljIbCVAI9Ng1cJowcknUHe?=
 =?us-ascii?Q?EMPgNvA+xjZhfvbw7/zqPrtdg+CSGRvZSwO6I7m51M/7irFHVB4EE6eFFGA0?=
 =?us-ascii?Q?Wytj0hNCY9ocbiotiuIOCPI+EKGVPGdrqJXA1OS9PgnahNH2L4B98oMT4IKh?=
 =?us-ascii?Q?T/uvnZpMlw0OdYFGoLeC0oB3JJi8S9EKSA8PZWLqxObNQPzd7/IsvkljgSXo?=
 =?us-ascii?Q?LGHSGphs1ZdLx7uLLMeVIMyF1gQ46dTx8q+Emfs30uSPcNEZa3ceYuKiCMxW?=
 =?us-ascii?Q?CUg5kllGsZCeoe8g196jtyGFseF5YSNuHhjtqWtApnlqVrn+UNxLU/V/oz1m?=
 =?us-ascii?Q?2rs4oYTiFFmQ1SLIn8zU/Hbky0L0Yt7OzOwX+ZGVzjD3O9lxWYMwNhvtgST0?=
 =?us-ascii?Q?XSb0qBPRpZupg6qqa0p+ziDC0CVVnFLsy66GJwcnpm3gXBSQqI1Vg9Ggu7x4?=
 =?us-ascii?Q?CED03FwR1KLb9bBpykUQReHHlHW3ecgyrkHrwBzM1L30MQjMNCJBDynRkmo+?=
 =?us-ascii?Q?M6Yytq9QDnPnAIkjArLsklICKG0+lUS1yyohdH0jX/Ck9obJuQ30S9xmr0Qf?=
 =?us-ascii?Q?7iTbsoSLGbgEZU8+vWBoCfmaLgQlumanrSQ+h5O4mPfmnsPNsoFO6EMEtjK7?=
 =?us-ascii?Q?36nkolFh/Qw+CN/VwdDixu76NQ5j+zUl6Pxkjx5hYtMl3qsXRTUlSSF5Z9NI?=
 =?us-ascii?Q?ZfWfMNYJkUcx4n9u2qlC8X2JysMGmyeUR3B9TDNbJ7OBkMvcGxeCTnx5Nhyf?=
 =?us-ascii?Q?/N/TQD7TxFkKNaYaZxFGCRy7pLwygYZogTVrPdtg8+NOG/HaqoNrLq6uSSbt?=
 =?us-ascii?Q?Y3f80qArzKnIBxl4DSuG85H5iBKHcZvi07or66eIZeo8nFsumMuMqxBxmHkD?=
 =?us-ascii?Q?dFw5KIzoAJAJ99i3z/5/JowahUqFd2bCdT0qyoy+qauNW7Kzh/h6hWIL08Ew?=
 =?us-ascii?Q?ZNXcExMqcXUq2DsTDBPaegVP9DHe9y0BmWmGkjaCeyaeP96f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI3P153MB1838.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5e10dc-a7cc-4d99-7aa1-08df26b0a3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 09:27:01.2711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuV7yuzC2k4q5sp74GC7s+Zq2+eieDJEowo9PsZjjTrAXxLl97zJ5ZRyW3CzfYm2RwGnO2skedAeXnqG2LBsBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQP153MB1208
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
> Sent: Friday, October 9, 2026 3:10 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Wei Hu
> <weh@microsoft.com>
> Subject: [EXTERNAL] [RFC] bus/vmbus: make driver interface internal
>=20
> The vmbus bus API was exposed as public API, but it is only usable by the
> netvsc PMD and DPDK core: the functions operate on vmbus channels and
> devices that no application can obtain. Exposing them commits DPDK to an
> ABI that has no external consumer.
>=20
> Make the interface internal as announced. The public headers
> rte_bus_vmbus.h and rte_vmbus_reg.h are renamed to vmbus_api.h and
> vmbus_reg.h and listed as driver SDK headers, so they are no longer insta=
lled
> for applications. All rte_vmbus_* functions are marked __rte_internal and
> exported as internal symbols.
>=20
> rte_vmbus_chan_dump() had no export annotation at all, so it was declared=
 in
> the public header but never present in the shared library.
> It is now exported as internal like the rest.
>=20
> netvsc needs no change: it already includes bus_vmbus_driver.h, and the b=
us
> driver dependency puts the driver directory on its include path.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Wei Hu <weh@microsoft.com>

Thanks,
Wei

> ---
> I don't have access to Hyper-V or Azure to test this.
> Was generated by LLM based on the intention in the deprecation note.
> Please test on proper environment before merging.
>=20
>  doc/guides/rel_notes/deprecation.rst          |  3 --
>  doc/guides/rel_notes/release_26_11.rst        |  6 ++++
>  drivers/bus/vmbus/bus_vmbus_driver.h          |  2 +-
>  drivers/bus/vmbus/linux/vmbus_bus.c           | 14 ++++-----
>  drivers/bus/vmbus/linux/vmbus_uio.c           |  2 +-
>  drivers/bus/vmbus/meson.build                 |  7 +++--
>  drivers/bus/vmbus/private.h                   |  2 +-
>  .../vmbus/{rte_bus_vmbus.h =3D> vmbus_api.h}    | 30 ++++++++++++++++---
>  drivers/bus/vmbus/vmbus_bufring.c             |  2 +-
>  drivers/bus/vmbus/vmbus_channel.c             | 29 +++++++++---------
>  drivers/bus/vmbus/vmbus_common.c              |  4 +--
>  drivers/bus/vmbus/vmbus_common_uio.c          |  2 +-
>  .../vmbus/{rte_vmbus_reg.h =3D> vmbus_reg.h}    |  0
>  13 files changed, 66 insertions(+), 37 deletions(-)  rename
> drivers/bus/vmbus/{rte_bus_vmbus.h =3D> vmbus_api.h} (94%)  rename
> drivers/bus/vmbus/{rte_vmbus_reg.h =3D> vmbus_reg.h} (100%)
>=20
> diff --git a/doc/guides/rel_notes/deprecation.rst
> b/doc/guides/rel_notes/deprecation.rst
> index 56a67c372e..08875f1d0a 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -135,6 +135,3 @@ Deprecation Notices
>    The graph walk functions will process nodes in topological order
>    using bitmap scanning instead of the circular buffer.
>=20
> -* bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
> -  ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
> -  Those API functions are used internally by DPDK core and netvsc PMD.
> diff --git a/doc/guides/rel_notes/release_26_11.rst
> b/doc/guides/rel_notes/release_26_11.rst
> index 16d3a90723..fb195be54b 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -235,6 +235,12 @@ API Changes
>     Also, make sure to start the actual text at the margin.
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>=20
> +* bus/vmbus: Made the vmbus bus API internal.
> +  The ``rte_bus_vmbus.h`` and ``rte_vmbus_reg.h`` headers are no longer
> +installed;
> +  their contents moved to the driver only headers
> +  ``vmbus_api.h`` and ``vmbus_reg.h``.
> +  All ``rte_vmbus_*`` functions are now internal to DPDK.
> +
>  * eal: Improved pointer arithmetic macros.
>=20
>    * ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``,
> ``RTE_PTR_ALIGN_CEIL``, diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h
> b/drivers/bus/vmbus/bus_vmbus_driver.h
> index 706ff1fcf5..09a38058dd 100644
> --- a/drivers/bus/vmbus/bus_vmbus_driver.h
> +++ b/drivers/bus/vmbus/bus_vmbus_driver.h
> @@ -6,7 +6,7 @@
>  #ifndef BUS_VMBUS_DRIVER_H
>  #define BUS_VMBUS_DRIVER_H
>=20
> -#include <rte_bus_vmbus.h>
> +#include <vmbus_api.h>
>  #include <rte_compat.h>
>  #include <dev_driver.h>
>=20
> diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c
> b/drivers/bus/vmbus/linux/vmbus_bus.c
> index 779ea50b92..6c26f7e354 100644
> --- a/drivers/bus/vmbus/linux/vmbus_bus.c
> +++ b/drivers/bus/vmbus/linux/vmbus_bus.c
> @@ -17,7 +17,7 @@
>  #include <rte_devargs.h>
>  #include <rte_memory.h>
>  #include <rte_malloc.h>
> -#include <rte_bus_vmbus.h>
> +#include <vmbus_api.h>
>  #include <rte_kvargs.h>
>=20
>  #include <eal_export.h>
> @@ -164,7 +164,7 @@ static const char
> *map_names[VMBUS_MAX_RESOURCE] =3D {
>=20
>=20
>  /* map the resources of a vmbus device in virtual memory */
> -RTE_EXPORT_SYMBOL(rte_vmbus_map_device)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_map_device)
>  int
>  rte_vmbus_map_device(struct rte_vmbus_device *dev)  { @@ -223,7 +223,7
> @@ rte_vmbus_map_device(struct rte_vmbus_device *dev)
>  	return vmbus_uio_map_resource(dev);
>  }
>=20
> -RTE_EXPORT_SYMBOL(rte_vmbus_unmap_device)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_unmap_device)
>  void
>  rte_vmbus_unmap_device(struct rte_vmbus_device *dev)  { @@ -375,7
> +375,7 @@ vmbus_scan_one(const char *name)
>  /*
>   * Scan the content of the vmbus, and the devices in the devices list
>   */
> -RTE_EXPORT_SYMBOL(rte_vmbus_scan)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_scan)
>  int
>  rte_vmbus_scan(void)
>  {
> @@ -407,19 +407,19 @@ rte_vmbus_scan(void)
>  	return -1;
>  }
>=20
> -RTE_EXPORT_SYMBOL(rte_vmbus_irq_mask)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_irq_mask)
>  void rte_vmbus_irq_mask(struct rte_vmbus_device *device)  {
>  	vmbus_uio_irq_control(device, 1);
>  }
>=20
> -RTE_EXPORT_SYMBOL(rte_vmbus_irq_unmask)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_irq_unmask)
>  void rte_vmbus_irq_unmask(struct rte_vmbus_device *device)  {
>  	vmbus_uio_irq_control(device, 0);
>  }
>=20
> -RTE_EXPORT_SYMBOL(rte_vmbus_irq_read)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_irq_read)
>  int rte_vmbus_irq_read(struct rte_vmbus_device *device)  {
>  	return vmbus_uio_irq_read(device);
> diff --git a/drivers/bus/vmbus/linux/vmbus_uio.c
> b/drivers/bus/vmbus/linux/vmbus_uio.c
> index 0ef05c0096..34cfb63d54 100644
> --- a/drivers/bus/vmbus/linux/vmbus_uio.c
> +++ b/drivers/bus/vmbus/linux/vmbus_uio.c
> @@ -16,7 +16,7 @@
>  #include <rte_memory.h>
>  #include <rte_common.h>
>  #include <rte_malloc.h>
> -#include <rte_bus_vmbus.h>
> +#include <vmbus_api.h>
>  #include <rte_string_fns.h>
>=20
>  #include "private.h"
> diff --git a/drivers/bus/vmbus/meson.build
> b/drivers/bus/vmbus/meson.build index 86ad9cc4d8..47408bb5d5 100644
> --- a/drivers/bus/vmbus/meson.build
> +++ b/drivers/bus/vmbus/meson.build
> @@ -6,8 +6,11 @@ if is_windows
>      subdir_done()
>  endif
>=20
> -headers =3D files('rte_bus_vmbus.h','rte_vmbus_reg.h')
> -driver_sdk_headers =3D files('bus_vmbus_driver.h')
> +driver_sdk_headers =3D files(
> +        'bus_vmbus_driver.h',
> +        'vmbus_api.h',
> +        'vmbus_reg.h',
> +)
>=20
>  sources =3D files(
>          'vmbus_bufring.c',
> diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h in=
dex
> 6b7782724f..20f6d16a9b 100644
> --- a/drivers/bus/vmbus/private.h
> +++ b/drivers/bus/vmbus/private.h
> @@ -13,7 +13,7 @@
>  #include <bus_vmbus_driver.h>
>  #include <rte_log.h>
>  #include <rte_eal_paging.h>
> -#include <rte_vmbus_reg.h>
> +#include <vmbus_reg.h>
>=20
>  extern struct rte_bus rte_vmbus_bus;
>=20
> diff --git a/drivers/bus/vmbus/rte_bus_vmbus.h
> b/drivers/bus/vmbus/vmbus_api.h similarity index 94% rename from
> drivers/bus/vmbus/rte_bus_vmbus.h rename to
> drivers/bus/vmbus/vmbus_api.h index 2e9898ed7f..f1078110cd 100644
> --- a/drivers/bus/vmbus/rte_bus_vmbus.h
> +++ b/drivers/bus/vmbus/vmbus_api.h
> @@ -3,8 +3,8 @@
>   * All Rights Reserved.
>   */
>=20
> -#ifndef _VMBUS_H_
> -#define _VMBUS_H_
> +#ifndef VMBUS_API_H
> +#define VMBUS_API_H
>=20
>  /**
>   * @file
> @@ -19,10 +19,11 @@
>  #include <stdint.h>
>  #include <inttypes.h>
>=20
> +#include <rte_compat.h>
>  #include <rte_uuid.h>
>  #include <rte_debug.h>
>  #include <rte_interrupts.h>
> -#include <rte_vmbus_reg.h>
> +#include <vmbus_reg.h>
>=20
>  #ifdef __cplusplus
>  extern "C" {
> @@ -40,6 +41,7 @@ struct vmbus_channel;
>   * @return
>   *  0 on success, negative on error
>   */
> +__rte_internal
>  int rte_vmbus_scan(void);
>=20
>  /**
> @@ -49,6 +51,7 @@ int rte_vmbus_scan(void);
>   *   - 0 on success.
>   *   - !0 on error.
>   */
> +__rte_internal
>  int rte_vmbus_probe(void);
>=20
>  /**
> @@ -62,6 +65,7 @@ int rte_vmbus_probe(void);
>   *   0 on success, negative on error and positive if no driver
>   *   is found for the device.
>   */
> +__rte_internal
>  int rte_vmbus_map_device(struct rte_vmbus_device *dev);
>=20
>  /**
> @@ -71,6 +75,7 @@ int rte_vmbus_map_device(struct rte_vmbus_device
> *dev);
>   *   A pointer to a rte_vmbus_device structure describing the device
>   *   to use
>   */
> +__rte_internal
>  void rte_vmbus_unmap_device(struct rte_vmbus_device *dev);
>=20
>  /**
> @@ -85,6 +90,7 @@ void rte_vmbus_unmap_device(struct
> rte_vmbus_device *dev);
>   *   - -ENOMEM: Not enough memory available.
>   *   - -EINVAL: Regions could not be mapped.
>   */
> +__rte_internal
>  int rte_vmbus_chan_open(struct rte_vmbus_device *device,
>  			struct vmbus_channel **chan);
>=20
> @@ -94,6 +100,7 @@ int rte_vmbus_chan_open(struct rte_vmbus_device
> *device,
>   * @param chan
>   *    VMBUS channel
>   */
> +__rte_internal
>  void rte_vmbus_chan_close(struct vmbus_channel *chan);
>=20
>  /**
> @@ -104,6 +111,7 @@ void rte_vmbus_chan_close(struct vmbus_channel
> *chan);
>   * @return
>   *   Number of channels available.
>   */
> +__rte_internal
>  int rte_vmbus_max_channels(const struct rte_vmbus_device *device);
>=20
>  /**
> @@ -118,6 +126,7 @@ int rte_vmbus_max_channels(const struct
> rte_vmbus_device *device);
>   *   - -ENOMEM: Not enough memory available.
>   *   - -EINVAL: Regions could not be mapped.
>   */
> +__rte_internal
>  int rte_vmbus_subchan_open(struct vmbus_channel *primary,
>  			   struct vmbus_channel **new_chan);
>=20
> @@ -127,6 +136,7 @@ int rte_vmbus_subchan_open(struct vmbus_channel
> *primary,
>   * @param device
>   *    VMBUS device
>   */
> +__rte_internal
>  void rte_vmbus_irq_mask(struct rte_vmbus_device *device);
>=20
>  /**
> @@ -135,6 +145,7 @@ void rte_vmbus_irq_mask(struct rte_vmbus_device
> *device);
>   * @param device
>   *    VMBUS device
>   */
> +__rte_internal
>  void rte_vmbus_irq_unmask(struct rte_vmbus_device *device);
>=20
>  /**
> @@ -143,6 +154,7 @@ void rte_vmbus_irq_unmask(struct
> rte_vmbus_device *device);
>   * @param device
>   *    VMBUS device
>   */
> +__rte_internal
>  int rte_vmbus_irq_read(struct rte_vmbus_device *device);
>=20
>  /**
> @@ -153,6 +165,7 @@ int rte_vmbus_irq_read(struct rte_vmbus_device
> *device);
>   * @return
>   *	Return true if no data present in incoming ring.
>   */
> +__rte_internal
>  bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel);
>=20
>  /**
> @@ -176,6 +189,7 @@ bool rte_vmbus_chan_rx_empty(const struct
> vmbus_channel *channel);
>   *
>   * Sends data in buffer directly to hyper-v via the vmbus
>   */
> +__rte_internal
>  int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
>  			struct vmbus_channel *channel, uint16_t type,
>  			void *data, uint32_t dlen,
> @@ -190,6 +204,7 @@ int rte_vmbus_chan_send(struct rte_vmbus_device
> *dev,
>   * Used when batching multiple sends and only signaling host
>   * after the last send.
>   */
> +__rte_internal
>  void rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev,
>  			      const struct vmbus_channel *channel);
>=20
> @@ -225,6 +240,7 @@ struct iova_list {
>   *
>   * Sends data in buffer directly to hyper-v via the vmbus
>   */
> +__rte_internal
>  int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
>  			       struct vmbus_channel *channel,
>  			       struct vmbus_gpa gpa[], uint32_t gpacnt, @@ -
> 246,6 +262,7 @@ int rte_vmbus_chan_send_sglist(struct rte_vmbus_device
> *dev,
>   *   On success, returns 0
>   *   On failure, returns negative errno.
>   */
> +__rte_internal
>  int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
>  			struct vmbus_channel *chan,
>  			void *data, uint32_t *len,
> @@ -265,6 +282,7 @@ int rte_vmbus_chan_recv(struct rte_vmbus_device
> *dev,
>   *   On success, returns number of bytes read.
>   *   On failure, returns negative errno.
>   */
> +__rte_internal
>  int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
>  			    void *data, uint32_t *len);
>=20
> @@ -277,6 +295,7 @@ int rte_vmbus_chan_recv_raw(struct vmbus_channel
> *chan,
>   * @param bytes_read
>   *	Number of bytes read since last signal
>   */
> +__rte_internal
>  void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
>  				struct vmbus_channel *chan,
>  				uint32_t bytes_read);
> @@ -289,6 +308,7 @@ void rte_vmbus_chan_signal_read(struct
> rte_vmbus_device *dev,
>   * @return
>   *   Sub channel index (0 for primary)
>   */
> +__rte_internal
>  uint16_t rte_vmbus_sub_channel_index(const struct vmbus_channel *chan);
>=20
>  /**
> @@ -302,6 +322,7 @@ uint16_t rte_vmbus_sub_channel_index(const struct
> vmbus_channel *chan);
>   *	Approximate wait period between hypervisor examinations of
>   *	the trigger page (in nanoseconds).
>   */
> +__rte_internal
>  void rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
>  			   const struct vmbus_channel *chan,
>  			   uint32_t latency);
> @@ -312,10 +333,11 @@ void rte_vmbus_set_latency(const struct
> rte_vmbus_device *dev,
>   * @param channel
>   *	Pointer to vmbus_channel structure.
>   */
> +__rte_internal
>  void rte_vmbus_chan_dump(FILE *f, const struct vmbus_channel *chan);
>=20
>  #ifdef __cplusplus
>  }
>  #endif
>=20
> -#endif /* _VMBUS_H_ */
> +#endif /* VMBUS_API_H */
> diff --git a/drivers/bus/vmbus/vmbus_bufring.c
> b/drivers/bus/vmbus/vmbus_bufring.c
> index dcd66390a3..9e8227a863 100644
> --- a/drivers/bus/vmbus/vmbus_bufring.c
> +++ b/drivers/bus/vmbus/vmbus_bufring.c
> @@ -18,7 +18,7 @@
>  #include <rte_stdatomic.h>
>  #include <rte_memory.h>
>  #include <rte_pause.h>
> -#include <rte_bus_vmbus.h>
> +#include <vmbus_api.h>
>=20
>  #include "private.h"
>=20
> diff --git a/drivers/bus/vmbus/vmbus_channel.c
> b/drivers/bus/vmbus/vmbus_channel.c
> index 6887fbad46..a8768eab16 100644
> --- a/drivers/bus/vmbus/vmbus_channel.c
> +++ b/drivers/bus/vmbus/vmbus_channel.c
> @@ -15,7 +15,7 @@
>  #include <rte_malloc.h>
>  #include <rte_atomic.h>
>  #include <rte_memory.h>
> -#include <rte_bus_vmbus.h>
> +#include <vmbus_api.h>
>=20
>  #include "private.h"
>=20
> @@ -65,7 +65,7 @@ vmbus_set_event(struct rte_vmbus_device *dev, const
> struct vmbus_channel *chan)
>  /*
>   * Set the wait between when hypervisor examines the trigger.
>   */
> -RTE_EXPORT_SYMBOL(rte_vmbus_set_latency)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_set_latency)
>  void
>  rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
>  		      const struct vmbus_channel *chan, @@ -98,7 +98,7 @@
> rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
>   * Since this in userspace, rely on the monitor page.
>   * Can't do a hypercall from userspace.
>   */
> -RTE_EXPORT_SYMBOL(rte_vmbus_chan_signal_tx)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_signal_tx)
>  void
>  rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev, const struct
> vmbus_channel *chan)  { @@ -116,7 +116,7 @@
> rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev, const struct
> vmbus_channe
>=20
>=20
>  /* Do a simple send directly using transmit ring. */
> -RTE_EXPORT_SYMBOL(rte_vmbus_chan_send)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_send)
>  int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
>  			struct vmbus_channel *chan, uint16_t type, void
> *data,
>  			uint32_t dlen, uint64_t xactid, uint32_t flags, @@ -
> 161,7 +161,7 @@ int rte_vmbus_chan_send(struct rte_vmbus_device *dev,  }
>=20
>  /* Do a scatter/gather send where the descriptor points to data. */
> -RTE_EXPORT_SYMBOL(rte_vmbus_chan_send_sglist)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_send_sglist)
>  int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
>  			       struct vmbus_channel *chan,
>  			       struct vmbus_gpa sg[], uint32_t sglen, @@ -206,7
> +206,7 @@ int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
>  	return error;
>  }
>=20
> -RTE_EXPORT_SYMBOL(rte_vmbus_chan_rx_empty)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_rx_empty)
>  bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)  {
>  	const struct vmbus_br *br =3D &channel->rxbr; @@ -216,7 +216,7 @@
> bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)  }
>=20
>  /* Signal host after reading N bytes */
> -RTE_EXPORT_SYMBOL(rte_vmbus_chan_signal_read)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_signal_read)
>  void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
>  				struct vmbus_channel *chan,
>  				uint32_t bytes_read)
> @@ -249,7 +249,7 @@ void rte_vmbus_chan_signal_read(struct
> rte_vmbus_device *dev,
>  	vmbus_set_event(dev, chan);
>  }
>=20
> -RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_recv)
>  int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
>  			struct vmbus_channel *chan, void *data, uint32_t
> *len,
>  			uint64_t *request_id)
> @@ -298,7 +298,7 @@ int rte_vmbus_chan_recv(struct rte_vmbus_device
> *dev,  }
>=20
>  /* TODO: replace this with inplace ring buffer (no copy) */
> -RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv_raw)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_recv_raw)
>  int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
>  			    void *data, uint32_t *len)
>  {
> @@ -369,7 +369,7 @@ int vmbus_chan_create(const struct
> rte_vmbus_device *device,  }
>=20
>  /* Setup the primary channel */
> -RTE_EXPORT_SYMBOL(rte_vmbus_chan_open)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_open)
>  int rte_vmbus_chan_open(struct rte_vmbus_device *device,
>  			struct vmbus_channel **new_chan)
>  {
> @@ -390,7 +390,7 @@ int rte_vmbus_chan_open(struct rte_vmbus_device
> *device,
>  	return err;
>  }
>=20
> -RTE_EXPORT_SYMBOL(rte_vmbus_max_channels)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_max_channels)
>  int rte_vmbus_max_channels(const struct rte_vmbus_device *device)  {
>  	if (vmbus_uio_subchannels_supported(device, device->primary)) @@
> -400,7 +400,7 @@ int rte_vmbus_max_channels(const struct
> rte_vmbus_device *device)  }
>=20
>  /* Setup secondary channel */
> -RTE_EXPORT_SYMBOL(rte_vmbus_subchan_open)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_subchan_open)
>  int rte_vmbus_subchan_open(struct vmbus_channel *primary,
>  			   struct vmbus_channel **new_chan)
>  {
> @@ -416,13 +416,13 @@ int rte_vmbus_subchan_open(struct
> vmbus_channel *primary,
>  	return 0;
>  }
>=20
> -RTE_EXPORT_SYMBOL(rte_vmbus_sub_channel_index)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_sub_channel_index)
>  uint16_t rte_vmbus_sub_channel_index(const struct vmbus_channel *chan)
> {
>  	return chan->subchannel_id;
>  }
>=20
> -RTE_EXPORT_SYMBOL(rte_vmbus_chan_close)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_close)
>  void rte_vmbus_chan_close(struct vmbus_channel *chan)  {
>  	const struct rte_vmbus_device *device =3D chan->device; @@ -459,6
> +459,7 @@ static void vmbus_dump_ring(FILE *f, const char *id, const stru=
ct
> vmbus_br *br)
>  			pkt.flags, pkt.xactid);
>  }
>=20
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_chan_dump)
>  void rte_vmbus_chan_dump(FILE *f, const struct vmbus_channel *chan)  {
>  	fprintf(f, "channel[%u] relid=3D%u monitor=3D%u\n", diff --git
> a/drivers/bus/vmbus/vmbus_common.c
> b/drivers/bus/vmbus/vmbus_common.c
> index 4c64856abb..63d8c0d8b0 100644
> --- a/drivers/bus/vmbus/vmbus_common.c
> +++ b/drivers/bus/vmbus/vmbus_common.c
> @@ -19,7 +19,7 @@
>  #include <rte_malloc.h>
>  #include <rte_errno.h>
>  #include <rte_memory.h>
> -#include <rte_bus_vmbus.h>
> +#include <vmbus_api.h>
>=20
>  #include "private.h"
>=20
> @@ -129,7 +129,7 @@ vmbus_probe_device(struct rte_driver *drv, struct
> rte_device *dev)
>   * all registered drivers that have a matching entry in its id_table
>   * for discovered devices.
>   */
> -RTE_EXPORT_SYMBOL(rte_vmbus_probe)
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_probe)
>  int
>  rte_vmbus_probe(void)
>  {
> diff --git a/drivers/bus/vmbus/vmbus_common_uio.c
> b/drivers/bus/vmbus/vmbus_common_uio.c
> index c6e7e07302..974b01470f 100644
> --- a/drivers/bus/vmbus/vmbus_common_uio.c
> +++ b/drivers/bus/vmbus/vmbus_common_uio.c
> @@ -13,7 +13,7 @@
>  #include <rte_tailq.h>
>  #include <rte_log.h>
>  #include <rte_malloc.h>
> -#include <rte_bus_vmbus.h>
> +#include <vmbus_api.h>
>=20
>  #include "private.h"
>=20
> diff --git a/drivers/bus/vmbus/rte_vmbus_reg.h
> b/drivers/bus/vmbus/vmbus_reg.h similarity index 100% rename from
> drivers/bus/vmbus/rte_vmbus_reg.h rename to
> drivers/bus/vmbus/vmbus_reg.h
> --
> 2.53.0

