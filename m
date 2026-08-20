Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B32CC5DF88
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 01:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D6AA40284;
	Thu, 20 Aug 2026 03:38:23 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11023097.outbound.protection.outlook.com
 [40.93.196.97]) by mails.dpdk.org (Postfix) with ESMTP id AFFAD4014F;
 Thu, 20 Aug 2026 03:38:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDjQJ6QnR3fem3nCe3DV41u/rhg1t+K4jXtUTBxUTBYkKYhQPXjb9fMWUFZKAE0cxR8bpaTeQOP8BFR2f51Jn4IGbpyXZl1Zp+WFEvAG9GKYNLVP6DdGLeht0CTJcRa09sVeuX7dam+YK+AAmzNJtkP7B2JMUmoQIYjueSpZ1EZN8WsBHiLQFZjkZ/lH7ONa0LJAJYtSdmhk6Q3y6kll5eU5URIgo7EjICaalGd9tWA327QmlQHDpNQjxZTjyP2wr3LaApp1bsR324NEwa9aBcJlhqlnYPPL3DjIwKHBpb1xPIyutJiCX+R/NEges/cmoBr6cgd0lwlFxKOYB0PTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvXMd35mMwlv/J52YF01f2VhCLgMREKumTvMrS46KTo=;
 b=I+AlJqiuqPxmxJU0gI8OHktc+/dX80SJ/lM0ZSUzqXRNbjwcP7zh0b8go+n0psDCnT2BOhu+KrTLeNjk4zw3sXdkpjWdHvv0qEGCZkhkxd2PFERt9tw+xHu89tRmpYBaQXuYnCK0XuXpRQyBQklq0A+RAZVQIz/JcBF0MfyQ0KUZpEx5sl8QyTelWnq/F1zcxKvPGd5FWuu036PviVL6/s1LY5HCNGMAFOUP/eR3mP3xnry1BYAFbbGf/AXltcdcF6EPnbh5hsTCmaLs6SrpI7t7lOOxB5vzmFmhvpNblCxzypvzbeASIOyf1r11cYPX/LK9zk6hOCtmb+wfOL394Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvXMd35mMwlv/J52YF01f2VhCLgMREKumTvMrS46KTo=;
 b=RF6S6KrkLe2Ksh0ouU/aua04VzatfYsCmhXjFfJsS6H1VuxqpNI7RArAJZt4PZWwjS5mlZnYtN+PIUsNjWo56WEMRxKxRZPJmKTLy3YUz2Ss6sdN6AJCRusQwxD8ticybu4YD0HQe0GnOemE5CSIqkMQsJpzxEMEizVfknFnb6w=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6825.namprd21.prod.outlook.com (2603:10b6:806:4a9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.5; Thu, 20 Aug
 2026 01:38:18 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Thu, 20 Aug 2026
 01:38:18 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Randy Tice <rtice@cisco.com>, Thomas
 Monjalon <thomas@monjalon.net>, Jianfeng Tan <jianfeng.tan@intel.com>, Jeff
 Guo <jia.guo@intel.com>
Subject: RE: [EXTERNAL] [PATCH v5 1/4] eal/linux: filter uevent Netlink in
 kernel
Thread-Topic: [EXTERNAL] [PATCH v5 1/4] eal/linux: filter uevent Netlink in
 kernel
Thread-Index: AQHdMA50+wOzHqdIbUK9Li0Ev/DtAbamKPRQ
Date: Thu, 20 Aug 2026 01:38:17 +0000
Message-ID: <SA1PR21MB66839FA8D69C7769E6BD64E0CEA42@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260817201602.120526-1-rtice@cisco.com>
 <20260819191036.679330-1-stephen@networkplumber.org>
 <20260819191036.679330-2-stephen@networkplumber.org>
In-Reply-To: <20260819191036.679330-2-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9a516598-d965-4538-995b-638e699148ba;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-20T01:38:00Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6825:EE_
x-ms-office365-filtering-correlation-id: 8f74eb6e-609e-4770-73aa-08defe5bb5dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|38070700021|11063799006|56012099006|6133799003|10067099003|7146999003|4143699003;
x-microsoft-antispam-message-info: GADZWJdz7dIMTtmw6uzN/SC5e3joA2ryQB5Mgk3vA4a7TAnrLQljCzTbCpUrfaKbZf/s2osBVk99XT2yWJLkt1+iV6PdD9R7Y0u21HsFxSL9RmJr+virs8Av5rF1D/4ROcqdrqpzAatz0sYOh/rZYj1JVZsM/ZbtZk9LLE357kUBuL2lG05mYdF+ije40LntkOag84y8jKRU0Tn3yAIvgcYx3TwZutz6N8fM6GgzixCSwcfzCnSscbUnggSUMKL1WUtBQneCPm6zWBmcVJ9hisyiGHWDmYYUS5f76rZvVbhRbUri7Pu+jJpnucJ/yrOBW9pKqsMpslqVKytOP9UlGQCTFK2aQYSUYZhzzaZvohDztJwoJadAMefN/dc3lxLvPhVsHXUKeWVDzKmZ3T1JFoj04U1ARfyaQGjAOdmq4B7szNJuL/feNcf2E5YTvz+XQk8+J5Smq6Tcg7BZcP23z1KZLROyu+fiDVnU6SQ/5BMXO/SYCsJQbw2+3GNA6tlNZaQ8G9qESTjWGGSeDoBGLRomM2PtVu+bZK1o2Vi6xYEL2BS2X0+Sc1rhz1Hlit1IOc8X2+luSgca5eCWOAqTea+/dJ5z3Bk5Or60dh5MFzKLb+FuQ2GEzGZYrJbJ4nde4mDAvy9WjvJNpAQ+hS0LG5QTCsdGic1I49grUdYI5E8+IgMleif9BAqumG9Nr2Guk96cGoOvlUz9BaBiUU22QSyCDgE8zAep6cui5qr/tiQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(6133799003)(10067099003)(7146999003)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wrCMAye13jym4GbiQw/uILrDM8NCQcg3R96+3kGSUa6GoZnrLDGTZ3kTXRod?=
 =?us-ascii?Q?Ea1/j3oTqDP7IZtHtMuAXGiUOpBJ4g8gGeU171kXqravYQLOl5hN8ozSXElX?=
 =?us-ascii?Q?guD2ysFiQ9nXJ/AEh3wgKTxShQALfAxae50iVKOCze9ean055+sCCQU4SuKh?=
 =?us-ascii?Q?2gRJhqh/pfICak1spSJFNyffyInYxctDPhgO68F4wAN60P1ohNdn5RjSePVM?=
 =?us-ascii?Q?IFS9k3k0RIXCvrcq3Oseie3vA5ooQmVY3URAy1+DCbMe1JK5X3LuhxTfIHmr?=
 =?us-ascii?Q?WVvXcPLVevZVwMxcwCozcOOHQriNxK3DRmpQhwAf/zVY0nr9xhVyi07mX2vy?=
 =?us-ascii?Q?hpAA3d2cm8JXGg+CbQMa/NJb6nzdM9EcPjD9ddLh3S2YXoMZF6fTIGRdS7Wk?=
 =?us-ascii?Q?uQMf2YM5cT0AqA0J3sZ/6shZwaR2DxgrCYGSMiiMmJSmyXJw+vjb1Kw7woNV?=
 =?us-ascii?Q?VICFFo/X4B6fEnbWWLLW3cVrCWXHQg7ZMCLcCf82yZYKM7my61IRQPuSzkAi?=
 =?us-ascii?Q?jVU9cEqbysvKxKBmZopbwGZMTRbUpLFI5vzC6nj/d40MQFqUxHnV5RFmiqHg?=
 =?us-ascii?Q?9YI7hMLkKWD0yx9oPp2HP7aWkLlH5ireX91RFKntw8Z7V1QXz2tzh/fZYm+a?=
 =?us-ascii?Q?rP5LDKFh0oHfhvSanPVM3HqE8CY57BDBwYBbGrfdOe4mWtauSTwm8jdlfEG/?=
 =?us-ascii?Q?KF1+WzUGSnLcwzyqWL5U3WFSV70K4Tjxo+aC/DOiA4dLiaf1e7Mr//GYUXRz?=
 =?us-ascii?Q?hrH9uCEQvbbqshzK//wEFxsY16hBn+pKh6A54Kk74UiAse5Q7CLXMVl0zjnD?=
 =?us-ascii?Q?8FlNjKopMkdsnrfSOLFrsaCQ+tac9hpcvqnludLLTtjDxg8SPAPAUPn7ksxo?=
 =?us-ascii?Q?7G+7jHPtlxwPBZdxIAzM8kXBUDmk+VQy6Z/T5WCZwdSGYBh3g+v5A1o6Hkp6?=
 =?us-ascii?Q?uFGv8AU0Ma3FuYicCrGG3SFhRFRc0/TC4Ch8pr/z0KejYMToEn5gUTTs4Ikr?=
 =?us-ascii?Q?rjtZDyw8y9mZQU9QuO4rT7tDPZrek8ZQNRRSVpzxZ+0XjJWQYAkN78Bl1QMo?=
 =?us-ascii?Q?znPT8lKdvE87i1haAAagpALRRGJE0vNXOvXyYuGnUdHb9V5sGc0ry/tdu6Tf?=
 =?us-ascii?Q?AxBNAiYvwnuXvBDfEDjQ3DxlJu7gJl+qjpyUBLqHbcEEga6Lh3YByyFd/USS?=
 =?us-ascii?Q?smjiHQrb+mhwgbw1Er3ey4b3P8pLYlWCFDfwVH9Cnf9qAb68hcPGUu6Ir8zj?=
 =?us-ascii?Q?NS3CNfLwph6o6oIZHhJy9EpB1PCJASQGyU0TH7M4NMsjMx2LL5wEc97rfJBo?=
 =?us-ascii?Q?U/Xn1rApJyXpbpuImKAYWYxL4YqvYCcHzmBBq6TSemznxrh9KV3Pq2/uPXvN?=
 =?us-ascii?Q?PW7/TAnRfHkuONugc2FSGWbifj3oVFIUOgd9xy7Vw1cDfMZm5js8d8JBqUPn?=
 =?us-ascii?Q?Xaw2BjSvuimwue4PTIU127bCOWEUwbxG/tPndK4agLE2xGzYS9Gpd6V98uVd?=
 =?us-ascii?Q?yo2GhfEfOi0ramEKvN8OsF2VVkiOGIdfM989kQx9MSinmUC7Lo7h8oN6b8bG?=
 =?us-ascii?Q?p18o3TSu/76Sp3yQ4i43OgfP8aFKFPKEVFMvknl4mpO36pGDOTv3k5QNziVl?=
 =?us-ascii?Q?8lmuHp4dAkq0M9Ba/JBF8KkH373y+QFlWNut9XzV/4+PmY2uq4dGBG4z8rxV?=
 =?us-ascii?Q?9ztbZnrj63S3C/HSyCCavIsTrI1hFjZubaaxdEdRNw73E+o3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f74eb6e-609e-4770-73aa-08defe5bb5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 01:38:17.9815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQ86Z3yvm6A1UWIRWuuuQ+ugsTJ8bm2fbv7OAtaG2CGLp6zK4O+p56TQKyTO7/TfJP0qPQ+DtEl/DQ8hUS7+nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6825
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

> The EAL uevent only needs/wants messages from the kernel.
> Better to let kernel side do the filtering to avoid any overrun issues in=
 DPDK
> interrupt thread.
>=20
> There is no exposed API definition here. The convention is kernel is 1 an=
d
> libudev uses 2.
>=20
> Since kernel is now filtering can remove step in uevent parsing.
>=20
> Fixes: 0d0f478d0483 ("eal/linux: add uevent parse and process")
> Cc: stable@dpdk.org
>=20
> Reported-by: Randy Tice <rtice@cisco.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>




> ---
>  .mailmap                | 1 +
>  lib/eal/linux/eal_dev.c | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index fcb3d1bb3f..9b7713b6df 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1380,6 +1380,7 @@ Ralf Hoffmann <ralf.hoffmann@allegro-
> packets.com>
>  Rami Rosen <ramirose@gmail.com> <rami.rosen@intel.com>  Rami Rosen
> <ramirose@gmail.com> <roszenrami@gmail.com>  Randy Schacher
> <stuart.schacher@broadcom.com>
> +Randy Tice <rtice@cisco.com>
>  Rani Sharoni <ranish@nvidia.com>
>  Ranjit Menon <ranjit.menon@intel.com>
>  Rasesh Mody <rmody@marvell.com> <rasesh.mody@cavium.com> diff --git
> a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c index
> ec408649d0..666967667f 100644
> --- a/lib/eal/linux/eal_dev.c
> +++ b/lib/eal/linux/eal_dev.c
> @@ -29,6 +29,9 @@ static bool hotplug_handle;  #define EAL_UEV_MSG_LEN
> 4096  #define EAL_UEV_MSG_ELEM_LEN 128
>=20
> +/* Listen only to messages from kernel (not libudev) */ #define
> +EAL_UEV_GROUP_KERNEL 1
> +
>  /*
>   * spinlock for device hot-unplug failure handling. If it try to access =
bus or
>   * device, such as handle sigbus on bus or handle memory failure for dev=
ice
> @@ -116,7 +119,7 @@ dev_uev_socket_fd_create(void)
>  	memset(&addr, 0, sizeof(addr));
>  	addr.nl_family =3D AF_NETLINK;
>  	addr.nl_pid =3D 0;
> -	addr.nl_groups =3D 0xffffffff;
> +	addr.nl_groups =3D EAL_UEV_GROUP_KERNEL;
>=20
>  	ret =3D bind(fd, (struct sockaddr *) &addr, sizeof(addr));
>  	if (ret < 0) {
> @@ -164,9 +167,6 @@ dev_uev_parse(const char *buf, struct rte_dev_event
> *event, int length)
>  		 * check device uevent from kernel side, no need to check
>  		 * uevent from udev.
>  		 */
> -		if (!strncmp(buf, "libudev", 7)) {
> -			return -1;
> -		}
>  		if (!strncmp(buf, "ACTION=3D", 7)) {
>  			buf +=3D 7;
>  			i +=3D 7;
> --
> 2.53.0

